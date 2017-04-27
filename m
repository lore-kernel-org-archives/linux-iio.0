Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([46.235.227.227]:50170 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754344AbdD0Pah (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 27 Apr 2017 11:30:37 -0400
From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
To: Sebastian Reichel <sre@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>
Cc: J Keerthy <j-keerthy@ti.com>, linux-iio@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: [PATCH 2/7] power: supply: avoid unused twl4030-madc.h
Date: Thu, 27 Apr 2017 17:30:07 +0200
Message-Id: <20170427153012.32310-3-sebastian.reichel@collabora.co.uk>
In-Reply-To: <20170427153012.32310-1-sebastian.reichel@collabora.co.uk>
References: <20170427153012.32310-1-sebastian.reichel@collabora.co.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Avoid inclusion of unused twl4030-madc.h. This
will allow twl4030-madc.h to be merged into the
iio driver.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
---
 drivers/power/supply/rx51_battery.c         | 1 -
 drivers/power/supply/twl4030_madc_battery.c | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/power/supply/rx51_battery.c b/drivers/power/supply/rx51_battery.c
index af9383d23d12..5654708b1279 100644
--- a/drivers/power/supply/rx51_battery.c
+++ b/drivers/power/supply/rx51_battery.c
@@ -23,7 +23,6 @@
 #include <linux/platform_device.h>
 #include <linux/power_supply.h>
 #include <linux/slab.h>
-#include <linux/i2c/twl4030-madc.h>
 #include <linux/iio/consumer.h>
 #include <linux/of.h>
 
diff --git a/drivers/power/supply/twl4030_madc_battery.c b/drivers/power/supply/twl4030_madc_battery.c
index f5817e422d64..4d41acb98576 100644
--- a/drivers/power/supply/twl4030_madc_battery.c
+++ b/drivers/power/supply/twl4030_madc_battery.c
@@ -17,7 +17,6 @@
 #include <linux/power_supply.h>
 #include <linux/slab.h>
 #include <linux/sort.h>
-#include <linux/i2c/twl4030-madc.h>
 #include <linux/power/twl4030_madc_battery.h>
 #include <linux/iio/consumer.h>
 
-- 
2.11.0

