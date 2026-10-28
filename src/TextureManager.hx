package;

import sys.io.FileSeek;
import raylib.Raylib.*;
import raylib.Types.TextureImpl;
import haxe.ds.StringMap;
import haxe.io.Path;
import sys.FileSystem;

class TextureManager {
    public static var textures: StringMap<TextureImpl> = new StringMap();
    private static var artPath = "resources/art";

    public static function load() {
        readDirectory(artPath);
    }

    private static function readDirectory(path: String) {
        if (!FileSystem.exists(path)) return;

        for (item in FileSystem.readDirectory(path)) {
            var fullPath = Path.join([artPath, item]);

            if (FileSystem.isDirectory(fullPath)) {
                readDirectory(fullPath);
            } else {
                var texture = LoadTexture(fullPath);
                textures.set(item, texture);
            }
        }
    }

    public static function close() {
        for (item in textures) {
            UnloadTexture(item);
        }
    }

}