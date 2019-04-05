#include "Preferences/PSSpecifier.h"

@interface PSUIPrefsListController

@property (nonatomic, assign) BOOL performedActions;
-(id)specifiers;
-(void)reload;
-(void)substituteSpecifierNames;
@end

const PSSpecifier *appleAccountSpecifier = NULL;



%hook PSUIPrefsListController


%property (nonatomic, assign) BOOL performedActions;

-(void)substituteSpecifierNames
{

  NSMutableArray *specifiers = [self specifiers];
  // laod substitute strings from plist file
  // loading it from a file allows the tweak to use custom strings user puts in it

  // NSDictionary *substituteStrings = [NSDictionary dictionaryWithContentsOfFile:@"/Library/Application Support/DopeSettings/defaults.bundle/defaults.plist"];
  NSMutableDictionary *substituteStrings = [NSMutableDictionary dictionaryWithContentsOfFile:@"/private/var/mobile/Library/Preferences/xyz.xninja.dopesettings.plist"];
  if(!substituteStrings)
  {
    substituteStrings = [[NSMutableDictionary alloc] initWithDictionary:
    @{
      @"AIRPLANE_MODE" : @"No NSA mode",
      @"Bluetooth" : @"Are your teeth blue yet?",
      @"COMPASS" : @"Tells you true North!",
      @"CONTACTS" : @"Telephone Directory",
      @"Carrier" : @"Radiation provider",
      @"ControlCenter" : @"Control my Center",
      @"DISPLAY" : @"Display & Blindness",
      @"DO_NOT_DISTURB" : @"Shut up plz",
      @"General" : @"Actual settings you're looking for",
      @"INTERNET_TETHERING" : @"Magical ability to give out internet",
      @"MAPS" : @"To the ocean",
      @"MOBILE_DATA_SETTINGS_ID" : @"Heating mode",
      @"NOTES" : @"Scribblings",
      @"NOTIFICATIONS_ID" : @"Attention grabbing options",
      @"Phone" : @"Telephone",
      @"Privacy" : @"High five brah",
      @"REMINDERS" : @"To remind you of things",
      @"Sounds" : @"Noises and stuff",
      @"VPN" : @"Alternate Spy Network",
      @"SCREEN_TIME" : @"OCD reports",
      @"MAIL" : @"Carrier Pigeons",
      @"SAFARI" : @"Chrome.exe",
      @"BATTERY_USAGE" : @"Jailbreaker OCD Center",
      @"WIFI" : @"Internet from thin air"
    }];
  }


  // write available IDs and names so that user can use set their own values

// - (int)numberOfSectionsInTableView:(id)arg1
-(void)viewWillLayoutSubviews
{
  if(!self.performedActions)
  {
    [self substituteSpecifierNames];
    self.performedActions = TRUE;
  }
  return %orig;
}

%end
