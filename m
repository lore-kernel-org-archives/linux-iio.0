Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:33917 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753951AbbBNMHo (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 14 Feb 2015 07:07:44 -0500
Message-ID: <54DF3A8D.3040900@kernel.org>
Date: Sat, 14 Feb 2015 12:07:41 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Kevin Tsai <ktsai@capellamicro.com>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>
CC: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V4 1/1] iio: Updated Capella cm3232 ambient light sensor
 driver.
References: <1423787719-2844-1-git-send-email-ktsai@capellamicro.com>
In-Reply-To: <1423787719-2844-1-git-send-email-ktsai@capellamicro.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 13/02/15 00:35, Kevin Tsai wrote:
> Added ACPI and Power Management support.
>

> Signed-off-by: Kevin Tsai <ktsai@capellamicro.com>
Hi Kevin,

Please treat this as a new series, adding functionality to the
driver that has already been merged.

As such we are back to v1.  Also make it clear what you are
adding in this patch in the title.

A few trivial bits to do with the patch formatting.

Actually I'd have preferred two patches for the core
changes here, one doing the power management and one
doing the ACPI support..

The ACPI stuff is slightly out of my comfort zone, so
I'd like input from others on that if possible.

Note such input will be easier once you've split this
up into a trivial clean up patch, a power management patch
and finally an ACPI magic patch.

