Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.stresser.de ([88.198.198.115]:33076 "EHLO mail.stresser.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933418AbeCHOTm (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 8 Mar 2018 09:19:42 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.stresser.de (Postfix) with ESMTP id 0B0154380065
        for <linux-iio@vger.kernel.org>; Thu,  8 Mar 2018 15:19:41 +0100 (CET)
Received: from _ (frachter.heine.tech [46.4.84.91])
        (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.stresser.de (Postfix) with ESMTPSA id D5E9D4380064
        for <linux-iio@vger.kernel.org>; Thu,  8 Mar 2018 15:19:39 +0100 (CET)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Date: Thu, 08 Mar 2018 15:19:39 +0100
From: Michael Nosthoff <posted@heine.so>
To: linux-iio@vger.kernel.org
Subject: Re: st_pressure: lps22: unused default data
In-Reply-To: <c374f2001d45f64a4df8a1852616224f@heine.so>
References: <c374f2001d45f64a4df8a1852616224f@heine.so>
Message-ID: <f5e6faf1ab9488d8f18a00a73d3a9a5a@heine.so>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 2018-03-08 14:54, Michael Nosthoff wrote:
> Hi,

Sorry for answering my own mail, but I got a bit further. See below

> I have an LPS22 sensor which i used sucessfully with Kernel 4.9. Upon
> switching to 4.14 it was not loading properly anymore. This failure
> occured:
> 
> [    3.827094] iio iio:device1: DRDY on pdata not valid.
> [    3.832578] st-press-i2c: probe of 0-005c failed with error -22
> 
> So I started digging. It started working again when I add this entry
> to my devicetree:
> 
> st,drdy-int-pin = <1>;
> 
> So it seems the default value seems to be not set in 4.14 but was in 
> 4.9
> 
> I came to the conclusion that the problem happens in
> drivers/iio/pressure/st_pressure_core.c in
> 
> st_press_common_probe:
> 
> 
> struct st_sensors_platform_data *pdata =
> 	(struct st_sensors_platform_data *)press_data->dev->platform_data;
> ...
> if (!pdata && press_data->sensor_settings->drdy_irq.addr)
> 	pdata =	(struct st_sensors_platform_data *)&default_press_pdata;
> 
> err = st_sensors_init_sensor(indio_dev, 
> press_data->dev->platform_data);
> 
> 
> If pdata is not set (which is correct in my case) it gets assigned a
> default value. But in the call to st_sensors_init_sensor it's still
> using the data stored in press_data.
> 
> Okay, simple solution would be to pass pdata here as well. But I'm a
> bit confused about the commit [1] which introduced this. pdata is not
> used anymore in this function, so it seems completely useless to set it
> there. And so I don't understand what the commit tries to achieve at 
> all
> besides never using the default data.
> 

Somebody seems also to have noticed in the accel driver. See this commit 
[2]
and decided to remove the default initialization completely. Which makes 
sense
as this code was not doing anything.

I guess the what the intial commit was trying to achieve was to not 
overwrite
the pointer in dev->platform_data which i can imagine might be a problem 
when
using it as a module. But maybe forgot to alter the following usage of 
the data.

So I would suggest to revert commit [2] and pass pdata to 
st_sensors_init_sensor
in both cases (st_pressure and st_accel).

Does this make sense?



> 
> [1]
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/iio/pressure/st_pressure_core.c?id=7383d44b84c94aaca4bf695a6bd8a69f2295ef1a
[2] 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/iio/accel/st_accel_core.c?id=585ed27d06151f98e39238298f43ee261314ae74
-- 
Regards,
Michael
