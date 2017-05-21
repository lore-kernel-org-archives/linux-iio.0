Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:37133 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753954AbdEUMQA (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 21 May 2017 08:16:00 -0400
Subject: Re: [PATCH v2 2/2] iio: accel: bma180: Add ACPI enumeration support
 for BMA250E
To: Hans de Goede <hdegoede@redhat.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
References: <20170516125159.25403-1-hdegoede@redhat.com>
 <20170516125159.25403-2-hdegoede@redhat.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <1d6cbd9d-7b9d-fb90-4970-72e8a36fb90f@kernel.org>
Date: Sun, 21 May 2017 13:15:58 +0100
MIME-Version: 1.0
In-Reply-To: <20170516125159.25403-2-hdegoede@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 16/05/17 13:51, Hans de Goede wrote:
> Some x86 tablets use the BMA250E accelerometer, add support for this.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Applied to the togreg branch of iio.git and pushed out as testing.

Jonathan
> ---
> Changes in v2:
> -Rebase on top of current master
> -Map ACPI "BMA250E" to BMA250E not BMA250, these are not the same
> ---
>   drivers/iio/accel/bma180.c | 21 +++++++++++++++++++--
>   1 file changed, 19 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/accel/bma180.c b/drivers/iio/accel/bma180.c
> index 3d6694821a96..17b7953f2502 100644
> --- a/drivers/iio/accel/bma180.c
> +++ b/drivers/iio/accel/bma180.c
> @@ -14,6 +14,7 @@
>    * BMA250: 7-bit I2C slave address 0x18 or 0x19
>    */
>   
> +#include <linux/acpi.h>
>   #include <linux/module.h>
>   #include <linux/i2c.h>
>   #include <linux/interrupt.h>
> @@ -727,6 +728,8 @@ static const struct iio_trigger_ops bma180_trigger_ops = {
>   static int bma180_probe(struct i2c_client *client,
>   		const struct i2c_device_id *id)
>   {
> +	struct device *dev = &client->dev;
> +	const struct acpi_device_id *acpi_id;
>   	struct bma180_data *data;
>   	struct iio_dev *indio_dev;
>   	enum chip_ids chip;
> @@ -739,10 +742,17 @@ static int bma180_probe(struct i2c_client *client,
>   	data = iio_priv(indio_dev);
>   	i2c_set_clientdata(client, indio_dev);
>   	data->client = client;
> -	if (client->dev.of_node)
> +	if (dev->of_node) {
>   		chip = (enum chip_ids)of_device_get_match_data(&client->dev);
> -	else
> +	} else if (id) {
>   		chip = id->driver_data;
> +	} else {
> +		acpi_id = acpi_match_device(dev->driver->acpi_match_table, dev);
> +		if (!acpi_id)
> +			return -ENODEV;
> +
> +		chip = acpi_id->driver_data;
> +	}
>   	data->part_info = &bma180_part_info[chip];
>   
>   	ret = data->part_info->chip_config(data);
> @@ -863,6 +873,12 @@ static SIMPLE_DEV_PM_OPS(bma180_pm_ops, bma180_suspend, bma180_resume);
>   #define BMA180_PM_OPS NULL
>   #endif
>   
> +static const struct acpi_device_id bma180_acpi_match[] = {
> +	{ "BMA250E", BMA250E },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(acpi, bma180_acpi_match);
> +
>   static struct i2c_device_id bma180_ids[] = {
>   	{ "bma180", BMA180 },
>   	{ "bma250", BMA250 },
> @@ -888,6 +904,7 @@ MODULE_DEVICE_TABLE(of, bma180_of_match);
>   static struct i2c_driver bma180_driver = {
>   	.driver = {
>   		.name	= "bma180",
> +		.acpi_match_table = ACPI_PTR(bma180_acpi_match),
>   		.pm	= BMA180_PM_OPS,
>   		.of_match_table = bma180_of_match,
>   	},
> 

