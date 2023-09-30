import 'dart:convert';

import 'package:astrolex/app/services.dart';
import 'package:astrolex/features/search/models/assistant_message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import 'package:openalex/models/models.dart';
import 'package:openalex/openalex.dart';

@Singleton()
class SearchService {
  ValueNotifier<String?> searchTerm = ValueNotifier(null);

  ValueNotifier<String?> researchId = ValueNotifier(null);

  void setResearchId(String val) {
    researchId.value = val;
  }

  ValueNotifier<String?> systemMessage = ValueNotifier(null);

  void setSystemMessage(String? val) {
    systemMessage.value = val;
  }

  ValueNotifier<bool> loading = ValueNotifier(false);

  void setLoading(bool val, {String? message}) {
    loading.value = val;

    if (val == false) {
      systemMessage.value = null;
    } else {
      if (message != null) {
        systemMessage.value = message;
      }
    }
  }

  void clearAll() {
    searchTerm.value = null;
    endpoint.value = 'concept';
    concept = null;
    authors = {};
    encounteredNgrams = [];
    viewedWorks = [];
    viewedConcepts = [];
  }

  void setSearchTerm(String? val) {
    searchTerm.value = val;
  }

  ValueNotifier<String?> endpoint = ValueNotifier('work');

  void setEndpoint(String? val) {
    endpoint.value = val;
  }

  /// Author ID and citation count
  List<Concept> viewedConcepts = [];
  Map<String, int> authors = {};
  List<String> encounteredNgrams = [];
  List<Work> viewedWorks = [];

  void addWork(Work work) {
    if (!viewedWorks.where((element) => element.displayName == work.displayName).isNotEmpty) {
      viewedWorks.insert(0, work);
    }
  }

  void addConcept(Concept concept) {
    if (!viewedConcepts.where((element) => element.displayName == concept.displayName).isNotEmpty) {
      viewedConcepts.add(concept);
    }
  }

  void addNgram(String ngram) {
    if (!encounteredNgrams.contains(ngram)) {
      encounteredNgrams.add(ngram);
    }
  }

  void addAuthor(String author, int citation) {
    Map<String, int> newAuthors = authors;

    if (newAuthors.containsKey(author)) {
      newAuthors[author] = newAuthors[author]! + citation;
      authors = newAuthors;
      return;
    }

    newAuthors[author] = citation;
    authors = newAuthors;
  }

  Concept? concept;

  void setConcept(Concept? val) {
    concept = val;
  }

  String aggregateWorkData(List<Work> viewedWorks) {
    String result = '';

    if (viewedWorks.isNotEmpty) {
      result += 'Viewed Works:\n';
      for (var work in viewedWorks) {
        result += '- Title: ${work.title}\n';
        if (work.abstractInvertedIndex != null && work.abstractInvertedIndex!.isNotEmpty) {
          String abstractText = work.abstractInvertedIndex!.entries.map((e) => e.key).toList().join(' ');
          result += '  Abstract: $abstractText\n';
        }
      }
      result += '\n';
    }

    return result;
  }

  String? researchGoal = 'Find gaps in available research';

  void setResearchGoal(String? val) {
    researchGoal = val;
  }

