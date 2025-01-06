package venteLubrifiant;

import vente.VenteDetails;

public class PrelevementLubLib extends PrelevementLub{
    VenteDetails[] venteDetails;

    public PrelevementLub[] convertToPrelevementLubs(){
        PrelevementLub[] prelevements = new PrelevementLub[getVenteDetails().length];
        for(int i = 0; i < getVenteDetails().length; i++){
            PrelevementLub temp = convertToPrelevementLub();
            temp.setIdProduit(getVenteDetails()[i].getIdProduit());
            temp.setQte(getVenteDetails()[i].getQte());
            temp.setPu(getVenteDetails()[i].getPu());
            prelevements[i] = temp;
        }
        return prelevements;
    }

    public PrelevementLub convertToPrelevementLub(){
        PrelevementLub prelevement = new PrelevementLub();
        prelevement.setIdPompiste(getIdPompiste());
        prelevement.setIdMagasin(getIdMagasin());
        prelevement.setDaty(getDaty());
        prelevement.setHeure(getHeure());
        return prelevement;
    }

    public VenteDetails[] getVenteDetails() {
        return this.venteDetails;
    }

    public void setVenteDetails(VenteDetails[] venteDetails) {
        this.venteDetails = venteDetails;
    }

}
