Return-Path: <SRS0=dXrR=P6=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB6DAC37124
	for <linux-iio@archiver.kernel.org>; Tue, 22 Jan 2019 02:04:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80CED217D4
	for <linux-iio@archiver.kernel.org>; Tue, 22 Jan 2019 02:04:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=martingkelly-com.20150623.gappssmtp.com header.i=@martingkelly-com.20150623.gappssmtp.com header.b="rKjIoGOn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726827AbfAVCEw (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Mon, 21 Jan 2019 21:04:52 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43213 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726875AbfAVCEw (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 21 Jan 2019 21:04:52 -0500
Received: by mail-pg1-f193.google.com with SMTP id v28so10272240pgk.10
        for <linux-iio@vger.kernel.org>; Mon, 21 Jan 2019 18:04:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=martingkelly-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NvPd3WMGgFHrNJUvFjzTxAPvqUZN2CkFtmwIKx5KcvQ=;
        b=rKjIoGOnpNxouy4yFQhT0BiOwrd7iOLMvhYha0lqxvLzGVlpJrjBMCToLpn3ddAafe
         81BQarpgbLKx5sp3PqQqBkzsbUl8AarIo1o3Yu6iRKb3B+kYeTnNnT6fO5iJ8uy+hwtB
         QPToIjm72enOfI+iTlA/eUI9Tjq/+eUVgT11U+XfmAYDprBofYAubhA+gZOM4y1X83OB
         NwFj/obaRTvejjYBgcGVHDA7951pvnBAXwUbOJppT1AKsCAlPXmHkAYtdhNrPRBkdN9O
         VALJy6mgE+WKrNzxBoKENSHfPeF6W33mRmFTBYnva/UFkNDGv5rHvOPwG7+irySHERNf
         zqCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=NvPd3WMGgFHrNJUvFjzTxAPvqUZN2CkFtmwIKx5KcvQ=;
        b=hBlsjVDjerfSBzkaszQ8AjEOjf1fg/2uVUZURSW1EXoU9Imz/39Ywvd3PpRDO+IljA
         Ffg3CYNLu6E6qHM0gCR+h/4LeAwL5+P1zhIVg+saSwt1L07hre6CL6Qg5hTA4Z/nvV1Z
         WGMEInZyhctlFyxlTfxCqzQ4BxXI+/a18qhRX7hEC2C/yrIzChAAAGDJuOE8N2zJk7C3
         B/IYLH4Hh1nM+ADV8ok76nZw0Lzwwqqze5VQ5/mVxwZ5+hzuEvK5RBEB7HMx900PFBSx
         My134+RNJ5JcW/q6YDiqOVG5WdQ063DMx30BPTt/V2AAZDvXN3OUwyIYALaWHQza3IxE
         nE3g==
X-Gm-Message-State: AJcUukc4nRJBWtTJF4AH6wYsafpsOf8JEhV/BoMPc70Q0FJHPRo6uBg0
        uqztcONjhjRb9sD4gxxu0aRoiPK8mRc=
X-Google-Smtp-Source: ALg8bN4Z4sp4UjIXFboz8LKlyejd7GtwnX0ENgGoN0rCPG+x9ulUqJRMy9jCa7EFYq3hPUGlfhdxFA==
X-Received: by 2002:a63:6103:: with SMTP id v3mr29398559pgb.75.1548122691244;
        Mon, 21 Jan 2019 18:04:51 -0800 (PST)
Received: from cascade.Home (174-21-177-9.tukw.qwest.net. [174.21.177.9])
        by smtp.gmail.com with ESMTPSA id n21sm19759404pfg.84.2019.01.21.18.04.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Jan 2019 18:04:50 -0800 (PST)
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
Subject: [PATCH v2 6/6] iio:bmi160: use if (ret) instead of if (ret < 0)
Date:   Mon, 21 Jan 2019 18:04:31 -0800
Message-Id: <20190122020431.5338-6-martin@martingkelly.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190122020431.5338-1-martin@martingkelly.com>
References: <20190122020431.5338-1-martin@martingkelly.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Martin Kelly <martin@martingkelly.com>

We are using "if (ret < 0)" in many places in which the function returns 0
on success. Use "if (ret)" instead for better clarity and correctness.

Signed-off-by: Martin Kelly <martin@martingkelly.com>
---
 drivers/iio/imu/bmi160/bmi160_core.c | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/iio/imu/bmi160/bmi160_core.c b/drivers/iio/imu/bmi160/bmi160_core.c
