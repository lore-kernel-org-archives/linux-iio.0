Return-Path: <SRS0=jbKP=A7=onstation.org=masneyb@kernel.org>
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
Subject: [PATCH 0/3] staging: iio: tsl2x7x: staging cleanups
Date: Fri, 29 Sep 2017 21:09:18 -0400
Message-Id: <20170930010921.15447-1-masneyb@onstation.org>
List-ID: <linux-iio@vger.kernel.org>

This patch set converts several sysfs attributes from directly being
created by the driver to be created by iio_chan_spec and iio_event_spec.
There is also a patch to shorten the length of a variable to fix an
issue that I encountered with some lines that were over 80 characters
with this refactoring.

Driver tested using a TSL2771 hooked up to a Raspberry Pi 2.

List of sysfs attributes before and after my changes:

raspberrypi:/sys/bus/iio/devices/iio:device0$ find . -type f | sort
./dev
./events/in_intensity0_thresh_falling_en
./events/in_intensity0_thresh_falling_value
./events/in_intensity0_thresh_period
./events/in_intensity0_thresh_rising_en
./events/in_intensity0_thresh_rising_value
./events/in_proximity0_thresh_falling_en
./events/in_proximity0_thresh_falling_value
./events/in_proximity0_thresh_period
./events/in_proximity0_thresh_rising_en
./events/in_proximity0_thresh_rising_value
./in_illuminance0_calibrate
./in_illuminance0_calibscale_available
./in_illuminance0_input
./in_illuminance0_integration_time
./in_illuminance0_integration_time_available
./in_illuminance0_lux_table
./in_illuminance0_target_input
./in_intensity0_calibbias
./in_intensity0_calibscale
./in_intensity0_raw
./in_intensity1_raw
./in_proximity0_calibrate
./in_proximity0_raw
./name
./power/autosuspend_delay_ms
./power/control
./power/runtime_active_time
./power/runtime_status
./power/runtime_suspended_time
./uevent

Brian Masney (3):
  staging: iio: tsl2x7x: rename tsl2x7x_settings variable to settings
  staging: iio: tsl2x7x: migrate in_illuminance0_integration_time sysfs
    attribute to iio_chan_spec
  staging: iio: tsl2x7x: migrate *_thresh_period sysfs attributes to
    iio_event_spec

 drivers/staging/iio/light/tsl2x7x.c | 418 ++++++++++++------------------------
 1 file changed, 141 insertions(+), 277 deletions(-)

-- 
2.13.5
