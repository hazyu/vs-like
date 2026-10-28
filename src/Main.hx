package;

import raylib.Raylib.*;
import raylib.Types;
import slifer.Nodes;

class Main {
    public static function main() {
        InitWindow(1280, 720, "Game");
        InitAudioDevice();

        TextureManager.load();

        var root = new Node(0, 0);

        while (!WindowShouldClose()) {
            root.update();

            BeginDrawing();
            ClearBackground(RAYWHITE);

            var renderQueue = new Array<Node>();
            root.collectInRenderQueue(renderQueue);

            renderQueue.sort((a, b) -> a.zIndex - b.zIndex);

            for (node in renderQueue) {
                node.draw();
            }


            EndDrawing();
        }

        TextureManager.close();
        CloseWindow();
    }
}