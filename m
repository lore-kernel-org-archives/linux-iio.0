Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:46081 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752520Ab2KBLCW (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 2 Nov 2012 07:02:22 -0400
Message-ID: <5093A83D.3040409@kernel.org>
Date: Fri, 02 Nov 2012 11:02:21 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Peter Meerwald <pmeerw@pmeerw.net>
CC: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@cam.ac.uk>
Subject: Re: [PATCH 4/4] staging:iio: Proof of concept input driver.
References: <1351679431-7963-1-git-send-email-jic23@kernel.org> <1351679431-7963-5-git-send-email-jic23@kernel.org> <alpine.DEB.2.01.1210311513050.10186@pmeerw.net>
In-Reply-To: <alpine.DEB.2.01.1210311513050.10186@pmeerw.net>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


I actually forgot to say in this posting - I'm not really intending to
merge this driver just yet.  It needs a fair bit of blugeoning then a bit
of time to be hammered by the input list before it's ready.  For now its
just acting as an example user (and a means of testing the other patches).

Still the review is obviously most welcome!

Jonathan
> 
>> +config IIO_ST_INPUT
>> +	tristate "Input driver that uses channels specified via iio maps"
>> +	depends on INPUT
>> +	depends on IIO_BUFFER
>> +	select IIO_BUFFER_CB
>> +	help
>> +	  Client driver for IIO via the push interfaces.  Used to provide
>> +	  and input interface for IIO devices that can feed a buffer on
> 
> an input interface
good catch.

> 
>> + * Copyright (c) 2011 Jonathan Cameron
> 
> 2012 is almost over
I've not changed much in here since 2011 though so will leave it be.
Did this whilst still in accademia.  Been doing a real job for a year
and this patch is still kicking around... hohum. It's been a busy year.

> 
>> +		case 32:
>> +			switch (chan->scan_type.endianness) {
>> +			case IIO_CPU:
>> +				value = *(s32 *)(data);
>> +				break;
>> +			case IIO_BE:
>> +				value = be32_to_cpu(*(__be32 *)data);
>> +				break;
>> +			case IIO_LE:
>> +				value = le32_to_cpu(*(__le32  *)data);
>> +				break;
> 
> here's an extra space between le32 and *
eagle eyes :)
> 
>> +static struct platform_driver iio_input_driver = {
>> +	.driver = {
>> +		.name = "iio_input_bridge",
>> +		.owner = THIS_MODULE,
>> +	},
>> +	.probe = iio_input_probe,
>> +	.remove = __devexit_p(iio_input_remove),
>> +};
>> +
>> +module_platform_driver(iio_input_driver);
>> +
>> +MODULE_AUTHOR("Jonathan Cameron <jic23@cam.ac.uk>");
>> +MODULE_DESCRIPTION("IIO input buffer driver");
>> +MODULE_LICENSE("GPL v2");
>> diff --git a/drivers/staging/iio/iio_input.h b/drivers/staging/iio/iio_input.h
>> new file mode 100644
>> index 0000000..cfd1d34
>> --- /dev/null
>> +++ b/drivers/staging/iio/iio_input.h
>> @@ -0,0 +1,23 @@
>> +/*
>> + * The industrial I/O input client driver
> 
> this thing is called 
> iio_input_bridge, 
> IIO input buffer_driver, 
> instrustrial I/O input client driver
> within a few lines of code -- now is the time to christen the driver :)
Fair point.
iio client driver for the input subsystem
(iio_to_input for driver name)
> 
>> + *
>> + * Copyright (c) 2011 Jonathan Cameron
>> + *
>> + * This program is free software; you can redistribute it and/or modify it
>> + * under the terms of the GNU General Public License version 2 as published by
>> + * the Free Software Foundation.
>> + */
>> +
>> +/**
>> + * iio_input_channel_data - description of the channel for input subsystem
>> + * @code:	Absolute axis.
>> + * @min:	Minimum value.
>> + * @max:	Maximum value.
>> + * @fuzz:	Used to filter noise from the event stream.
>> + * @flat:	Values within this value will be discarded by joydev
>> + *		and reported as 0 instead.
> 
> @flat: 	Values within the range [-flat, flat] will be discarded ...
> 
> this is at least what I would guess it does; input.h is equally vague
> 
I'll be honest - I'm not all that sure what it does either... Gone with your
description. We'll see what Dmitry et al say when I post it to linux-input.
>> + */
>> +struct iio_input_channel_data {
>> +	unsigned int code;
>> +	int min, max, fuzz, flat;
>> +};
>>
> 
