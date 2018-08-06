//
//  ViewController.m
//  FLJSearchBar
//
//  Created by 贾林飞 on 2018/8/3.
//  Copyright © 2018年 贾林飞. All rights reserved.
//

#import "ViewController.h"
#import "FLJSearchBar.h"

@interface ViewController ()<UISearchBarDelegate>

@property(nonatomic,strong)FLJSearchBar* searchBar;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    FLJSearchBar* searchBar = [[FLJSearchBar alloc] initWithFrame:CGRectMake(0, 50, [UIScreen mainScreen].bounds.size.width, 60)];
    searchBar.delegate = self;
    searchBar.borderColor = [UIColor blackColor];
    searchBar.cornerRadius = 5.f;
    searchBar.placeHolderString = @"请输入搜索关键词";
    searchBar.placeHolderStringFont = [UIFont systemFontOfSize:20];
    searchBar.placeHolderStringColor = [UIColor redColor];
    searchBar.clearBtnHidden = NO;
    searchBar.placeHolderCenter = NO;
    searchBar.showsCancelButton = YES;
    searchBar.cancelInputDisabled = YES;
    [self.view addSubview:searchBar];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

-(BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    return YES;
}

-(BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar
{
    
    return YES;
}

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    NSLog(@"%s",__func__);
}

-(void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    NSLog(@"%s",__func__);
}

-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    NSLog(@"%s",__func__);
    [self.view endEditing:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
