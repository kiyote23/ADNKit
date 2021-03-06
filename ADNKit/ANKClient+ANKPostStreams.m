/*
 Copyright (c) 2013, Joel Levin
 All rights reserved.
 
 Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
 
 Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
 Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
 Neither the name of ADNKit nor the names of its contributors may be used to endorse or promote products derived from this software without specific prior written permission.
 THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

#import "ANKClient+ANKPostStreams.h"
#import "ANKPost.h"
#import "ANKUser.h"


@implementation ANKClient (ANKPostStreams)

// http://developers.app.net/docs/resources/post/streams/#retrieve-the-global-stream

- (void)fetchGlobalStreamWithCompletion:(ANKClientCompletionBlock)completionHandler {
	[self getPath:@"posts/stream/global"
	   parameters:nil
		  success:[self successHandlerForCollectionOfResourceClass:[ANKPost class] clientHandler:completionHandler]
		  failure:[self failureHandlerForClientHandler:completionHandler]];
}


// http://developers.app.net/docs/resources/post/streams/#retrieve-tagged-posts

- (void)fetchPostsWithHashtag:(NSString *)hashtag completion:(ANKClientCompletionBlock)completionHandler {
	[self getPath:[NSString stringWithFormat:@"posts/tag/%@", hashtag]
	   parameters:nil
		  success:[self successHandlerForCollectionOfResourceClass:[ANKPost class] clientHandler:completionHandler]
		  failure:[self failureHandlerForClientHandler:completionHandler]];
}


// http://developers.app.net/docs/resources/post/streams/#retrieve-posts-created-by-a-user

- (void)fetchPostsCreatedByUser:(ANKUser *)user completion:(ANKClientCompletionBlock)completionHandler {
	[self fetchPostsCreatedByUserWithID:user.userID completion:completionHandler];
}


- (void)fetchPostsCreatedByUserWithID:(NSString *)userID completion:(ANKClientCompletionBlock)completionHandler {
	[self getPath:[NSString stringWithFormat:@"users/%@/posts", userID]
	   parameters:nil
		  success:[self successHandlerForCollectionOfResourceClass:[ANKPost class] clientHandler:completionHandler]
		  failure:[self failureHandlerForClientHandler:completionHandler]];
}


// http://developers.app.net/docs/resources/post/streams/#retrieve-posts-mentioning-a-user

- (void)fetchPostsMentioningUser:(ANKUser *)user completion:(ANKClientCompletionBlock)completionHandler {
	[self fetchPostsMentioningUserWithID:user.userID completion:completionHandler];
}


- (void)fetchPostsMentioningUserWithID:(NSString *)userID completion:(ANKClientCompletionBlock)completionHandler {
	[self getPath:[NSString stringWithFormat:@"users/%@/mentions", userID]
	   parameters:nil
		  success:[self successHandlerForCollectionOfResourceClass:[ANKPost class] clientHandler:completionHandler]
		  failure:[self failureHandlerForClientHandler:completionHandler]];
}


// http://developers.app.net/docs/resources/post/streams/#retrieve-a-users-personalized-stream

- (void)fetchStreamForCurrentUserWithCompletion:(ANKClientCompletionBlock)completionHandler {
	[self getPath:@"posts/stream"
	   parameters:nil
		  success:[self successHandlerForCollectionOfResourceClass:[ANKPost class] clientHandler:completionHandler]
		  failure:[self failureHandlerForClientHandler:completionHandler]];
}


// http://developers.app.net/docs/resources/post/streams/#retrieve-a-users-unified-stream

- (void)fetchUnifiedStreamForCurrentUserWithCompletion:(ANKClientCompletionBlock)completionHandler {
	[self getPath:@"posts/stream/unified"
	   parameters:nil
		  success:[self successHandlerForCollectionOfResourceClass:[ANKPost class] clientHandler:completionHandler]
		  failure:[self failureHandlerForClientHandler:completionHandler]];
}


@end
