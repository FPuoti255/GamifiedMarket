package entities;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "swears")
public class Swears {
    private String swearText;

    public Swears() {
    }

    @Id
    @Column(name = "swear_text", nullable = false, length = 64)
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

        Swears swears = (Swears) o;

        if (swearText != null ? !swearText.equals(swears.swearText) : swears.swearText != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        return swearText != null ? swearText.hashCode() : 0;
    }
}
