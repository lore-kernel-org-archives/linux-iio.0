Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wi0-f179.google.com ([209.85.212.179]:44023 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755240AbaDMTJg (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 13 Apr 2014 15:09:36 -0400
Received: by mail-wi0-f179.google.com with SMTP id z2so3126344wiv.0
        for <linux-iio@vger.kernel.org>; Sun, 13 Apr 2014 12:09:35 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
	Denis CIOCCA <denis.ciocca@st.com>
Cc: Lee Jones <lee.jones@linaro.org>,
	Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 3/6] iio: st_sensors: get platform data from device tree
Date: Sun, 13 Apr 2014 21:09:00 +0200
Message-Id: <1397416143-4396-4-git-send-email-linus.walleij@linaro.org>
In-Reply-To: <1397416143-4396-1-git-send-email-linus.walleij@linaro.org>
References: <1397416143-4396-1-git-send-email-linus.walleij@linaro.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Currently the STMicroelectronics sensors only support one single
platform data item: configuration of the DRDY (data ready) pin
for a particular design. Augment the core to prioritize and take
this information from the device tree if the parent device has an
assigned device node, else fall back to passed in platform data
(usually the default data).

Cc: Lee Jones <lee.jones@linaro.org>
Cc: Denis CIOCCA <denis.ciocca@st.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/iio/common/st_sensors/st_sensors_core.c | 35 ++++++++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/common/st_sensors/st_sensors_core.c b/drivers/iio/common/st_sensors/st_sensors_core.c
index e8b932fed70e..1cdcef94e6a2 100644
--- a/drivers/iio/common/st_sensors/st_sensors_core.c
+++ b/drivers/iio/common/st_sensors/st_sensors_core.c
@@ -14,8 +14,8 @@
 #include <linux/delay.h>
 #include <linux/iio/iio.h>
 #include <linux/regulator/consumer.h>
+#include <linux/of.h>
 #include <asm/unaligned.h>
-
 #include <linux/iio/common/st_sensors.h>
 
 
@@ -265,14 +265,47 @@ static int st_sensors_set_drdy_int_pin(struct iio_dev *indio_dev,
 	return 0;
 }
 
+#ifdef CONFIG_OF
+static struct st_sensors_platform_data *st_sensors_of_probe(struct device *dev,
+		struct st_sensors_platform_data *defdata)
+{
+	struct st_sensors_platform_data *pdata;
+	struct device_node *np = dev->of_node;
+	u32 val;
+
+	if (!np)
+		return NULL;
+
+	pdata = devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
+	if (!of_property_read_u32(np, "st,drdy-int-pin", &val) && (val <= 2))
+		pdata->drdy_int_pin = (u8) val;
+	else
+		pdata->drdy_int_pin = defdata ? defdata->drdy_int_pin : 1;
+
+	return pdata;
+}
+#else
+static struct st_sensors_platform_data *st_sensors_of_probe(struct device *dev,
+		struct st_sensors_platform_data *defdata)
+{
+	return NULL;
+}
+#endif
+
 int st_sensors_init_sensor(struct iio_dev *indio_dev,
 					struct st_sensors_platform_data *pdata)
 {
 	struct st_sensor_data *sdata = iio_priv(indio_dev);
+	struct st_sensors_platform_data *of_pdata;
 	int err = 0;
 
 	mutex_init(&sdata->tb.buf_lock);
 
+	/* If OF/DT pdata exists, it will take precedence of anything else */
+	of_pdata = st_sensors_of_probe(indio_dev->dev.parent, pdata);
+	if (of_pdata)
+		pdata = of_pdata;
+
 	if (pdata)
 		err = st_sensors_set_drdy_int_pin(indio_dev, pdata);
 
-- 
1.9.0

