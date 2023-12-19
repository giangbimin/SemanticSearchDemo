# LLM and Semantic Search

## Table of content

- Introduction
- LLM
- OPEN-Ai
- Demo
- Q&A

## Introduction

- Freelance Web developer
- soccer, manga, cat
- <https://github.com/giangbimin>

## LLM

### definition

- A large language model (LLM) is a type of artificial intelligence (AI) algorithm that uses deep learning techniques and massively large data sets to understand, summarize, generate and predict new content. The term generative AI also is closely connected with LLMs, which are, in fact, a type of generative AI that has been specifically architected to help generate text-based content.

### Example

- LLM predict the next word will appear in a sentence of a bounce of context user have proved

```
who is Tom?

1. a cat
2. an Actor

with context is cartoon
answer is: Tom is a Cat

with context is film
answer is: Tom is a Cat

```

### Keywords

- Model Size & Parameters: Number of weights in the model's neural network, it bigger => more Smart + more Accuracy

- Tokenizers: all unique characters (including blanks and punctuation marks) are treated as an initial set of n-grams.

- Inference: LLMs use a variety of techniques to make inferences based on the input they are given. One of the key techniques used by these models is known as attention. Attention allows the model to focus on specific parts of the input text when generating a response. This can help the model to better understand the context and generate more accurate responses.

- Retrieval Augmented Generation (RAG): Aims to improve prediction quality by using an external datastore at inference time to build a richer prompt that includes some combination of context, history, and recent/relevant knowledge (RAG LLMs

### User Cases

- Sentiment analysis
- Customer service
- Chatbots
- Online search

### Advantages and Limitations

- Productivity
- Accuracy
- Compile with your data
- Sensitive data leak

## Open-Ai

- OpenAI is an AI research and deployment company. Our mission is to ensure that artificial general intelligence benefits all of humanity.

### Products

- ChatGPT
- Dall-e

### Configs

- Temperature: serve as a control mechanism. Higher temperatures introduce randomness, which is beneficial for creative tasks
- Token, MaxToken: Depending on the model used, requests can use up to 4097 tokens shared between prompt and completion.
- Top p, Top k => Query Strategy: Euclidean Distance, Cosine Similarity
- Penalty is a flat reduction if the token has appeared at least once before

### API-Endpoint

```
  MODEL = "text-embedding-ada-002"
  OPENAI_API = "https://api.openai.com/v1/embeddings"
```

### Consider

- Cost & Policy

### Replace it with you own model

- Quantization model
- Local Run
- Policy
- VRAM/RAM
- Limit data
- Open source
- Free

### Semantic Search

### Semantic VS Full taxt

- Understanding of Queries
- Matching Techniques
- Flexibility & Precision
- Applications & use cases

### Steps

- Chunks
- Save Embedding Vectors
- Calculate input
- Find neighbors
- Return results

### Demo

```

```
