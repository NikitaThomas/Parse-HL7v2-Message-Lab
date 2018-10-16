require(jsonlite)

parse_hl7 <- function(hl7_msg) {
  # Parses an HL7 message into a JSON-LD document.
  #
  # Args
  # hl7_msg: Filepath to an HL7 message string to be parsed.
  #
  # Returns
  # A list where the first item is the Patient resource and the second is the
  # Observation resource from the HL7 message.
  extract_fields(hl7_msg)
  patient_obj <- list("resourceType" = unbox("Patient"), 
                      "identifier" = data.frame(list("use" = unbox("usual"), "label" = unbox("MRN"),
                                          "system" = unbox("urn:oid:2.16.840.1.113883.19.5"), "value" = unbox(as.character(df_patient[1,1])))),
                      "gender" =  list("coding" = data.frame(list("system" = unbox("http://hl7.org/fhir/v3/AdministrativeGender"), "code" = unbox(as.character(df_patient[1,2]))))), 
                      "birthDate" = unbox(as.character(df_patient[1,3])),
                      "managingOrganization"= list("reference" = unbox("Organization/2.16.840.1.113883.19.5"), "display" = unbox("MIMIC2")))
  
  observation_obj <- list( "resourceType" = unbox("Observation"),
                           "name" = list("coding" = data.frame(list("system" = unbox("http://loinc.org"), "code" = unbox(as.character(df_observation[1,1])), "display" = unbox(as.character(df_observation[1,2]))))),
                           "valueQyantity" = list("value" = unbox(as.character(df_observation[1,3]))),
                           "issued" = unbox("2013-04-03T15:30:10+01:00"),
                           "status" = unbox("final"),
                           "subject" = list("reference" = unbox(paste("Patient", df_observation[1,4], sep = "/")), "display" = unbox("P. van de Heuvel")))
  
  patient<- toJSON(patient_obj,pretty = TRUE)
  observation<- toJSON(observation_obj, pretty = TRUE)
  print("PATIENT")
  print(patient)
  print("OBSERVATION")
  print(observation)
}

extract_fields <- function(hl7_msg){
  filepath<- hl7_msg
  lines <- readLines(filepath)
  for (line in lines){
    if(substr(line,1,3) == "PID"){
      MRN <- strsplit(strsplit(line, "|", fixed = TRUE)[[1]][4], "^", fixed = TRUE)[[1]][1]
      DOB <- strsplit(strsplit(line, "|", fixed = TRUE)[[1]][8], "^", fixed = TRUE)[[1]][1]
      SEX <- strsplit(strsplit(line, "|", fixed = TRUE)[[1]][9], "^", fixed = TRUE)[[1]][1]
    }
    else if(substr(line,1,3) == 'OBX'){
      Value <- strsplit(strsplit(line, "|", fixed = TRUE)[[1]][6], "^", fixed = TRUE)[[1]][1]
      LOINC <- strsplit(strsplit(line, "|", fixed = TRUE)[[1]][4], "^", fixed = TRUE)[[1]][1]
    }
    else if(substr(line,1,3) == 'OBR'){
      Text <- strsplit(strsplit(line, "|", fixed = TRUE)[[1]][5], "^", fixed = TRUE)[[1]][2]
    }
  }
  DOB <- gsub("(\\d{4})(\\d{2})(\\d{2})$","\\1-\\2-\\3",DOB)
  df_patient<<- data.frame(MRN,SEX,DOB)
  df_observation<<- data.frame(LOINC,Text,Value, MRN)
}

#Test
sample1<- "~/Desktop/HS_611/hs611-labs/NikitaThomas-lab-hl7-r/samples/1.txt"
parse_hl7(sample1)

#Main
main<- function(){
  file_path<- 
  json_obj<- parse_hl7(file_path)
  write_json(json_obj[["patient"]], "patient.json")
  write_json(json_obj[["observation"]], "observation.json")
}
main()
