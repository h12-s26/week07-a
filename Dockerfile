FROM node:alpine AS build-stage
WORKDIR /app
COPY package.json .
RUN npm install
COPY . .
RUN npx parcel build "/app/source/index.html" --dist-dir "dist" --public-url "/"

FROM nginx:latest
COPY --from=build-stage "/app/dist" /usr/share/nginx/html
