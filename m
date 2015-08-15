Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:47570 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752846AbbHOPD0 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 15 Aug 2015 11:03:26 -0400
Subject: Re: [PATCH v3 6/6] iio: bmg160: Add SPI driver
To: Peter Meerwald <pmeerw@pmeerw.net>,
	Markus Pargmann <mpa@pengutronix.de>
References: <1439391009-6051-1-git-send-email-mpa@pengutronix.de>
 <1439391009-6051-7-git-send-email-mpa@pengutronix.de>
 <alpine.DEB.2.02.1508121716430.13952@pmeerw.net>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Vlad Dogaru <vlad.dogaru@intel.com>,
	Paul Bolle <pebolle@tiscali.nl>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel@pengutronix.de
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <55CF54BC.5030602@kernel.org>
Date: Sat, 15 Aug 2015 16:03:24 +0100
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.02.1508121716430.13952@pmeerw.net>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 12/08/15 16:19, Peter Meerwald wrote:
> On Wed, 12 Aug 2015, Markus Pargmann wrote:
> 
>> Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> 
> the spelling of Bosch is inconsistent, sometimes it is BOSCH, I'd prefer 
> the former
> 
> please find a slightly more relevant comment below :)
Another comment on the break up of modules you have here
which is a bit odd and leads to two large modules instead
of 1 large and 2 small (which I think would be preferable).

Jonathan
> 
>> ---
>>  drivers/iio/gyro/Kconfig      | 11 +++++++++
>>  drivers/iio/gyro/Makefile     |  1 +
>>  drivers/iio/gyro/bmg160_spi.c | 57 +++++++++++++++++++++++++++++++++++++++++++
>>  3 files changed, 69 insertions(+)
>>  create mode 100644 drivers/iio/gyro/bmg160_spi.c
>>
>> diff --git a/drivers/iio/gyro/Kconfig b/drivers/iio/gyro/Kconfig
>> index 13f8e0051615..a77dbb0062fe 100644
>> --- a/drivers/iio/gyro/Kconfig
>> +++ b/drivers/iio/gyro/Kconfig
>> @@ -71,6 +71,17 @@ config BMG160_I2C
>>  	  This driver can also be built as a module.  If so, the module
>>  	  will be called bmg160_i2c.
>>  
>> +config BMG160_SPI
>> +	tristate "Driver for connection via SPI"
>> +	depends on SPI
>> +	select REGMAP_SPI
>> +	help
>> +	  Say yes here to build support for Bosch BMG160 Tri-axis Gyro Sensor
>> +	  driver connected via SPI. This driver also supports BMI055 gyroscope.
>> +
>> +	  This driver can also be built as a module.  If so, the module
>> +	  will be called bmg160_spi.
>> +
>>  endif
>>  
>>  config HID_SENSOR_GYRO_3D
>> diff --git a/drivers/iio/gyro/Makefile b/drivers/iio/gyro/Makefile
>> index 73b41e43a974..848e55c605c0 100644
>> --- a/drivers/iio/gyro/Makefile
>> +++ b/drivers/iio/gyro/Makefile
>> @@ -9,6 +9,7 @@ obj-$(CONFIG_ADIS16136) += adis16136.o
>>  obj-$(CONFIG_ADIS16260) += adis16260.o
>>  obj-$(CONFIG_ADXRS450) += adxrs450.o
>>  obj-$(CONFIG_BMG160_I2C) += bmg160_core.o bmg160_i2c.o
>> +obj-$(CONFIG_BMG160_I2C) += bmg160_core.o bmg160_spi.o
So if both are present (and most distros will build both) we will have
the core stuff built twice?  I'd rather that was a separate module
as is usually done for this sort of case.  See how the ST accelerometer
driver does it (slightly more complex case)
>>  
>>  obj-$(CONFIG_HID_SENSOR_GYRO_3D) += hid-sensor-gyro-3d.o
>>  
>> diff --git a/drivers/iio/gyro/bmg160_spi.c b/drivers/iio/gyro/bmg160_spi.c
>> new file mode 100644
>> index 000000000000..8a358571b702
>> --- /dev/null
>> +++ b/drivers/iio/gyro/bmg160_spi.c
>> @@ -0,0 +1,57 @@
>> +#include <linux/spi/spi.h>
>> +#include <linux/regmap.h>
>> +#include <linux/iio/iio.h>
>> +#include <linux/module.h>
>> +
>> +#include <bmg160.h>
> 
> I think this should be
> #include "bmg160.h"
> as in the _i2c part of the driver
> 
>> +
>> +static const struct regmap_config bmg160_regmap_spi_conf = {
>> +	.reg_bits = 8,
>> +	.val_bits = 8,
>> +	.max_register = 0x3f,
>> +};
>> +
>> +static int bmg160_spi_probe(struct spi_device *spi)
>> +{
>> +	struct regmap *regmap;
>> +	const struct spi_device_id *id = spi_get_device_id(spi);
>> +
>> +	regmap = devm_regmap_init_spi(spi, &bmg160_regmap_spi_conf);
>> +	if (IS_ERR(regmap)) {
>> +		dev_err(&spi->dev, "Failed to register spi regmap %d\n",
>> +			(int)PTR_ERR(regmap));
>> +		return PTR_ERR(regmap);
>> +	}
>> +
>> +	return bmg160_core_probe(&spi->dev, regmap, spi->irq, id->name);
>> +}
>> +
>> +static int bmg160_spi_remove(struct spi_device *spi)
>> +{
>> +	bmg160_core_remove(&spi->dev);
>> +
>> +	return 0;
>> +}
>> +
>> +static const struct spi_device_id bmg160_spi_id[] = {
>> +	{"bmg160", 0},
>> +	{"bmi055_gyro", 0},
>> +	{}
>> +};
>> +
>> +MODULE_DEVICE_TABLE(spi, bmg160_spi_id);
>> +
>> +static struct spi_driver bmg160_spi_driver = {
>> +	.driver = {
>> +		.name	= "bmg160_spi",
>> +		.pm	= &bmg160_pm_ops,
>> +	},
>> +	.probe		= bmg160_spi_probe,
>> +	.remove		= bmg160_spi_remove,
>> +	.id_table	= bmg160_spi_id,
>> +};
>> +module_spi_driver(bmg160_spi_driver);
>> +
>> +MODULE_AUTHOR("Markus Pargmann <mpa@pengutronix.de>");
>> +MODULE_LICENSE("GPL v2");
>> +MODULE_DESCRIPTION("BMG160 SPI Gyro driver");
>>
> 

