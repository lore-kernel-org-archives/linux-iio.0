Return-Path: <Michael.Hennerich@analog.com>
From: "Hennerich, Michael" <Michael.Hennerich@analog.com>
To: Paul Thomas <pthomas8589@gmail.com>
CC: Jonathan Cameron <jic23@cam.ac.uk>, "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>, "device-drivers-devel@blackfin.uclinux.org"
	<device-drivers-devel@blackfin.uclinux.org>, Drivers <Drivers@analog.com>
Date: Fri, 19 Aug 2011 08:41:57 +0100
Subject: RE: [PATCH] IIO: ADC: New driver for AD7190/AD7192/AD7195 4 Channel
 SPI ADC
Message-ID: <544AC56F16B56944AEC3BD4E3D59177143006BAC41@LIMKCMBX1.ad.analog.com>
References: <1313593455-29706-1-git-send-email-michael.hennerich@analog.com>
	<4E4BDEBC.3090606@cam.ac.uk>
	<CAD56B7cP+b3EbpvwfnqMdU9oWJVWw-HG66SgQeY6EX3tFEaRiw@mail.gmail.com>
	<544AC56F16B56944AEC3BD4E3D59177143006BA839@LIMKCMBX1.ad.analog.com>
 <CAD56B7ea7kqEkjDo=4xH8e00Ss=CA1cANjr_Mo8vw+mo8NrvGA@mail.gmail.com>
In-Reply-To: <CAD56B7ea7kqEkjDo=4xH8e00Ss=CA1cANjr_Mo8vw+mo8NrvGA@mail.gmail.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

Paul Thomas wrote on 2011-08-18:
> OK, that makes sense. So, what's the plan here? Do you want to add the
> msleep version and ad7194 support to your driver?

I can remove the IRQ requirement from the driver.
However I don't have hardware to test at the moment, so you are welcome to =
add the ad7194 support.
Ideally we do this on Jonathan's iio-blue git, since he already made some A=
PI changes...

> Do you want me to add
> that stuff to your driver? Another option would be for me to continue on
> with my ad7194 driver incorporating yours and Jonathan's suggestions.

That's up to you -

>
> On Wed, Aug 17, 2011 at 11:41 PM, Hennerich, Michael
> <Michael.Hennerich@analog.com> wrote:
>> Paul Thomas wrote on 2011-08-17:
>>> This looks like the 4 channel version of the ad7194. I'm currently
>>> using the ad7194, and was working on the driver, I'd be happy to just
>>> take this driver up, but the only problem is I'd like to be able to
>>> run this without an interrupt, and that is how my ad7194 driver
> worked.
>>
>> Hi Paul,
>>
>> Your driver also lacks SPI bus locking - see the comment in the ad7192
>> source file. For direct sysfs access, it should be easy to remove the
>> interrupt requirement and just do msleep instead. In case no IRQ is
>> given we simply drop the ring buffer registration.
>>
>>
>>> thanks,
>>> Paul
>>>
>>> On Wed, Aug 17, 2011 at 8:31 AM, Jonathan Cameron <jic23@cam.ac.uk>
>>> wrote:
>>>> On 08/17/11 16:04, michael.hennerich@analog.com wrote:
>>>>> From: Michael Hennerich <michael.hennerich@analog.com>
>>>>>
>>>>> New driver for AD7190/AD7192/AD7195 4.8 kHz, Ultralow Noise, 24- Bit
>>>>> Sigma-Delta ADC with PGA
>>>>>
>>>>> These devices features a dual use data out ready DOUT/RDY output. In
>>>>> order to avoid contentions on the SPI bus, it's necessary to use spi
>>>>> bus locking. The DOUT/RDY output must also be wired to an interrupt
>>>>> capable GPIO.
>>>>>
>>>>> In INDIO_RING_TRIGGERED mode, this driver may block its SPI bus
>>>>> segment for an extended period of time.
>>>>>
>>>>> Changes since V1:
>>>>>
>>>>> Add missing documentation.
>>>>> Remove obsoleted include files.
>>>>> Fix typos and style issues.
>>>>> Fix buffer size.
>>>>> Split ad7192_show() into two functions.
>>>>> Avoid race condition add mutex.
>>>>> Abandon IIO_CHAN macro.
>>>>> Reorder elements in ad7192_platform_data.
>>>>> Remove driver bus type.
>>>>>
>>>>> Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
>>>> Acked-by: Jonathan Cameron <jic23@cam.ac.uk>
>>>>
>>>> No merge issues with what I've sent Greg so far so this one should
>>>> go in cleanly either before them or after. (all sorts of fun later
>>>> on though  - I'll pull it into iio-blue and fix up shortly.)
>>>>
>>>> Thanks,
>>>>
>>>> Jonathan -- To unsubscribe from this list: send the line "unsubscribe
>>>> linux- iio" in the body of a message to majordomo@vger.kernel.org
>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>>
>>
>> Greetings,
>> Michael
>>
>> --
>> Analog Devices GmbH      Wilhelm-Wagenfeld-Str. 6      80807 Muenchen
>> Sitz der Gesellschaft: Muenchen; Registergericht: Muenchen HRB 40368;
> Geschaeftsfuehrer:Dr.Carsten Suckrow, Thomas Wessel, William A. Martin,
> Margaret Seif
>>
>>
>> -- To unsubscribe from this list: send the line "unsubscribe linux-iio"
>> in the body of a message to majordomo@vger.kernel.org More majordomo
>> info at  http://vger.kernel.org/majordomo-info.html
>>

Greetings,
Michael

--
Analog Devices GmbH      Wilhelm-Wagenfeld-Str. 6      80807 Muenchen
Sitz der Gesellschaft: Muenchen; Registergericht: Muenchen HRB 40368;
Geschaeftsfuehrer:Dr.Carsten Suckrow, Thomas Wessel, William A. Martin, Mar=
garet Seif
