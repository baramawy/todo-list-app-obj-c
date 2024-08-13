//
//  Notes.m
//  ToDoListAppWorkShop
//
//  Created by Mostafa Baramawy on 13/08/2024.
//

#import "Notes.h"

@implementation Notes


- (void)encodeWithCoder:(nonnull NSCoder *)coder {
    [coder encodeObject:_title forKey:@"title"];
    [coder encodeInteger:_priority forKey:@"priority"];
    [coder encodeObject:self.description forKey:@"description"];
    [coder encodeInteger:_type forKey:@"type"];
    [coder encodeObject:_date forKey:@"date"];
    
}

- (nullable instancetype)initWithCoder:(nonnull NSCoder *)coder {
    self = [super init];
            if (self) {
        _priority = [coder decodeIntForKey: @"priority"];
        _title = [coder decodeObjectOfClass:[NSString class] forKey:@"title"];
        self.description = [coder decodeObjectOfClass:[NSString class] forKey:@"description"];
        _type = [coder decodeIntegerForKey: @"type"];
        _date = [coder decodeObjectForKey:@"date"];
    }
    return self;
}

+ (BOOL)supportsSecureCoding{
    return  YES;
}
@end
