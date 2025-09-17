@IsTest
private class MyClassTest {

    @IsTest
    static void testAddNumbers() {
        System.assertEquals(12, MyClass.addNumbers(5, 7));
        System.assertEquals(0, MyClass.addNumbers(null, 10));
    }

    @IsTest
    static void testIsPositive() {
        System.assertEquals(true, MyClass.isPositive(5));
        System.assertEquals(false, MyClass.isPositive(-3));
        System.assertEquals(false, MyClass.isPositive(null));
    }
}
