package entity;

public class Personne {
	
	private String nom;
	private String login;
	private String mdp;
	
	public Personne(){}
	
	public Personne(String nom, String login, String mdp) {
		this.nom = nom;
		this.login = login;
		this.mdp = mdp;
	}
	
	public String getNom() {
		return this.nom;
	}
	
	public void setNom(String nom) {
		this.nom = nom;
	}
	
	public String getLogin() {
		return this.login;
	}
	
	public void setLogin(String login) {
		this.login = login;
	}
	
	public String getMdp() {
		return this.mdp;
	}
	
	public void setMdp(String Mdp) {
		this.mdp = mdp;
	}
}
