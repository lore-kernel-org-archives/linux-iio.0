Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:58378 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750708AbdL2MxT (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 29 Dec 2017 07:53:19 -0500
Date: Fri, 29 Dec 2017 12:53:13 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Marc CAPDEVILLE <m.capdeville@no-log.org>
Cc: Kevin Tsai <ktsai@capellamicro.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Wolfram Sang <wsa@the-dreams.de>, linux-iio@vger.kernel.org,
        linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 3/4] iio : Add cm3218 smbus ara and acpi support
Message-ID: <20171229125313.28269179@archlinux>
In-Reply-To: <20171225155723.6338-3-m.capdeville@no-log.org>
References: <20171225155723.6338-1-m.capdeville@no-log.org>
        <20171225155723.6338-3-m.capdeville@no-log.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, 25 Dec 2017 16:57:22 +0100
Marc CAPDEVILLE <m.capdeville@no-log.org> wrote:

> On asus T100, Capella cm3218 chip is implemented as ambiant light

ambient

> sensor. This chip expose an smbus ARA protocol device on standard
> address 0x0c. The chip is not functional before all alerts are
> acknowledged.
> On asus T100, this device is enumerated on ACPI bus and the description
> give two I2C connection. The first is the connection to the ARA device
> and the second gives the real address of the device.
> 
> So, on device probe,If the i2c address is the ARA address and the

if

> device is enumerated via acpi, we change address of the device for
> the one in the second acpi serial bus connection.
> This free the ara address so we can register with the smbus_alert
> driver.
> 
> If an interrupt resource is given, and a smbus_alert device was
> found on the adapter, we request a treaded interrupt to

threaded

> call i2c_smbus_alert_event to handle the alert.
> 
> In somme case, the treaded interrupt is not schedule before the driver

threaded

> try to initialize chip registers. So if first registers access fail, we
> call i2c_smbus_alert_event() to acknowledge initial alert, then retry
> register access.
> 
> Signed-off-by: Marc CAPDEVILLE <m.capdeville@no-log.org>

The main thing that bothers me about this is it is putting a non trivial
burden on each individual driver.  Perhaps we let it go like this
for now, and see how common this is.  It would be possible (I think)
to do it in a fashion invisible to the client drivers, but I appreciate
that would be more complex than this. The multiple devices sharing a bus
with individual interrupt lines would need to be handled.

Minor comments inline.

Jonathan

> ---
>  drivers/iio/light/cm32181.c | 120 ++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 115 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iio/light/cm32181.c b/drivers/iio/light/cm32181.c
> index aebf7dd071af..96c08755e6e3 100644
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
> +#define SMBUS_ARA_ADDR			0x0c

This isn't driver specific - to my mind belongs in the smbus header.

