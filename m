Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wg0-f45.google.com ([74.125.82.45]:39309 "EHLO
	mail-wg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751081AbbBEVgE (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 5 Feb 2015 16:36:04 -0500
Received: by mail-wg0-f45.google.com with SMTP id x12so9993760wgg.4
        for <linux-iio@vger.kernel.org>; Thu, 05 Feb 2015 13:36:02 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <54D25209.2050809@kernel.org>
References: <1419122556-8100-1-git-send-email-octavian.purdila@intel.com>
	<1419122556-8100-5-git-send-email-octavian.purdila@intel.com>
	<54A96525.2030200@kernel.org>
	<CAE1zot+7DdscD6+D=XaX08Fpsbdheqn6OUPMSZYEMoRqV2m+rw@mail.gmail.com>
	<54D25209.2050809@kernel.org>
Date: Thu, 5 Feb 2015 23:36:02 +0200
Message-ID: <CAE1zot+9S__23yT3AVxPY-g1dp4OBRv8iqU9XG=UithgZ-FZwg@mail.gmail.com>
Subject: Re: [PATCH v2 04/11] iio: add support for hardware fifo
From: Octavian Purdila <octavian.purdila@intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, Feb 4, 2015 at 7:08 PM, Jonathan Cameron <jic23@kernel.org> wrote:
> On 05/01/15 11:29, Octavian Purdila wrote:
>> On Mon, Jan 5, 2015 at 2:07 AM, Jonathan Cameron <jic23@kernel.org> wrote:
>>> On 21/12/14 00:42, Octavian Purdila wrote:
>>>
>>> Thanks for taking this on!
>>>
>>> This all looks fairly sensible, though a few comments inline.
>>> One big semantic change I'd suggest is to allow the watermark
>>> level passed to the hardware to be a 'hint' rather than a hard
>>> and fast rull.  A lot of these hardware buffers are fairly small
>>> (perhaps 32 entries) and the devices can run fast so whilst
>>> we will obviously have to handle an interrupt often, we may well
>>> want to have a much larger software front end buffer with a
>>> much larger watermark.  For example, a 8192Hz accelerometer
>>> with 32 entry fifo (watermark at 16).  Will fire an interrupt 512 times
>>> a second.  Userspace might be only interested in getting data 32 times
>>> a second and hence want a watermark of 256 entries and probably have
>>> a buffer that is 512 entries long or more.
>>>
>>
>> Very good point with the above example, but I find the hint approach a
>> bit too hard to diagnose and tune by the application.
>>
>> Could we perhaps expose the hwfifo watermark as well, in addition to
>> the software watermark? We can even keep the hint behavior if the
>> application only touches the software watermark, but if it the
>> application directly sets the hwfifo level then we use that.
> Hmm. Not sure how well this would work.  We probably need a way of indicating
> the hardware buffer has not been 'pinned' to a particular value.
> Maybe we can have it read only?
> That way it is obvious what effect the 'hint' is having on the hardware
> without adding a confusing double control for the same thing...

Yeah, the double control do seem confusing...

>>> Hmm. I wonder to a degree if the trigger approach really makes sense for
>>> fifo equiped devices.  We've deliberately not added one in a few existing
>>> cases.
>>>
>>> Otherwise, is there a reason to run this separately from a trigger not using
>>> the fifo.  Surely that's just the same as a watermark of 1?
>>>
>>> Anyhow, a point for discussion!
>>
>> I might be misunderstand you here, but the reason for which we use a
>> separate trigger is to have a way to enable/disable FIFO mode, because
>> enabling the FIFO might have some downsides, e.g. more power
>> consumption. This matters only when the application is interested in
>> low latency sampling ( watermark of 1).
> Perhaps we use a watermark of one to disable the fifo if present.  Can't
> think why you'd want it under those circumstances unless the data can't
> be read without.  This then becomes a driver issue as all the core
> cares about is that the data turns up, not particularly whether it very
> briefly bounces through a buffer or not.
>>

There is another reason to use a trigger to enable/disable the FIFO.

Lets take the bmc150 driver and say that the user sets the any-motion
trigger. In this case we only get data in the buffer when the
accelerometer is moved regardless of sample_frequency. Now, if we
enable the FIFO, the user might expect to see this behavior unchanged
- get data only when the accelerometer is moved. With BMC150's FIFO
this is not true, the FIFO will be filled with data at the
sample_frequency. We effectively switched to a data ready trigger.

>> Yeah, I wanted to add some checks in the core to make sure that if the
>> driver is registering the hwfifo ops then it should allocate and
>> register a watermark trigger as well. If we decide to go with the
>> trigger approach, do you think it is a good idea to add the checks?
>>
> If so, but I'll be honest I really don't like the trigger approach here.
> It feels like an abuse of an interface that is really there to allow
> synchronized capture/ controllable capture on devices without fixed
> timing... (when they are fixed, the point is really to allow other
> non fixed devices to lock on and sample at the same time - very handy
> for inertial data fusion and other places...)

Ah, I was not aware of what the trigger abstraction was intended for.
I always thought it was the equivalent of a device interrupt so it
felt natural to me to implement it as a trigger.
