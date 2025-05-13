package com.example.demo.controllers;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

/** Controls the requirements: file size, file type etc. */
@RestController
@RequestMapping("/api/analysis/verify")
public class RequirementController {
    @Value("${api.req.max-file-size-mb}")
    private int maxFileSizeMB;

    @Value("${api.req.valid-file-types}")
    private String[] validFileTypes;

    /** These two methods will be used by the frontend for example to verify before sending to main method */

    @GetMapping("/maxsizemb")
    public int getMaxFileSizeMB(){
        return maxFileSizeMB;
    }

    @GetMapping("/validtypes")
    public String[] getValidFileTypes(){
        return validFileTypes;
    }

    /** Checks the requirements */
    @GetMapping("/image")
    public boolean isValid(@RequestParam("file") MultipartFile file){
        // TODO: Maybe check rate limit?

        return validFileSize(file) && validFileType(file);
    }

    private boolean validFileSize(MultipartFile file){
        return file.getSize() <= maxFileSizeMB;
    }

    private boolean validFileType(MultipartFile file){
        String fileName = file.getOriginalFilename();

        if (fileName == null || !fileName.contains(".")) {
            return false;
        }

        String fileType = fileName.substring(fileName.lastIndexOf('.') + 1).toLowerCase();

        for(String type : validFileTypes){
            if(type.toLowerCase().equals(fileType)){
                return true;
            }
        }
        return false;
    }
}