//
//  ViewController.m
//  Msonry Arrangement
//
//  Created by 黄明族 on 16/5/18.
//  Copyright © 2016年 hmz. All rights reserved.
//

#import "ViewController.h"
#import "Masonry.h"

#define padding UIEdgeInsetsMake(40,40,40,40)


@interface ViewController ()

@end

@implementation ViewController{
  //总共两个view
    UIView *displayView;
    UIView *keyboardView;
    //button的显示文本
    NSArray *keys;
    UILabel *displayNum;
}

-(instancetype)init {
    if (self = [super init]) {
        displayNum = [[UILabel alloc]init];
        displayView = [[UIView alloc] init];
        keyboardView = [[UIView alloc] init];
        displayView.backgroundColor = [UIColor blackColor];
        keys = @[@"AC",@"+/-",@"%",@"÷"
                ,@"7",@"8",@"9",@"x"
                ,@"4",@"5",@"6",@"-"
                ,@"1",@"2",@"3",@"+"
                ,@"0",@"?",@".",@"="];
    }
    return self;
}


-(void)initUI{
    //需要将视图加入父视图中，才可以进行布局。Masonry布局也是添加约束，所以要时刻关注的是，不要少加约束或者多加约束造成冲突。
    [self.view addSubview:displayView];
    [self.view addSubview:keyboardView];
    [displayView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view.mas_top);
        make.left.and.right.equalTo(self.view);
        make.height.equalTo(keyboardView).multipliedBy(0.3);
    }];
    [keyboardView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(displayView.mas_bottom);
        make.left.and.right.equalTo(self.view);
        make.bottom.mas_equalTo(self.view.mas_bottom);
    }];
    
    //设置结果显示位置的数字为0
    [displayView addSubview:displayNum];
    displayNum.text = @"0";
    displayNum.font = [UIFont fontWithName:@"HeiTi SC" size:70];
    displayNum.textColor = [UIColor whiteColor];
    displayNum.textAlignment = NSTextAlignmentRight;
    [displayNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(displayView).with.offset(-10);
        make.bottom.equalTo(displayView).with.offset(-10);
    }];
    
    //定义键盘键名称，？号代表合并的单元格
  
    int indexOfKeys = 0;
    for (NSString *key in keys){
        //循环所有键
        indexOfKeys++;
        //第几行
        int rowNum = indexOfKeys %4 ==0? indexOfKeys/4:indexOfKeys/4 +1;
        //第几列
        int colNum = indexOfKeys %4 ==0? 4 :indexOfKeys %4;
        //键样式
        UIButton *keyView = [UIButton buttonWithType:UIButtonTypeCustom];
        keyView.backgroundColor = [UIColor colorWithRed:205 green:205 blue:205 alpha:1];
        [keyboardView addSubview:keyView];
        [keyView setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [keyView setTitle:key forState:UIControlStateNormal];
        [keyView.layer setBorderWidth:1];
        [keyView.layer setBorderColor:[[UIColor blackColor]CGColor]];
        [keyView.titleLabel setFont:[UIFont fontWithName:@"Arial-BoldItalicMT" size:30]];
        keyView.tag = indexOfKeys;
        [keyView addTarget:self action:@selector(touchandshow:) forControlEvents:UIControlEventTouchUpInside];
        //键约束
        [keyView mas_makeConstraints:^(MASConstraintMaker *make) {
            //处理 0 合并单元格
            if([key isEqualToString:@"0"] || [key isEqualToString:@"?"] ){
                if([key isEqualToString:@"0"]){
                    [keyView mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.height.equalTo(keyboardView.mas_height).with.multipliedBy(.2f);
                        make.width.equalTo(keyboardView.mas_width).multipliedBy(.5);
                        make.left.equalTo(keyboardView.mas_left);
                        make.baseline.equalTo(keyboardView.mas_baseline).with.multipliedBy(.9f);
                    }];
                }if([key isEqualToString:@"?"]){
                    [keyView removeFromSuperview];
                }
            }
            //正常的单元格
            else{
                make.width.equalTo(keyboardView.mas_width).with.multipliedBy(.25f);
                make.height.equalTo(keyboardView.mas_height).with.multipliedBy(.2f);
                
                //按照行和列添加约束，这里添加行约束
                switch (rowNum) {
                    case 1:
                    {
                        make.baseline.equalTo(keyboardView.mas_baseline).with.multipliedBy(.1f);
                    }
                        break;
                    case 2:
                    {
                        make.baseline.equalTo(keyboardView.mas_baseline).with.multipliedBy(.3f);
                    }
                        break;
                    case 3:
                    {
                        make.baseline.equalTo(keyboardView.mas_baseline).with.multipliedBy(.5f);
                    }
                        break;
                    case 4:
                    {
                        make.baseline.equalTo(keyboardView.mas_baseline).with.multipliedBy(.7f);
                    }
                        break;
                    case 5:
                    {
                        make.baseline.equalTo(keyboardView.mas_baseline).with.multipliedBy(.9f);
                    }
                        break;
                    default:
                        break;
                }
                //按照行和列添加约束，这里添加列约束
                switch (colNum) {
                    case 1:
                    {
                        make.left.equalTo(keyboardView.mas_left);
                    }
                        break;
                    case 2:
                    {
                        make.right.equalTo(keyboardView.mas_centerX);
                    }
                        break;
                    case 3:
                    {
                        make.left.equalTo(keyboardView.mas_centerX);
                    }
                        break;
                    case 4:
                    {
                        make.right.equalTo(keyboardView.mas_right);
                    }
                        break;
                    default:
                        break;
                }
            }
        }];
    }
}

#pragma mark - button event
-(void)touchandshow:(UIButton *)btn {
    NSLog(@"Tag:.....%ld", btn.tag);
    displayNum.text = keys[btn.tag-1];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
