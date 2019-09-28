#include "Preferences/PSSpecifier.h"

@interface PSUIPrefsListController

@property (nonatomic, assign) BOOL performedActions;
-(id)specifiers;
-(void)substituteSpecifierNames;
@end

%hook PSUIPrefsListController

%property (nonatomic, assign) BOOL performedActions;

%new
-(void)substituteSpecifierNames
{
  NSMutableArray *specifiers = [self specifiers];

  NSMutableDictionary *substituteStrings = [[NSMutableDictionary alloc] initWithDictionary:
    @{
      @"AIRPLANE_MODE" : @"No NSA mode",
      @"Bluetooth" : @"Are your teeth blue yet?",
      @"CONTACTS" : @"Telephone Directory",
      @"Carrier" : @"Radiation provider",
      @"ControlCenter" : @"The Center of Control",
      @"DISPLAY" : @"Display & Blindness",
      @"DO_NOT_DISTURB" : @"Shut up plz",
      @"General" : @"Actual settings you're looking for",
      @"INTERNET_TETHERING" : @"Magical ability to give out internet",
      @"MAPS" : @"To the ocean",
      @"MOBILE_DATA_SETTINGS_ID" : @"Heating mode",
      @"NEWS" : @"Fake News",
      @"NOTES" : @"Scribblings",
      @"NOTIFICATIONS_ID" : @"Attention grabbing options",
      @"Phone" : @"Telephone",
      @"Privacy" : @"High five",
      @"Sounds" : @"Noises n' things",
      @"VPN" : @"Alternate Spy Network",
      @"SCREEN_TIME" : @"OCD reports",
      @"MAIL" : @"Carrier Pigeons",
      @"SAFARI" : @"Chrome.exe",
      @"BATTERY_USAGE" : @"Jailbreaker OCD Center",
      @"WIFI" : @"Internet from thin air"
    }];
  
  // NSDictionary to capture all available specifier IDs
  for(PSSpecifier *specifier in specifiers)
  {
      NSString *substitute = [substituteStrings objectForKey:specifier.identifier];

      // if user has set a substitute that's not any default value, use it
      if([substitute length])
      {
        specifier.name = substitute;
        [substituteStrings setObject:specifier.name forKey:specifier.identifier];
      }
  }
}

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
