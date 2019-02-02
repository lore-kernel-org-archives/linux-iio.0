Return-Path: <SRS0=e/h2=QJ=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E68AEC282D7
	for <linux-iio@archiver.kernel.org>; Sat,  2 Feb 2019 21:56:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A274220856
	for <linux-iio@archiver.kernel.org>; Sat,  2 Feb 2019 21:56:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=martingkelly-com.20150623.gappssmtp.com header.i=@martingkelly-com.20150623.gappssmtp.com header.b="A/MjQoiM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726660AbfBBV4W (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 2 Feb 2019 16:56:22 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:41974 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726690AbfBBV4V (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 2 Feb 2019 16:56:21 -0500
Received: by mail-pg1-f195.google.com with SMTP id m1so4600076pgq.8
        for <linux-iio@vger.kernel.org>; Sat, 02 Feb 2019 13:56:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=martingkelly-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IL3nXPeVJ6brWYu2R/3o65WhAeliANJmDgqCQrv3iK8=;
        b=A/MjQoiM518UGDq4iWrnkq0vBnjRzO4opW+AEIIMWc/FlFkRPlKXy3oc6qocVUY5NZ
         +kQuLoXa9l+nT9VbRr7jYV35N6eFEPJugU2HRnm47AARAM0WXR3imfSudZWw6Ywed24K
         2ipyP8muA1I6IbXYdcrxF/cMlRuN9FAScdm0T5j7Aeqgl/oJG352OZ/q3/HmG1V+T24Q
         8qhZzgLUc/aTjANadZi4dTuEdua18gIAbqrrr4GaxHO8sVwIhSSC49w9M/7MRX7xHzCi
         E83odv+MHAIDRF3PdKfVpzSsXKgW2sUWxzLclHlJd/NIEEWopoJihEf3Fq+zq3XMnNT5
         7zLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=IL3nXPeVJ6brWYu2R/3o65WhAeliANJmDgqCQrv3iK8=;
        b=lJwrvx+YMa12HDxdMkyfOdVUz1YDa0qjw8n7g6jGM6iEyOVVC63cI6AXVoHCQNKg7U
         wO1J2K1b1jZw4FLJuuylwj/lqQfypgvtX30eztWPvx/Q/Wdj9x7T01xZY+XPtFb2TM5Q
         k9KUJps9IRmLbvviNLJZ+yT5AZO798LxM5Nozv5u1McV2r0XZRDY45dTcQiewEqKOz+H
         d627ATcDLWuoUbuAScTW7VNLwuVSmgNQEwP1Z8jt8Tu5cFn71AjglWzPAOJjm5h+WFzq
         4aYIkUCjQx1LTpbXqG4T9S3kpJCchHPUGftKMp/5iRWfR016KLo2Lv2hgWOoQ50gxLU8
         3jWA==
X-Gm-Message-State: AHQUAuaYxO9mbzhlVAxnXUGcFKDlrBtas8MUPHU+X9I4rV72nYDOGeYz
        TP7kstVilMxWuY3jwQ48SVOgbaR6W+c=
X-Google-Smtp-Source: AHgI3IYbhywS9N8NQjMm7eO7XO2FBAfODMy5E0Sm78kUl9xQ1v7lGRXevO8B2mOG8Ow3WsE0FKHlFg==
X-Received: by 2002:a63:b81a:: with SMTP id p26mr4731283pge.433.1549144580108;
        Sat, 02 Feb 2019 13:56:20 -0800 (PST)
Received: from cascade.Home (174-21-177-9.tukw.qwest.net. [174.21.177.9])
        by smtp.gmail.com with ESMTPSA id z127sm20082025pfb.80.2019.02.02.13.56.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 02 Feb 2019 13:56:19 -0800 (PST)
From:   Martin Kelly <martin@martingkelly.com>
X-Google-Original-From: Martin Kelly <martin@martingkelly.com
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Daniel Baluta <daniel.baluta@gmail.com>,
        devicetree@vger.kernel.org, Martin Kelly <martin@martingkelly.com>
Subject: [PATCH v4 2/6] iio:bmi160: add drdy interrupt support
Date:   Sat,  2 Feb 2019 13:55:57 -0800
Message-Id: <20190202215601.20275-3-martin@martingkelly.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190202215601.20275-1-martin@martingkelly.com>
References: <20190202215601.20275-1-martin@martingkelly.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Martin Kelly <martin@martingkelly.com>

Add interrupt support for the data ready signal on the BMI160, which fires
an interrupt whenever new accelerometer/gyroscope data is ready to read.

Signed-off-by: Martin Kelly <martin@martingkelly.com>
---
 drivers/iio/imu/bmi160/bmi160.h      |  11 ++
 drivers/iio/imu/bmi160/bmi160_core.c | 270 ++++++++++++++++++++++++++++++++++-
 2 files changed, 278 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/imu/bmi160/bmi160.h b/drivers/iio/imu/bmi160/bmi160.h
