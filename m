Return-Path: <Michael.Hennerich@analog.com>
From: "Hennerich, Michael" <Michael.Hennerich@analog.com>
To: Jonathan Cameron <jic23@cam.ac.uk>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"device-drivers-devel@blackfin.uclinux.org"
	<device-drivers-devel@blackfin.uclinux.org>
Date: Thu, 13 Jan 2011 09:20:11 +0000
Subject: RE: different ring buffer usage scenario
Message-ID: <544AC56F16B56944AEC3BD4E3D591771324BFF3F3A@LIMKCMBX1.ad.analog.com>
References: <544AC56F16B56944AEC3BD4E3D591771324BEA42CB@LIMKCMBX1.ad.analog.com>
 <4D0B7888.6050007@cam.ac.uk>
In-Reply-To: <4D0B7888.6050007@cam.ac.uk>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

Jonathan Cameron wrote on 2010-12-17:
> On 12/17/10 13:47, Hennerich, Michael wrote:
>> Hi Jonathan,
>>
>> I'm currently working on a high speed ADC driver, that requires a
>> different ring buffer use case scenario. Let me explain a little bit
>> the setup. I'm running Linux on a Microblaze softcore inside an Virtex6
>> FPGA. Part of the system is a peripheral interface block, we call it
>> the ADC Interface Module (AIM). External to the FPGA we connect a
>> single channel high speed ADC AD9649, to the AIM signals.
>>
>> The AIM features a FIFO, with watermark interrupt capabilities. There
>> are two modes that need to be supported. Continues Sampling Mode and
>> Single Shot Sample Mode. In Single Shot Sample Mode, the user reads an
>> arbitrary Number of samples from the
> ADC, and then the sampling stops. This mode does not need to have a
> ringbuffer at all.
>> A simple chardev might be sufficient.
>>
>> Any objections creating a driver private chardev?
> None at all.
> Is it appropriate to maintain the interfaces and buffer description we
> have for those where there is a buffer involved?  I think those
> interfaces are flexible enough... If not we probably want to make it
> so they are.
>
> I did think of creating a pass through buffer that would effectively
> allow other devices to simulate this behaviour. Basically to the core
> it would look like a buffer, but it would only store one scan and then
> only if someone has the chrdev open. It would support select type
> calls. This would be needed for the input bridge to no apply any delay
> to the data stream.
>
> Not actually done any work on it though.

Hi Jonathan,

For a project I'm currently working on I need such a pass through buffer.

The requirements I have are pretty basic. When user space reads x number of=
 elements
>>From the buffer, the generic pass through buffer implementation calls a reg=
istered
function in the ADC driver, that may sleep until the requested amount of el=
ements are
available.

I wonder if you have something in the make already?

Greetings,
Michael

--
Analog Devices GmbH      Wilhelm-Wagenfeld-Str. 6      80807 Muenchen
Sitz der Gesellschaft: Muenchen; Registergericht: Muenchen HRB 40368; Gesch=
aeftsfuehrer:Dr.Carsten Suckrow, Thomas Wessel, William A. Martin, Margaret=
 Seif
