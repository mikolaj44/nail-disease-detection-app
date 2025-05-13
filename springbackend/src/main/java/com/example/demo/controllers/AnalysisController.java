package com.example.demo.controllers;

import org.springframework.ai.chat.client.ChatClient;
import org.springframework.ai.chat.messages.UserMessage;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

/** Controls api calls to users wanting to analyse images, testes them against requirements */
@RestController
@RequestMapping("/api/analysis")
public class AnalysisController {
    private final ChatClient chatClient;
    private final RequirementController requirementController;

    // TODO: THESE ARE TEMPORARY, CHANGE LATER
    private final String testURL = "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSFUAfyVe3Easiycyh3isP9wDQTYuSmGPsPQvLIJdEYvQ_DsFq5Ez2Nh_QjiS3oZ3B8ZPfK9cZQyIStmQMV1lDPLw";
    private final String prompt = "what is this?";

    public AnalysisController(ChatClient chatClient){
        this.chatClient = chatClient;
        this.requirementController = new RequirementController();
    }

    /** Default api message */
    @GetMapping()
    public String getPing(){
        return "Nail image analysis is working, analyse image on api/analysis/image, check requirements on api/analysis/verify";
    }

    /** Performs a GET request from the image recognition model */
    @GetMapping("/image")
    public String getImageRecognitionResult(@RequestParam("file") MultipartFile file) {
        if(file.isEmpty()){
            return "empty file"; // TODO: change these messages (more verbose or something else):
        }

        if(!requirementController.isValid(file)){
            return "file is invalid";
        }

        // TODO:
        // check bad lighting, maybe other factors
        // perform preprocessing

        try {
            //List<Media> mediaList = new ArrayList<>(1);
            //mediaList.add(new Media(new MimeType(file.getContentType()), new ClassPathResource()));
            //Base64.getEncoder().encodeToString(file.getBytes())
            return chatClient.prompt().messages(new UserMessage(testURL)).call().content();
        }
        catch(Exception e){
            return e.toString(); // TODO: change this
        }
    }

}