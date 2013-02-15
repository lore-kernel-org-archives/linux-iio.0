Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-045.synserver.de ([212.40.185.45]:1074 "EHLO
	smtp-out-045.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755615Ab3BOQ4C (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 15 Feb 2013 11:56:02 -0500
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jean Delvare <khali@linux-fr.org>,
	Guenter Roeck <linux@roeck-us.net>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
	Jonathan Cameron <jic23@cam.ac.uk>, lm-sensors@lm-sensors.org,
	linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 2/9] hwmon: (adt7410) Let suspend/resume depend on CONFIG_PM_SLEEP
Date: Fri, 15 Feb 2013 17:57:11 +0100
Message-Id: <1360947438-2550-2-git-send-email-lars@metafoo.de>
In-Reply-To: <1360947438-2550-1-git-send-email-lars@metafoo.de>
References: <1360947438-2550-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Only build the suspend/resume code if CONFIG_PM_SLEEP is selected. Currently the
code is built if CONFIG_PM is selected, but it will also be selected if only
runtime PM support is built into the kernel.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/hwmon/adt7410.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/adt7410.c b/drivers/hwmon/adt7410.c
index 4ccee4f..ae80815 100644
--- a/drivers/hwmon/adt7410.c
+++ b/drivers/hwmon/adt7410.c
@@ -415,7 +415,7 @@ static const struct i2c_device_id adt7410_ids[] = {
 };
 MODULE_DEVICE_TABLE(i2c, adt7410_ids);
 
-#ifdef CONFIG_PM
+#ifdef CONFIG_PM_SLEEP
 static int adt7410_suspend(struct device *dev)
 {
 	int ret;
-- 
1.8.0

