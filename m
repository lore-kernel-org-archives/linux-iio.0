Return-Path: <jic23@kernel.org>
Message-ID: <4EC2C2E7.4030302@kernel.org>
Date: Tue, 15 Nov 2011 19:52:07 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Maxime Ripard <maxime.ripard@free-electrons.com>
CC: Jonathan Cameron <jic23@cam.ac.uk>, linux-iio@vger.kernel.org,
 thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: Re: More questions about IIO
References: <4EBB9CD7.4000408@free-electrons.com> <865baf2d-7cc9-4e22-bffd-8c007ba6bc72@email.android.com> <4EC2AA0A.4040205@free-electrons.com>
In-Reply-To: <4EC2AA0A.4040205@free-electrons.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On 11/15/2011 06:06 PM, Maxime Ripard wrote:
> Hi Jonathan,
> 
> Thanks for the first replies.
> 
> On 10/11/2011 11:03, Jonathan Cameron wrote:
>> On a train so will reply in more detail later.
>>
>> Maxime Ripard <maxime.ripard@free-electrons.com> wrote:
>>
>>> Hi Jonathan,
>>>
>>> Now that the work on the AT91 adc driver using software triggers looks
>>> well on its way to the kernel, I begin to work on hardware triggers for
>>> it.
>>>
>>> Few questions raise though.
>>>
>>> First, it seems that when using hardware triggers, we have to use the
>>> iio ring buffers.
>> There are patches against staging that allow a fake buffer that routes data to input or similar but it looks much the same from the driver.
> 
> Ok
> 
>>> So the first implementation that comes to my mind is this one :
>>> - The probe function actually sets up the driver, the triggers, the
>>> buffer, etc.
>> Creates infrastructure etc.
>>> - Each time an interrupt is raised, the handler either fill the buffer
>>> with the values of the activated channels or store it in a temporary
>>> variable just like I'm doing right now for the software triggers.
>> Interupt drives a trigger. That then calls the pollfunc which does the read into the buffer.  Note the trigger is associated with the device in userspace so can be provided by any device or indeed fake device. 
>>>  - When a user reads the sysfs file, either read from the buffer or
>> >from the temporary variable.
>> Yes. 
>>>
>>> But :
>>>  - Is it the right way to do so with iio ?
>> Not quite as explained... I will take a look at the datasheets later and try and point you at something similar in tree.
>>>  - Is there a way for the user to select at runtime if he wants only
>>> software trigger or hardware trigger (if they are enabled in the
>>> kernel) ?
>> Yup. Don't enable the buffer. I need to put in a single scan buffer for in kernel interface anyway so may make sense for you to use that on long run.
>>>  - What is the role of this pollfunc defined in the iio_dev struct ?
>> Equivalent of threaded interupt to be run on a data ready or capture now interupt.
> 
> I'm confused here. You said earlier that the pollfunc was reading from
> the buffer. But if it is similar to a threaded interrupt, I'm more
> expecting it to be writing into the buffer, no ? Or there is two buffers ?
Nope. It reads data and pushes it to the buffer. It is basically a
threaded interrupt - wrapped up somewhat for convenience.  The enabling
of the relevant interrupt occurs in iio_triggered_buffer_postenable.
Actually it only gets one from the per trigger poll of interrupts at
this stage.  Until then there is no point.
> 
>>> Also, the ADC has 4 external trigger sources, which are selected
>>> through
>>> a register. 3 of them are muxed pins, so the pins available varies from
>>> one board to another. Is there a way for the user at runtime to select
>>> the source he wants ?
>> Yes create lots of triggers. 
> 
> Ok, fine by me :)
> 
>>> Finally, this ADC supports two resolutions : 8 and 10 bit. For now,
>>> only
>>> 10 bit resolution is supported, but the user might want to use 8 bit.
>>> Is
>>> there a way to do so ?
>> Never seen a use case for sysfs users. Can in theory control it for buffered data but I think the core support is missing. Sca3000 used to do it.
> 
> Ok
> 
