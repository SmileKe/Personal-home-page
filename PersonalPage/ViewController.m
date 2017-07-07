//
//  ViewController.m
//  PersonalPage
//
//  Created by cc on 2017/7/6.
//  Copyright © 2017年 keke. All rights reserved.
//

#import "ViewController.h"
#define Screen_Width   ([[UIScreen mainScreen] bounds].size.width)
#define Screen_Height  ([[UIScreen mainScreen] bounds].size.height)
#define HeaderHeight 160
#define HeadImageViewHeight Screen_Width/1.5
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSInteger selectTag;
    NSArray*titleArr;
    UIView*sectionView;
    
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    selectTag=0;
    titleArr=@[@"我的收藏",@"我的订单"];
    [self.view addSubview:[self imageview]];
    [self.view addSubview:[self tableView]];
    [self addHeadView];
    
    sectionView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, 40)];
    sectionView.backgroundColor=[UIColor colorWithRed:176/255.0 green:196/255.0 blue:222/255.0 alpha:1];
    for (int i=0; i<2; i++) {
        UIButton*btn=[[UIButton alloc]initWithFrame:CGRectMake(i*Screen_Width/2, 0, Screen_Width/2, 40)];
        [btn setTitle:titleArr[i] forState:0];
        btn.tag=1000+i;
        [btn addTarget:self action:@selector(selectBtn:) forControlEvents:UIControlEventTouchUpInside];
        [btn setTitleColor:[UIColor whiteColor] forState:0];
        [btn setTitleColor:[UIColor blueColor] forState:UIControlStateSelected];
        [sectionView addSubview:btn];
        if (i==0) {
            btn.selected=YES;
            self.selectedBtn=btn;
        }else{
            btn.selected=NO;
        }
    }
}

-(UIImageView*)imageview{
    if (!_headImageView) {
        _headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, HeadImageViewHeight)];
        _headImageView.image = [UIImage imageNamed:@"bg_zhuye"];
        self.origialFrame = _headImageView.frame;
    }
    return _headImageView;
}
- (UITableView *)tableView{
    if (!_perTableView) {
        _perTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_Height) style:UITableViewStylePlain];
        _perTableView.delegate = self;
        _perTableView.dataSource = self;
        _perTableView.backgroundColor=[UIColor clearColor];
        _perTableView.showsVerticalScrollIndicator = NO;
        _perTableView.rowHeight = 50;
    }
    return _perTableView;
}

-(void)addHeadView{
    UIView*headView= [[UIView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, HeadImageViewHeight)];
    headView.backgroundColor =[UIColor clearColor];
    headView.userInteractionEnabled = YES;
    
    UIImageView*headPho=[[UIImageView alloc]initWithFrame:CGRectMake(Screen_Width/2-40, 60,80, 80)];
    headPho.layer.cornerRadius=40;
    headPho.clipsToBounds=YES;
    [headView addSubview:headPho];
    
    UILabel*name=[[UILabel alloc]initWithFrame:CGRectMake(Screen_Width/2-100, 160,200, 20)];
    name.font=[UIFont systemFontOfSize:14];
    name.textColor=[UIColor whiteColor];
    name.textAlignment=1;
    [headView addSubview:name];
    
    UILabel*  signatureLabel=[[UILabel alloc]initWithFrame:CGRectMake(Screen_Width/2-100, 190, 200, 20)];
    signatureLabel.font=[UIFont systemFontOfSize:14];
    signatureLabel.textColor=[UIColor whiteColor];
    signatureLabel.textAlignment=1;
    [headView addSubview:signatureLabel];
    
    self.perTableView.tableHeaderView=headView;
    //赋值
    headPho.image= [UIImage imageNamed:@"999.jpg"];
    name.text=@"美少女战士";
    signatureLabel.text=@"没有签名就算最好的个性签名";
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 50;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString*cellId=@"cellId";
    UITableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    if (selectTag==1001) {
        cell.textLabel.text=[NSString stringWithFormat:@"%ld===%@",(long)indexPath.row,titleArr[1]];
    }else{
        cell.textLabel.text=[NSString stringWithFormat:@"%@###%ld",titleArr[0],(long)indexPath.row];
    }
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
    
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    return sectionView;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    //往上滑动offset增加，往下滑动，yoffset减小
    CGFloat yoffset = scrollView.contentOffset.y;
    //处理背景图的放大效果和往上移动的效果
    if (yoffset>0) {//往上滑动
        
        _headImageView.frame = ({
            CGRect frame = self.origialFrame;
            frame.origin.y = self.origialFrame.origin.y - yoffset;
            frame;
        });
        
    }else {//往下滑动，放大处理
        _headImageView.frame = ({
            CGRect frame = self.origialFrame;
            frame.size.height = self.origialFrame.size.height - yoffset;
            frame.size.width = frame.size.height*1.5;
            frame.origin.x = _origialFrame.origin.x - (frame.size.width-_origialFrame.size.width)/2;
            frame;
        });
    }
}
-(void)selectBtn:(UIButton*)sender{
    selectTag=sender.tag;
    
    if (sender!= self.selectedBtn) {
        self.selectedBtn.selected = NO;
        sender.selected = YES;
        self.selectedBtn = sender;
    }else{
        self.selectedBtn.selected = YES;
    }
    [self.perTableView reloadData];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
