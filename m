Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pl1-f195.google.com ([209.85.214.195]:46560 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726179AbeKUDYu (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 20 Nov 2018 22:24:50 -0500
From: Shreeya Patel <shreeya.patel23498@gmail.com>
To: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/5] Staging: iio: adt7316: Use device tree data to set ldac_pin
Date: Tue, 20 Nov 2018 22:24:36 +0530
Message-Id: <20181120165436.7178-1-shreeya.patel23498@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Make the driver use device tree instead of the platform data.
Hence, use devm_gpiod_get_optional function to get the data from
device tree for ldac-pin and accordingly make the needed changes
in the driver.

Signed-off-by: Shreeya Patel <shreeya.patel23498@gmail.com>
---
 drivers/staging/iio/addac/adt7316.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/iio/addac/adt7316.c b/drivers/staging/iio/addac/adt7316.c
index 3f22d1088713..deb2f7b40f60 100644
--- a/drivers/staging/iio/addac/adt7316.c
+++ b/drivers/staging/iio/addac/adt7316.c
@@ -177,7 +177,7 @@
 
 struct adt7316_chip_info {
 	struct adt7316_bus	bus;
-	u16			ldac_pin;
+	struct gpio_desc	*ldac_pin;
 	u16			int_mask;	/* 0x2f */
 	u8			config1;
 	u8			config2;
@@ -950,8 +950,8 @@ static ssize_t adt7316_store_update_DAC(struct device *dev,
 		if (ret)
 			return -EIO;
 	} else {
-		gpio_set_value(chip->ldac_pin, 0);
-		gpio_set_value(chip->ldac_pin, 1);
+		gpiod_set_value(chip->ldac_pin, 0);
+		gpiod_set_value(chip->ldac_pin, 1);
 	}
 
 	return len;
@@ -2120,7 +2120,13 @@ int adt7316_probe(struct device *dev, struct adt7316_bus *bus,
 	else
 		return -ENODEV;
 
-	chip->ldac_pin = adt7316_platform_data[1];
+	chip->ldac_pin = devm_gpiod_get_optional(dev, "ldac", GPIOD_OUT_LOW);
+	if (IS_ERR(chip->ldac_pin)) {
+		ret = PTR_ERR(chip->ldac_pin);
+		dev_err(dev, "Failed to request ldac GPIO: %d\n", ret);
+		return ret;
+	}
+
 	if (chip->ldac_pin) {
 		chip->config3 |= ADT7316_DA_EN_VIA_DAC_LDCA;
 		if ((chip->id & ID_FAMILY_MASK) == ID_ADT75XX)
-- 
2.17.1
