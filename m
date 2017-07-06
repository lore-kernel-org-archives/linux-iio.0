Return-Path: <SRS0=6ppP=6J=onstation.org=masneyb@kernel.org>
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
Subject: [PATCH v2 0/9] staging: iio: tsl2x7x: staging cleanups
Date: Thu,  6 Jul 2017 18:56:17 -0400
Message-Id: <20170706225626.6716-1-masneyb@onstation.org>
List-ID: <linux-iio@vger.kernel.org>

This begins my work to clean this driver up and eventually move it out
of staging. Driver changes were tested using a TSL2771 hooked up to a
Raspberry Pi 2.

Thanks to Jon Brenner at AMS/TAOS for loaning me some hardware samples
to test my driver changes.

Changes since v1:
- checkpatch cleanups (oops)
- Split out the device tree documentation and driver change into
  two separate commits so that the changes can be accepted in separate
  trees to avoid merge conflicts later.
- New patch: migrate in_illuminance0_integration_time sysfs
  attribute to iio_chan_spec
- New patch: check return value from tsl2x7x_invoke_change()

Brian Masney (9):
  staging: iio: tsl2x7x: add of_match table for device tree support
  staging: iio: tsl2x7x: add device tree documentation
  staging: iio: tsl2x7x: remove redundant power_state sysfs attribute
  staging: iio: tsl2x7x: remove tsl2x7x_i2c_read()
  staging: iio: tsl2x7x: cleaned up i2c calls in tsl2x7x_als_calibrate()
  staging: iio: tsl2x7x: refactor {read,write}_event_value to allow
    handling multiple iio_event_infos
  staging: iio: tsl2x7x: use usleep_range() instead of mdelay()
  staging: iio: tsl2x7x: migrate in_illuminance0_integration_time sysfs
    attribute to iio_chan_spec
  staging: iio: tsl2x7x: check return value from tsl2x7x_invoke_change()

 .../devicetree/bindings/trivial-devices.txt        |  10 +
 drivers/staging/iio/light/tsl2x7x.c                | 440 ++++++++++-----------
 2 files changed, 209 insertions(+), 241 deletions(-)

-- 
2.9.4
