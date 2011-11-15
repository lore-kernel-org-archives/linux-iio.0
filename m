Return-Path: <lars@metafoo.de>
Message-ID: <4EC2CB45.8030308@metafoo.de>
Date: Tue, 15 Nov 2011 21:27:49 +0100
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@kernel.org>
CC: Jonathan Cameron <jic23@cam.ac.uk>,
 Michael Hennerich <michael.hennerich@analog.com>,
 linux-iio@vger.kernel.org, device-drivers-devel@blackfin.uclinux.org,
 drivers@analog.com
Subject: Re: [PATCH] staging:iio: Add missing MODULE_DEVICE_TABLE and MODULE_ALIAS
References: <1321373655-14359-1-git-send-email-lars@metafoo.de> <4EC2C16B.5040400@kernel.org>
In-Reply-To: <4EC2C16B.5040400@kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

On 11/15/2011 08:45 PM, Jonathan Cameron wrote:
> On 11/15/2011 04:14 PM, Lars-Peter Clausen wrote:
>> Quite a few iio drivers provide no MODULE_DEVICE_TABLE or MODULE_ALIAS or only
>> provide a MODULE_ALIAS while they have support for multiple device ids. This
>> prevents auto module loading from working correctly.
>>
> Sensible patch.  I've never chased this down because I'm cynical and
> tend to specifically load drivers for my devices.  This will have
> fuzz all over the place, so you may end up rebasing to get it in.
> I'd like this to happen asap though as things are moderately quiet at
> the moment!

I'm don't use module auto loading myself that much, but these kind of issues
tend to spread as previous drivers are used as skeletons for new ones.

In regard to the fuzz, I've collected the IIO patches which were sent to GregKH
but haven't been applied yet[1] and based this patch on top of it.

Btw. I see you have a new email address. Which one should we send patches too?

>> This patch fixes it by adding the missing MODULE_DEVICE_TABLEs and
>> MODULE_ALIAS'.
>>
>> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> Acked-by: Jonathan Cameron <jic23@kernel.org>

Thanks
- Lars


[1] http://git.metafoo.de/?p=linux-2.6;a=shortlog;h=refs/heads/iio-queue
