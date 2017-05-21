Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:55063 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752119AbdEUUes (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 21 May 2017 16:34:48 -0400
From: Wolfram Sang <wsa@the-dreams.de>
To: linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa@the-dreams.de>, Dirk Eibach <eibach@gdsys.de>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: [PATCH 1/5] hwmon: ads1015: move header file out of I2C realm
Date: Sun, 21 May 2017 22:34:39 +0200
Message-Id: <20170521203443.6387-2-wsa@the-dreams.de>
In-Reply-To: <20170521203443.6387-1-wsa@the-dreams.de>
References: <20170521203443.6387-1-wsa@the-dreams.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

include/linux/i2c is not for client devices. Move the header file to a
more appropriate location.

Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
---
 Documentation/hwmon/ads1015                    | 2 +-
 MAINTAINERS                                    | 2 +-
 drivers/hwmon/ads1015.c                        | 2 +-
 drivers/iio/adc/ti-ads1015.c                   | 2 +-
 include/linux/{i2c => platform_data}/ads1015.h | 0
 5 files changed, 4 insertions(+), 4 deletions(-)
 rename include/linux/{i2c => platform_data}/ads1015.h (100%)

diff --git a/Documentation/hwmon/ads1015 b/Documentation/hwmon/ads1015
index 063b80d857b1f8..02d2a459385f39 100644
--- a/Documentation/hwmon/ads1015
+++ b/Documentation/hwmon/ads1015
@@ -40,7 +40,7 @@ By default all inputs are exported.
 Platform Data
 -------------
 
-In linux/i2c/ads1015.h platform data is defined, channel_data contains
+In linux/platform_data/ads1015.h platform data is defined, channel_data contains
 configuration data for the used input combinations:
 - pga is the programmable gain amplifier (values are full scale)
   0: +/- 6.144 V
diff --git a/MAINTAINERS b/MAINTAINERS
index 9e984645c4b08b..33541336258e77 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -478,7 +478,7 @@ L:	linux-hwmon@vger.kernel.org
 S:	Maintained
 F:	Documentation/hwmon/ads1015
 F:	drivers/hwmon/ads1015.c
-F:	include/linux/i2c/ads1015.h
+F:	include/linux/platform_data/ads1015.h
 
 ADT746X FAN DRIVER
 M:	Colin Leroy <colin@colino.net>
diff --git a/drivers/hwmon/ads1015.c b/drivers/hwmon/ads1015.c
index 5140c27d16dd03..357b4260716404 100644
--- a/drivers/hwmon/ads1015.c
+++ b/drivers/hwmon/ads1015.c
@@ -34,7 +34,7 @@
 #include <linux/of_device.h>
 #include <linux/of.h>
 
-#include <linux/i2c/ads1015.h>
+#include <linux/platform_data/ads1015.h>
 
 /* ADS1015 registers */
 enum {
diff --git a/drivers/iio/adc/ti-ads1015.c b/drivers/iio/adc/ti-ads1015.c
index f76d979fb7e86e..884b8e461b1755 100644
--- a/drivers/iio/adc/ti-ads1015.c
+++ b/drivers/iio/adc/ti-ads1015.c
@@ -23,7 +23,7 @@
 #include <linux/mutex.h>
 #include <linux/delay.h>
 
-#include <linux/i2c/ads1015.h>
+#include <linux/platform_data/ads1015.h>
 
 #include <linux/iio/iio.h>
 #include <linux/iio/types.h>
diff --git a/include/linux/i2c/ads1015.h b/include/linux/platform_data/ads1015.h
similarity index 100%
rename from include/linux/i2c/ads1015.h
rename to include/linux/platform_data/ads1015.h
-- 
2.11.0

