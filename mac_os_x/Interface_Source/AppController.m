//#import "Preferences.h"
#import "AppController.h"
#import "EnvController.h"
#import "PreferenceController.h"
#import "CLIPSTerminalController.h"
#import "CLIPSTextMenu.h"
#import <CLIPS/clips.h>

@implementation AppController

/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
/* Initialization/Deallocation Methods */
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/

/***********************************************/
/* initialize: Set up the default preferences. */
/***********************************************/
+ (void) initialize
  { 
   NSDictionary *appDefaults; 
   NSUserDefaults *defaults; 
   NSFont *theFont;
   
   theFont = [NSFont userFixedPitchFontOfSize:0.0];

   appDefaults = 
      [NSDictionary dictionaryWithObjectsAndKeys:
         [NSNumber numberWithBool:YES], @"watchCompilations", 
         [NSNumber numberWithBool:NO],  @"watchFacts", 
         [NSNumber numberWithBool:NO],  @"watchRules", 
         [NSNumber numberWithBool:NO],  @"watchStatistics", 
         [NSNumber numberWithBool:NO],  @"watchActivations", 
         [NSNumber numberWithBool:NO],  @"watchFocus", 
         [NSNumber numberWithBool:NO],  @"watchGlobals", 
         [NSNumber numberWithBool:NO],  @"watchDeffunctions", 
         [NSNumber numberWithBool:NO],  @"watchGenericFunctions", 
         [NSNumber numberWithBool:NO],  @"watchMethods", 
         [NSNumber numberWithBool:NO],  @"watchInstances", 
         [NSNumber numberWithBool:NO],  @"watchSlots", 
         [NSNumber numberWithBool:NO],  @"watchMessageHandlers", 
         [NSNumber numberWithBool:NO],  @"watchMessages",

         [NSNumber numberWithInt: WHEN_DEFINED],   @"salienceEvaluation", 
         [NSNumber numberWithInt: DEPTH_STRATEGY], @"strategy", 
         
         [NSNumber numberWithBool:YES], @"staticConstraintChecking",
         [NSNumber numberWithBool:NO],  @"dynamicConstraintChecking",
         [NSNumber numberWithBool:YES], @"resetGlobalVariables",
         [NSNumber numberWithBool:NO],  @"sequenceExpansionOperatorRecognition",
         [NSNumber numberWithBool:YES], @"incrementalReset",
         [NSNumber numberWithBool:YES], @"autoFloatDividend",
         [NSNumber numberWithBool:NO],  @"factDuplication",
         
         [theFont fontName],                             @"editorTextFontName",
         [NSNumber numberWithFloat:[theFont pointSize]], @"editorTextFontSize", 
         [NSNumber numberWithBool:YES],                  @"editorBalanceParens",

         [NSNumber numberWithBool:NO], @"factsDisplayDefaultedValues",
         
         nil]; 
 
   defaults = [NSUserDefaults standardUserDefaults]; 
   [defaults registerDefaults:appDefaults]; 

   [[NSUserDefaultsController sharedUserDefaultsController] setInitialValues:appDefaults];
  } 

/*****************/
/* awakeFromNib: */
/*****************/
- (void) awakeFromNib
  {
  }

/************/    
/* dealloc: */
/************/    
- (void) dealloc
  {
   [envController release];
   [super dealloc];
  }
    
/*%%%%%%%%%%%%%%%%*/
/* Action Methods */
/*%%%%%%%%%%%%%%%%*/

/************************/
/* showPreferencePanel: */
/************************/
- (IBAction) showPreferencePanel: (id) sender
  {
   if (! preferenceController)
     { preferenceController = [[PreferenceController alloc] init]; }
    
   [preferenceController showPanel];
  }

/*************************************************/
/* showCLIPSHomePage: Opens the CLIPS Home Page. */
/*************************************************/
- (IBAction) showCLIPSHomePage: (id) sender
  {
   [[NSWorkspace sharedWorkspace] 
       openURL: [NSURL URLWithString: @"http://clipsrules.sourceforge.net/"]];
  }

