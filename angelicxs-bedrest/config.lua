Config = {}

Config.CommandName = 'bedrest'
Config.JobName = 'ambulance'

Config.Distance = 15 -- how far in GTA units they can be from spot
Config.Spot = vector4(1124.79, -1559.09, 35.03, 272.14) -- Where they will go

Config.MinTime = 0 -- Minimum time in minutes that they will be stuck in bed
Config.MaxTime = 10 -- Maximum time in minutes that they will be stuck in bed

Config.Lang = {
    ['wrong_job'] = 'You do not have the correct job for this!',
    ['bed_rest'] = 'Send Patient for Bed Rest',
    ['submit'] = 'Submit',
    ['time'] = 'Length of time (minutes)',
    ['zero_error'] = 'You must enter a number larger then 0.',
    ['no_player'] = 'That player is not online!',
    ['player_sent'] = 'Citizen has been sent to bed rest for',
    ['minutes'] = 'minutes!',
    ['bed_rest_player'] = 'You have been sent to bed rest for',
    ['cured'] = 'You feel great and your bed rest is over!',
    ['server_id'] = 'Please enter the player\'s server ID',
    ['bed_rest_3eye'] = 'Bed Rest',
    ['reset'] = 'You are on bed rest, you need to stay near the area!',
}