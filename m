Return-Path: <SRS0=4lFy=Y4=gmail.com=k.matthias12@kernel.org>
MIME-Version: 1.0
Sender: k.matthias12@gmail.com
In-Reply-To: <07a0ebde-dffe-ba6a-5fac-eade517b5a21@metafoo.de>
References: <CAKNHny9CYKzSoyq_-T3q35rq=1y1ekQPXr2Rg1ByhabadMWv9A@mail.gmail.com>
 <d1c324a3-17c9-ed66-3946-ccf9a0bbce5d@kernel.org> <07a0ebde-dffe-ba6a-5fac-eade517b5a21@metafoo.de>
From: Matthias Klumpp <matthias@tenstral.net>
Date: Sat, 14 Jan 2017 18:18:16 +0100
Message-ID: <CAKNHny_oY0bsfTZK7_KDKCm=x=KXiMaGkkGXpDFcUXB9SYkoRg@mail.gmail.com>
Subject: Re: Using IIO for high-speed DAQ
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

Thank you all for the replies!

2017-01-14 18:03 GMT+01:00 Lars-Peter Clausen <lars@metafoo.de>:
> On 01/14/2017 05:12 PM, Jonathan Cameron wrote:
>> On 13/01/17 14:13, Matthias Klumpp wrote:
>>> Hello!
>>> I would like to use IIO for high-speed data acquisition. In order to
>>> do that I implemented a new IIO driver for the ADC chip I am using
>>> (MAX1133, maximum sampling frequency 200ksps).
>>>
>>> The initial approach with triggered buffers was way too slow,
>>> achieving only a maximum sampling frequency of 4ksps.
>> Any idea where the bottle neck was specifically?  I'm guessing it
>> might have been on the userspace side, but not certain.
>
> This is less of a software restriction and more of a hardware design issue.
> Devices like the MAX1133 are not designed to be interfaced to a general
> purpose operating system and be able to operate at datasheet performance.
> The device requires to do a SPI transfer for each sample that is
> transferred. In a interrupt driven environment the context switch overhead
> that is introduced by this approach makes it impractical to be used at
> higher sampling rates.

I feared that this was the case...

> You either need to dedicate one full CPU to the capture process that does
> nothing else but configuring the SPI controller and spinning on the SPI
> transfer completion event. The data can then be transfered through a mailbox
> like system to a different CPU running the application.
>
> Or you need offloading support in hardware somewhere between the device and
> the applications processor. The offloading block needs to be able to handle
> flow control and group multiple sample into a larger block which is then in
> bulk transferred to the application processor. This can for example be
> implemented with a small FPGA or CPLD between the converter and the
> application processor. In rare cases the SPI controller built into the
> application processor SoC is capable of doing hardware flow control.

Currently I think that doing any of these will require way more time
than feasible. The chip is used as part of a device which is supposed
to do real-time data analysis for a research experiment (Neuroscience
stuff), and I think it would make much more sense to just invest the
time (and money) into buying a different chip and wire it up with the
other components than rewriting the world.

Initially the system was designed very differently and due to recent
changes ended up the way it was, and I hoped to be able to save some
time by using the preexisting MAX1133 chip directly (not the best
idea, apparently).

> The IIO framework itself does not impose a limit on the maximum sampling
> rate. It's all a matter of what the hardware is capable of handling. We have
> systems where we do 3-digit MSPS continuous transfers and GSPS oneshot
> transfers.

Since this is the first time I touched this area: Is there a group of
chips which you would recommend that samples with 200ksps, has a 16bit
bit-depth and bipolar mode and is accessible at that speed via IIO?
I'll look around a bit to find a solution for this issue.

Thank you a lot for the work you put into this! The slides from your
FOSDEM/LinuxFoundation talks have been incredibly helpful in
understanding the bigger picture.

In any case, now that I have it anyway, I'll submit the MAX1133
non-DMA version of the driver as RFC after I polished it a little
(could still be useful for someone).

Regards,
    Matthias
