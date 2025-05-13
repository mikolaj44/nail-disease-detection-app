package com.example.demo.entities;

public class ImageRecognitionResult {
    private String resultText;
    private double certainty;

    public ImageRecognitionResult(String resultText, double certainty) {
        this.resultText = resultText;
        this.certainty = certainty;
    }

    public ImageRecognitionResult(String resultText) {
        this.resultText = resultText;
        this.certainty = 1;
    }

    public String getResultText() {
        return resultText;
    }

    public void setResultText(String resultText) {
        this.resultText = resultText;
    }

    public double getCertainty() {
        return certainty;
    }

    public void setCertainty(double certainty) {
        this.certainty = certainty;
    }
}
