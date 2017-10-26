Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:35162 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932137AbdJZRAm (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 26 Oct 2017 13:00:42 -0400
Date: Thu, 26 Oct 2017 18:00:25 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Marc CAPDEVILLE <m.capdeville@no-log.org>
Cc: Kevin Tsai <ktsai@capellamicro.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v2] iio : Add cm3218 smbus ara and acpi support
Message-ID: <20171026180025.34d5cba6@archlinux>
In-Reply-To: <20171025145515.GA9033@azrael>
References: <20171025145515.GA9033@azrael>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, 25 Oct 2017 16:55:15 +0200
Marc CAPDEVILLE <m.capdeville@no-log.org> wrote:

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
> 
> Signed-off-by: Marc CAPDEVILLE <m.capdeville@no-log.org>
Hi Marc,

The ACPI resource filtering is not being used as that infrastructure
is intended.  What you have here may be shorter, but it is non
standard so both fragile and harder to review.

I will also be needed an ack from Kevin and please cc wolfram as
the smbus usage is relatively unusual.

We have probably missed the upcoming merge window now (unless it
is delayed for some reason).  I am travelling for the next
two weeks so any response may be delayed (or quicker depending
on how much time I spend using airport wifi :)

Jonathan

> ---
> v2 : 
>    - cm3218 support always build
>    - Cleanup of unneeded #if statement
>    - Beter identifying chip in platform device, acpi and of_device
> 
>  drivers/iio/light/cm32181.c | 165 +++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 162 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/light/cm32181.c b/drivers/iio/light/cm32181.c
> index d6fd0da..7bc97ff 100644
> --- a/drivers/iio/light/cm32181.c
> +++ b/drivers/iio/light/cm32181.c
> @@ -18,6 +18,9 @@
>  #include <linux/iio/sysfs.h>
>  #include <linux/iio/events.h>
>  #include <linux/init.h>
> +#include <linux/i2c-smbus.h>
> +#include <linux/acpi.h>
> +#include <linux/of_device.h>
>  
>  /* Registers Address */
>  #define CM32181_REG_ADDR_CMD		0x00
> @@ -47,6 +50,11 @@
>  #define CM32181_CALIBSCALE_RESOLUTION	1000
>  #define MLUX_PER_LUX			1000
>  
> +#define CM32181_ID			0x81
> +#define CM3218_ID			0x18
> +
> +#define CM3218_ARA_ADDR			0x0c
> +
>  static const u8 cm32181_reg[CM32181_CONF_REG_NUM] = {
>  	CM32181_REG_ADDR_CMD,
>  };
> @@ -57,6 +65,8 @@ static const int als_it_value[] = {25000, 50000, 100000, 200000, 400000,
>  
>  struct cm32181_chip {
>  	struct i2c_client *client;
> +	int chip_id;
> +	struct i2c_client *ara;
>  	struct mutex lock;
>  	u16 conf_regs[CM32181_CONF_REG_NUM];
>  	int calibscale;
> @@ -81,7 +91,7 @@ static int cm32181_reg_init(struct cm32181_chip *cm32181)
>  		return ret;
>  
>  	/* check device ID */
> -	if ((ret & 0xFF) != 0x81)
> +	if ((ret & 0xFF) != cm32181->chip_id)
>  		return -ENODEV;
>  
>  	/* Default Values */
> @@ -298,12 +308,81 @@ static const struct iio_info cm32181_info = {
>  	.attrs			= &cm32181_attribute_group,
>  };
>  
> +#if defined(CONFIG_ACPI)
> +/* Parse acpi resources for a second i2c address on same adapter
> + */
Please use kernel style comment syntax with correct single and multiple
line comments.

> +static int cm3218_get_i2c_address(struct acpi_resource *ares, void *data)

Read http://elixir.free-electrons.com/linux/latest/source/drivers/acpi/resource.c#L600
help text and make this function do the actions described rrather than what it
is doing currently.

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
> +	if (!ACPI_SUCCESS(status))
> +		return 1;
> +
> +	if (adapter_handle != ACPI_HANDLE(&client->adapter->dev))
> +		return 1;
> +
> +	if (sb->slave_address == CM3218_ARA_ADDR)
> +		return 1;
> +
> +	client->addr = sb->slave_address;
> +	client->flags &= ~I2C_CLIENT_TEN;
> +	if (sb->access_mode == ACPI_I2C_10BIT_MODE)
> +		client->flags |= I2C_CLIENT_TEN;
> +
> +	return -1;
> +}
> +
> +/* Walk through acpi resources to find second i2c connection
> + */
Single line comment syntax please.
> +static int cm3218_acpi_get_address(struct i2c_client *client)
> +{
> +	int ret;
> +	struct acpi_device *adev;
> +	LIST_HEAD(ares);
> +
> +	adev = ACPI_COMPANION(&client->dev);
> +	if (!adev)
> +		return -ENODEV;
> +
> +	ret = acpi_dev_get_resources(adev,
> +				     &ares,
> +				     cm3218_get_i2c_address,
> +				     client);
> +	acpi_dev_free_resource_list(&ares);
> +	if (ret < 0)
> +		return -ENODEV;
Firstly, acpi_dev_get_resources returns meaningful error so
don't replace them.

Secondly this does not look like the intended use of this functionality.
You re getting the address effectively as a side effect rather than
explicitly doing so.  Then intent is you convert the returned resources
into a form that can be added to the resource list and then get your
answer from there...

The idea of the data element is that it is used as part of a filter,
not that you should be setting stuff in it.

So, filter the resources and put the resulting i2c serial bus resource
in the list.  Then in this function you can use that to do the
configuration.

> +
> +	return 0;
> +}
> +#else
> +static inline int cm3218_acpi_get_address(struct i2c_client *client)
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
> @@ -323,11 +402,65 @@ static int cm32181_probe(struct i2c_client *client,
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
> +			/* In case first address is the ARA device
/*
 * In case..

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
> +			/* setup smb alert device
> +			 */
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
> @@ -336,32 +469,58 @@ static int cm32181_probe(struct i2c_client *client,
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

