# LLM and Semantic Search

## Table of Contents

- [LLM and Semantic Search](#llm-and-semantic-search)
  - [Table of Contents](#table-of-contents)
  - [Introduction](#introduction)
  - [LLM](#llm)
    - [Definition](#definition)
    - [Example](#example)
    - [Keywords](#keywords)
    - [Use Cases](#use-cases)
    - [Advantages and Limitations](#advantages-and-limitations)
  - [OpenAI](#openai)
    - [Products](#products)
    - [Configs](#configs)
    - [API Endpoint](#api-endpoint)
    - [Considerations](#considerations)
    - [Replacing with Your Own Model](#replacing-with-your-own-model)
  - [Semantic Search](#semantic-search)
    - [Semantic vs Full Text](#semantic-vs-full-text)
    - [Semantic search steps](#semantic-search-steps)
  - [Demo](#demo)
  - [Q\&A](#qa)

## Introduction

- Freelance Web Developer with interests in soccer, manga, and cats.
- [GitHub Profile](https://github.com/giangbimin)

## LLM

### Definition

A Large Language Model (LLM) is an artificial intelligence algorithm using deep learning and massive datasets to understand, summarize, generate, and predict content. LLMs, a type of generative AI, specialize in generating text-based content.

### Example

LLMs predict the next word in a sentence based on user-provided context. For example:

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

- **Model Size & Parameters:** Larger sizes result in smarter and more accurate models.
- **Tokenizers:** Treats all unique characters as initial n-grams.
- **Inference:** Uses attention to focus on specific parts of input for better context understanding.
- **Retrieval Augmented Generation (RAG):** Improves prediction by using external data at inference time.

### Use Cases

- Sentiment analysis
- Customer service
- Chatbots
- Online search

### Advantages and Limitations

- **Productivity:** Increased productivity.
- **Accuracy:** Higher accuracy in predictions.
- **Compatibility:** Can be customized with your data.
- **Risk:** Potential for sensitive data leaks.

## OpenAI

OpenAI is an AI research and deployment company with a mission to ensure artificial general intelligence benefits humanity.

### Products

- ChatGPT
- DALL-E

### Configs

- **Temperature:** Controls randomness, beneficial for creative tasks.
- **Token, MaxToken:** Limits on token usage (up to 4097 tokens).
- **Top p, Top k:** Query strategies like Euclidean Distance and Cosine Similarity.
- **Penalty:** Reduces token occurrence if it has appeared before.

### API Endpoint

```
MODEL = "text-embedding-ada-002"
OPENAI_API = "https://api.openai.com/v1/embeddings"
```

### Considerations

- Cost & Policy

### Replacing with Your Own Model

- Quantization model
- Local Run
- Policy
- VRAM/RAM
- Limit data
- Open source
- Free

## Semantic Search

### Semantic vs Full Text

Differences between semantic and full-text search:

- Understanding of Queries
- Matching Techniques
- Flexibility & Precision
- Applications & use cases

### Semantic search steps

- Chunks
- Save Embedding Vectors
- Calculate input
- Find neighbors
- Return results

## Demo


- test openai embedding

```

Openai.fetch_embeddings(Article.first.body)

# example result
[0.02107661, 0.0058093295, 0.008067076, -0.010111338, 0.0035742256, -0.005000681, 0.004428158, -0.013067757, -0.0020749916]

```

- Reindex Article

```
  ReindexSearchJob.perform_async(Article.first.id)
```


- chunks

Chunk size is the maximum number of characters that a chunk can contain.
Chunk overlap is the number of characters that should overlap between two adjacent chunks.

```
  Langchain::Chunker::RecursiveText.new( "Langchain.rb wraps all supported LLMs in a unified interface allowing you to easily swap out and test out different models.", chunk_size: 100, chunk_overlap: 20, separators: ["\n\n"]).chunks

```


- Compare results

```
require "matrix"
first_vector = Chunk.first.embedding
second_vector = Langchain::LLM::OpenAI.new(api_key: ENV["OPENAI_API_KEY"]).embed(text: "Ai Technology").embedding
third_vector = Langchain::LLM::OpenAI.new(api_key: ENV["OPENAI_API_KEY"]).embed(text: "bioluminescence organisms").embedding
fourth_vector = Langchain::LLM::OpenAI.new(api_key: ENV["OPENAI_API_KEY"]).embed(text: "from glowing mushrooms in deep forests to the dazzling displays of bioluminescent plankton in the ocean").embedding
fifth_vector = Langchain::LLM::OpenAI.new(api_key: ENV["OPENAI_API_KEY"]).embed(text: "Revolutionizing Renewable Energy: Solar Innovations").embedding

Vector[*second_vector].inner_product(Vector[*first_vector])
Vector[*third_vector].inner_product(Vector[*first_vector])
Vector[*fourth_vector].inner_product(Vector[*first_vector])
```


## Q&A
If you have any questions, feel free to ask!
