-- Exemple : Créer une table et insérer des données initiales
CREATE TABLE example_table (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO example_table (name) VALUES ('Example 1'), ('Example 2');
