Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40549 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725744AbeIOHnR (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 15 Sep 2018 03:43:17 -0400
From: Song Qiang <songqiang1304521@gmail.com>
Date: Sat, 15 Sep 2018 10:25:57 +0800
To: Himanshu Jha <himanshujha199640@gmail.com>
Cc: Song Qiang <songqiang1304521@gmail.com>, jic23@kernel.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        robh+dt@kernel.org, mark.rutland@arm.com,
        andriy.shevchenko@linux.intel.com, matt.ranostay@konsulko.com,
        tglx@linutronix.de, ak@it-klinger.de, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: proximity: Add driver support for ST's VL53L0X ToF
 ranging sensor.
Message-ID: <20180915022557.GA18453@Eros>
References: <20180913022229.21563-1-songqiang.1304521@gmail.com>
 <20180914184322.GA9481@himanshu-Vostro-3559>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20180914184322.GA9481@himanshu-Vostro-3559>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sat, Sep 15, 2018 at 12:13:22AM +0530, Himanshu Jha wrote:
> Hi Song,
> 
> On Thu, Sep 13, 2018 at 10:22:29AM +0800, Song Qiang wrote:
> > This driver was originally written by ST in 2016 as a misc input device
> > driver, and hasn't been maintained for a long time. I grabbed some code
> > from it's API and reformed it into a iio proximity device driver.
> > This version of driver uses i2c bus to talk to the sensor and
> > polling for measuring completes, so no irq line is needed.
> > This version of driver supports only one-shot mode, and it can be
> > tested with reading from
> > /sys/bus/iio/devices/iio:deviceX/in_distance_raw
> > 
> > Signed-off-by: Song Qiang <songqiang.1304521@gmail.com>
> 
> I'm sorry but you probably need another revision.
> 
> And don't feel embarrassed, I mean this is your first patch
> in the kernel and that's an IIO driver!!
> 
> I used to fix spelling mistakes, align parameters, ... an year ago
> and even those got rejected several times ;)
> 
> > ---
> 
> > +ST VL53L0X ToF RANGER(I2C) IIO DRIVER
> > +M:	Song Qiang <songqiang.1304521@gmail.com>
> > +L:	linux-iio@vger.kernel.org
> > +S:	Maintained
> > +F:	drivers/iio/proximity/vl53l0x-i2c.c
> > +F:	Documentation/devicetree/bindings/iio/proximity/vl53l0x.txt
> 
> Obligations!
> 
> Just don't go "Keyser Söze" once you're done with your major
> at University. You would need to test/review patches in future.
> 
> Not a big deal though..
> 
> > +
> > +static const struct of_device_id st_vl53l0x_dt_match[] = {
> > +	{ .compatible = "st,vl53l0x-i2c", },
> > +	{ }
> > +};
> 
> MODULE_DEVICE_TABLE(of, st_vl53l0x_dt_match); ?
> 
> 
> Thanks
> -- 
> Himanshu Jha
> Undergraduate Student
> Department of Electronics & Communication
> Guru Tegh Bahadur Institute of Technology

Hi Himanshu,

I think I'll do some double check on it to make sure it's good, compare
my patch with other drivers to see some more problems I miss.
Thanks for your kindness, and with or without this patch accepted, I've
been feeling glad to get connected with the community and learned a lot
from people like you. :)

yours,
Song Qiang
