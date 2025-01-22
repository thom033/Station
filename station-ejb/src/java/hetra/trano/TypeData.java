package hetra.trano;

import bean.CGenUtil;

public class TypeData {
    TypeRindrina[] typeRindrinaList;
    TypeTafo[] typeTafoList;

    public TypeData() throws Exception {

        this.typeRindrinaList = (TypeRindrina[]) CGenUtil.rechercher(new TypeRindrina(), null, null, "");
        this.typeTafoList = (TypeTafo[]) CGenUtil.rechercher(new TypeTafo(), null, null, "");
    }
}