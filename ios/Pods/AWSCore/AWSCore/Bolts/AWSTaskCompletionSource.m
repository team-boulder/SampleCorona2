/*
 *  Copyright (c) 2014, Facebook, Inc.
 *  All rights reserved.
 *
 *  This source code is licensed under the BSD-style license found in the
 *  LICENSE file in the root directory of this source tree. An additional grant
 *  of patent rights can be found in the PATENTS file in the same directory.
 *
 */

#import "AWSTaskCompletionSource.h"

#import "AWSTask.h"

@interface AWSTaskCompletionSource ()

@property (nonatomic, strong, readwrite) AWSTask *task;

@end

@interface AWSTask (AWSTaskCompletionSource)

- (BOOL)trySetresult:(id)result;
- (BOOL)trySetError:(NSError *)error;
- (BOOL)trySetException:(NSException *)exception;
- (BOOL)trySetCancelled;

@end

@implementation AWSTaskCompletionSource

#pragma mark - Initializer

+ (instancetype)taskCompletionSource {
    return [[self alloc] init];
}

- (instancetype)init {
    self = [super init];
    if (!self) return nil;

    _task = [[AWSTask alloc] init];

    return self;
}

#pragma mark - Custom Setters/Getters

- (void)setresult:(id)result {
    if (![self.task trySetresult:result]) {
        [NSException raise:NSInternalInconsistencyException
                    format:@"Cannot set the result on a completed task."];
    }
}

- (void)setError:(NSError *)error {
    if (![self.task trySetError:error]) {
        [NSException raise:NSInternalInconsistencyException
                    format:@"Cannot set the error on a completed task."];
    }
}

- (void)setException:(NSException *)exception {
    if (![self.task trySetException:exception]) {
        [NSException raise:NSInternalInconsistencyException
                    format:@"Cannot set the exception on a completed task."];
    }
}

- (void)cancel {
    if (![self.task trySetCancelled]) {
        [NSException raise:NSInternalInconsistencyException
                    format:@"Cannot cancel a completed task."];
    }
}

- (BOOL)trySetresult:(id)result {
    return [self.task trySetresult:result];
}

- (BOOL)trySetError:(NSError *)error {
    return [self.task trySetError:error];
}

- (BOOL)trySetException:(NSException *)exception {
    return [self.task trySetException:exception];
}

- (BOOL)trySetCancelled {
    return [self.task trySetCancelled];
}

@end
