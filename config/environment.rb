# User Constants
LOGIN = "LOGIN"
LOGOUT = "LOGOUT"

# Encounter Constants
LOAD_ENCOUNTERS = "LOAD_ENCOUNTERS"
ADD_ENCOUNTER = "ADD_ENCOUNTER"
UPDATE_ENCOUNTER = "UPDATE_ENCOUNTER"
DELETE_ENCOUNTER = "DELETE_ENCOUNTER"

# Creature Constants
LOAD_CREATURES = "LOAD_CREATURES"
UPDATE_CREATURE = "UPDATE_CREATURE"

# Character Constants
LOAD_CHARACTERS = "LOAD_CHARACTERS"
ADD_CHARACTER = "ADD_CHARACTER"
UPDATE_CHARACTER = "UPDATE_CHARACTER"

# Campaign Constants
LOAD_CAMPAIGNS = "LOAD_CAMPAIGNS"
ADD_CAMPAIGN = "ADD_CAMPAIGN"
UPDATE_CAMPAIGN = "UPDATE_CAMPAIGN"
DELETE_CAMPAIGN = "DELETE_CAMPAIGN"

# Message Constants
LOAD_MESSAGES = "LOAD_MESSAGES"
ADD_MESSAGE = "ADD_MESSAGE"
UPDATE_MESSAGE = "UPDATE_MESSAGE"
DELETE_MESSAGE = "DELETE_MESSAGE"

# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.initialize!
