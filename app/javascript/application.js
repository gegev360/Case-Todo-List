// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

// Configurar listeners quando o documento estiver pronto
document.addEventListener('turbo:load', function() {
  setupTaskToggleButtons();
  observeDOM();
});

// Observar mudanças no DOM para detectar novos botões
function observeDOM() {
  const targetNode = document.body;
  const config = { childList: true, subtree: true };
  
  const observer = new MutationObserver(function(mutations) {
    mutations.forEach(function(mutation) {
      if (mutation.type === 'childList' && mutation.addedNodes.length > 0) {
        setupTaskToggleButtons();
      }
    });
  });
  
  observer.observe(targetNode, config);
}

function setupTaskToggleButtons() {
  document.querySelectorAll('.task-toggle').forEach(button => {
    // Remover listeners anteriores para evitar duplicação
    button.removeEventListener('mouseenter', showHoverState);
    button.removeEventListener('mouseleave', showNormalState);
    
    // Adicionar novos listeners
    button.addEventListener('mouseenter', showHoverState);
    button.addEventListener('mouseleave', showNormalState);
  });
}

function showHoverState() {
  const normalState = this.querySelector('.normal-state');
  const hoverState = this.querySelector('.hover-state');
  
  if (normalState && hoverState) {
    normalState.style.display = 'none';
    hoverState.style.display = 'inline';
  }
}

function showNormalState() {
  const normalState = this.querySelector('.normal-state');
  const hoverState = this.querySelector('.hover-state');
  
  if (normalState && hoverState) {
    normalState.style.display = 'inline';
    hoverState.style.display = 'none';
  }
}
