Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:55055 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751583AbdEUUes (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 21 May 2017 16:34:48 -0400
From: Wolfram Sang <wsa@the-dreams.de>
To: linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-doc@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/5] hwmon: move include files out of include/linux/i2c
Date: Sun, 21 May 2017 22:34:38 +0200
Message-Id: <20170521203443.6387-1-wsa@the-dreams.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

It doesn't make sense to use include/linux/i2c for client drivers which may in
fact rather be hwmon or input or whatever devices. As a result, I want to
deprecate include/linux/i2c for good. This series moves the include files to a
better location, largely include/platform_data because that is what most of the
moved include files contain. Note that some files don't seem to have upstream
users in board code, so they maybe could even be removed? I didn't check for
that now, but I did it for one i2c master driver recently. So, it may be
possible. pmbus.h got moved just one layer upwards, see the patch description
there.

I prefer the series to go upstream via the subsystem tree; if you prefer that I
take it via I2C, just let me know.

No runtime testing because of no HW, but buildbot is happy with this series at
least. A branch can be found here:

git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/platform_data

Thanks and kind regards,

   Wolfram


Wolfram Sang (5):
  hwmon: ads1015: move header file out of I2C realm
  hwmon: ds620: move header file out of I2C realm
  hwmon: ltc4245: move header file out of I2C realm
  hwmon: max6639: move header file out of I2C realm
  hwmon: pmbus: move header file out of I2C realm

 Documentation/hwmon/ads1015                    | 2 +-
 Documentation/hwmon/ltc4245                    | 2 +-
 Documentation/hwmon/pmbus-core                 | 2 +-
 MAINTAINERS                                    | 4 ++--
 drivers/hwmon/ads1015.c                        | 2 +-
 drivers/hwmon/ds620.c                          | 2 +-
 drivers/hwmon/ltc4245.c                        | 2 +-
 drivers/hwmon/max6639.c                        | 2 +-
 drivers/hwmon/pmbus/pmbus.c                    | 2 +-
 drivers/hwmon/pmbus/pmbus_core.c               | 2 +-
 drivers/hwmon/pmbus/ucd9000.c                  | 2 +-
 drivers/hwmon/pmbus/ucd9200.c                  | 2 +-
 drivers/iio/adc/ti-ads1015.c                   | 2 +-
 include/linux/{i2c => platform_data}/ads1015.h | 0
 include/linux/{i2c => platform_data}/ds620.h   | 0
 include/linux/{i2c => platform_data}/ltc4245.h | 0
 include/linux/{i2c => platform_data}/max6639.h | 0
 include/linux/{i2c => }/pmbus.h                | 0
 18 files changed, 14 insertions(+), 14 deletions(-)
 rename include/linux/{i2c => platform_data}/ads1015.h (100%)
 rename include/linux/{i2c => platform_data}/ds620.h (100%)
 rename include/linux/{i2c => platform_data}/ltc4245.h (100%)
 rename include/linux/{i2c => platform_data}/max6639.h (100%)
 rename include/linux/{i2c => }/pmbus.h (100%)

-- 
2.11.0

