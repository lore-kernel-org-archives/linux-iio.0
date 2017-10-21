Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:38490 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932132AbdJUR04 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 21 Oct 2017 13:26:56 -0400
Date: Sat, 21 Oct 2017 18:26:51 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Marc CAPDEVILLE <m.capdeville@no-log.org>
Cc: Kevin Tsai <ktsai@capellamicro.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] iio : Add cm3218 smbus ara and acpi support
Message-ID: <20171021182651.08a2214f@archlinux>
In-Reply-To: <20171019163231.GA8831@azrael>
References: <20171019163231.GA8831@azrael>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, 19 Oct 2017 18:32:31 +0200
Marc CAPDEVILLE <m.capdeville@no-log.org> wrote:

> On asus T100, Capella cm3218 chip is implemented as ambiant light
> sensor. This chip expose an smbus ARA protocol device on standard
> address 0x0c. The chip is not functional before all alerts are
> acknowledged.
> On asus T100, this device is enumerated on ACPI bus and the description
> give tow I2C connection. The first is the connection to the ARA device
> and the second gives the real address of the device.
> 
> So, on device probe, if an interrupt resource is given, we declare an
> smbus_alert device, and if the i2c address is the ARA address, we lookup
> for the second in the ACPI resource list and change it in the client
> structur.
> 
> Signed-off-by: Marc CAPDEVILLE <m.capdeville@no-log.org>

Hi,

You have put too much effort in here to avoid any changes
to what is currently built.  It's a good aim, but not when
it comes at the cost of readability.

My main concern is the complexity of ifdef fun we have in here.
Personally I'm not that bothered by pulling the I2C_SMBUS in for
the normal build of the driver.  It's not exactly a heavy
weight dependency.

I am definitely not keen on having an explicit ACPI Kconfig option.
Support for that should just always be built in if CONFIG_ACPI
is enabled.

The ACPI and ara bit is complex enough I've cc'd Wolfram for an
opinion. Wolfram - what do you think of the means of configuring
the ARA client seen here from ACPI?

In particular - all the existing users of the alert registration
code are buses which makes me suspicious ;)

Thanks,

Jonathan

