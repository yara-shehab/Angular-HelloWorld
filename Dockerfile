# stage 1 build
FROM node:latest as node
WORKDIR /usr/local/app
COPY ./ /usr/local/app/
RUN npm install
RUN npm run build --prod

# stage 2 setup
FROM nginx:alpine
COPY --from=node /usr/local/app/dist/sample-angular-app /usr/share/nginx/html
