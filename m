Return-Path: <lars@metafoo.de>
Message-ID: <561115CF.9020006@metafoo.de>
Date: Sun, 04 Oct 2015 14:04:31 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Shraddha Barke <shraddha.6596@gmail.com>,
 Jonathan Cameron <jic23@kernel.org>,
 Michael Hennerich <Michael.Hennerich@analog.com>
CC: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Staging: iio: meter: Use devm functions
References: <1443933272-23398-1-git-send-email-shraddha.6596@gmail.com>
In-Reply-To: <1443933272-23398-1-git-send-email-shraddha.6596@gmail.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-iio@vger.kernel.org>

On 10/04/2015 06:34 AM, Shraddha Barke wrote:
> [...]

Hi,

Thanks for the patch.

> -	st->trig = iio_trigger_alloc("%s-dev%d",
> -					spi_get_device_id(st->us)->name,
> -					indio_dev->id);
> +	st->trig = devm_iio_trigger_alloc(&indio_dev->id, "%s-dev%d",

But I don't think this compiles. The first parameter needs to be a struct
device.

> +					  spi_get_device_id(st->us)->name,
> +					  indio_dev->id);
>  	if (!st->trig) {
>  		ret = -ENOMEM;
>  		goto error_ret;
>  	}
>  
> -	ret = request_irq(st->us->irq,
> -			  ade7758_data_rdy_trig_poll,
> -			  IRQF_TRIGGER_LOW,
> -			  spi_get_device_id(st->us)->name,
> -			  st->trig);
> +	ret = devm_request_irq(&indio_dev->dev, st->us->irq,

And the device also needs to be the device from whose probe function this is
called. Please add a parameter to ade7758_probe_trigger that supplies this
device.

> +			       ade7758_data_rdy_trig_poll,
> +			       IRQF_TRIGGER_LOW,
> +			       spi_get_device_id(st->us)->name,
> +			       st->trig);
[...]
