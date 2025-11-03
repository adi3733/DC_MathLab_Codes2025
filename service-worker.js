// ⚡ MATLAB Code Vault — Offline Support with Multi-file Practical Cache
const CACHE_NAME = "matlab-code-vault-v5";

const URLS_TO_CACHE = [
  "/",
  "/index.html",
  "/style-v2.css",
  "/script.js",
  "/manifest.json",
  "/assets/favicon.png",
  "/assets/mathlab.png",
  "/assets/Caution.png",
  "/assets/HD Logo PNG.png",

  // ✅ MATLAB Files (Offline Ready)
  "/assets/dc5.m",
  "/assets/dc6a.m",
  "/assets/dc6b.m",
  "/assets/dc7.m",
  "/assets/dc8.m",
  "/assets/dc9a.m",
  "/assets/dc9b.m",
  "/assets/dc10a.m",
  "/assets/dc10b.m"
];

// INSTALL — Cache All
self.addEventListener("install", event => {
  console.log("📦 Installing MATLAB Vault Cache...");
  event.waitUntil(
    caches.open(CACHE_NAME)
      .then(cache => cache.addAll(URLS_TO_CACHE))
      .then(() => self.skipWaiting())
  );
});

// ACTIVATE — Clear Old Cache
self.addEventListener("activate", event => {
  event.waitUntil(
    caches.keys().then(keys =>
      Promise.all(keys.filter(k => k !== CACHE_NAME).map(k => caches.delete(k)))
    )
  );
  self.clients.claim();
});

// FETCH — Cache-first, then network
self.addEventListener("fetch", event => {
  event.respondWith(
    caches.match(event.request).then(cached => {
      const fetchPromise = fetch(event.request)
        .then(networkResponse => {
          if (networkResponse && networkResponse.status === 200) {
            caches.open(CACHE_NAME).then(cache =>
              cache.put(event.request, networkResponse.clone())
            );
          }
          return networkResponse;
        })
        .catch(() => cached);
      return cached || fetchPromise;
    })
  );
});

// SKIP WAITING MESSAGE
self.addEventListener("message", event => {
  if (event.data === "SKIP_WAITING") self.skipWaiting();
});
