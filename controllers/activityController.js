const cloudinary = require('cloudinary').v2;

cloudinary.config({
    cloud_name: process.env.CLOUDINARY_CLOUD_NAME,
    api_key: process.env.CLOUDINARY_API_KEY,
    api_secret: process.env.CLOUDINARY_API_SECRET,
});

exports.addActivity = async (req, res) => {
    try {
        const { childId } = req.params;
        const { name, description, date, duration, location } = req.body;

        // Vérifier que le relative a accès au child
        const relativeId = req.user.id;
        const child = await User.findOne({ _id: childId, relativeId });
        if (!child) {
            return res.status(403).json({ message: "Accès refusé." });
        }

        // Upload de l'image sur Cloudinary
        let cloudinaryId = null;
        if (req.file) {
            const result = await cloudinary.uploader.upload(req.file.path);
            cloudinaryId = result.public_id;
        }

        // Créer l'activité
        const activity = new Activity({
            userId: childId,
            name,
            description,
            date,
            duration,
            location,
            cloudinaryId,
        });

        await activity.save();
        res.status(201).json(activity);
    } catch (error) {
        res.status(500).json({ message: "Erreur serveur.", error });
    }
}
