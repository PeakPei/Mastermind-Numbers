//
//  RWGameData.m
//  SpaceShooter
//
//  Created by Marin Todorov on 15/1/14.
//  Copyright (c) 2014 fullmoonmanor. All rights reserved.
//

#import "RWGameData.h"
#import "KeychainWrapper.h"

@implementation RWGameData
@synthesize myNumber,opponentsNumber,playerIDs,threeDigitGame,fourDigitGame,playerRemotePower;

static NSString* const SSGameDataScoreKey = @"score";
static NSString* const SSGameDataScoreAIKey = @"scoreAI";
static NSString* const PlayerIDsKey = @"PlayerIDs";
static NSString* const TrainingAvarageStepsKey = @"trainingAvarageSteps";
static NSString* const TrainingAvarageSteps4Key = @"trainingAvarageSteps4";
static NSString* const MultiGameCountKey = @"multiGameCount";
static NSString* const MultiWinCountKey = @"multiWinCount";
static NSString* const MultiDrawCountKey = @"multiDrawCount";
static NSString* const MultiLostCountKey = @"multiLostCount";
static NSString* const MultiWinCountKey4 = @"multiWinCount4";
static NSString* const MultiDrawCountKey4 = @"multiDrawCount4";
static NSString* const MultiLostCountKey4 = @"multiLostCount4";
static NSString* const SingleWinCountKey = @"singleWinCount";
static NSString* const SingleDrawCountKey = @"singleDrawCount";
static NSString* const SingleLostCountKey = @"singleLostCount";
static NSString* const SingleWinCountKey4 = @"singleWinCount4";
static NSString* const SingleDrawCountKey4 = @"singleDrawCount4";
static NSString* const SingleLostCountKey4 = @"singleLostCount4";
static NSString* const MultiRemainingGameCountKey = @"multiRemainingGameCount";
static NSString* const SingleGameCountKey = @"singleGameCount";
static NSString* const OfflineGameCountKey = @"offlineGameCount";
static NSString* const TrainingGameCountKey = @"trainingGameCount";
static NSString* const TrainingGameCount4Key = @"trainingGameCount4";
static NSString* const MultiAvarageTimeKey = @"multiAvarageTime";
static NSString* const SSGameDataChecksumKey = @"SSGameDataChecksumKey";
static NSString* const RewardedGameCountKey = @"rewardedGameCount";
static NSString* const LimitDateKey = @"LimitDate";
static NSString* const DailyLimitKey = @"DailyLimit";
static NSString* const LimitStepKey = @"LimitStep";
static NSString* const NoAdKey = @"NoAddKey";
static NSString* const ShowAIPlayers = @"ShowAIPlayers";
static NSString* const PlayerId = @"PlayerId";
static NSString* const PlayerName = @"PlayerName";
static NSString* const PlayerPower = @"PlayerPower";
static NSString* const IAPAd = @"IAPAd";
static NSString* const LimitExeeded = @"limitExeeded";
static NSString* const IAPPacket1 = @"IAPpacket1";
static NSString* const IAPPacket2 = @"IAPpacket2";
static NSString* const IAPPacket3 = @"IAPpacket3";
static NSString* const Thema = @"Thema";
static NSString* const TimeInterval = @"TimeInterval";

- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeDouble:self.score forKey: SSGameDataScoreKey];
    [encoder encodeDouble:self.scoreAI forKey: SSGameDataScoreAIKey];
    [encoder encodeDouble:self.trainingAvarageSteps forKey: TrainingAvarageStepsKey];
    [encoder encodeDouble:self.trainingAvarage4Steps forKey: TrainingAvarageSteps4Key];
    [encoder encodeDouble:self.multiGameCount forKey: MultiGameCountKey];
    [encoder encodeDouble:self.multiWinCount forKey: MultiWinCountKey];
    [encoder encodeDouble:self.multiLostCount forKey: MultiLostCountKey];
    [encoder encodeDouble:self.multiDrawCount forKey: MultiDrawCountKey];
    [encoder encodeDouble:self.multiWinCount4 forKey: MultiWinCountKey4];
    [encoder encodeDouble:self.multiLostCount4 forKey: MultiLostCountKey4];
    [encoder encodeDouble:self.multiDrawCount4 forKey: MultiDrawCountKey4];
    [encoder encodeDouble:self.singleWinCount forKey: SingleWinCountKey];
    [encoder encodeDouble:self.singleLostCount forKey: SingleLostCountKey];
    [encoder encodeDouble:self.singleDrawCount forKey: SingleDrawCountKey];
    [encoder encodeDouble:self.singleWinCount4 forKey: SingleWinCountKey4];
    [encoder encodeDouble:self.singleLostCount4 forKey: SingleLostCountKey4];
    [encoder encodeDouble:self.singleDrawCount4 forKey: SingleDrawCountKey4];
    [encoder encodeDouble:self.singleGameCount forKey: SingleGameCountKey];
    [encoder encodeDouble:self.offlineGameCount forKey: OfflineGameCountKey];
    [encoder encodeDouble:self.trainingGameCount forKey: TrainingGameCountKey];
    [encoder encodeDouble:self.trainingGame4Count forKey: TrainingGameCount4Key];
    [encoder encodeDouble:self.multiAvarageTime forKey: MultiAvarageTimeKey];
    [encoder encodeDouble:self.multiRemainingGameCount forKey: MultiRemainingGameCountKey];
    [encoder encodeDouble:self.rewardedGameCount forKey: RewardedGameCountKey];
    [encoder encodeDouble:self.dailyLimit forKey: DailyLimitKey];
    [encoder encodeDouble:self.limitStep forKey: LimitStepKey];
    [encoder encodeObject:self.limitDate forKey:LimitDateKey];
    [encoder encodeObject:self.playerIDs forKey:PlayerIDsKey];
    [encoder encodeDouble:self.noAd forKey:NoAdKey];
    [encoder encodeBool:self.showAIPlayers forKey:ShowAIPlayers];
    [encoder encodeDouble:self.playerId forKey:PlayerId];
    [encoder encodeObject:self.playerName forKey:PlayerName];
    [encoder encodeObject:self.playerPower forKey:PlayerPower];
    [encoder encodeBool:self.IAPAd forKey:IAPAd];
    [encoder encodeBool:self.IAPPacket1 forKey:IAPPacket1];
    [encoder encodeBool:self.IAPPacket2 forKey:IAPPacket2];
    [encoder encodeBool:self.IAPPacket3 forKey:IAPPacket3];
    [encoder encodeDouble:self.thema forKey:Thema];
    [encoder encodeBool:self.limitExceeded forKey:LimitExeeded];
    [encoder encodeDouble:self.timeInterval forKey: TimeInterval];
}

