Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:42946 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750932AbcGQFa7 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 17 Jul 2016 01:30:59 -0400
From: Guenter Roeck <linux@roeck-us.net>
To: Jean Delvare <jdelvare@suse.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Eduardo Valentin <edubezval@gmail.com>,
	Punit Agrawal <punit.agrawal@arm.com>,
	linux-pm@vger.kernel.org, linux-iio@vger.kernel.org,
	linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v2 1/9] hwmon: (core) Order include files alphabetically
Date: Sat, 16 Jul 2016 22:30:24 -0700
Message-Id: <1468733432-15730-2-git-send-email-linux@roeck-us.net>
In-Reply-To: <1468733432-15730-1-git-send-email-linux@roeck-us.net>
References: <1468733432-15730-1-git-send-email-linux@roeck-us.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Ordering include files alphabetically makes it easier to add new ones.
Stop including linux/spinlock.h and linux/kdev_t.h since both are not
needed.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v2: Added patch

 drivers/hwmon/hwmon.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/hwmon/hwmon.c b/drivers/hwmon/hwmon.c
index a26c385a435b..649a68d119b4 100644
--- a/drivers/hwmon/hwmon.c
+++ b/drivers/hwmon/hwmon.c
@@ -12,16 +12,14 @@
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
-#include <linux/module.h>
 #include <linux/device.h>
 #include <linux/err.h>
-#include <linux/slab.h>
-#include <linux/kdev_t.h>
-#include <linux/idr.h>
-#include <linux/hwmon.h>
 #include <linux/gfp.h>
-#include <linux/spinlock.h>
+#include <linux/hwmon.h>
+#include <linux/idr.h>
+#include <linux/module.h>
 #include <linux/pci.h>
+#include <linux/slab.h>
 #include <linux/string.h>
 
 #define HWMON_ID_PREFIX "hwmon"
-- 
2.5.0

