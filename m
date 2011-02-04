Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-52.csi.cam.ac.uk ([131.111.8.152]:58690 "EHLO
	ppsw-52.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751377Ab1BDO4a (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 4 Feb 2011 09:56:30 -0500
Message-ID: <4D4C139D.9090700@cam.ac.uk>
Date: Fri, 04 Feb 2011 14:56:29 +0000
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: "Hennerich, Michael" <Michael.Hennerich@analog.com>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Drivers <Drivers@analog.com>,
	"device-drivers-devel@blackfin.uclinux.org"
	<device-drivers-devel@blackfin.uclinux.org>
Subject: Re: [PATCH] IIO: ADC: New driver for AD7606/AD7606-6/AD7606-4
References: <1296744691-24320-1-git-send-email-michael.hennerich@analog.com> <4D4B1208.3080604@cam.ac.uk> <544AC56F16B56944AEC3BD4E3D591771324C1BA54D@LIMKCMBX1.ad.analog.com>
In-Reply-To: <544AC56F16B56944AEC3BD4E3D591771324C1BA54D@LIMKCMBX1.ad.analog.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 02/04/11 14:27, Hennerich, Michael wrote:
>> From: Jonathan Cameron [mailto:jic23@cam.ac.uk]
>> On 02/03/11 14:51, michael.hennerich@analog.com wrote:
>>> From: Michael Hennerich <michael.hennerich@analog.com>
> 
> [--snip--]
> 
>>> +
>>> +What:              /sys/bus/iio/devices/deviceX/range_available
>>> +KernelVersion:     2.6.38
>>> +Contact:   linux-iio@vger.kernel.org
>>> +Description:
>>> +           Hardware dependent supported vales for ADC Full Scale
>> Range.
>>> +
>>> +What:              /sys/bus/iio/devices/deviceX/oversampling
>>> +KernelVersion:     2.6.38
>>> +Contact:   linux-iio@vger.kernel.org
>>> +Description:
>>> +           Hardware dependent ADC oversamplimg.
>> Typo.
>>> Controls the sampling ratio
>>> +           of the digital filter if available.
>> What are the units?  The obvious choice is a multiplier, but could be
>> frequency.
>> Either way, needs to be specified here.
> 
> 'Ratio' or 'rate' is the best you can use here.
> http://mathworld.wolfram.com/Oversampling.html
Then lets call it oversampling_ratio and make this very obvious.
> 
>>> +
>>> +What:              /sys/bus/iio/devices/deviceX/oversampling_available
>>> +KernelVersion:     2.6.38
>>> +Contact:   linux-iio@vger.kernel.org
>>> +Description:
>>> +           Hardware dependent supported vales
>> values (and should probably be Hardware dependent values supported by
>> the
>> oversampling filter.)
>>> by the oversampling filter.
>>> +
<snip>

>>> index 0000000..21e5af8
>>> --- /dev/null
>>> +++ b/drivers/staging/iio/adc/ad7606_core.c
>>> @@ -0,0 +1,560 @@
>>> +/*
>>> + * AD7606 SPI ADC driver
>>> + *
>>> + * Copyright 2011 Analog Devices Inc.
>>> + *
>>> + * Licensed under the GPL-2.
>>> + */
>>> +
>>> +#include <linux/interrupt.h>
>>> +#include <linux/workqueue.h>
>>> +#include <linux/device.h>
>>> +#include <linux/kernel.h>
>>> +#include <linux/slab.h>
>>> +#include <linux/sysfs.h>
>>> +#include <linux/list.h>
>>> +#include <linux/regulator/consumer.h>
>>> +#include <linux/err.h>
>>> +#include <linux/gpio.h>
>>> +#include <linux/delay.h>
>>> +
>>> +#include "../iio.h"
>>> +#include "../sysfs.h"
>>> +#include "../ring_generic.h"
>>> +#include "adc.h"
>>> +
>>> +#include "ad7606.h"
>>> +
>>> +int ad7606_reset(struct ad7606_state *st)
>>> +{
>>> +   if (st->have_reset) {
>>> +           gpio_set_value(st->pdata->gpio_reset, 1);
>>> +           ndelay(100); /* t_reset >= 100ns */
>> could it be a sleep?
> 
> Only 100ns are required!
> Why would I go to sleep?
Fair point.
> 
> 
>>> +           gpio_set_value(st->pdata->gpio_reset, 0);
>>> +           return 0;
>>> +   }
>>> +
>>> +   return -ENODEV;
>>> +}
>>> +
>>> +static int ad7606_scan_direct(struct ad7606_state *st, unsigned ch)
>>> +{
>>> +   int ret;
>>> +
>>> +   gpio_set_value(st->pdata->gpio_convst, 1);
>>> +   st->done = false;
>>> +
>>> +   ret = wait_event_interruptible(st->wq_data_avail, st->done);
>>> +   if (ret)
>>> +           goto error_ret;
>>> +
>>> +   if (st->have_frstdata) {
>>> +           st->bops->read_block(st->dev, 1, st->data);
>>> +           if (!gpio_get_value(st->pdata->gpio_frstdata)) {
>>> +                   /* This should never happen */
>>                       As below.... does it and if so why?
> 
> In case it happens we're out of sync.
> 
> Most people won't use FRSTDATA checks at all.
> 
> However some signal glitch caused perhaps by some electrostatic
> discharge, could cause an extra read or clock.
> This allows recovery.
Can you add that to the comment please for future readers of the code.
> 
>>> +                   ad7606_reset(st);
>>> +                   ret = -EIO;
>>> +                   goto error_ret;
>>> +           }
<snip>
