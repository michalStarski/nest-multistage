FROM node:14-alpine as build

WORKDIR /app

COPY package.json .
COPY yarn.lock .

RUN yarn install --frozen-lockfile
COPY . .
RUN yarn build

FROM nginx:1.21.4-alpine

WORKDIR /app

COPY --from=build /app/dist /app
