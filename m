Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:55826 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751148AbcCEOkh (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 5 Mar 2016 09:40:37 -0500
Subject: Re: [PATCH v4 2/3] iio:pressure:ms5611: complete DT support
To: Gregor Boirie <gregor.boirie@parrot.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org
References: <cover.1456828051.git.gregor.boirie@parrot.com>
 <6cbaba17e57b0bdc6c3550f49af9161e33438f84.1456828051.git.gregor.boirie@parrot.com>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Tomasz Duszynski <tduszyns@gmail.com>,
	Daniel Baluta <daniel.baluta@intel.com>,
	Krzysztof Kozlowski <k.kozlowski@samsung.com>,
	Mark Brown <broonie@kernel.org>,
	"Andrew F. Davis" <afd@ti.com>, Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <56DAEFE2.8080403@kernel.org>
Date: Sat, 5 Mar 2016 14:40:34 +0000
MIME-Version: 1.0
In-Reply-To: <6cbaba17e57b0bdc6c3550f49af9161e33438f84.1456828051.git.gregor.boirie@parrot.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 01/03/16 10:31, Gregor Boirie wrote:
> From: Grégor Boirie <gregor.boirie@parrot.com>
> 
> Add device-tree ID tables and document bindings.
> 
> Signed-off-by: Gregor Boirie <gregor.boirie@parrot.com>
Applied to the togreg branch of iio.git - initially pushed out as testing
for the autobuilders to play with it.  May or may not make it in this cycle
depending on what Linus says in his rc email tomorrow (and whether I get time
to do a pull request mid week).

Thanks,

Jonathan
> ---
>  .../devicetree/bindings/iio/pressure/ms5611.txt       | 19 +++++++++++++++++++
>  Documentation/devicetree/bindings/vendor-prefixes.txt |  1 +
>  drivers/iio/pressure/ms5611_i2c.c                     | 13 +++++++++++++
>  drivers/iio/pressure/ms5611_spi.c                     | 13 +++++++++++++
>  4 files changed, 46 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/pressure/ms5611.txt
> 
> diff --git a/Documentation/devicetree/bindings/iio/pressure/ms5611.txt b/Documentation/devicetree/bindings/iio/pressure/ms5611.txt
> new file mode 100644
> index 0000000..17bca86
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/pressure/ms5611.txt
> @@ -0,0 +1,19 @@
> +MEAS ms5611 family pressure sensors
> +
> +Pressure sensors from MEAS Switzerland with SPI and I2C bus interfaces.
> +
> +Required properties:
> +- compatible: "meas,ms5611" or "meas,ms5607"
> +- reg: the I2C address or SPI chip select the device will respond to
> +
> +Optional properties:
> +- vdd-supply: an optional regulator that needs to be on to provide VDD
> +  power to the sensor.
> +
> +Example:
> +
> +ms5607@77 {
> +	compatible = "meas,ms5607";
> +	reg = <0x77>;
> +	vdd-supply = <&ldo_3v3_gnss>;
> +};
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
> index 44ddc98..7733f8c 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.txt
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
> @@ -136,6 +136,7 @@ lsi	LSI Corp. (LSI Logic)
>  lltc	Linear Technology Corporation
>  marvell	Marvell Technology Group Ltd.
>  maxim	Maxim Integrated Products
> +meas	Measurement Specialties
>  mediatek	MediaTek Inc.
>  melexis	Melexis N.V.
>  merrii	Merrii Technology Co., Ltd.
> diff --git a/drivers/iio/pressure/ms5611_i2c.c b/drivers/iio/pressure/ms5611_i2c.c
> index 7f6fc8e..57a8f2c 100644
> --- a/drivers/iio/pressure/ms5611_i2c.c
> +++ b/drivers/iio/pressure/ms5611_i2c.c
> @@ -17,6 +17,7 @@
>  #include <linux/delay.h>
>  #include <linux/i2c.h>
>  #include <linux/module.h>
> +#include <linux/of_device.h>
>  
>  #include "ms5611.h"
>  
> @@ -113,6 +114,17 @@ static int ms5611_i2c_remove(struct i2c_client *client)
>  	return ms5611_remove(i2c_get_clientdata(client));
>  }
>  
> +#if defined(CONFIG_OF)
> +static const struct of_device_id ms5611_i2c_matches[] = {
> +	{ .compatible = "meas,ms5611" },
> +	{ .compatible = "ms5611" },
> +	{ .compatible = "meas,ms5607" },
> +	{ .compatible = "ms5607" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, ms5611_i2c_matches);
> +#endif
> +
>  static const struct i2c_device_id ms5611_id[] = {
>  	{ "ms5611", MS5611 },
>  	{ "ms5607", MS5607 },
> @@ -123,6 +135,7 @@ MODULE_DEVICE_TABLE(i2c, ms5611_id);
>  static struct i2c_driver ms5611_driver = {
>  	.driver = {
>  		.name = "ms5611",
> +		.of_match_table = of_match_ptr(ms5611_i2c_matches)
>  	},
>  	.id_table = ms5611_id,
>  	.probe = ms5611_i2c_probe,
> diff --git a/drivers/iio/pressure/ms5611_spi.c b/drivers/iio/pressure/ms5611_spi.c
> index 5cc009e..7ec0c64 100644
> --- a/drivers/iio/pressure/ms5611_spi.c
> +++ b/drivers/iio/pressure/ms5611_spi.c
> @@ -12,6 +12,7 @@
>  #include <linux/delay.h>
>  #include <linux/module.h>
>  #include <linux/spi/spi.h>
> +#include <linux/of_device.h>
>  
>  #include "ms5611.h"
>  
> @@ -114,6 +115,17 @@ static int ms5611_spi_remove(struct spi_device *spi)
>  	return ms5611_remove(spi_get_drvdata(spi));
>  }
>  
> +#if defined(CONFIG_OF)
> +static const struct of_device_id ms5611_spi_matches[] = {
> +	{ .compatible = "meas,ms5611" },
> +	{ .compatible = "ms5611" },
> +	{ .compatible = "meas,ms5607" },
> +	{ .compatible = "ms5607" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, ms5611_spi_matches);
> +#endif
> +
>  static const struct spi_device_id ms5611_id[] = {
>  	{ "ms5611", MS5611 },
>  	{ "ms5607", MS5607 },
> @@ -124,6 +136,7 @@ MODULE_DEVICE_TABLE(spi, ms5611_id);
>  static struct spi_driver ms5611_driver = {
>  	.driver = {
>  		.name = "ms5611",
> +		.of_match_table = of_match_ptr(ms5611_spi_matches)
>  	},
>  	.id_table = ms5611_id,
>  	.probe = ms5611_spi_probe,
> 

