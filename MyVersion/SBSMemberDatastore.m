//
//  SBSMemberDatastore.m
//  SleepyPeople
//
//  Created by David Groulx on 6/3/14.
//  Copyright (c) 2014 David Groulx. All rights reserved.
//

#import "SBSMemberDatastore.h"
#import "SBSMember.h"

@interface SBSMemberDatastore () {
    NSMutableArray *members;
    NSURLConnection *connection;
    NSMutableData *jsonData;
}
@end

@implementation SBSMemberDatastore

- (id)init {
    self = [super init];
    if (self) {
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"https://api.parse.com/1/classes/member"]];
        [request setValue:@"nq5kBbLQqWjW7taX9UVLoiEkyCDJ8gONbw92Fx6d" forHTTPHeaderField:@"X-Parse-Application-Id"];
        [request setValue:@"hwz7WjcntmkHEphq0JazkvX1WoN4jcLi3IKo5UbY" forHTTPHeaderField:@"X-Parse-REST-API-Key"];
        
        NSData *theData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
        NSDictionary *allMembers = (NSDictionary *)[NSJSONSerialization JSONObjectWithData:theData options:0 error:nil];
        
        members = [NSMutableArray array];
        for (NSDictionary *memberDictionary in allMembers[@"results"]) {
            [members addObject:[[SBSMember alloc] initWithDictionary:memberDictionary]];
        }
    }
    
    return self;
}

- (id)initWithTestData {
    self = [super init];
    if (self) {
        NSDictionary *trentonDictionary = @{@"ama": @"",
                                            @"bio": @"",
                                            @"email": @"",
                                            @"fb": @"",
                                            @"name": @"Trenton Broughton",
                                            @"twitter": @"",
                                            @"pic": @""};
        NSDictionary *garrickDictionary = @{@"ama": @"",
                                            @"bio": @"",
                                            @"email": @"",
                                            @"fb": @"",
                                            @"name": @"Garrick Pohl",
                                            @"twitter": @"",
                                            @"pic": @""};
        NSDictionary *ronDictionary = @{@"ama": @"",
                                        @"bio": @"",
                                        @"email": @"",
                                        @"fb": @"",
                                        @"name": @"Ron VanSurksum",
                                        @"twitter": @"",
                                        @"pic": @""};
        members = [@[[[SBSMember alloc] initWithDictionary:trentonDictionary],
                     [[SBSMember alloc] initWithDictionary:garrickDictionary],
                     [[SBSMember alloc] initWithDictionary:ronDictionary]] mutableCopy];
    }
    return self;
}

- (NSUInteger)count {
    return [members count];
}

- (SBSMember *)recordAtIndex:(NSUInteger)index {
    return members[index];
}

@end