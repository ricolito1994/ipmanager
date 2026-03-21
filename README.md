<H1>Ip Manager App</H1>

<hr />

<H2>
  A dockerized CRUD application utilize microservice pattern. 
</H2>

<ul>
  <li>Ip Manager Service - main CRUD service for managing IP addresses.</li>
  <li>Gateway Service - main routing service for inter-service communication. Utilized backend async processes using guzzle.</li>
  <li>Auth Service - main role is for authentication microservice of the app. Utilize JWT for access purposes.</li>
</ul>

<hr />

<h2>Requirements</h2>
<ul>
  <li>Docker</li>
  <li>PHP 8.^</li>
  <li>Laravel 12</li>
  <li>Composer</li>
</ul>

<h2>Installation</h2>
<ol>
  <li>clone the repository <code>git clone --recurse-modules <gitrepo></code></li>
  <li>cd to ipmanager <code>cd ipmanager</code></li>
  <li>run <code>docker compose --build --no-cache</code></li>
  <li>to activate the containers <code>docker compose up -d</code></li>
  <li>after installation run on your git bash terminal <code>./migratedata.sh</code> everything will install/setup including mysql db and migration</li>
</ol>

