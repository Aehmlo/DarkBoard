%config(generator=internal)

%hook UIKBRenderConfig

%group Dark
- (BOOL)lightKeyboard{
	return NO;
}

%end

%group Default

- (BOOL)lightKeyboard{
	return %orig();
}

%end

%end


%ctor{ //There are so many things wrong with this method. Oh well.
	@autoreleasepool{
		NSDictionary *prefs;
		NSString *prefsPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Library/Preferences/com.aehmlo.darkboard.plist"];
		if([[NSFileManager defaultManager] fileExistsAtPath:prefsPath])
			prefs = [[NSDictionary alloc] initWithContentsOfFile:prefsPath];
		else{
			prefs = [@{@"Enabled": @YES} retain]; //Enabled by default. Still not the best practice, but it works.
			[prefs writeToFile:prefsPath atomically:YES];
		}

		//I know this is usually not how %groups are used.
		//Normally I would not do this, but as this tweak is supposed to be something to learn from, I went ahead and demonstrated how they work.
		//Hopefully somebody will find this useful in the future.

		//As the method hooked by this tweak is typically only called once, it doesn't make sense to do any more logic after the tweak is injected.
		//Hence the logic in the %ctor rather than in the hooked method.
		//If it were called multiple times per app launch, it would make sense to use notifications (in fact, this was originally what I did).
		//But not in this case.
		//So now this just serves as a %ctor/%group/%init example.
		//Hopefully it's helpful for somebody.
		if([prefs[@"Enabled"] boolValue] && ![prefs[[@"DisableFor-" stringByAppendingString:[[NSBundle mainBundle] bundleIdentifier]]] boolValue])
			%init(Dark);
		else %init(Default);
		[prefs release];
	}
}


//Well, this is one convoluted little tweak, but hopefully it got its point accross, and hopefully it helps somebody out someday.
//I promise, most of my code is better quality than this, but this does what it's supposed to.
//Enjoy.
//Also, who uses block comments? Losers. :P