'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"assets/AssetManifest.bin": "06ce994a0f39ee647d216471ca9193c0",
"assets/AssetManifest.bin.json": "86f2da59c45bf4f057ae5fc2fd5f8a7e",
"assets/AssetManifest.json": "dac58c2b4a03af2635b22103e4bf3cc9",
"assets/assets/Fonts/Dubai/Dubai-Bold.ttf": "8fbdda63d87a91c5600c512a12aec79a",
"assets/assets/Fonts/Dubai/Dubai-Light.ttf": "2f7c5bb9cf55f5b0cb2d06c57d5a8ae7",
"assets/assets/Fonts/Dubai/Dubai-Medium.ttf": "1b70cb9a589df286a5e4faf70e2a50d9",
"assets/assets/Fonts/Dubai/Dubai-Regular.ttf": "24ab51f6ae1804c808f822d28b9be18a",
"assets/assets/Fonts/Inter/Inter-Black.ttf": "4154321279162ceac54088eca13d3e59",
"assets/assets/Fonts/Inter/Inter-BlackItalic.ttf": "c5c41f7587f272a4c43a265d0286f7bb",
"assets/assets/Fonts/Inter/Inter-Bold.ttf": "8f2869a84ad71f156a17bb66611ebe22",
"assets/assets/Fonts/Inter/Inter-BoldItalic.ttf": "c4c47e3d7ed51a6bb67b7b8088a4b0e3",
"assets/assets/Fonts/Inter/Inter-ExtraBold.ttf": "5061bd7701b1b3339f0c80e69a2136e4",
"assets/assets/Fonts/Inter/Inter-Regular.ttf": "fdb50e0d48cdcf775fa1ac0dc3c33bd4",
"assets/assets/Fonts/Inter/Inter-SemiBold.ttf": "4d24f378e7f8656a5bccb128265a6c3d",
"assets/assets/Fonts/Inter/Inter-SemiBoldItalic.ttf": "04551623d1023398fd3da941e920d727",
"assets/assets/Fonts/RobotoCondensed/RobotoCondensed-Bold.ttf": "52f9b35f9f7cfa1be2644bcbac61a983",
"assets/assets/Fonts/RobotoCondensed/RobotoCondensed-BoldItalic.ttf": "2860190205c52812d6575eb24eed1020",
"assets/assets/Fonts/RobotoCondensed/RobotoCondensed-Italic.ttf": "12ca82aeda584d84d13d0c067a5e1e9d",
"assets/assets/Fonts/RobotoCondensed/RobotoCondensed-Light.ttf": "5b45554305562f2fc404839bb9fe418a",
"assets/assets/Fonts/RobotoCondensed/RobotoCondensed-LightItalic.ttf": "11989836a08a2e1f2e33c89b9420ceda",
"assets/assets/Fonts/RobotoCondensed/RobotoCondensed-Regular.ttf": "0e1821fdf320fddc0e1c2b272c422068",
"assets/assets/Fonts/Shrikhand-Regular.otf": "7f1dacd0d3f99e36e90865d7b21b52fd",
"assets/assets/images/Base/image1.png": "fa820c926fc45ec911a6fdf31badbd5b",
"assets/assets/images/Base/image2.png": "1c758fc5067b978b02e9e07c39417979",
"assets/assets/images/Base/imagenDetalle1.jpg": "5532b1f205bb01429f326e17279dfb39",
"assets/assets/images/Base/logo.png": "77fb62da6f0f4c91ee5eec4ede9924e1",
"assets/assets/images/Base/proyectoImage.png": "009e8fa37bd1b0d830c0c590a370869c",
"assets/assets/images/Header/logo.png": "461e797cc4e571dd109e93fa5752603e",
"assets/assets/images/Header/User.jpg": "84816646bbaead220761f9f8f059fe2b",
"assets/assets/images/login/backgroupRegister.png": "3b424cf4c124b4ff1b7b28a03e8cc937",
"assets/assets/images/login/login_background.png": "3d0f5def7f691f00d14a5d805be577e8",
"assets/assets/images/login/login_image.png": "b58e2cb508395130aa29b8be6fc34596",
"assets/assets/images/login/registerImage.png": "f1c546f0c68d0815c8557d86a36ad129",
"assets/FontManifest.json": "9da6f9e8eeb08b6344d9fc5e0e8169c1",
"assets/fonts/MaterialIcons-Regular.otf": "42cadb6c32e63dc1cafa910f5c189d0c",
"assets/NOTICES": "a88ab9ef04103c8ecc72f25ff1cef1fb",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"canvaskit/canvaskit.js": "5fda3f1af7d6433d53b24083e2219fa0",
"canvaskit/canvaskit.js.symbols": "48c83a2ce573d9692e8d970e288d75f7",
"canvaskit/canvaskit.wasm": "1f237a213d7370cf95f443d896176460",
"canvaskit/chromium/canvaskit.js": "87325e67bf77a9b483250e1fb1b54677",
"canvaskit/chromium/canvaskit.js.symbols": "a012ed99ccba193cf96bb2643003f6fc",
"canvaskit/chromium/canvaskit.wasm": "b1ac05b29c127d86df4bcfbf50dd902a",
"canvaskit/skwasm.js": "9fa2ffe90a40d062dd2343c7b84caf01",
"canvaskit/skwasm.js.symbols": "262f4827a1317abb59d71d6c587a93e2",
"canvaskit/skwasm.wasm": "9f0c0c02b82a910d12ce0543ec130e60",
"canvaskit/skwasm.worker.js": "bfb704a6c714a75da9ef320991e88b03",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"flutter.js": "f31737fb005cd3a3c6bd9355efd33061",
"flutter_bootstrap.js": "a8f0350c868753db446ed990dcf612cc",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"index.html": "7813585eb122a9265a95d7e1fc3ba478",
"/": "7813585eb122a9265a95d7e1fc3ba478",
"main.dart.js": "563b16c5cc2eab231c47b3ef38632f07",
"manifest.json": "3c16890e7430afff441c09706c96c0b7",
"version.json": "6fa44fabc41177e2a212337e1f7bd7b4"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
