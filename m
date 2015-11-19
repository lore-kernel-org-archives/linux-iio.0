Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f50.google.com ([74.125.82.50]:34226 "EHLO
	mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756230AbbKSJP4 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 19 Nov 2015 04:15:56 -0500
Received: by wmvv187 with SMTP id v187so15132355wmv.1
        for <linux-iio@vger.kernel.org>; Thu, 19 Nov 2015 01:15:55 -0800 (PST)
Subject: Re: [RFC 8/9] iio: buffer: allow for last-second trigger spawning
 from device driver
To: Jonathan Cameron <jic23@kernel.org>, knaack.h@gmx.de,
	lars@metafoo.de, pmeerw@pmeerw.net
References: <1447857515-23935-1-git-send-email-mtitinger@baylibre.com>
 <1447857515-23935-9-git-send-email-mtitinger@baylibre.com>
 <564CC9B4.7010207@kernel.org>
Cc: daniel.baluta@intel.com, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org
From: Marc Titinger <mtitinger@baylibre.com>
Message-ID: <564D9349.40306@baylibre.com>
Date: Thu, 19 Nov 2015 10:15:53 +0100
MIME-Version: 1.0
In-Reply-To: <564CC9B4.7010207@kernel.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 18/11/2015 19:55, Jonathan Cameron wrote:
> On 18/11/15 14:38, Marc Titinger wrote:
>> The hrtimer sw-trigger allow for polling mode on devices w/o hard irq
>> trigger source, but setting the frequency from userland for both the
>> hrtimer trigger device and the adc is error prone.
>>
>> Make adc drivers able to setup the sw-trigger at the last second when the
>> buffer is enabled, and the sampling frequency is known.
> Hi Marc,
>
> This statement rang alarm bells.  We are trying to cross synchronize a timer
> on the processor with that on the device.  Doing this is ALWAYS going to end
> up dropping or duplicating samples depending on whether we happen to run faster
> or slower than the sample rate.
>
Yup, I had a hunch this was an issue, I understand this is not something 
you guys want to generally support in IIO since it should allow for 
reliable signal processing!

> Now I've done a spot of datasheet diving to see if there is a status register or
> other indication that we are looking at new data (if there isn't one, then any
> attempt to get a stream of data off the device is going to give us a mess unfortunately)
>
> Anyhow, on the INA219 we have a CNVR bit in the bus voltage register which will do as it
> it's semantics are described in the datasheet and it's basically a 'you haven't read
> me before bit'
>
> The INA226 seems to have a CVRF bit (nothing like consistency in naming ;) that indicates
> the 'dataready / alert pin' was set high to indicate new data - so you may need to enable
> the interrupt pin even if you don't have it wired to anything useful.
>
> Anyhow, so we have discussed how to handle this in the past (though right now I can't
> remember the device in question so will be fun to find).  The case it came up for was
> a board where the interrupt pin on a device wasn't wired to anything (or perhaps a stripped
> down package in which the sensor didn't have a pin for it - I can't recall).
>
>   First thing to note is that you 'don't' have to use a trigger to drive a buffer.
> This makes our life rather easier!  Here we don't have a timing signal that is terribly
> useful for any other sensors to use so a trigger won't be much real use.
>
> Once we have dropped that requirement you do end up with something close to the
> strategy you adopted in the first patch with a small twist.
>
> You need to check those 'dataready' register bits to decide whether to push anything
> at all to the buffer.

Ok yes, I can check that dataready bit, and only push new values with a 
usable timestamp. So I shall go back to my polling thread version with 
that addition. I'm just concerned that It is one more register to read 
while part of this work was to increase the bandwidth of our 
apllication. Our hwmon sigrok layer would reissue the last value anyhow 
if the hardware is not ready for a new sample, so a bit of clock jitter 
was ok for my purpose.

Alternatively, I could check if the cnvr signal can be configured as an 
alarm and routed to a gpio irq, and then use a conventional trigger.

>
> So basically you need your thread to always query significantly faster than the sampling
> rate and to push data directly into the buffer iff the device indicates it is new data.
> (not the significantly is to ensure that the you get one clean full set of readings within the sample period - I'm not sure the docs were all that specific on what happens if you hit
> the sampling point in your read - maybe I missed it!)
>
> The hrtimer trigger etc make a lot of sense for sample of demand devices, but
> they will result in inconsistent data if used to sample a self clocking device like
> this one.
>
> I recall we discussed once how to do this generically and concluded that it really
> isn't easy to do so as it involves polling a local register on a given device.
>
> Sorry I didn't pick up on this earlier.

No worries, I'm happy to experiment and gain understanding of the 
features of IIO, I'm sorry it cost you guys review time though, _and_ it 
is still getting onto something useful :)

Marc.


>
> Jonathan
>
>>
>> enable_trigger is called from verify_update, before the classical setup_ops
>> are called in buffers_enable. This gives a chance to complete the setup of
>> indio_dev->trig.
>>
>> Signed-off-by: Marc Titinger <mtitinger@baylibre.com>
>> ---
>>   drivers/iio/industrialio-buffer.c | 5 +++++
>>   include/linux/iio/iio.h           | 3 +++
>>   2 files changed, 8 insertions(+)
>>
>> diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
>> index d7e908a..ba7abd4 100644
>> --- a/drivers/iio/industrialio-buffer.c
>> +++ b/drivers/iio/industrialio-buffer.c
>> @@ -647,6 +647,11 @@ static int iio_verify_update(struct iio_dev *indio_dev,
>>   	if (insert_buffer)
>>   		modes &= insert_buffer->access->modes;
>>
>> +	if (indio_dev->setup_ops &&
>> +	    indio_dev->setup_ops->enable_trigger &&
>> +	   (indio_dev->setup_ops->enable_trigger(indio_dev) < 0))
>> +		return -ENXIO;
>> +
>>   	/* Definitely possible for devices to support both of these. */
>>   	if ((modes & INDIO_BUFFER_TRIGGERED) && indio_dev->trig) {
>>   		config->mode = INDIO_BUFFER_TRIGGERED;
>> diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
>> index 7bb7f67..8f82113 100644
>> --- a/include/linux/iio/iio.h
>> +++ b/include/linux/iio/iio.h
>> @@ -419,6 +419,8 @@ struct iio_info {
>>
>>   /**
>>    * struct iio_buffer_setup_ops - buffer setup related callbacks
>> + * @enable_trigger:	[DRIVER] function to call if a trigger is instancied
>> + *				 upon enabling the buffer (sw triggers)
>>    * @preenable:		[DRIVER] function to run prior to marking buffer enabled
>>    * @postenable:		[DRIVER] function to run after marking buffer enabled
>>    * @predisable:		[DRIVER] function to run prior to marking buffer
>> @@ -428,6 +430,7 @@ struct iio_info {
>>    *			scan mask is valid for the device.
>>    */
>>   struct iio_buffer_setup_ops {
>> +	int (*enable_trigger)(struct iio_dev *);
>>   	int (*preenable)(struct iio_dev *);
>>   	int (*postenable)(struct iio_dev *);
>>   	int (*predisable)(struct iio_dev *);
>>
>

