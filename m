Return-Path: <SRS0=Uw90=OT=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C71EDC04EB8
	for <linux-iio@archiver.kernel.org>; Mon, 10 Dec 2018 03:15:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C0892081F
	for <linux-iio@archiver.kernel.org>; Mon, 10 Dec 2018 03:15:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=martingkelly-com.20150623.gappssmtp.com header.i=@martingkelly-com.20150623.gappssmtp.com header.b="Ivmk/HFi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C0892081F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=martingkelly.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-iio-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726368AbeLJDO7 (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 9 Dec 2018 22:14:59 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:41718 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726355AbeLJDO7 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 9 Dec 2018 22:14:59 -0500
Received: by mail-pl1-f196.google.com with SMTP id u6so4533340plm.8
        for <linux-iio@vger.kernel.org>; Sun, 09 Dec 2018 19:14:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=martingkelly-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=wPJwHtC69mqz1/Ebq3TFPG0ipESl+zOPcU23XQBbMSI=;
        b=Ivmk/HFiGjo4HivoNjkVlmx04rpxqcRCXt0gV2djdshyLYuiRCx6/eC8ZR85bzgTWk
         bY2l2a1/nblqq5hZVFEY6PUglX8N8+EMGoGc8u1aEl2gC0buMcotn+DFjrwZWyA+lgDc
         EOmfahDO3f55RKx3on8ItmWnRrmlOFz8Of3MJ7tE268b1SoV+6futPZhLMO0HViZCUVB
         COIp6yZ9LO6jLpmfD9W4aXoOWKpNTGYCN5H52BT5dO8Qhfg9bCPy3EyiP8NVuKOZ5k7O
         raD5zkFyvWJtJEQpD6eS/PyrOkSWv/IVhfBxsBwVwj7KUTKEDuhBuBtbcOZxwzElfFdl
         rupg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=wPJwHtC69mqz1/Ebq3TFPG0ipESl+zOPcU23XQBbMSI=;
        b=ks6BTfbgo25nGmurRWzGrFxzpkFQ/WqSKnMeJqn3aoQnb8scmW/8Pc+7UIrI8yQXom
         RXqNGJqnAbYy7tBOwqx6vymWKR1do6g0oUjk7FlYXhAVU2pOmOYo2qxcv0Ww3EhEMfLv
         bBJbIIURG7G8UOHM/rGGE0cmkDDjc39sJAdGY7l0MIvnaBnAFzBTHZVbZHoS9p10Pazb
         ibnuHEaikdWFHLBDVzrl27oIRAB7mOLlSRvvEmLQ7+qtV/kPGgXfQb71kyTIPQsfgeSJ
         nORMatvt+7SJzzE0+0RCxfu/IVXsuxdUVry0+MRNOkd3/rR+wE0k1tGBmcRcqNpS7z2F
         WAcA==
X-Gm-Message-State: AA+aEWblqRoKyNKr2C5FwzVReWsW1wuS58A7Ejs1gm56I6aGNwTaMVVs
        f8hQUNIBjTxO+vbsUYjmU9hdK/Ko848=
X-Google-Smtp-Source: AFSGD/X5DlSePVIwNhOhK5Pzc48RhybuHTHOpOw5ZyAXwME7B8EyG1Fc77Y6migA5yUhse72eBPolQ==
X-Received: by 2002:a17:902:380c:: with SMTP id l12mr10366208plc.326.1544411698340;
        Sun, 09 Dec 2018 19:14:58 -0800 (PST)
Received: from cascade.Home (97-113-252-154.tukw.qwest.net. [97.113.252.154])
        by smtp.gmail.com with ESMTPSA id x27sm22781712pfe.178.2018.12.09.19.14.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 09 Dec 2018 19:14:57 -0800 (PST)
From:   Martin Kelly <martin@martingkelly.com>
X-Google-Original-From: Martin Kelly <martin@martingkelly.com
To:     linux-iio@vger.kernel.org
Cc:     Daniel Baluta <daniel.baluta@intel.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Martin Kelly <martin@martingkelly.com>
Subject: [PATCH v2] iio: bmi160: use all devm functions in probe
Date:   Sun,  9 Dec 2018 19:14:55 -0800
Message-Id: <20181210031455.2836-1-martin@martingkelly.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Martin Kelly <martin@martingkelly.com>

Currently, we're using the devm version of some but not all functions.
Switch to the devm version of iio_triggered_buffer_setup and
iio_device_register to simplify the code a bit and decrease the chance of
bugs.

Signed-off-by: Martin Kelly <martin@martingkelly.com>
---
v2:
- Use devm_add_action_or_reset to prevent device uninit prior to unregister.

 drivers/iio/imu/bmi160/bmi160_core.c | 38 +++++++++++++-----------------------
 drivers/iio/imu/bmi160/bmi160_i2c.c  |  8 --------
 drivers/iio/imu/bmi160/bmi160_spi.c  |  8 --------
 3 files changed, 14 insertions(+), 40 deletions(-)

