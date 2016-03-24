Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:45777 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753065AbcCXJIn (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Thu, 24 Mar 2016 05:08:43 -0400
From: Irina Tirdea <irina.tirdea@intel.com>
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Irina Tirdea <irina.tirdea@intel.com>
Subject: [PATCH 1/1] iio: remove unused gpio consumer.h include
Date: Thu, 24 Mar 2016 11:08:38 +0200
Message-Id: <1458810518-24459-1-git-send-email-irina.tirdea@intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

GPIO handling code has been removed from the drivers (since
this is now handled by the ACPI core) in commit 0f0796509c07 ("iio:
remove gpio interrupt probing from drivers that use a single interrupt").

Remove the include for linux/gpio/consumer.h since it is no longer
used.

Signed-off-by: Irina Tirdea <irina.tirdea@intel.com>
---
 drivers/iio/accel/bmc150-accel-core.c  | 1 -
 drivers/iio/accel/kxcjk-1013.c         | 1 -
 drivers/iio/accel/mma9553.c            | 1 -
 drivers/iio/accel/stk8312.c            | 1 -
 drivers/iio/accel/stk8ba50.c           | 1 -
 drivers/iio/imu/kmx61.c                | 1 -
 drivers/iio/light/stk3310.c            | 1 -
 drivers/iio/magnetometer/bmc150_magn.c | 1 -
 8 files changed, 8 deletions(-)

diff --git a/drivers/iio/accel/bmc150-accel-core.c b/drivers/iio/accel/bmc150-accel-core.c
index feff894..65966e5 100644
--- a/drivers/iio/accel/bmc150-accel-core.c
+++ b/drivers/iio/accel/bmc150-accel-core.c
@@ -25,7 +25,6 @@
 #include <linux/delay.h>
 #include <linux/slab.h>
 #include <linux/acpi.h>
-#include <linux/gpio/consumer.h>
 #include <linux/pm.h>
 #include <linux/pm_runtime.h>
 #include <linux/iio/iio.h>
diff --git a/drivers/iio/accel/kxcjk-1013.c b/drivers/iio/accel/kxcjk-1013.c
index edec1d0..47305dc 100644
--- a/drivers/iio/accel/kxcjk-1013.c
+++ b/drivers/iio/accel/kxcjk-1013.c
@@ -20,7 +20,6 @@
 #include <linux/slab.h>
 #include <linux/string.h>
 #include <linux/acpi.h>
-#include <linux/gpio/consumer.h>
 #include <linux/pm.h>
 #include <linux/pm_runtime.h>
 #include <linux/iio/iio.h>
diff --git a/drivers/iio/accel/mma9553.c b/drivers/iio/accel/mma9553.c
index fa7d362..bb05f3e 100644
--- a/drivers/iio/accel/mma9553.c
+++ b/drivers/iio/accel/mma9553.c
@@ -17,7 +17,6 @@
 #include <linux/interrupt.h>
 #include <linux/slab.h>
 #include <linux/acpi.h>
-#include <linux/gpio/consumer.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
 #include <linux/iio/events.h>
diff --git a/drivers/iio/accel/stk8312.c b/drivers/iio/accel/stk8312.c
index 85fe7f7..e31023d 100644
--- a/drivers/iio/accel/stk8312.c
+++ b/drivers/iio/accel/stk8312.c
@@ -11,7 +11,6 @@
  */
 
 #include <linux/acpi.h>
-#include <linux/gpio/consumer.h>
 #include <linux/i2c.h>
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
diff --git a/drivers/iio/accel/stk8ba50.c b/drivers/iio/accel/stk8ba50.c
index 5709d9e..300d955 100644
--- a/drivers/iio/accel/stk8ba50.c
+++ b/drivers/iio/accel/stk8ba50.c
@@ -11,7 +11,6 @@
  */
 
 #include <linux/acpi.h>
-#include <linux/gpio/consumer.h>
 #include <linux/i2c.h>
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
diff --git a/drivers/iio/imu/kmx61.c b/drivers/iio/imu/kmx61.c
index e5306b4..2e7dd57 100644
--- a/drivers/iio/imu/kmx61.c
+++ b/drivers/iio/imu/kmx61.c
@@ -14,7 +14,6 @@
 #include <linux/module.h>
 #include <linux/i2c.h>
 #include <linux/acpi.h>
-#include <linux/gpio/consumer.h>
 #include <linux/interrupt.h>
 #include <linux/pm.h>
 #include <linux/pm_runtime.h>
diff --git a/drivers/iio/light/stk3310.c b/drivers/iio/light/stk3310.c
index 42d334b..9e847f8 100644
--- a/drivers/iio/light/stk3310.c
+++ b/drivers/iio/light/stk3310.c
@@ -16,7 +16,6 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/regmap.h>
-#include <linux/gpio/consumer.h>
 #include <linux/iio/events.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
diff --git a/drivers/iio/magnetometer/bmc150_magn.c b/drivers/iio/magnetometer/bmc150_magn.c
index ffcb75e..0e9da18 100644
--- a/drivers/iio/magnetometer/bmc150_magn.c
+++ b/drivers/iio/magnetometer/bmc150_magn.c
@@ -23,7 +23,6 @@
 #include <linux/delay.h>
 #include <linux/slab.h>
 #include <linux/acpi.h>
-#include <linux/gpio/consumer.h>
 #include <linux/pm.h>
 #include <linux/pm_runtime.h>
 #include <linux/iio/iio.h>
-- 
1.9.1

