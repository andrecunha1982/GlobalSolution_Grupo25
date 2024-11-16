import random
import time
import json

# Função para simular a coleta de dados dos sensores do ESP32
def simulate_sensor_data():
    data = {
        "luminosity": random.randint(0, 3000),  # Valores de luminosidade
        "distance": random.randint(0, 400),     # Valores de distância
        "energy_price": random.uniform(0.1, 0.5),  # Tarifas de energia
        "internal_consumption": random.uniform(0, 5)  # Consumo interno em kWh
    }
    return data

# Função para salvar os dados simulados em um arquivo JSON

def save_data_to_file(data, filename="sensor_data.json"):
    with open(filename, 'w') as file:
        json.dump(data, file)


# Função principal para simular a coleta de dados e salvar em arquivo
def main():
    sensor_data = []
    for _ in range(10):  # Simulando 10 leituras de sensores
        data = simulate_sensor_data()
        sensor_data.append(data)
        time.sleep(1)  

    save_data_to_file(sensor_data)

if __name__ == "__main__":
    main()

# Função para selecionar automaticamente a fonte de energia mais econômica e sustentável

def switch_energy_source(sensor_data):
    for data in sensor_data:
        if data["luminosity"] > 2000 and data["energy_price"] > 0.3:
            print("Usando energia solar")
        else:
            print("Usando energia da rede")

if __name__ == "__main__":
    with open("sensor_data.json", 'r') as file:
        sensor_data = json.load(file)
    switch_energy_source(sensor_data)

# Interface de usuário para visualização dos dados dos sensores
import tkinter as tk
from tkinter import ttk

def display_data(sensor_data):
    root = tk.Tk()
    root.title("Dados dos Sensores")

    tree = ttk.Treeview(root, columns=("Luminosidade", "Distância", "Tarifa de Energia", "Consumo Interno"), show='headings')
    tree.heading("Luminosidade", text="Luminosidade")
    tree.heading("Distância", text="Distância")
    tree.heading("Tarifa de Energia", text="Tarifa de Energia (R$/kWh)")
    tree.heading("Consumo Interno", text="Consumo Interno (kWh)")

    for data in sensor_data:
        tree.insert("", tk.END, values=(data["luminosity"], data["distance"], data["energy_price"], data["internal_consumption"]))

    tree.pack()
    root.mainloop()

if __name__ == "__main__":
    with open("sensor_data.json", 'r') as file:
        sensor_data = json.load(file)
    display_data(sensor_data)

# Função para gerenciamento e otimização do consumo energético
def manage_energy_consumption(sensor_data):
    for data in sensor_data:
        if data["luminosity"] > 2000 and data["energy_price"] > 0.3:
            print("Usando energia solar")
        else:
            print("Usando energia da rede")

        if data["luminosity"] < 1000:
            print("Carregando dispositivos de armazenamento")

if __name__ == "__main__":
    with open("sensor_data.json", 'r') as file:
        sensor_data = json.load(file)
    manage_energy_consumption(sensor_data)