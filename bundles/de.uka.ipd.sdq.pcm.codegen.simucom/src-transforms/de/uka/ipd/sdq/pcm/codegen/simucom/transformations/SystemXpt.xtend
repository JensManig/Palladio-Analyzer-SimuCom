package de.uka.ipd.sdq.pcm.codegen.simucom.transformations

import com.google.inject.Inject
import de.uka.ipd.sdq.pcm.codegen.simucom.helper.M2TFileSystemAccess
import org.palladiosimulator.pcm.system.System

class SystemXpt {
	@Inject M2TFileSystemAccess fsa
	
	@Inject extension JavaNamesExt
	@Inject extension CompletionsXpt
	@Inject extension ComposedStructureXpt
	@Inject extension ProvidedPortsXpt
	@Inject extension ContextPatternXpt

	def void root(System s) {
		s.expandCompletions
		
		val fileName = s.fileName
		val fileContent = s.system
		
		fsa.generateFile(fileName, fileContent)
	}
	
	def system(System s) '''
		«s.composedStructureStart»
		«s.providedPorts»
		«s.requiredInterfaces»
		«s.systemInnerAdditionsTM»
		«s.composedStructureEnd»
		«s.systemAdditionsTM»
	'''
	
	def systemInnerAdditionsTM(System s) ''''''
	def systemAdditionsTM(System s) ''''''
}