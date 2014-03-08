Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:42217 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751639AbaCHRsW (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 8 Mar 2014 12:48:22 -0500
In-Reply-To: <531B3C25.90609@metafoo.de>
References: <5318CB62.2020103@kernel.org> <20140306193355.GA12474@kroah.com> <531B3C25.90609@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Subject: Re: [PULL] IIO new drivers, features and cleanups for 3.15 - set 3
From: Jonathan Cameron <jic23@kernel.org>
Date: Sat, 08 Mar 2014 17:48:20 +0000
To: Lars-Peter Clausen <lars@metafoo.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Linux IIO List <linux-iio@vger.kernel.org>
Message-ID: <9b323c4f-5efb-4d3e-a931-77285a3b3267@email.android.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org



On March 8, 2014 3:49:57 PM GMT+00:00, Lars-Peter Clausen <lars@metafoo.de> wrote:
>On 03/06/2014 08:33 PM, Greg Kroah-Hartman wrote:
>> On Thu, Mar 06, 2014 at 07:24:18PM +0000, Jonathan Cameron wrote:
>>> The following changes since commit
>aa256f8d0dd9c2dff872849418d8e09e5d06718f:
>>>
>>>    Merge tag 'iio-for-3.15b' of
>git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio into
>staging-next (2014-02-23 09:08:34 -0800)
>>>
>>> are available in the git repository at:
>>>
>>>
>>>    git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git
>tags/iio-for-3.15c
>>
>> Pulled and pushed out.
>>
>> What's the status of the remaining drivers/staging/iio/ stuff? 
>Anything
>> major keeping them from all moving out of staging sometime soon?
>
>I think we are past the point were we can move big chunks of drivers.
>The 
>drivers that are in good shape have already been moved. What's left has
>
>issues, some smaller, some bigger. Moving things out of staging is 
>progressing, but it is progressing one driver at a time.

I started looking at this on the train the other day.  Some drivers are pretty much there
 because their developer moved on and are simple enough that any updates are trivial. 
 I'll start the process of getting these moved sometime soonish. 

>
>- Lars
>
>--
>To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Sent from my Android phone with K-9 Mail. Please excuse my brevity.
