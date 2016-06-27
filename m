Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([84.19.176.92]:46364 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751879AbcF0Qwc (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 27 Jun 2016 12:52:32 -0400
Date: Mon, 27 Jun 2016 18:52:23 +0200 (CEST)
From: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
To: Linus Walleij <linus.walleij@linaro.org>
cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Subject: Re: [PATCH 03/10 v3] iio: pressure: bmp280: add reset GPIO line
 handling
In-Reply-To: <1467045020-2665-4-git-send-email-linus.walleij@linaro.org>
Message-ID: <alpine.DEB.2.02.1606271851140.5271@pmeerw.net>
References: <1467045020-2665-1-git-send-email-linus.walleij@linaro.org> <1467045020-2665-4-git-send-email-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, 27 Jun 2016, Linus Walleij wrote:

> On the APQ8060 Dragonboard the reset line to the BMP058 pressure

BMP085

> sensor is not deasserted on boot, so the driver needs to handle
> this. For a simple GPIO line supplied as a descriptor (from a board
> file, device tree or ACPI) this does the trick.
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ChangeLog v2->v3:
> - None, just rebasing/resending
> ---
>  drivers/iio/pressure/bmp280.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/iio/pressure/bmp280.c b/drivers/iio/pressure/bmp280.c
> index fa76f5851245..1618968f8889 100644
> --- a/drivers/iio/pressure/bmp280.c
> +++ b/drivers/iio/pressure/bmp280.c
> @@ -23,6 +23,7 @@
>  #include <linux/delay.h>
>  #include <linux/iio/iio.h>
>  #include <linux/iio/sysfs.h>
> +#include <linux/gpio/consumer.h>
>  
>  /* BMP280 specific registers */
>  #define BMP280_REG_HUMIDITY_LSB		0xFE
> @@ -1024,6 +1025,7 @@ static int bmp280_probe(struct i2c_client *client,
>  	struct iio_dev *indio_dev;
>  	struct bmp280_data *data;
>  	unsigned int chip_id;
> +	struct gpio_desc *gpiod;
>  
>  	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
>  	if (!indio_dev)
> @@ -1063,6 +1065,14 @@ static int bmp280_probe(struct i2c_client *client,
>  		return -EINVAL;
>  	}
>  
> +	/* Bring chip out of reset if there is an assigned GPIO line */
> +	gpiod = devm_gpiod_get(&client->dev, "reset", GPIOD_OUT_HIGH);
> +	/* Deassert the signal */
> +	if (!IS_ERR(gpiod)) {
> +		dev_info(&client->dev, "release reset\n");
> +		gpiod_set_value(gpiod, 0);
> +	}
> +
>  	data->regmap = devm_regmap_init_i2c(client,
>  					data->chip_info->regmap_config);
>  	if (IS_ERR(data->regmap)) {
> 

-- 

Peter Meerwald-Stadler
+43-664-2444418 (mobile)
