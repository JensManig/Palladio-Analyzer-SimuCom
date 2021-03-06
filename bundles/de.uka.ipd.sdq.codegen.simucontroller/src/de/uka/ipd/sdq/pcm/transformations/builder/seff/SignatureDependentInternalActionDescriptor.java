package de.uka.ipd.sdq.pcm.transformations.builder.seff;

import org.palladiosimulator.pcm.repository.Signature;
import org.palladiosimulator.pcm.resourcetype.ResourceType;

public abstract class SignatureDependentInternalActionDescriptor extends AbstractInternalActionDescriptor implements
        ISignatureDependentAction {

    protected Signature currentSignature;

    public SignatureDependentInternalActionDescriptor(ResourceType resourceType) {
        super(resourceType);
    }

    /*
     * (non-Javadoc)
     * 
     * @see
     * de.uka.sdq.pcm.transformations.builder.seff.ISignatureDependentAction#setCurrentSignature
     * (org.palladiosimulator.pcm.repository.Signature)
     */
    public void setCurrentSignature(Signature sig) {
        this.currentSignature = sig;
    }

    @Override
    public String getResourceDemand() {
        return getDemand(currentSignature);
    }

    protected abstract String getDemand(Signature signature);
}
