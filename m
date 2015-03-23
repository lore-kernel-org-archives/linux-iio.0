Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:15876 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752497AbbCWPSw (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 23 Mar 2015 11:18:52 -0400
Date: Mon, 23 Mar 2015 17:18:41 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Robert Dolca <robert.dolca@intel.com>
Cc: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
	linux-kernel@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Linus Walleij <linus.walleij@linaro.org>,
	Denis CIOCCA <denis.ciocca@st.com>
Subject: Re: [PATCH] IIO: Adds ACPI support for ST gyroscopes
Message-ID: <20150323151841.GA1878@lahna.fi.intel.com>
References: <1427118025-4380-1-git-send-email-robert.dolca@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1427118025-4380-1-git-send-email-robert.dolca@intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, Mar 23, 2015 at 03:40:24PM +0200, Robert Dolca wrote:
> Signed-off-by: Robert Dolca <robert.dolca@intel.com>
> ---
>  drivers/iio/common/st_sensors/st_sensors_i2c.c | 35 ++++++++++++++++++++++++++
>  drivers/iio/gyro/st_gyro_i2c.c                 | 29 ++++++++++++++++++++-
>  include/linux/iio/common/st_sensors_i2c.h      |  3 +++
>  3 files changed, 66 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/common/st_sensors/st_sensors_i2c.c b/drivers/iio/common/st_sensors/st_sensors_i2c.c
> index 98cfee29..2f612ec 100644
> --- a/drivers/iio/common/st_sensors/st_sensors_i2c.c
> +++ b/drivers/iio/common/st_sensors/st_sensors_i2c.c
> @@ -13,6 +13,8 @@
>  #include <linux/slab.h>
>  #include <linux/iio/iio.h>
>  #include <linux/of_device.h>
> +#include <linux/acpi.h>
> +#include <linux/gpio/consumer.h>
>  
>  #include <linux/iio/common/st_sensors_i2c.h>
>  
> @@ -107,6 +109,39 @@ void st_sensors_of_i2c_probe(struct i2c_client *client,
>  EXPORT_SYMBOL(st_sensors_of_i2c_probe);
>  #endif
>  
> +int st_sensors_acpi_i2c_probe(struct i2c_client *client,
> +			       const struct acpi_device_id *match)
> +{
> +	const struct acpi_device_id *id;
> +	struct gpio_desc *gpiod_irq;
> +	int ret;
> +
> +	id = acpi_match_device(match, &client->dev);
> +	if (!id)
> +		return -ENODEV;
> +
> +	/* Get IRQ GPIO */
> +	gpiod_irq = devm_gpiod_get_index(&client->dev, 0, 0);

Please use plain devm_gpiod_get(&client->dev, NULL). That should work
with DT and ACPI _DSD as well.

> +	if (IS_ERR(gpiod_irq))
> +		return -ENODEV;

Why not return the original error here? Now you lose things like
-EPROBE_DEFER.

> +	/* Configure IRQ GPIO */
> +	ret = gpiod_direction_input(gpiod_irq);
> +	if (ret)
> +		return ret;
> +
> +	/* Map the pin to an IRQ */
> +	client->irq = gpiod_to_irq(gpiod_irq);
> +
> +	/* The name from the ACPI match takes precedence if present */
> +	memset(client->name, 0, sizeof(client->name));
> +	strncpy(client->name, (char *) id->driver_data,
> +		min(sizeof(client->name), strlen((char *) id->driver_data)));

Hmm, the above should not be required at all. If the device has an ACPI
companion the I2C core will match first with that.

Also you now modify the original i2c_client structure. Should you at
least restore the original values when the driver is unbound?

> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(st_sensors_acpi_i2c_probe);
> +
>  MODULE_AUTHOR("Denis Ciocca <denis.ciocca@st.com>");
>  MODULE_DESCRIPTION("STMicroelectronics ST-sensors i2c driver");
>  MODULE_LICENSE("GPL v2");
> diff --git a/drivers/iio/gyro/st_gyro_i2c.c b/drivers/iio/gyro/st_gyro_i2c.c
> index 64480b1..712d23f 100644
> --- a/drivers/iio/gyro/st_gyro_i2c.c
> +++ b/drivers/iio/gyro/st_gyro_i2c.c
> @@ -11,6 +11,7 @@
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/slab.h>
> +#include <linux/acpi.h>
>  #include <linux/i2c.h>
>  #include <linux/iio/iio.h>
>  
> @@ -18,6 +19,25 @@
>  #include <linux/iio/common/st_sensors_i2c.h>
>  #include "st_gyro.h"
>  
> +static const char L3G4200D_gyro_dev_name[]  = "l3g4200d";
> +static const char LSM330D_gyro_dev_name[]   = "lsm330d_gyro";
> +static const char LSM330DL_gyro_dev_name[]  = "lsm330dl_gyro";
> +static const char LSM330DLC_gyro_dev_name[] = "lsm330dlc_gyro";
> +static const char L3GD20_gyro_dev_name[]    = "l3gd20";
> +static const char L3G4IS_gyro_dev_name[]    = "l3g4is_ui";
> +static const char LSM330_gyro_dev_name[]    = "lsm330_gyro";
> +
> +static const struct acpi_device_id st_gyro_acpi_match[] = {
> +	{"L3G4200D", (kernel_ulong_t) L3G4200D_gyro_dev_name},
> +	{"LSM330D",  (kernel_ulong_t) LSM330D_gyro_dev_name},
> +	{"LSM330D2", (kernel_ulong_t) LSM330DL_gyro_dev_name},
> +	{"LSM330D3", (kernel_ulong_t) LSM330DLC_gyro_dev_name},
> +	{"L3GD2000", (kernel_ulong_t) L3GD20_gyro_dev_name},
> +	{"L3G40000", (kernel_ulong_t) L3G4IS_gyro_dev_name},
> +	{"LSM3300",  (kernel_ulong_t) LSM330_gyro_dev_name},
> +	{}
> +};
> +
>  #ifdef CONFIG_OF
>  static const struct of_device_id st_gyro_of_match[] = {
>  	{
> @@ -67,7 +87,13 @@ static int st_gyro_i2c_probe(struct i2c_client *client,
>  		return -ENOMEM;
>  
>  	gdata = iio_priv(indio_dev);
> -	st_sensors_of_i2c_probe(client, st_gyro_of_match);
> +
> +	if (ACPI_HANDLE(&client->dev)) {
> +		err = st_sensors_acpi_i2c_probe(client, st_gyro_acpi_match);
> +		if (err < 0)
> +			return err;
> +	} else
> +		st_sensors_of_i2c_probe(client, st_gyro_of_match);
>  
>  	st_sensors_i2c_configure(indio_dev, client, gdata);
>  
> @@ -102,6 +128,7 @@ static struct i2c_driver st_gyro_driver = {
>  		.owner = THIS_MODULE,
>  		.name = "st-gyro-i2c",
>  		.of_match_table = of_match_ptr(st_gyro_of_match),
> +		.acpi_match_table = ACPI_PTR(st_gyro_acpi_match),
>  	},
>  	.probe = st_gyro_i2c_probe,
>  	.remove = st_gyro_i2c_remove,
> diff --git a/include/linux/iio/common/st_sensors_i2c.h b/include/linux/iio/common/st_sensors_i2c.h
> index 1796af0..2e90b8f 100644
> --- a/include/linux/iio/common/st_sensors_i2c.h
> +++ b/include/linux/iio/common/st_sensors_i2c.h
> @@ -28,4 +28,7 @@ static inline void st_sensors_of_i2c_probe(struct i2c_client *client,
>  }
>  #endif
>  
> +int st_sensors_acpi_i2c_probe(struct i2c_client *client,
> +			       const struct acpi_device_id *match);
> +
>  #endif /* ST_SENSORS_I2C_H */
> -- 
> 1.9.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
