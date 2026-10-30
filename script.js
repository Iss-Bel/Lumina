document.addEventListener("DOMContentLoaded", function () {
  // ==========================================
  // 1. FILTROS E ORDENAÇÃO DE PRODUTOS
  // ==========================================
  const gridProdutos = document.getElementById("produtos");

  if (gridProdutos) {
    const cards = Array.from(gridProdutos.querySelectorAll(".card"));
    const linksCategorias = document.querySelectorAll(".categoria-item");
    const btnsTamanho = document.querySelectorAll(".btn-tamanho");
    const selectOrdenar = document.querySelector(".select-ordenar");

    // Guardar a ordem inicial dos produtos
    cards.forEach((card, index) => {
      card.dataset.ordemOriginal = index;
    });

    // Categoria inicial ('todos' exibe toda a loja)
    let categoriaAtual = "todos";
    
    // Desativar qualquer filtro de tamanho predefinido para exibir TODOS os produtos no arranque
    let tamanhoAtual = null;
    btnsTamanho.forEach((b) => b.classList.remove("ativo"));

    // Ler termo de pesquisa da URL (ex: ?q=camiseta)
    const urlParams = new URLSearchParams(window.location.search);
    const termoBusca = (urlParams.get("q") || "").toLowerCase().trim();

    // Compatibilidade entre tamanhos em letras e numéricos (ex: M -> 38, 40)
    function tamanhoCorresponde(tamanhoProduto, tamanhoFiltro) {
      if (!tamanhoFiltro) return true;
      if (tamanhoProduto === "ÚNICO") return true;
      if (tamanhoProduto === tamanhoFiltro) return true;

      const equivalencias = {
        PP: ["34", "36"],
        P: ["36", "38"],
        M: ["38", "40"],
        G: ["42", "44"]
      };

      return equivalencias[tamanhoFiltro] ? equivalencias[tamanhoFiltro].includes(tamanhoProduto) : false;
    }

    function aplicarFiltrosEOrdenacao() {
      // 1. Filtragem dos produtos
      const produtosVisiveis = cards.filter((card) => {
        // Categoria
        const categoriasCard = (card.dataset.categoria || "").toLowerCase().split(" ");
        const atendeCategoria =
          categoriaAtual === "todos" || categoriasCard.includes(categoriaAtual.toLowerCase());

        // Tamanho
        const inputTamanho = card.querySelector('input[name="tamanho"]');
        const tamanhoCard = inputTamanho ? inputTamanho.value.trim().toUpperCase() : "";
        const atendeTamanho = tamanhoCorresponde(tamanhoCard, tamanhoAtual);

        // Termo de Pesquisa
        const tituloProduto = (card.querySelector("h2")?.innerText || "").toLowerCase();
        const atendeBusca = !termoBusca || tituloProduto.includes(termoBusca);

        return atendeCategoria && atendeTamanho && atendeBusca;
      });

      // Exibir/Ocultar elementos no DOM
      cards.forEach((card) => {
        card.style.display = produtosVisiveis.includes(card) ? "" : "none";
      });

      // 2. Ordenação dos produtos visíveis
      const modoOrdenacao = selectOrdenar ? selectOrdenar.value : "relevancia";

      produtosVisiveis.sort((a, b) => {
        const precoA = parseFloat(a.querySelector('input[name="preco"]')?.value || 0);
        const precoB = parseFloat(b.querySelector('input[name="preco"]')?.value || 0);

        if (modoOrdenacao === "menor-preco") {
          return precoA - precoB;
        } else if (modoOrdenacao === "maior-preco") {
          return precoB - precoA;
        } else {
          return parseInt(a.dataset.ordemOriginal, 10) - parseInt(b.dataset.ordemOriginal, 10);
        }
      });

      // Atualizar a ordem visual dos cartões na grelha
      produtosVisiveis.forEach((card) => gridProdutos.appendChild(card));
    }

    // Clique nas Categorias
    linksCategorias.forEach((link) => {
      link.addEventListener("click", function (e) {
        e.preventDefault();
        linksCategorias.forEach((l) => l.classList.remove("ativa"));
        this.classList.add("ativa");
        categoriaAtual = this.dataset.filtro || "todos";
        aplicarFiltrosEOrdenacao();
      });
    });

    // Clique nos Tamanhos (permite desmarcar ao clicar no mesmo tamanho)
    btnsTamanho.forEach((btn) => {
      btn.addEventListener("click", function () {
        if (this.classList.contains("ativo")) {
          this.classList.remove("ativo");
          tamanhoAtual = null;
        } else {
          btnsTamanho.forEach((b) => b.classList.remove("ativo"));
          this.classList.add("ativo");
          tamanhoAtual = this.innerText.trim().toUpperCase();
        }
        aplicarFiltrosEOrdenacao();
      });
    });

    // Alteração na caixa de seleção de Ordenação
    if (selectOrdenar) {
      selectOrdenar.addEventListener("change", aplicarFiltrosEOrdenacao);
    }

    // Execução inicial: mostra todos os produtos imediatamente
    aplicarFiltrosEOrdenacao();
  }

  // ==========================================
  // 2. CHECKOUT E MÉTODOS DE PAGAMENTO
  // ==========================================
  const formCheckout = document.getElementById("form-checkout");
  if (!formCheckout) return;

  const radiosMetodo = document.querySelectorAll('input[name="metodo_pagamento"]');
  const painelCartao = document.getElementById("painel-cartao");
  const painelPix = document.getElementById("painel-pix");
  const painelBoleto = document.getElementById("painel-boleto");

  const lblCartao = document.getElementById("lbl-cartao");
  const lblPix = document.getElementById("lbl-pix");
  const lblBoleto = document.getElementById("lbl-boleto");

  const cartaoInputs = painelCartao ? painelCartao.querySelectorAll("input, select") : [];

  const pixKeyInput = document.getElementById("pix-key-input");
  const qrCodeImg = document.getElementById("pix-qrcode-img");
  const btnCopyPix = document.getElementById("btn-copy-pix");
  const copyFeedback = document.getElementById("copy-feedback");
  const timerDisplay = document.getElementById("pix-timer");

  const totalElement = document.getElementById("resumo-total-valor");
  const totalBase = totalElement && totalElement.dataset.totalOriginal 
    ? parseFloat(totalElement.dataset.totalOriginal) 
    : 0;

  let timerInterval = null;
  let tempoRestante = 15 * 60;
  let pixGerado = false;

  function alternarCamposCartao(ativar) {
    cartaoInputs.forEach((input) => {
      if (ativar) {
        input.removeAttribute("disabled");
        if (input.dataset.required === "true") {
          input.setAttribute("required", "required");
        }
      } else {
        input.removeAttribute("required");
        input.setAttribute("disabled", "disabled");
      }
    });
  }

  function atualizarResumoTotal(metodo) {
    if (!totalElement || !totalBase) return;

    if (metodo === "pix") {
      const totalComDesconto = totalBase * 0.95;
      totalElement.innerText = `R$ ${totalComDesconto.toFixed(2).replace(".", ",")}`;
    } else {
      totalElement.innerText = `R$ ${totalBase.toFixed(2).replace(".", ",")}`;
    }
  }

  function gerarCodigoPix() {
    const randomHex = Math.random().toString(36).substring(2, 10).toUpperCase();
    return `00020126580014BR.GOV.BCB.PIX0136123e4567-e89b-12d3-a456-4266141740005204000053039865405150.005802BR5915LUMINA_LOJA6009SAO_PAULO62070503${randomHex}6304ABCD`;
  }

  function inicializarPix() {
    if (!pixGerado) {
      const codigo = gerarCodigoPix();
      if (pixKeyInput) pixKeyInput.value = codigo;
      if (qrCodeImg) {
        qrCodeImg.src = `https://api.qrserver.com/v1/create-qr-code/?size=180x180&data=${encodeURIComponent(codigo)}`;
      }
      pixGerado = true;
    }

    if (btnCopyPix) {
      btnCopyPix.disabled = false;
      btnCopyPix.innerText = "📋 Copiar";
    }

    iniciarTimerPix();
  }

  function iniciarTimerPix() {
    if (timerInterval && tempoRestante > 0) return;

    clearInterval(timerInterval);

    function atualizarDisplay() {
      const minutos = Math.floor(tempoRestante / 60);
      const segundos = tempoRestante % 60;

      if (timerDisplay) {
        timerDisplay.textContent = `${String(minutos).padStart(2, "0")}:${String(segundos).padStart(2, "0")}`;
      }

      if (tempoRestante <= 0) {
        clearInterval(timerInterval);
        if (timerDisplay) timerDisplay.textContent = "EXPIRADO";
        if (btnCopyPix) {
          btnCopyPix.disabled = true;
          btnCopyPix.innerText = "Expirado";
        }
      } else {
        tempoRestante--;
      }
    }

    atualizarDisplay();
    timerInterval = setInterval(atualizarDisplay, 1000);
  }

  function alternarMetodo(valor) {
    if (painelCartao) painelCartao.style.display = "none";
    if (painelPix) painelPix.style.display = "none";
    if (painelBoleto) painelBoleto.style.display = "none";

    if (lblCartao) lblCartao.classList.remove("ativo");
    if (lblPix) lblPix.classList.remove("ativo");
    if (lblBoleto) lblBoleto.classList.remove("ativo");

    atualizarResumoTotal(valor);

    if (valor === "cartao") {
      if (painelCartao) painelCartao.style.display = "block";
      if (lblCartao) lblCartao.classList.add("ativo");
      alternarCamposCartao(true);
    } else if (valor === "pix") {
      if (painelPix) painelPix.style.display = "block";
      if (lblPix) lblPix.classList.add("ativo");
      alternarCamposCartao(false);
      inicializarPix();
    } else if (valor === "boleto") {
      if (painelBoleto) painelBoleto.style.display = "block";
      if (lblBoleto) lblBoleto.classList.add("ativo");
      alternarCamposCartao(false);
    }
  }

  radiosMetodo.forEach((radio) => {
    radio.addEventListener("change", function () {
      alternarMetodo(this.value);
    });
  });

  if (btnCopyPix && pixKeyInput) {
    btnCopyPix.addEventListener("click", function (e) {
      e.stopPropagation();
      pixKeyInput.select();
      pixKeyInput.setSelectionRange(0, 99999);

      if (navigator.clipboard && window.isSecureContext) {
        navigator.clipboard.writeText(pixKeyInput.value);
      } else {
        document.execCommand("copy");
      }

      if (copyFeedback) {
        copyFeedback.style.display = "block";
        setTimeout(() => {
          copyFeedback.style.display = "none";
        }, 3000);
      }

      btnCopyPix.innerText = "✅ Copiado!";
      setTimeout(() => {
        if (tempoRestante > 0) btnCopyPix.innerText = "📋 Copiar";
      }, 2000);
    });
  }

  // Máscaras dos campos de texto
  const inputCep = document.getElementById("cep");
  if (inputCep) {
    inputCep.addEventListener("input", function (e) {
      let v = e.target.value.replace(/\D/g, "");
      if (v.length > 5) v = v.substring(0, 5) + "-" + v.substring(5, 8);
      e.target.value = v;
    });
  }

  const inputCartao = document.getElementById("cartao_numero");
  if (inputCartao) {
    inputCartao.addEventListener("input", function (e) {
      let v = e.target.value.replace(/\D/g, "");
      v = v.replace(/(\d{4})(?=\d)/g, "$1 ");
      e.target.value = v.substring(0, 19);
    });
  }

  const inputValidade = document.getElementById("cartao_validade");
  if (inputValidade) {
    inputValidade.addEventListener("input", function (e) {
      let v = e.target.value.replace(/\D/g, "");
      if (v.length > 2) v = v.substring(0, 2) + "/" + v.substring(2, 4);
      e.target.value = v.substring(0, 5);
    });
  }

  const inputCvv = document.getElementById("cartao_cvv");
  if (inputCvv) {
    inputCvv.addEventListener("input", function (e) {
      e.target.value = e.target.value.replace(/\D/g, "").substring(0, 4);
    });
  }

  const radioInicial = document.querySelector('input[name="metodo_pagamento"]:checked');
  if (radioInicial) {
    alternarMetodo(radioInicial.value);
  }
});