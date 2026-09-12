const cards = document.querySelectorAll('.card');
const dropZones = document.querySelectorAll('.drop-zone');
const startZone = document.getElementById('start-zone');
const resultMsg = document.getElementById('result-msg');

cards.forEach(card => {
    card.addEventListener('dragstart', () => {
        card.classList.add('dragging');
    });

    card.addEventListener('dragend', () => {
        card.classList.remove('dragging');
        checkCompletion();
    });
});

dropZones.forEach(zone => {
    zone.addEventListener('dragover', (e) => {
        // Erlaubt das Droppen von Elementen
        e.preventDefault(); 
        zone.classList.add('drag-over');
    });

    zone.addEventListener('dragleave', () => {
        zone.classList.remove('drag-over');
    });

    zone.addEventListener('drop', (e) => {
        e.preventDefault();
        zone.classList.remove('drag-over');
        
        const draggingCard = document.querySelector('.dragging');
        if (!draggingCard) return;

        // Karte in die neue Zone verschieben
        zone.appendChild(draggingCard);

        // Validierung: Entspricht die ID der Dropzone dem Datentarget des Kärtchens?
        if (draggingCard.dataset.target === zone.id) {
            draggingCard.classList.remove('wrong');
            draggingCard.classList.add('correct');
        } else {
            draggingCard.classList.remove('correct');
            draggingCard.classList.add('wrong');
        }
    });
});

// Erlaube es auch, Kärtchen zurück in die Startbox zu legen
startZone.addEventListener('dragover', (e) => e.preventDefault());
startZone.addEventListener('drop', (e) => {
    e.preventDefault();
    const draggingCard = document.querySelector('.dragging');
    if (draggingCard) {
        startZone.appendChild(draggingCard);
        draggingCard.classList.remove('correct', 'wrong'); // Reset der Farben
    }
});

// Prüft, ob alle Aufgaben gelöst wurden
function checkCompletion() {
    const totalCards = cards.length;
    const correctCards = document.querySelectorAll('.card.correct').length;
    const remainingCards = startZone.querySelectorAll('.card').length;

    if (remainingCards === 0) {
        if (correctCards === totalCards) {
            resultMsg.innerText = "🎉 Perfekt! Du hast alle Buchungsfälle richtig zugeordnet.";
            resultMsg.style.color = "#2ecc71";
        } else {
            resultMsg.innerText = "Es sind noch Fehler vorhanden. Korrigiere die roten Kärtchen!";
            resultMsg.style.color = "#e74c3c";
        }
    } else {
        resultMsg.innerText = "";
    }
}
