Return-Path: <SRS0=yIYx=6C=onstation.org=masneyb@kernel.org>
From: Brian Masney <masneyb@onstation.org>
To: jic23@kernel.org,
	linux-iio@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	devel@driverdev.osuosl.org,
	knaack.h@gmx.de,
	lars@metafoo.de,
	pmeerw@pmeerw.net,
	linux-kernel@vger.kernel.org,
	Jon.Brenner@ams.com
Subject: [PATCH 0/6] staging: iio: tsl2x7x: staging cleanups
Date: Thu, 29 Jun 2017 13:03:46 -0400
Message-Id: <20170629170352.11264-1-masneyb@onstation.org>
List-ID: <linux-iio@vger.kernel.org>

This begins my work to clean this driver up and eventually move it out
of staging. Driver changes were tested using a TSL2771 hooked up to a
Raspberry Pi 2.

Thanks to Jon Brenner at AMS/TAOS for loaning me some hardware samples
to test my driver changes.

Brian Masney (6):
  staging: iio: tsl2x7x: add of_match table for device tree support
  staging: iio: tsl2x7x: remove redundant power_state sysfs attribute
  staging: iio: tsl2x7x: remove tsl2x7x_i2c_read()
  staging: iio: tsl2x7x: cleaned up i2c calls in tsl2x7x_als_calibrate()
  staging: iio: tsl2x7x: refactor {read,write}_event_value to allow
    handling multiple iio_event_infos
  staging: iio: tsl2x7x: use usleep_range() instead of mdelay()

 .../devicetree/bindings/trivial-devices.txt        |  10 +
 drivers/staging/iio/light/tsl2x7x.c                | 316 ++++++++++-----------
 2 files changed, 153 insertions(+), 173 deletions(-)

-- 
2.9.4