diff --git a/drivers/iio/imu/bmi160/bmi160_core.c b/drivers/iio/imu/bmi160/bmi160_core.c
index c85659ca9507..b10330b0f93f 100644
--- a/drivers/iio/imu/bmi160/bmi160_core.c
+++ b/drivers/iio/imu/bmi160/bmi160_core.c
@@ -542,10 +542,12 @@ static int bmi160_chip_init(struct bmi160_data *data, bool use_spi)
 	return 0;
 }

-static void bmi160_chip_uninit(struct bmi160_data *data)
+static void bmi160_chip_uninit(void *data)
 {
-	bmi160_set_mode(data, BMI160_GYRO, false);
-	bmi160_set_mode(data, BMI160_ACCEL, false);
+	struct bmi160_data *bmi_data = data;
+
+	bmi160_set_mode(bmi_data, BMI160_GYRO, false);
+	bmi160_set_mode(bmi_data, BMI160_ACCEL, false);
 }

 int bmi160_core_probe(struct device *dev, struct regmap *regmap,
@@ -567,6 +569,10 @@ int bmi160_core_probe(struct device *dev, struct regmap *regmap,
 	if (ret < 0)
 		return ret;

+	ret = devm_add_action_or_reset(dev, bmi160_chip_uninit, data);
+	if (ret < 0)
+		return ret;
+
 	if (!name && ACPI_HANDLE(dev))
 		name = bmi160_match_acpi_device(dev);

@@ -577,35 +583,19 @@ int bmi160_core_probe(struct device *dev, struct regmap *regmap,
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->info = &bmi160_info;

-	ret = iio_triggered_buffer_setup(indio_dev, NULL,
-					 bmi160_trigger_handler, NULL);
+	ret = devm_iio_triggered_buffer_setup(dev, indio_dev, NULL,
+					      bmi160_trigger_handler, NULL);
 	if (ret < 0)
-		goto uninit;
+		return ret;

-	ret = iio_device_register(indio_dev);
+	ret = devm_iio_device_register(dev, indio_dev);
 	if (ret < 0)
-		goto buffer_cleanup;
+		return ret;

 	return 0;
-buffer_cleanup:
-	iio_triggered_buffer_cleanup(indio_dev);
-uninit:
-	bmi160_chip_uninit(data);
-	return ret;
 }
 EXPORT_SYMBOL_GPL(bmi160_core_probe);

-void bmi160_core_remove(struct device *dev)
-{
-	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct bmi160_data *data = iio_priv(indio_dev);
-
-	iio_device_unregister(indio_dev);
-	iio_triggered_buffer_cleanup(indio_dev);
-	bmi160_chip_uninit(data);
-}
-EXPORT_SYMBOL_GPL(bmi160_core_remove);
-
 MODULE_AUTHOR("Daniel Baluta <daniel.baluta@intel.com");
 MODULE_DESCRIPTION("Bosch BMI160 driver");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/iio/imu/bmi160/bmi160_i2c.c b/drivers/iio/imu/bmi160/bmi160_i2c.c
index 155a31f72445..5b1f7e6af651 100644
--- a/drivers/iio/imu/bmi160/bmi160_i2c.c
+++ b/drivers/iio/imu/bmi160/bmi160_i2c.c
@@ -38,13 +38,6 @@ static int bmi160_i2c_probe(struct i2c_client *client,
 	return bmi160_core_probe(&client->dev, regmap, name, false);
 }

-static int bmi160_i2c_remove(struct i2c_client *client)
-{
-	bmi160_core_remove(&client->dev);
-
-	return 0;
-}
-
 static const struct i2c_device_id bmi160_i2c_id[] = {
 	{"bmi160", 0},
 	{}
@@ -72,7 +65,6 @@ static struct i2c_driver bmi160_i2c_driver = {
 		.of_match_table		= of_match_ptr(bmi160_of_match),
 	},
 	.probe		= bmi160_i2c_probe,
-	.remove		= bmi160_i2c_remove,
 	.id_table	= bmi160_i2c_id,
 };
 module_i2c_driver(bmi160_i2c_driver);
diff --git a/drivers/iio/imu/bmi160/bmi160_spi.c b/drivers/iio/imu/bmi160/bmi160_spi.c
index d34dfdfd1a7d..e521ad14eeac 100644
--- a/drivers/iio/imu/bmi160/bmi160_spi.c
+++ b/drivers/iio/imu/bmi160/bmi160_spi.c
@@ -29,13 +29,6 @@ static int bmi160_spi_probe(struct spi_device *spi)
 	return bmi160_core_probe(&spi->dev, regmap, id->name, true);
 }

-static int bmi160_spi_remove(struct spi_device *spi)
-{
-	bmi160_core_remove(&spi->dev);
-
-	return 0;
-}
-
 static const struct spi_device_id bmi160_spi_id[] = {
 	{"bmi160", 0},
 	{}
@@ -58,7 +51,6 @@ MODULE_DEVICE_TABLE(of, bmi160_of_match);

 static struct spi_driver bmi160_spi_driver = {
 	.probe		= bmi160_spi_probe,
-	.remove		= bmi160_spi_remove,
 	.id_table	= bmi160_spi_id,
 	.driver = {
 		.acpi_match_table	= ACPI_PTR(bmi160_acpi_match),
--
2.11.0

