import java.util.ArrayList;

import static java.lang.Math.pow;

public class MemoryFiller {
    private static final Runtime runtime = Runtime.getRuntime();

    public static void main(String[] args) {
        printTotalMemory();
        ArrayList<long[]> list = new ArrayList<>();
        int size = Double.valueOf(pow(2, 20)).intValue();
        while (true) {
            list.add(new long[size]);
            printFreeMemory();
        }
    }

    private static String formatPrintMemory(long memory) {
        int divisor = Double.valueOf(pow(1024, 3)).intValue();
        int gigabytes = (int) (memory / divisor);
        memory = memory % divisor;
        divisor = Double.valueOf(pow(1024, 2)).intValue();
        int megabytes = (int) (memory / divisor);
        memory = memory % divisor;
        divisor = 1024;
        int kilobytes = (int) (memory / divisor);
        int bytes = (int) (memory % divisor);
        StringBuilder formattedMemory = new StringBuilder();
        if (gigabytes != 0) {
            formattedMemory.append(gigabytes + " GB ");
        }
        if (megabytes != 0) {
            formattedMemory.append(megabytes + " MB ");
        }
        if (kilobytes != 0) {
            formattedMemory.append(kilobytes + " KB ");
        }
        if (bytes != 0) {
            formattedMemory.append(bytes + " B");
        }
        return formattedMemory.toString();
    }

    private static void printMemory(String text, long memory) {
        System.out.println(text + formatPrintMemory(memory));
    }

    private static void printTotalMemory() {
        printMemory("Total Memory: ", runtime.totalMemory());
    }

    private static void printFreeMemory() {
        printMemory("Free Memory: ", runtime.freeMemory());
    }
}
