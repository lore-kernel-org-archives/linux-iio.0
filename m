Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([46.235.227.227]:55282 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750753AbdKJV4L (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 10 Nov 2017 16:56:11 -0500
From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
To: Lee Jones <lee.jones@linaro.org>, bleung@chromium.org
Cc: Guenter Roeck <groeck@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        rtc-linux@googlegroups.com
Subject: [PATCH v4 0/2] Add support for cros-ec-rtc driver.
Date: Fri, 10 Nov 2017 22:55:51 +0100
Message-Id: <20171110215553.20696-1-enric.balletbo@collabora.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Dear all,

This is an attempt to revive some patches from that [1] patchset, some
of them are still under discussion but I think there is no reason to not
have the other two in this fourth version to land upstream meanwhile we
discuss about the others.

[1] https://lkml.org/lkml/2017/7/12/182

Changes since v3:
* Rebased an retested with current mainline using a Samsung Chromebook Plus
* Removed from patchset
  * 1/4 mfd: cros_ec: Get rid of cros_ec_check_features from cros_ec_dev.
  * 4/4 mfd: cros_ec: add RTC as mfd subdevice.

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

Best regards,

 Enric

Stephen Barber (2):
  mfd: cros_ec: Introduce RTC commands and events definitions.
  rtc: cros-ec: add cros-ec-rtc driver.

 drivers/rtc/Kconfig                  |  10 +
 drivers/rtc/Makefile                 |   1 +
 drivers/rtc/rtc-cros-ec.c            | 413 +++++++++++++++++++++++++++++++++++
 include/linux/mfd/cros_ec_commands.h |   8 +
 4 files changed, 432 insertions(+)
 create mode 100644 drivers/rtc/rtc-cros-ec.c

-- 
2.9.3

