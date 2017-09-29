Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:57266 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751224AbdI2Rce (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 29 Sep 2017 13:32:34 -0400
Message-ID: <1506706352.3098.1.camel@linux.intel.com>
Subject: Re: [PATCH v3 7/8] iio: accel: kxcjk1013: remove unused platform
 data struct
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: Jonathan Cameron <jic23@kernel.org>,
        =?UTF-8?Q?Micha=C5=82_Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Cc: linux-iio@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Date: Fri, 29 Sep 2017 10:32:32 -0700
In-Reply-To: <20170924162952.405404b0@archlinux>
References: <cover.1505660069.git.mirq-linux@rere.qmqm.pl>
         <7bab949c05f3fb70014bda990d7217ac98b08cbd.1505660069.git.mirq-linux@rere.qmqm.pl>
         <20170924162952.405404b0@archlinux>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sun, 2017-09-24 at 16:29 +0100, Jonathan Cameron wrote:
> On Sun, 17 Sep 2017 17:01:04 +0200
> Michał Mirosław <mirq-linux@rere.qmqm.pl> wrote:
> 
> > kxcjk1013's platform data has no in-kernel users. Remove it.
> > 
> > Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
> 
> Hmm. I'm not particularly keen on breaking peoples out of tree
> board files just for the sake of removing a bit of code.
> 
> Srinivas, what do you think?
I am sure it will break some boards. We have some boards with an
interface called SFI, which can send this platform data.

Thanks,
Srinivas

> 
> Jonathan
> 
> > ---
> >  drivers/iio/accel/kxcjk-1013.c       | 14 +-------------
> >  include/linux/iio/accel/kxcjk_1013.h | 22 ----------------------
> >  2 files changed, 1 insertion(+), 35 deletions(-)
> > 
> > diff --git a/drivers/iio/accel/kxcjk-1013.c
> > b/drivers/iio/accel/kxcjk-1013.c
> > index 8892dc5d2422..7c010892945c 100644
> > --- a/drivers/iio/accel/kxcjk-1013.c
> > +++ b/drivers/iio/accel/kxcjk-1013.c
> > @@ -29,7 +29,6 @@
> >  #include <linux/iio/events.h>
> >  #include <linux/iio/trigger_consumer.h>
> >  #include <linux/iio/triggered_buffer.h>
> > -#include <linux/iio/accel/kxcjk_1013.h>
> >  
> >  #define KXCJK1013_DRV_NAME "kxcjk1013"
> >  #define KXCJK1013_IRQ_NAME "kxcjk1013_event"
> > @@ -144,7 +143,6 @@ struct kxcjk1013_data {
> >  	u8 range;
> >  	int wake_thres;
> >  	int wake_dur;
> > -	bool active_high_intr;
> >  	bool dready_trigger_on;
> >  	int ev_enable_state;
> >  	bool motion_trigger_on;
> > @@ -402,10 +400,7 @@ static int kxcjk1013_chip_init(struct
> > kxcjk1013_data *data)
> >  		return ret;
> >  	}
> >  
> > -	if (data->active_high_intr)
> > -		ret |= KXCJK1013_REG_INT_CTRL1_BIT_IEA;
> > -	else
> > -		ret &= ~KXCJK1013_REG_INT_CTRL1_BIT_IEA;
> > +	ret |= KXCJK1013_REG_INT_CTRL1_BIT_IEA;
> >  
> >  	ret = i2c_smbus_write_byte_data(data->client,
> > KXCJK1013_REG_INT_CTRL1,
> >  					ret);
> > @@ -1264,7 +1259,6 @@ static int kxcjk1013_probe(struct i2c_client
> > *client,
> >  {
> >  	struct kxcjk1013_data *data;
> >  	struct iio_dev *indio_dev;
> > -	struct kxcjk_1013_platform_data *pdata;
> >  	const char *name;
> >  	int ret;
> >  
> > @@ -1276,12 +1270,6 @@ static int kxcjk1013_probe(struct i2c_client
> > *client,
> >  	i2c_set_clientdata(client, indio_dev);
> >  	data->client = client;
> >  
> > -	pdata = dev_get_platdata(&client->dev);
> > -	if (pdata)
> > -		data->active_high_intr = pdata->active_high_intr;
> > -	else
> > -		data->active_high_intr = true; /* default polarity
> > */
> > -
> >  	if (id) {
> >  		data->chipset = (enum kx_chipset)(id-
> > >driver_data);
> >  		name = id->name;
> > diff --git a/include/linux/iio/accel/kxcjk_1013.h
> > b/include/linux/iio/accel/kxcjk_1013.h
> > deleted file mode 100644
> > index fd1d540ea62d..000000000000
> > --- a/include/linux/iio/accel/kxcjk_1013.h
> > +++ /dev/null
> > @@ -1,22 +0,0 @@
> > -/*
> > - * KXCJK-1013 3-axis accelerometer Interface
> > - * Copyright (c) 2014, Intel Corporation.
> > - *
> > - * This program is free software; you can redistribute it and/or
> > modify it
> > - * under the terms and conditions of the GNU General Public
> > License,
> > - * version 2, as published by the Free Software Foundation.
> > - *
> > - * This program is distributed in the hope it will be useful, but
> > WITHOUT
> > - * ANY WARRANTY; without even the implied warranty of
> > MERCHANTABILITY or
> > - * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public
> > License for
> > - * more details.
> > - */
> > -
> > -#ifndef __IIO_KXCJK_1013_H__
> > -#define __IIO_KXCJK_1013_H__
> > -
> > -struct kxcjk_1013_platform_data {
> > -	bool active_high_intr;
> > -};
> > -
> > -#endif
> 
> 
