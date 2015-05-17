Return-Path: <lars@metafoo.de>
Message-ID: <55587DCC.3050309@metafoo.de>
Date: Sun, 17 May 2015 13:38:52 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
 Peter Meerwald <pmeerw@pmeerw.net>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH 4/8] iio: __iio_update_buffers: Update mode before preenable/after
 postdisable
References: <1431525891-19285-1-git-send-email-lars@metafoo.de> <1431525891-19285-5-git-send-email-lars@metafoo.de> <55585AEA.5020907@kernel.org>
In-Reply-To: <55585AEA.5020907@kernel.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-iio@vger.kernel.org>

On 05/17/2015 11:10 AM, Jonathan Cameron wrote:
> On 13/05/15 15:04, Lars-Peter Clausen wrote:
>> It is clear that we transition to INDIO_DIRECT_MODE when disabling the
>> buffer(s) and it is also clear that we transition from INDIO_DIRECT_MODE
>> when enabling the buffer(s). So leaving the currentmode field
>> INDIO_DIRECT_MODE until after the preenable() callback and updating it to
>> INDIO_DIRECT_MODE before the postdisable() callback doesn't add additional
>> value. On the other hand some drivers will need to perform different
>> actions depending on which mode the device is going to operate in/was
>> operating in.
>>
>> Moving the update of currentmode before preenable() and after postdisable()
>> enables us to have drivers which perform mode dependent actions in those
>> callbacks.
> I'm not sure that the argument that drivers might do something that requires
> knowledge of this state in preenable or post disable is terribly relevant
> (as inherently the driver always knows what is going on in these callbacks!).

I have a driver which supports multiple different modes. And the selected 
mode depends on which type of buffer is attached. Depending on which mode 
got selected the driver has to do slightly different things in the callbacks.

But yea, this patch is a bit out of place in this series. I initially moved 
it up here since it made some of the other refactoring a bit easier. But I 
think that refactoring has been refactored so this is patch is no longer 
necessary. I'll drop it for now and resend it later in a context where it 
makes more sense.

>
> However, more interesting is the race conditions with drivers that cannot do
> direct reads when in buffered mode. There are presumably still race conditions
> in this region whatever we do here so it's up to the drivers to take appropriate
> locks - I suspect many do not and hence might generate garbage readings if
> a sysfs read is going on during the transition...
 >
 > I suppose adding additional states to say we are transitioning modes might be
 > useful.. Worth the bother?

We do hold the device lock for the whole duration of __iio_update_buffers(). 
So things should be ok as long as the driver holds the same lock when doing 
a direct conversion. If the driver does not then even adding additional 
states will not help.

Unfortunately most drivers currently do something like

	if (iio_buffer_enabled(indio_dev))
		return -EBUSY;
	do_direct_conversion(...)

So this is clearly broken at the moment. For one preenable() can already 
have been called and iio_buffer_enabled() still returns false. So that's 
something you could avoid having extra states. But there is nothing that 
prevents buffered mode from getting enabled right after the 
iio_buffer_enabled() check or even in the middle of do_direct_conversion(). 
So additional modes won't helper there only proper locking will do.

A few other drivers do something like:

	mutex_lock(&indio_dev->mlock);
	if (indio_dev->currentmode == INDIO_BUFFER_TRIGGERED) {
		ret = -EBUSY;
	} else {
		ret = do_direct_conversion(...);
	}
	mutex_unlock(&indio_dev->mlock);

This should be safe. Although we might want to add some helpers in the core 
that makes this a bit more straight forward and a bit more semantically 
expressive, maybe something like.

	if (!iio_device_claim_direct_mode(indio_dev))
		return -EBUSY;
	do_direct_conversion(...)
	iio_device_release_direct_mode(indio_dev);

iio_device_claim_direct_mode() returns false if the device is in buffered 
mode. If it returns true it is guaranteed that the device stays in direct 
mode until iio_device_release_direct_mode() is called. This makes sure that 
the driver can do a direction conversion without having to bother that the 
device might suddenly switch to buffered mode.

And while we should fix that, this is not necessarily part of the scope of 
this series.

- Lars
