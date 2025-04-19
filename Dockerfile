# Build React
FROM node:18 as build-stage
WORKDIR /app
COPY frontend/ .
RUN npm install && npm run build

# Build backend with React build
FROM node:18 as prod-stage
WORKDIR /app
COPY backend/ .
COPY --from=build-stage /app/build ./public
RUN npm install

EXPOSE 3000
CMD ["node", "index.js"]