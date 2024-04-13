if [ -f .env ]; then
   source .env
fi

export PORT="${PORT:-3000}"

echo "Stopping the application..."
docker stop radix-chat-backend

echo "Building the Docker image..."
docker build -t theredscreen/radix-chat-backend .

echo "Running migrations..."
docker run --rm \
  -e NODE_ENV=production \
  -e DATABASE_URL="${DATABASE_URL}" \
  --network=host \
  theredscreen/radix-chat-backend npm run migrate

echo "Starting the application..."
docker start radix-chat-backend

echo "Finished!"