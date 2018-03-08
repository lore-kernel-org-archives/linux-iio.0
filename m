Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.stresser.de ([88.198.198.115]:60946 "EHLO mail.stresser.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751434AbeCHNyS (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 8 Mar 2018 08:54:18 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.stresser.de (Postfix) with ESMTP id 85C0A4380065
        for <linux-iio@vger.kernel.org>; Thu,  8 Mar 2018 14:54:17 +0100 (CET)
Received: from _ (frachter.heine.tech [46.4.84.91])
        (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.stresser.de (Postfix) with ESMTPSA id 5F62D4380064
        for <linux-iio@vger.kernel.org>; Thu,  8 Mar 2018 14:54:16 +0100 (CET)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Date: Thu, 08 Mar 2018 14:54:16 +0100
From: Michael Nosthoff <posted@heine.so>
To: linux-iio@vger.kernel.org
Subject: st_pressure: lps22: unused default data
Message-ID: <c374f2001d45f64a4df8a1852616224f@heine.so>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi,

I have an LPS22 sensor which i used sucessfully with Kernel 4.9. Upon
switching to 4.14 it was not loading properly anymore. This failure
occured:

[    3.827094] iio iio:device1: DRDY on pdata not valid.
[    3.832578] st-press-i2c: probe of 0-005c failed with error -22

So I started digging. It started working again when I add this entry
to my devicetree:

st,drdy-int-pin = <1>;

So it seems the default value seems to be not set in 4.14 but was in 4.9

I came to the conclusion that the problem happens in
drivers/iio/pressure/st_pressure_core.c in

st_press_common_probe:


struct st_sensors_platform_data *pdata =
	(struct st_sensors_platform_data *)press_data->dev->platform_data;
...
if (!pdata && press_data->sensor_settings->drdy_irq.addr)
	pdata =	(struct st_sensors_platform_data *)&default_press_pdata;

err = st_sensors_init_sensor(indio_dev, press_data->dev->platform_data);


If pdata is not set (which is correct in my case) it gets assigned a
default value. But in the call to st_sensors_init_sensor it's still
using the data stored in press_data.

Okay, simple solution would be to pass pdata here as well. But I'm a
bit confused about the commit [1] which introduced this. pdata is not
used anymore in this function, so it seems completely useless to set it
there. And so I don't understand what the commit tries to achieve at all
besides never using the default data.

Any Ideas?

[1] 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/iio/pressure/st_pressure_core.c?id=7383d44b84c94aaca4bf695a6bd8a69f2295ef1a
-- 
Regards,
Michael
