package slifer;

class IdGenerator {
    private static var nextId: Int = 0;

    public static inline function next(): Int {
        return nextId++;
    }
}