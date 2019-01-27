Return-Path: <SRS0=pB1S=QD=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A6EFC282CB
	for <linux-iio@archiver.kernel.org>; Sun, 27 Jan 2019 20:39:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C861221473
	for <linux-iio@archiver.kernel.org>; Sun, 27 Jan 2019 20:39:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=martingkelly-com.20150623.gappssmtp.com header.i=@martingkelly-com.20150623.gappssmtp.com header.b="cvYn6WZK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727095AbfA0Ujd (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 27 Jan 2019 15:39:33 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:44548 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727101AbfA0Ujc (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 27 Jan 2019 15:39:32 -0500
Received: by mail-pl1-f196.google.com with SMTP id e11so6801813plt.11
        for <linux-iio@vger.kernel.org>; Sun, 27 Jan 2019 12:39:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=martingkelly-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FlyRPLlgUAShz0ebP8RTaMbNSXmKYKB9Wl5iiR3oRNU=;
        b=cvYn6WZKZDS1hBEhg9zr+SecvfU4vQenbViUm4Jp+aYYHy43tSSG0DcE4Pi9pPparg
         66Qgs0WJlxz6h+mamBDQQHFMr3HQWGCYnTuAvi3o6Iq96kq+tBPITs6da5OSNgs9IRub
         x0rrhruCKhvOYFGJRSqtsbGDzLO0IbpbDhs8+oei8UhpWnhI786Wu+bXJfjc2LFNBdJM
         nDzxwi4PIb+O1d5VBzMUacW+cJnL3NXzTHRU2LhBVUg/jwry8b4LxRWFqNWbKZmfpbpH
         mXF9d7RR4MHnbjzuid0hJeoWzjWEDUpF0UTz8XcFLGaHFTlAzftwRWpoyDSfBLyEvEzd
         jNdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FlyRPLlgUAShz0ebP8RTaMbNSXmKYKB9Wl5iiR3oRNU=;
        b=WX8s2LYlAlo01KbZ0y0/JyDNC0+saZBsl4tBSZByg6Vcfez2nDQ7ax/QO0fz7J7HR8
         NSEcHHiS5YIgcBhufvZOClDjPu7srZnzFF38mEP6EbuhSqdHdF5FA5eO8DgcYIfQyWf2
         XBwLjn8s8XZGSSKsxZgLD/oH4Nab0g1w/RyYFsZafrQhYlfM9Z/1fOYC6I4XXgX2bR9p
         izqx2CkW0jwCLm4m3e03fxZtj7b8gEwYk25C5fDexHqt7Z/hZ0/aG5RNSUmSkHsAhiTl
         zWqdLhXsmheFy0F3mP7z7BZkhcNjkbGc03WqCTIoIZNTPVaZ84+UgpiCnectH0xs+GAh
         37gA==
X-Gm-Message-State: AJcUukeQhXvcZvGt0JGFHR7/nD7R/wGKFLx/oxh8GohhP9XaOmlmDXeO
        w6n0phVr0PKb7d6oJb0LNhwGC2wbSqBVeg==
X-Google-Smtp-Source: ALg8bN7ET3eoXQ/XR2HRxKvfFQ+UhQwVeYrXhiRtiosl4ipPQqEMnLJu43t0G6mZtGh9dZSw3gSsXw==
X-Received: by 2002:a17:902:e290:: with SMTP id cf16mr19643159plb.81.1548621571502;
        Sun, 27 Jan 2019 12:39:31 -0800 (PST)
Received: from cascade.Home (174-21-177-9.tukw.qwest.net. [174.21.177.9])
        by smtp.gmail.com with ESMTPSA id a4sm33049912pgv.70.2019.01.27.12.39.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 27 Jan 2019 12:39:30 -0800 (PST)
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
Subject: [PATCH v3 2/6] iio:bmi160: add drdy interrupt support
Date:   Sun, 27 Jan 2019 12:39:07 -0800
Message-Id: <20190127203911.8696-3-martin@martingkelly.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190127203911.8696-1-martin@martingkelly.com>
References: <20190127203911.8696-1-martin@martingkelly.com>
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
index ce61026d84c3..70739e3920af 100644
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
+	/* Use INT1 if possible, otherwise falling back to INT2. */
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
+	open_drain = of_property_read_bool(dev->of_node, "bmi160,open-drain");
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