  Future<Map<String, dynamic>> callPaLMApi(String promptText) async {
    debugPrint('Prompt text: ' + promptText);
    try {
      const String palmApiKey = String.fromEnvironment('PALM_API_KEY');
      final Uri url = Uri.parse('https://generativelanguage.googleapis.com/v1beta2/models/chat-bison-001:generateMessage?key=$palmApiKey');

      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "prompt": {
            "context": "Find gaps in available research",
            "messages": [
              {
                "content": promptText,
              }
            ],
          },
          "temperature": 1.0,
          "candidate_count": 1,
          "topP": 0.8,
          "topK": 10,
        }),
      );

      debugPrint('response: ' + response.body.toString());
      debugPrint('response code: ' + response.statusCode.toString());

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to call PalM API');
      }
    } catch (e) {
      debugPrint('Error: ' + e.toString());
      throw Exception('Failed to call PalM API');
    }
  }

  Future<String> getQuestion() async {
    String promptText = "Based on the available data, what single question has not been asked?: \n\n"
        "${aggregateWorkData(viewedWorks)} \n"
        "What search terms can help us answer this question?";

    Map<String, dynamic> apiResponse = await callPaLMApi(promptText);

    debugPrint('API response: ' + apiResponse.toString());
    String actionResponse = apiResponse['candidates'].first['content']; // assuming the API sends this key

    return actionResponse.replaceAll('```json', '').replaceAll('```', '');
  }

  Future<String> getSearchTerm(String message) async {
    debugPrint('Search Term prompt text: ' + message);
    try {
      const String palmApiKey = String.fromEnvironment('PALM_API_KEY');
      final Uri url = Uri.parse('https://generativelanguage.googleapis.com/v1beta2/models/text-bison-001:generateText?key=$palmApiKey');

      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "prompt": {
            "text": "What is the next term we should search for based on this analysis: $message\n\n"
                "Respond in the form of a json object:"
                "{searchTerm: term}\n"
          },
          "temperature": 1.0,
          "candidate_count": 1,
          "topP": 0.8,
          "topK": 10,
        }),
      );

      debugPrint('Search response: ' + response.body.toString());
      debugPrint('search response code: ' + response.statusCode.toString());

      if (response.statusCode == 200) {
        return jsonDecode(jsonDecode(response.body)['candidates'].first['output'].replaceAll('```json', '').replaceAll('```', ''))['searchTerm'];
      } else {
        throw Exception('Failed to call PalM API');
      }
    } catch (e) {
      debugPrint('Error: ' + e.toString());
      throw Exception('Failed to call PalM API');
    }
  }

  Future<AssistantMessage> getWorkSummary(String message) async {
    try {
      const String palmApiKey = String.fromEnvironment('PALM_API_KEY');
      final Uri url = Uri.parse('https://generativelanguage.googleapis.com/v1beta2/models/text-bison-001:generateText?key=$palmApiKey');

      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "prompt": {
            "text": "Summarize the existing works and provide follow up questions and search terms: $message\n\n"
                "Respond in the form of a json object:"
                "{summary: summary of provided works,"
                "searchTerms: [one, two, three],"
                "questions: [one, two, three]}\n"
          },
          "temperature": 1.0,
          "candidate_count": 1,
          "topP": 0.8,
          "topK": 10,
        }),
      );

      debugPrint('Search response: ' + response.body.toString());
      debugPrint('search response code: ' + response.statusCode.toString());

      if (response.statusCode == 200) {
        AssistantMessage message = AssistantMessage.fromJson(jsonDecode(jsonDecode(response.body)['candidates'].first['output'].replaceAll('```json', '').replaceAll('```', '')));
        return message;
      } else {
        throw Exception('Failed to call PalM API');
      }
    } catch (e) {
      debugPrint('Error: ' + e.toString());
      throw Exception('Failed to call PalM API');
    }
  }

  Future<AssistantMessage> getBasicResponse(String message) async {
    try {
      const String palmApiKey = String.fromEnvironment('PALM_API_KEY');
      final Uri url = Uri.parse('https://generativelanguage.googleapis.com/v1beta2/models/text-bison-001:generateText?key=$palmApiKey');

      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "prompt": {
            "text": "$message - Provide follow up questions and search terms: \n\n"
                "Respond in the form of a json object:"
                "{summary: summary of provided works,"
                "searchTerms: [one, two, three],"
                "questions: [one, two, three]}\n"
          },
          "temperature": 1.0,
          "candidate_count": 1,
          "topP": 0.8,
          "topK": 10,
        }),
      );

      debugPrint('Search response: ' + response.body.toString());
      debugPrint('search response code: ' + response.statusCode.toString());

      if (response.statusCode == 200) {
        AssistantMessage message = AssistantMessage.fromJson(jsonDecode(jsonDecode(response.body)['candidates'].first['output'].replaceAll('```json', '').replaceAll('```', '')));
        return message;
      } else {
        throw Exception('Failed to call PalM API');
      }
    } catch (e) {
      debugPrint('Error: ' + e.toString());
      throw Exception('Failed to call PalM API');
    }
  }

  /// 1. Search OpenAlex works for search term
  /// 2. Summarize works from abstracts
  /// 3. Get suggested search terms and follow up questions
  Future<void> searchTermAction(String searchTerm) async {
    setLoading(true, message: 'Searching OpenAlex...');
    try {
      // 1. Query OpenAlex
      MetaWorks? works = await queryOpenAlex(searchTerm);

      if (works != null) {
        FirebaseFirestore.instance.collection('users').doc(authenticationService.id).collection('research').doc(researchId.value).collection('messages').add(
              AssistantMessage(
                works: works.works,
                summary: 'Found ${works.works?.length ?? 0} works related to $searchTerm',
                type: 'openalex',
                date: DateTime.now(),
              ).toJson(),
            );

        /*if (works.works != null && works.works!.isNotEmpty) {
          AssistantMessage workSummary = await getWorkSummary(aggregateWorkData(works.works!));

          workSummary.date = DateTime.now();
          workSummary.type = 'ai';

          FirebaseFirestore.instance.collection('users').doc(authenticationService.id).collection('research').doc(researchId.value).collection('messages').add(
                workSummary.toJson(),
              );
        }*/
      }
    } catch (e) {
      debugPrint('Error: $e');
    } finally {
      setLoading(false);
    }
  }

  Future<void> questionAction(String question) async {
    setLoading(true, message: 'Generating Response...');
    try {
      AssistantMessage message = await getBasicResponse(question);

      message.date = DateTime.now();
      message.type = 'ai';

      FirebaseFirestore.instance.collection('users').doc(authenticationService.id).collection('research').doc(researchId.value).collection('messages').add(
            message.toJson(),
          );
    } catch (e) {
      debugPrint('Error: $e');
    } finally {
      setLoading(false);
    }
  }


  Future<void> summarizeAction(Work work) async {
    setLoading(true, message: 'Summarizing Abstract...');
    try {
      AssistantMessage message = await getBasicResponse('Summarize the following: ${work.abstract}');

      message.works = [work];
      message.date = DateTime.now();
      message.type = 'ai';

      FirebaseFirestore.instance.collection('users').doc(authenticationService.id).collection('research').doc(researchId.value).collection('messages').add(
        message.toJson(),
      );
    } catch (e) {
      debugPrint('Error: $e');
    } finally {
      setLoading(false);
    }
  }

  Future<void> relatedWorkAction(Work work) async {
    setLoading(true, message: 'Loading Related Works...');
    try {
      MetaWorks? relatedWorks = await OpenAlex().getWorksById(ids: work.relatedWorks ?? [], perPage: 3);
      MetaWorks? referencedWorks = await OpenAlex().getWorksById(ids: work.referencedWorks ?? [], perPage: 3);

      List<Work> allWorks = [];
      if (relatedWorks != null && relatedWorks.works != null) {
        allWorks.addAll(relatedWorks.works!);
      }

      if (referencedWorks != null && referencedWorks.works != null) {
        allWorks.addAll(referencedWorks.works!);
      }

      if (allWorks.isNotEmpty) {
        FirebaseFirestore.instance.collection('users').doc(authenticationService.id).collection('research').doc(researchId.value).collection('messages').add(
          AssistantMessage(
            works: allWorks,
            summary: 'Found ${allWorks.length ?? 0} related works',
            type: 'openalex',
            date: DateTime.now(),
          ).toJson(),
        );

        /*if (allWorks.isNotEmpty) {
          AssistantMessage workSummary = await getWorkSummary(aggregateWorkData(allWorks));

          workSummary.date = DateTime.now();
          workSummary.type = 'ai';

          FirebaseFirestore.instance.collection('users').doc(authenticationService.id).collection('research').doc(researchId.value).collection('messages').add(
            workSummary.toJson(),
          );
        }*/
      }
    } catch (e) {
      debugPrint('Error: $e');
    } finally {
      setLoading(false);
    }
  }

  Future<void> relatedConceptsAction(String searchTerm) async {
    setLoading(true, message: 'Loading Related Concepts...');
    try {
      MetaConcepts? relatedConcepts = await OpenAlex().getConcepts(query: searchTerm, perPage: 10);

      if (relatedConcepts.concepts != null && relatedConcepts.concepts!.isNotEmpty) {
        FirebaseFirestore.instance.collection('users').doc(authenticationService.id).collection('research').doc(researchId.value).collection('messages').add(
          AssistantMessage(
            concepts: relatedConcepts.concepts,
            summary: 'Found ${relatedConcepts.concepts!.length} related concepts',
            type: 'openalex',
            date: DateTime.now(),
          ).toJson(),
        );

      }
    } catch (e) {
      debugPrint('Error: $e');
    } finally {
      setLoading(false);
    }
  }

  Future<MetaWorks?> queryOpenAlex(String searchTerm) async {
    MetaWorks? works = await OpenAlex().getWorks(query: searchTerm, perPage: 5);

    debugPrint('works: ${works?.works ?? ''}');
    if (works?.works != null && works!.works!.isNotEmpty) {
      if (works.works!.length > 1) {
        works.works?.sublist(0, 1).forEach((element) {
          searchService.addWork(element);
        });
      } else {
        works.works?.forEach((element) {
          searchService.addWork(element);
        });
      }
    }

    return works;
  }
}