index 2351049d930b..621f5309d735 100644
--- a/drivers/iio/imu/bmi160/bmi160.h
+++ b/drivers/iio/imu/bmi160/bmi160.h
@@ -2,9 +2,20 @@
 #ifndef BMI160_H_
 #define BMI160_H_
 
+#include <linux/iio/iio.h>
+
+struct bmi160_data {
+	struct regmap *regmap;
+	struct iio_trigger *trig;
+};
+
 extern const struct regmap_config bmi160_regmap_config;
 
 int bmi160_core_probe(struct device *dev, struct regmap *regmap,
 		      const char *name, bool use_spi);
 
+int bmi160_enable_irq(struct regmap *regmap, bool enable);
+
+int bmi160_probe_trigger(struct iio_dev *indio_dev, int irq, u32 irq_type);
+
 #endif  /* BMI160_H_ */
diff --git a/drivers/iio/imu/bmi160/bmi160_core.c b/drivers/iio/imu/bmi160/bmi160_core.c
index ce61026d84c3..007f7c532ac4 100644
--- a/drivers/iio/imu/bmi160/bmi160_core.c
+++ b/drivers/iio/imu/bmi160/bmi160_core.c
@@ -3,21 +3,25 @@
  * BMI160 - Bosch IMU (accel, gyro plus external magnetometer)
  *
  * Copyright (c) 2016, Intel Corporation.
+ * Copyright (c) 2019, Martin Kelly.
  *
  * IIO core driver for BMI160, with support for I2C/SPI busses
  *
- * TODO: magnetometer, interrupts, hardware FIFO
+ * TODO: magnetometer, hardware FIFO
  */
 #include <linux/module.h>
 #include <linux/regmap.h>
 #include <linux/acpi.h>
 #include <linux/delay.h>
+#include <linux/irq.h>
+#include <linux/of_irq.h>
 
 #include <linux/iio/iio.h>
 #include <linux/iio/triggered_buffer.h>
 #include <linux/iio/trigger_consumer.h>
 #include <linux/iio/buffer.h>
 #include <linux/iio/sysfs.h>
+#include <linux/iio/trigger.h>
 
 #include "bmi160.h"
 
@@ -61,8 +65,32 @@
 #define BMI160_CMD_GYRO_PM_FAST_STARTUP	0x17
 #define BMI160_CMD_SOFTRESET		0xB6
 
+#define BMI160_REG_INT_EN		0x51
+#define BMI160_DRDY_INT_EN		BIT(4)
+
+#define BMI160_REG_INT_OUT_CTRL		0x53
+#define BMI160_INT_OUT_CTRL_MASK	0x0f
+#define BMI160_INT1_OUT_CTRL_SHIFT	0
+#define BMI160_INT2_OUT_CTRL_SHIFT	4
+#define BMI160_EDGE_TRIGGERED		BIT(0)
+#define BMI160_ACTIVE_HIGH		BIT(1)
+#define BMI160_OPEN_DRAIN		BIT(2)
+#define BMI160_OUTPUT_EN		BIT(3)
+
+#define BMI160_REG_INT_LATCH		0x54
+#define BMI160_INT1_LATCH_MASK		BIT(4)
+#define BMI160_INT2_LATCH_MASK		BIT(5)
+
+/* INT1 and INT2 are in the opposite order as in INT_OUT_CTRL! */
+#define BMI160_REG_INT_MAP		0x56
+#define BMI160_INT1_MAP_DRDY_EN		0x80
+#define BMI160_INT2_MAP_DRDY_EN		0x08
+
 #define BMI160_REG_DUMMY		0x7F
 
+#define BMI160_NORMAL_WRITE_USLEEP	2
+#define BMI160_SUSPENDED_WRITE_USLEEP	450
+
 #define BMI160_ACCEL_PMU_MIN_USLEEP	3800
 #define BMI160_GYRO_PMU_MIN_USLEEP	80000
 #define BMI160_SOFTRESET_USLEEP		1000
@@ -105,8 +133,9 @@ enum bmi160_sensor_type {
 	BMI160_NUM_SENSORS /* must be last */
 };
 
