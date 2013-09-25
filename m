Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:34537 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751242Ab3IYToz (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 25 Sep 2013 15:44:55 -0400
Message-ID: <52434B5F.4020303@kernel.org>
Date: Wed, 25 Sep 2013 21:45:19 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Sachin Kamat <sachin.kamat@linaro.org>
CC: linux-iio@vger.kernel.org, lars@metafoo.de
Subject: Re: [PATCH 02/32] iio: accel: kxsd9: Use devm_iio_device_register
References: <1380106208-6948-1-git-send-email-sachin.kamat@linaro.org> <1380106208-6948-3-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1380106208-6948-3-git-send-email-sachin.kamat@linaro.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 09/25/13 11:49, Sachin Kamat wrote:
> devm_iio_device_register simplifies the code.
> 
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Saddly what this really shows is that this driver is not doing some
cleanup that it ideally would be.  The device has a low power mode.
At the very least, one would expect the device to be put into that state
when the kernel calls the remove.

Can't really blame anyone else for this thought can I :)

For reference, ctrl reg B bit 6 is the device enable.  Set it to 0 and it goes
into a low power mode.

This is particularly ugly given there is a perfectly good defined
constant for the ctrl reg that isn't even used in the power up function.

I was young and ignorant ;)


I suspect it is a rare device where there is nothing that 'should' be done
after the unregister has occured.

Note that we have even started seeing the power supply of devices being controlled
by optional regulators for boards where they may not necessarily be getting any
power at all.  I suspect this will become more common as time goes on.

> ---
>  drivers/iio/accel/kxsd9.c |   10 +---------
>  1 file changed, 1 insertion(+), 9 deletions(-)
> 
> diff --git a/drivers/iio/accel/kxsd9.c b/drivers/iio/accel/kxsd9.c
> index 709c132..3048686 100644
> --- a/drivers/iio/accel/kxsd9.c
> +++ b/drivers/iio/accel/kxsd9.c
> @@ -244,20 +244,13 @@ static int kxsd9_probe(struct spi_device *spi)
>  	spi_setup(spi);
>  	kxsd9_power_up(st);
>  
> -	ret = iio_device_register(indio_dev);
> +	ret = devm_iio_device_register(&spi->dev, indio_dev);
>  	if (ret)
>  		return ret;
>  
>  	return 0;
>  }
>  
> -static int kxsd9_remove(struct spi_device *spi)
> -{
> -	iio_device_unregister(spi_get_drvdata(spi));
> -
> -	return 0;
> -}
> -
>  static const struct spi_device_id kxsd9_id[] = {
>  	{"kxsd9", 0},
>  	{ },
> @@ -270,7 +263,6 @@ static struct spi_driver kxsd9_driver = {
>  		.owner = THIS_MODULE,
>  	},
>  	.probe = kxsd9_probe,
> -	.remove = kxsd9_remove,
>  	.id_table = kxsd9_id,
>  };
>  module_spi_driver(kxsd9_driver);
> 
