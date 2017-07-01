Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:42014 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751754AbdGAKRA (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 1 Jul 2017 06:17:00 -0400
Date: Sat, 1 Jul 2017 11:16:56 +0100
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: hdegoede@redhat.com, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
Subject: Re: [bug report] iio: accel: bma180: Add ACPI enumeration support
 for BMA250E
Message-ID: <20170701111656.621f1567@jic23.retrosnub.co.uk>
In-Reply-To: <20170628113027.g6g7prztloozs7uo@mwanda>
References: <20170628113027.g6g7prztloozs7uo@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, 28 Jun 2017 14:30:27 +0300
Dan Carpenter <dan.carpenter@oracle.com> wrote:

> Hello Hans de Goede,
> 
> This is a semi-automatic email about new static checker warnings.
> 
> The patch 5333e88661f2: "iio: accel: bma180: Add ACPI enumeration 
> support for BMA250E" from May 16, 2017, leads to the following Smatch 
> complaint:
> 
> drivers/iio/accel/bma180.c:766 bma180_probe()
> 	 error: we previously assumed 'id' could be null (see line 747)
> 
> drivers/iio/accel/bma180.c
>    746			chip = (enum chip_ids)of_device_get_match_data(&client->dev);
>    747		} else if (id) {
>                            ^^
> New check for NULL.
> 
>    748			chip = id->driver_data;
>    749		} else {
>    750			acpi_id = acpi_match_device(dev->driver->acpi_match_table, dev);
>    751			if (!acpi_id)
>    752				return -ENODEV;
>    753	
>    754			chip = acpi_id->driver_data;
>    755		}
>    756		data->part_info = &bma180_part_info[chip];
>    757	
>    758		ret = data->part_info->chip_config(data);
>    759		if (ret < 0)
>    760			goto err_chip_disable;
>    761	
>    762		mutex_init(&data->mutex);
>    763		indio_dev->dev.parent = &client->dev;
>    764		indio_dev->channels = data->part_info->channels;
>    765		indio_dev->num_channels = data->part_info->num_channels;
>    766		indio_dev->name = id->name;
>                                   ^^^^^^^^
> Old code assumes "id" is always non-NULL.
> 
>    767		indio_dev->modes = INDIO_DIRECT_MODE;
>    768		indio_dev->info = &bma180_info;
> 
> regards,
> dan carpenter

Hi Dan,

Patch in question has been reverted.   We all failed to notice the
BMA250E is already supported by the bmc150 driver.

Jonathan
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

