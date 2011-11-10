Return-Path: <jic23@cam.ac.uk>
Message-ID: <4EBC0418.2040005@cam.ac.uk>
Date: Thu, 10 Nov 2011 17:04:24 +0000
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
CC: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, guenter.roeck@ericsson.com,
 khali@linux-fr.org, dmitry.torokhov@gmail.com, gregkh@suse.de,
 alan@lxorguk.ukuu.org.uk, arnd@arndb.de, linus.walleij@linaro.org,
 lars@metafoo.de, maxime.ripard@free-electrons.com,
 lm-sensors@lm-sensors.org, thomas.petazzoni@free-electrons.com,
 zdevai@gmail.com
Subject: Re: [PATCH 3/5] IIO:CORE add in kernel interface mapping and getting
 IIO channels.
References: <1320680681-5635-1-git-send-email-jic23@kernel.org> <1320680681-5635-4-git-send-email-jic23@kernel.org> <20111110132506.GF3832@opensource.wolfsonmicro.com>
In-Reply-To: <20111110132506.GF3832@opensource.wolfsonmicro.com>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

On 11/10/2011 01:25 PM, Mark Brown wrote:
> On Mon, Nov 07, 2011 at 03:44:39PM +0000, Jonathan Cameron wrote:
>> From: Jonathan Cameron <jic23@cam.ac.uk>
>>
>> Two elements here:
>> * Map as defined in include/linux/iio/inkern.h
>> * Matching code to actually get the iio_dev and channel
>> that we want from the global list of IIO devices.
> 
> I've not read it thoroughly but this certainly this looks sensible from
> an external interface point of view, I'd expect that issues can be
> worked through incrementally.
> 
> Reviewed-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
Thanks.
> 
>> +extern struct list_head iio_map_list;
> 
> It's surprising that this is part of the external interface of IIO
> rather than something hidden within the implementation.
You are quite correct. I was being lazy and had that one element that
didn't fit in any headers.  I'lll add a trivial inkern-core.h to handle
that one bit.
