Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36022 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754125AbdENPps (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 14 May 2017 11:45:48 -0400
Received: by mail-wm0-f67.google.com with SMTP id u65so22648036wmu.3
        for <linux-iio@vger.kernel.org>; Sun, 14 May 2017 08:45:47 -0700 (PDT)
From: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org, masneyb@onstation.org,
        lorenzo.bianconi@st.com
Subject: [PATCH v2] iio: humidity: hts221: add power management support
Date: Sun, 14 May 2017 17:45:44 +0200
Message-Id: <20170514154544.9603-1-lorenzo.bianconi@st.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Add system sleep power management support to hts221 driver

Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@st.com>
---
Changes since v1:
- substitute ifdef CONFIG_PM with __maybe_unused macro
---
 drivers/iio/humidity/hts221.h      |  3 +++
 drivers/iio/humidity/hts221_core.c | 54 +++++++++++++++++++++++++++++++++++---
 drivers/iio/humidity/hts221_i2c.c  |  1 +
 drivers/iio/humidity/hts221_spi.c  |  1 +
 4 files changed, 55 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/humidity/hts221.h b/drivers/iio/humidity/hts221.h
index c7154665512e..94510266e0a5 100644
--- a/drivers/iio/humidity/hts221.h
+++ b/drivers/iio/humidity/hts221.h
@@ -57,12 +57,15 @@ struct hts221_hw {
 
 	struct hts221_sensor sensors[HTS221_SENSOR_MAX];
 
+	bool enabled;
 	u8 odr;
 
 	const struct hts221_transfer_function *tf;
 	struct hts221_transfer_buffer tb;
 };
 
+extern const struct dev_pm_ops hts221_pm_ops;
+
 int hts221_config_drdy(struct hts221_hw *hw, bool enable);
 int hts221_probe(struct iio_dev *iio_dev);
 int hts221_power_on(struct hts221_hw *hw);
diff --git a/drivers/iio/humidity/hts221_core.c b/drivers/iio/humidity/hts221_core.c
index 3f3ef4a1a474..a56da3999e00 100644
--- a/drivers/iio/humidity/hts221_core.c
+++ b/drivers/iio/humidity/hts221_core.c
@@ -13,6 +13,7 @@
 #include <linux/device.h>
 #include <linux/iio/sysfs.h>
 #include <linux/delay.h>
+#include <linux/pm.h>
 #include <asm/unaligned.h>
 
 #include "hts221.h"
@@ -307,15 +308,30 @@ hts221_sysfs_temp_oversampling_avail(struct device *dev,
 
 int hts221_power_on(struct hts221_hw *hw)
 {
-	return hts221_update_odr(hw, hw->odr);
+	int err;
+
+	err = hts221_update_odr(hw, hw->odr);
+	if (err < 0)
+		return err;
+
+	hw->enabled = true;
+
+	return 0;
 }
 
 int hts221_power_off(struct hts221_hw *hw)
 {
-	u8 data[] = {0x00, 0x00};
+	__le16 data = 0;
+	int err;
 
-	return hw->tf->write(hw->dev, HTS221_REG_CNTRL1_ADDR, sizeof(data),
-			     data);
+	err = hw->tf->write(hw->dev, HTS221_REG_CNTRL1_ADDR, sizeof(data),
+			    (u8 *)&data);
+	if (err < 0)
+		return err;
+
+	hw->enabled = false;
+
+	return 0;
 }
 
 static int hts221_parse_temp_caldata(struct hts221_hw *hw)
@@ -682,6 +698,36 @@ int hts221_probe(struct iio_dev *iio_dev)
 }
 EXPORT_SYMBOL(hts221_probe);
 
+static int __maybe_unused hts221_suspend(struct device *dev)
+{
+	struct iio_dev *iio_dev = dev_get_drvdata(dev);
+	struct hts221_hw *hw = iio_priv(iio_dev);
+	__le16 data = 0;
+	int err;
+
+	err = hw->tf->write(hw->dev, HTS221_REG_CNTRL1_ADDR, sizeof(data),
+			    (u8 *)&data);
+
+	return err < 0 ? err : 0;
+}
+
+static int __maybe_unused hts221_resume(struct device *dev)
+{
+	struct iio_dev *iio_dev = dev_get_drvdata(dev);
+	struct hts221_hw *hw = iio_priv(iio_dev);
+	int err = 0;
+
+	if (hw->enabled)
+		err = hts221_update_odr(hw, hw->odr);
+
+	return err;
+}
+
+const struct dev_pm_ops hts221_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(hts221_suspend, hts221_resume)
+};
+EXPORT_SYMBOL(hts221_pm_ops);
+
 MODULE_AUTHOR("Lorenzo Bianconi <lorenzo.bianconi@st.com>");
 MODULE_DESCRIPTION("STMicroelectronics hts221 sensor driver");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/iio/humidity/hts221_i2c.c b/drivers/iio/humidity/hts221_i2c.c
index 8333c0296c0e..f38e4b7e0160 100644
--- a/drivers/iio/humidity/hts221_i2c.c
+++ b/drivers/iio/humidity/hts221_i2c.c
@@ -105,6 +105,7 @@ MODULE_DEVICE_TABLE(i2c, hts221_i2c_id_table);
 static struct i2c_driver hts221_driver = {
 	.driver = {
 		.name = "hts221_i2c",
+		.pm = &hts221_pm_ops,
 		.of_match_table = of_match_ptr(hts221_i2c_of_match),
 		.acpi_match_table = ACPI_PTR(hts221_acpi_match),
 	},
diff --git a/drivers/iio/humidity/hts221_spi.c b/drivers/iio/humidity/hts221_spi.c
index 70df5e7150c1..57cbc256771b 100644
--- a/drivers/iio/humidity/hts221_spi.c
+++ b/drivers/iio/humidity/hts221_spi.c
@@ -113,6 +113,7 @@ MODULE_DEVICE_TABLE(spi, hts221_spi_id_table);
 static struct spi_driver hts221_driver = {
 	.driver = {
 		.name = "hts221_spi",
+		.pm = &hts221_pm_ops,
 		.of_match_table = of_match_ptr(hts221_spi_of_match),
 	},
 	.probe = hts221_spi_probe,
-- 
2.12.2

