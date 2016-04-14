Return-Path: <sst@poczta.fm>
From: Slawomir Stepien <sst@poczta.fm>
To: jic23@kernel.org,
	knaack.h@gmx.de,
	pmeerw@pmeerw.net
Cc: linux-iio@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Slawomir Stepien <sst@poczta.fm>
Subject: [PATCH 00/10] iio: fix errors reported by checkpatch.pl
Date: Thu, 14 Apr 2016 21:36:32 +0200
Message-Id: <1460662602-2951-1-git-send-email-sst@poczta.fm>
List-ID: <linux-iio@vger.kernel.org>

Simple fixes of errors reported by checkpatch.pl.

Slawomir Stepien (10):
  iio: light apds9960: fix wrong use of brace
  iio: inkern: add a missing space before if
  iio: adc: vf610_adc: fix case label indent
  iio: adc: mcp3422: remove spaces before comma
  iio: adc: at91_adc: fix errors reported by checkpatch.pl
  iio: adc: ad799x: remove space before comma
  iio: common: ms_sensors: use tab for indention
  iio: common: hid-sensors: use tab for indention
  iio: magnetometer: ak8975: put else and brace at the same line
  iio: pressure: ms5611: use tab for indention

 drivers/iio/adc/ad799x.c                           |  2 +-
 drivers/iio/adc/at91_adc.c                         |  8 ++++----
 drivers/iio/adc/mcp3422.c                          |  6 +++---
 drivers/iio/adc/vf610_adc.c                        | 24 +++++++++++-----------
 .../iio/common/hid-sensors/hid-sensor-trigger.c    |  2 +-
 drivers/iio/common/ms_sensors/ms_sensors_i2c.c     |  2 +-
 drivers/iio/inkern.c                               |  2 +-
 drivers/iio/light/apds9960.c                       |  8 ++++++--
 drivers/iio/magnetometer/ak8975.c                  |  3 +--
 drivers/iio/pressure/ms5611_core.c                 |  2 +-
 drivers/iio/pressure/ms5611_spi.c                  |  2 +-
 11 files changed, 32 insertions(+), 29 deletions(-)

-- 
2.8.0
