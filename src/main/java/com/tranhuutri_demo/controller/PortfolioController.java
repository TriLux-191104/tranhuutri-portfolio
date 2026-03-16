package com.tranhuutri_demo.controller;

import com.tranhuutri_demo.entity.Contact;
import com.tranhuutri_demo.repository.ContactRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

@Controller
public class PortfolioController {

    @Autowired
    private ContactRepository contactRepository;

    @GetMapping("/")
    public String home(Model model) {
        model.addAttribute("contact", new Contact());
        return "index"; // Trả về file index.html
    }

    @PostMapping("/contact")
    public String submitContact(Contact contact, Model model) {
        contactRepository.save(contact); // Lưu xuống DB
        model.addAttribute("successMessage", "Cảm ơn bạn! Lời nhắn đã được gửi thành công.");
        model.addAttribute("contact", new Contact()); // Reset form
        return "index";
    }
}