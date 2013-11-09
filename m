Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:54809 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753755Ab3KIQqP (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 9 Nov 2013 11:46:15 -0500
Message-ID: <527E7520.3080601@kernel.org>
Date: Sat, 09 Nov 2013 17:47:12 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Sachin Kamat <sachin.kamat@linaro.org>, linux-iio@vger.kernel.org
CC: lars@metafoo.de
Subject: Re: [PATCH 03/33] iio: accel: kxsd9: Use devm_iio_device_register
References: <1383046796-329-1-git-send-email-sachin.kamat@linaro.org> <1383046796-329-4-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1383046796-329-4-git-send-email-sachin.kamat@linaro.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/29/13 11:39, Sachin Kamat wrote:
> devm_iio_device_register simplifies the code.
> 
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
This highlights the issue I raised before.  The driver really ought to be
shuting down the device. Thus there should be some code in the unregister
that is not there.

Hence, nope on this one.
> ---
>  drivers/iio/accel/kxsd9.c |   10 +---------
>  1 file changed, 1 insertion(+), 9 deletions(-)
> 
> diff --git a/drivers/iio/accel/kxsd9.c b/drivers/iio/accel/kxsd9.c
> index d72118d..877ae67 100644
> --- a/drivers/iio/accel/kxsd9.c
> +++ b/drivers/iio/accel/kxsd9.c
> @@ -243,14 +243,7 @@ static int kxsd9_probe(struct spi_device *spi)
>  	spi_setup(spi);
>  	kxsd9_power_up(st);
>  
> -	return iio_device_register(indio_dev);
> -}
> -
> -static int kxsd9_remove(struct spi_device *spi)
> -{
> -	iio_device_unregister(spi_get_drvdata(spi));
> -
> -	return 0;
> +	return devm_iio_device_register(&spi->dev, indio_dev);
>  }
>  
>  static const struct spi_device_id kxsd9_id[] = {
> @@ -265,7 +258,6 @@ static struct spi_driver kxsd9_driver = {
>  		.owner = THIS_MODULE,
>  	},
>  	.probe = kxsd9_probe,
> -	.remove = kxsd9_remove,
>  	.id_table = kxsd9_id,
>  };
>  module_spi_driver(kxsd9_driver);
> 
