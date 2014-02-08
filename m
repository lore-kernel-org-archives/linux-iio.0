Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:40952 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751140AbaBHLgh (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 8 Feb 2014 06:36:37 -0500
Message-ID: <52F616E2.2000706@kernel.org>
Date: Sat, 08 Feb 2014 11:37:06 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Peter Meerwald <pmeerw@pmeerw.net>
CC: linux-iio@vger.kernel.org, Kravchenko Oleksandr <x0199363@ti.com>,
	Oleksandr Kravchenko <o.v.kravchenko@globallogic.com>
Subject: Re: [PATCH 1/2] iio:accel:bma180: Use modifier instead of index in
 channel specification
References: <1389389841-7389-1-git-send-email-pmeerw@pmeerw.net> <52D12D6C.2020007@kernel.org> <alpine.DEB.2.01.1401111602360.9334@pmeerw.net>
In-Reply-To: <alpine.DEB.2.01.1401111602360.9334@pmeerw.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 11/01/14 15:25, Peter Meerwald wrote:
> Hello,
>
>>> should use channel modifiers (X/Y/Z), not channel indices
>>> timestamp channel has scan index 3, not 4
>>>
>> Aag.  Whilst a correct fix, this is going to result in a userspace ABI
>> change.  Driver has been in since 3.12.  We may need to maintain
>> both ABI's for now and then deprecate it at some point.  Easiest way to do
>> this
>> will be to have two sets of iio_chan_specs pointing at the same underlying
>> real channels.
>>
>> Anyone have a strong opinion about this?
>> Good spot by the way!
>
> adding another email address of Oleksandr, x0199363@ti.com bounces
>
> the IIO ABI is under "testing", not "stable" so the interface may be
> changed due to 'grave errors'
>
> given the short timespan since 3.12 and the clear violation of the
> documented ABI, I think this should just be fixed
Fine, I've applied this to fixes-togreg and marked it for stable.
>
> another suggestion:
>
> often (at least for me) it is difficult to figure out what the user-space
> sysfs ABI is from reading the source code and I find it even more
> difficult to sometimes guess what a particular sysfs is supposed to do
> (e.g. what writing to a _scale actually sets in terms of the hardware);
>
> I'd like to suggest to ask for a listing of the sysfs entries relating
> to a new driver under review (e.g. the output of 'find
> /sys/bus/iio/devices/iio:deviceX'); it should be feasible to provide a
> tool which compares the submitted listing against the sysfs-bus-iio
> documentation and output appropriate warnings
It would certainly be helpful to do this. I'll start asking for complex
drivers, but am not going to bother for really simple ones.
(obviously I'd be happy if the cover letter contained it in all drivers!)
>
> regards, p.
>
>>> Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
>>> Cc: Kravchenko Oleksandr <x0199363@ti.com>
>>> ---
>>>    drivers/iio/accel/bma180.c | 16 ++++++++--------
>>>    1 file changed, 8 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/drivers/iio/accel/bma180.c b/drivers/iio/accel/bma180.c
>>> index 3bec922..bfec313 100644
>>> --- a/drivers/iio/accel/bma180.c
>>> +++ b/drivers/iio/accel/bma180.c
>>> @@ -447,14 +447,14 @@ static const struct iio_chan_spec_ext_info
>>> bma180_ext_info[] = {
>>>    	{ },
>>>    };
>>>
>>> -#define BMA180_CHANNEL(_index) {					\
>>> +#define BMA180_CHANNEL(_axis) {					\
>>>    	.type = IIO_ACCEL,						\
>>> -	.indexed = 1,							\
>>> -	.channel = (_index),						\
>>> +	.modified = 1,							\
>>> +	.channel2 = IIO_MOD_##_axis,					\
>>>    	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |			\
>>>    		BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY),	\
>>>    	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),		\
>>> -	.scan_index = (_index),						\
>>> +	.scan_index = AXIS_##_axis,					\
>>>    	.scan_type = {							\
>>>    		.sign = 's',						\
>>>    		.realbits = 14,						\
>>> @@ -465,10 +465,10 @@ static const struct iio_chan_spec_ext_info
>>> bma180_ext_info[] = {
>>>    }
>>>
>>>    static const struct iio_chan_spec bma180_channels[] = {
>>> -	BMA180_CHANNEL(AXIS_X),
>>> -	BMA180_CHANNEL(AXIS_Y),
>>> -	BMA180_CHANNEL(AXIS_Z),
>>> -	IIO_CHAN_SOFT_TIMESTAMP(4),
>>> +	BMA180_CHANNEL(X),
>>> +	BMA180_CHANNEL(Y),
>>> +	BMA180_CHANNEL(Z),
>>> +	IIO_CHAN_SOFT_TIMESTAMP(3),
>>>    };
>>>
>>>    static irqreturn_t bma180_trigger_handler(int irq, void *p)
>>>
>>
>

