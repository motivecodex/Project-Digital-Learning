package models;

/**
 *
 * @author Shahin Mokhtar
 */
public class WorkForm {

    private String workId, fromMonth, fromYear, tillMonth, tillYear, name, profession, description;

    public WorkForm() {

    }

    public WorkForm(String workId, String fromMonth, String fromYear, String tillMonth, String tillYear,
            String profession, String description) {
        this.workId = workId;
        this.fromMonth = fromMonth;
        this.fromYear = fromYear;
        this.tillMonth = tillMonth;
        this.tillYear = tillYear;
        this.name = name;
        this.profession = profession;
        this.description = description;
    }

    /**
     * @return the workId
     */
    public String getWorkId() {
        return workId;
    }

    /**
     * @param workId the workId to set
     */
    public void setWorkId(String workId) {
        this.workId = workId;
    }

    /**
     * @return the fromMonth
     */
    public String getFromMonth() {
        return fromMonth;
    }

    /**
     * @param fromMonth the fromMonth to set
     */
    public void setFromMonth(String fromMonth) {
        this.fromMonth = fromMonth;
    }

    /**
     * @return the fromYear
     */
    public String getFromYear() {
        return fromYear;
    }

    /**
     * @param fromYear the fromYear to set
     */
    public void setFromYear(String fromYear) {
        this.fromYear = fromYear;
    }

    /**
     * @return the tillMonth
     */
    public String getTillMonth() {
        return tillMonth;
    }

    /**
     * @param tillMonth the tillMonth to set
     */
    public void setTillMonth(String tillMonth) {
        this.tillMonth = tillMonth;
    }

    /**
     * @return the tillYear
     */
    public String getTillYear() {
        return tillYear;
    }

    /**
     * @param tillYear the tillYear to set
     */
    public void setTillYear(String tillYear) {
        this.tillYear = tillYear;
    }

    /**
     * @return the name
     */
    public String getName() {
        return name;
    }

    /**
     * @param name the name to set
     */
    public void setName(String name) {
        this.name = name;
    }

    /**
     * @return the profession
     */
    public String getProfession() {
        return profession;
    }

    /**
     * @param profession the profession to set
     */
    public void setProfession(String profession) {
        this.profession = profession;
    }

    /**
     * @return the description
     */
    public String getDescription() {
        return description;
    }

    /**
     * @param description the description to set
     */
    public void setDescription(String description) {
        this.description = description;
    }

    
}