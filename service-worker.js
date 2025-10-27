// ⚡ MATLAB Code Vault - FULL Offline Support + Update Notice
const CACHE_NAME = "matlab-code-vault-v3";
const URLS_TO_CACHE = [
  "/",
  "/index.html",
  "/style-v2.css",
  "/script.js",
  "/manifest.json",

  // Images & Icons
  "/assets/favicon.png",
  "/assets/mathlab.png",
  "/assets/Caution.png",
  "/assets/HD Logo PNG.png",

  // MATLAB Codes ✅ (Offline Available)
  "/assets/Adi5.m",
  "/assets/Adi6.m",
  "/assets/Adi7.m",
  "/assets/Adi8.m",
  "/assets/Adi9.m",
  "/assets/Adi10.m"
];

// INSTALL → Cache all required content
self.addEventListener("install", event => {
  event.waitUntil(
    caches.open(CACHE_NAME)
      .then(cache => cache.addAll(URLS_TO_CACHE))
      .then(() => self.skipWaiting())
  );
});

// ACTIVATE → Remove old cache
self.addEventListener("activate", event => {
  event.waitUntil(
    caches.keys().then(keys =>
      Promise.all(
        keys.map(key => {
          if (key !== CACHE_NAME) return caches.delete(key);
        })
      )
    )
  );
  self.clients.claim();
});

// FETCH → Serve from cache first, update in background
self.addEventListener("fetch", event => {
  event.respondWith(
    caches.match(event.request).then(cached => {
      const fetchPromise = fetch(event.request)
        .then(networkResponse => {
          if (networkResponse && networkResponse.status === 200) {
            caches.open(CACHE_NAME).then(cache => {
              cache.put(event.request, networkResponse.clone());
            });
          }
          return networkResponse;
        })
        .catch(() => cached);
      return cached || fetchPromise;
    })
  );
});

// NEW VERSION UPDATE
self.addEventListener("message", event => {
  if (event.data === "SKIP_WAITING") self.skipWaiting();
});