- (instancetype)initWithCoder:(NSCoder *)decoder
{
    self = [self init];
    if (self) {
        _score = [decoder decodeDoubleForKey: SSGameDataScoreKey];
        _scoreAI = [decoder decodeDoubleForKey: SSGameDataScoreAIKey];
        _trainingAvarageSteps = [decoder decodeDoubleForKey: TrainingAvarageStepsKey];
        _trainingAvarage4Steps = [decoder decodeDoubleForKey: TrainingAvarageSteps4Key];
        _multiGameCount = [decoder decodeDoubleForKey: MultiGameCountKey];
        _singleGameCount = [decoder decodeDoubleForKey: SingleGameCountKey];
        _multiWinCount = [decoder decodeDoubleForKey: MultiWinCountKey];
        _multiLostCount = [decoder decodeDoubleForKey: MultiLostCountKey];
        _multiDrawCount = [decoder decodeDoubleForKey: MultiDrawCountKey];
        _multiWinCount4 = [decoder decodeDoubleForKey: MultiWinCountKey4];
        _multiLostCount4 = [decoder decodeDoubleForKey: MultiLostCountKey4];
        _multiDrawCount4 = [decoder decodeDoubleForKey: MultiDrawCountKey4];
        _singleWinCount = [decoder decodeDoubleForKey: SingleWinCountKey];
        _singleLostCount = [decoder decodeDoubleForKey: SingleLostCountKey];
        _singleDrawCount = [decoder decodeDoubleForKey: SingleDrawCountKey];
        _singleWinCount4 = [decoder decodeDoubleForKey: SingleWinCountKey4];
        _singleLostCount4 = [decoder decodeDoubleForKey: SingleLostCountKey4];
        _singleDrawCount4 = [decoder decodeDoubleForKey: SingleDrawCountKey4];
        _offlineGameCount = [decoder decodeDoubleForKey: OfflineGameCountKey];
        _trainingGameCount = [decoder decodeDoubleForKey: TrainingGameCountKey];
        _trainingGame4Count = [decoder decodeDoubleForKey: TrainingGameCount4Key];
        _multiAvarageTime = [decoder decodeDoubleForKey: MultiAvarageTimeKey];
        _multiRemainingGameCount = [decoder decodeDoubleForKey: MultiRemainingGameCountKey];
        _rewardedGameCount = [decoder decodeDoubleForKey: RewardedGameCountKey];
        _dailyLimit = [decoder decodeDoubleForKey: DailyLimitKey];
        _limitStep = [decoder decodeDoubleForKey: LimitStepKey];
        playerIDs = [[decoder decodeObjectForKey:PlayerIDsKey] mutableCopy];
        _limitDate = [decoder decodeObjectForKey:LimitDateKey];
        _noAd =  [decoder decodeDoubleForKey: NoAdKey];
        _showAIPlayers =  [decoder decodeBoolForKey:ShowAIPlayers];
        _playerId = [decoder decodeDoubleForKey: PlayerId];
        _playerName = [decoder decodeObjectForKey: PlayerName];
        _playerPower = [decoder decodeObjectForKey: PlayerPower];
        _IAPAd =  [decoder decodeBoolForKey:IAPAd];
        _IAPPacket1 =  [decoder decodeBoolForKey:IAPPacket1];
        _IAPPacket2 =  [decoder decodeBoolForKey:IAPPacket2];
        _IAPPacket3 =  [decoder decodeBoolForKey:IAPPacket3];
        _thema = [decoder decodeDoubleForKey: Thema];
        _limitExceeded = [decoder decodeBoolForKey: LimitExeeded];
        _timeInterval = [decoder decodeDoubleForKey: TimeInterval];
        
        if (!playerIDs)
            playerIDs = [[NSMutableArray alloc] init];
        
    }
    return self;
}

+ (instancetype)sharedGameData {
    static id sharedInstance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [self loadInstance];
    });
    
    return sharedInstance;
}

-(void)reset
{
    self.score = 0;
    self.trainingAvarageSteps = 0;
    self.trainingAvarage4Steps = 0;
    self.singleGameCount = 0;
    self.trainingGameCount = 0;
    self.trainingGame4Count = 0;
    self.multiGameCount = 0;
    self.multiAvarageTime = 0;
    self.playerIDs = nil;
    self.multiRemainingGameCount = 0;
    
    [self save];
}

