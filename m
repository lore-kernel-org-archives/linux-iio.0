Return-Path: <linus.walleij@linaro.org>
From: Linus Walleij <linus.walleij@linaro.org>
To: Jonathan Cameron <jic23@kernel.org>,
	linux-iio@vger.kernel.org,
	Denis CIOCCA <denis.ciocca@st.com>
Cc: Lee Jones <lee.jones@linaro.org>,
	Linus Walleij <linus.walleij@linaro.org>
Subject: [RESEND PATCH 1/3] iio: st_sensors: get platform data from device tree
Date: Mon,  7 Jul 2014 11:47:15 +0200
Message-Id: <1404726435-2565-1-git-send-email-linus.walleij@linaro.org>
List-ID: <linux-iio@vger.kernel.org>

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
1.9.3
