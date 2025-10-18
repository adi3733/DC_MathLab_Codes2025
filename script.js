const practicals = [
  { name: "Practical 5", desc: "Performance of M-ary PSK using MATLAB", file: "Adi5.m" },
  { name: "Practical 6", desc: "Performance of M-PSK and M-QAM", file: "Adi6.m" },
  { name: "Practical 7", desc: "BPSK Receiver Performance in Presence of Noise", file: "Adi7.m" },
  { name: "Practical 8", desc: "Source Coding Technique using MATLAB", file: "Adi8.m" },
  { name: "Practical 9", desc: "Simulation of Cyclic Codes using MATLAB", file: "Adi9.m" },
  { name: "Practical 10", desc: "Convolutional Coding Technique using MATLAB", file: "Adi10.m" },
];

const list = document.getElementById("practicalList");
const popup = document.getElementById("popup");
const popupTitle = document.getElementById("popupTitle");
const popupCode = document.getElementById("popupCode");
const copyBtn = document.getElementById("copyBtn");
const closeBtn = document.getElementById("closeBtn");

// Create cards
practicals.forEach(p => {
  const card = document.createElement("div");
  card.className = "card";
  card.innerHTML = `<h3>${p.name}</h3><span>${p.desc}</span>`;
  card.onclick = () => openPopup(p);
  list.appendChild(card);
});

function openPopup(p) {
  fetch(`assets/${p.file}`)
    .then(res => res.text())
    .then(code => {
      popupTitle.textContent = `${p.name}: ${p.desc}`;
      popupCode.textContent = code;
      popup.style.display = "flex";
      copyBtn.onclick = () => {
        navigator.clipboard.writeText(code);
        copyBtn.textContent = "✅ Copied!";
        setTimeout(() => (copyBtn.textContent = "📋 Copy Code"), 1500);
      };
    })
    .catch(() => {
      popupTitle.textContent = p.name;
      popupCode.textContent = "⚠️ Unable to load file.";
      popup.style.display = "flex";
    });
}

closeBtn.onclick = () => (popup.style.display = "none");


const fontPlus = document.getElementById("fontPlus");
const fontMinus = document.getElementById("fontMinus");
let currentFontSize = 0.95; // default size

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
