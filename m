Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:36036 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751269AbeEVRVc (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 22 May 2018 13:21:32 -0400
Date: Tue, 22 May 2018 18:21:28 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Silvan Murer <silvan.murer@gmail.com>
Cc: lars@metafoo.de, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v4 1/2] iio: dac: fix missing of_match_table assignment
 in the LTC 2632 device
Message-ID: <20180522182128.3770f50c@archlinux>
In-Reply-To: <1526905288-28668-2-git-send-email-silvan.murer@gmail.com>
References: <1526905288-28668-1-git-send-email-silvan.murer@gmail.com>
        <1526905288-28668-2-git-send-email-silvan.murer@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, 21 May 2018 14:21:27 +0200
Silvan Murer <silvan.murer@gmail.com> wrote:

> Signed-off-by: Silvan Murer <silvan.murer@gmail.com>
> Reviewed-by: Lars-Peter Clausen <lars@metafoo.de>

Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

Thanks,

Jonathan

> ---
>  drivers/iio/dac/ltc2632.c | 19 ++++++++++---------
>  1 file changed, 10 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/iio/dac/ltc2632.c b/drivers/iio/dac/ltc2632.c
> index ac5e05f..d322b78 100644
> --- a/drivers/iio/dac/ltc2632.c
> +++ b/drivers/iio/dac/ltc2632.c
> @@ -276,15 +276,6 @@ static const struct spi_device_id ltc2632_id[] = {
>  };
>  MODULE_DEVICE_TABLE(spi, ltc2632_id);
>  
> -static struct spi_driver ltc2632_driver = {
> -	.driver		= {
> -		.name	= "ltc2632",
> -	},
> -	.probe		= ltc2632_probe,
> -	.id_table	= ltc2632_id,
> -};
> -module_spi_driver(ltc2632_driver);
> -
>  static const struct of_device_id ltc2632_of_match[] = {
>  	{
>  		.compatible = "lltc,ltc2632-l12",
> @@ -309,6 +300,16 @@ static const struct of_device_id ltc2632_of_match[] = {
>  };
>  MODULE_DEVICE_TABLE(of, ltc2632_of_match);
>  
> +static struct spi_driver ltc2632_driver = {
> +	.driver		= {
> +		.name	= "ltc2632",
> +		.of_match_table = of_match_ptr(ltc2632_of_match),
> +	},
> +	.probe		= ltc2632_probe,
> +	.id_table	= ltc2632_id,
> +};
> +module_spi_driver(ltc2632_driver);
> +
>  MODULE_AUTHOR("Maxime Roussin-Belanger <maxime.roussinbelanger@gmail.com>");
>  MODULE_DESCRIPTION("LTC2632 DAC SPI driver");
>  MODULE_LICENSE("GPL v2");

