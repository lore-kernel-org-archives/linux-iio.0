Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([46.235.227.227]:47117 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751215AbdGLKN1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 12 Jul 2017 06:13:27 -0400
From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
To: Jonathan Cameron <jic23@kernel.org>,
        Lee Jones <lee.jones@linaro.org>, bleung@chromium.org
Cc: martinez.javier@gmail.com, Guenter Roeck <groeck@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        rtc-linux@googlegroups.com
Subject: [PATCH v3 0/4] mfd: cros-ec: Some fixes and improvements.
Date: Wed, 12 Jul 2017 12:13:05 +0200
Message-Id: <20170712101309.6045-1-enric.balletbo@collabora.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Dear all,

Basically this is a resend and rebase due that [2] and [3] are currently
merged so all dependecies are in mainline now.

To remmember:

* 1/4 mfd: cros_ec: Get rid of cros_ec_check_features from cros_ec_dev.

As pointed by Lee Jones in this thread [1] we should not use the MFD API
outside of MFD. For this reason the cros-ec-rtc did not get accepted yet.
The reality is that we are calling mfd_add_devices from cros-ec-dev driver
already, so this patch get rid off the MFD calls inside the chardev driver
and moves to cros-ec MFD. Also I think the chardev device should simply
implement the ioctl calls to access to it from userspace.

The above patch involves MFD, IIO and platform chrome subsystems.

* 2/4 mfd: cros_ec: Introduce RTC commands and events definitions
* 3/4 rtc: cros-ec: add cros-ec-rtc driver
* 4/4 mfd: cros_ec: add RTC as mfd subdevice

These patches are the cros-ec RTC driver, 3 and 4 patches are already
acked by the subsystem maintainers involved and are equal to the last
version I send. Patch 5 registers the rtc cell inside the cros-ec MFD
intead of cros-ec-dev chardev driver.

Changes since v2:
- Rebase on top of mainline.
- Removed patch 'mfd: cros-ec: Fix host command buffer size' from series
as was already picked.

Changes since v1:
- Removed patch 'iio: cros_ec_sensors: Fix return value to get raw and
calibbias data' from series as was already picked.
- Removed patch 'iio: cros_ec_sensors: Fix return value to get raw and
calibbias data' from series as was already picked.
- Patch 2/5: Acked-by: Jonathan Cameron <***@kernel.org>

[1] https://www.spinics.net/lists/kernel/msg2465099.html
[2] https://lkml.org/lkml/2017/3/17/319
[3] https://lkml.org/lkml/2017/3/17/321

Best regards,

Enric Balletbo i Serra (1):
  mfd: cros_ec: Get rid of cros_ec_check_features from cros_ec_dev.

Stephen Barber (3):
  mfd: cros_ec: Introduce RTC commands and events definitions.
  rtc: cros-ec: add cros-ec-rtc driver.
  mfd: cros_ec: add RTC as mfd subdevice

 .../iio/common/cros_ec_sensors/cros_ec_sensors.c   |   8 -
 .../common/cros_ec_sensors/cros_ec_sensors_core.c  |   8 +-
 drivers/iio/light/cros_ec_light_prox.c             |   8 -
 drivers/iio/pressure/cros_ec_baro.c                |   8 -
 drivers/mfd/cros_ec.c                              | 178 +++++++++
 drivers/platform/chrome/cros_ec_dev.c              | 161 --------
 drivers/rtc/Kconfig                                |  10 +
 drivers/rtc/Makefile                               |   1 +
 drivers/rtc/rtc-cros-ec.c                          | 412 +++++++++++++++++++++
 include/linux/mfd/cros_ec.h                        |   6 +-
 include/linux/mfd/cros_ec_commands.h               |   8 +
 11 files changed, 619 insertions(+), 189 deletions(-)
 create mode 100644 drivers/rtc/rtc-cros-ec.c

-- 
2.9.3

