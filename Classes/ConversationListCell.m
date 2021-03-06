//
//  ConversationListCell.m
//  Sharetribe
//
//  Created by Janne Käki on 2/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ConversationListCell.h"

#import "Conversation.h"
#import "Message.h"
#import "Participation.h"
#import "User.h"
#import "NSDate+Sharetribe.h"
#import "UIImageView+Sharetribe.h"
#import <QuartzCore/QuartzCore.h>

@interface ConversationListCell () {
    Conversation *conversation;
}
@end

@implementation ConversationListCell

@dynamic conversation;

@synthesize avatarView;
@synthesize usernameLabel;
@synthesize timeLabel;
@synthesize titleLabel;
@synthesize messageLabel;
@synthesize iconView;

+ (ConversationListCell *)instance
{
    NSArray *nibContents = [[NSBundle mainBundle] loadNibNamed:@"ConversationListCell" owner:self options:nil];
    if (nibContents.count > 0) {
        ConversationListCell *cell = [nibContents objectAtIndex:0];
        cell.backgroundColor = kSharetribeBackgroundColor;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.avatarView.backgroundColor = [UIColor colorWithWhite:1 alpha:0.9];
        cell.avatarView.layer.cornerRadius = 5;
        return cell;
    }
    return nil;
}

- (Conversation *)conversation
{
    return conversation;
}

- (void)setConversation:(Conversation *)newConversation
{
    conversation = newConversation;
    
    User *recipient = [conversation recipient];
    usernameLabel.text = recipient.name;
    [avatarView setImageWithUser:recipient];
    
    titleLabel.text = conversation.title;
    messageLabel.text = [conversation.lastMessage content];
    timeLabel.text = [conversation.lastMessage.createdAt agestamp];
    
    if (conversation.isUnread) {
        iconView.image = [UIImage imageWithIconNamed:@"bonfire" pointSize:16 color:[UIColor grayColor] insets:UIEdgeInsetsMake(3, 0, 0, 0)];
    } else if (conversation.isReplied) {
        iconView.image = [UIImage imageWithIconNamed:@"reply" pointSize:16 color:[UIColor grayColor] insets:UIEdgeInsetsMake(3, 0, 0, 0)];
    } else {
        iconView.image = nil;
    }
    
    messageLabel.x = (iconView.image) ? (iconView.x + iconView.width + 4) : titleLabel.x;
    messageLabel.width = 210 - (messageLabel.x - titleLabel.x);
    messageLabel.height = [messageLabel.text sizeWithFont:messageLabel.font constrainedToSize:CGSizeMake(messageLabel.width, 32) lineBreakMode:NSLineBreakByWordWrapping].height;
    
    iconView.y = messageLabel.y;
    iconView.height = messageLabel.height;
    
    usernameLabel.textColor = kSharetribeThemeColor;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    if (selected) {
        self.backgroundColor = kSharetribeThemeColor;
        usernameLabel.textColor = [UIColor whiteColor];
    } else {
        self.backgroundColor = kSharetribeBackgroundColor;
        usernameLabel.textColor = kSharetribeThemeColor;
    }
}

@end
