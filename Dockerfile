# stage 1 build
FROM node:latest as node
WORKDIR /app
COPY . .
RUN npm install
RUN npm run build --prod

# stage 2 setup
FROM nginx:alpine
COPY --from=node /app/dist/angular-app /usr/share/nginx/htmll
