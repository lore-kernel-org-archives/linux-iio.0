Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from cloudserver094114.home.pl ([79.96.170.134]:58438 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751964AbdL1BUz (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 27 Dec 2017 20:20:55 -0500
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Marc CAPDEVILLE <m.capdeville@no-log.org>
Cc: Kevin Tsai <ktsai@capellamicro.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Wolfram Sang <wsa@the-dreams.de>, linux-iio@vger.kernel.org,
        linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 3/4] iio : Add cm3218 smbus ara and acpi support
Date: Thu, 28 Dec 2017 02:19:55 +0100
Message-ID: <3555182.adivIrLfU0@aspire.rjw.lan>
In-Reply-To: <20171225155723.6338-3-m.capdeville@no-log.org>
References: <20171225155723.6338-1-m.capdeville@no-log.org> <20171225155723.6338-3-m.capdeville@no-log.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Monday, December 25, 2017 4:57:22 PM CET Marc CAPDEVILLE wrote:
> On asus T100, Capella cm3218 chip is implemented as ambiant light
> sensor. This chip expose an smbus ARA protocol device on standard
> address 0x0c. The chip is not functional before all alerts are
> acknowledged.
> On asus T100, this device is enumerated on ACPI bus and the description
> give two I2C connection. The first is the connection to the ARA device
> and the second gives the real address of the device.
> 
> So, on device probe,If the i2c address is the ARA address and the
> device is enumerated via acpi, we change address of the device for
> the one in the second acpi serial bus connection.
> This free the ara address so we can register with the smbus_alert
> driver.
> 
> If an interrupt resource is given, and a smbus_alert device was
> found on the adapter, we request a treaded interrupt to
> call i2c_smbus_alert_event to handle the alert.
> 
> In somme case, the treaded interrupt is not schedule before the driver
> try to initialize chip registers. So if first registers access fail, we
> call i2c_smbus_alert_event() to acknowledge initial alert, then retry
> register access.
> 
> Signed-off-by: Marc CAPDEVILLE <m.capdeville@no-log.org>
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
> +		/* This is cm3218 chip irq, so handle the smbus alert */
> +		i2c_smbus_alert_event(cm32181->client);
> +	}
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

This looks super-fragile to me.

What about making the enumeration aware of the SMBUS_ARA thing and avoid
using resources corresponding to that at all?

BTW, in comments and similar always spell ACPI in capitals.

Thanks,
Rafael

