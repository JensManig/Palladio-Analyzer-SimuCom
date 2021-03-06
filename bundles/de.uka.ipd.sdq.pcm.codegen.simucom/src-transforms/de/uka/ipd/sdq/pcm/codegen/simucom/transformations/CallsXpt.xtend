package de.uka.ipd.sdq.pcm.codegen.simucom.transformations

import com.google.inject.Inject
import org.palladiosimulator.pcm.core.entity.Entity
import org.palladiosimulator.pcm.parameter.VariableUsage
import org.palladiosimulator.pcm.repository.InfrastructureSignature
import org.palladiosimulator.pcm.repository.OperationSignature
import org.palladiosimulator.pcm.seff.seff_performance.InfrastructureCall
import java.util.List

abstract class CallsXpt {
	@Inject extension JavaNamesExt
	@Inject extension JavaCoreXpt

	//-----------------------------------
	// Templates for the call to an external method
	// An instance of a port can be passed as prefix
	// The list of parameter usages characterises the paramter contents
	// ----------------------------------
	def CharSequence call(OperationSignature signature, Entity call, String prefix, List<VariableUsage> parameterUsages,
		List<VariableUsage> outParameterUsages) '''
		«signature.preCallTM(call, prefix, parameterUsages)»
		«prefix»«signature.javaSignature»
			(«signature.parameterUsageListTM»);
		«signature.postCallTM(call, prefix, outParameterUsages)»
	'''

	def CharSequence call(InfrastructureCall infraCall, Entity call) '''
			{ //CALL SCOPE: this scope is needed if the same service is called multiple times in one SEFF. Otherwise there is a duplicate local variable definition.
		   long numberOfCalls = ctx.evaluate("«infraCall.numberOfCalls__InfrastructureCall.specification.specificationString»",Double.class).longValue();
			for (long callNumber = 0; callNumber < numberOfCalls; callNumber++) {
			«val prefix = "myContext.getRole" + infraCall.requiredRole__InfrastructureCall.javaName + "()."»
			«infraCall.signature__InfrastructureCall.preCallTM(call, prefix, infraCall.inputVariableUsages__CallAction)»
			  	«prefix»«infraCall.signature__InfrastructureCall.javaSignature»
			  		(«infraCall.signature__InfrastructureCall.parameterUsageListTM»);
			«infraCall.signature__InfrastructureCall.postCallTM(call, prefix)»
			}
		} // END CALL SCOPE
	'''

	// ----------------------------------
	// Template method for code to be executed before
	// an external call
	// ----------------------------------
	def CharSequence preCallTM(OperationSignature signature, Entity call, String prefix,
		List<VariableUsage> parameterUsages)

	def CharSequence preCallTM(InfrastructureSignature signature, Entity call, String prefix,
		List<VariableUsage> parameterUsages)

	// ----------------------------------
	// Template method for code to be executed after
	// an external call
	// ----------------------------------
	def CharSequence postCallTM(OperationSignature signature, Entity call, String prefix,
		List<VariableUsage> outParameterUsages)

	def CharSequence postCallTM(InfrastructureSignature signature, Entity call, String prefix)
}
