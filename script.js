// ☕ MATLAB Code Vault — by TechhBuddies
// Supports multi-file practicals (.m files)

const practicals = [
  { 
    name: "Practical 5", 
    desc: "Performance of M-ary PSK using MATLAB", 
    files: [ "dc5.m" ] 
  },
  { 
    name: "Practical 6", 
    desc: "Performance of M-PSK and M-QAM", 
    files: [ "dc6a.m",  ] 
  },
  { 
    name: "Practical 7", 
    desc: "BPSK Receiver Performance in Presence of Noise", 
    files: [ "dc7.m" ] 
  },
  { 
    name: "Practical 8", 
    desc: "Source Coding Technique using MATLAB", 
    files: [ "dc8.m" ] 
  },
  { 
    name: "Practical 9", 
    desc: "Simulation of Cyclic Codes using MATLAB", 
    files: [ "dc9a.m",  ] 
  },
  { 
    name: "Practical 10", 
    desc: "Convolutional Coding Technique using MATLAB", 
    files: [ "dc10a.m", "dc10b.m" ] 
  },
];

const list = document.getElementById("practicalList");
const popup = document.getElementById("popup");
const popupTitle = document.getElementById("popupTitle");
const popupCode = document.getElementById("popupCode");
const copyBtn = document.getElementById("copyBtn");
const closeBtn = document.getElementById("closeBtn");
const fileTabs = document.getElementById("fileTabs");

// Render practical cards
practicals.forEach(p => {
  const card = document.createElement("div");
  card.className = "card";
  const count = p.files.length;
  card.innerHTML = `<h3>${p.name}</h3><span>${p.desc} — ${count} file${count > 1 ? "s" : ""}</span>`;
  card.onclick = () => openPopup(p);
  list.appendChild(card);
});

let currentCode = "";
let currentFontSize = 0.95;

function openPopup(p) {
  popupTitle.textContent = `${p.name}: ${p.desc}`;
  popup.style.display = "flex";
  fileTabs.innerHTML = "";

  p.files.forEach((f, idx) => {
    const btn = document.createElement("button");
    btn.className = "file-tab";
    btn.textContent = f;
    btn.onclick = e => {
      e.stopPropagation();
      setActiveFile(p, idx);
    };
    fileTabs.appendChild(btn);
  });
  setActiveFile(p, 0);
}

function setActiveFile(practical, index) {
  const tabs = Array.from(fileTabs.children);
  tabs.forEach((tab, i) => tab.classList.toggle("active", i === index));

  const file = practical.files[index];
  fetch(`/assets/${file}`)
    .then(res => {
      if (!res.ok) throw new Error("File not found");
      return res.text();
    })
    .then(code => {
      currentCode = code;
      popupCode.textContent = code;
      copyBtn.textContent = "📋 Copy Code";
      popupCode.style.fontSize = `${currentFontSize}rem`;
    })
    .catch(() => {
      popupCode.textContent = `⚠️ Unable to load file: ${file}`;
    });
}

// Copy Code
copyBtn.onclick = () => {
  if (!currentCode) return;
  navigator.clipboard.writeText(currentCode);
  copyBtn.textContent = "✅ Copied!";
  setTimeout(() => (copyBtn.textContent = "📋 Copy Code"), 1500);
};

// Font Controls
const fontPlus = document.getElementById("fontPlus");
const fontMinus = document.getElementById("fontMinus");

fontPlus.onclick = () => {
  currentFontSize += 0.1;
  popupCode.style.fontSize = `${currentFontSize}rem`;
};

fontMinus.onclick = () => {
  if (currentFontSize > 0.6) {
    currentFontSize -= 0.1;
    popupCode.style.fontSize = `${currentFontSize}rem`;
  }
};

// Close Popup
closeBtn.onclick = () => (popup.style.display = "none");

// Version
const buildVersion = document.getElementById("buildVersion");
buildVersion.textContent = new Date().toLocaleString("en-IN", {
  dateStyle: "medium",
  timeStyle: "short"
});
