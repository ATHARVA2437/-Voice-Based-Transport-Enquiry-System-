# Voice-Based Public Transport Enquiry System

A voice-enabled database application designed to make public transport information accessible, fast, and user-friendly. This project integrates voice commands with a relational database to allow users to fetch transport details such as schedules, routes, availability, and booking options hands-free.

---

## 🚀 Overview

In today’s fast-paced world, there's a growing need for hands-free, real-time access to transport information. This system allows users to query available buses, trains, or flights simply by speaking, and get instant, spoken and visual feedback. Designed with accessibility and ease-of-use in mind, the platform is useful for everyone — especially those with disabilities or on-the-go.

---

## 🎯 Objectives

- Enable real-time retrieval of transport data using voice commands.
- Eliminate the need for human-operated helpdesks.
- Provide admin control for route and schedule management.
- Enhance public transport systems with a smart digital interface.
- Improve accessibility for differently-abled users.

---

## 🛠️ Technologies Used

- **MySQL** – for structured and normalized database design
- **Python** – for back-end voice handling and logic
- **SpeechRecognition** – to convert voice input to text
- **pyttsx3** – for converting system responses into speech
- **Basic UI/CLI** – for displaying results alongside audio

---

## 🧩 Key Features

- 🎙️ Voice-to-text transport queries  
- 📢 Audio output of search results  
- 📍 Route and fare lookup  
- 🧾 Booking and cancellation via voice  
- 🛡️ Admin dashboard for managing data  
- 👤 User and admin login modes  
- ⏱️ 24x7 system availability  

---

## 🧠 Database Highlights

- Well-structured relational schema (normalized to 3NF)
- Use of primary & foreign keys for relationship mapping
- Stored procedures for booking/cancellation workflows
- Triggers for update logging
- Views for simplified query outputs
- Joins to fetch complex transport data across tables

---

## 🔄 Voice Interaction Flow

1. **User says**: “Show buses from Pune to Mumbai.”
2. **Speech is recognized**, converted to text.
3. **Query is generated**, executed on the MySQL database.
4. **Result is read aloud** via text-to-speech and shown on screen.
5. **Optional**: User may say “Book ticket…” to proceed with booking.

---

## 🌱 Future Scope

- Integration with real-time GPS or Google Maps
- Multi-language voice support
- OTP verification and email/SMS notifications
- Android/iOS mobile app interface
- Analytics dashboard for admins

---

## 👨‍💻 Team Members

- Vedant Ghodmare  
- Yash Soni  
- Atharva Rathi  
- Shrinit Jichkar  
- Vivek Ghosh  

---

## 📌 Conclusion

This project demonstrates how voice-based interfaces can be successfully combined with relational databases to enhance the user experience in public transport systems. The solution not only simplifies access but also showcases the practical application of DBMS concepts in real-world systems.

---

> “Accessibility is not a feature, it's a foundation.”