-struct bmi160_data {
-	struct regmap *regmap;
+enum bmi160_int_pin {
+	BMI160_PIN_INT1,
+	BMI160_PIN_INT2
 };
 
 const struct regmap_config bmi160_regmap_config = {
@@ -495,6 +524,186 @@ static const char *bmi160_match_acpi_device(struct device *dev)
 	return dev_name(dev);
 }
 
+static int bmi160_write_conf_reg(struct regmap *regmap, unsigned int reg,
+				 unsigned int mask, unsigned int bits,
+				 unsigned int write_usleep)
+{
+	int ret;
+	unsigned int val;
+
+	ret = regmap_read(regmap, reg, &val);
+	if (ret)
+		return ret;
+
+	val = (val & ~mask) | bits;
+
+	ret = regmap_write(regmap, reg, val);
+	if (ret)
+		return ret;
+
+	/*
+	 * We need to wait after writing before we can write again. See the
+	 * datasheet, page 93.
+	 */
+	usleep_range(write_usleep, write_usleep + 1000);
+
+	return 0;
+}
+
+static int bmi160_config_pin(struct regmap *regmap, enum bmi160_int_pin pin,
+			     bool open_drain, u8 irq_mask,
+			     unsigned long write_usleep)
+{
+	int ret;
+	struct device *dev = regmap_get_device(regmap);
+	u8 int_out_ctrl_shift;
+	u8 int_latch_mask;
+	u8 int_map_mask;
+	u8 int_out_ctrl_mask;
+	u8 int_out_ctrl_bits;
+	const char *pin_name;
+
+	switch (pin) {
+	case BMI160_PIN_INT1:
+		int_out_ctrl_shift = BMI160_INT1_OUT_CTRL_SHIFT;
+		int_latch_mask = BMI160_INT1_LATCH_MASK;
+		int_map_mask = BMI160_INT1_MAP_DRDY_EN;
+		break;
+	case BMI160_PIN_INT2:
+		int_out_ctrl_shift = BMI160_INT2_OUT_CTRL_SHIFT;
+		int_latch_mask = BMI160_INT2_LATCH_MASK;
+		int_map_mask = BMI160_INT2_MAP_DRDY_EN;
+		break;
+	}
+	int_out_ctrl_mask = BMI160_INT_OUT_CTRL_MASK << int_out_ctrl_shift;
+
+	/*
+	 * Enable the requested pin with the right settings:
+	 * - Push-pull/open-drain
+	 * - Active low/high
+	 * - Edge/level triggered
+	 */
+	int_out_ctrl_bits = BMI160_OUTPUT_EN;
+	if (open_drain)
+		/* Default is push-pull. */
+		int_out_ctrl_bits |= BMI160_OPEN_DRAIN;
+	int_out_ctrl_bits |= irq_mask;
+	int_out_ctrl_bits <<= int_out_ctrl_shift;
+
+	ret = bmi160_write_conf_reg(regmap, BMI160_REG_INT_OUT_CTRL,
+				    int_out_ctrl_mask, int_out_ctrl_bits,
+				    write_usleep);
+	if (ret)
+		return ret;
+
+	/* Set the pin to input mode with no latching. */
+	ret = bmi160_write_conf_reg(regmap, BMI160_REG_INT_LATCH,
+				    int_latch_mask, int_latch_mask,
+				    write_usleep);
+	if (ret)
+		return ret;
+
+	/* Map interrupts to the requested pin. */
+	ret = bmi160_write_conf_reg(regmap, BMI160_REG_INT_MAP,
+				    int_map_mask, int_map_mask,
+				    write_usleep);
+	if (ret) {
+		switch (pin) {
+		case BMI160_PIN_INT1:
+			pin_name = "INT1";
+			break;
+		case BMI160_PIN_INT2:
+			pin_name = "INT2";
+			break;
+		}
+		dev_err(dev, "Failed to configure %s IRQ pin", pin_name);
+	}
+
+	return ret;
+}
+
+int bmi160_enable_irq(struct regmap *regmap, bool enable)
+{
+	unsigned int enable_bit = 0;
+
+	if (enable)
+		enable_bit = BMI160_DRDY_INT_EN;
+
+	return bmi160_write_conf_reg(regmap, BMI160_REG_INT_EN,
+				     BMI160_DRDY_INT_EN, enable_bit,
+				     BMI160_NORMAL_WRITE_USLEEP);
+}
+EXPORT_SYMBOL(bmi160_enable_irq);
+
+static int bmi160_get_irq(struct device_node *of_node, enum bmi160_int_pin *pin)
+{
+	int irq;
+
+	/* Use INT1 if possible, otherwise fall back to INT2. */
+	irq = of_irq_get_byname(of_node, "INT1");
+	if (irq > 0) {
+		*pin = BMI160_PIN_INT1;
+		return irq;
+	}
+
+	irq = of_irq_get_byname(of_node, "INT2");
+	if (irq > 0)
+		*pin = BMI160_PIN_INT2;
+
+	return irq;
+}
+
+static int bmi160_config_device_irq(struct iio_dev *indio_dev, int irq_type,
+				    enum bmi160_int_pin pin)
+{
+	bool open_drain;
+	u8 irq_mask;
+	struct bmi160_data *data = iio_priv(indio_dev);
+	struct device *dev = regmap_get_device(data->regmap);
+
+	/* Level-triggered, active-low is the default if we set all zeroes. */
+	if (irq_type == IRQF_TRIGGER_RISING)
+		irq_mask = BMI160_ACTIVE_HIGH | BMI160_EDGE_TRIGGERED;
+	else if (irq_type == IRQF_TRIGGER_FALLING)
+		irq_mask = BMI160_EDGE_TRIGGERED;
+	else if (irq_type == IRQF_TRIGGER_HIGH)
+		irq_mask = BMI160_ACTIVE_HIGH;
+	else if (irq_type == IRQF_TRIGGER_LOW)
+		irq_mask = 0;
+	else {
+		dev_err(&indio_dev->dev,
+			"Invalid interrupt type 0x%x specified\n", irq_type);
+		return -EINVAL;
+	}
+
+	open_drain = of_property_read_bool(dev->of_node, "drive-open-drain");
+
+	return bmi160_config_pin(data->regmap, pin, open_drain, irq_mask,
+				 BMI160_NORMAL_WRITE_USLEEP);
+}
+
+static int bmi160_setup_irq(struct iio_dev *indio_dev, int irq,
+			    enum bmi160_int_pin pin)
+{
+	struct irq_data *desc;
+	u32 irq_type;
+	int ret;
+
+	desc = irq_get_irq_data(irq);
+	if (!desc) {
+		dev_err(&indio_dev->dev, "Could not find IRQ %d\n", irq);
+		return -EINVAL;
+	}
+
+	irq_type = irqd_get_trigger_type(desc);
+
+	ret = bmi160_config_device_irq(indio_dev, irq_type, pin);
+	if (ret)
+		return ret;
+
+	return bmi160_probe_trigger(indio_dev, irq, irq_type);
+}
+
 static int bmi160_chip_init(struct bmi160_data *data, bool use_spi)
 {
 	int ret;
@@ -539,6 +748,49 @@ static int bmi160_chip_init(struct bmi160_data *data, bool use_spi)
 	return 0;
 }
 
+static int bmi160_data_rdy_trigger_set_state(struct iio_trigger *trig,
+					     bool enable)
+{
+	struct iio_dev *indio_dev = iio_trigger_get_drvdata(trig);
+	struct bmi160_data *data = iio_priv(indio_dev);
+
+	return bmi160_enable_irq(data->regmap, enable);
+}
+
+static const struct iio_trigger_ops bmi160_trigger_ops = {
+	.set_trigger_state = &bmi160_data_rdy_trigger_set_state,
+};
+
+int bmi160_probe_trigger(struct iio_dev *indio_dev, int irq, u32 irq_type)
+{
+	struct bmi160_data *data = iio_priv(indio_dev);
+	int ret;
+
+	data->trig = devm_iio_trigger_alloc(&indio_dev->dev, "%s-dev%d",
+					    indio_dev->name, indio_dev->id);
+
+	if (data->trig == NULL)
+		return -ENOMEM;
+
+	ret = devm_request_irq(&indio_dev->dev, irq,
+			       &iio_trigger_generic_data_rdy_poll,
+			       irq_type, "bmi160", data->trig);
+	if (ret < 0)
+		return ret;
+
+	data->trig->dev.parent = regmap_get_device(data->regmap);
+	data->trig->ops = &bmi160_trigger_ops;
+	iio_trigger_set_drvdata(data->trig, indio_dev);
+
+	ret = devm_iio_trigger_register(&indio_dev->dev, data->trig);
+	if (ret)
+		return ret;
+
+	indio_dev->trig = iio_trigger_get(data->trig);
+
+	return 0;
+}
+
 static void bmi160_chip_uninit(void *data)
 {
 	struct bmi160_data *bmi_data = data;
@@ -552,6 +804,8 @@ int bmi160_core_probe(struct device *dev, struct regmap *regmap,
 {
 	struct iio_dev *indio_dev;
 	struct bmi160_data *data;
+	int irq;
+	enum bmi160_int_pin int_pin;
 	int ret;
 
 	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
@@ -585,6 +839,16 @@ int bmi160_core_probe(struct device *dev, struct regmap *regmap,
 	if (ret < 0)
 		return ret;
 
+	irq = bmi160_get_irq(dev->of_node, &int_pin);
+	if (irq > 0) {
+		ret = bmi160_setup_irq(indio_dev, irq, int_pin);
+		if (ret)
+			dev_err(&indio_dev->dev, "Failed to setup IRQ %d\n",
+				irq);
+	} else {
+		dev_info(&indio_dev->dev, "Not setting up IRQ trigger\n");
+	}
+
 	ret = devm_iio_device_register(dev, indio_dev);
 	if (ret < 0)
 		return ret;
-- 
2.11.0

