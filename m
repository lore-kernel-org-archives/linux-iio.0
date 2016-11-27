Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:41288 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753806AbcK0L0z (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 27 Nov 2016 06:26:55 -0500
Subject: Re: [PATCH] iio: humidity: Support acpi probe for hts211
To: Shrirang Bagul <shrirang.bagul@canonical.com>
References: <20161124090754.20427-1-shrirang.bagul@canonical.com>
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        lorenzo.bianconi83@gmail.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <11630563-1cc3-7411-82e8-ffaaeb9214e2@kernel.org>
Date: Sun, 27 Nov 2016 11:17:35 +0000
MIME-Version: 1.0
In-Reply-To: <20161124090754.20427-1-shrirang.bagul@canonical.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 24/11/16 09:07, Shrirang Bagul wrote:
> Support driver probe by reading unique HID on systems based on ACPI instead
> of DT compatible strings.
> 
> Signed-off-by: Shrirang Bagul <shrirang.bagul@canonical.com>
Applied to the togreg branch of iio.git and pushed out as testing for the autobuilders
to play with it.

Thanks,

Jonathan
> ---
>  drivers/iio/humidity/hts221_i2c.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/iio/humidity/hts221_i2c.c b/drivers/iio/humidity/hts221_i2c.c
> index 367ecd5..8333c02 100644
> --- a/drivers/iio/humidity/hts221_i2c.c
> +++ b/drivers/iio/humidity/hts221_i2c.c
> @@ -10,6 +10,7 @@
>  
>  #include <linux/kernel.h>
>  #include <linux/module.h>
> +#include <linux/acpi.h>
>  #include <linux/i2c.h>
>  #include <linux/slab.h>
>  #include "hts221.h"
> @@ -83,6 +84,12 @@ static int hts221_i2c_probe(struct i2c_client *client,
>  	return hts221_probe(iio_dev);
>  }
>  
> +static const struct acpi_device_id hts221_acpi_match[] = {
> +	{"SMO9100", 0},
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(acpi, hts221_acpi_match);
> +
>  static const struct of_device_id hts221_i2c_of_match[] = {
>  	{ .compatible = "st,hts221", },
>  	{},
> @@ -99,6 +106,7 @@ static struct i2c_driver hts221_driver = {
>  	.driver = {
>  		.name = "hts221_i2c",
>  		.of_match_table = of_match_ptr(hts221_i2c_of_match),
> +		.acpi_match_table = ACPI_PTR(hts221_acpi_match),
>  	},
>  	.probe = hts221_i2c_probe,
>  	.id_table = hts221_i2c_id_table,
> 

