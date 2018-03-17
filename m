Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([46.235.226.198]:58864 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753259AbeCQUAG (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 17 Mar 2018 16:00:06 -0400
Date: Sat, 17 Mar 2018 20:00:03 +0000
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To: Gwendal Grignou <gwendal@chromium.org>
Cc: lars@metafoo.de, paolocretaro@gmail.com,
        enric.balletbo@collabora.com, linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: cros_ec: Move cros_ec_sensors_core.h in /include
Message-ID: <20180317200003.595e88d5@archlinux>
In-Reply-To: <20180317195604.4a561f97@archlinux>
References: <20180313212328.129640-1-gwendal@chromium.org>
        <20180317195604.4a561f97@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sat, 17 Mar 2018 19:56:04 +0000
Jonathan Cameron <jic23@kernel.org> wrote:

> On Tue, 13 Mar 2018 14:23:28 -0700
> Gwendal Grignou <gwendal@chromium.org> wrote:
> 
> > Similar to other common iio frameworks, move cros_ec_sensors_core.h from
> > drivers/iio/common/cros_ec_sensors/ to include/linux/iio/common.
> > 
> > Signed-off-by: Gwendal Grignou <gwendal@chromium.org>  
> Applied to the togreg branch of iio.git and pushed out as testing for the
> autobuilders to play with it.
I spoke too soon as my own build tests were running.  The header ordering
change broke the build as there was no definition of struct platform_device.
I added it to the header and I think it is all fixed.

May be other problems hiding like that, but the autobuilders should find
them.

Jonathan

> 
> Thanks,
> 
> Jonathan
> 
> > ---
> >  drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c           | 3 +--
> >  drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c      | 3 +--
> >  drivers/iio/light/cros_ec_light_prox.c                         | 3 +--
> >  drivers/iio/pressure/cros_ec_baro.c                            | 3 +--
> >  .../linux/iio/common}/cros_ec_sensors_core.h                   | 2 ++
> >  5 files changed, 6 insertions(+), 8 deletions(-)
> >  rename {drivers/iio/common/cros_ec_sensors => include/linux/iio/common}/cros_ec_sensors_core.h (99%)
> > 
> > diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c
> > index 7d30c59da3e2..8e3f99a8b30c 100644
> > --- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c
> > +++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c
> > @@ -19,6 +19,7 @@
> >  #include <linux/delay.h>
> >  #include <linux/device.h>
> >  #include <linux/iio/buffer.h>
> > +#include <linux/iio/common/cros_ec_sensors_core.h>
> >  #include <linux/iio/iio.h>
> >  #include <linux/iio/kfifo_buf.h>
> >  #include <linux/iio/trigger_consumer.h>
> > @@ -31,8 +32,6 @@
> >  #include <linux/slab.h>
> >  #include <linux/sysfs.h>
> >  
> > -#include "cros_ec_sensors_core.h"
> > -
> >  #define CROS_EC_SENSORS_MAX_CHANNELS 4
> >  
> >  /* State data for ec_sensors iio driver. */
> > diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> > index 416cae5ebbd0..ea3268bd92f4 100644
> > --- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> > +++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> > @@ -16,6 +16,7 @@
> >  #include <linux/delay.h>
> >  #include <linux/device.h>
> >  #include <linux/iio/buffer.h>
> > +#include <linux/iio/common/cros_ec_sensors_core.h>
> >  #include <linux/iio/iio.h>
> >  #include <linux/iio/kfifo_buf.h>
> >  #include <linux/iio/trigger_consumer.h>
> > @@ -27,8 +28,6 @@
> >  #include <linux/sysfs.h>
> >  #include <linux/platform_device.h>
> >  
> > -#include "cros_ec_sensors_core.h"
> > -
> >  static char *cros_ec_loc[] = {
> >  	[MOTIONSENSE_LOC_BASE] = "base",
> >  	[MOTIONSENSE_LOC_LID] = "lid",
> > diff --git a/drivers/iio/light/cros_ec_light_prox.c b/drivers/iio/light/cros_ec_light_prox.c
> > index acfad4aeb27a..15bd105b08f3 100644
> > --- a/drivers/iio/light/cros_ec_light_prox.c
> > +++ b/drivers/iio/light/cros_ec_light_prox.c
> > @@ -16,6 +16,7 @@
> >  #include <linux/delay.h>
> >  #include <linux/device.h>
> >  #include <linux/iio/buffer.h>
> > +#include <linux/iio/common/cros_ec_sensors_core.h>
> >  #include <linux/iio/iio.h>
> >  #include <linux/iio/kfifo_buf.h>
> >  #include <linux/iio/trigger.h>
> > @@ -29,8 +30,6 @@
> >  #include <linux/slab.h>
> >  #include <linux/sysfs.h>
> >  
> > -#include "../common/cros_ec_sensors/cros_ec_sensors_core.h"
> > -
> >  /*
> >   * We only represent one entry for light or proximity. EC is merging different
> >   * light sensors to return the what the eye would see. For proximity, we
> > diff --git a/drivers/iio/pressure/cros_ec_baro.c b/drivers/iio/pressure/cros_ec_baro.c
> > index 4599fde4dd25..87c07af9181f 100644
> > --- a/drivers/iio/pressure/cros_ec_baro.c
> > +++ b/drivers/iio/pressure/cros_ec_baro.c
> > @@ -16,6 +16,7 @@
> >  #include <linux/delay.h>
> >  #include <linux/device.h>
> >  #include <linux/iio/buffer.h>
> > +#include <linux/iio/common/cros_ec_sensors_core.h>
> >  #include <linux/iio/iio.h>
> >  #include <linux/iio/kfifo_buf.h>
> >  #include <linux/iio/trigger.h>
> > @@ -28,8 +29,6 @@
> >  #include <linux/slab.h>
> >  #include <linux/platform_device.h>
> >  
> > -#include "../common/cros_ec_sensors/cros_ec_sensors_core.h"
> > -
> >  /*
> >   * One channel for pressure, the other for timestamp.
> >   */
> > diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.h b/include/linux/iio/common/cros_ec_sensors_core.h
> > similarity index 99%
> > rename from drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.h
> > rename to include/linux/iio/common/cros_ec_sensors_core.h
> > index 8bc2ca3c2e2e..a6701827a773 100644
> > --- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.h
> > +++ b/include/linux/iio/common/cros_ec_sensors_core.h
> > @@ -16,7 +16,9 @@
> >  #ifndef __CROS_EC_SENSORS_CORE_H
> >  #define __CROS_EC_SENSORS_CORE_H
> >  
> > +#include <linux/iio/iio.h>
> >  #include <linux/irqreturn.h>
> > +#include <linux/mfd/cros_ec.h>
> >  
> >  enum {
> >  	CROS_EC_SENSOR_X,  
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

