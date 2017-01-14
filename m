Return-Path: <SRS0=MSLf=Y4=metafoo.de=lars@kernel.org>
Subject: Re: Using IIO for high-speed DAQ
To: Jonathan Cameron <jic23@kernel.org>,
 Matthias Klumpp <matthias@tenstral.net>, linux-iio@vger.kernel.org
References: <CAKNHny9CYKzSoyq_-T3q35rq=1y1ekQPXr2Rg1ByhabadMWv9A@mail.gmail.com>
 <d1c324a3-17c9-ed66-3946-ccf9a0bbce5d@kernel.org>
From: Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <07a0ebde-dffe-ba6a-5fac-eade517b5a21@metafoo.de>
Date: Sat, 14 Jan 2017 18:03:14 +0100
MIME-Version: 1.0
In-Reply-To: <d1c324a3-17c9-ed66-3946-ccf9a0bbce5d@kernel.org>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-iio@vger.kernel.org>

On 01/14/2017 05:12 PM, Jonathan Cameron wrote:
> On 13/01/17 14:13, Matthias Klumpp wrote:
>> Hello!
>> I would like to use IIO for high-speed data acquisition. In order to
>> do that I implemented a new IIO driver for the ADC chip I am using
>> (MAX1133, maximum sampling frequency 200ksps).
>>
>> The initial approach with triggered buffers was way too slow,
>> achieving only a maximum sampling frequency of 4ksps.
> Any idea where the bottle neck was specifically?  I'm guessing it
> might have been on the userspace side, but not certain.

This is less of a software restriction and more of a hardware design issue.
Devices like the MAX1133 are not designed to be interfaced to a general
purpose operating system and be able to operate at datasheet performance.
The device requires to do a SPI transfer for each sample that is
transferred. In a interrupt driven environment the context switch overhead
that is introduced by this approach makes it impractical to be used at
higher sampling rates.

You either need to dedicate one full CPU to the capture process that does
nothing else but configuring the SPI controller and spinning on the SPI
transfer completion event. The data can then be transfered through a mailbox
like system to a different CPU running the application.

Or you need offloading support in hardware somewhere between the device and
the applications processor. The offloading block needs to be able to handle
flow control and group multiple sample into a larger block which is then in
bulk transferred to the application processor. This can for example be
implemented with a small FPGA or CPLD between the converter and the
application processor. In rare cases the SPI controller built into the
application processor SoC is capable of doing hardware flow control.

The IIO framework itself does not impose a limit on the maximum sampling
rate. It's all a matter of what the hardware is capable of handling. We have
systems where we do 3-digit MSPS continuous transfers and GSPS oneshot
transfers.

- Lars
