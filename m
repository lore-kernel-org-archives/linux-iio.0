Return-Path: <jic23@kernel.org>
Message-ID: <4EE66BF5.8080506@kernel.org>
Date: Mon, 12 Dec 2011 21:02:45 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: Jonathan Cameron <jic23@cam.ac.uk>,
 Michael Hennerich <michael.hennerich@analog.com>,
 linux-iio@vger.kernel.org, device-drivers-devel@blackfin.uclinux.org,
 drivers@analog.com
Subject: Re: [PATCH] staging:iio:adc: Add AD7265/AD7266 support
References: <1323333852-4975-1-git-send-email-lars@metafoo.de> <4EE365C7.60900@kernel.org> <4EE4E05A.6080107@metafoo.de>
In-Reply-To: <4EE4E05A.6080107@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

0; i < ARRAY_SIZE(st->gpios); ++i) {
>>> +				st->gpios[i].gpio = pdata->addr_gpios[i];
>>> +				st->gpios[i].flags = GPIOF_OUT_INIT_LOW;
>>> +				st->gpios[i].label = ad7266_gpio_labels[i];
>>> +			}
>>> +			ret = gpio_request_array(st->gpios,
>>> +				ARRAY_SIZE(st->gpios));
>>> +			if (ret)
>>> +				goto error_disable_reg;
>>> +		}
>>> +	} else {
>>> +		st->fixed_addr = true;
>>> +		st->range = AD7266_RANGE_VREF;
>>> +		st->mode = AD7266_MODE_DIFF;
>>> +	}
>>> +
>>> +	spi_set_drvdata(spi, indio_dev);
>>> +	st->spi = spi;
>>> +
>>> +	indio_dev->dev.parent = &spi->dev;
>>> +	indio_dev->name = spi_get_device_id(spi)->name;
>>> +	indio_dev->modes = INDIO_DIRECT_MODE;
>>> +	indio_dev->info = &ad7266_info;
>>> +
>> Interesting. I vaguely wonder if we want to support controlling the pins
>> that set whether single ended vs differential?  That way it can be
>> controlled
>> in software (assuming pin is wired up.)  Guess that is getting a little
>> fiddly unless there is a user who actually does have a board wired to allow
>> controlling this though...
>>
> 
> Yes, I think this is a general issues with devices where the behavior can be
> controller using external pins. The pin can either be hardwired to high,
> hardwired to low or software controllable. So what this driver currently
> implements is some kind of a compromise. The address pins are software
> controllable the range, vref and diff/sgl pins are not, simply because it's
> more likely that the address pins are software controllable on an actual board.
> In theory it is also possible that for example only two of address pins are
> software controllable and the third one is hard wired. And if for example the
> diff/sgl pin is software controllable we probably don't want to support both
> single-ended and differential modes on all pins. It's more likely the case that
> you'd want to support single-ended conversion on some and differential
> conversions on others. So we'd need a per channel mask which conversion types
> should be supported for this channel.
> 
> So yes, there is room for improvement of the drivers feature set here, but I
> think it is something we can save for later when we actually meet an
> application which needs these features.

Agreed.  As a vague musing.  Is there any millage in a 'fixed gpio'
impementation?  When read it would always return the same value.
When written it would return an error indicating it cannot change..

That way we could more or less make the driver independent of whether
the pins are gpios or hard wired.

Just random musings on my bicycle earlier so don't take them too
seriously ;)
