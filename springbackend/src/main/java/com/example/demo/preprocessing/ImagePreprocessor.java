package com.example.demo.preprocessing;

import org.springframework.ai.content.Media;

public abstract class ImagePreprocessor {
    /** Presumably runs a Python script on an image that preprocesses it */
    abstract void preprocess(Media imageMedia);
}