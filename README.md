<h1 align="center">🧠 Cognitive Load Butler</h1>

<p align="center">
  <em>Your personal assistant for managing mental effort, not just tasks.</em>
</p>

<hr />

<h2>Overview</h2>

<p>
Cognitive Load Butler is a lightweight productivity prototype that helps users decide
<strong>what to focus on today</strong> by balancing task importance against mental effort.
</p>

<p>
Instead of showing an ever-growing to-do list, the Butler applies a simple scoring model
to surface a smaller, more realistic set of high-impact tasks — helping users pace
themselves and avoid burnout.
</p>

<hr />

<h2>Key Features</h2>

<ul>
  <li>
    <strong>Dynamic Task Management</strong><br />
    Users can add custom tasks using sliders for <em>Importance</em> and <em>Mental Load</em>.
  </li>

  <li>
    <strong>Today’s High-Impact Focus</strong><br />
    Tasks are reorganized into a focused view that highlights what matters most today,
    rather than showing the entire backlog.
  </li>

  <li>
    <strong>Butler Scoring Algorithm</strong><br />
    Each task is ranked using a weighted formula that prioritizes impact while accounting
    for cognitive cost.
  </li>

  <li>
    <strong>Native Web Notifications</strong><br />
    Uses the browser’s Notification API to:
    <ul>
      <li>Alert users when a high-impact task requires attention</li>
      <li>Confirm task completion when an item is finished and removed</li>
    </ul>
  </li>

  <li>
    <strong>Task Completion Flow</strong><br />
    Completing a task removes it from both the task list and the focus list,
    with immediate feedback from the Butler.
  </li>

  <li>
    <strong>Visual Prioritization</strong><br />
    High-impact tasks are visually emphasized using a compact “sticky note” layout
    to reduce visual clutter and scanning time.
  </li>
</ul>

<hr />

<h2>The Butler Algorithm</h2>

<p>
Rather than treating all tasks equally, the Butler assigns a score to each task:
</p>

<pre>
Score = (Importance × 3) − Mental Load
</pre>

<table border="1" cellpadding="8" cellspacing="0">
  <thead>
    <tr>
      <th>Score Range</th>
      <th>Meaning</th>
      <th>Behavior</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>8+</td>
      <td>High-impact, manageable effort</td>
      <td>Pinned and highlighted in focus view</td>
    </tr>
    <tr>
      <td>1–7</td>
      <td>Standard priority</td>
      <td>Shown normally</td>
    </tr>
    <tr>
      <td>&lt; 0</td>
      <td>High cognitive cost</td>
      <td>De-emphasized to avoid overload</td>
    </tr>
  </tbody>
</table>

<hr />

<h2>Design Philosophy</h2>

<p>
Most productivity tools focus on quantity: more tasks, more lists, more pressure.
Cognitive Load Butler treats mental energy as a limited resource.
</p>

<p>
Feedback is immediate and lightweight — actions are acknowledged,
then cleared away to reduce cognitive clutter.
</p>

<p>
The goal is not to do everything, but to do the right things at the right pace.
</p>

<hr />

<h2>Tech Stack</h2>

<table border="1" cellpadding="8" cellspacing="0">
  <thead>
    <tr>
      <th>Layer</th>
      <th>Technology</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>Frontend</td>
      <td>Flutter Web (custom compact “sticky note” UI)</td>
    </tr>
    <tr>
      <td>Backend</td>
      <td>Serverpod (Dart-based backend)</td>
    </tr>
    <tr>
      <td>APIs</td>
      <td>Browser Notification API (via universal_html)</td>
    </tr>
    <tr>
      <td>DevOps</td>
      <td>Docker Compose for local Serverpod setup</td>
    </tr>
  </tbody>
</table>

<hr />

<h2>Running the Project Locally</h2>

<h3>Prerequisites</h3>

<ul>
  <li>Flutter SDK (3.32.0+)</li>
  <li>Serverpod CLI (3.1.1)</li>
  <li>Docker & Docker Compose</li>
  <li>Chrome Browser</li>
</ul>

<h3>Steps</h3>

<h4>1. Start the Serverpod backend</h4>

<pre>
cd server
docker-compose up --build
dart bin/main.dart
</pre>

<h4>2. Run the Flutter Web client</h4>

<pre>
cd cognitive_load_butler_flutter
flutter run -d chrome
</pre>

<p>
When prompted, allow browser notifications to enable Butler alerts.
</p>

<hr />

<h2>Status</h2>

<p>
<strong>Hackathon Prototype — Complete</strong><br />
This project is a functional MVP demonstrating:
</p>

<ul>
  <li>Task input and prioritization logic</li>
  <li>UI-driven focus management</li>
  <li>Browser-level notifications</li>
  <li>End-to-end integration between Flutter Web and Serverpod</li>
</ul>

<p align="center">
Built with ❤️ for the 2026 Serverpod Butler Hackathon
</p>
