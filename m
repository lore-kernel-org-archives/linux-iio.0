Return-Path: <Michael.Hennerich@analog.com>
From: "Hennerich, Michael" <Michael.Hennerich@analog.com>
To: Jonathan Cameron <jic23@cam.ac.uk>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, Drivers
	<Drivers@analog.com>
Date: Fri, 8 Oct 2010 12:05:38 +0100
Subject: RE: [RFC PATCH] staging: iio: adc: ad7476 new SPI ADC driver
Message-ID: <544AC56F16B56944AEC3BD4E3D5917712F35A102B4@LIMKCMBX1.ad.analog.com>
References: <1286462190-2002-1-git-send-email-michael.hennerich@analog.com>
 <4CAEEB3A.2070301@cam.ac.uk>
In-Reply-To: <4CAEEB3A.2070301@cam.ac.uk>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

Jonathan Cameron wrote on 2010-10-08:
> On 10/07/10 15:36, michael.hennerich@analog.com wrote:
>> From: Michael Hennerich <michael.hennerich@analog.com>
>>
>> New driver handling:         AD7475, AD7476, AD7477, AD7478, AD7466, AD7=
467,
>> AD7468, AD7495 SPI micropower and high speed 12-/10-/8-Bit ADCs
>
> Hi Michael,
>
> Another pretty clean driver. Thanks, it makes reviewing much easier!
> A few more suggestions this morning.
>
> * Might be a cache line issue with having buffer directly allocated
>   inside the state structure. In summary the issue is that another
>   element of the structure may be touched whilst dma is occuring into
>   buffer. With really bad luck this can mean that the value dma'd in is
>   wiped out with that in the cache before it is read.  If I'm missing a
>   reason we are fine here, please tell me.

Hi Jonathan,

Thanks for your detailed review!

I remember this conversation on linux-input. It was also around my AD7877
touch screen driver. I'm not a friend of malloc and free short junks of dat=
a
every time we make a transfer. I'll probably add the ____cacheline_aligned =
thing
to the data buffer.

>  This stuff always gives me a
>   headache.
> * Don't (I think) need scan_attrs in chip info structure.
>   They all seem to be set to the same pointer. Guess you can probably
>   shift the scan el code off into the ring buffer file.

Well I did it that way for future usage - I'm going to add support for more
SPI ADC devices to that driver in future. I remove it until it is actually
used.

> * Is platform data vital? Probably not if using the id_table.

When using id_table together with the regulator framework, we don't need it=
.

> * Could use helper to alloc the pollfunc.

Will do.

> * I may be imagining issues that don't exist with the bit
>   about whether the the contents of spi elements is guaranteed
>   not to be eaten by the bus drivers!  Worth verifying perhaps though?

I think it is - at least I have done various drivers doing the same here.
Without any complains yet...

Greetings,
Michael

Analog Devices GmbH      Wilhelm-Wagenfeld-Str. 6      80807 Muenchen
Sitz der Gesellschaft Muenchen, Registergericht Muenchen HRB 4036 Geschaeft=
sfuehrer Thomas Wessel, William A. Martin, Margaret Seif
