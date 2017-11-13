Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-lf0-f68.google.com ([209.85.215.68]:53149 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752116AbdKMKcB (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 13 Nov 2017 05:32:01 -0500
Received: by mail-lf0-f68.google.com with SMTP id m1so1732453lfj.9
        for <linux-iio@vger.kernel.org>; Mon, 13 Nov 2017 02:32:00 -0800 (PST)
From: Linus Walleij <linus.walleij@linaro.org>
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc: Linus Walleij <linus.walleij@linaro.org>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] iio: adc/accel: Fix up module licenses
Date: Mon, 13 Nov 2017 11:29:55 +0100
Message-Id: <20171113102955.5257-1-linus.walleij@linaro.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The module license checker complains about these two so just fix
it up. They are both GPLv2, both written by me or using code
I extracted while refactoring from the GPLv2 drivers.

Cc: Randy Dunlap <rdunlap@infradead.org>
Reported-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/iio/accel/kxsd9-i2c.c      | 3 +++
 drivers/iio/adc/qcom-vadc-common.c | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/drivers/iio/accel/kxsd9-i2c.c b/drivers/iio/accel/kxsd9-i2c.c
index 98fbb628d5bd..38411e1c155b 100644
--- a/drivers/iio/accel/kxsd9-i2c.c
+++ b/drivers/iio/accel/kxsd9-i2c.c
@@ -63,3 +63,6 @@ static struct i2c_driver kxsd9_i2c_driver = {
 	.id_table	= kxsd9_i2c_id,
 };
 module_i2c_driver(kxsd9_i2c_driver);
+
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("KXSD9 accelerometer I2C interface");
diff --git a/drivers/iio/adc/qcom-vadc-common.c b/drivers/iio/adc/qcom-vadc-common.c
index 47d24ae5462f..d249ce643e48 100644
--- a/drivers/iio/adc/qcom-vadc-common.c
+++ b/drivers/iio/adc/qcom-vadc-common.c
@@ -229,3 +229,6 @@ int qcom_vadc_decimation_from_dt(u32 value)
 	return __ffs64(value / VADC_DECIMATION_MIN);
 }
 EXPORT_SYMBOL(qcom_vadc_decimation_from_dt);
+
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("Qualcomm ADC common functionality");
-- 
2.13.6

