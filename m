Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-ea0-f175.google.com ([209.85.215.175]:54152 "EHLO
	mail-ea0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754247Ab3ALW0V convert rfc822-to-8bit (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 12 Jan 2013 17:26:21 -0500
Received: by mail-ea0-f175.google.com with SMTP id d1so27606eab.34
        for <linux-iio@vger.kernel.org>; Sat, 12 Jan 2013 14:26:20 -0800 (PST)
Content-Type: text/plain; charset=US-ASCII
Mime-Version: 1.0 (Mac OS X Mail 6.2 \(1499\))
Subject: Re: iio: STMicroelectronics iio drivers bugfix
From: Denis Ciocca <denis.ciocca@gmail.com>
In-Reply-To: <50F1DD83.2080301@kernel.org>
Date: Sat, 12 Jan 2013 23:20:38 +0100
Cc: Denis CIOCCA <denis.ciocca@st.com>, lars@metafoo.de,
	linux-iio@vger.kernel.org
Message-Id: <026421CD-F2C7-4655-A357-A58ECA635895@gmail.com>
References: <1357733221-6248-1-git-send-email-denis.ciocca@st.com> <50F1DD83.2080301@kernel.org>
To: Jonathan Cameron <jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Jonathan,

thanks for your comments and your support to my works!


> Just a quick email to say I'm very happy with the state these patches are
> now in.

me too...:)


> I have one utterly trivial point on patch 1 but am happy to fix
> that up during the merge.  (Basically you type cast a parameter to u16 instead
> of __le16).

no problem, in this days I can review and fix this issue.


> Also right now I've only looked at 1 and 2 (assuming the others are
> very similar for obvious reasons!) I will give them a look before merging
> just in case anything slipped by.

Yeah, the other patchs are very very similar.


> Thanks for all your work on these. When I get some time I'll see what is needed
> to add support for the lis3l02dq to this driver.  From what I recall that
> chip is a little dumber than some of the newer ones and needs some uggly
> interrupt handling trickery.  Given it's an ancient chip I doubt it is
> terribly high on your list to support.  I just happen to have one on my
> test board so it's always been of inordinate interest to me ;)

If I have a little bit of time, I can check what is needed to add support for the lis3l02dq!



Denis

