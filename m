Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([84.19.176.117]:43670 "EHLO vps.pmeerw.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751614AbdJ0R5O (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 27 Oct 2017 13:57:14 -0400
Date: Fri, 27 Oct 2017 19:57:12 +0200 (CEST)
From: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
To: Marc CAPDEVILLE <m.capdeville@no-log.org>
cc: Kevin Tsai <ktsai@capellamicro.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Wolfram Sang <wsa@the-dreams.de>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] iio : Add cm3218 smbus ara and acpi support
In-Reply-To: <20171027161426.m27e52jvnpgembsu@azrael>
Message-ID: <alpine.DEB.2.20.1710271951001.29421@vps.pmeerw.net>
References: <20171027161426.m27e52jvnpgembsu@azrael>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


> On asus T100, Capella cm3218 chip is implemented as ambiant light
> sensor. This chip expose an smbus ARA protocol device on standard
> address 0x0c. The chip is not functional before all alerts are
> acknowledged.
> On asus T100, this device is enumerated on ACPI bus and the description
> give tow I2C connection. The first is the connection to the ARA device
> and the second gives the real address of the device.
> 
> So, on device probe,If the i2c address is the ARA address and the
> device is enumerated via acpi, we lookup for the real address in
> the ACPI resource list and change it in the client structure.
> if an interrupt resource is given, and only for cm3218 chip,
> we declare an smbus_alert device.


I think the unrelated cleanups should have been put in a separate patch (I 
feel sorry for guiding you in the wrong direction and not pointing this 
out more clearly)

more very minor comments below
 
> Signed-off-by: Marc CAPDEVILLE <m.capdeville@no-log.org>
> ---
> v4 :
>    - rework acpi i2c adress lookup due to bad commit being sent.
> 
> v3 :
>    - rework acpi i2c adress lookup
>    - comment style cleanup
>    - add prefix cm32181_to constantes and macros
> 
> v2 :
>    - cm3218 support always build
>    - Cleanup of unneeded #if statement
>    - Beter identifying chip in platform device, acpi and of_device
> 
>  drivers/iio/light/cm32181.c | 202 ++++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 185 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/iio/light/cm32181.c b/drivers/iio/light/cm32181.c
> index d6fd0dace74f..f1a7495e851b 100644
> --- a/drivers/iio/light/cm32181.c
> +++ b/drivers/iio/light/cm32181.c
> @@ -18,8 +18,12 @@
>  #include <linux/iio/sysfs.h>
>  #include <linux/iio/events.h>
>  #include <linux/init.h>
> +#include <linux/i2c-smbus.h>
> +#include <linux/acpi.h>
> +#include <linux/of_device.h>
> +#include <linux/resource_ext.h>
>  
> -/* Registers Address */
> +/* Registers Addresses */

Register Addresses

