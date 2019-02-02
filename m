Return-Path: <SRS0=e/h2=QJ=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E9DCC282D7
	for <linux-iio@archiver.kernel.org>; Sat,  2 Feb 2019 21:56:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24D2520856
	for <linux-iio@archiver.kernel.org>; Sat,  2 Feb 2019 21:56:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=martingkelly-com.20150623.gappssmtp.com header.i=@martingkelly-com.20150623.gappssmtp.com header.b="MCwFf3RL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726771AbfBBV43 (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 2 Feb 2019 16:56:29 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:43740 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726784AbfBBV43 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 2 Feb 2019 16:56:29 -0500
Received: by mail-pl1-f194.google.com with SMTP id gn14so5004762plb.10
        for <linux-iio@vger.kernel.org>; Sat, 02 Feb 2019 13:56:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=martingkelly-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Tvvv9GlYcmAwl+5pZu2U15t6n8F1a8a+vsfgMpLluds=;
        b=MCwFf3RL0fODvpFf640WCnJ1qbtDISc6Jpdw/nHlmBs6aPbhq5021rDUjZZGctI/uj
         Hwgs69O2JbK2Es4XE7mnJvC6gv7CZVywGjL2BPDx+XR2OW856UHFcVnNuwGiHMlgJuu1
         j2ugVxxG5wVUK5CK4Tw71DJfXv4Ylq+jN+drYFb3lVF0q3iWUGcYA0bBP2qmoVeWNsN+
         o95gtagOvdg8kW8AvJ++5NNfrwlM4E0qgHWclsn4VuGzwoMdtKg/c9S1xFQfzvSr4KeA
         U4qmMt9jCI3k8K+i22AkJV2+u67zuPh9ki+aU5EZN/Xgd57F2I51WHhz4uW6V3j9O4An
         gpQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Tvvv9GlYcmAwl+5pZu2U15t6n8F1a8a+vsfgMpLluds=;
        b=V9QqHylSrJpcC9qDVaIe6eJI+6CVTb+X2CYR5AJ/kOS96OvhGEBmxMSYndtla8uXbk
         lVtYS9igDnWbHVcfQ/Jvcmtp/amxNKET5/5SUFYHNmqkd9mN3jLwa3mLsyGUQDSsJS0j
         AU1YnY1Faw0z+sxSkAluCNRdZPKH+2PZ9XsDbSXo51pfvbUIttN2ZWH1kXG6BULfZsza
         KoPWhgmey2sUy4yoxlAI4SsoVhd5ijvDWxqFNH2y9iCSuC/jPuA2CfZd609zEKPrwfxA
         6jeSmAENEJmZYVH9TVEFBUJkQF7sdwtOBvebUfGYURckQySYOGPWM4VtlqE0JzECZQ8f
         8DOQ==
X-Gm-Message-State: AJcUukfHdKsajXIA7ATCVkK3+xZYQNIMyjsf8zGxlDFK1JwFa+4OwUbz
        n40wef0FDQJeqDsXgnQbU/jQ4bnyufw=
X-Google-Smtp-Source: ALg8bN4Gy3ytSVtk3g05+Dh5MeDkmVqdloWWfSwGrmjAjB9atbVH/d5bNPcChIcDEwkx+C+oOUFQVA==
X-Received: by 2002:a17:902:8607:: with SMTP id f7mr44157059plo.123.1549144588314;
        Sat, 02 Feb 2019 13:56:28 -0800 (PST)
Received: from cascade.Home (174-21-177-9.tukw.qwest.net. [174.21.177.9])
        by smtp.gmail.com with ESMTPSA id z127sm20082025pfb.80.2019.02.02.13.56.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 02 Feb 2019 13:56:27 -0800 (PST)
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
Subject: [PATCH v4 6/6] iio:bmi160: use if (ret) instead of if (ret < 0)
Date:   Sat,  2 Feb 2019 13:56:01 -0800
Message-Id: <20190202215601.20275-7-martin@martingkelly.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190202215601.20275-1-martin@martingkelly.com>
References: <20190202215601.20275-1-martin@martingkelly.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Martin Kelly <martin@martingkelly.com>

We are using "if (ret < 0)" in many places in which the function returns 0
on success. Use "if (ret)" instead for better clarity and correctness.

Signed-off-by: Martin Kelly <martin@martingkelly.com>
---
 drivers/iio/imu/bmi160/bmi160_core.c | 40 ++++++++++++++++--------------------
 1 file changed, 18 insertions(+), 22 deletions(-)

diff --git a/drivers/iio/imu/bmi160/bmi160_core.c b/drivers/iio/imu/bmi160/bmi160_core.c
index f3c5b86a281e..6af65d6f1d28 100644
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
@@ -710,7 +710,7 @@ static int bmi160_chip_init(struct bmi160_data *data, bool use_spi)
 	struct device *dev = regmap_get_device(data->regmap);
 
 	ret = regmap_write(data->regmap, BMI160_REG_CMD, BMI160_CMD_SOFTRESET);
-	if (ret < 0)
+	if (ret)
 		return ret;
 
 	usleep_range(BMI160_SOFTRESET_USLEEP, BMI160_SOFTRESET_USLEEP + 1);
@@ -721,12 +721,12 @@ static int bmi160_chip_init(struct bmi160_data *data, bool use_spi)
 	 */
 	if (use_spi) {
 		ret = regmap_read(data->regmap, BMI160_REG_DUMMY, &val);
-		if (ret < 0)
+		if (ret)
 			return ret;
 	}
 
 	ret = regmap_read(data->regmap, BMI160_REG_CHIP_ID, &val);
-	if (ret < 0) {
+	if (ret) {
 		dev_err(dev, "Error reading chip id\n");
 		return ret;
 	}
@@ -737,11 +737,11 @@ static int bmi160_chip_init(struct bmi160_data *data, bool use_spi)
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
@@ -774,7 +774,7 @@ int bmi160_probe_trigger(struct iio_dev *indio_dev, int irq, u32 irq_type)
 	ret = devm_request_irq(&indio_dev->dev, irq,
 			       &iio_trigger_generic_data_rdy_poll,
 			       irq_type, "bmi160", data->trig);
-	if (ret < 0)
+	if (ret)
 		return ret;
 
 	data->trig->dev.parent = regmap_get_device(data->regmap);
@@ -816,11 +816,11 @@ int bmi160_core_probe(struct device *dev, struct regmap *regmap,
 	data->regmap = regmap;
 
 	ret = bmi160_chip_init(data, use_spi);
-	if (ret < 0)
+	if (ret)
 		return ret;
 
 	ret = devm_add_action_or_reset(dev, bmi160_chip_uninit, data);
-	if (ret < 0)
+	if (ret)
 		return ret;
 
 	if (!name && ACPI_HANDLE(dev))
@@ -836,7 +836,7 @@ int bmi160_core_probe(struct device *dev, struct regmap *regmap,
 	ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
 					      iio_pollfunc_store_time,
 					      bmi160_trigger_handler, NULL);
-	if (ret < 0)
+	if (ret)
 		return ret;
 
 	irq = bmi160_get_irq(dev->of_node, &int_pin);
@@ -849,11 +849,7 @@ int bmi160_core_probe(struct device *dev, struct regmap *regmap,
 		dev_info(&indio_dev->dev, "Not setting up IRQ trigger\n");
 	}
 
-	ret = devm_iio_device_register(dev, indio_dev);
-	if (ret < 0)
-		return ret;
-
-	return 0;
+	return devm_iio_device_register(dev, indio_dev);
 }
 EXPORT_SYMBOL_GPL(bmi160_core_probe);
 
-- 
2.11.0

