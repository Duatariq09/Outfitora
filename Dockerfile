# Runs Outfitora in a container (Hugging Face Spaces, or any Docker host).
FROM node:22-slim

# Hugging Face Spaces run the app as user 1000. The "node" user already is 1000.

ENV HOME=/home/node PORT=7860
WORKDIR /home/node/app

# Copy the code owned by that user so the app can write its data/ and uploads/ folders.
COPY --chown=node:node . .

EXPOSE 7860
CMD ["node", "start.js"]
