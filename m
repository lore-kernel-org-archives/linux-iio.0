Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.24]:62040 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753029AbcHZPcI (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 26 Aug 2016 11:32:08 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] iio: magn/ak8974: avoid unused function warning
Date: Fri, 26 Aug 2016 17:31:19 +0200
Message-Id: <20160826153137.701672-1-arnd@arndb.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The ak8974_configure() function is used only from the PM code,
but that can be hidden when CONFIG_PM is disabled:

drivers/iio/magnetometer/ak8974.c:201:12: error: 'ak8974_configure' defined but not used [-Werror=unused-function]

This replaces the #ifdef with a __maybe_unused annotation, which
will work correctly in all configurations and avoid the warning,
as the compiler can now see where ak8974_configure is called from.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: 7c94a8b2ee8c ("iio: magn: add a driver for AK8974")
---
 drivers/iio/magnetometer/ak8974.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/magnetometer/ak8974.c b/drivers/iio/magnetometer/ak8974.c
index e70e4e22b72c..12bd17b4cf58 100644
--- a/drivers/iio/magnetometer/ak8974.c
+++ b/drivers/iio/magnetometer/ak8974.c
@@ -783,8 +783,7 @@ static int __exit ak8974_remove(struct i2c_client *i2c)
 	return 0;
 }
 
-#ifdef CONFIG_PM
-static int ak8974_runtime_suspend(struct device *dev)
+static int __maybe_unused ak8974_runtime_suspend(struct device *dev)
 {
 	struct ak8974 *ak8974 =
 		iio_priv(i2c_get_clientdata(to_i2c_client(dev)));
@@ -795,7 +794,7 @@ static int ak8974_runtime_suspend(struct device *dev)
 	return 0;
 }
 
-static int ak8974_runtime_resume(struct device *dev)
+static int __maybe_unused ak8974_runtime_resume(struct device *dev)
 {
 	struct ak8974 *ak8974 =
 		iio_priv(i2c_get_clientdata(to_i2c_client(dev)));
@@ -822,7 +821,6 @@ out_regulator_disable:
 
 	return ret;
 }
-#endif /* CONFIG_PM */
 
 static const struct dev_pm_ops ak8974_dev_pm_ops = {
 	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
-- 
2.9.0

