# ShowPhotoForBaby

Aplicativo de educação infantil para capturar e visualizar fotos associadas a nomes, estimulando a associação visual e o vocabulário das crianças.

## Características

| Recurso | Descrição |
|--------|-----------|
| **Bater foto** | Captura fotos pela câmera ou seleciona do álbum; associa um nome a cada foto e salva localmente |
| **Ver fotos** | Visualização em tela cheia com swipe horizontal, no estilo de virar página de livro |
| **Interface infantil** | Botões grandes e arredondados, ideal para uso por crianças pequenas |
| **Persistência** | Fotos e nomes salvos na memória do dispositivo |

## Fluxo de uso

1. **Tela inicial** — Dois botões: "Bater foto" e "Ver fotos"
2. **Bater foto** — Escolha câmera ou álbum → tire ou selecione a foto → digite o nome → salve
3. **Ver fotos** — Abre o visualizador em full-screen; nome no canto inferior; swipe para trocar de foto; X vermelho no canto superior esquerdo para voltar

## Requisitos

- iOS 16+
- Xcode 15+
- iPhone ou iPad

## Como executar

1. Clone o repositório
2. Abra `ShowPhotoForBaby.xcodeproj` no Xcode
3. Selecione um simulador ou dispositivo físico
4. Pressione **Run** (⌘R)

## Estrutura do projeto

```
ShowPhotoForBaby/
├── ContentView.swift       # Tela inicial com botões
├── TakePhotoFlowView.swift # Fluxo de captura e associação de nome
├── ViewPhotosView.swift    # Visualizador full-screen com swipe
├── CameraPickerView.swift  # Wrapper da câmera (UIKit)
├── ImageStorage.swift      # Salvar/carregar imagens no dispositivo
├── Item.swift              # Modelo PhotoItem (SwiftData)
└── Assets.xcassets/        # App icon e cores
```

## Tecnologias

- **SwiftUI** — Interface declarativa
- **SwiftData** — Persistência de dados (associação foto ↔ nome)
- **PhotosUI** — Seleção de fotos do álbum
- **UIKit** — Acesso à câmera nativa

## Licença

Projeto pessoal — uso livre.
