package com.mytoeic;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
public class MyToeicApplication {
    public static void main(String[] args) {
        if(java.util.Arrays.asList(args).contains("--migrate-only")) {
            com.mytoeic.config.MigrationCommand.run(System.getenv());
            return;
        }
        SpringApplication.run(MyToeicApplication.class, args);
    }
}
