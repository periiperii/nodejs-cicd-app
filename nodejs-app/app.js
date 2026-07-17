const express = require("express");

const app = express();

const PORT = process.env.PORT || 3000;

app.get("/", (req, res) => {
    res.send("🚀 CI/CD Pipeline Working!");
});

app.get("/health", (req, res) => {
    res.json({
        status: "healthy",
        service: "nodejs-app"
    });
});

app.listen(PORT, () => {
    console.log(`Server running on port ${PORT}`);
});