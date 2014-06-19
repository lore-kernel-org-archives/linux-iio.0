Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-116.synserver.de ([212.40.185.116]:1046 "EHLO
	smtp-out-113.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752560AbaFSK5z (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 19 Jun 2014 06:57:55 -0400
Message-ID: <53A2C22E.3060409@metafoo.de>
Date: Thu, 19 Jun 2014 12:57:50 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@kernel.org>
CC: Denis CIOCCA <denis.ciocca@st.com>, linux-iio@vger.kernel.org
Subject: Re: IIO hrtimer trigger
References: <1380483412-13458-1-git-send-email-denis.ciocca@st.com> <524DA508.2030606@metafoo.de> <5251A8BE.9000309@kernel.org> <5252C2CF.8080609@metafoo.de> <53A1ECBC.3010501@kernel.org>
In-Reply-To: <53A1ECBC.3010501@kernel.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 06/18/2014 09:47 PM, Jonathan Cameron wrote:
> On 07/10/13 15:18, Lars-Peter Clausen wrote:
>> On 10/06/2013 08:15 PM, Jonathan Cameron wrote:
>>> On 10/03/13 18:10, Lars-Peter Clausen wrote:
>>>> On 09/29/2013 09:36 PM, Denis CIOCCA wrote:
>>>>> Hi Lars,
>>>>>
>>>>> Thanks for your review.
>>>>> I reviewed the code in accordance with your comments, for the other point
>>>>> can you explain me better please?
>>>>> You intend to use one driver to manage all triggers added by sysfs?
>>>>
>>>> Not necessarily, but I think we should have some common code that manages
>>>> the software triggers.
>>> That is fair enough.
>>>
>>>> But what I'm most concerned about is the userspace
>>>> ABI, since once we have added it, we have to maintain it forever. So the
>>>> big
>>>> question do we think that the current ABI implemented by that patch is good
>>>> enough.
>>> We are pretty much stuck with that for the sysfs trigger already...
>>
>> Unfortunately yes. I never liked its API and I still don't like it and we
>> have to live with it. But this doesn't mean we have to add more of the same.
>>
>>>
>>>> Some thoughts:
>>>>
>>>> * Should it maybe be called timer instead of hrtimer.
>>> Agreed.
>>>> * Do we only want to allow names which follow "hrtimer-%d" or do we want to
>>>> allow arbitrary names.
>>> Arbitary would be fine.
>>>> * Do we want to have a top-level folder for each sw trigger type
>>> I'm not that bothered about this we are hardly talking a huge number of such
>>> folders.
>>>> * Is sysfs actually the right place for this, or should it go into
>>>> configfs?
>>>>    Quote from Documentation/filesystems/configs:
>>>>    "configfs is a ram-based filesystem that provides the converse of
>>>>     sysfs's functionality.  Where sysfs is a filesystem-based view of
>>>>     kernel objects, configfs is a filesystem-based manager of kernel
>>>>     objects, or config_items. [...] Unlike sysfs, the
>>>>     lifetime of the representation is completely driven by userspace.  The
>>>>     kernel modules backing the items must respond to this."
>>> Hmm. maybe, I'm not sure how cleanly this would work and it adds an
>>> additional
>>> dependency for all these types of drivers.  I'll take the lazy option:
>>> Go on Lars, put together a full proposal on the actual interface ;)
>>
>> I'll do that but that might take a few weeks until I get to it.
> Bump.  Do we want to still wait for this, or should we just go ahead with the
> hrtimer as is.  It may not be ideal, but it's useful and lets us kill off
> some much worse options..

I'd really prefer to not compromise on user-space ABI. Quick hacks are 
sometimes fine for kernel internal things since we can clean them up later. 
But for userspace ABI we'll be stuck with it forever.

