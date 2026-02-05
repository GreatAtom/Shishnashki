const SIZE = 4;
const board = document.getElementById('board');
const buttons = document.getElementById('buttons');
const timeEl = document.getElementById('time');
const finalTimeEl = document.getElementById('finalTime');
const helpDialog = document.getElementById('helpDialog');
const winDialog = document.getElementById('winDialog');

const state = {
  cells: [],
  running: false,
  lock: false,
  startedAt: 0,
  timerId: null,
};

function shuffledNumbers() {
  const values = Array.from({ length: SIZE * SIZE }, (_, i) => i + 1);
  for (let i = values.length - 1; i > 0; i -= 1) {
    const j = Math.floor(Math.random() * (i + 1));
    [values[i], values[j]] = [values[j], values[i]];
  }
  return values;
}

function formatTime(ms) {
  const total = Math.floor(ms / 1000);
  const mm = String(Math.floor(total / 60)).padStart(2, '0');
  const ss = String(total % 60).padStart(2, '0');
  return `${mm}:${ss}`;
}

function renderBoard() {
  board.innerHTML = '';
  state.cells.forEach((value, idx) => {
    const cell = document.createElement('div');
    cell.className = 'cell';
    if (value === idx + 1) cell.classList.add('correct');
    cell.textContent = value;
    board.append(cell);
  });
}

function checkWin() {
  const won = state.cells.every((n, i) => n === i + 1);
  if (!won) return;
  stopTimer();
  finalTimeEl.textContent = timeEl.textContent;
  winDialog.showModal();
}

function swap2x2(r, c) {
  if (!state.running || state.lock) return;
  state.lock = true;
  const i1 = r * SIZE + c;
  const i2 = r * SIZE + (c + 1);
  const i3 = (r + 1) * SIZE + c;
  const i4 = (r + 1) * SIZE + (c + 1);

  // clockwise rotation
  const a = state.cells[i1];
  const b = state.cells[i2];
  const c1 = state.cells[i3];
  const d = state.cells[i4];
  state.cells[i1] = c1;
  state.cells[i2] = a;
  state.cells[i4] = b;
  state.cells[i3] = d;

  renderBoard();
  checkWin();
  setTimeout(() => {
    state.lock = false;
  }, 120);
}

function renderButtons() {
  buttons.innerHTML = '';
  for (let r = 0; r < SIZE - 1; r += 1) {
    for (let c = 0; c < SIZE - 1; c += 1) {
      const btn = document.createElement('button');
      btn.className = 'swap';
      btn.title = `Rotate block (${r + 1}, ${c + 1})`;
      btn.addEventListener('click', () => swap2x2(r, c));
      buttons.append(btn);
    }
  }
}

function tick() {
  timeEl.textContent = formatTime(Date.now() - state.startedAt);
}

function startTimer() {
  state.startedAt = Date.now();
  timeEl.textContent = '00:00';
  state.timerId = setInterval(tick, 250);
}

function stopTimer() {
  clearInterval(state.timerId);
  state.timerId = null;
}

function startGame() {
  state.cells = shuffledNumbers();
  state.running = true;
  stopTimer();
  startTimer();
  renderBoard();
}

document.getElementById('start').addEventListener('click', startGame);
document.getElementById('restart').addEventListener('click', startGame);
document.getElementById('help').addEventListener('click', () => helpDialog.showModal());
document.getElementById('closeHelp').addEventListener('click', () => helpDialog.close());
document.getElementById('playAgain').addEventListener('click', () => {
  winDialog.close();
  startGame();
});

renderButtons();
renderBoard();
