import React from 'react';
import ReactDOM from 'react-dom';
import RelativeDashboard from '../../views/RelativeDashboard';
import AddActivityForm from '../../views/AddActivityForm';

document.addEventListener('DOMContentLoaded', () => {
    const dashboardElement = document.getElementById('relative-dashboard-app');
    if (dashboardElement) {
        const children = JSON.parse(dashboardElement.dataset.children); // Charger les enfants depuis un attribut data
        ReactDOM.render(
            <div>
                <RelativeDashboard children={children} />
                <AddActivityForm childId={children[0]?.id} />
            </div>,
            dashboardElement
        );
    }
});
