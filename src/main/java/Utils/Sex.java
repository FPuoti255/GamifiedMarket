package Utils;

public enum Sex {

    MALE (0, "male"),
    FEMALE (1, "female"),
    OTHER (2, "other");

    private final int num;
    private final String name;

    Sex(int i, String name) {
        this.num = i;
        this.name = name;
    }

    public int getNum() {
        return num;
    }

    public String getName() {
        return name;
    }

    public static Sex parseName (String sex) throws IllegalArgumentException {
        switch (sex.toLowerCase()){
            case "male" :
                return MALE;
            case "female" :
                return FEMALE;
            case "other" :
                return OTHER;
            default:
                throw new IllegalArgumentException();
        }
    }

    public static Sex parseInt (int sex) throws IllegalArgumentException {
        switch (sex){
            case 0 :
                return MALE;
            case 1 :
                return FEMALE;
            case 2 :
                return OTHER;
            default:
                throw new IllegalArgumentException();
        }
    }


}
