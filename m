Return-Path: <SRS0=4tHG=RD=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D9F8C43381
	for <linux-iio@archiver.kernel.org>; Thu, 28 Feb 2019 17:41:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A20B218CD
	for <linux-iio@archiver.kernel.org>; Thu, 28 Feb 2019 17:41:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="byHTQDY+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387507AbfB1Rln (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Thu, 28 Feb 2019 12:41:43 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:37556 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732473AbfB1Rln (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 28 Feb 2019 12:41:43 -0500
Received: by mail-io1-f66.google.com with SMTP id v10so17295114iop.4
        for <linux-iio@vger.kernel.org>; Thu, 28 Feb 2019 09:41:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cckoPTsb+jHCcl0xUxPKTRx/AhpgqbazadCmKuJdRBk=;
        b=byHTQDY+/BEVnKx7MLIBVjKw+rt+tVIYp9ppmkBC/LEYbRH4EahTc71Oy12WRTae7Q
         vZ+FQRdezKMQcslWxWmT3Qf//BTx1SAVIFACpBv2y8iE/cPs4AO6m1CIfogRhCb77pTT
         cWKNdYurKZd9+1XYQvAQX3ohWb5FDR06jeS9I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cckoPTsb+jHCcl0xUxPKTRx/AhpgqbazadCmKuJdRBk=;
        b=AsFk8I8F2Dy/ZzjAWC22MCO51xRRbzmrf5I9JeSMHLrBUXLzt+CusoIAnPIRo6+kXn
         JwfcKV5Z3es8RyAfS552BDsqHvsEMC37s3CeXCob6iaXAT6BjVsFCNdmXMDJusNba4XB
         aoc+11lC3wq2SKBQkeLA47cfkHY6sk4ph+kfsn+iJDkEC0YMaBCy0Zy3L1ujdnoe8NgR
         8EyEn1WSZtbj57uiOuf2IRmLS/aFMy3ve+jawnCaMXC5Ce1J+zvuurknSDcKP3Eyu6SW
         HqE/q6s7e7EwjXtE0tvpDvtraWD7VS0I/L2xEDt9CQ4Sdx0sRn4tsqVmqjmtEw+Ppfhs
         pTsA==
X-Gm-Message-State: APjAAAVjYfB8mcmIKHnCarLKmih6kGfhinKF2LTQK1dv8EVmnEqiVmDx
        YqR1kH0hSPVWlDdnIXTYJZKbL8tsOn6yLmmZZqcv5w==
X-Google-Smtp-Source: APXvYqy/BU6mXe9AmD1kMI/58QRwWGITRFvUtDSsaBzjLZ6E7bz/BwBLjzS6AEE7jS9s5uLaJp8WH93A+ubWp1z7l9I=
X-Received: by 2002:a5e:8416:: with SMTP id h22mr335673ioj.118.1551375702320;
 Thu, 28 Feb 2019 09:41:42 -0800 (PST)
MIME-Version: 1.0
References: <20190228015005.81232-1-gwendal@chromium.org> <891ea2d8-81cf-9cff-eb04-9f52259cd734@collabora.com>
In-Reply-To: <891ea2d8-81cf-9cff-eb04-9f52259cd734@collabora.com>
From:   Gwendal Grignou <gwendal@chromium.org>
Date:   Thu, 28 Feb 2019 09:41:31 -0800
Message-ID: <CAPUE2uvHzJR-82yBdY3oxYV_-t=3Lr6n2svaf+FeN7LCzw6saA@mail.gmail.com>
Subject: Re: [PATCH] iio: cros_ec: Add lid angle driver
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     lee.jones@linaro.org, Guenter Roeck <groeck@chromium.org>,
        bleung@chromium.org, lars@metafoo.de, jic23@kernel.org,
        egranata@chromium.org, linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Feb 28, 2019 at 3:18 AM Enric Balletbo i Serra
<enric.balletbo@collabora.com> wrote:
>
> Hi Gwendal,
>
> Thanks to send this upstream.
>
> On 28/2/19 2:50, Gwendal Grignou wrote:
> > Add a IIO driver that reports the angle between the lid and the base for
> > ChromeOS convertible device.
> >
> > Tested on eve with ToT EC firmware.
> > Check driver is loaded and lid angle is correct.
> >
> > Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
> > ---
> >  drivers/iio/common/cros_ec_sensors/Kconfig    |   9 +
> >  drivers/iio/common/cros_ec_sensors/Makefile   |   1 +
> >  .../cros_ec_sensors/cros_ec_lid_angle.c       | 164 ++++++++++++++++++
> >  drivers/mfd/cros_ec_dev.c                     |  15 +-
>
> The mfd/cros_ec_dev.c part looks good to me. I have some few comments in the IIO
> part, see below.
>
> >  4 files changed, 186 insertions(+), 3 deletions(-)
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
> > index 000000000000..370b3e9a1405
> > --- /dev/null
> > +++ b/drivers/iio/common/cros_ec_sensors/cros_ec_lid_angle.c
> > @@ -0,0 +1,164 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +
>
> There is a license mismatch between the SPDX identifier (GPLv2 or later) and the
> MODULE_LICENSE (GPLv2). I think that this should be only GPL-2.0
Done.
>
> > +/*
> > + * cros_ec_lid_angle - Driver for CrOS EC lid angle sensor.
> > + *
...
> > +static const struct iio_info cros_ec_lid_angle_info = {
> > +     .read_raw = &cros_ec_lid_angle_read,
> > +     .driver_module = THIS_MODULE,
>
> This is not needed now, you can remove it.
Done.
>
> > +};
> > +
> > +static int cros_ec_lid_angle_probe(struct platform_device *pdev)
...
