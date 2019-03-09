Return-Path: <SRS0=9Bew=RM=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A858C43381
	for <linux-iio@archiver.kernel.org>; Sat,  9 Mar 2019 17:43:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D5D420815
	for <linux-iio@archiver.kernel.org>; Sat,  9 Mar 2019 17:43:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552153413;
	bh=/j4QnvEQbKDQNDKKdah/srVmewv0SZ4BaXLOB28PtZ8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=bzqN/KZgI1NYLH2AhKhsUxJ1IQ9mlqdEwlCzOGlDiWUesrdBGPkVAv98JGN30v/eK
	 cLMNFAe8nVKkdGIDnj6vrw87++9hZIDY6vkpmljtLAfLAIKb0CBQrEW1sJ/sT4qo3f
	 c5mp8HwIJjIPy3ypqHWOusthfg4Fp+4ux3B+4c+k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726360AbfCIRnc (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 9 Mar 2019 12:43:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:57158 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726298AbfCIRnc (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 9 Mar 2019 12:43:32 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CE52D207E0;
        Sat,  9 Mar 2019 17:43:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552153410;
        bh=/j4QnvEQbKDQNDKKdah/srVmewv0SZ4BaXLOB28PtZ8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Cwg21uP04YGsWRNgS+o+PEa4RpkeaIjjsA9Ett+0wiqZ9KSXO167n1yNk15eVIyeJ
         URVpXoiCuJMgn8WnxdatjHLnjCF8CcIy3gkp0xjbbT/mc41wCXbYNCgkMopRuawec9
         qEdD8TmkD6Jb4ZwUeGJP7f8PiVTdPIDF6LhN8RmU=
Date:   Sat, 9 Mar 2019 17:43:25 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     Gwendal Grignou <gwendal@chromium.org>, lee.jones@linaro.org,
        groeck@chromium.org, bleung@chromium.org, lars@metafoo.de,
        egranata@chromium.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH v3] iio: cros_ec: Add lid angle driver
Message-ID: <20190309174325.07b9f527@archlinux>
In-Reply-To: <3da262ee-0b0b-e87d-ca60-c877318681ec@collabora.com>
References: <CAPUE2uutkNsiVtsVfF81WcJyvSvOFWNMYbA86dSd589JnON+JA@mail.gmail.com>
        <20190307003545.29260-1-gwendal@chromium.org>
        <3da262ee-0b0b-e87d-ca60-c877318681ec@collabora.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 7 Mar 2019 13:32:44 +0100
Enric Balletbo i Serra <enric.balletbo@collabora.com> wrote:

> Hi,
> 
> On 7/3/19 1:35, Gwendal Grignou wrote:
> > Add a IIO driver that reports the angle between the lid and the base for
> > ChromeOS convertible device.
> > 
> > Tested on eve with ToT EC firmware.
> > Check driver is loaded and lid angle is correct.
> > 
> > Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
> > ---
> > Changes in v3:
> > - Use static channel array, simplify code because index is always 0.
> > 
> > Changes in v2:
> > - Fix license, remove driver_module field.
> > 
> >  drivers/iio/common/cros_ec_sensors/Kconfig    |   9 ++
> >  drivers/iio/common/cros_ec_sensors/Makefile   |   1 +
> >  .../cros_ec_sensors/cros_ec_lid_angle.c       | 138 ++++++++++++++++++
> >  drivers/mfd/cros_ec_dev.c                     |  15 +-  
> 
> Note that this patch depends on https://lkml.org/lkml/2019/2/27/723 to build.
Thanks for the heads up!

Gwendal, chances are I'll forget about this patch, so I'd appreciate
a poke once that precursor is upstream or ideally when it turns up
in staging/staging-next so I can rebase to get it into the iio togreg
branch.

Otherwise, looks good to me.

Thanks,

Jonathan
> 
> Acked-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> 
> Thanks,
>  Enric
> 
> >  4 files changed, 160 insertions(+), 3 deletions(-)
> >  create mode 100644 drivers/iio/common/cros_ec_sensors/cros_ec_lid_angle.c
> > 
> > diff --git a/drivers/iio/common/cros_ec_sensors/Kconfig b/drivers/iio/common/cros_ec_sensors/Kconfig
> > index 135f6825903f..aacc2ab9c34f 100644
> > --- a/drivers/iio/common/cros_ec_sensors/Kconfig
> > +++ b/drivers/iio/common/cros_ec_sensors/Kconfig
> > @@ -20,3 +20,12 @@ config IIO_CROS_EC_SENSORS
> >  	  Accelerometers, Gyroscope and Magnetometer that are
> >  	  presented by the ChromeOS EC Sensor hub.
> >  	  Creates an IIO device for each functions.
> > +
> > +config IIO_CROS_EC_SENSORS_LID_ANGLE
> > +	tristate "ChromeOS EC Sensor for lid angle"
> > +	depends on IIO_CROS_EC_SENSORS_CORE
> > +	help
> > +	  Module to report the angle between lid and base for some
> > +	  convertible devices.
> > +	  This module is loaded when the EC can calculate the angle between the base
> > +	  and the lid.
> > diff --git a/drivers/iio/common/cros_ec_sensors/Makefile b/drivers/iio/common/cros_ec_sensors/Makefile
> > index ec716ff2a775..a35ee232ac07 100644
> > --- a/drivers/iio/common/cros_ec_sensors/Makefile
> > +++ b/drivers/iio/common/cros_ec_sensors/Makefile
> > @@ -4,3 +4,4 @@
> >  
> >  obj-$(CONFIG_IIO_CROS_EC_SENSORS_CORE) += cros_ec_sensors_core.o
> >  obj-$(CONFIG_IIO_CROS_EC_SENSORS) += cros_ec_sensors.o
> > +obj-$(CONFIG_IIO_CROS_EC_SENSORS_LID_ANGLE) += cros_ec_lid_angle.o
> > diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_lid_angle.c b/drivers/iio/common/cros_ec_sensors/cros_ec_lid_angle.c
> > new file mode 100644
> > index 000000000000..92be07d7fa36
> > --- /dev/null
> > +++ b/drivers/iio/common/cros_ec_sensors/cros_ec_lid_angle.c
> > @@ -0,0 +1,138 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +/*
> > + * cros_ec_lid_angle - Driver for CrOS EC lid angle sensor.
> > + *
> > + * Copyright 2018 Google, Inc
> > + *
> > + * This driver uses the cros-ec interface to communicate with the Chrome OS
> > + * EC about counter sensors. Counters are presented through
> > + * iio sysfs.
> > + */
> > +
> > +#include <linux/delay.h>
> > +#include <linux/device.h>
> > +#include <linux/iio/buffer.h>
> > +#include <linux/iio/common/cros_ec_sensors_core.h>
> > +#include <linux/iio/iio.h>
> > +#include <linux/iio/kfifo_buf.h>
> > +#include <linux/iio/trigger.h>
> > +#include <linux/iio/triggered_buffer.h>
> > +#include <linux/iio/trigger_consumer.h>
> > +#include <linux/kernel.h>
> > +#include <linux/mfd/cros_ec.h>
> > +#include <linux/mfd/cros_ec_commands.h>
> > +#include <linux/module.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/slab.h>
> > +
> > +#define DRV_NAME "cros-ec-lid-angle"
> > +
> > +/*
> > + * One channel for the lid angle, the other for timestamp.
> > + */
> > +static const struct iio_chan_spec cros_ec_lid_angle_channels[] = {
> > +	{
> > +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> > +		.scan_type.realbits = CROS_EC_SENSOR_BITS,
> > +		.scan_type.storagebits = CROS_EC_SENSOR_BITS,
> > +		.scan_type.sign = 'u',
> > +		.type = IIO_ANGL
> > +	},
> > +	IIO_CHAN_SOFT_TIMESTAMP(1)
> > +};
> > +
> > +/* State data for ec_sensors iio driver. */
> > +struct cros_ec_lid_angle_state {
> > +	/* Shared by all sensors */
> > +	struct cros_ec_sensors_core_state core;
> > +};
> > +
> > +static int cros_ec_sensors_read_lid_angle(struct iio_dev *indio_dev,
> > +					  unsigned long scan_mask, s16 *data)
> > +{
> > +	struct cros_ec_sensors_core_state *st = iio_priv(indio_dev);
> > +	int ret;
> > +
> > +	st->param.cmd = MOTIONSENSE_CMD_LID_ANGLE;
> > +	ret = cros_ec_motion_send_host_cmd(st, sizeof(st->resp->lid_angle));
> > +	if (ret) {
> > +		dev_warn(&indio_dev->dev, "Unable to read lid angle\n");
> > +		return ret;
> > +	}
> > +
> > +	*data = st->resp->lid_angle.value;
> > +	return 0;
> > +}
> > +
> > +static int cros_ec_lid_angle_read(struct iio_dev *indio_dev,
> > +				    struct iio_chan_spec const *chan,
> > +				    int *val, int *val2, long mask)
> > +{
> > +	struct cros_ec_lid_angle_state *st = iio_priv(indio_dev);
> > +	s16 data;
> > +	int ret;
> > +
> > +	mutex_lock(&st->core.cmd_lock);
> > +	ret = cros_ec_sensors_read_lid_angle(indio_dev, 1, &data);
> > +	if (ret)
> > +		return ret;
> > +	*val = data;
> > +	mutex_unlock(&st->core.cmd_lock);
> > +	return IIO_VAL_INT;
> > +}
> > +
> > +static const struct iio_info cros_ec_lid_angle_info = {
> > +	.read_raw = &cros_ec_lid_angle_read,
> > +};
> > +
> > +static int cros_ec_lid_angle_probe(struct platform_device *pdev)
> > +{
> > +	struct device *dev = &pdev->dev;
> > +	struct iio_dev *indio_dev;
> > +	struct cros_ec_lid_angle_state *state;
> > +	int ret;
> > +
> > +	indio_dev = devm_iio_device_alloc(dev, sizeof(*state));
> > +	if (!indio_dev)
> > +		return -ENOMEM;
> > +
> > +	ret = cros_ec_sensors_core_init(pdev, indio_dev, false);
> > +	if (ret)
> > +		return ret;
> > +
> > +	indio_dev->info = &cros_ec_lid_angle_info;
> > +	state = iio_priv(indio_dev);
> > +	indio_dev->channels = cros_ec_lid_angle_channels;
> > +	indio_dev->num_channels = ARRAY_SIZE(cros_ec_lid_angle_channels);
> > +
> > +	state->core.read_ec_sensors_data = cros_ec_sensors_read_lid_angle;
> > +
> > +	ret = devm_iio_triggered_buffer_setup(dev, indio_dev, NULL,
> > +			cros_ec_sensors_capture, NULL);
> > +	if (ret)
> > +		return ret;
> > +
> > +	return devm_iio_device_register(dev, indio_dev);
> > +}
> > +
> > +static const struct platform_device_id cros_ec_lid_angle_ids[] = {
> > +	{
> > +		.name = DRV_NAME,
> > +	},
> > +	{ /* sentinel */ }
> > +};
> > +MODULE_DEVICE_TABLE(platform, cros_ec_lid_angle_ids);
> > +
> > +static struct platform_driver cros_ec_lid_angle_platform_driver = {
> > +	.driver = {
> > +		.name	= DRV_NAME,
> > +		.pm	= &cros_ec_sensors_pm_ops,
> > +	},
> > +	.probe		= cros_ec_lid_angle_probe,
> > +	.id_table	= cros_ec_lid_angle_ids,
> > +};
> > +module_platform_driver(cros_ec_lid_angle_platform_driver);
> > +
> > +MODULE_DESCRIPTION("ChromeOS EC driver for reporting convertible lid angle.");
> > +MODULE_LICENSE("GPL v2");
> > diff --git a/drivers/mfd/cros_ec_dev.c b/drivers/mfd/cros_ec_dev.c
> > index d275deaecb12..11b5b2fd1f33 100644
> > --- a/drivers/mfd/cros_ec_dev.c
> > +++ b/drivers/mfd/cros_ec_dev.c
> > @@ -297,13 +297,17 @@ static void cros_ec_sensors_register(struct cros_ec_dev *ec)
> >  
> >  	resp = (struct ec_response_motion_sense *)msg->data;
> >  	sensor_num = resp->dump.sensor_count;
> > -	/* Allocate 1 extra sensors in FIFO are needed */
> > -	sensor_cells = kcalloc(sensor_num + 1, sizeof(struct mfd_cell),
> > +	/*
> > +	 * Allocate extra sensors if lid angle sensor or FIFO are needed.
> > +	 */
> > +#define NUM_EXTRA_SENSORS 2
> > +	sensor_cells = kcalloc(sensor_num + NUM_EXTRA_SENSORS,
> > +			       sizeof(struct mfd_cell),
> >  			       GFP_KERNEL);
> >  	if (sensor_cells == NULL)
> >  		goto error;
> >  
> > -	sensor_platforms = kcalloc(sensor_num + 1,
> > +	sensor_platforms = kcalloc(sensor_num,
> >  				   sizeof(struct cros_ec_sensor_platform),
> >  				   GFP_KERNEL);
> >  	if (sensor_platforms == NULL)
> > @@ -363,6 +367,11 @@ static void cros_ec_sensors_register(struct cros_ec_dev *ec)
> >  		sensor_cells[id].name = "cros-ec-ring";
> >  		id++;
> >  	}
> > +	if (cros_ec_check_features(ec,
> > +				EC_FEATURE_REFINED_TABLET_MODE_HYSTERESIS)) {
> > +		sensor_cells[id].name = "cros-ec-lid-angle";
> > +		id++;
> > +	}
> >  
> >  	ret = mfd_add_devices(ec->dev, 0, sensor_cells, id,
> >  			      NULL, 0, NULL);
> >   

