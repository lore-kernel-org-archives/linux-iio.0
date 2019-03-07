Return-Path: <SRS0=p+Fr=RK=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32712C43381
	for <linux-iio@archiver.kernel.org>; Thu,  7 Mar 2019 00:34:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0DFC206DD
	for <linux-iio@archiver.kernel.org>; Thu,  7 Mar 2019 00:34:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="IoqBFFye"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726104AbfCGAeF (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Wed, 6 Mar 2019 19:34:05 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:39018 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726094AbfCGAeF (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 6 Mar 2019 19:34:05 -0500
Received: by mail-io1-f68.google.com with SMTP id x3so11917933ior.6
        for <linux-iio@vger.kernel.org>; Wed, 06 Mar 2019 16:34:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=x8hz7inWJBsAtB7QANcLFg5K+C2ODB+sPyQhVwqiNRY=;
        b=IoqBFFyex3Aa8ro5voS0+QaHnEur9cLZmZ/y6OqPlFNXA/sSyoIxDHcZqwJMKUid+A
         2sf+5ybQeJdJ4RNdykysAFBTI0o2x0hJ7NgHVtLJfDTvCGzTAAEUzaGpNad2W6sRUZtU
         sY/oNCBg5deLQ/X2w57pXFwn4q/Z3tI/cjEp4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x8hz7inWJBsAtB7QANcLFg5K+C2ODB+sPyQhVwqiNRY=;
        b=XNyfooHGtaUddeo6bkt1lX4GFByqnifExjDtEADk6fHkGl0U6O5ULdxebErgHtos0B
         dgQoN2r7saREP5dyuKDa5A89hmCpUGnc8sR8W/HqFHtKVc0F273GX8ldo5uqaKNsUblJ
         76O0/6PONUPqSPYLVsiJwxd3malX3hAZnThzdAkStstaRneYxGmlLmr9wgO8O7e8Ucd4
         sVzqv1awmS0wYXEFHHZKJCiIdGjLs2OdA4ygf47GcjwR6/Ixdomh4CzaMhh1YwYTe5tG
         aT32oL+dZuzCDo4KIEYLDfx7AZeltbxaIveYofaXBf3cspYfpcFvJh/xnS3wmbWafRuk
         lkZA==
X-Gm-Message-State: APjAAAXv7a3OYtN9Hcv8Gcl5pXezrW3KVX7DXLh1Jca7jZ844+/CQniC
        RDPs4CU4oajIpxju5I9YM+Wrwpiyw2cpS7JggBRY/A==
X-Google-Smtp-Source: APXvYqy+hdPEmrybVNp0hqpPnJA7mkXMJOuxgghQH0pkrY+qvSsKdN/d3xKpJzkgoYDixP8G2OaGyJfNuVSN6QGfNQo=
X-Received: by 2002:a5e:8416:: with SMTP id h22mr5003710ioj.118.1551918843949;
 Wed, 06 Mar 2019 16:34:03 -0800 (PST)
MIME-Version: 1.0
References: <CAPUE2uvHzJR-82yBdY3oxYV_-t=3Lr6n2svaf+FeN7LCzw6saA@mail.gmail.com>
 <20190228174154.223930-1-gwendal@chromium.org> <20190303124300.3d6f5149@archlinux>
In-Reply-To: <20190303124300.3d6f5149@archlinux>
From:   Gwendal Grignou <gwendal@chromium.org>
Date:   Wed, 6 Mar 2019 16:33:53 -0800
Message-ID: <CAPUE2uutkNsiVtsVfF81WcJyvSvOFWNMYbA86dSd589JnON+JA@mail.gmail.com>
Subject: Re: [PATCH v2] iio: cros_ec: Add lid angle driver
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Guenter Roeck <groeck@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Benson Leung <bleung@chromium.org>, lars@metafoo.de,
        Enrico Granata <egranata@chromium.org>,
        linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Mar 3, 2019 at 4:43 AM Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Thu, 28 Feb 2019 09:41:54 -0800
> Gwendal Grignou <gwendal@chromium.org> wrote:
>
> > Add a IIO driver that reports the angle between the lid and the base for
> > ChromeOS convertible device.
> >
> > Tested on eve with ToT EC firmware.
> > Check driver is loaded and lid angle is correct.
> >
> > Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
>
> Hi Gwendal,
>
> Just a few minor comments inline.  It seems a bit like this has been
> copied from a driver needing a lot more flexibility and as a result
> various items that can be hard coded, simplifying this, are left
> flexible.
>
> Also one question about the cros_ec part.
>
> Jonathan
Thanks for the review, v3 coming soon.

Gwendal.
>
> > ---
> > Changes in v2:
> > - Fix license, remove driver_module field.
> >
> >  drivers/iio/common/cros_ec_sensors/Kconfig    |   9 +
> >  drivers/iio/common/cros_ec_sensors/Makefile   |   1 +
> >  .../cros_ec_sensors/cros_ec_lid_angle.c       | 163 ++++++++++++++++++
> >  drivers/mfd/cros_ec_dev.c                     |  15 +-
> >  4 files changed, 185 insertions(+), 3 deletions(-)
> >  create mode 100644 drivers/iio/common/cros_ec_sensors/cros_ec_lid_angle.c
> >
> > diff --git a/drivers/iio/common/cros_ec_sensors/Kconfig b/drivers/iio/common/cros_ec_sensors/Kconfig
> > index 135f6825903f..aacc2ab9c34f 100644
> > --- a/drivers/iio/common/cros_ec_sensors/Kconfig
> > +++ b/drivers/iio/common/cros_ec_sensors/Kconfig
> > @@ -20,3 +20,12 @@ config IIO_CROS_EC_SENSORS
> >         Accelerometers, Gyroscope and Magnetometer that are
> >         presented by the ChromeOS EC Sensor hub.
> >         Creates an IIO device for each functions.
> > +
> > +config IIO_CROS_EC_SENSORS_LID_ANGLE
> > +     tristate "ChromeOS EC Sensor for lid angle"
> > +     depends on IIO_CROS_EC_SENSORS_CORE
> > +     help
> > +       Module to report the angle between lid and base for some
> > +       convertible devices.
> > +       This module is loaded when the EC can calculate the angle between the base
> > +       and the lid.
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
> > index 000000000000..09d30976a743
> > --- /dev/null
> > +++ b/drivers/iio/common/cros_ec_sensors/cros_ec_lid_angle.c
> > @@ -0,0 +1,163 @@
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
> > +#define MAX_CHANNELS (1 + 1)
> > +
> > +/* State data for ec_sensors iio driver. */
> > +struct cros_ec_lid_angle_state {
> > +     /* Shared by all sensors */
> > +     struct cros_ec_sensors_core_state core;
> > +
> > +     struct iio_chan_spec channels[MAX_CHANNELS];
> > +};
> > +
> > +static int cros_ec_sensors_read_lid_angle(struct iio_dev *indio_dev,
> > +                                       unsigned long scan_mask, s16 *data)
> > +{
> > +     struct cros_ec_sensors_core_state *st = iio_priv(indio_dev);
> > +     int ret;
> > +
> > +     st->param.cmd = MOTIONSENSE_CMD_LID_ANGLE;
> > +     ret = cros_ec_motion_send_host_cmd(st, sizeof(st->resp->lid_angle));
> > +     if (ret) {
> > +             dev_warn(&indio_dev->dev, "Unable to read lid angle\n");
> > +             return ret;
> > +     }
> > +
> > +     if (scan_mask & 1)
>
> As below, this seems like flexibility with no benefit. I think it
> is always true.
Done.
>
> > +             *data = st->resp->lid_angle.value;
> > +     return 0;
> > +}
> > +
> > +static int cros_ec_lid_angle_read(struct iio_dev *indio_dev,
> > +                                 struct iio_chan_spec const *chan,
> > +                                 int *val, int *val2, long mask)
> > +{
> > +     struct cros_ec_lid_angle_state *st = iio_priv(indio_dev);
> > +     u16 data;
> > +     int ret;
> > +     int idx = chan->scan_index;
> > +
> > +     mutex_lock(&st->core.cmd_lock);
> > +     switch (mask) {
> > +     case IIO_CHAN_INFO_RAW:
> > +             ret = cros_ec_sensors_read_lid_angle(
> > +                             indio_dev, 1 << idx, &data);
>
> This seems to suffer a bit from unwarranted flexibility.
> idx is always 0 in this driver - hence there is an obvious
> simplification!
Done: I kept cros_ec_sensors_read_lid_angle as it is use when
populating /dev/iio:deviceX.
>
> > +             if (ret)
> > +                     break;
> > +             ret = IIO_VAL_INT;
> > +             *val = data;
> > +             break;
> > +     default:
> > +             ret = -EINVAL;
> > +     }
> > +     mutex_unlock(&st->core.cmd_lock);
> > +     return ret;
> > +}
> > +
> > +static const struct iio_info cros_ec_lid_angle_info = {
> > +     .read_raw = &cros_ec_lid_angle_read,
> > +};
> > +
> > +static int cros_ec_lid_angle_probe(struct platform_device *pdev)
> > +{
> > +     struct device *dev = &pdev->dev;
> > +     struct iio_dev *indio_dev;
> > +     struct cros_ec_lid_angle_state *state;
> > +     struct iio_chan_spec *channel;
> > +     int ret;
> > +
> > +     indio_dev = devm_iio_device_alloc(dev, sizeof(*state));
> > +     if (!indio_dev)
> > +             return -ENOMEM;
> > +
> > +     ret = cros_ec_sensors_core_init(pdev, indio_dev, false);
> > +     if (ret)
> > +             return ret;
> > +
> > +     indio_dev->info = &cros_ec_lid_angle_info;
> > +     state = iio_priv(indio_dev);
> > +     channel = state->channels;
> > +
> > +     channel->info_mask_separate = BIT(IIO_CHAN_INFO_RAW);
> > +     channel->scan_type.realbits = CROS_EC_SENSOR_BITS;
> > +     channel->scan_type.storagebits = CROS_EC_SENSOR_BITS;
> > +     channel->scan_type.shift = 0;
>
> Shift has an 'obvious' default of 0 so I wouldn't bother
> explicitly setting it.
Done.
>
> > +     channel->scan_index = 0;
> > +     channel->scan_type.sign = 'u';
> > +     channel->type = IIO_ANGL;
> > +
> > +     state->core.calib[0] = 0;
> > +
> > +     /* Timestamp */
> > +     channel++;
> > +     channel->type = IIO_TIMESTAMP;
> > +     channel->channel = -1;
> > +     channel->scan_index = 1;
> > +     channel->scan_type.sign = 's';
> > +     channel->scan_type.realbits = 64;
> > +     channel->scan_type.storagebits = 64;
> > +
>
> These appear to be constant.  Why not just use a static
> const array for them rather than within the state structure?
Done.
>
> > +     indio_dev->channels = state->channels;
> > +     indio_dev->num_channels = MAX_CHANNELS;
> > +
> > +     state->core.read_ec_sensors_data = cros_ec_sensors_read_lid_angle;
> > +
> > +     ret = devm_iio_triggered_buffer_setup(dev, indio_dev, NULL,
> > +                     cros_ec_sensors_capture, NULL);
> > +     if (ret)
> > +             return ret;
> > +
> > +     return devm_iio_device_register(dev, indio_dev);
> > +}
> > +
> > +static const struct platform_device_id cros_ec_lid_angle_ids[] = {
> > +     {
> > +             .name = DRV_NAME,
> > +     },
> > +     { /* sentinel */ }
> > +};
> > +MODULE_DEVICE_TABLE(platform, cros_ec_lid_angle_ids);
> > +
> > +static struct platform_driver cros_ec_lid_angle_platform_driver = {
> > +     .driver = {
> > +             .name   = DRV_NAME,
> > +             .pm     = &cros_ec_sensors_pm_ops,
> > +     },
> > +     .probe          = cros_ec_lid_angle_probe,
> > +     .id_table       = cros_ec_lid_angle_ids,
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
> >       resp = (struct ec_response_motion_sense *)msg->data;
> >       sensor_num = resp->dump.sensor_count;
> > -     /* Allocate 1 extra sensors in FIFO are needed */
> > -     sensor_cells = kcalloc(sensor_num + 1, sizeof(struct mfd_cell),
> > +     /*
> > +      * Allocate extra sensors if lid angle sensor or FIFO are needed.
> > +      */
> > +#define NUM_EXTRA_SENSORS 2
> > +     sensor_cells = kcalloc(sensor_num + NUM_EXTRA_SENSORS,
> > +                            sizeof(struct mfd_cell),
> >                              GFP_KERNEL);
> >       if (sensor_cells == NULL)
> >               goto error;
> >
> > -     sensor_platforms = kcalloc(sensor_num + 1,
> > +     sensor_platforms = kcalloc(sensor_num,
>
> This change has me curious.  Why was the +1 ever needed?
No, it was a mistake.
> As far as I can see we only ever use <= sensor_num entries in this array.
>
> >                                  sizeof(struct cros_ec_sensor_platform),
> >                                  GFP_KERNEL);
> >       if (sensor_platforms == NULL)
> > @@ -363,6 +367,11 @@ static void cros_ec_sensors_register(struct cros_ec_dev *ec)
> >               sensor_cells[id].name = "cros-ec-ring";
> >               id++;
> >       }
> > +     if (cros_ec_check_features(ec,
> > +                             EC_FEATURE_REFINED_TABLET_MODE_HYSTERESIS)) {
> > +             sensor_cells[id].name = "cros-ec-lid-angle";
> > +             id++;
> > +     }
> >
> >       ret = mfd_add_devices(ec->dev, 0, sensor_cells, id,
> >                             NULL, 0, NULL);
>
