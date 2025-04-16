import React, { useState } from 'react';
import axios from 'axios';

const AddActivityForm = ({ childId }) => {
    const [formData, setFormData] = useState({
        name: '',
        description: '',
        date: '',
        duration: '',
        location: '',
        image: null,
    });

    const handleChange = (e) => {
        const { name, value } = e.target;
        setFormData({ ...formData, [name]: value });
    };

    const handleFileChange = (e) => {
        setFormData({ ...formData, image: e.target.files[0] });
    };

    const handleSubmit = async (e) => {
        e.preventDefault();
        const data = new FormData();
        data.append('name', formData.name);
        data.append('description', formData.description);
        data.append('date', formData.date);
        data.append('duration', formData.duration);
        data.append('location', formData.location);
        if (formData.image) {
            data.append('image', formData.image);
        }

        try {
            await axios.post(`/child/${childId}/activities`, data, {
                headers: { 'Content-Type': 'multipart/form-data' },
            });
            alert('Activité ajoutée avec succès !');
        } catch (error) {
            alert('Erreur lors de l\'ajout de l\'activité.');
        }
    };

    return (
        <form onSubmit={handleSubmit}>
            <div>
                <label>Nom de l'activité:</label>
                <input type="text" name="name" value={formData.name} onChange={handleChange} required />
            </div>
            <div>
                <label>Description:</label>
                <textarea name="description" value={formData.description} onChange={handleChange}></textarea>
            </div>
            <div>
                <label>Date:</label>
                <input type="date" name="date" value={formData.date} onChange={handleChange} required />
            </div>
            <div>
                <label>Durée (minutes):</label>
                <input type="number" name="duration" value={formData.duration} onChange={handleChange} />
            </div>
            <div>
                <label>Localisation:</label>
                <input type="text" name="location" value={formData.location} onChange={handleChange} />
            </div>
            <div>
                <label>Image:</label>
                <input type="file" name="image" onChange={handleFileChange} />
            </div>
            <button type="submit">Ajouter l'activité</button>
        </form>
    );
};

export default AddActivityForm;
