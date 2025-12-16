import '../models/paper_item.dart';

/// PromptBERT 논문 더미 데이터
PaperItem getPromptBertPaper() {
  return PaperItem(
    title: "PromptBERT: Improving BERT Sentence Embeddings with Prompts",
    authors: "Ting Jiang, Jian Jiao, Shaohan Huang, Zihan Zhang, Deqing Wang, Fuzhen Zhuang, Furu Wei, Haizhen Huang, Denvy Deng, Qi Zhang",
    conference: "arXiv",
    year: 2022,
    arxivId: "http://arxiv.org/abs/2201.04337v2",
    publishedDate: "2022-01-12",
    summary: "본 논문 \"PromptBERT: 프롬프트를 이용한 BERT 문장 임베딩 개선\"은 기존 BERT 모델을 활용한 문장 임베딩 방식의 한계를 극복하고자 한다. 저자는 BERT 모델 자체의 정적인 토큰 임베딩 편향과 비효율적인 레이어 구조가 문장 임베딩 성능 저하의 주요 원인임을 분석하고, 이를 해결하기 위해 프롬프트 기반의 새로운 문장 임베딩 방법을 제시한다.",
    abstractText: "We propose PromptBERT, a novel contrastive learning method for learning better sentence representation. We firstly analyze the drawback of current sentence embedding from original BERT and find that it is mainly due to the static token embedding bias and ineffective BERT layers. Then we propose the first prompt-based sentence embeddings method and discuss two prompt representing methods and three prompt searching methods to make BERT achieve better sentence embeddings. Moreover, we propose a novel unsupervised training objective by the technology of template denoising, which substantially shortens the performance gap between the supervised and unsupervised settings. Extensive experiments show the effectiveness of our method. Compared to SimCSE, PromptBert achieves 2.29 and 2.58 points of improvement based on BERT and RoBERTa in the unsupervised setting.",
    
    equations: [
      FigureItem(
        imageUrl: "https://storage.googleapis.com/rsp_bucket/images/KakaoTalk_20251207_202529801.png",
        description: "제공된 수식은 PromptBERT 논문에서 unsupervised 학습 시 문장 임베딩의 품질을 평가하는 데 사용되는 지표와 관련이 있을 가능성이 높습니다. 특히, 이 수식은 문장 임베딩 간의 유사성을 측정하고, 전체 데이터셋에 대해 이 유사성을 평균내는 과정을 나타냅니다.\n\n구체적으로, M(s_i)와 M(s_j)는 각각 문장 s_i와 s_j를 PromptBERT 모델을 통해 얻은 문장 임베딩을 의미합니다. cos(M(s_i), M(s_j))는 이 두 임베딩 벡터 간의 코사인 유사도를 계산하여, 두 문장이 얼마나 의미적으로 유사한지를 나타냅니다.",
      ),
      FigureItem(
        imageUrl: "https://storage.googleapis.com/rsp_bucket/images/KakaoTalk_20251207_202554064.png",
        description: "이 수식은 PromptBERT 논문에서 제안하는 '템플릿 노이즈 제거'라는 새로운 비지도 학습 목표를 나타내는 손실 함수(Loss function)입니다. 핵심은 문장 표현(sentence embedding)을 더 잘 학습하기 위해 문장들을 서로 비교하고, 긍정적인 쌍(positive pair)은 가깝게, 부정적인 쌍(negative pair)은 멀리 떨어지도록 학습시키는 데 있습니다.",
      ),
    ],
    
    tables: [
      FigureItem(
        imageUrl: "https://storage.googleapis.com/rsp_bucket/images/94b972ba-4b20-46fa-aeef-8048aa6f1b71_page_3_table1.png",
        description: "이 표는 다양한 BERT 모델들의 문장 임베딩 품질을 코사인 유사도를 통해 간접적으로 비교하고 있습니다. 가장 눈에 띄는 점은 bert-base-uncased 모델의 코사인 유사도가 0.4445로, 다른 모델(bert-base-cased, roberta-base)에 비해 월등히 높다는 것입니다.",
      ),
      FigureItem(
        imageUrl: "https://storage.googleapis.com/rsp_bucket/images/d7f49017-bcde-47db-b0ea-fe8630f89da3_page_3_table2.png",
        description: "이 표는 사전 학습된 BERT 모델들의 문장 임베딩 품질을 평가하기 위해, 모델의 토큰 임베딩 방식에 따른 Spearman 상관 계수와 Sentence anisotropy(문장 이방성)를 비교하고 있습니다.",
      ),
    ],
    
    figures: [
      FigureItem(
        imageUrl: "https://storage.googleapis.com/rsp_bucket/images/b8aa2b1d-20d7-4e72-9a5a-6bf9353252ef_page_4_figure1.png",
        description: "제공된 그림은 2차원 공간에 점들이 분포된 형태를 보여주는 산점도(Scatter Plot)로 보입니다. 각 점은 문장 임베딩을 나타낼 가능성이 높으며, 색상은 문장의 종류나 속성을 나타내는 데 사용되었을 수 있습니다.",
      ),
      FigureItem(
        imageUrl: "https://storage.googleapis.com/rsp_bucket/images/ade632aa-5e84-4a34-837f-ebb97bbad05b_page_4_figure2.png",
        description: "제공된 그림은 BERT 및 RoBERTa 모델에서 나타나는 편향(bias)을 시각적으로 보여주는 2차원 산점도입니다. 각 점은 문장 임베딩을 나타내며, 점의 색깔은 특정 속성(빈도수, subword, 대소문자 구분 등)에 따라 다르게 표시됩니다.",
      ),
    ],
    
    podcastScript: """주제: BERT, 그냥 쓰면 바보라고? PromptBERT로 문장 임베딩 구원하기

[캐릭터 설정]
호스트 (남): 민수 - 진행자 
게스트 (여): 지은 - AI 연구원

[대본]

민수: 안녕하세요! 매일 아침 따끈따끈한 AI 논문을 씹고 뜯고 맛보는 시간, <AI Paper Dive>의 민수입니다.

지은: 네, 안녕하세요. 오늘도 흥미로운 논문을 들고 왔습니다. 자연어 처리(NLP) 하면 가장 먼저 떠오르는 모델이 뭐죠?

민수: 에이, 당연히 BERT죠! 요즘 LLM이 난리라지만, 그래도 근본은 BERT 아니겠습니까?

지은: 맞아요. 그런데 민수 님, 그 "근본"인 BERT를 가지고 문장 임베딩(Sentence Embedding)을 만들면, 성능이 얼마나 나올 것 같으세요?

민수: 워낙 똑똑한 놈이니까... 그냥 BERT 출력값 평균 내서 쓰면 엄청 잘 나오지 않을까요?

지은: 땡! 틀렸습니다. 놀랍게도 순정 BERT의 문장 임베딩 성능은, 2014년에 나온 GloVe(글로브) 보다도 안 좋습니다.

민수: 네? 아니, 딥러닝 시대의 황태자 BERT가 고전적인 단어 임베딩보다 못하다고요?

지은: 네, 사실 이 문제는 꽤 유명한데요. 오늘 소개할 논문 "PromptBERT"는 바로 이 문제의 원인을 아주 집요하게 파헤치고, 기가 막힌 해결책을 내놓은 연구입니다.

민수: 오, 흥미진진한데요. 도대체 왜 성능이 안 좋은 거죠?

지은: 저자들은 진짜 범인으로 '정적 토큰 임베딩의 편향(Bias)'을 지목했어요. BERT가 단어의 빈도수, 대소문자, 그리고 서브워드 정보에 너무 민감하게 반응해서, 문장의 진짜 의미보다는 그런 껍데기 정보에 휘둘린다는 거죠.

민수: 아, 그러니까 "문장의 뜻"이 비슷해서 뭉치는 게 아니라, 단순히 "자주 나오는 단어"가 들어있어서 뭉쳐버린다는 거군요?

지은: 정확합니다! 그래서 이 논문 제목이 PromptBERT잖아요. 이 문제를 '프롬프트'로 해결했다는 건데요. 기존처럼 문장 벡터를 평균 내는 방식은 버리고, 대신 BERT한테 템플릿을 씌워서 물어보는 방식을 택했어요.

민수: 아! GPT-3 이후로 유행하는 그 프롬프트 방식이네요?

지은: 그렇죠. 여기서 저자들은 "Template Denoising(템플릿 디노이징)"이라는 필살기를 하나 더 추가합니다. 템플릿이 주는 껍데기 정보는 날려버리고, 순수하게 문장의 의미만 남기겠다는 거예요.

민수: 와... 아이디어 진짜 좋다. 결과도 대박입니다. 당시에 가장 핫했던 SimCSE라는 모델보다, 비지도 학습 환경에서 약 2.5점이나 더 높은 성능을 기록했어요.

지은: 결론적으로 PromptBERT는 "문장 임베딩, 어렵게 생각하지 마라. BERT 본연의 능력을 프롬프트로 잘 꺼내 쓰기만 해도 최고가 될 수 있다"는 걸 증명한 논문이라고 할 수 있죠.

민수: 오늘 <AI Paper Dive>는 여기까지입니다. 유익하셨다면 구독과 좋아요 부탁드리고요!""",
  );
}

// 검색 더미 데이터는 제거됨 - API 연동으로 대체