-(void)resetGamePower
{
    if (self.threeDigitGame) {
        self.trainingAvarageSteps = 0;
        self.trainingGameCount = 0;
        [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"trainingNumbers"];
        [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"computerNumber"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }else{
        self.trainingAvarage4Steps = 0;
        self.trainingGame4Count = 0;
        [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"trainingNumbers4"];
        [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"computerNumber4"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
    [self save];
}

+(NSString*)filePath
{
    static NSString* filePath = nil;
    if (!filePath) {
        filePath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:@"gamedata"];
    }
    return filePath;
}

+(instancetype)loadInstance
{
    NSData* decodedData = [NSData dataWithContentsOfFile: [RWGameData filePath]];
    if (decodedData) {
        //1
        NSString* checksumOfSavedFile = [KeychainWrapper computeSHA256DigestForData: decodedData];
        
        //2
        NSString* checksumInKeychain = [KeychainWrapper keychainStringFromMatchingIdentifier: SSGameDataChecksumKey];
        
        //3
        if ([checksumOfSavedFile isEqualToString: checksumInKeychain]) {
            RWGameData* gameData = [NSKeyedUnarchiver unarchiveObjectWithData:decodedData];
            return gameData;
        }
        //4
    }
    
    return [[RWGameData alloc] init];
}

-(void)save
{
    NSData* encodedData = [NSKeyedArchiver archivedDataWithRootObject: self];
    [encodedData writeToFile:[RWGameData filePath] atomically:YES];
    
    NSString* checksum = [KeychainWrapper computeSHA256DigestForData: encodedData];
    if ([KeychainWrapper keychainStringFromMatchingIdentifier: SSGameDataChecksumKey]) {
        [KeychainWrapper updateKeychainValue:checksum forIdentifier:SSGameDataChecksumKey];
    } else {
        [KeychainWrapper createKeychainValue:checksum forIdentifier:SSGameDataChecksumKey];
    }
    
    if([NSUbiquitousKeyValueStore defaultStore]) {
        [self updateiCloud];
    }
}

-(void)updateiCloud
{
    NSUbiquitousKeyValueStore *iCloudStore = [NSUbiquitousKeyValueStore defaultStore];
    
    [iCloudStore setLongLong:self.score forKey: SSGameDataScoreKey];
    [iCloudStore setLongLong:self.scoreAI forKey: SSGameDataScoreAIKey];
    [iCloudStore setDouble:self.trainingAvarageSteps forKey: TrainingAvarageStepsKey];
    [iCloudStore setDouble:self.trainingAvarage4Steps forKey: TrainingAvarageSteps4Key];
    [iCloudStore setLongLong:self.singleGameCount forKey: SingleGameCountKey];
    [iCloudStore setLongLong:self.multiWinCount forKey: MultiWinCountKey];
    [iCloudStore setLongLong:self.multiLostCount forKey: MultiLostCountKey];
    [iCloudStore setLongLong:self.multiDrawCount forKey: MultiDrawCountKey];
    [iCloudStore setLongLong:self.multiWinCount4 forKey: MultiWinCountKey4];
    [iCloudStore setLongLong:self.multiLostCount4 forKey: MultiLostCountKey4];
    [iCloudStore setLongLong:self.multiDrawCount4 forKey: MultiDrawCountKey4];
    [iCloudStore setLongLong:self.singleWinCount forKey: SingleWinCountKey];
    [iCloudStore setLongLong:self.singleLostCount forKey: SingleLostCountKey];
    [iCloudStore setLongLong:self.singleDrawCount forKey: SingleDrawCountKey];
    [iCloudStore setLongLong:self.singleWinCount4 forKey: SingleWinCountKey4];
    [iCloudStore setLongLong:self.singleLostCount4 forKey: SingleLostCountKey4];
    [iCloudStore setLongLong:self.singleDrawCount4 forKey: SingleDrawCountKey4];
    [iCloudStore setLongLong:self.offlineGameCount forKey: OfflineGameCountKey];
    [iCloudStore setLongLong:self.trainingGameCount forKey: TrainingGameCountKey];
    [iCloudStore setLongLong:self.trainingGame4Count forKey: TrainingGameCount4Key];
    [iCloudStore setLongLong:self.multiGameCount forKey: MultiGameCountKey];
    [iCloudStore setLongLong:self.multiAvarageTime forKey: MultiAvarageTimeKey];
    [iCloudStore setLongLong:self.multiRemainingGameCount forKey: MultiRemainingGameCountKey];
    [iCloudStore setLongLong:self.rewardedGameCount forKey: RewardedGameCountKey];
    [iCloudStore setLongLong:self.dailyLimit forKey: DailyLimitKey];
    [iCloudStore setLongLong:self.limitStep forKey: LimitStepKey];
    [iCloudStore setArray:self.playerIDs forKey:PlayerIDsKey];
    [iCloudStore setObject:self.limitDate forKey:LimitDateKey];
    [iCloudStore setLongLong:self.noAd forKey:NoAdKey];
    [iCloudStore setBool:self.showAIPlayers forKey:ShowAIPlayers];
    [iCloudStore setObject:self.playerName forKey:PlayerName];
    [iCloudStore setObject:self.playerPower forKey:PlayerPower];
    [iCloudStore setLongLong:self.playerId forKey:PlayerId];
    [iCloudStore setBool:self.IAPAd forKey:IAPAd];
    [iCloudStore setBool:self.IAPPacket1 forKey:IAPPacket1];
    [iCloudStore setBool:self.IAPPacket2 forKey:IAPPacket2];
    [iCloudStore setBool:self.IAPPacket3 forKey:IAPPacket3];
    [iCloudStore setLongLong:self.thema forKey:Thema];
    [iCloudStore setBool:self.limitExceeded forKey:LimitExeeded];
    [iCloudStore setLongLong:self.timeInterval forKey: TimeInterval];

    [iCloudStore synchronize];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        playerIDs = [NSMutableArray new];
        //1
        if([NSUbiquitousKeyValueStore defaultStore]) {
            
            //2
            [[NSNotificationCenter defaultCenter] addObserver:self
                                                     selector:@selector(updateFromiCloud:)
                                                         name:NSUbiquitousKeyValueStoreDidChangeExternallyNotification
                                                       object:nil];
        }
    }
    return self;
}

-(void)updateFromiCloud:(NSNotification*) notificationObject
{
    NSUbiquitousKeyValueStore *iCloudStore = [NSUbiquitousKeyValueStore defaultStore];
    self.score = (long)[iCloudStore longLongForKey: SSGameDataScoreKey];
    self.scoreAI = (long)[iCloudStore longLongForKey: SSGameDataScoreAIKey];
    self.trainingAvarageSteps = [iCloudStore doubleForKey: TrainingAvarageStepsKey];
    self.trainingAvarage4Steps = [iCloudStore doubleForKey: TrainingAvarageSteps4Key];
    self.singleGameCount = (long)[iCloudStore longLongForKey: SingleGameCountKey];
    self.multiWinCount = (long)[iCloudStore longLongForKey: MultiWinCountKey];
    self.multiLostCount = (long)[iCloudStore longLongForKey: MultiLostCountKey];
    self.multiDrawCount = (long)[iCloudStore longLongForKey: MultiDrawCountKey];
    self.multiWinCount4 = (long)[iCloudStore longLongForKey: MultiWinCountKey4];
    self.multiLostCount4 = (long)[iCloudStore longLongForKey: MultiLostCountKey4];
    self.multiDrawCount4 = (long)[iCloudStore longLongForKey: MultiDrawCountKey4];
    self.singleWinCount = (long)[iCloudStore longLongForKey: SingleWinCountKey];
    self.singleLostCount = (long)[iCloudStore longLongForKey: SingleLostCountKey];
    self.singleDrawCount = (long)[iCloudStore longLongForKey: SingleDrawCountKey];
    self.singleWinCount4 = (long)[iCloudStore longLongForKey: SingleWinCountKey4];
    self.singleLostCount4 = (long)[iCloudStore longLongForKey: SingleLostCountKey4];
    self.singleDrawCount4 = (long)[iCloudStore longLongForKey: SingleDrawCountKey4];
    self.offlineGameCount = (long)[iCloudStore longLongForKey: OfflineGameCountKey];
    self.trainingGameCount = (long)[iCloudStore longLongForKey: TrainingGameCountKey];
    self.trainingGame4Count = (long)[iCloudStore longLongForKey: TrainingGameCount4Key];
    self.multiGameCount = (long)[iCloudStore longLongForKey: MultiGameCountKey];
    self.multiAvarageTime = (long)[iCloudStore longLongForKey: MultiAvarageTimeKey];
    self.multiRemainingGameCount = (long)[iCloudStore longLongForKey: MultiRemainingGameCountKey];
    self.rewardedGameCount = (long)[iCloudStore longLongForKey:RewardedGameCountKey];
    self.dailyLimit = (long)[iCloudStore longLongForKey:DailyLimitKey];
    self.limitStep = (long)[iCloudStore longLongForKey:LimitStepKey];
    self.playerIDs = [[iCloudStore arrayForKey:PlayerIDsKey] mutableCopy];
    self.limitDate = (NSString*)[iCloudStore objectForKey:LimitDateKey];
    self.noAd = (long)[iCloudStore objectForKey:NoAdKey];
    self.showAIPlayers = [iCloudStore boolForKey:ShowAIPlayers];
    self.playerId = (long)[iCloudStore objectForKey:PlayerId];
    self.playerName = (NSString*)[iCloudStore objectForKey:PlayerName];
    self.playerPower = (NSString*)[iCloudStore objectForKey:PlayerPower];
    self.IAPAd =  [iCloudStore boolForKey:IAPAd];
    self.IAPPacket1 =  [iCloudStore boolForKey:IAPPacket1];
    self.IAPPacket2 =  [iCloudStore boolForKey:IAPPacket2];
    self.IAPPacket3 =  [iCloudStore boolForKey:IAPPacket3];
    self.thema = (long)[iCloudStore objectForKey:Thema];
    self.limitExceeded = [iCloudStore boolForKey:LimitExeeded];
    self.timeInterval = [iCloudStore boolForKey:TimeInterval];

    [self save];
    
    [[NSNotificationCenter defaultCenter] postNotificationName: SSGameDataUpdatedFromiCloud object:nil];
}

@end
