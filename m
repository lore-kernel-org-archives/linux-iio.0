Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:45369 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751434AbdA1Mof (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 28 Jan 2017 07:44:35 -0500
Subject: Re: [PATCH] iio: stx104: Utilize devm_ functions in driver probe
 callback
To: William Breathitt Gray <vilhelm.gray@gmail.com>, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net
References: <20170124202617.15512-1-vilhelm.gray@gmail.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <3c732afb-65ea-df1b-c309-1979dcc81560@kernel.org>
Date: Sat, 28 Jan 2017 12:44:33 +0000
MIME-Version: 1.0
In-Reply-To: <20170124202617.15512-1-vilhelm.gray@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 24/01/17 20:26, William Breathitt Gray wrote:
> The devm_ resource manager functions allow memory to be automatically
> released when a device is unbound. This patch takes advantage of the
> resource manager functions and replaces the gpiochip_add_data call and
> iio_device_register call with the devm_gpiochip_add_data call and
> devm_iio_device_register call respectively. In addition, the
> stx104_remove function has been removed as no longer necessary due to
> the use of the relevant devm_ resource manager functions.
> 
> Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

Thanks,

Jonathan
> ---
>  drivers/iio/adc/stx104.c | 22 ++--------------------
>  1 file changed, 2 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/iio/adc/stx104.c b/drivers/iio/adc/stx104.c
> index 7e3645749eaf..c56ff286695d 100644
> --- a/drivers/iio/adc/stx104.c
> +++ b/drivers/iio/adc/stx104.c
> @@ -339,30 +339,13 @@ static int stx104_probe(struct device *dev, unsigned int id)
>  	stx104dev->chip = &stx104gpio->chip;
>  	dev_set_drvdata(dev, stx104dev);
>  
> -	err = gpiochip_add_data(&stx104gpio->chip, stx104gpio);
> +	err = devm_gpiochip_add_data(dev, &stx104gpio->chip, stx104gpio);
>  	if (err) {
>  		dev_err(dev, "GPIO registering failed (%d)\n", err);
>  		return err;
>  	}
>  
> -	err = iio_device_register(indio_dev);
> -	if (err) {
> -		dev_err(dev, "IIO device registering failed (%d)\n", err);
> -		gpiochip_remove(&stx104gpio->chip);
> -		return err;
> -	}
> -
> -	return 0;
> -}
> -
> -static int stx104_remove(struct device *dev, unsigned int id)
> -{
> -	struct stx104_dev *const stx104dev = dev_get_drvdata(dev);
> -
> -	iio_device_unregister(stx104dev->indio_dev);
> -	gpiochip_remove(stx104dev->chip);
> -
> -	return 0;
> +	return devm_iio_device_register(dev, indio_dev);
>  }
>  
>  static struct isa_driver stx104_driver = {
> @@ -370,7 +353,6 @@ static struct isa_driver stx104_driver = {
>  	.driver = {
>  		.name = "stx104"
>  	},
> -	.remove = stx104_remove
>  };
>  
>  module_isa_driver(stx104_driver, num_stx104);
> 

