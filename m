Return-Path: <jic23@jic23.retrosnub.co.uk>
References: <5072F3B9.4050309@st.com> <5073260C.3010506@metafoo.de> <20121008195007.GA32042@elf.ucw.cz> <507338B5.60307@metafoo.de>
In-Reply-To: <507338B5.60307@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Subject: Re: STMicroelectronics accelerometers driver.
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Date: Mon, 08 Oct 2012 21:37:48 +0100
To: Lars-Peter Clausen <lars@metafoo.de>,Pavel Machek <pavel@denx.de>
CC: Denis CIOCCA <denis.ciocca@st.com>,"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,Jonathan Cameron <jic23@kernel.org>,"burman.yan@gmail.com" <burman.yan@gmail.com>
Message-ID: <665718a4-de6b-4d09-ba80-35705fcf2595@email.android.com>
List-ID: <linux-iio@vger.kernel.org>



Lars-Peter Clausen <lars@metafoo.de> wrote:

>On 10/08/2012 09:50 PM, Pavel Machek wrote:
>> 
>>>> drivers/iio/accel/STMicroelectronics_accelerometers_iio_i2c.c
>>>>   create mode 100644
>>>> drivers/iio/accel/STMicroelectronics_accelerometers_iio_spi.c
>>>>   create mode 100644
>>>> drivers/iio/accel/STMicroelectronics_accelerometers_iio_trigger.c
>>>
>>> the file names are a bit excessive in my opinion. How about
>>> st_accel_{buffer,core,i2c,...}.c?
>> 
>> drivers/iio/accel/st/iio_spi.c ?
>
>Maybe. I'd still vote for st_accel though, since I think it is most
>descriptive. Since trigger and buffer should go down to a few lines it
>probably
>makes sense to put their content into the core file and I don't think
>we need a
>extra directory for the driver then.
>
Agreed.  Either is an improvement but Lars' is more in keeping with other drivers.   Doesn't need its own dir. Whilst this one is large it isn't exceptionally so.

>- Lars

-- 
Sent from my Android phone with K-9 Mail. Please excuse my brevity.
