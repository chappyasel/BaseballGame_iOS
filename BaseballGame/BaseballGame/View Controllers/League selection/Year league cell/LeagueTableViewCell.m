//
//  LeagueTableViewCell.m
//  BaseballGame
//
//  Created by Chappy Asel on 9/6/15.
//  Copyright © 2015 CD. All rights reserved.
//

#import "LeagueTableViewCell.h"
#import "BGLeagueController.h"

@implementation LeagueTableViewCell

- (void)awakeFromNib {
    self.downloadButton.delegate = self;
    self.downloadButton.downloadedButton.tintColor = [UIColor redColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    //[super setSelected:selected animated:animated];
    if (selected && self.isDownloaded) {
        self.checkImageView.image = [UIImage imageNamed:@"check.png"];
        self.downloadButton.state = kPKDownloadButtonState_Downloaded;
    }
    else if (self.isDownloaded){
        self.checkImageView.image = [UIImage imageNamed:@"select_empty.png"];
        self.downloadButton.state = kPKDownloadButtonState_Downloaded;
    }
    else {
        self.checkImageView.image = nil;
        self.downloadButton.state = kPKDownloadButtonState_StartDownload;
    }
}

- (void)updateDownloaded {
    if (self.isDownloaded) {
        self.checkImageView.image = [UIImage imageNamed:@"select_empty.png"];
        self.downloadButton.state = kPKDownloadButtonState_Downloaded;
    }
    else {
        self.checkImageView.image = nil;
        self.downloadButton.state = kPKDownloadButtonState_StartDownload;
    }
}

#pragma mark - downloadButton delegate

- (void)downloadButtonTapped:(PKDownloadButton *)downloadButton currentState:(PKDownloadButtonState)state {
    if (state == kPKDownloadButtonState_StartDownload) { //start
        downloadButton.state = kPKDownloadButtonState_Pending;
        [self.leagueController loadLeagueForYear:self.year.intValue context:self.managedObjectContext WithProgressBlock:^(float progress) {
            downloadButton.state = kPKDownloadButtonState_Downloading;
            downloadButton.stopDownloadButton.progress = progress;
            if (progress > .99) {
                downloadButton.state = kPKDownloadButtonState_Downloaded;
                self.isDownloaded = YES;
                self.checkImageView.image = [UIImage imageNamed:@"select_empty.png"];
            }
        }];
    }
    else if (state == kPKDownloadButtonState_Pending) { //waiting (cancel)
        downloadButton.state = kPKDownloadButtonState_StartDownload;
        
    }
    else if (state == kPKDownloadButtonState_Downloading) { //stopped
        downloadButton.state = kPKDownloadButtonState_StartDownload;
        
    }
    else if (state == kPKDownloadButtonState_Downloaded) { //delete
        downloadButton.state = kPKDownloadButtonState_StartDownload;
        [self.leagueController removeLeagueForYear:self.year.intValue context:self.managedObjectContext];
        self.isDownloaded = NO;
        [self updateDownloaded];
    }
    else NSLog(@"Incorrect downloadButton state");
}

@end