/*****************************************/
/* showCLIPSExpertSystemGroup: Opens the */
/*   CLIPS Expert System Group Web Page. */
/*****************************************/
- (IBAction) showCLIPSExpertSystemGroup: (id) sender
  {
   [[NSWorkspace sharedWorkspace] 
       openURL: [NSURL URLWithString: @"http://groups.google.com/group/CLIPSESG/"]];
  }

/*****************************************/
/* showCLIPSSourceForgeForums: Opens the */
/*   CLIPS SourceForge Forums Web Page.  */
/*****************************************/
- (IBAction) showCLIPSSourceForgeForums: (id) sender
  {
   [[NSWorkspace sharedWorkspace] 
       openURL: [NSURL URLWithString: @"http://sourceforge.net/forum/?group_id=215471"]];
  }

/***********************************/
/* showUsersGuide: Opens the CLIPS */
/*   User's Guide Web Page.        */
/***********************************/
- (IBAction) showUsersGuide: (id) sender
  {
   [[NSWorkspace sharedWorkspace] 
       openURL: [NSURL URLWithString: @"http://clipsrules.sourceforge.net/documentation/v630/ug.pdf"]];
  }

/**********************************************/
/* showBasicProgrammingGuide: Opens the CLIPS */
/*   Basic Programming Guide Web Page.        */
/**********************************************/
- (IBAction) showBasicProgrammingGuide: (id) sender
  {
   [[NSWorkspace sharedWorkspace] 
       openURL: [NSURL URLWithString: @"http://clipsrules.sourceforge.net/documentation/v630/bpg.pdf"]];
  }

/**********************************************/
/* showAdvancedProgrammingGuide: Opens the CLIPS */
/*   Advanced Programming Guide Web Page.        */
/**********************************************/
- (IBAction) showAdvancedProgrammingGuide: (id) sender
  {
   [[NSWorkspace sharedWorkspace] 
       openURL: [NSURL URLWithString: @"http://clipsrules.sourceforge.net/documentation/v630/apg.pdf"]];
  }

/****************************************/
/* showInterfacesGuide: Opens the CLIPS */
/*   Interfaces Guide Web Page.         */
/****************************************/
- (IBAction) showInterfacesGuide: (id) sender
  {
   [[NSWorkspace sharedWorkspace] 
       openURL: [NSURL URLWithString: @"http://clipsrules.sourceforge.net/documentation/v630/ig.pdf"]];
  }

/*%%%%%%%%%%%%%%%%%%*/
/* Delegate Methods */
/*%%%%%%%%%%%%%%%%%%*/

/**********************************/
/* applicationDidFinishLaunching: */
/**********************************/
- (void) applicationDidFinishLaunching: (NSNotification *) aNotification
  {
   if (! textMenu)
     { 
      textMenu = [[CLIPSTextMenu alloc] init]; 
      [NSBundle loadNibNamed: @"TextMenu" owner: textMenu]; // TBD don't forget to deallocate
     }

   if (! envController)
     { 
      envController = [[EnvController alloc] init]; 
      [NSBundle loadNibNamed: @"EnvController" owner: envController]; // TBD don't forget to deallocate
     }
       
   [envController newEnvironment: self]; 
  }
    
/***********************************************************/
/* applicationShouldOpenUntitledFile: This delegate method */
/*   is used to indicate that an untitled file should not  */
/*   be opened when the application is launched.           */
/***********************************************************/
- (BOOL) applicationShouldOpenUntitledFile: (NSApplication *) sender
  {
   return NO;
  }
        
/*******************************/
/* applicationShouldTerminate: */
/*******************************/
- (NSApplicationTerminateReply) applicationShouldTerminate: (NSApplication *) app
  {
   if (preferenceController != nil)
     { return [preferenceController reviewPreferencesBeforeQuitting]; }
     
   return NSTerminateNow;
  }

/*%%%%%%%%%%%%%%%%%%%%%%%%%%*/
/* Key-Value Coding Methods */
/*%%%%%%%%%%%%%%%%%%%%%%%%%%*/
 
- (void) setEnvController: (EnvController *) theController
  {
   [theController retain];
   [envController release];
   envController = theController;
  }

- (EnvController *) envController
  {
   return envController;
  }

@end
