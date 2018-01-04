Return-Path: <SRS0=Sbe4=D7=google.com=gwendal@kernel.org>
Sender: Gwendal Grignou <gwendal@google.com>
From: Gwendal Grignou <gwendal@chromium.org>
To: enric.balletbo@collabora.com,
	jic23@kernel.org,
	groeck@chromium.org
Cc: linux-iio@vger.kernel.org
Subject: [PATCH 0/3] Add ALS and barometer driver to ChromesOS EC sensor hub
Date: Thu,  4 Jan 2018 12:17:15 -0800
Message-Id: <20180104201718.221900-1-gwendal@chromium.org>
List-ID: <linux-iio@vger.kernel.org>

This patchset adds 2 drivers for supporting barometer, light and proximity
sensors when connected behind the Embedded Controller in a ChromeBook.

Gwendal Grignou (3):
  iio: cros_ec: light code cleanup
  iio: cros_ec: Add EC driver for Light and Proximity
  iio: cros_ec: add barometer driver

 drivers/iio/common/cros_ec_sensors/Kconfig         |  16 ++
 drivers/iio/common/cros_ec_sensors/Makefile        |   2 +
 drivers/iio/common/cros_ec_sensors/cros_ec_baro.c  | 222 +++++++++++++++++
 .../common/cros_ec_sensors/cros_ec_light_prox.c    | 269 +++++++++++++++++++++
 .../iio/common/cros_ec_sensors/cros_ec_sensors.c   |   5 +-
 .../common/cros_ec_sensors/cros_ec_sensors_core.c  |   7 +-
 6 files changed, 514 insertions(+), 7 deletions(-)
 create mode 100644 drivers/iio/common/cros_ec_sensors/cros_ec_baro.c
 create mode 100644 drivers/iio/common/cros_ec_sensors/cros_ec_light_prox.c

-- 
2.16.0.rc0.223.g4a4ac83678-goog
