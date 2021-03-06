package de.uka.ipd.sdq.pcm.transformations.builder.seff;

import java.util.Collection;

import org.palladiosimulator.pcm.parameter.VariableUsage;
import org.palladiosimulator.pcm.repository.OperationRequiredRole;
import org.palladiosimulator.pcm.repository.OperationSignature;

public abstract class SignatureDependentExternalCallActionDescriptor extends ExternalCallActionDescriptor implements
        ISignatureDependentAction {

    private OperationSignature currentSignature;

    public SignatureDependentExternalCallActionDescriptor(OperationSignature sig, OperationRequiredRole role) {
        super(sig, role, null, null);
    }

    @Override
    protected Collection<VariableUsage> getInputParameter() {
        return getSignatureDependentInputParameter(this.currentSignature);
    }

    @Override
    protected Collection<VariableUsage> getOutputParameter() {
        return getSignatureDependentOutputParameter(currentSignature);
    }

    protected abstract Collection<VariableUsage> getSignatureDependentInputParameter(OperationSignature currentSignature);

    protected abstract Collection<VariableUsage> getSignatureDependentOutputParameter(
            OperationSignature currentSignature);

    public void setCurrentSignature(OperationSignature sig) {
        this.currentSignature = sig;
    }
}
