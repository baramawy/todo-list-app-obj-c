//
//  Notes.h
//  ToDoListAppWorkShop
//
//  Created by Mostafa Baramawy on 13/08/2024.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Notes : NSObject<NSCoding,NSSecureCoding>

@property NSString *title;
@property NSString *description;
@property NSInteger priority;
@property NSInteger type;
@property NSDate* date;
@end

NS_ASSUME_NONNULL_END
