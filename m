Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:43122 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751666AbcF3TYp (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 30 Jun 2016 15:24:45 -0400
Subject: Re: [PATCH 02/10 v4] iio: pressure: bmp280: support device tree
 initialization
To: Linus Walleij <linus.walleij@linaro.org>,
	linux-iio@vger.kernel.org, Akinobu Mita <akinobu.mita@gmail.com>,
	"H. Nikolaus Schaller" <hns@goldelico.com>,
	Matt Ranostay <mranostay@gmail.com>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>
References: <1467251334-30594-1-git-send-email-linus.walleij@linaro.org>
 <1467251334-30594-3-git-send-email-linus.walleij@linaro.org>
Cc: Christoph Mair <christoph.mair@gmail.com>,
	Vlad Dogaru <vlad.dogaru@intel.com>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Marek Belisko <marek@goldelico.com>,
	Eric Andersson <eric.andersson@unixphere.com>,
	Neil Brown <neilb@suse.de>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <9cd6e0c8-a844-0e38-0177-2d6e3d5b5557@kernel.org>
Date: Thu, 30 Jun 2016 20:24:43 +0100
MIME-Version: 1.0
In-Reply-To: <1467251334-30594-3-git-send-email-linus.walleij@linaro.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 30/06/16 02:48, Linus Walleij wrote:
> This adds device tree support to the BMP085, BMP180 and BMP280
> pressure sensors. Tested on the Qualcomm APQ8060 Dragonboard:
> 
> iio:device1$ cat in_temp_input
> 26700
> iio:device1$ cat in_pressure_input
> 99.185000000
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Applied.
> ---
> ChangeLog v3->v4:
> - No real changes.
> ChangeLog v2->v3:
> - Terminate OF ID table properly with an { }
> ChangeLog v1->v2:
> - Fix some BMP085 misspelled as BMP058 errors.
> - Add the new BME280 sensor as well
> ---
>  drivers/iio/pressure/bmp280.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/drivers/iio/pressure/bmp280.c b/drivers/iio/pressure/bmp280.c
> index 1876b50cc84a..fa76f5851245 100644
> --- a/drivers/iio/pressure/bmp280.c
> +++ b/drivers/iio/pressure/bmp280.c
> @@ -18,6 +18,7 @@
>  #include <linux/module.h>
>  #include <linux/i2c.h>
>  #include <linux/acpi.h>
> +#include <linux/of.h>
>  #include <linux/regmap.h>
>  #include <linux/delay.h>
>  #include <linux/iio/iio.h>
> @@ -1094,6 +1095,19 @@ static const struct acpi_device_id bmp280_acpi_match[] = {
>  };
>  MODULE_DEVICE_TABLE(acpi, bmp280_acpi_match);
>  
> +#ifdef CONFIG_OF
> +static const struct of_device_id bmp280_of_match[] = {
> +	{ .compatible = "bosch,bme280", .data = (void *)BME280_CHIP_ID },
> +	{ .compatible = "bosch,bmp280", .data = (void *)BMP280_CHIP_ID },
> +	{ .compatible = "bosch,bmp180", .data = (void *)BMP180_CHIP_ID },
> +	{ .compatible = "bosch,bmp085", .data = (void *)BMP180_CHIP_ID },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(of, bmp280_of_match);
> +#else
> +#define bmp280_of_match NULL
> +#endif
> +
>  static const struct i2c_device_id bmp280_id[] = {
>  	{"bmp280", BMP280_CHIP_ID },
>  	{"bmp180", BMP180_CHIP_ID },
> @@ -1107,6 +1121,7 @@ static struct i2c_driver bmp280_driver = {
>  	.driver = {
>  		.name	= "bmp280",
>  		.acpi_match_table = ACPI_PTR(bmp280_acpi_match),
> +		.of_match_table = of_match_ptr(bmp280_of_match),
>  	},
>  	.probe		= bmp280_probe,
>  	.id_table	= bmp280_id,
> 

