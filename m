Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:38750 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752020AbbBHKxG (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 8 Feb 2015 05:53:06 -0500
Message-ID: <54D7400F.2070300@kernel.org>
Date: Sun, 08 Feb 2015 10:53:03 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Octavian Purdila <octavian.purdila@intel.com>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v2 04/11] iio: add support for hardware fifo
References: <1419122556-8100-1-git-send-email-octavian.purdila@intel.com>	<1419122556-8100-5-git-send-email-octavian.purdila@intel.com>	<54A96525.2030200@kernel.org>	<CAE1zot+7DdscD6+D=XaX08Fpsbdheqn6OUPMSZYEMoRqV2m+rw@mail.gmail.com>	<54D25209.2050809@kernel.org> <CAE1zot+9S__23yT3AVxPY-g1dp4OBRv8iqU9XG=UithgZ-FZwg@mail.gmail.com>
In-Reply-To: <CAE1zot+9S__23yT3AVxPY-g1dp4OBRv8iqU9XG=UithgZ-FZwg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 05/02/15 21:36, Octavian Purdila wrote:
> On Wed, Feb 4, 2015 at 7:08 PM, Jonathan Cameron <jic23@kernel.org> wrote:
>> On 05/01/15 11:29, Octavian Purdila wrote:
>>> On Mon, Jan 5, 2015 at 2:07 AM, Jonathan Cameron <jic23@kernel.org> wrote:
>>>> On 21/12/14 00:42, Octavian Purdila wrote:
>>>>
>>>> Thanks for taking this on!
>>>>
>>>> This all looks fairly sensible, though a few comments inline.
>>>> One big semantic change I'd suggest is to allow the watermark
>>>> level passed to the hardware to be a 'hint' rather than a hard
>>>> and fast rull.  A lot of these hardware buffers are fairly small
>>>> (perhaps 32 entries) and the devices can run fast so whilst
>>>> we will obviously have to handle an interrupt often, we may well
>>>> want to have a much larger software front end buffer with a
>>>> much larger watermark.  For example, a 8192Hz accelerometer
>>>> with 32 entry fifo (watermark at 16).  Will fire an interrupt 512 times
>>>> a second.  Userspace might be only interested in getting data 32 times
>>>> a second and hence want a watermark of 256 entries and probably have
>>>> a buffer that is 512 entries long or more.
>>>>
>>>
>>> Very good point with the above example, but I find the hint approach a
>>> bit too hard to diagnose and tune by the application.
>>>
>>> Could we perhaps expose the hwfifo watermark as well, in addition to
>>> the software watermark? We can even keep the hint behavior if the
>>> application only touches the software watermark, but if it the
>>> application directly sets the hwfifo level then we use that.
>> Hmm. Not sure how well this would work.  We probably need a way of indicating
>> the hardware buffer has not been 'pinned' to a particular value.
>> Maybe we can have it read only?
>> That way it is obvious what effect the 'hint' is having on the hardware
>> without adding a confusing double control for the same thing...
> 
> Yeah, the double control do seem confusing...
> 
>>>> Hmm. I wonder to a degree if the trigger approach really makes sense for
>>>> fifo equiped devices.  We've deliberately not added one in a few existing
>>>> cases.
>>>>
>>>> Otherwise, is there a reason to run this separately from a trigger not using
>>>> the fifo.  Surely that's just the same as a watermark of 1?
>>>>
>>>> Anyhow, a point for discussion!
>>>
>>> I might be misunderstand you here, but the reason for which we use a
>>> separate trigger is to have a way to enable/disable FIFO mode, because
>>> enabling the FIFO might have some downsides, e.g. more power
>>> consumption. This matters only when the application is interested in
>>> low latency sampling ( watermark of 1).
>> Perhaps we use a watermark of one to disable the fifo if present.  Can't
>> think why you'd want it under those circumstances unless the data can't
>> be read without.  This then becomes a driver issue as all the core
>> cares about is that the data turns up, not particularly whether it very
>> briefly bounces through a buffer or not.
>>>
> 
> There is another reason to use a trigger to enable/disable the FIFO.
> 
> Lets take the bmc150 driver and say that the user sets the any-motion
> trigger. In this case we only get data in the buffer when the
> accelerometer is moved regardless of sample_frequency. Now, if we
> enable the FIFO, the user might expect to see this behavior unchanged
> - get data only when the accelerometer is moved. With BMC150's FIFO
> this is not true, the FIFO will be filled with data at the
> sample_frequency. We effectively switched to a data ready trigger.
Hmm. They way to stop that would be to prevent the fifo being enabled
if the any-motion trigger is enabled.  Effectively the hardware doesn't
support doing this in a coherent (e.g. vaguely expected!) way.

This is getting a little tricky.  My general concept of this would normally
say that a hardware fifo and trigger are mutually exclusive.  We've effectively
never seen both in a single driver before.

I can see it might be a little confusing to have to 'unset' the trigger if
the fifo is to be used.  The question is which is worse from a usability
point of view?  From a control point of view, both are fine - we can do
what we want either way.

So options:

1) Have a 'fake' trigger for the hardware fifo. This trigger is set to reject
   any other devices binding to it.

2) Use no trigger when enabling the hardware fifo.  Basically if the buffer
   is enabled with no trigger and a watermark of greater than 1 it will go
   through the fifo.  If watermark is 1 it won't (or at least userspace will
   think it looks like it doesn't).  If a trigger is selected, then the
   watermark for the software buffer will work as normal, but the hardware
   fifo will be disabled (and this will be reflected in the hw_watermark
   value if read).

The second option corresponds to what our few existing hardware buffered drivers
effectively do.  Be it that they don't have a trigger consumer registered so
no one would try to set a trigger!
> 
>>> Yeah, I wanted to add some checks in the core to make sure that if the
>>> driver is registering the hwfifo ops then it should allocate and
>>> register a watermark trigger as well. If we decide to go with the
>>> trigger approach, do you think it is a good idea to add the checks?
>>>
>> If so, but I'll be honest I really don't like the trigger approach here.
>> It feels like an abuse of an interface that is really there to allow
>> synchronized capture/ controllable capture on devices without fixed
>> timing... (when they are fixed, the point is really to allow other
>> non fixed devices to lock on and sample at the same time - very handy
>> for inertial data fusion and other places...)
> 
> Ah, I was not aware of what the trigger abstraction was intended for.
> I always thought it was the equivalent of a device interrupt so it
> felt natural to me to implement it as a trigger.
It's always been an interesting corner as it's sometimes helpful for
events to trigger data capture (e.g. the anymotion-triggers).
At somepoint I'd like to figure out how to allow any iio event
to act as at trigger in a generic fashion.  Keeping the interface
clean for that might however be a pain.  Probably more of the configfs
magic that we've discussed on the list before (and I keep making a
start on but never finishing!)

Jonathan
