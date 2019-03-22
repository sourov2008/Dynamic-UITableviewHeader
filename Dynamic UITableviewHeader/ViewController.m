//
//  ViewController.m
//  Dynamic UITableviewHeader
//
//  Created by shourov datta on 3/22/19.
//  Copyright © 2019 shourov datta. All rights reserved.
//

#import "ViewController.h"
#import "UILabel+LabelCategory.h"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tbaleView;
@property (weak, nonatomic) IBOutlet UILabel *lblFirst;
@property (weak, nonatomic) IBOutlet UILabel *lblSecond;
@property (weak, nonatomic) IBOutlet UIView *tableViewHeader;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.lblFirst.text = @" Do any additional setup after loading the view, typically from a nib. Do any additional setup after loading the view, typically from a nib. Do any additional setup after loading the view, typically from a nib. Do any additional setup after loading the view, typically from a nib.";
    
    
    self.lblSecond.text = @" Do any additional setup after loading the view, typically from a nib. Do any additional setup after loading the view, typically from a nib. Do any additional setup after loading the view, typically from a nib. Do any additional setup after loading the view, typically from a nib. Do any additional setup after loading the view, typically from a nib. Do any additional setup after loading the view, typically from a nib. Do any additional setup after loading the view, typically from a nib. Do any additional setup after loading the view, typically from a nib.";
    
    
    [self configureTableviewHeader];
}

/// Dynamic UItableViewHeader setup
-(void)configureTableviewHeader{
    
    int height=0;
    CGRect contentRect = CGRectZero;
    
    for (UIView *view in self.tableViewHeader.subviews){
        contentRect = CGRectUnion(contentRect, view.frame);
        
        if ([view isKindOfClass:[UILabel  class]]) {
            UILabel *lbl = (UILabel*)view;
            if (![lbl.text isEqualToString:@""]) {// not empty
                height = [self preferredHeightFromWidth:lbl.frame.size.width text:lbl.text font:lbl.font]  +height;
            }
            
            else
                height = height + 0;
            
        }
        
        else
        height = height + view.frame.size.height;
        
    }
    
    //    int newAttachmentContainerHeight = [self createAttachmentCell] ;
    //    // Previous tableViewHeader height + New attachment Height (Minus attchment container height because because container height is included on new height)
    //    float newHeight  = contentRect.size.height + newAttachmentContainerHeight  - self.attachmentContainer.frame.size.height;
    //
    // Assign new frame
    
    NSLog(@"Height : %d",  height);
    int buffer = 0; // Add you buffer if necessary.
    self.tableViewHeader.frame =  CGRectMake(self.tableViewHeader.frame.origin.x, self.tableViewHeader.frame.origin.y,self.tableViewHeader.frame.size.width ,  height+ buffer);
    
    self.tbaleView.tableHeaderView = self.tableViewHeader;
    //[self.tbaleView reloadData];
    
    
}

- (CGFloat)preferredHeightFromWidth:(CGFloat)width text:(NSString *)text font:(UIFont *)font
{
    // Calculate label height
    CGFloat labelHeight = [text
                           boundingRectWithSize:CGSizeMake(width, 10000)
                           options:NSStringDrawingUsesLineFragmentOrigin
                           attributes:@{NSFontAttributeName:font}
                           context:[[NSStringDrawingContext alloc] init]
                           ].size.height;

    // Do the sum
    return labelHeight ;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SimpleTableItem";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    cell.textLabel.text = @"Text";
    return cell;
}

@end
