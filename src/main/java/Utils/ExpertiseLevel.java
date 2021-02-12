package Utils;

public enum ExpertiseLevel {
    LOW (0, "low"),
    MEDIUM (1, "medium"),
    HIGH (2, "high");

    private final int num;
    private final String name;

    ExpertiseLevel(int i, String name) {
        this.num = i;
        this.name = name;
    }

    public int getNum() {
        return num;
    }

    public String getName() {
        return name;
    }

    public static ExpertiseLevel parseName (String exp) throws IllegalArgumentException {
        switch (exp.toLowerCase()){
            case "low" :
                return LOW;
            case "medium" :
                return MEDIUM;
            case "high" :
                return HIGH;
            default:
                throw new IllegalArgumentException();
        }
    }

    public static ExpertiseLevel parseInt (int exp) throws IllegalArgumentException {
        switch (exp){
            case 0 :
                return LOW;
            case 1 :
                return MEDIUM;
            case 2 :
                return HIGH;
            default:
                throw new IllegalArgumentException();
        }
    }
}
