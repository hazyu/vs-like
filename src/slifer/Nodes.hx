package slifer;

import haxe.ds.IntMap;
import raylib.Raylib.*;
import raylib.Types;
import slifer.IdGenerator;

class Node {
    public var id: Int = 0;
    public var parent: Node = null;
    public var visible = true;
    public var zIndex = 0;
    public var children: IntMap<Node> = new IntMap();

    public var position: Vector2 = new Vector2(0, 0);
    public var rotation: Float = 0;
    
    public var world_position: Vector2 = new Vector2(0, 0);
    public var world_rotation: Float = 0;
    private var remove_queue: List<Int> = new List();

    private function updateTransform() {
        if (this.parent == null) return;

        var pCos = Math.cos(this.parent.world_rotation);
        var pSin = Math.sin(this.parent.world_rotation);

        var rx = this.position.x * pCos - this.position.y * pSin;
        var ry = this.position.x * pSin + this.position.y * pCos;

        this.world_rotation = this.parent.world_rotation + this.rotation;
        this.world_position.x = this.world_position.x + rx;
        this.world_position.y = this.world_position.y + ry;

        if (this.zIndex == 0) {
            if (this.parent.zIndex != 0) {
                this.zIndex = this.parent.zIndex;
            }
        }
    }

    private function clearAllChildren() {
        for (child in this.children) {
            child.parent = null;
            child.clearAllChildren();
        }
    }

    public function new(x: Float, y: Float) {
        this.id = IdGenerator.next();
        this.position = new Vector2(x, y);
    }

    public function update() {
        if (!this.visible) return;

        while (this.remove_queue.length > 0) {
            var targetId = this.remove_queue.pop();
            if (this.children.exists(targetId)) {
                var target = this.children.get(targetId);
                this.children.remove(targetId);

                if (target != null ){
                    target.parent = null;
                    target.clearAllChildren();
                }
            }
        }

        this.updateTransform();

        var childrenSnapshot: Array<Dynamic> = [ for (child in this.children) child];

        for (child in childrenSnapshot) {
            if (child != null && child.parent == this) {
                child.update();
            }
        }
    }

    public function draw() {
        return;
    }

    public function collectInRenderQueue(renderQueue: Array<Node>) {
        if (!this.visible) return;

        renderQueue.push(this);

        for (child in this.children) {
            child.collectInRenderQueue(renderQueue);
        }
    }
}