> ---
>  drivers/iio/light/Kconfig   |  19 +++++++
>  drivers/iio/light/cm32181.c | 119 ++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 138 insertions(+)
> 
> diff --git a/drivers/iio/light/Kconfig b/drivers/iio/light/Kconfig
> index 2356ed9..6b1dacc 100644
> --- a/drivers/iio/light/Kconfig
> +++ b/drivers/iio/light/Kconfig
> @@ -94,6 +94,25 @@ config CM32181
>  	 To compile this driver as a module, choose M here:
>  	 the module will be called cm32181.
>  
> +if CM32181
> +config CM3218
> +	depends on CM32181
> +	depends on I2C_SMBUS
> +	bool "Support for smbus ara protocol on cm3218 chip"
> +	help
> +	 Say Y here if you want to support Capella cm3218
> +	 ambiant light sensor with smbus ARA protocol.
> +
> +config CM3218_ACPI
> +	depends on CM3218
> +	depends on ACPI
> +	bool "Support for second address on acpi enumerated cm3218"
> +	help
> +	 Say Y here if you want to support Capella cm3218
> +	 ambiant light sensor enumerated on ACPI.
> +
> +endif #CM32181
> +
>  config CM3232
>  	depends on I2C
>  	tristate "CM3232 ambient light sensor"
> diff --git a/drivers/iio/light/cm32181.c b/drivers/iio/light/cm32181.c
> index d6fd0da..9b69177 100644
> --- a/drivers/iio/light/cm32181.c
> +++ b/drivers/iio/light/cm32181.c
> @@ -18,6 +18,12 @@
>  #include <linux/iio/sysfs.h>
>  #include <linux/iio/events.h>
>  #include <linux/init.h>
> +#if defined(CONFIG_I2C_SMBUS) && defined(CONFIG_CM3218)
> +#include <linux/i2c-smbus.h>
> +#if  defined(CONFIG_ACPI) && defined(CONFIG_CM3218_ACPI)
> +#include <linux/acpi.h>
> +#endif
> +#endif
Include these whatever..
>  
>  /* Registers Address */
>  #define CM32181_REG_ADDR_CMD		0x00
> @@ -47,6 +53,10 @@
>  #define CM32181_CALIBSCALE_RESOLUTION	1000
>  #define MLUX_PER_LUX			1000
>  
> +#if defined(CONFIG_I2C_SMBUS) && defined(CONFIG_CM3218)
> +#define CM3218_ARA_ADDR			0x0c
> +#endif
It's a constant.  What harm does always defining it do?
> +
>  static const u8 cm32181_reg[CM32181_CONF_REG_NUM] = {
>  	CM32181_REG_ADDR_CMD,
>  };
> @@ -57,6 +67,9 @@ static const int als_it_value[] = {25000, 50000, 100000, 200000, 400000,
>  
>  struct cm32181_chip {
>  	struct i2c_client *client;
> +#if  defined(CONFIG_I2C_SMBUS) && defined(CONFIG_CM3218)
> +	struct i2c_client *ara;
> +#endif
It's a single pointer.  Even if it meant sense to have all the config
complexity - it never made sense to stick ifdefs around this.
>  	struct mutex lock;
>  	u16 conf_regs[CM32181_CONF_REG_NUM];
>  	int calibscale;
> @@ -81,7 +94,11 @@ static int cm32181_reg_init(struct cm32181_chip *cm32181)
>  		return ret;
>  
>  	/* check device ID */
> +#ifdef CONFIG_CM3218
Get rid of this complexity by always supporting the CM3218
> +	if ((ret & 0xFF) != 0x81 && (ret & 0xFF) != 0x18)
> +#else
>  	if ((ret & 0xFF) != 0x81)
> +#endif
>  		return -ENODEV;
>  
>  	/* Default Values */
> @@ -298,12 +315,59 @@ static const struct iio_info cm32181_info = {
>  	.attrs			= &cm32181_attribute_group,
>  };
>  
> +#if defined(CONFIG_ACPI) && defined(CONFIG_CM3218_ACPI)
> +static int cm3218_get_i2c_client(struct acpi_resource *ares, void *data)
> +{
> +	struct i2c_client *client = data;
> +	struct acpi_resource_i2c_serialbus *sb;
> +	acpi_status status;
> +	acpi_handle adapter_handle;
> +	acpi_handle client_adapter_handle;
> +
> +	if (ares->type != ACPI_RESOURCE_TYPE_SERIAL_BUS)
> +		return 1;
> +
> +	sb = &ares->data.i2c_serial_bus;
> +	if (sb->type != ACPI_RESOURCE_SERIAL_TYPE_I2C)
> +		return 1;
> +
> +	status = acpi_get_handle(acpi_device_handle(ACPI_COMPANION(&client->dev)),
> +				 sb->resource_source.string_ptr,
> +				 &adapter_handle);
> +	if (!ACPI_SUCCESS(status))
> +		return 1;
> +
> +	client_adapter_handle = acpi_device_handle(ACPI_COMPANION(&client->adapter->dev));
> +
> +	if (adapter_handle != client_adapter_handle)
> +		return 1;
> +
> +	if (sb->slave_address == client->addr)
> +		return 1;
> +
> +	client->addr = sb->slave_address;
> +	client->flags &= ~I2C_CLIENT_TEN;
> +	if (sb->access_mode == ACPI_I2C_10BIT_MODE)
> +		client->flags |= I2C_CLIENT_TEN;
This needs some explanatory comments.  It's an elaborate trick to get the
slave address from ACPI presumably...  
> +
> +	return -1;
> +}
> +#endif
> +
>  static int cm32181_probe(struct i2c_client *client,
>  			const struct i2c_device_id *id)
>  {
>  	struct cm32181_chip *cm32181;
>  	struct iio_dev *indio_dev;
>  	int ret;
> +#if defined(CONFIG_I2C_SMBUS) && defined(CONFIG_CM3218)
> +	struct i2c_smbus_alert_setup ara_setup;
> +#if defined(CONFIG_ACPI) && defined(CONFIG_CM3218_ACPI)
> +	struct acpi_device *adev;
> +	LIST_HEAD(ares);

You could move the scope of these to inside the other ifdef
and tidy this mess up somewhat.

> +#endif
> +#endif
> +
>  
>  	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*cm32181));
>  	if (!indio_dev) {
> @@ -323,6 +387,30 @@ static int cm32181_probe(struct i2c_client *client,
>  	indio_dev->name = id->name;
>  	indio_dev->modes = INDIO_DIRECT_MODE;
>  
> +#if defined(CONFIG_I2C_SMBUS) && defined(CONFIG_CM3218)
Check the device type, not the config symbol.

> +	if (client->irq > 0) {
> +		if (client->addr == CM3218_ARA_ADDR) {
> +#if defined(CONFIG_ACPI) && defined(CONFIG_CM3218_ACPI)
Just CONFIG_ACPI please.

> +			adev = ACPI_COMPANION(&client->dev);
> +			if (!adev)
> +				return -ENODEV;
> +			ret = acpi_dev_get_resources(adev,
> +						     &ares,
> +						     cm3218_get_i2c_client,
> +						     client);
What is this dance actually for?   I'd expect to see some comments here.
> +			acpi_dev_free_resource_list(&ares);
> +			if (ret < 0)
> +				return -ENODEV;
> +#else
> +			return -ENODEV;
> +#endif
> +		}
> +		ara_setup.irq = client->irq;
> +		ara_setup.alert_edge_triggered = 0;
> +		cm32181->ara = i2c_setup_smbus_alert(client->adapter,
> +						     &ara_setup);
> +	}
> +#endif
>  	ret = cm32181_reg_init(cm32181);
>  	if (ret) {
>  		dev_err(&client->dev,
> @@ -342,8 +430,24 @@ static int cm32181_probe(struct i2c_client *client,
>  	return 0;
>  }
>  
> +#if defined(CONFIG_I2C_SMBUS) && defined(CONFIG_CM3218)
> +static int cm32181_remove(struct i2c_client *client)
> +{
> +	struct iio_dev *indio_dev = i2c_get_clientdata(client);
> +	struct cm32181_chip *cm32181 = iio_priv(indio_dev);
> +
> +	if (cm32181->ara)
> +		i2c_unregister_device(cm32181->ara);
This is breaking the ordering wrt to probe.  
> +
> +	return 0;
> +};
> +#endif
> +
>  static const struct i2c_device_id cm32181_id[] = {
>  	{ "cm32181", 0 },
> +#if defined(CONFIG_I2C_SMBUS) && defined(CONFIG_CM3218)
> +	{ "CPLM3218", 1 },
> +#endif
>  	{ }
>  };
>  
> @@ -355,13 +459,28 @@ static const struct of_device_id cm32181_of_match[] = {
>  };
>  MODULE_DEVICE_TABLE(of, cm32181_of_match);
>  
> +#if defined(CONFIG_ACPI) && defined(CONFIG_CM3218_ACPI)
> +static const struct acpi_device_id cm32181_acpi_match[] = {
> +	{ "CPLM3218", 0 },
> +	{ }
> +};
> +
> +MODULE_DEVICE_TABLE(acpi, cm32181_acpi_match);
> +#endif
> +
>  static struct i2c_driver cm32181_driver = {
>  	.driver = {
>  		.name	= "cm32181",
>  		.of_match_table = of_match_ptr(cm32181_of_match),
> +#if defined(CONFIG_ACPI) && defined(CONFIG_CM3218_ACPI)
> +		.acpi_match_table = ACPI_PTR(cm32181_acpi_match),
> +#endif
>  	},
>  	.id_table       = cm32181_id,
>  	.probe		= cm32181_probe,
> +#if defined(CONFIG_I2C_SMBUS) && defined(CONFIG_CM3218)
> +	.remove		= cm32181_remove,
> +#endif
>  };
>  
>  module_i2c_driver(cm32181_driver);

