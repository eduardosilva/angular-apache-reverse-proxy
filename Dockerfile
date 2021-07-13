# DEV
FROM node:12.18-alpine AS dev
WORKDIR /usr/src/app
COPY package*.json ./
RUN npm install -g @angular/cli @angular-devkit/build-angular && npm install
COPY . .
EXPOSE 4200
CMD ["npm", "start"]

# BUILD
FROM node:12.18-alpine AS build
WORKDIR /usr/src/app
COPY package.json package-lock.json ./
RUN npm install -g @angular/cli @angular-devkit/build-angular && npm install
COPY . .
RUN npm run build

# PROD
FROM httpd:alpine3.13 AS prod
COPY httpd.conf /usr/local/apache2/conf/httpd.conf
COPY --from=build /usr/src/app/dist/ui /usr/local/apache2/htdocs/
RUN chmod -R 755 /usr/local/apache2/htdocs/
EXPOSE 80