# # as builder - means that from this command and everything below it will be referred to as builder
# FROM node:alpine as builder 
# WORKDIR "/app"
# COPY package.json .
# RUN npm install
# COPY . .
# CMD ["npm", "run", "build"]

# FROM nginx
# # copying something from another phase (build folder from builder phase)
# COPY --from=builder /app/build /usr/share/nginx/html


FROM node:alpine
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build
 
FROM nginx
EXPOSE 80
COPY --from=0 /app/build /usr/share/nginx/html