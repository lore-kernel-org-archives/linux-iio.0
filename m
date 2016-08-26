Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.187]:50818 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751711AbcHZPaX (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 26 Aug 2016 11:30:23 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] iio: hid-sensors: avoid unused function warning
Date: Fri, 26 Aug 2016 17:29:35 +0200
Message-Id: <20160826152956.666025-1-arnd@arndb.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

A small rework of the PM code in this driver introduced a harmless
warning when CONFIG_PM_SLEEP is not set:

drivers/iio/common/hid-sensors/hid-sensor-trigger.c:212:12: error: 'hid_sensor_resume' defined but not used [-Werror=unused-function]

This removes the #ifdef and instead marks all three PM functions
as __maybe_unused, which covers all possible cases and is harder
to get wrong.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: 7f6cf7414538 ("iio: hid-sensors: use asynchronous resume")
---
 drivers/iio/common/hid-sensors/hid-sensor-trigger.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/common/hid-sensors/hid-sensor-trigger.c b/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
index 5264ed6e03e5..a3cce3a38300 100644
--- a/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
+++ b/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
@@ -199,8 +199,7 @@ error_ret:
 }
 EXPORT_SYMBOL(hid_sensor_setup_trigger);
 
-#ifdef CONFIG_PM
-static int hid_sensor_suspend(struct device *dev)
+static int __maybe_unused hid_sensor_suspend(struct device *dev)
 {
 	struct platform_device *pdev = to_platform_device(dev);
 	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
@@ -209,7 +208,7 @@ static int hid_sensor_suspend(struct device *dev)
 	return _hid_sensor_power_state(attrb, false);
 }
 
-static int hid_sensor_resume(struct device *dev)
+static int __maybe_unused hid_sensor_resume(struct device *dev)
 {
 	struct platform_device *pdev = to_platform_device(dev);
 	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
@@ -218,7 +217,7 @@ static int hid_sensor_resume(struct device *dev)
 	return 0;
 }
 
-static int hid_sensor_runtime_resume(struct device *dev)
+static int __maybe_unused hid_sensor_runtime_resume(struct device *dev)
 {
 	struct platform_device *pdev = to_platform_device(dev);
 	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
@@ -226,8 +225,6 @@ static int hid_sensor_runtime_resume(struct device *dev)
 	return _hid_sensor_power_state(attrb, true);
 }
 
-#endif
-
 const struct dev_pm_ops hid_sensor_pm_ops = {
 	SET_SYSTEM_SLEEP_PM_OPS(hid_sensor_suspend, hid_sensor_resume)
 	SET_RUNTIME_PM_OPS(hid_sensor_suspend,
-- 
2.9.0

