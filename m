Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-qk0-f174.google.com ([209.85.220.174]:36424 "EHLO
	mail-qk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753745AbcHPNet (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 16 Aug 2016 09:34:49 -0400
Received: by mail-qk0-f174.google.com with SMTP id l2so70474999qkf.3
        for <linux-iio@vger.kernel.org>; Tue, 16 Aug 2016 06:34:49 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 14/17] iio: accel: kxsd9: Fetch and handle regulators
Date: Tue, 16 Aug 2016 15:33:40 +0200
Message-Id: <1471354423-19186-15-git-send-email-linus.walleij@linaro.org>
In-Reply-To: <1471354423-19186-1-git-send-email-linus.walleij@linaro.org>
References: <1471354423-19186-1-git-send-email-linus.walleij@linaro.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This adds supply regulator handling for the VDD and IOVDD inputs
on the KXSD9 component, makes sure to bring the regulators online
during probe and disable them on remove or the errorpath.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/iio/accel/kxsd9.c | 88 +++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 85 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/accel/kxsd9.c b/drivers/iio/accel/kxsd9.c
index 93be5e1f8968..e169f40311af 100644
--- a/drivers/iio/accel/kxsd9.c
+++ b/drivers/iio/accel/kxsd9.c
@@ -21,6 +21,8 @@
 #include <linux/module.h>
 #include <linux/regmap.h>
 #include <linux/bitops.h>
+#include <linux/delay.h>
+#include <linux/regulator/consumer.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
 #include <linux/iio/buffer.h>
@@ -65,10 +67,12 @@
  * struct kxsd9_state - device related storage
  * @dev: pointer to the parent device
  * @map: regmap to the device
+ * @regs: regulators for this device, VDD and IOVDD
  */
 struct kxsd9_state {
 	struct device *dev;
 	struct regmap *map;
+	struct regulator_bulk_data regs[2];
 };
 
 #define KXSD9_SCALE_2G "0.011978"
@@ -81,6 +85,12 @@ static const int kxsd9_micro_scales[4] = { 47853, 35934, 23927, 11978 };
 
 #define KXSD9_ZERO_G_OFFSET -2048
 
+/*
+ * Regulator names
+ */
+static const char kxsd9_reg_vdd[] = "vdd";
+static const char kxsd9_reg_iovdd[] = "iovdd";
+
 static int kxsd9_write_scale(struct iio_dev *indio_dev, int micro)
 {
 	int ret, i;
@@ -252,12 +262,69 @@ static int kxsd9_power_up(struct kxsd9_state *st)
 {
 	int ret;
 
-	ret = regmap_write(st->map, KXSD9_REG_CTRL_B, 0x40);
+	/* Enable the regulators */
+	ret = regulator_bulk_enable(ARRAY_SIZE(st->regs), st->regs);
+	if (ret) {
+		dev_err(st->dev, "Cannot enable regulators\n");
+		return ret;
+	}
+
+	/* Power up */
+	ret = regmap_write(st->map,
+			   KXSD9_REG_CTRL_B,
+			   KXSD9_CTRL_B_ENABLE);
 	if (ret)
 		return ret;
-	return regmap_write(st->map, KXSD9_REG_CTRL_C, 0x9b);
+
+	/*
+	 * Set 1000Hz LPF, 2g fullscale, motion wakeup threshold 1g,
+	 * latched wakeup
+	 */
+	ret = regmap_write(st->map,
+			   KXSD9_REG_CTRL_C,
+			   KXSD9_CTRL_C_LP_1000HZ |
+			   KXSD9_CTRL_C_MOT_LEV	|
+			   KXSD9_CTRL_C_MOT_LAT |
+			   KXSD9_CTRL_C_FS_2G);
+	if (ret)
+		return ret;
+
+	/*
+	 * Power-up time depends on the LPF setting, but typ 15.9 ms, let's
+	 * set 20 ms to allow for some slack.
+	 */
+	msleep(20);
+
+	return 0;
 };
 
+static int kxsd9_power_down(struct kxsd9_state *st)
+{
+	int ret;
+
+	/*
+	 * Set into low power mode - since there may be more users of the
+	 * regulators this is the first step of the power saving: it will
+	 * make sure we conserve power even if there are others users on the
+	 * regulators.
+	 */
+	ret = regmap_update_bits(st->map,
+				 KXSD9_REG_CTRL_B,
+				 KXSD9_CTRL_B_ENABLE,
+				 0);
+	if (ret)
+		return ret;
+
+	/* Disable the regulators */
+	ret = regulator_bulk_disable(ARRAY_SIZE(st->regs), st->regs);
+	if (ret) {
+		dev_err(st->dev, "Cannot disable regulators\n");
+		return ret;
+	}
+
+	return 0;
+}
+
 static const struct iio_info kxsd9_info = {
 	.read_raw = &kxsd9_read_raw,
 	.write_raw = &kxsd9_write_raw,
@@ -292,6 +359,17 @@ int kxsd9_common_probe(struct device *parent,
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->available_scan_masks = kxsd9_scan_masks;
 
+	/* Fetch and turn on regulators */
+	st->regs[0].supply = kxsd9_reg_vdd;
+	st->regs[1].supply = kxsd9_reg_iovdd;
+	ret = devm_regulator_bulk_get(parent,
+				      ARRAY_SIZE(st->regs),
+				      st->regs);
+	if (ret) {
+		dev_err(parent, "Cannot get regulators\n");
+		return ret;
+	}
+
 	kxsd9_power_up(st);
 
 	ret = iio_triggered_buffer_setup(indio_dev,
@@ -300,7 +378,7 @@ int kxsd9_common_probe(struct device *parent,
 					 NULL);
 	if (ret) {
 		dev_err(parent, "triggered buffer setup failed\n");
-		return ret;
+		goto err_power_down;
 	}
 
 	ret = devm_iio_device_register(parent, indio_dev);
@@ -313,6 +391,8 @@ int kxsd9_common_probe(struct device *parent,
 
 err_cleanup_buffer:
 	iio_triggered_buffer_cleanup(indio_dev);
+err_power_down:
+	kxsd9_power_down(st);
 
 	return ret;
 }
@@ -321,8 +401,10 @@ EXPORT_SYMBOL(kxsd9_common_probe);
 int kxsd9_common_remove(struct device *parent)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(parent);
+	struct kxsd9_state *st = iio_priv(indio_dev);
 
 	iio_triggered_buffer_cleanup(indio_dev);
+	kxsd9_power_down(st);
 
 	return 0;
 }
-- 
2.7.4

