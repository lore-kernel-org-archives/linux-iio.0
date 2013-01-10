Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-053.synserver.de ([212.40.185.53]:1212 "EHLO
	smtp-out-052.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753090Ab3AJQ3k (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 10 Jan 2013 11:29:40 -0500
Message-ID: <50EEEC9E.8020508@metafoo.de>
Date: Thu, 10 Jan 2013 17:30:22 +0100
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@kernel.org>
CC: James Peverill <arsenix@gmail.com>, linux-iio@vger.kernel.org,
	"Hennerich, Michael" <Michael.Hennerich@analog.com>
Subject: Re: IIO for soft realtime control?
References: <loom.20130106T050717-736@post.gmane.org> <50E960C4.80208@kernel.org> <50EA07D5.7060400@gmail.com> <50EDCC13.3040802@kernel.org>
In-Reply-To: <50EDCC13.3040802@kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 01/09/2013 08:59 PM, Jonathan Cameron wrote:
> On 01/06/2013 11:25 PM, James Peverill wrote:
>> On 01/06/2013 06:32 AM, Jonathan Cameron wrote:
>>> On 01/06/2013 04:31 AM, James Peverill wrote:
>>>> I have been working on realtime robotics under Linux, and just learned about
>>>> iio. It seems like many great hardware drivers are being written (some of which
>>>> I had started working on in parallel), and it would be great if I could
>>>> integrate what I am working on with iio. It seems mostly targeted at streaming
>>>> data acquisition and output, but also includes triggering and event support. Has
>>>> there been any thought to running realtime control loops using the iio
>>>> subsystem? For this application I would be reading from sensors (i2c interface
>>>> accelerometers etc) in the 10's of hz (ideally at least 50) and then updating
>>>> actuator outputs.
>>>>
>>>> Any thoughts on the feasibility? I would probably accomplish this by writing a
>>>> kernel driver to glue the input iio devices to the output. I'm not sure what
>>>> type of latency and jitter would result from this configuration, but this could
>>>> limit the applications.
>>>>
>>> I don't know of anyone else doing this with IIO at the moment (though someone may
>>> well shout out in the near future!)
>>>
>>> So based on 5 mins of thinking about it the situation at the moment is...
>>>
>>> We handle streaming inputs reasonably well and the just merged in kernel 'buffer'
>>> interfaces (which are really just hooks to get the stream of data from a device)
>>> should allow a kernel module to get hold of this data fairly efficiently (certainly
>>> 50Hz shouldn't be a problem!).  We don't currently have interfaces for getting hold
>>> of events in kernel though (threshold etc) but that should be fairly trivial to
>>> add.
>>>
>>> Unfortunately streaming support on the output side is not currently there.  Right now
>>> you can set individual DAC outputs from other kernel drivers (though some nice
>>> but trivial util functions might be missing) but buffered writing support isn't
>>> there yet.  There is a lot of interest in adding this, but from what I recall there
>>> are some 'interesting' issues with actually supporting precisely timed writes to
>>> DAC chips (usually there is some dma involved).
>>> Some spi implementations are capable of doing this I believe but there isn't any
>>> kernel support for it as far as I know.
>>> I'm guessing some DAC chips have hardware fifos (right now I can only find a TI
>>> technote on a separate fifo for this purpose).
>>>
>>> I've cc'd Lars and Michael because I know this sort of support is of interest to them
>>> and they will doubtlessly be able to give some more informed comments!

Just as a sidenote, we do have buffered output support, but it is in my
opinion not quite ready for mainline yet. See:

https://github.com/analogdevicesinc/linux/commit/23ec650f56c9d5a753a77e45be0b537467c7d8c4

>>>
>>> If the buffered output were present then using IIO for real time control should
>>> be straight forward.
>>>  From the level of interest I've seen in this functionality support will definitely
>>> occur at some point though this will happen faster obviously if someone
>>> (no hints at all :) takes on implementing such support!
>>>
>>> In the meantime, using IIO for your input drivers may make sense even if they
>>> more involved actuator side comes later.  Or possibliy the slow current dac
>>> interface will be 'good enough' timing wise for your application?
>>>
>>> If you are able to, I'd love to hear more about your project, both in terms
>>> of what you are doing (google gives me a fair idea as there aren't
>>> many James Peverill's in the world ;) and in terms of the
>>> control you are doing in kernel.
>>>
>>> Jonathan
>> My interest is in flying robots, as your google searches turned up! The ability to run control loops from within a Linux
>> system though has a lot of varied uses. Most flying vehicles and other real time robotics uses small microcontrollers
>> for the fast control, but I am of the opinion that there is no reason you can't run those on a Linux based system. I've
>> played around with Xenomai and other "hard" realtime Linux enhancements, and with these it is certainly possible to meet
>> the timing requirements to control most mechanical systems. Adding the realtime layers though adds quite a bit of
>> complexity and requires rewriting drivers to get the benefits. Now I'm investigating whether a standard kernel driver
>> will suffice. Currently my target hardware platform is the Raspberry Pi (700mhz Arm11), although I like to keep things
>> as hardware independent as possible.
>>
>> In terms of IIO, what would be really cool is if there was a way to glue together the IIO blocks into a control chain.
>> Ie you could take an ADC device and chain it with a PID driver and an output device. Inside the ADC device driver it
>> would pass the data to the next chain element after a new value was read. This way you could chain together devices in a
>> user mode sysfs context and end up with a complete control loop running inside the kernel.
> Whilst this would be possible, if you want this to ultimately go in the mainline kernel
> you'll need to persuade people that such dynamic chaining has a significant enough benefit
> to justify some 'interesting' code. With more static bindings (device tree based probably)
> or at least some static 'this is available for reading, this for writing' bindings to a module
> that acts as glue, there isn't much to prevent you doing this now though as stated the
> output route for data is less well evolved than the input.

In my opinion this chaining could best be implemented in userspace. E.g. by
splice()'ing the input and the output stream together. With rt priority the
response of the application shouldn't be to bad.

- Lars
