FROM node:20-alpine as build
COPY package*.json /usr/src/app
WORKDIR /usr/app/src
RUN npm install
COPY . .
RUN npm run build

'''

FROM nginx:alpine
WORKDIR /usr/share/nginx/html
COPY --from= build /usr/src/app/dist/angular-frontend /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