> +
>  static const u8 cm32181_reg[CM32181_CONF_REG_NUM] = {
>  	CM32181_REG_ADDR_CMD,
>  };
> @@ -57,6 +65,7 @@ static const int als_it_value[] = {25000, 50000, 100000, 200000, 400000,
>  
>  struct cm32181_chip {
>  	struct i2c_client *client;
> +	int chip_id;
>  	struct mutex lock;
>  	u16 conf_regs[CM32181_CONF_REG_NUM];
>  	int calibscale;
> @@ -77,11 +86,22 @@ static int cm32181_reg_init(struct cm32181_chip *cm32181)
>  	s32 ret;
>  
>  	ret = i2c_smbus_read_word_data(client, CM32181_REG_ADDR_ID);
> -	if (ret < 0)
> -		return ret;
> +	if (ret < 0) {
> +		if (cm32181->chip_id == CM3218_ID) {
> +			/*
> +			 * On cm3218, smbus alert trigger after probing,
> +			 * so poll for first alert here, then retry.

Is it a level interrupt?  I'd have thought we could leave this out and let
the interrupt handler pick it up if so.
The check on the ID is rather paranoid anyway so I wouldn't worry about
it failing here.

Or are we blocked from finishing configuring the device until this is done?

> +			 */
> +			i2c_smbus_alert_event(client);
> +			ret = i2c_smbus_read_word_data(client,
> +						       CM32181_REG_ADDR_ID);
> +		} else {
> +			return ret;
> +		}
> +	}
>  
>  	/* check device ID */
> -	if ((ret & 0xFF) != 0x81)
> +	if ((ret & 0xFF) != cm32181->chip_id)
>  		return -ENODEV;
>  
>  	/* Default Values */
> @@ -297,12 +317,36 @@ static const struct iio_info cm32181_info = {
>  	.attrs			= &cm32181_attribute_group,
>  };
>  
> +static void cm3218_alert(struct i2c_client *client,
> +			 enum i2c_alert_protocol type,
> +			 unsigned int data)
> +{
> +	/*
> +	 * nothing to do for now.
> +	 * This is just here to acknownledge the cm3218 alert.
> +	 */
> +}
> +
> +static irqreturn_t cm32181_irq(int irq, void *d)
> +{
> +	struct cm32181_chip *cm32181 = d;
> +
> +	if (cm32181->chip_id == CM3218_ID) {

I'd move the check out and only register this handler if the chip supports
ARA in the first place.  That then makes this handler
generic to any ARA device. Not sure there is a generic handler available,
but it would make sense to add one if there isn't in the smbus code.

> +		/* This is cm3218 chip irq, so handle the smbus alert */
> +		i2c_smbus_alert_event(cm32181->client);
> +	}
The 32181 also has interrupt support - just looks like it isn't
ARA.

I guess support for that can be added here at some later date.
> +
> +	return IRQ_HANDLED;
> +}
> +
>  static int cm32181_probe(struct i2c_client *client,
>  			const struct i2c_device_id *id)
>  {
>  	struct cm32181_chip *cm32181;
>  	struct iio_dev *indio_dev;
>  	int ret;
> +	const struct of_device_id *of_id;
> +	const struct acpi_device_id *acpi_id;
>  
>  	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*cm32181));
>  	if (!indio_dev) {
> @@ -322,6 +366,61 @@ static int cm32181_probe(struct i2c_client *client,
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
> +		of_id = of_match_device(client->dev.driver->of_match_table,
> +					&client->dev);
> +		if (!of_id)
> +			return -ENODEV;
> +
> +		cm32181->chip_id = (kernel_ulong_t)of_id->data;

of_device_get_match_data perhaps?

I thought something similar had been proposed for acpi as well to
avoid this boiler plate, but can't find it right now so maybe that
never went anywhere.


> +	} else {
> +		return -ENODEV;
> +	}
> +
> +	if (cm32181->chip_id == CM3218_ID) {
> +		if (ACPI_COMPANION(&client->dev) &&
> +		    client->addr == SMBUS_ARA_ADDR) {
> +			/*
> +			 * In case this device as been enumerated by acpi
> +			 * with the reserved smbus ARA address (first acpi
> +			 * connection), request change of address to the second
> +			 * connection.
> +			 */
> +			ret = i2c_acpi_set_connection(client, 1);
> +			if (ret)
> +				return ret;
> +		}
> +
> +		/* cm3218 chip require an ara device on his adapter */
> +		ret = i2c_require_smbus_alert(client);
> +		if (ret < 0)
> +			return ret;
> +
> +		/*
> +		 * If irq is given, request a threaded irq handler to manage
> +		 * smbus alert.
> +		 */
> +		if (client->irq > 0) {

If we have a chip that needs ara and no IRQ isn't it a probe failure case?
The device won't work as I understand it.

> +			ret = devm_request_threaded_irq(&client->dev,
> +							client->irq,
> +							NULL, cm32181_irq,
> +							IRQF_ONESHOT,
> +							"cm32181", cm32181);
> +			if (ret)
> +				return ret;
> +		}
> +	}
> +
>  	ret = cm32181_reg_init(cm32181);
>  	if (ret) {
>  		dev_err(&client->dev,
> @@ -342,25 +441,36 @@ static int cm32181_probe(struct i2c_client *client,
>  }
>  
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
> +	.alert		= cm3218_alert,

It's a bit ugly - I'm not sure we wouldn't be better registering
two separate i2c drivers so as not to specify the alert for devices
that don't handle it.

>  };
>  
>  module_i2c_driver(cm32181_driver);

