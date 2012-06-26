Return-Path: <lars@metafoo.de>
Message-ID: <4FE971B9.2040506@metafoo.de>
Date: Tue, 26 Jun 2012 10:24:25 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@kernel.org>
CC: Jonathan Cameron <jic23@cam.ac.uk>, linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio:dac:ad5064: Add support for the ad5629r and ad5669r
References: <1340630285-11591-1-git-send-email-lars@metafoo.de> <4FE8C790.5020305@kernel.org>
In-Reply-To: <4FE8C790.5020305@kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

>>[...]
>> +
>> +static const struct i2c_device_id ad5064_i2c_ids[] = {
>> +	{"ad5629-1", ID_AD5628_1},
>> +	{"ad5629-2", ID_AD5628_2},
>> +	{"ad5629-3", ID_AD5628_2}, /* similar enough to ad5629-2 */
>> +	{"ad5669-1", ID_AD5668_1},
>> +	{"ad5669-2", ID_AD5668_2},
>> +	{"ad5669-3", ID_AD5668_2}, /* similar enough to ad5669-2 */
> Must be null terminated.
> 
> Btw I didn't get that by hand. Got a message at the end
> of build test
> drivers/iio/dac/ad5064: struct i2c_device_id is 24 bytes.  The last of 6 is:
> 0x61 0x64 0x35 0x36 0x36 0x39 0x2d 0x33 0x00 0x00 0x00 0x00 0x00 0x00
> 0x00 0x00 0x00 0x00 0x00 0x00 0x0e 0x00 0x00 0x00
> FATAL: drivers/iio/dac/ad5064: struct i2c_device_id is not terminated
> with a NULL entry!
> 

Damm, again... I never get this error on blackfin, I should really start
trying to compile drivers before submitting them on other archs as well.

Thanks.
