# User Guide: Humor Memory Game

Complete guide on how to access, use, and interact with the deployed Humor Memory Game application.

## Table of Contents

1. [Accessing the Application](#accessing-the-application)
2. [Game Features](#game-features)
3. [How to Play](#how-to-play)
4. [Leaderboard](#leaderboard)
5. [My Stats](#my-stats)
6. [Troubleshooting Access](#troubleshooting-access)

## Accessing the Application

### Local Development (Docker Compose)

1. **Start the application**:
   ```bash
   docker-compose up -d
   ```

2. **Access the game**:
   - Open browser: `http://localhost:8080`
   - Or: `http://localhost:3000` (if configured)

3. **Verify services are running**:
   ```bash
   docker-compose ps
   # Should show: backend, frontend, postgres, redis all "Up"
   ```

### Local Kubernetes

1. **Deploy the application**:
   ```bash
   kubectl apply -f k8s/
   ```

2. **Port-forward to access**:
   ```bash
   kubectl port-forward svc/frontend -n humor-game 8080:80
   ```

3. **Access the game**:
   - Open browser: `http://localhost:8080`

### Production (AWS/Kubernetes with Ingress)

1. **Access via domain** (if configured):
   - `https://yourdomain.com` or `http://gameapp.local:8080`

2. **Access via port-forward** (from bastion):
   ```bash
   # SSH to bastion first
   ssh -i key.pem ec2-user@<bastion-ip>
   
   # Configure kubectl
   aws eks update-kubeconfig --region us-east-1 --name <cluster-name>
   
   # Port-forward
   kubectl port-forward svc/frontend -n humor-game 8080:80
   ```

## Game Features

### Main Features

- **Memory Card Game**: Match pairs of emoji cards
- **Multiple Difficulty Levels**: Easy, Medium, Hard, Expert
- **Real-time Scoring**: Points based on speed and accuracy
- **Leaderboard**: See top players and rankings
- **Personal Statistics**: Track your games and best scores
- **Session Management**: Save and resume games

### Navigation Tabs

1. **Game Tab**: Play the memory game
2. **Leaderboard Tab**: View top players
3. **My Stats Tab**: View your personal statistics
4. **About Tab**: Game information and credits

## How to Play

### Starting a Game

1. **Select Difficulty**:
   - Easy: 4x4 grid (8 pairs)
   - Medium: 6x6 grid (18 pairs)
   - Hard: 8x8 grid (32 pairs)
   - Expert: 10x10 grid (50 pairs)

2. **Click "Start Game"** button

3. **Gameplay**:
   - Click cards to flip them
   - Match pairs of identical emojis
   - Cards flip back if no match
   - Complete all pairs to win

### Scoring System

- **Base Points**: 10 points per match
- **Speed Bonus**: Faster matches = more points
- **Combo Bonus**: Consecutive matches increase multiplier
- **Time Penalty**: Longer games reduce final score

### Game Controls

- **Click**: Flip a card
- **Auto-flip**: Cards automatically flip back after 2 seconds if no match
- **Reset**: Start a new game (loses current progress)

## Leaderboard

### Viewing Leaderboard

1. Click **"Leaderboard"** tab
2. View top players sorted by:
   - Best Score (highest)
   - Best Time (fastest)
   - Total Games (most played)

### Leaderboard Information

- **Username**: Player's display name
- **Best Score**: Highest score achieved
- **Best Time**: Fastest completion time
- **Total Games**: Number of games played
- **Average Score**: Average points per game
- **Rank**: Position on leaderboard

## My Stats

### Personal Statistics

Access your stats by clicking **"My Stats"** tab:

- **Total Games**: Number of games you've played
- **Total Score**: Sum of all your scores
- **Best Score**: Your highest score
- **Best Time**: Your fastest completion
- **Average Score**: Your average points per game
- **Last Played**: When you last played

### Tracking Progress

- Stats update automatically after each game
- Best scores and times are saved permanently
- View your improvement over time

## API Endpoints

### Health Check

```bash
# Check if backend is healthy
curl http://localhost:3001/health

# Expected response:
# {"status":"ok","timestamp":"2024-01-01T00:00:00.000Z"}
```

### Game API

```bash
# Get leaderboard
curl http://localhost:3001/api/leaderboard

# Get user stats
curl http://localhost:3001/api/stats?username=your_username

# Submit game score
curl -X POST http://localhost:3001/api/games \
  -H "Content-Type: application/json" \
  -d '{"username":"player1","score":100,"time":45000}'
```

## Troubleshooting Access

### Cannot Access Application

**Symptom**: Browser shows "Cannot connect" or timeout

**Solutions**:
1. **Check if services are running**:
   ```bash
   # Docker Compose
   docker-compose ps
   
   # Kubernetes
   kubectl get pods -n humor-game
   ```

2. **Check service ports**:
   ```bash
   # Docker Compose
   docker-compose port frontend 80
   
   # Kubernetes
   kubectl get svc -n humor-game
   ```

3. **Check logs for errors**:
   ```bash
   # Docker Compose
   docker-compose logs frontend
   docker-compose logs backend
   
   # Kubernetes
   kubectl logs deployment/frontend -n humor-game
   kubectl logs deployment/backend -n humor-game
   ```

### Game Not Loading

**Symptom**: Page loads but game doesn't start

**Solutions**:
1. **Check browser console** (F12 → Console tab)
2. **Verify API connection**:
   ```bash
   curl http://localhost:3001/health
   ```
3. **Check CORS configuration** if accessing from different domain
4. **Clear browser cache** and reload

### Database Connection Errors

**Symptom**: "Database connection failed" in logs

**Solutions**:
1. **Verify database is running**:
   ```bash
   # Docker Compose
   docker-compose ps postgres
   
   # Kubernetes
   kubectl get pods -n humor-game | grep postgres
   ```

2. **Check database credentials** in ConfigMap/Secrets
3. **Wait for database initialization** (may take 30-60 seconds)

### Leaderboard Not Showing

**Symptom**: Leaderboard is empty or shows errors

**Solutions**:
1. **Check if database has data**:
   ```bash
   # Docker Compose
   docker-compose exec postgres psql -U gameuser -d humor_memory_game -c "SELECT * FROM users LIMIT 5;"
   ```

2. **Verify API endpoint**:
   ```bash
   curl http://localhost:3001/api/leaderboard
   ```

3. **Check backend logs** for database query errors

## Performance Tips

### For Best Performance

1. **Use modern browser**: Chrome, Firefox, Safari, Edge (latest versions)
2. **Enable JavaScript**: Required for game functionality
3. **Stable internet connection**: For online deployments
4. **Close unnecessary tabs**: Frees up browser resources

### Browser Compatibility

- ✅ Chrome 90+
- ✅ Firefox 88+
- ✅ Safari 14+
- ✅ Edge 90+

## Keyboard Shortcuts

- **R**: Reset game (if implemented)
- **Esc**: Close modals/dialogs
- **Enter**: Submit forms

## Mobile Access

### Responsive Design

The game is responsive and works on:
- 📱 Mobile phones (iOS, Android)
- 📱 Tablets (iPad, Android tablets)
- 💻 Desktop browsers

### Mobile-Specific Notes

- Touch-friendly card flipping
- Optimized for portrait and landscape
- Responsive layout adapts to screen size

## Support

### Getting Help

1. **Check logs** for error messages
2. **Review troubleshooting section** above
3. **Check application health**:
   ```bash
   curl http://localhost:3001/health
   ```
4. **Verify all services are running**

### Reporting Issues

If you encounter bugs or issues:
1. Note the error message
2. Check browser console (F12)
3. Check backend logs
4. Report with:
   - Error message
   - Steps to reproduce
   - Browser and version
   - Screenshots if possible

## Next Steps

- [Deployment Guide](./03-k8s-basics.md) - Deploy the application
- [Troubleshooting](./08-troubleshooting.md) - Fix common issues
- [Monitoring Guide](./05-observability.md) - Monitor application performance

