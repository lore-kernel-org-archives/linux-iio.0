Return-Path: <SRS0=09Pb=Y5=gmail.com=marek.vasut@kernel.org>
Subject: Re: [PATCH V5] iio: adc: Add Renesas GyroADC driver
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
References: <20170115001437.30478-1-marek.vasut@gmail.com>
 <d91d43b8-1e78-ca8a-9848-ff664e588559@kernel.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
 Simon Horman <horms+renesas@verge.net.au>, linux-renesas-soc@vger.kernel.org
From: Marek Vasut <marek.vasut@gmail.com>
Message-ID: <0e0398c2-a858-efe8-230f-c454145ec7bc@gmail.com>
Date: Sun, 15 Jan 2017 16:47:31 +0100
MIME-Version: 1.0
In-Reply-To: <d91d43b8-1e78-ca8a-9848-ff664e588559@kernel.org>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-iio@vger.kernel.org>

On 01/15/2017 03:05 PM, Jonathan Cameron wrote:
> On 15/01/17 00:14, Marek Vasut wrote:
>> Add IIO driver for the Renesas RCar GyroADC block. This block is a
>> simple 4/8-channel ADC which samples 12/15/24 bits of data every
>> cycle from all channels.
>>
>> Signed-off-by: Marek Vasut <marek.vasut@gmail.com>
>> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
>> Cc: Simon Horman <horms+renesas@verge.net.au>
>> Cc: Jonathan Cameron <jic23@kernel.org>
>> Cc: linux-renesas-soc@vger.kernel.org
> One question about the name attribute and what it gives you. Looks like another
> case of what Lars has been pointing out this morning.
> 
> We had a load of these sneak in.  Changing them would break userspace code
> so we can't fix them, but that attribute ought to give you something
> related to the part number.
> 
> Here it might even be cute to give an indication of what is connected
> to it as part of the name.

You can extract that information from the of_node, so I don't think that
is a good idea, it'd only bring in duplication:

~ # cat /sys/bus/iio/devices/iio\:device0/of_node/adc@*/compatible
maxim,max11100

> J

[...]

>> +	ret = rcar_gyroadc_parse_subdevs(indio_dev);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret = rcar_gyroadc_init_supplies(indio_dev);
>> +	if (ret)
>> +		return ret;
>> +
>> +	priv->model = (enum rcar_gyroadc_model)of_id->data;
>> +
>> +	platform_set_drvdata(pdev, indio_dev);
>> +
>> +	indio_dev->name = dev_name(dev);
> What do you then get when you read /sys/bus/iio/iio\:deviceX/name?

e6e54000.adc

> Should be something like the part number, rather than the id of the
> parent device (I'm not 100% sure what that even is in this case!)

You mean like "rcar-gyroadc" ? That works for me, sure.

[...]

-- 
Best regards,
Marek Vasut
