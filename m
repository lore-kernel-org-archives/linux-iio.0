Return-Path: <pthomas8589@gmail.com>
MIME-Version: 1.0
In-Reply-To: <4E4BDEBC.3090606@cam.ac.uk>
References: <1313593455-29706-1-git-send-email-michael.hennerich@analog.com>
	<4E4BDEBC.3090606@cam.ac.uk>
Date: Wed, 17 Aug 2011 09:05:10 -0700
Message-ID: <CAD56B7cP+b3EbpvwfnqMdU9oWJVWw-HG66SgQeY6EX3tFEaRiw@mail.gmail.com>
Subject: Re: [PATCH] IIO: ADC: New driver for AD7190/AD7192/AD7195 4 Channel
 SPI ADC
From: Paul Thomas <pthomas8589@gmail.com>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: michael.hennerich@analog.com, linux-iio@vger.kernel.org,
	device-drivers-devel@blackfin.uclinux.org, drivers@analog.com
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

This looks like the 4 channel version of the ad7194. I'm currently
using the ad7194, and was working on the driver, I'd be happy to just
take this driver up, but the only problem is I'd like to be able to
run this without an interrupt, and that is how my ad7194 driver
worked.

thanks,
Paul

On Wed, Aug 17, 2011 at 8:31 AM, Jonathan Cameron <jic23@cam.ac.uk> wrote:
> On 08/17/11 16:04, michael.hennerich@analog.com wrote:
>> From: Michael Hennerich <michael.hennerich@analog.com>
>>
>> New driver for AD7190/AD7192/AD7195 4.8 kHz, Ultralow Noise, 24-Bit
>> Sigma-Delta ADC with PGA
>>
>> These devices features a dual use data out ready DOUT/RDY output.
>> In order to avoid contentions on the SPI bus, it's necessary to use
>> spi bus locking. The DOUT/RDY output must also be wired to an
>> interrupt capable GPIO.
>>
>> In INDIO_RING_TRIGGERED mode, this driver may block its SPI bus segment
>> for an extended period of time.
>>
>> Changes since V1:
>>
>> Add missing documentation.
>> Remove obsoleted include files.
>> Fix typos and style issues.
>> Fix buffer size.
>> Split ad7192_show() into two functions.
>> Avoid race condition add mutex.
>> Abandon IIO_CHAN macro.
>> Reorder elements in ad7192_platform_data.
>> Remove driver bus type.
>>
>> Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
> Acked-by: Jonathan Cameron <jic23@cam.ac.uk>
>
> No merge issues with what I've sent Greg so far so this one should
> go in cleanly either before them or after. (all sorts of fun
> later on though =A0- I'll pull it into iio-blue and fix up shortly.)
>
> Thanks,
>
> Jonathan
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
