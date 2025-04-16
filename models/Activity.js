const activitySchema = new mongoose.Schema({
    location: { type: String }, // Coordonnées ou adresse
    cloudinaryId: { type: String }, // ID de l'image sur Cloudinary
});
