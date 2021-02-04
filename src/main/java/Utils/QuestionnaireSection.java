package Utils;

public enum QuestionnaireSection {
    MARKETING (0,"marketing"),
    STATISTICAL (1, "statistical");

    private final int num;
    private final String name;

    QuestionnaireSection(int i, String name) {
        this.num = i;
        this.name = name;
    }

    public int getNum() {
        return num;
    }

    public String getName() {
        return name;
    }

    public static QuestionnaireSection parseName (String section) throws IllegalArgumentException {
        switch (section.toLowerCase()){
            case "marketing" :
                return MARKETING;
            case "statistical" :
                return STATISTICAL;
            default:
                throw new IllegalArgumentException();
        }
    }

    public static QuestionnaireSection parseInt (int num) throws IllegalArgumentException {
        switch (num) {
            case 0:
                return MARKETING;
            case 1:
                return STATISTICAL;
            default:
                throw new IllegalArgumentException();
        }
    }
}
