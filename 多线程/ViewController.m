//
//  ViewController.m
//  多线程
//
//  Created by sunze on 15/9/15.
//  Copyright (c) 2015年 sunze. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
<NSXMLParserDelegate>

@property (retain,nonatomic) NSMutableArray *arrayData;
@property (nonatomic, strong) NSMutableString *tempString;     // 用于临时保存解析的字
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    _arrayData = [NSMutableArray array];
    NSString *strPath = [[NSBundle mainBundle] pathForResource:@"license_city" ofType:@"xml"];
    NSData *data = [NSData dataWithContentsOfFile:strPath];
    NSXMLParser *xmlParser = [[NSXMLParser alloc] initWithData:data];
    xmlParser.delegate = self;
    [xmlParser parse];


}

-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary<NSString *,NSString *> *)attributeDict
{
   
}


-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    NSLog(@"正在解析节点内容");
    if(self.tempString == nil) self.tempString = [[NSMutableString alloc] init];
    NSCharacterSet*set = [NSCharacterSet characterSetWithCharactersInString:@"@／：；（）¥「」＂、[]{}#%-*+=_\\|~＜＞$?^?'@#$%^&*()_+'\" \n"];
    NSString*trimmedString = [string stringByTrimmingCharactersInSet:set];
    [self.tempString appendString:trimmedString];
    }

-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    NSLog(@"解析节点结束");
    if ([self.tempString isEqualToString:@""]) {
        return;
    }
    [self.arrayData addObject:self.tempString];
    self.tempString = nil;
}

-(void)parserDidEndDocument:(NSXMLParser *)parser
{
    NSLog(@"%@ %zd",self.arrayData,self.arrayData.count);
}



@end
