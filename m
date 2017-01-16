Return-Path: <SRS0=QGQM=Y6=metafoo.de=lars@kernel.org>
Subject: Re: Using IIO for high-speed DAQ
To: Matthias Klumpp <matthias@tenstral.net>
References: <CAKNHny9CYKzSoyq_-T3q35rq=1y1ekQPXr2Rg1ByhabadMWv9A@mail.gmail.com>
 <d1c324a3-17c9-ed66-3946-ccf9a0bbce5d@kernel.org>
 <07a0ebde-dffe-ba6a-5fac-eade517b5a21@metafoo.de>
 <CAKNHny_oY0bsfTZK7_KDKCm=x=KXiMaGkkGXpDFcUXB9SYkoRg@mail.gmail.com>
 <eb9bf135-9ea3-99b7-6a21-264dceb8a178@metafoo.de>
 <CAKNHny_9FCDfBdTC-=AL3LwdPyqQ0M58rYT22gxULFgB1hA1LA@mail.gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
From: Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <d5af1ec3-383f-9b2a-98d0-01ad421c2f83@metafoo.de>
Date: Mon, 16 Jan 2017 22:40:07 +0100
MIME-Version: 1.0
In-Reply-To: <CAKNHny_9FCDfBdTC-=AL3LwdPyqQ0M58rYT22gxULFgB1hA1LA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-iio@vger.kernel.org>

On 01/16/2017 03:23 PM, Matthias Klumpp wrote:
> 2017-01-14 18:49 GMT+01:00 Lars-Peter Clausen <lars@metafoo.de>:
>> On 01/14/2017 06:18 PM, Matthias Klumpp wrote:
>>>> The IIO framework itself does not impose a limit on the maximum sampling
>>>> rate. It's all a matter of what the hardware is capable of handling. We have
>>>> systems where we do 3-digit MSPS continuous transfers and GSPS oneshot
>>>> transfers.
>>>
>>> Since this is the first time I touched this area: Is there a group of
>>> chips which you would recommend that samples with 200ksps, has a 16bit
>>> bit-depth and bipolar mode and is accessible at that speed via IIO?
>>> I'll look around a bit to find a solution for this issue.
>>
>> Unfortunately this is often as  much about the AP as it is about the
>> converter. In the setups we have we use a AP+FPGA combination where the AP
>> runs Linux with IIO and the FPGA is responsible for handling the SPI flow
>> control during the acquisition phase. For this we've developed the
>> SPI-Engine framework[1]. It is compatible with most ADI single-channel SAR
>> and Sigma-Delta ADCs[2].
>> [...]
> 
> Thanks!
> I was already looking into this, but also tried to access the BCM2835
> on my Raspberry Pi test device directly (someone wrote a nice helper
> library for that at [1]).
> Turns out that using this library, I can easily achieve my desired
> speed of 200ksps (it also turned out that with a few changes on the
> setup, 6ksps can be just enough...).

This is basically the dedicated CPU approach I described. Your application
is spinning on the SPI registers and not using interrupts. This means a lot
of CPU time is used for busy-waiting. If you are issuing one transfer after
another CPU utilization will go to 100%.

One issue with doing this in Linux userspace is that your application will
still get interrupted occasionally, either to run interrupts or potentially
schedule other applications for a short duration on the CPU. When this
happens there is a good chance that you'll loose a few sample and have a
discontinuity in your signal. Which will show itself in strange glitches
when you are processing the data.
