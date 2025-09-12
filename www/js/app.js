document.addEventListener('deviceready', onDeviceReady, false);

// Variáveis globais para controle de tela cheia e som
let isFullScreen = false;
let beepSound = null;

function onDeviceReady() {
    // Cordova está pronto e podemos usar recursos específicos da plataforma
    console.log('Cordova inicializado');
    
    // Inicializar o som de beep
    if (window.Media) {
        beepSound = new Media('/android_asset/www/sounds/beep.mp3',
            function() { console.log("Som de beep reproduzido com sucesso"); },
            function(err) { console.log("Erro ao reproduzir som de beep: " + err); }
        );
        // Reproduzir som ao iniciar o app
        playBeepSound();
    } else {
        console.log("Plugin de Media não disponível para som");
    }

    // Desativar o botão voltar do Android para evitar sair do aplicativo
    document.addEventListener('backbutton', function(e) {      
        e.preventDefault();
        return false;
    }, false);
    
    // Adicionar botões de controle ao player
    setupPlayerControls();
}

// Função para reproduzir o som de beep
function playBeepSound() {
    if (beepSound) {
        beepSound.play();
    }
}

// Função para alternar entre tela cheia e normal
function toggleFullScreen() {
    if (isFullScreen) {
        // Sair da tela cheia
        if (document.exitFullscreen) {
            document.exitFullscreen();
        } else if (document.webkitExitFullscreen) {
            document.webkitExitFullscreen();
        } else if (document.mozCancelFullScreen) {
            document.mozCancelFullScreen();
        } else if (document.msExitFullscreen) {
            document.msExitFullscreen();
        }
    } else {
        // Entrar em tela cheia
        const videoContainer = document.querySelector('.fp-player') || document.body;
        if (videoContainer.requestFullscreen) {
            videoContainer.requestFullscreen();
        } else if (videoContainer.webkitRequestFullscreen) {
            videoContainer.webkitRequestFullscreen();
        } else if (videoContainer.mozRequestFullScreen) {
            videoContainer.mozRequestFullScreen();
        } else if (videoContainer.msRequestFullscreen) {
            videoContainer.msRequestFullscreen();
        }
    }
    
    isFullScreen = !isFullScreen;
}

// Função para iniciar transmissão para Chromecast
function startCasting() {
    if (window.chrome && window.chrome.cast && window.chrome.cast.isAvailable) {
        console.log("Iniciando transmissão para Chromecast");
        // Implementação da API do Chromecast
        const sessionRequest = new chrome.cast.SessionRequest(chrome.cast.media.DEFAULT_MEDIA_RECEIVER_APP_ID);
        const apiConfig = new chrome.cast.ApiConfig(sessionRequest,
            sessionListener,
            receiverListener);
        chrome.cast.initialize(apiConfig, onInitSuccess, onError);
    } else {
        alert("Chromecast não disponível neste dispositivo");
    }
}

// Funções de callback para o Chromecast
function sessionListener(e) {
    console.log("Sessão Chromecast iniciada");
}

function receiverListener(e) {
    if (e === chrome.cast.ReceiverAvailability.AVAILABLE) {
        console.log("Receptores Chromecast disponíveis");
    }
}

function onInitSuccess() {
    console.log("Inicialização do Chromecast bem-sucedida");
}

function onError(e) {
    console.log("Erro na inicialização do Chromecast: " + e);
}

// Configurar controles do player
function setupPlayerControls() {
    // Aguardar a inicialização do player
    document.addEventListener('DOMContentLoaded', function() {
        // Verificar se o flowplayer está disponível
        if (window.flowplayer) {
            // Adicionar botões personalizados após a inicialização do player
            flowplayer(function(api) {
                api.on('ready', function() {
                    // Adicionar botão de tela cheia
                    const fullscreenBtn = document.createElement('button');
                    fullscreenBtn.className = 'fp-controls-button fullscreen-button';
                    fullscreenBtn.innerHTML = '<i class="bx bx-fullscreen"></i>';
                    fullscreenBtn.title = 'Tela Cheia';
                    fullscreenBtn.onclick = toggleFullScreen;
                    
                    // Adicionar botão de Chromecast
                    const castBtn = document.createElement('button');
                    castBtn.className = 'fp-controls-button cast-button';
                    castBtn.innerHTML = '<i class="bx bx-cast"></i>';
                    castBtn.title = 'Transmitir para TV';
                    castBtn.onclick = startCasting;
                    
                    // Adicionar botões à barra de controles
                    const controlBar = document.querySelector('.fp-controls');
                    if (controlBar) {
                        controlBar.appendChild(fullscreenBtn);
                        controlBar.appendChild(castBtn);
                    }
                });
            });
        }
    });
}
