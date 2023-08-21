package com.example.popbob;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.ComponentScan;

@SpringBootApplication
@ComponentScan( basePackages = { "com.example.controller", "com.example.model", "com.example.config", "com.example.domain", "com.example.dto", "com.example.service" } )
public class PopbobLogInApplication {

	public static void main(String[] args) {
		SpringApplication.run(PopbobLogInApplication.class, args);
	}
}