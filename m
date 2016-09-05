Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pa0-f68.google.com ([209.85.220.68]:34932 "EHLO
        mail-pa0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934889AbcIEQrS (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 5 Sep 2016 12:47:18 -0400
From: Joshua Clayton <stillcompiling@gmail.com>
To: Quentin Schulz <quentin.schulz@free-electrons.com>
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>,
        jdelvare@suse.com, linux@roeck-us.net, jic23@kernel.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net, wens@csie.org,
        lee.jones@linaro.org, thomas.petazzoni@free-electrons.com,
        antoine.tenart@free-electrons.com, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 3/3] iio: adc: add support for Allwinner SoCs ADC
Date: Mon, 05 Sep 2016 09:47:12 -0700
Message-ID: <1957122.9eY1bPBcZc@diplodocus>
In-Reply-To: <9219f76c-384a-a7c3-5b13-ebaec980ab41@free-electrons.com>
References: <1472738705-20145-1-git-send-email-quentin.schulz@free-electrons.com> <20160905070716.GA6322@lukather> <9219f76c-384a-a7c3-5b13-ebaec980ab41@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Monday, September 05, 2016 09:11:47 AM Quentin Schulz wrote:
> On 05/09/2016 09:07, Maxime Ripard wrote:
> > Hi,
> > 
> > Nitpicks ahead.
> > 
> > On Thu, Sep 01, 2016 at 04:05:05PM +0200, Quentin Schulz wrote:
> >> +	info->soc_specific = (struct soc_specific *)platform_get_device_id(pdev)->driver_data;
> > 
> > This line is still rather long. How about calling the field "data" and
> > the structure gpadc_data?
> > 
> 
> driver_data is coming from the platform_device_id
> (http://lxr.free-electrons.com/source/include/linux/mod_devicetable.h#L498)
> so can't really change that.
> I could change the structure to gpadc_data, that would save me 2
> characters, still 13 characters above the 80 characters limit however.
> 
I think Maxime meant to change member "soc_specific" to "data" of type
struct gpadc_data

> >> +
> >> +	tzd = devm_thermal_zone_of_sensor_register(pdev->dev.parent, 0, info,
> >> +						   &sun4i_ts_tz_ops);
> > 
> > A comment on why you put the parent device structure and not the
> > device itself like you're doing on all the other calls in that probe
> > would be nice.
> > 
> 
> Indeed.
> 
> Thanks,
> Quentin
> 
> > Thanks!
> > Maxime
> > 
> 

