Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wr0-f171.google.com ([209.85.128.171]:32872 "EHLO
        mail-wr0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752577AbdDDIiP (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 4 Apr 2017 04:38:15 -0400
Received: by mail-wr0-f171.google.com with SMTP id w43so203513094wrb.0
        for <linux-iio@vger.kernel.org>; Tue, 04 Apr 2017 01:38:15 -0700 (PDT)
Date: Tue, 4 Apr 2017 09:38:06 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
        Olof Johansson <olof@lixom.net>, bleung@chromium.org,
        martinez.javier@gmail.com, Guenter Roeck <groeck@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        rtc-linux@googlegroups.com, Stephen Barber <smbarber@chromium.org>
Subject: Re: [PATCH 7/7] mfd: cros_ec: add RTC as mfd subdevice
Message-ID: <20170404083806.hkjvkacznxefqsqz@dell>
References: <20170324174407.25401-1-enric.balletbo@collabora.com>
 <20170324174407.25401-8-enric.balletbo@collabora.com>
 <20170403142512.dlipwaocizisyipg@dell>
 <1e60b276-5327-5bbd-15c5-fd5c920e5ba6@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1e60b276-5327-5bbd-15c5-fd5c920e5ba6@collabora.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, 03 Apr 2017, Enric Balletbo i Serra wrote:

> 
> 
> On 03/04/17 16:25, Lee Jones wrote:
> > On Fri, 24 Mar 2017, Enric Balletbo i Serra wrote:
> > 
> >> From: Stephen Barber <smbarber@chromium.org>
> >>
> >> If the EC supports RTC host commands, expose an RTC device.
> >>
> >> Signed-off-by: Stephen Barber <smbarber@chromium.org>
> >> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> >> ---
> >>  drivers/mfd/cros_ec.c | 18 ++++++++++++++++++
> >>  1 file changed, 18 insertions(+)
> >>
> >> diff --git a/drivers/mfd/cros_ec.c b/drivers/mfd/cros_ec.c
> >> index bbc17ab..1ff88b1 100644
> >> --- a/drivers/mfd/cros_ec.c
> >> +++ b/drivers/mfd/cros_ec.c
> >> @@ -51,6 +51,11 @@ static const struct mfd_cell ec_pd_cell = {
> >>  	.pdata_size = sizeof(pd_p),
> >>  };
> >>  
> >> +static const struct mfd_cell ec_rtc_cell = {
> >> +	.name = "cros-ec-rtc",
> >> +	.id   = -1,
> > 
> > Why -1?
> > 
> >> +};
> >> +
> >>  static irqreturn_t ec_irq_thread(int irq, void *data)
> >>  {
> >>  	struct cros_ec_device *ec_dev = data;
> >> @@ -238,6 +243,15 @@ static void cros_ec_sensors_register(struct cros_ec_device *ec_dev)
> >>  	kfree(msg);
> >>  }
> >>  
> >> +static void cros_ec_rtc_register(struct cros_ec_device *ec_dev)
> >> +{
> >> +	int ret;
> >> +
> >> +	ret = mfd_add_devices(ec_dev->dev, 0, &ec_rtc_cell, 1, NULL, 0, NULL);
> > 
> > Why 0?
> > 
> 
> Right, just maintained the one in the original. I think I can use
> PLATFORM_DEVID_AUTO here?

Yes, and don't set the .id to -1 in the cell.

> >> +	if (ret)
> >> +		dev_err(ec_dev->dev, "failed to add EC RTC\n");
> >> +}
> >> +
> >>  int cros_ec_register(struct cros_ec_device *ec_dev)
> >>  {
> >>  	struct device *dev = ec_dev->dev;
> >> @@ -287,6 +301,10 @@ int cros_ec_register(struct cros_ec_device *ec_dev)
> >>  	if (cros_ec_check_features(ec_dev, EC_FEATURE_MOTION_SENSE))
> >>  		cros_ec_sensors_register(ec_dev);
> >>  
> >> +	/* Check whether this EC has RTC support */
> >> +	if (cros_ec_check_features(ec_dev, EC_FEATURE_RTC))
> >> +		cros_ec_rtc_register(ec_dev);
> >> +
> >>  	if (ec_dev->max_passthru) {
> >>  		/*
> >>  		 * Register a PD device as well on top of this device.
> > 

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
