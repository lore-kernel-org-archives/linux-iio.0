Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([46.235.227.227]:48465 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752901AbdHKOXM (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 11 Aug 2017 10:23:12 -0400
From: Thierry Escande <thierry.escande@collabora.com>
To: Benson Leung <bleung@chromium.org>,
        Lee Jones <lee.jones@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>
Cc: Joseph Lo <josephl@nvidia.com>,
        Gwendal Grignou <gwendal@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Daniel Hung-yu Wu <hywu@google.com>,
        Vincent Palatin <vpalatin@chromium.org>,
        Wei-Ning Huang <wnhuang@google.com>,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: [PATCH v2 0/8] platform/chrome: cros_ec: Fixes and improvements
Date: Fri, 11 Aug 2017 16:22:57 +0200
Message-Id: <1502461385-27564-1-git-send-email-thierry.escande@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset = "utf-8"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi,

This series contains various fixes and improvements for the ChromeOS
Embedded Controller drivers. These concern PM suspend/resume fixes,
sysfs interface, and module initialization.

Regards,
 Thierry

v2 changes:
- Restore original changes from ChromeOS kernel tree (a function is
  added in patch #7 and then modified in patch #8). This keeps the
  changes as closed to the originals as possible.
- Replace a uint16_t declaration with u16.

Daniel Hung-yu Wu (1):
  platform/chrome: cros_ec: register shutdown function for debugfs

Douglas Anderson (1):
  mfd: cros_ec: Stop the debugfs work when suspended

Gwendal Grignou (3):
  iio: cros_ec: Relax sampling frequency before suspending
  platform/chrome: cros_ec: Add sysfs entry to set keyboard wake lid
    angle
  platform/chrome: cros_ec: sysfs: Modify error handling

Joseph Lo (1):
  mfd: cros_ec_i2c: move the system sleep pm ops to late

Vincent Palatin (1):
  mfd: cros_ec: fail early if we cannot identify the EC

Wei-Ning Huang (1):
  mfd: cros_ec_i2c: add ACPI module device table

 .../iio/common/cros_ec_sensors/cros_ec_sensors.c   |   1 +
 .../common/cros_ec_sensors/cros_ec_sensors_core.c  |  49 ++++++++++
 .../common/cros_ec_sensors/cros_ec_sensors_core.h  |   2 +
 drivers/iio/light/cros_ec_light_prox.c             |   1 +
 drivers/mfd/cros_ec.c                              |   6 +-
 drivers/mfd/cros_ec_i2c.c                          |  17 +++-
 drivers/platform/chrome/cros_ec_debugfs.c          |  18 ++++
 drivers/platform/chrome/cros_ec_debugfs.h          |   2 +
 drivers/platform/chrome/cros_ec_dev.c              |  45 +++++----
 drivers/platform/chrome/cros_ec_sysfs.c            | 105 ++++++++++++++++-----
 include/linux/mfd/cros_ec.h                        |   1 +
 11 files changed, 204 insertions(+), 43 deletions(-)

-- 
2.7.4

