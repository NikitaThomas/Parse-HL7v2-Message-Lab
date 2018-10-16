"""You will need to implement two key functions in this file, parse_hl7() and
save(). You can implement any other helper functions you like, however
make sure that when this module is imported it does not execute any code.
"""


def parse_hl7(hl7_msg=None):
    """Parses an HL7 message into a JSON-LD document suitable for persisting
    into MongoDB.

    Parameters
    ----------
    hl7_msg : str
        A string containing the HL7 message to be parsed.

    Returns
    -------
    list, tuple
        An iterable of Python dictionaries, where the first item in the iterable
        is the Patient resource and the second is the Observation resource from
        the HL7 message.
    """
    pass


def save(data, db_name="encounters", port=27017):
    """Saves the data to MongoDB at the specified port and database.

    If the "resourceType" of the data is HL7's "Patient" then the data should
    be saved to the MongoDB collection called "patients" (all lowercase). If the
    "resourceType" is "Observation" then the data should be saved to the
    "observations" collection.

    Parameters
    ----------
    data : dict, list
        A dictionary or a list of dictionaries where each dictionary is to be
        saved into MongoDB. Dictionaries should represent a FHIR resource.
    db_name: str
        The name of the MongoDB database to save data to. DO NOT change the
        default value.
    port : int
        The port at which MongoDB is listening. Defaults to 27017, MongoDB's
        default port. Again, DO NOT change the default value.

    Returns
    -------
    list
        A list containing the ObjectID's of the document(s) that were saved.
    """
    pass
