Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from onstation.org ([52.200.56.107]:39954 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751266AbdBICN1 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 8 Feb 2017 21:13:27 -0500
From: Brian Masney <masneyb@onstation.org>
To: jic23@kernel.org
Cc: gregkh@linuxfoundation.org, linux-iio@vger.kernel.org,
        devel@driverdev.osuosl.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, linux-kernel@vger.kernel.org,
        ldewangan@nvidia.com
Subject: [PATCH 0/7] iio: isl29028: move out of staging
Date: Wed,  8 Feb 2017 20:54:24 -0500
Message-Id: <20170209015431.17380-1-masneyb@onstation.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This is my last series of staging cleanups for the ISL29028 driver.
Highlights of this patch series include some cleanups to the timing
code, a fix for runtime power management support, and documentation.

I mentioned in one of my earlier patch series that I was having issues
getting the proximity sensing portion of the sensor working. This
appears to be an issue with my sensor since I was able to get the
proximity sensor working intermittenly by tapping the chip. It is
likely an issue with the way that the chip was mounted on my breakout
board. I've also verified with a cell phone screen that the IR LED
turns on for two seconds when the proximity sensing feature is enabled.

Brian Masney (7):
  staging: iio: isl29028: change mdelay() to msleep()
  staging: iio: isl29028: fix incorrect sleep time when taking proximity
    reading
  staging: iio: isl29028: fix incorrect sampling frequency value
  staging: iio: isl29028: use the runtime power management for system
    sleep
  staging: iio: isl29028: add copyright
  iio: Documentation: add ABI documentation for
    in_proximity_sampling_frequency_available
  staging: iio: isl29028: move out of staging

 Documentation/ABI/testing/sysfs-bus-iio    |  1 +
 drivers/iio/light/Kconfig                  | 10 ++++++++
 drivers/iio/light/Makefile                 |  1 +
 drivers/{staging => }/iio/light/isl29028.c | 39 ++++++++++++++++++++----------
 drivers/staging/iio/light/Kconfig          | 10 --------
 drivers/staging/iio/light/Makefile         |  1 -
 6 files changed, 38 insertions(+), 24 deletions(-)
 rename drivers/{staging => }/iio/light/isl29028.c (95%)

-- 
2.9.3

