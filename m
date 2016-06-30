Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:43137 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751975AbcF3T0B (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 30 Jun 2016 15:26:01 -0400
Subject: Re: [PATCH 03/10 v4] iio: pressure: bmp280: add reset GPIO line
 handling
To: Linus Walleij <linus.walleij@linaro.org>,
	linux-iio@vger.kernel.org, Akinobu Mita <akinobu.mita@gmail.com>,
	"H. Nikolaus Schaller" <hns@goldelico.com>,
	Matt Ranostay <mranostay@gmail.com>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>
References: <1467251334-30594-1-git-send-email-linus.walleij@linaro.org>
 <1467251334-30594-4-git-send-email-linus.walleij@linaro.org>
Cc: Christoph Mair <christoph.mair@gmail.com>,
	Vlad Dogaru <vlad.dogaru@intel.com>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Marek Belisko <marek@goldelico.com>,
	Eric Andersson <eric.andersson@unixphere.com>,
	Neil Brown <neilb@suse.de>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <30468a81-6c7f-827c-4842-8aa42b43917a@kernel.org>
Date: Thu, 30 Jun 2016 20:25:59 +0100
MIME-Version: 1.0
In-Reply-To: <1467251334-30594-4-git-send-email-linus.walleij@linaro.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 30/06/16 02:48, Linus Walleij wrote:
> On the APQ8060 Dragonboard the reset line to the BMP085 pressure
> sensor is not deasserted on boot, so the driver needs to handle
> this. For a simple GPIO line supplied as a descriptor (from a board
> file, device tree or ACPI) this does the trick.
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Applied.
> ---
> ChangeLog v3->v4:
> - Fix BMP058->BMP085 in commit message
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

