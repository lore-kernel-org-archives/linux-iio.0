Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from onstation.org ([52.200.56.107]:49184 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S936397AbcJGAt6 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 6 Oct 2016 20:49:58 -0400
From: Brian Masney <masneyb@onstation.org>
To: jic23@kernel.org
Cc: gregkh@linuxfoundation.org, linux-iio@vger.kernel.org,
        devel@driverdev.osuosl.org
Subject: [PATCH 3/4] staging: iio: isl29018: rename Kconfig variable to match existing light drivers in mainline.
Date: Thu,  6 Oct 2016 20:48:36 -0400
Message-Id: <1475801317-29449-3-git-send-email-masneyb@onstation.org>
In-Reply-To: <1475801317-29449-1-git-send-email-masneyb@onstation.org>
References: <1475801317-29449-1-git-send-email-masneyb@onstation.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Rename CONFIG_SENSORS_ISL29018 to CONFIG_ISL29018 for consistency with
the other light drivers in mainline.

Signed-off-by: Brian Masney <masneyb@onstation.org>
---
 drivers/staging/iio/light/Kconfig  | 2 +-
 drivers/staging/iio/light/Makefile | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/iio/light/Kconfig b/drivers/staging/iio/light/Kconfig
index ca8d6e6..b0e2948 100644
--- a/drivers/staging/iio/light/Kconfig
+++ b/drivers/staging/iio/light/Kconfig
@@ -3,7 +3,7 @@
 #
 menu "Light sensors"
 
-config SENSORS_ISL29018
+config ISL29018
 	tristate "ISL 29018 light and proximity sensor"
 	depends on I2C
 	select REGMAP_I2C
diff --git a/drivers/staging/iio/light/Makefile b/drivers/staging/iio/light/Makefile
index 9960fdf..89d6b02 100644
--- a/drivers/staging/iio/light/Makefile
+++ b/drivers/staging/iio/light/Makefile
@@ -2,7 +2,7 @@
 # Makefile for industrial I/O Light sensors
 #
 
-obj-$(CONFIG_SENSORS_ISL29018)	+= isl29018.o
+obj-$(CONFIG_ISL29018)	+= isl29018.o
 obj-$(CONFIG_SENSORS_ISL29028)	+= isl29028.o
 obj-$(CONFIG_TSL2583)	+= tsl2583.o
 obj-$(CONFIG_TSL2x7x)	+= tsl2x7x_core.o
-- 
2.5.5

