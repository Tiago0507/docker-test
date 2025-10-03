FROM node:18-alpine AS build

# Se establece el directorio de trabajo dentro del contenedor
WORKDIR /app

# Se copia el package.json y package-lock.json para instalar dependencias
COPY package*.json ./

RUN npm install

# Se copian el resto de los archivos de la aplicación
COPY . .

RUN npm run build

FROM nginx:stable-alpine

# Se copian los archivos construidos de la etapa anterior a la carpeta de Nginx
COPY --from=build /app/build /usr/share/nginx/html

EXPOSE 80

# El comando por defecto para iniciar el servidor Nginx
CMD ["nginx", "-g", "daemon off;"]