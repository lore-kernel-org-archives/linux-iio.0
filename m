Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:58505 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1956147AbdDZGkl (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 26 Apr 2017 02:40:41 -0400
Subject: Re: [PATCH] iio: accel: bma180: Add ACPI enumeration support
To: Hans de Goede <hdegoede@redhat.com>
Cc: linux-acpi@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
References: <20170421073812.12531-1-hdegoede@redhat.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <08327ffe-119a-b62b-a6f9-0f485444bd9a@kernel.org>
Date: Wed, 26 Apr 2017 07:40:33 +0100
MIME-Version: 1.0
In-Reply-To: <20170421073812.12531-1-hdegoede@redhat.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 21/04/17 08:38, Hans de Goede wrote:
> Some x86 tablets use the bms250 accelerometer, add support for this.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Hi Hans,

Would you mind rebasing this on the latest iio.git togreg branch?
(which should be the same as linux-next by now if that is easier)
Some OF bindings got added in the recent cycle that make it not
apply cleanly.

Thanks,

Jonathan
> ---
>  drivers/iio/accel/bma180.c | 20 +++++++++++++++++++-
>  1 file changed, 19 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/accel/bma180.c b/drivers/iio/accel/bma180.c
> index 0890934..5c75190 100644
> --- a/drivers/iio/accel/bma180.c
> +++ b/drivers/iio/accel/bma180.c
> @@ -14,6 +14,7 @@
>   * BMA250: 7-bit I2C slave address 0x18 or 0x19
>   */
>  
> +#include <linux/acpi.h>
>  #include <linux/module.h>
>  #include <linux/i2c.h>
>  #include <linux/interrupt.h>
> @@ -705,6 +706,8 @@ static const struct iio_trigger_ops bma180_trigger_ops = {
>  static int bma180_probe(struct i2c_client *client,
>  		const struct i2c_device_id *id)
>  {
> +	struct device *dev = &client->dev;
> +	const struct acpi_device_id *acpi_id;
>  	struct bma180_data *data;
>  	struct iio_dev *indio_dev;
>  	int ret;
> @@ -716,7 +719,15 @@ static int bma180_probe(struct i2c_client *client,
>  	data = iio_priv(indio_dev);
>  	i2c_set_clientdata(client, indio_dev);
>  	data->client = client;
> -	data->part_info = &bma180_part_info[id->driver_data];
> +	if (id) {
> +		data->part_info = &bma180_part_info[id->driver_data];
> +	} else {
> +		acpi_id = acpi_match_device(dev->driver->acpi_match_table, dev);
> +		if (!acpi_id)
> +			return -ENODEV;
> +
> +		data->part_info = &bma180_part_info[acpi_id->driver_data];
> +	}
>  
>  	ret = data->part_info->chip_config(data);
>  	if (ret < 0)
> @@ -836,6 +847,12 @@ static SIMPLE_DEV_PM_OPS(bma180_pm_ops, bma180_suspend, bma180_resume);
>  #define BMA180_PM_OPS NULL
>  #endif
>  
> +static const struct acpi_device_id bma180_acpi_match[] = {
> +	{ "BMA250E", BMA250 },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(acpi, bma180_acpi_match);
> +
>  static struct i2c_device_id bma180_ids[] = {
>  	{ "bma180", BMA180 },
>  	{ "bma250", BMA250 },
> @@ -847,6 +864,7 @@ MODULE_DEVICE_TABLE(i2c, bma180_ids);
>  static struct i2c_driver bma180_driver = {
>  	.driver = {
>  		.name	= "bma180",
> +		.acpi_match_table = ACPI_PTR(bma180_acpi_match),
>  		.pm	= BMA180_PM_OPS,
>  	},
>  	.probe		= bma180_probe,
> 

