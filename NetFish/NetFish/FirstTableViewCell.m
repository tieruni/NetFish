//
//  FirstTableViewCell.m
//  NetFish
//
//  Created by tieruni on 16/4/29.
//  Copyright © 2016年 Fish. All rights reserved.
//

#import "FirstTableViewCell.h"

@implementation FirstTableViewCell

- (void)awakeFromNib {
    // Initialization code
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];


}
//------>>>>>>>>>>>>>>>>
//- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
//{
//    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
//    {
//        self.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
//        
//        // cell's title label
//        self.textLabel.backgroundColor = self.backgroundColor;
//        self.textLabel.opaque = NO;
//        self.textLabel.textColor = [UIColor blackColor];
//        self.textLabel.highlightedTextColor = [UIColor whiteColor];
//        self.textLabel.font = [UIFont boldSystemFontOfSize:18.0];
//        
//        // cell's check button
////        checkButton = [[UIButton buttonWithType:UIButtonTypeCustom] retain];
////        checkButton.frame = CGRectZero;
////        checkButton.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
////        checkButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
////        [checkButton addTarget:self action:@selector(checkAction:) forControlEvents:UIControlEventTouchDown];
////        checkButton.backgroundColor = self.backgroundColor;
////        [self.contentView addSubview:checkButton];
//    }
//    return self;
//}

//- (void)layoutSubviews
//{
//    [super layoutSubviews];
//    
//    CGRect contentRect = [self.contentView bounds];
//    
//    CGRect frame = CGRectMake(contentRect.origin.x + 40.0, 8.0, contentRect.size.width, 30.0);
//    self.textLabel.frame = frame;
//    
//    // layout the check button image
////    UIImage *checkedImage = [UIImage imageNamed:@"checked.png"];
////    frame = CGRectMake(contentRect.origin.x + 10.0, 12.0, checkedImage.size.width, checkedImage.size.height);
////    checkButton.frame = frame;
////    
////    UIImage *image = (self.checked) ? checkedImage: [UIImage imageNamed:@"unchecked.png"];
////    UIImage *newImage = [image stretchableImageWithLeftCapWidth:12.0 topCapHeight:0.0];
////    [checkButton setBackgroundImage:newImage forState:UIControlStateNormal];
//}

//-------
//#pragma mark - UITableViewDataSource
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//    return 1;
//}
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//    return 2;
//}
//- (FirstTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    static NSString *CellIdentifier = @"Cell";
//    
//    FirstTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
//    if (cell == nil) {
//        cell = [[FirstTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
//        //设置你的cell
//    }
////    cell.frame = tableView.bounds;
//    cell.frame = CGRectMake(0, 408, UI_SCREEN_W, 100);
//    
//    return cell;
//}

@end
