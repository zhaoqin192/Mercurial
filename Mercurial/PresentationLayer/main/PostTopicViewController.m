//
//  PostTopicViewController.m
//  Mercurial
//
//  Created by 王霄 on 16/4/9.
//  Copyright © 2016年 muggins. All rights reserved.
//

#import "PostTopicViewController.h"

@interface PostTopicViewController ()
<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UITextField *titleTF;
@property (weak, nonatomic) IBOutlet UITextView *contentTextView;
@property (weak, nonatomic) IBOutlet UIImageView *picImageView;
@property (strong, nonatomic) UIImage *image;
@end

@implementation PostTopicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = self.myTitle;
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"menu_bg"]]];
    if(self.isReply){
        self.titleTF.hidden = YES;
        self.titleLabel.hidden = YES;
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}
- (IBAction)cameraButtonClicked {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;//设置可编辑
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    [self presentViewController:picker animated:YES completion:nil];//进入照相界面
}

- (IBAction)photoButtonClicked {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;//设置可编辑
    picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    [self presentViewController:picker animated:YES completion:nil];//进入照相界面
}

- (IBAction)postButtonClicked {
    if (!self.isReply) {
        if (self.titleTF.text.length == 0) {
            [SVProgressHUD showErrorWithStatus:@"请输入主题"];
            [self performSelector:@selector(dismiss) withObject:nil afterDelay:0.5f];
            return;
        }
        if (self.contentTextView.text.length == 0) {
            [SVProgressHUD showErrorWithStatus:@"请输入内容"];
            [self performSelector:@selector(dismiss) withObject:nil afterDelay:0.5f];
            return;
        }
        [NetworkRequest requestSendTopic:self.titleTF.text text:self.contentTextView.text type:self.type typeID:self.identify success:^(NSString *topic_id, NSString *forum_answer_id) {
            if (self.image) {
                [SVProgressHUD showSuccessWithStatus:@"发帖成功"];
                [self performSelector:@selector(dismiss) withObject:nil afterDelay:1.5f];
            }
            else{
                [NetworkRequest uploadTopicPic:topic_id forumAnswerID:forum_answer_id success:^{
                    [SVProgressHUD showSuccessWithStatus:@"发帖成功"];
                    [self performSelector:@selector(dismiss) withObject:nil afterDelay:1.5f];
                } failure:^{
                    [SVProgressHUD showErrorWithStatus:@"发帖失败请重新尝试"];
                    [self performSelector:@selector(dismiss) withObject:nil afterDelay:0.5f];
                }];
            }
        } failure:^{
            [SVProgressHUD showErrorWithStatus:@"发帖失败请重新尝试"];
            [self performSelector:@selector(dismiss) withObject:nil afterDelay:0.5f];
        }];
    }
    else{
        if (self.contentTextView.text.length == 0) {
            [SVProgressHUD showErrorWithStatus:@"请输入内容"];
            [self performSelector:@selector(dismiss) withObject:nil afterDelay:0.5f];
            return;
        }
        [NetworkRequest requestReplyTopic:self.topic_id text:self.contentTextView.text answerToUsername:self.answerName toFloor:self.toFloor success:^(NSString *test) {
            [SVProgressHUD showSuccessWithStatus:@"回复成功"];
            [self performSelector:@selector(dismiss) withObject:nil afterDelay:1.5f];
        } failure:^{
            [SVProgressHUD showErrorWithStatus:@"回复失败请重新尝试"];
            [self performSelector:@selector(dismiss) withObject:nil afterDelay:1.5f];
        }];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)dismiss {
    [SVProgressHUD dismiss];
}

#pragma mark UIImagePickerControllerDelegate
-(void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    
    NSString *mediaType = [info objectForKey: UIImagePickerControllerMediaType];
    UIImage *originalImage, *editedImage;
    // Handle a still image picked from a photo album
    if (CFStringCompare ((CFStringRef) mediaType, kUTTypeImage, 0)
        == kCFCompareEqualTo) {
        
        editedImage = (UIImage *) [info objectForKey:
                                   UIImagePickerControllerEditedImage];
        originalImage = (UIImage *) [info objectForKey:
                                     UIImagePickerControllerOriginalImage];
        
        if (editedImage) {
            self.image = editedImage;
        } else {
            self.image = originalImage;
        }
        // Do something with imageToUse
        self.picImageView.image = self.image;
        
        [picker dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

@end
