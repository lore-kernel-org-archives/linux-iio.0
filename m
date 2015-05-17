Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:59717 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752725AbbEQLoG (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 17 May 2015 07:44:06 -0400
Message-ID: <55587F04.3000701@kernel.org>
Date: Sun, 17 May 2015 12:44:04 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald <pmeerw@pmeerw.net>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH 4/8] iio: __iio_update_buffers: Update mode before preenable/after
 postdisable
References: <1431525891-19285-1-git-send-email-lars@metafoo.de> <1431525891-19285-5-git-send-email-lars@metafoo.de> <55585AEA.5020907@kernel.org> <55587DCC.3050309@metafoo.de>
In-Reply-To: <55587DCC.3050309@metafoo.de>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 17/05/15 12:38, Lars-Peter Clausen wrote:
> On 05/17/2015 11:10 AM, Jonathan Cameron wrote:
>> On 13/05/15 15:04, Lars-Peter Clausen wrote:
>>> It is clear that we transition to INDIO_DIRECT_MODE when disabling the
>>> buffer(s) and it is also clear that we transition from INDIO_DIRECT_MODE
>>> when enabling the buffer(s). So leaving the currentmode field
>>> INDIO_DIRECT_MODE until after the preenable() callback and updating it to
>>> INDIO_DIRECT_MODE before the postdisable() callback doesn't add additional
>>> value. On the other hand some drivers will need to perform different
>>> actions depending on which mode the device is going to operate in/was
>>> operating in.
>>>
>>> Moving the update of currentmode before preenable() and after postdisable()
>>> enables us to have drivers which perform mode dependent actions in those
>>> callbacks.
>> I'm not sure that the argument that drivers might do something that requires
>> knowledge of this state in preenable or post disable is terribly relevant
>> (as inherently the driver always knows what is going on in these
>> callbacks!).
> 
> I have a driver which supports multiple different modes. And the
> selected mode depends on which type of buffer is attached. Depending
> on which mode got selected the driver has to do slightly different
> things in the callbacks.
> 
> But yea, this patch is a bit out of place in this series. I initially
> moved it up here since it made some of the other refactoring a bit
> easier. But I think that refactoring has been refactored so this is
> patch is no longer necessary. I'll drop it for now and resend it
> later in a context where it makes more sense.
>>
>> However, more interesting is the race conditions with drivers that cannot do
>> direct reads when in buffered mode. There are presumably still race conditions
>> in this region whatever we do here so it's up to the drivers to take appropriate
>> locks - I suspect many do not and hence might generate garbage readings if
>> a sysfs read is going on during the transition...
>>
>> I suppose adding additional states to say we are transitioning modes might be
>> useful.. Worth the bother?
> 
> We do hold the device lock for the whole duration of
> __iio_update_buffers(). So things should be ok as long as the driver
> holds the same lock when doing a direct conversion. If the driver
> does not then even adding additional states will not help.
> Unfortunately most drivers currently do something like
> 
>     if (iio_buffer_enabled(indio_dev))
>         return -EBUSY;
>     do_direct_conversion(...)
Exactly what I meant (my fault as I did it first, but that was a long time ago!)

> 
> So this is clearly broken at the moment. For one preenable() can
> already have been called and iio_buffer_enabled() still returns
> false. So that's something you could avoid having extra states. But
> there is nothing that prevents buffered mode from getting enabled
> right after the iio_buffer_enabled() check or even in the middle of
> do_direct_conversion(). So additional modes won't helper there only
> proper locking will do.> 
Agreed.
> A few other drivers do something like:
> 
>     mutex_lock(&indio_dev->mlock);
>     if (indio_dev->currentmode == INDIO_BUFFER_TRIGGERED) {
>         ret = -EBUSY;
>     } else {
>         ret = do_direct_conversion(...);
>     }
>     mutex_unlock(&indio_dev->mlock);
> 
> This should be safe. Although we might want to add some helpers in
> the core that makes this a bit more straight forward and a bit more
> semantically expressive, maybe something like.
> 
>     if (!iio_device_claim_direct_mode(indio_dev))
>         return -EBUSY;
>     do_direct_conversion(...)
>     iio_device_release_direct_mode(indio_dev);
> 
> iio_device_claim_direct_mode() returns false if the device is in
> buffered mode. If it returns true it is guaranteed that the device
> stays in direct mode until iio_device_release_direct_mode() is
> called. This makes sure that the driver can do a direction conversion
> without having to bother that the device might suddenly switch to
> buffered mode.
Makes sense.
> 
> And while we should fix that, this is not necessarily part of the
> scope of this series.
Agreed.
> 
> - Lars
> 

