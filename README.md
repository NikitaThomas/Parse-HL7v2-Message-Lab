# Parse-HL7v2-Message-Lab

## The hypothetical scenario:

You are part of a team tasked with building an analytics system for a new
set of data. Luckily, you are able to leverage the infrastructure of
a previous project. So, for this project, all you you need to do is
write 2 functions to replace the key data organization functionality.
The first function will be given an HL7 string and will return an R
data structure. The second function will take the R data structure
and save it as a JSON document. 

Your task can be broken down as follows:

1. **Receive and parse HL7 messages**

   You will be writing a function called `parse_hl7()` that will take
   a single string as an input parameter. This string represents
   a single, complete HL7 message. You will need to extract the relevant
   fields from the HL7 message and store these data in an R data
   structure.  

   Your `parse_hl7()` function will return an R data.frame that
   can be sent out to the FHIR/JSON document. This dictionary will be
   passed to your next function for persistence to a JSON document.

2. **Process and structure the data with UMLS concepts and JSON-LD**

   Based on the documentation provided as part of the exercise, you will
   be choosing the appropriate terminology and codes to use when
   translating the data from the HL7 message. For example, one of the
   fields within the HL7 message may be a CBC lab test as described in the
   documentation.

   Every HL7 message you process will be an ORU R01 message containing
   a PID segment identifying the patient, an OBR segment identifying the
   test being ordered, and an OBX segment identifying the result. This
   data is taken from a real dataset that has been de-identified and
   reflects the original data including those test results that are not
   backed by LOINC codes.

   As such, you will not have to worry about matching up concepts from
   BioPortal or any other terminologies - everything is either matched to
   LOINC or not matched to anything.
