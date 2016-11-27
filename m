Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:41245 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753907AbcK0LVz (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 27 Nov 2016 06:21:55 -0500
Subject: Re: [PATCH 1/3] iio: st_sensors: match sensors using ACPI handle
To: Shrirang Bagul <shrirang.bagul@canonical.com>
References: <20161124053345.11254-1-shrirang.bagul@canonical.com>
 <20161124053345.11254-2-shrirang.bagul@canonical.com>
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        denis.ciocca@st.com, tiberiu.a.breana@intel.com,
        lorenzo.bianconi83@gmail.com, linus.walleij@linaro.org,
        gregor.boirie@parrot.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <482a7789-0d9b-c022-c327-ba1176ad42b8@kernel.org>
Date: Sun, 27 Nov 2016 11:15:42 +0000
MIME-Version: 1.0
In-Reply-To: <20161124053345.11254-2-shrirang.bagul@canonical.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 24/11/16 05:33, Shrirang Bagul wrote:
> Add support to match st sensors using information passed from ACPI DST
> tables.
> 
> Signed-off-by: Shrirang Bagul <shrirang.bagul@canonical.com>
Applied to the togreg branch of iio.git and pushed out as testing for the autobuilders
to play with it.

Presumably at somepoint this will need extending to cover the spi parts, but we 
can do that when it is relevant.

Thanks,

Jonathan
> ---
>  drivers/iio/common/st_sensors/st_sensors_i2c.c | 20 ++++++++++++++++++++
>  include/linux/iio/common/st_sensors_i2c.h      |  9 +++++++++
>  2 files changed, 29 insertions(+)
> 
> diff --git a/drivers/iio/common/st_sensors/st_sensors_i2c.c b/drivers/iio/common/st_sensors/st_sensors_i2c.c
> index b43aa36..c83df4d 100644
> --- a/drivers/iio/common/st_sensors/st_sensors_i2c.c
> +++ b/drivers/iio/common/st_sensors/st_sensors_i2c.c
> @@ -13,6 +13,7 @@
>  #include <linux/slab.h>
>  #include <linux/iio/iio.h>
>  #include <linux/of_device.h>
> +#include <linux/acpi.h>
>  
>  #include <linux/iio/common/st_sensors_i2c.h>
>  
> @@ -107,6 +108,25 @@ void st_sensors_of_i2c_probe(struct i2c_client *client,
>  EXPORT_SYMBOL(st_sensors_of_i2c_probe);
>  #endif
>  
> +#ifdef CONFIG_ACPI
> +int st_sensors_match_acpi_device(struct device *dev)
> +{
> +	const struct acpi_device_id *acpi_id;
> +	kernel_ulong_t driver_data = 0;
> +
> +	if (ACPI_HANDLE(dev)) {
> +		acpi_id = acpi_match_device(dev->driver->acpi_match_table, dev);
> +		if (!acpi_id) {
> +			dev_err(dev, "No driver data\n");
> +			return -EINVAL;
> +		}
> +		driver_data = acpi_id->driver_data;
> +	}
> +	return driver_data;
> +}
> +EXPORT_SYMBOL(st_sensors_match_acpi_device);
> +#endif
> +
>  MODULE_AUTHOR("Denis Ciocca <denis.ciocca@st.com>");
>  MODULE_DESCRIPTION("STMicroelectronics ST-sensors i2c driver");
>  MODULE_LICENSE("GPL v2");
> diff --git a/include/linux/iio/common/st_sensors_i2c.h b/include/linux/iio/common/st_sensors_i2c.h
> index 1796af0..254de3c 100644
> --- a/include/linux/iio/common/st_sensors_i2c.h
> +++ b/include/linux/iio/common/st_sensors_i2c.h
> @@ -28,4 +28,13 @@ static inline void st_sensors_of_i2c_probe(struct i2c_client *client,
>  }
>  #endif
>  
> +#ifdef CONFIG_ACPI
> +int st_sensors_match_acpi_device(struct device *dev);
> +#else
> +static inline int st_sensors_match_acpi_device(struct device *dev)
> +{
> +	return -ENODEV;
> +}
> +#endif
> +
>  #endif /* ST_SENSORS_I2C_H */
> 

