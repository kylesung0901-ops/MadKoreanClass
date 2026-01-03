import { initializeApp } from "firebase/app";
import { getAnalytics } from "firebase/analytics";

// Your web app's Firebase configuration
const firebaseConfig = {
    apiKey: "AIzaSyAGZlxZ_4QEH2PS5mtNdifbBFCUfbsLlOk",
    authDomain: "madkoreanclass.firebaseapp.com",
    projectId: "madkoreanclass",
    storageBucket: "madkoreanclass.firebasestorage.app",
    messagingSenderId: "795622295196",
    appId: "1:795622295196:web:f71a1bc45b028f60f00f59",
    measurementId: "G-RL7T9CZ9J4"
};

// Initialize Firebase
const app = initializeApp(firebaseConfig);
const analytics = getAnalytics(app);

console.log("Firebase initialized successfully");

// Expose to window for debugging or legacy script usage
window.firebaseApp = app;
window.firebaseAnalytics = analytics;
