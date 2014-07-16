Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wg0-f47.google.com ([74.125.82.47]:48927 "EHLO
	mail-wg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932951AbaGPOl7 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 16 Jul 2014 10:41:59 -0400
Received: by mail-wg0-f47.google.com with SMTP id b13so972111wgh.18
        for <linux-iio@vger.kernel.org>; Wed, 16 Jul 2014 07:41:56 -0700 (PDT)
Received: from [10.32.51.161] (ip65.parkeon.com. [213.152.31.65])
        by mx.google.com with ESMTPSA id ft17sm40189254wjc.14.2014.07.16.07.41.55
        for <linux-iio@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 16 Jul 2014 07:41:55 -0700 (PDT)
Message-ID: <53C68F32.9050407@parkeon.com>
Date: Wed, 16 Jul 2014 16:41:54 +0200
From: Martin Fuzzey <mfuzzey@parkeon.com>
MIME-Version: 1.0
To: linux-iio@vger.kernel.org
Subject: Accelerometer events
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi all,

I am in the process of adding events support to the mma8452 driver 
(patches will be forthcoming when cooked a little more).

However I have a few questions.

The hardware can generate an interrupt when the absolute value of the 
high pass filtered acceleration exceeds a configurable threshold.
This is called "transient detection" in the datasheet.
There is only a single threshold but the interrupt can be enabled or 
disabled for each axis.

So I define this as:
static const struct iio_event_spec mma8452_transient_event[] = {
     {
         .type = IIO_EV_TYPE_MAG,
         .dir = IIO_EV_DIR_RISING,
         .mask_separate = BIT(IIO_EV_INFO_ENABLE),
         .mask_shared_by_type = BIT(IIO_EV_INFO_VALUE),
     },
};

That causes the following sysfs entries to be created:
# ls -l /sys/bus/iio/devices/iio:device0/events
-rw-r--r-- 1 root root 4096 Jul 16 13:25 in_accel_mag_rising_value
-rw-r--r-- 1 root root 4096 Jul 16 13:25 in_accel_x_mag_rising_en
-rw-r--r-- 1 root root 4096 Jul 16 13:25 in_accel_y_mag_rising_en
-rw-r--r-- 1 root root 4096 Jul 16 13:26 in_accel_z_mag_rising_en

IE one enable switch per axis and one threshold (as expected).

However Documentation/ABI/testing/sysfs-bus-iio seems to indicate that 
the threshold values
should have raw or input variants.  [ 
/sys/.../events/in_accel_raw_mag_value]

This part is handled by the core, not the driver. Is there a problem here?

When raw values are used for the threshold, how is userspace to know the 
conversion factor?
In the case of the mma8452 it cannot use the current scale factor 
available in
     /sys/bus/iio/devices/iio\:device0/in_accel_scale
because the transient detection is always configured using 8G/127 units, 
regardless of the full
scale value (2G, 4G, 8G) selected for measurements.

Does this mean there should be another in_accel_scale in the events 
sysfs subdirectory?

My understanding of "rising"/"falling" is the crossing over / under the 
threshold.
However this hardware can only generate interrupts for exceeding the 
threshold (for magnitude)
It can however determine the sign of the acceleration (+ve or -ve) when 
this occurs - how should
this information be sent as an event?
I could use the "direction" attribute supplied to IIO_UNMOD_EVENT_CODE 
bit this seems to be an abuse.

All this transient detection part works with high pass filtered data 
(and the filter frequency is
configurable). There is no mention of high pass filters in the ABI, only 
low pass. So how should this
be handled?

Finally I have been using the example userspace code in 
drivers/staging/Doc/ iio_event_monitor.c
But that does
     #include <linux/iio/events.h>

Which is not exported by the kernel in include/uapi - is this a 
problem?  (Easy enough to hack around for testing
but if user space code is supposed to be using these interfaces...)


NB: for the moment I am doing this on 3.13 (I will update to latest 
mainline soon) but I haven't seen
anything in the latest git that affects the above.

Regards,

Martin
