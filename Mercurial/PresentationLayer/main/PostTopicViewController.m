//
//  PostTopicViewController.m
//  Mercurial
//
//  Created by 王霄 on 16/4/9.
//  Copyright © 2016年 muggins. All rights reserved.
//

#import "PostTopicViewController.h"
#import "NetworkRequest+BBS.h"


@interface PostTopicViewController ()
<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIScrollView *myScrollView;
@property (weak, nonatomic) IBOutlet UITextField *titleTF;
@property (weak, nonatomic) IBOutlet UITextView *contentTextView;
@property (strong, nonatomic) NSMutableArray *images;
@end

@implementation PostTopicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.images = [NSMutableArray array];
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

- (void)postImage:(NSString *)topic_id form_id:(NSString *)forum_answer_id imageIndex:(NSUInteger )index{
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    [SVProgressHUD show];
    if (index < self.images.count) {
        [NetworkRequest uploadTopicPic:topic_id forumAnswerID:forum_answer_id image:self.images[index] success:^{
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                if (self.images[index] == self.images.lastObject) {
                    [SVProgressHUD showSuccessWithStatus:@"上传图片成功"];
                    [self performSelector:@selector(dismiss) withObject:nil afterDelay:1.5f];
                    [self.navigationController popViewControllerAnimated:YES];
                }
                else{
                    [self postImage:topic_id form_id:forum_answer_id imageIndex:index+1];
                }
            });
        } failure:^{
            [SVProgressHUD showErrorWithStatus:@"上传图片失败请重新尝试"];
            [self performSelector:@selector(dismiss) withObject:nil afterDelay:1.5f];
             [self.navigationController popViewControllerAnimated:YES];
            return;
        }];
    }
}

- (void)replyImage:(NSString *)topic_id forumAnswerID:(NSString *)forum_answer_id imageIndex:(NSUInteger )index{
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    [SVProgressHUD show];
    if (index < self.images.count) {
        [NetworkRequest uploadTopicPic:topic_id forumAnswerID:forum_answer_id image:self.images[index] success:^{
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                if (self.images[index] == self.images.lastObject) {
                    [SVProgressHUD showSuccessWithStatus:@"上传图片成功"];
                    [self performSelector:@selector(dismiss) withObject:nil afterDelay:1.5f];
                    [self.navigationController popViewControllerAnimated:YES];
                }
                else{
                    [self replyImage:topic_id forumAnswerID:forum_answer_id imageIndex:index+1];
                }
            });
        } failure:^{
            [SVProgressHUD showErrorWithStatus:@"上传图片失败请重新尝试"];
            [self performSelector:@selector(dismiss) withObject:nil afterDelay:1.5f];
            [self.navigationController popViewControllerAnimated:YES];
            return;
        }];
    }
}

- (IBAction)postButtonClicked {
    if (!self.isReply) {
        if (self.titleTF.text.length == 0) {
            [SVProgressHUD showErrorWithStatus:@"请输入主题"];
            [self performSelector:@selector(dismiss) withObject:nil afterDelay:1.5f];
            return;
        }
        if (self.contentTextView.text.length == 0) {
            [SVProgressHUD showErrorWithStatus:@"请输入内容"];
            [self performSelector:@selector(dismiss) withObject:nil afterDelay:1.5f];
            return;
        }
        [NetworkRequest requestSendTopic:self.titleTF.text text:self.contentTextView.text type:self.type typeID:self.identify success:^(NSString *topic_id, NSString *forum_answer_id) {
            if (self.images.count == 0) {
                [SVProgressHUD showSuccessWithStatus:@"发帖成功"];
                [self performSelector:@selector(dismiss) withObject:nil afterDelay:1.5f];
            }
            else{
                [self postImage:topic_id form_id:forum_answer_id imageIndex:0];
            }
        } failure:^{
            [SVProgressHUD showErrorWithStatus:@"发帖失败请重新尝试"];
            [self performSelector:@selector(dismiss) withObject:nil afterDelay:1.5f];
        }];
    }
    else{
        if (self.contentTextView.text.length == 0) {
            [SVProgressHUD showErrorWithStatus:@"请输入内容"];
            [self performSelector:@selector(dismiss) withObject:nil afterDelay:1.5f];
            return;
        }
        [NetworkRequest requestReplyTopic:self.topic_id text:self.contentTextView.text answerToUsername:self.answerName toFloor:self.toFloor success:^(NSString *forum_answer_id) {
            if (self.images.count == 0) {
                [SVProgressHUD showSuccessWithStatus:@"回复成功"];
                [self performSelector:@selector(dismiss) withObject:nil afterDelay:1.5f];
            }
            else{
                [self replyImage:self.topic_id forumAnswerID:forum_answer_id imageIndex:0];
            }
        } failure:^{
            [SVProgressHUD showErrorWithStatus:@"回复失败请重新尝试"];
            [self performSelector:@selector(dismiss) withObject:nil afterDelay:1.5f];
        }];
    }
}

- (void)dismiss {
    [SVProgressHUD dismiss];
}

- (void)configureScrollView{
    self.myScrollView.hidden = NO;
    CGFloat itemW = 100;
    CGFloat itemH = 100;
    CGFloat margin = 15;
    if (self.images.count != 0) {
        for(int i = 0; i<self.images.count; i++){
            UIImageView *imageView = [[UIImageView alloc] initWithImage:self.images[i]];
            imageView.frame = CGRectMake(i * (itemW + margin), (self.myScrollView.frame.size.height - itemH)/2, itemW, itemH);
            [self.myScrollView addSubview:imageView];
            self.myScrollView.contentSize = CGSizeMake(CGRectGetMaxX(imageView.frame), 0);
        }
    }
    else{
        self.myScrollView.hidden = YES;
    }
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
            [self.images addObject:editedImage];
        } else {
            [self.images addObject:originalImage];
        }
        // Do something with imageToUse
        [self configureScrollView];
        [picker dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

@end
