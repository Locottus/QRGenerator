#build docker container 
#docker build -t generador-qr .
#run container
#docker run -p 5000:5000 generador-qr

# Utiliza una imagen base oficial de Python
FROM python:3.9-slim

# Establece el directorio de trabajo en el contenedor
WORKDIR /app

# Copia el archivo de dependencias al directorio actual
COPY requirements.txt .

# Instala las dependencias del proyecto
RUN pip install --no-cache-dir -r requirements.txt

# Copia el resto de tu aplicación al directorio de trabajo
COPY . .

# Expone el puerto que Flask utilizará
EXPOSE 5000

# Comando para ejecutar la aplicación
CMD ["flask", "run", "--host=0.0.0.0"]