>  #define CM32181_REG_ADDR_CMD		0x00
>  #define CM32181_REG_ADDR_ALS		0x04
>  #define CM32181_REG_ADDR_STATUS		0x06
> @@ -45,18 +49,25 @@
>  #define CM32181_MLUX_PER_BIT_BASE_IT	800000	/* Based on IT=800ms */
>  #define	CM32181_CALIBSCALE_DEFAULT	1000
>  #define CM32181_CALIBSCALE_RESOLUTION	1000
> -#define MLUX_PER_LUX			1000
> +#define CM32181_MLUX_PER_LUX			1000
> +
> +#define CM32181_ID			0x81
> +#define CM3218_ID			0x18
> +
> +#define CM3218_ARA_ADDR			0x0c
>  
>  static const u8 cm32181_reg[CM32181_CONF_REG_NUM] = {
>  	CM32181_REG_ADDR_CMD,
>  };
>  
> -static const int als_it_bits[] = {12, 8, 0, 1, 2, 3};
> -static const int als_it_value[] = {25000, 50000, 100000, 200000, 400000,
> +static const int cm32181_als_it_bits[] = {12, 8, 0, 1, 2, 3};
> +static const int cm32181_als_it_value[] = {25000, 50000, 100000, 200000, 400000,
>  	800000};
>  
>  struct cm32181_chip {
>  	struct i2c_client *client;
> +	int chip_id;
> +	struct i2c_client *ara;
>  	struct mutex lock;
>  	u16 conf_regs[CM32181_CONF_REG_NUM];
>  	int calibscale;
> @@ -81,7 +92,7 @@ static int cm32181_reg_init(struct cm32181_chip *cm32181)
>  		return ret;
>  
>  	/* check device ID */
> -	if ((ret & 0xFF) != 0x81)
> +	if ((ret & 0xFF) != cm32181->chip_id)
>  		return -ENODEV;
>  
>  	/* Default Values */
> @@ -103,7 +114,7 @@ static int cm32181_reg_init(struct cm32181_chip *cm32181)
>  /**
>   *  cm32181_read_als_it() - Get sensor integration time (ms)
>   *  @cm32181:	pointer of struct cm32181
> - *  @val2:	pointer of int to load the als_it value.
> + *  @val2:	pointer of int to load the cm32181_als_it value.
>   *
>   *  Report the current integartion time by millisecond.
>   *
> @@ -117,9 +128,9 @@ static int cm32181_read_als_it(struct cm32181_chip *cm32181, int *val2)
>  	als_it = cm32181->conf_regs[CM32181_REG_ADDR_CMD];
>  	als_it &= CM32181_CMD_ALS_IT_MASK;
>  	als_it >>= CM32181_CMD_ALS_IT_SHIFT;
> -	for (i = 0; i < ARRAY_SIZE(als_it_bits); i++) {
> -		if (als_it == als_it_bits[i]) {
> -			*val2 = als_it_value[i];
> +	for (i = 0; i < ARRAY_SIZE(cm32181_als_it_bits); i++) {
> +		if (als_it == cm32181_als_it_bits[i]) {
> +			*val2 = cm32181_als_it_value[i];
>  			return IIO_VAL_INT_PLUS_MICRO;
>  		}
>  	}
> @@ -142,14 +153,14 @@ static int cm32181_write_als_it(struct cm32181_chip *cm32181, int val)
>  	u16 als_it;
>  	int ret, i, n;
>  
> -	n = ARRAY_SIZE(als_it_value);
> +	n = ARRAY_SIZE(cm32181_als_it_value);
>  	for (i = 0; i < n; i++)
> -		if (val <= als_it_value[i])
> +		if (val <= cm32181_als_it_value[i])
>  			break;
>  	if (i >= n)
>  		i = n - 1;
>  
> -	als_it = als_it_bits[i];
> +	als_it = cm32181_als_it_bits[i];
>  	als_it <<= CM32181_CMD_ALS_IT_SHIFT;
>  
>  	mutex_lock(&cm32181->lock);
> @@ -195,7 +206,7 @@ static int cm32181_get_lux(struct cm32181_chip *cm32181)
>  	lux *= ret;
>  	lux *= cm32181->calibscale;
>  	lux /= CM32181_CALIBSCALE_RESOLUTION;
> -	lux /= MLUX_PER_LUX;
> +	lux /= CM32181_MLUX_PER_LUX;
>  
>  	if (lux > 0xFFFF)
>  		lux = 0xFFFF;
> @@ -263,9 +274,9 @@ static ssize_t cm32181_get_it_available(struct device *dev,
>  {
>  	int i, n, len;
>  
> -	n = ARRAY_SIZE(als_it_value);
> +	n = ARRAY_SIZE(cm32181_als_it_value);
>  	for (i = 0, len = 0; i < n; i++)
> -		len += sprintf(buf + len, "0.%06u ", als_it_value[i]);
> +		len += sprintf(buf + len, "0.%06u ", cm32181_als_it_value[i]);
>  	return len + sprintf(buf + len, "\n");
>  }
>  
> @@ -298,12 +309,89 @@ static const struct iio_info cm32181_info = {
>  	.attrs			= &cm32181_attribute_group,
>  };
>  
> +#if defined(CONFIG_ACPI)
> +/* Filter acpi resources for a real i2c address on same adapter */
> +static int cm3218_filter_i2c_address(struct acpi_resource *ares, void *data)
> +{
> +	struct i2c_client *client = data;
> +	struct acpi_resource_i2c_serialbus *sb;
> +	acpi_status status;
> +	acpi_handle adapter_handle;
> +
> +	if (ares->type != ACPI_RESOURCE_TYPE_SERIAL_BUS)
> +		return 1;
> +
> +	sb = &ares->data.i2c_serial_bus;
> +	if (sb->type != ACPI_RESOURCE_SERIAL_TYPE_I2C)
> +		return 1;
> +
> +	status = acpi_get_handle(ACPI_HANDLE(&client->dev),
> +				 sb->resource_source.string_ptr,
> +				 &adapter_handle);
> +	if (ACPI_FAILURE(status))
> +		return status;
> +
> +	if (adapter_handle != ACPI_HANDLE(&client->adapter->dev))
> +		return 1;
> +
> +	if (sb->slave_address == CM3218_ARA_ADDR)
> +		return 1;
> +
> +	return AE_OK;
> +}
> +
> +/* Get the real i2c address from acpi resources */
> +static int cm3218_acpi_get_address(struct i2c_client *client)
> +{
> +	int ret;
> +	struct acpi_device *adev;
> +	LIST_HEAD(res_list);
> +	struct resource_entry *res_entry;
> +	struct acpi_resource *ares;
> +	struct acpi_resource_i2c_serialbus *sb;
> +
> +	adev = ACPI_COMPANION(&client->dev);
> +	if (!adev)
> +		return -ENODEV;
> +
> +	ret = acpi_dev_get_resources(adev,
> +				     &res_list,
> +				     cm3218_filter_i2c_address,
> +				     client);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* get first resource */
> +	res_entry = list_entry(&res_list, struct resource_entry, node);
> +	ares = (struct acpi_resource *)res_entry->res;
> +	sb = &ares->data.i2c_serial_bus;
> +
> +	/* set i2c address */
> +	client->addr = sb->slave_address;
> +	client->flags &= ~I2C_CLIENT_TEN;
> +	if (sb->access_mode == ACPI_I2C_10BIT_MODE)
> +		client->flags |= I2C_CLIENT_TEN;
> +
> +	acpi_dev_free_resource_list(&res_list);
> +
> +	return 0;
> +}
> +#else
> +static inline int cm3218_acpi_get_address(struct i2c_client *client)

the unnecessary inline is still there...
the compiler will figure out on its own even without it (and I think the 
function signatures should be the same with and without CONFIG_ACPI

> +{
> +	return -ENODEV;
> +}
> +#endif
> +
>  static int cm32181_probe(struct i2c_client *client,
>  			const struct i2c_device_id *id)
>  {
>  	struct cm32181_chip *cm32181;
>  	struct iio_dev *indio_dev;
>  	int ret;
> +	struct i2c_smbus_alert_setup ara_setup;
> +	const struct of_device_id *of_id;
> +	const struct acpi_device_id *acpi_id;
>  
>  	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*cm32181));
>  	if (!indio_dev) {
> @@ -323,11 +411,65 @@ static int cm32181_probe(struct i2c_client *client,
>  	indio_dev->name = id->name;
>  	indio_dev->modes = INDIO_DIRECT_MODE;
>  
> +	/* Lookup for chip ID from platform, acpi or of device table */
> +	if (id) {
> +		cm32181->chip_id = id->driver_data;
> +	} else if (ACPI_COMPANION(&client->dev)) {
> +		acpi_id = acpi_match_device(client->dev.driver->acpi_match_table,
> +					    &client->dev);
> +		if (!acpi_id)
> +			return -ENODEV;
> +
> +		cm32181->chip_id = (kernel_ulong_t)acpi_id->driver_data;
> +	} else if (client->dev.of_node) {
> +		of_id = of_match_device(clients->dev.driver->of_match_table,
> +					&client->dev);
> +		if (!of_id)
> +			return -ENODEV;
> +
> +		cm32181->chip_id = (kernel_ulong_t)of_id->data;
> +	} else {
> +		return -ENODEV;
> +	}
> +
> +	if (cm32181->chip_id == CM3218_ID) {
> +		if (client->addr == CM3218_ARA_ADDR) {
> +			/*
> +			 * In case first address is the ARA device
> +			 * lookup for a second one in acpi resources if
> +			 * this client is enumerated on acpi
> +			 */
> +			ret = cm3218_acpi_get_address(client);
> +			if (ret < 0)
> +				return -ENODEV;
> +		}
> +
> +#ifdef CONFIG_I2C_SMBUS
> +		if (client->irq > 0) {
> +			/* setup smb alert device */
> +			ara_setup.irq = client->irq;
> +			ara_setup.alert_edge_triggered = 0;
> +			cm32181->ara = i2c_setup_smbus_alert(client->adapter,
> +							     &ara_setup);
> +			if (!cm32181->ara)
> +				return -ENODEV;
> +		} else {
> +			return -ENODEV;
> +		}
> +#else
> +		return -ENODEV;
> +#endif
> +	}
> +
>  	ret = cm32181_reg_init(cm32181);
>  	if (ret) {
>  		dev_err(&client->dev,
>  			"%s: register init failed\n",
>  			__func__);
> +
> +		if (cm32181->ara)
> +			i2c_unregister_device(cm32181->ara);
> +
>  		return ret;
>  	}
>  
> @@ -336,32 +478,58 @@ static int cm32181_probe(struct i2c_client *client,
>  		dev_err(&client->dev,
>  			"%s: regist device failed\n",
>  			__func__);
> +
> +		if (cm32181->ara)
> +			i2c_unregister_device(cm32181->ara);
> +
>  		return ret;
>  	}
>  
>  	return 0;
>  }
>  
> +static int cm32181_remove(struct i2c_client *client)
> +{
> +	struct iio_dev *indio_dev = i2c_get_clientdata(client);
> +	struct cm32181_chip *cm32181 = iio_priv(indio_dev);
> +
> +	if (cm32181->ara)
> +		i2c_unregister_device(cm32181->ara);
> +
> +	return 0;
> +};
> +
>  static const struct i2c_device_id cm32181_id[] = {
> -	{ "cm32181", 0 },
> +	{ "cm32181", CM32181_ID },
> +	{ "cm3218", CM3218_ID },
>  	{ }
>  };
>  
>  MODULE_DEVICE_TABLE(i2c, cm32181_id);
>  
>  static const struct of_device_id cm32181_of_match[] = {
> -	{ .compatible = "capella,cm32181" },
> +	{ .compatible = "capella,cm32181", (void *)CM32181_ID },
> +	{ .compatible = "capella,cm3218",  (void *)CM3218_ID },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(of, cm32181_of_match);
>  
> +static const struct acpi_device_id cm32181_acpi_match[] = {
> +	{ "CPLM3218", CM3218_ID },
> +	{ }
> +};
> +
> +MODULE_DEVICE_TABLE(acpi, cm32181_acpi_match);
> +
>  static struct i2c_driver cm32181_driver = {
>  	.driver = {
>  		.name	= "cm32181",
>  		.of_match_table = of_match_ptr(cm32181_of_match),
> +		.acpi_match_table = ACPI_PTR(cm32181_acpi_match),
>  	},
>  	.id_table       = cm32181_id,
>  	.probe		= cm32181_probe,
> +	.remove		= cm32181_remove,
>  };
>  
>  module_i2c_driver(cm32181_driver);
> 

-- 

Peter Meerwald-Stadler
Mobile: +43 664 24 44 418
