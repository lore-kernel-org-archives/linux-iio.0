Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:52327 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751465AbcL3RTt (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 30 Dec 2016 12:19:49 -0500
Subject: Re: [PATCH 1/2] iio: dac: ad5592r: Add ACPI support
To: michael.hennerich@analog.com, linux-iio@vger.kernel.org
References: <1482149439-16327-1-git-send-email-michael.hennerich@analog.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <9ff83ff3-77a7-aeb3-8353-b03e26e869f4@kernel.org>
Date: Fri, 30 Dec 2016 17:19:48 +0000
MIME-Version: 1.0
In-Reply-To: <1482149439-16327-1-git-send-email-michael.hennerich@analog.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 19/12/16 12:10, michael.hennerich@analog.com wrote:
> From: Michael Hennerich <michael.hennerich@analog.com>
> 
> This patch adds the ACPI/PNP ID. The AD5592/3 driver core is already
> designed around the unified device property API.
> 
> Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
Applied.

Thanks,

Jonathan
> ---
>  drivers/iio/dac/ad5592r.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/iio/dac/ad5592r.c b/drivers/iio/dac/ad5592r.c
> index 6eed5b7..6a12a3c 100644
> --- a/drivers/iio/dac/ad5592r.c
> +++ b/drivers/iio/dac/ad5592r.c
> @@ -13,6 +13,7 @@
>  #include <linux/module.h>
>  #include <linux/of.h>
>  #include <linux/spi/spi.h>
> +#include <linux/acpi.h>
>  
>  #define AD5592R_GPIO_READBACK_EN	BIT(10)
>  #define AD5592R_LDAC_READBACK_EN	BIT(6)
> @@ -148,10 +149,17 @@ static const struct of_device_id ad5592r_of_match[] = {
>  };
>  MODULE_DEVICE_TABLE(of, ad5592r_of_match);
>  
> +static const struct acpi_device_id ad5592r_acpi_match[] = {
> +	{"ADS5592", },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(acpi, ad5592r_acpi_match);
> +
>  static struct spi_driver ad5592r_spi_driver = {
>  	.driver = {
>  		.name = "ad5592r",
>  		.of_match_table = of_match_ptr(ad5592r_of_match),
> +		.acpi_match_table = ACPI_PTR(ad5592r_acpi_match),
>  	},
>  	.probe = ad5592r_spi_probe,
>  	.remove = ad5592r_spi_remove,
> 

