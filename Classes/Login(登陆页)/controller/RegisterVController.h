//
//  RegisterVController.h
//  FItemsBase
//
//  Created by 放 on 2018/3/28.
//  Copyright © 2018年 放. All rights reserved.
//
/*
 'A'  新增
 
 'D'  删除
 'M'  修改
 'R'  替代
 'C'  冲突
 'I'  忽略
 '?'  未受控
 '!'  丢失，一般是将受控文件直接删除导致
 
 这些标记跟你使用的代码托管工具或者xcode自带的svn代码托管工具有关，怎样消除：
 
 1、代码中 某文件后面有 “M” 标记，表示该文件已被修改，需要 commit.
 （右键该文件 -> source control -> commit selected file...）
 2、代码中 某文件后面有 “A” 标记，表示该文件是新添加的，已受SVN管理，需要 commit.
 （右键该文件 -> source control -> commit selected file...）
 3、代码中 某文件后面有 “?” 标记，表示该文件是新添加的，并且脱离了SVN的管理，首先需要add，然后 commit.
 （右键该文件 -> source control -> Add，这样该文件的标记就变为 “A”，然后在 commit）
 4、代码中 某文件后面有 “D” 标记，表示该文件在服务器上已被删除，这时update的话，可删除本地的文件。
 5、代码中 某文件后面有 “C” 标记，表示该文件与服务器的文件冲突
 
 */


#import <UIKit/UIKit.h>
#import "commenTField.h"

@interface RegisterVController : UIViewController

@end
