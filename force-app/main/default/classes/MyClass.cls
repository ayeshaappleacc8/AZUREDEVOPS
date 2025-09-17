public class MyClass {
    public static Integer addNumbers(Integer a, Integer b) {
        if (a == null || b == null) return 0;
        return a + b;
    }

    public static Boolean isPositive(Integer num) {
        return num != null && num > 0;
    }
}
