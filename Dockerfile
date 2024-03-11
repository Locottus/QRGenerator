#build docker container 
#docker build -t generador-qr .
#run container
#docker run -e PORT=8080 -p 8080:8080 generador-qr

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

# Define el valor predeterminado para la variable de entorno PORT
ENV PORT=5000

# Informa a Docker que el contenedor escucha en el puerto especificado en tiempo de ejecución.
EXPOSE $PORT

# Comando para ejecutar la aplicación
CMD ["flask", "run", "--host=0.0.0.0"]
