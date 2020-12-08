package dataSource;

@jakarta.persistence.Entity
@jakarta.persistence.Table(name = "swears", schema = "gamified_market" )
public class SwearsEntity {
    private String swearText;

    @jakarta.persistence.Id
    @jakarta.persistence.Column(name = "swear_text")
    public String getSwearText() {
        return swearText;
    }

    public void setSwearText(String swearText) {
        this.swearText = swearText;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        SwearsEntity that = (SwearsEntity) o;

        if (swearText != null ? !swearText.equals(that.swearText) : that.swearText != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        return swearText != null ? swearText.hashCode() : 0;
    }
}