index dca53be066e1..0ec9ded975e2 100644
--- a/drivers/iio/imu/bmi160/bmi160_core.c
+++ b/drivers/iio/imu/bmi160/bmi160_core.c
@@ -299,7 +299,7 @@ int bmi160_set_mode(struct bmi160_data *data, enum bmi160_sensor_type t,
 		cmd = bmi160_regs[t].pmu_cmd_suspend;
 
 	ret = regmap_write(data->regmap, BMI160_REG_CMD, cmd);
-	if (ret < 0)
+	if (ret)
 		return ret;
 
 	usleep_range(bmi160_pmu_time[t], bmi160_pmu_time[t] + 1000);
@@ -331,7 +331,7 @@ int bmi160_get_scale(struct bmi160_data *data, enum bmi160_sensor_type t,
 	int i, ret, val;
 
 	ret = regmap_read(data->regmap, bmi160_regs[t].range, &val);
-	if (ret < 0)
+	if (ret)
 		return ret;
 
 	for (i = 0; i < bmi160_scale_table[t].num; i++)
@@ -354,7 +354,7 @@ static int bmi160_get_data(struct bmi160_data *data, int chan_type,
 	reg = bmi160_regs[t].data + (axis - IIO_MOD_X) * sizeof(sample);
 
 	ret = regmap_bulk_read(data->regmap, reg, &sample, sizeof(sample));
-	if (ret < 0)
+	if (ret)
 		return ret;
 
 	*val = sign_extend32(le16_to_cpu(sample), 15);
@@ -388,7 +388,7 @@ static int bmi160_get_odr(struct bmi160_data *data, enum bmi160_sensor_type t,
 	int i, val, ret;
 
 	ret = regmap_read(data->regmap, bmi160_regs[t].config, &val);
-	if (ret < 0)
+	if (ret)
 		return ret;
 
 	val &= bmi160_regs[t].config_odr_mask;
@@ -420,7 +420,7 @@ static irqreturn_t bmi160_trigger_handler(int irq, void *p)
 			 indio_dev->masklength) {
 		ret = regmap_bulk_read(data->regmap, base + i * sizeof(sample),
 				       &sample, sizeof(sample));
-		if (ret < 0)
+		if (ret)
 			goto done;
 		buf[j++] = sample;
 	}
@@ -441,18 +441,18 @@ static int bmi160_read_raw(struct iio_dev *indio_dev,
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
 		ret = bmi160_get_data(data, chan->type, chan->channel2, val);
-		if (ret < 0)
+		if (ret)
 			return ret;
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_SCALE:
 		*val = 0;
 		ret = bmi160_get_scale(data,
 				       bmi160_to_sensor(chan->type), val2);
-		return ret < 0 ? ret : IIO_VAL_INT_PLUS_MICRO;
+		return ret ? ret : IIO_VAL_INT_PLUS_MICRO;
 	case IIO_CHAN_INFO_SAMP_FREQ:
 		ret = bmi160_get_odr(data, bmi160_to_sensor(chan->type),
 				     val, val2);
-		return ret < 0 ? ret : IIO_VAL_INT_PLUS_MICRO;
+		return ret ? ret : IIO_VAL_INT_PLUS_MICRO;
 	default:
 		return -EINVAL;
 	}
@@ -732,7 +732,7 @@ static int bmi160_chip_init(struct bmi160_data *data, bool use_spi, int irq)
 	struct device *dev = regmap_get_device(data->regmap);
 
 	ret = regmap_write(data->regmap, BMI160_REG_CMD, BMI160_CMD_SOFTRESET);
-	if (ret < 0)
+	if (ret)
 		return ret;
 
 	usleep_range(BMI160_SOFTRESET_USLEEP, BMI160_SOFTRESET_USLEEP + 1);
@@ -743,7 +743,7 @@ static int bmi160_chip_init(struct bmi160_data *data, bool use_spi, int irq)
 	 */
 	if (use_spi) {
 		ret = regmap_read(data->regmap, BMI160_REG_DUMMY, &val);
-		if (ret < 0)
+		if (ret)
 			return ret;
 	}
 
@@ -759,11 +759,11 @@ static int bmi160_chip_init(struct bmi160_data *data, bool use_spi, int irq)
 	}
 
 	ret = bmi160_set_mode(data, BMI160_ACCEL, true);
-	if (ret < 0)
+	if (ret)
 		return ret;
 
 	ret = bmi160_set_mode(data, BMI160_GYRO, true);
-	if (ret < 0)
+	if (ret)
 		return ret;
 
 	return 0;
@@ -796,7 +796,7 @@ int bmi160_probe_trigger(struct iio_dev *indio_dev, int irq, u32 irq_type)
 	ret = devm_request_irq(&indio_dev->dev, irq,
 			       &iio_trigger_generic_data_rdy_poll,
 			       irq_type, "bmi160", data->trig);
-	if (ret < 0)
+	if (ret)
 		return ret;
 
 	data->trig->dev.parent = regmap_get_device(data->regmap);
@@ -836,11 +836,11 @@ int bmi160_core_probe(struct device *dev, struct regmap *regmap,
 	data->regmap = regmap;
 
 	ret = bmi160_chip_init(data, use_spi, irq);
-	if (ret < 0)
+	if (ret)
 		return ret;
 
 	ret = devm_add_action_or_reset(dev, bmi160_chip_uninit, data);
-	if (ret < 0)
+	if (ret)
 		return ret;
 
 	if (!name && ACPI_HANDLE(dev))
@@ -856,7 +856,7 @@ int bmi160_core_probe(struct device *dev, struct regmap *regmap,
 	ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
 					      iio_pollfunc_store_time,
 					      bmi160_trigger_handler, NULL);
-	if (ret < 0)
+	if (ret)
 		return ret;
 
 	if (irq) {
@@ -866,7 +866,7 @@ int bmi160_core_probe(struct device *dev, struct regmap *regmap,
 	}
 
 	ret = devm_iio_device_register(dev, indio_dev);
-	if (ret < 0)
+	if (ret)
 		return ret;
 
 	return 0;
-- 
2.11.0

