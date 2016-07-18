Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([46.235.227.227]:48137 "EHLO
	bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751016AbcGRHDL (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 18 Jul 2016 03:03:11 -0400
From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
To: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Cc: Olof Johansson <olof@lixom.net>, Lee Jones <lee.jones@linaro.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Guenter Roeck <groeck@chromium.org>,
	Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH 00/10] Add support for cros-ec-sensors
Date: Mon, 18 Jul 2016 09:02:40 +0200
Message-Id: <1468825370-20075-1-git-send-email-enric.balletbo@collabora.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi,

This is the first patchset to add support for the sensors behind the ChromeOS
Embedded Controller. The first two patches needs to reviewed  by Lee Jones
as are MFD related, then there are six IIO patches for Jonathan Cameron and
finally the last two patches are platform/chrome specific so are for Olof.

The code was checked out from the ChromeOS v3.18 tree and forward ported to
mainline solving all the conflicts and build issues. I splitted the code in
single patches that have sense by themselves in order to avoid the chances
to fail.

Note that the patches depends on this [1] to apply and work.

[1] https://lkml.org/lkml/2016/7/1/188

Waiting for your reviews and feedback.

Best regards,

Enric Balletbo i Serra (8):
  mfd: cros_ec: add ChromeOS EC sensor platform information.
  mfd: cros_ec: update MOTIONSENSE definitions and commands.
  iio: cros_ec: Add common functions for cros_ec sensors.
  iio: cros_ec_sensors: add ChromeOS EC Contiguous Sensors driver
  iio: cros_ec_light_prox: add ChromeOS EC Light and Proximity Sensors
  iio: cros_ec_activity: add ChromeOS EC Activity Sensors
  iio: cros_ec_sensors_ring: add ChromeOS EC Sensors Ring
  platform/chrome: cros_ec_dev - Register cros-ec sensors

Gwendal Grignou (1):
  iio: core: Add double tap as possible gesture

Vincent Palatin (1):
  platform/chrome: Introduce a new function to check EC features.

 drivers/iio/common/Kconfig                         |   1 +
 drivers/iio/common/Makefile                        |   1 +
 drivers/iio/common/cros_ec_sensors/Kconfig         |  50 ++
 drivers/iio/common/cros_ec_sensors/Makefile        |   9 +
 .../iio/common/cros_ec_sensors/cros_ec_activity.c  | 294 +++++++++++
 .../common/cros_ec_sensors/cros_ec_light_prox.c    | 288 +++++++++++
 .../iio/common/cros_ec_sensors/cros_ec_sensors.c   | 322 ++++++++++++
 .../common/cros_ec_sensors/cros_ec_sensors_core.c  | 564 +++++++++++++++++++++
 .../common/cros_ec_sensors/cros_ec_sensors_core.h  | 155 ++++++
 .../common/cros_ec_sensors/cros_ec_sensors_ring.c  | 541 ++++++++++++++++++++
 drivers/iio/industrialio-core.c                    |   1 +
 drivers/platform/chrome/cros_ec_dev.c              | 159 ++++++
 include/linux/mfd/cros_ec.h                        |  11 +
 include/linux/mfd/cros_ec_commands.h               | 344 +++++++++++--
 include/uapi/linux/iio/types.h                     |   1 +
 15 files changed, 2712 insertions(+), 29 deletions(-)
 create mode 100644 drivers/iio/common/cros_ec_sensors/Kconfig
 create mode 100644 drivers/iio/common/cros_ec_sensors/Makefile
 create mode 100644 drivers/iio/common/cros_ec_sensors/cros_ec_activity.c
 create mode 100644 drivers/iio/common/cros_ec_sensors/cros_ec_light_prox.c
 create mode 100644 drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c
 create mode 100644 drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
 create mode 100644 drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.h
 create mode 100644 drivers/iio/common/cros_ec_sensors/cros_ec_sensors_ring.c

-- 
2.1.0