Jonathan
> ---
> v4:
> Added ACPI and Power Management support.
> 
> Thanks Srinivas Pandruvada's ACPI routines.
> 
> v3:
> Added hw_id to als_info structure.
> Removed unused include files.
> Modified cm3232_write_als_it() to handle register update fail.
> 
> Thanks comments from Daniel Baluta.
> 
> v2:
> Removed unused CM3232_CMD_ALS_HS.
> Modified cm3232_als_info structure.  Removed id field.
> Modified cm3232_chip structure.
> Merged CM3232_als_it_bits and CM3232_als_it_values to cm3232_it_scale.
> Removed mutex lock.
> Renamed als_raw to regs_als.  Moved it to cm3232_chip structure.
> Modified cm3232_read_als_it() and cm3232_write_als_it() to support val2.
> 
> Thanks comments from Jeremiah Mahler, Peter Meerwald, Daniel Baluta,
> and Joe Perches.
> 
> v1:
> Added cm3232.c to support Capella Microsystems CM3232 Ambient Light
> Sensor.
> 
>  drivers/iio/light/cm3232.c | 117 +++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 114 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/light/cm3232.c b/drivers/iio/light/cm3232.c
> index 90e3519..7a8a624 100644
> --- a/drivers/iio/light/cm3232.c
> +++ b/drivers/iio/light/cm3232.c
> @@ -2,7 +2,6 @@
>   * CM3232 Ambient Light Sensor
>   *
>   * Copyright (C) 2014-2015 Capella Microsystems Inc.
> - * Author: Kevin Tsai <ktsai@capellamicro.com>
>   *
>   * This program is free software; you can redistribute it and/or modify it
>   * under the terms of the GNU General Public License version 2, as published
> @@ -16,6 +15,7 @@
>  #include <linux/iio/iio.h>
>  #include <linux/iio/sysfs.h>
>  #include <linux/init.h>
> +#include <linux/acpi.h>
>  
>  /* Registers Address */
>  #define CM3232_REG_ADDR_CMD		0x00
> @@ -77,6 +77,50 @@ struct cm3232_chip {
>  };
>  
>  /**
> + *  cm32181_acpi_get_cpm_info() - Get CPM object from ACPI
> + *  @client      pointer of struct i2c_client.
> + *  @obj_name    pointer of ACPI object name.
> + *  @count       maximum size of return array.
> + *  @vals	pointer of array for return elements.
> + *
> + *  Convert ACPI CPM table to array. Special thanks Srinivas Pandruvada's
> + *  help to implement this routine.
> + *
> + *  Return: -ENODEV for fail.  Otherwise is number of elements.
> + */
> +static int cm32181_acpi_get_cpm_info(struct i2c_client *client, char *obj_name,
> +							int count, u64 *vals)
> +{
> +	acpi_handle handle;
> +	struct acpi_buffer buffer = {ACPI_ALLOCATE_BUFFER, NULL};
> +	int i;
> +	acpi_status status;
> +	union acpi_object *cpm;
> +
> +	handle = ACPI_HANDLE(&client->dev);
> +	if (!handle)
> +		return -ENODEV;
> +
> +	status = acpi_evaluate_object(handle, obj_name, NULL, &buffer);
> +	if (ACPI_FAILURE(status)) {
> +		dev_err(&client->dev, "object %s not found\n", obj_name);
> +		return -ENODEV;
> +	}
> +
> +	cpm = buffer.pointer;
> +	for (i = 0; i < cpm->package.count && i < count; ++i) {
> +		union acpi_object *elem;
> +
> +		elem = &(cpm->package.elements[i]);
> +		vals[i] = elem->integer.value;
> +	}
> +
> +	kfree(buffer.pointer);
> +
> +	return cpm->package.count;
> +}
> +
> +/**
>   * cm3232_reg_init() - Initialize CM3232
>   * @chip:	pointer of struct cm3232_chip.
>   *
> @@ -88,9 +132,35 @@ static int cm3232_reg_init(struct cm3232_chip *chip)
>  {
>  	struct i2c_client *client = chip->client;
>  	s32 ret;
> +	int cpm_elem_count;
> +	u64 cpm_elems[20];
>  
>  	chip->als_info = &cm3232_als_info_default;
>  
> +	if (ACPI_HANDLE(&client->dev)) {
> +		/* Load from ACPI */
> +		cpm_elem_count = cm32181_acpi_get_cpm_info(client, "CPM0",
> +							ARRAY_SIZE(cpm_elems),
> +							cpm_elems);
> +		if (cpm_elem_count > 0) {
> +			int header_num = 3;
> +			int regs_bmp = cpm_elems[2];
> +
> +			chip->als_info->hw_id = (u8)cpm_elems[0];
> +			if (regs_bmp & BIT(0))
> +				chip->als_info->regs_cmd_default =
> +							 cpm_elems[header_num];
> +		}
> +
> +		cpm_elem_count = cm32181_acpi_get_cpm_info(client, "CPM1",
> +							ARRAY_SIZE(cpm_elems),
> +							cpm_elems);
> +		if (cpm_elem_count > 0) {
> +			chip->als_info->mlux_per_bit = (int)cpm_elems[0] / 100;
> +			chip->als_info->calibscale = (int)cpm_elems[1];
> +		}
> +	}
> +
>  	/* Identify device */
>  	ret = i2c_smbus_read_word_data(client, CM3232_REG_ADDR_ID);
>  	if (ret < 0) {
> @@ -211,6 +281,7 @@ static int cm3232_get_lux(struct cm3232_chip *chip)
>  	ret = cm3232_read_als_it(chip, &val, &val2);
>  	if (ret < 0)
>  		return -EINVAL;
> +
>  	als_it = val * 1000000 + val2;
>  	lux = (__force u64)als_info->mlux_per_bit;
>  	lux *= als_info->mlux_per_bit_base_it;
> @@ -366,13 +437,41 @@ static int cm3232_remove(struct i2c_client *client)
>  	struct iio_dev *indio_dev = i2c_get_clientdata(client);
>  
>  	i2c_smbus_write_byte_data(client, CM3232_REG_ADDR_CMD,
> -		CM3232_CMD_ALS_DISABLE);
> +				CM3232_CMD_ALS_DISABLE);
Please do this sort of little tidy up in a separate patch.
It's worth doing, but here it just adds noise to the stuff
we actually need to review!
>  
>  	iio_device_unregister(indio_dev);
>  
>  	return 0;
>  }
>  
> +static int cm3232_suspend(struct device *dev)
> +{
> +	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
> +	struct cm3232_chip *chip = iio_priv(indio_dev);
> +	struct i2c_client *client = chip->client;
> +	int ret;
> +
> +	chip->regs_cmd |= CM3232_CMD_ALS_DISABLE;
> +	ret = i2c_smbus_write_byte_data(client, CM3232_REG_ADDR_CMD,
> +					chip->regs_cmd);
> +
> +	return ret;
> +}
> +
> +static int cm3232_resume(struct device *dev)
> +{
> +	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
> +	struct cm3232_chip *chip = iio_priv(indio_dev);
> +	struct i2c_client *client = chip->client;
> +	int ret;
> +
> +	chip->regs_cmd &= ~CM3232_CMD_ALS_DISABLE;
> +	ret = i2c_smbus_write_byte_data(client, CM3232_REG_ADDR_CMD,
> +					chip->regs_cmd | CM3232_CMD_ALS_RESET);
> +
> +	return ret;
> +}
> +
>  static const struct i2c_device_id cm3232_id[] = {
>  	{"cm3232", 0},
>  	{}
> @@ -385,11 +484,23 @@ static const struct of_device_id cm3232_of_match[] = {
>  	{}
>  };
>  
> +static const struct acpi_device_id cm3232_acpi_match[] = {
> +	{ "CPLM3232", 0},
> +	{},
> +};
> +
> +MODULE_DEVICE_TABLE(acpi, cm3232_acpi_match);
> +
> +static const struct dev_pm_ops cm3232_pm_ops = {
> +	SET_SYSTEM_SLEEP_PM_OPS(cm3232_suspend, cm3232_resume)};
> +
>  static struct i2c_driver cm3232_driver = {
>  	.driver = {
>  		.name	= "cm3232",
> -		.owner	= THIS_MODULE,
> +		.acpi_match_table = ACPI_PTR(cm3232_acpi_match),
>  		.of_match_table = of_match_ptr(cm3232_of_match),
> +		.owner	= THIS_MODULE,
> +		.pm	= &cm3232_pm_ops,
>  	},
>  	.id_table	= cm3232_id,
>  	.probe		= cm3232_probe,
> 

