package Utils;

public enum UserAction {
    SUBMITTED (0,"submitted"),
    CANCELLED (1, "cancelled"),
    LOGIN (2, "login"),
    LOGOUT (3, "logout"),
    LEAVE_REVIEW (4, "leave_review"),
    BANNED (5, "banned"),
    PREVIOUS (6, "previous");

    private final int num;
    private final String name;

    UserAction(int i, String name) {
        this.num = i;
        this.name = name;
    }

    public int getNum() {
        return num;
    }

    public String getName() {
        return name;
    }

    public static UserAction parseName (String action) throws IllegalArgumentException {
        if(action == null ) return null;

        switch (action.toLowerCase()){
            case "submitted" :
                return SUBMITTED;
            case "cancelled" :
                return CANCELLED;
            case "login" :
                return LOGIN;
            case "logout" :
                return LOGOUT;
            case "leave_review" :
                return LEAVE_REVIEW;
            case "banned" :
                return BANNED;
            case "previous" :
                return PREVIOUS;
            default:
                throw new IllegalArgumentException();
        }
    }

    public static UserAction parseInt (int action) throws IllegalArgumentException {
        switch (action){
            case 0 :
                return SUBMITTED;
            case 1 :
                return CANCELLED;
            case 2 :
                return LOGIN;
            case 3 :
                return LOGOUT;
            case 4 :
                return LEAVE_REVIEW;
            case 5 :
                return BANNED;
            case 6 :
                return PREVIOUS;
            default:
                throw new IllegalArgumentException();
        }
    }


}
