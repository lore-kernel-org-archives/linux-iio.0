Return-Path: <marten@intuitiveaerial.com>
Message-ID: <4D783517.1000605@intuitiveaerial.com>
Date: Thu, 10 Mar 2011 10:19:03 +0800
From: Marten Svanfeldt <marten@intuitiveaerial.com>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@cam.ac.uk>
CC: linux-iio@vger.kernel.org, michael.hennerich@analog.com
Subject: Re: [PATCH] IIO: trigger: New hrtimer based trigger driver
References: <4D70C8AA.4090300@cam.ac.uk> <1299679243-1318-2-git-send-email-marten@intuitiveaerial.com> <4D77D590.9090301@cam.ac.uk>
In-Reply-To: <4D77D590.9090301@cam.ac.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-ID: <linux-iio@vger.kernel.org>

On 2011-03-10 03:31, Jonathan Cameron wrote:
> Obviously run checkpatch over it at some point.
Will be done.

> Otherwise, nice clean little trigger driver.  After cleanup and
> testing I would be happy to see this in IIO.  Never realised it
> would be this simple :)
Looking over your comments I realized I forgot to pull over one part (or 
rather, thought I didn't need it but I do), which makes it a little bit 
more complex..

hrtimer callbacks are sent in hardirq context, which was OK in my 
driver, but as some IIO things involve SPI/I2C communications etc it 
needs to be moved over to a softirq setup. I will look into getting this 
fixed for a v2 patch.

>> +static enum hrtimer_restart iio_trig_hrtimer_trig(struct hrtimer *timer)
>> +{
>> +	struct iio_hrtimer_trig_info *trig_info = container_of(timer, struct iio_hrtimer_trig_info, timer);
>> +
>> +	iio_trigger_poll(trig_info->trigger, 0);
> Out of curiosity, how suceptible to drift is this?  I guess the timer doesn't take
> into account the amout of time this function takes, e.g how late are we by the time
> the timer is restarted?
This function is missing one line that updates the expiry time of the 
timer.. and the new expiry time is calculated based on the old time 
which means it should not drift at all. It can however "miss ticks" if 
the trigger poll takes longer than the interval.

>> +
>> +	trig_info->frequency = val;
> Only applied on trigger being stopped and restarted I think?
> Maybe return -EBUSY if the trigger is running to make this
> obvious to userspace.
Yes, I was unsure how to handle this properly.. I think I can make it 
update it properly if it is running though.

I'll have a v2 patch out in a couple of days, still untested as seems to 
be a few weeks before I get the second spin of our board on which I can 
run it.

Regards
Marten Svanfeldt
