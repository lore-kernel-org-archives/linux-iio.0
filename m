Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49FA53264F7
	for <linux-iio@vger.kernel.org>; Fri, 31 Jul 2026 23:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785541727; cv=none; b=oR1qOcAdn/yES+BDMyk9ltk1ahhfogkBeFylwBnYlSx5/CxL00vbKLlKz1LBGcWjHOsctbmlpq/HHa4ukMoSN/Y066drRDEKQZqMee0wSOfPEjkudJ+miSxavhCvJkFQbX9h3KSQvTz9PnyZwwOCP3isjLETdXlM0aQPpJUhGEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785541727; c=relaxed/simple;
	bh=k736qChxNvgkAm2LBCV31cD00UlFtg6ggFAPO2QDIo0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qS2N3r4mW7A4ghzZ9pY19Bh+dvOxa8POBTMO7LmNTrXkQW2L/EUwjqbtfbNLjpM9AH4rEM/L9h/einQgxxJzByGzoI7C9nuu3Fu/18mkBRCf6PBhUE0CaE/soE0Csmc2McWAre0UHHzP+SFy4NnkgT9v7/67qs+eDLzBGL2blIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=R6XizZXS; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="R6XizZXS"
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-7e9eaf04bfaso622963a34.1
        for <linux-iio@vger.kernel.org>; Fri, 31 Jul 2026 16:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1785541725; x=1786146525; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yBCLt57qHjd30ODnQE9rhM4LVAadv0RUWgg23EnaUhA=;
        b=R6XizZXSbO5Csw9Nnl+HTCxDFIo7z3c3yTowLCjnG9/4oIBd+AEUgiP89DdKINzzNt
         kDMRS+Jrg7ieyj4cqLU4hAbBzf/u3cgkpGcXx6NuTSbEyfat8utGFinvRt8EO1DtxgMz
         EqS3TA9kP1C2VHBnsi6wHxEJ+exSNsAaZ+pSqCMIXBVT62LLk5+x42Ii2FTP0ivYUl/q
         ghEmOoASuQVgBiHmsoWGdu5iBHs0k2NMOjzmirCn4/uxen1S2IZHiJILpycLpJjqFP6L
         seYEhuXoCeJu/xBSDQ6lBHfp74fryisvWtv3r+WJ4GTGli6CELzg1w4vWskiN/0a+cHN
         ZbjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785541725; x=1786146525;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yBCLt57qHjd30ODnQE9rhM4LVAadv0RUWgg23EnaUhA=;
        b=tSaCyBV3E36O6aj4qqjjFIVn7+7n2oJqcLCEPrxrNHdk2DszpYxXpcvj1xBjT1cAZJ
         61WgAYS4QrDkrrKMjj1Wk/u0OC5MSlWvjxjKdpgPeVt2hhovFjjp17+xW/lbScdTpcBr
         4W0zdNB2yWc4wdActWtrXiasamGn3A/6haMerWcLty2swGCKGhxpQT1XFe1mNXLUCAnv
         v8iFhzXRRbqlOsr7WPE2YrYXkIHmYEChZ9MQaCgI/s5T6DWzg4To2MLfksDx/ZMnyJZb
         M3Qmkwd7EZvMN3O8ArSlTXf9WfSQCLASK1h36wqnb+scHlAlhm8ZTADB7bZzrAGN+/B6
         fBgA==
X-Forwarded-Encrypted: i=1; AHgh+RqHC0c9ECC/hCgrjiNOA93SD+9SO53qJW+I4Ie6X4Hx75sZV6wG6BxCc7V471Bd4LQqhwqNEnFib3o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzP5CJlhSTftfdn2NctS7N4w3TnLqAGdi5Xj/zPcjFM4b8cHuvd
	ZyqoGfbyu9moJvOWGWZBI0ofuZVehw3RMPYBGbJRrhsi8+i3czoyNr/XHN2Z26kCx2I=
X-Gm-Gg: AR+sD12zFGE8YSHY+GJAeJ2lGtoLZAVb56lT+fuWJQvw08fYctSfKg14JT1cOU/NnVG
	qnNOx7SF0qEfm9IUu6wMn8vq+zPLhljUGjnCap+hWDAYi+zdR+bYqVFsk/dKKG37kIMwShAo2nS
	dgAbhzmt48oUaVSI3boeJyHGxzVN58HscnMDYZJyrNRsd7aaAX8PHV5X6PSKY6s5smgIQc0l6mP
	skXc7XYuDDSoV+Dr5BxO7FrczMvFPsySVMWfbMFvpkGkxul9YzDcOfyjcGkqplgRuskS12Mc1i7
	rie0AFPU7QcYcX01BsV5GXh5bV57XT8+mNPKkCAJ63ThCMqGIrNZQXZD5CM4DzDO6YOfnolfJ2H
	iFfZ/k7u85PzkPuA058PqjPQuwRcwMIKmZaZXKBctwak6r1l0YCQ5WDYpeUIGPoHxVTnjAFxx82
	yTA2begqI5FHn8lLEpCUlX6XAXpjbsdhNB+P1HL7RA3AspPh541i7Ucs1VerWnSZNSwQ==
X-Received: by 2002:a05:6830:82aa:b0:7e9:5022:3639 with SMTP id 46e09a7af769-7f196ed599fmr3609201a34.15.1785541725270;
        Fri, 31 Jul 2026 16:48:45 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:fa40:746f:401a:3b75])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f18ed3c814sm1736940a34.6.2026.07.31.16.48.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 16:48:44 -0700 (PDT)
From: "David Lechner (TI)" <dlechner@baylibre.com>
Date: Fri, 31 Jul 2026 18:48:10 -0500
Subject: [PATCH v2 1/3] iio: adc: ti-ads112c14: add DRDY interrupt support
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260731-iio-adc-ti-ads112c14-continuous-mode-v2-1-eb13da38e8fc@baylibre.com>
References: <20260731-iio-adc-ti-ads112c14-continuous-mode-v2-0-eb13da38e8fc@baylibre.com>
In-Reply-To: <20260731-iio-adc-ti-ads112c14-continuous-mode-v2-0-eb13da38e8fc@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: Chris Hall <c-hall@ti.com>, Patrick Edwards <pedwards@ti.com>, 
 Kurt Borja <kuurtb@gmail.com>, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, "David Lechner (TI)" <dlechner@baylibre.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=6140; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=k736qChxNvgkAm2LBCV31cD00UlFtg6ggFAPO2QDIo0=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBqbTRFkP9M5eM7+bxEg1M0Z0/ml+5cLyf9/YaLJ
 GWzdekD7GKJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCam00RQAKCRDCzCAB/wGP
 wPtlB/9YxOK9ZusClAm+2DHPMDl+9KACXQZcz+18LLka/2vZH3/EEt9YzCnziN18f1aecxLf1g6
 DMnGB471/ed+WurzbRSe7ypsFZUYa0bfpUndclhZ8l5HsIhgywQMvWvGmz7pLouh4H7VLWZ30uk
 mFzXHBow/YWa6b8yiwn4PRJzJEjevA962j9So7nR2JSzNA2LXbwAnLntU4rAEJF28ea5qZ+IpMP
 6wl1bcd21EE2yxZwwDESIPHFOzAG2Zwt9qKe6xjlssnkTtj4IkQbCKmnYYJ7pIhHvyrpk0JZmSE
 ZjmV0dCxKRG2C/QYl8dc1ttGtcqFyknT9Tg1jwpsVTibgxch
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Add handling for the DRDY interrupt to wait for data ready events rather
than polling (only when it is wired up).

Signed-off-by: David Lechner (TI) <dlechner@baylibre.com>
---

Small note: the hard-coded 100 ms timeout will be replaced in a future
series with a dynamic value, so I didn't bother with a macro or comments
to explain why the value was chosen.

And passing indio_dev instead of data to irq is intentional as it will
be used in the next patch.
---
 drivers/iio/adc/ti-ads112c14.c | 105 +++++++++++++++++++++++++++++++++++++----
 1 file changed, 95 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/adc/ti-ads112c14.c b/drivers/iio/adc/ti-ads112c14.c
index 8ad8caee0ff7..177f7064092e 100644
--- a/drivers/iio/adc/ti-ads112c14.c
+++ b/drivers/iio/adc/ti-ads112c14.c
@@ -10,6 +10,7 @@
 
 #include <linux/bitfield.h>
 #include <linux/cleanup.h>
+#include <linux/completion.h>
 #include <linux/crc8.h>
 #include <linux/delay.h>
 #include <linux/dev_printk.h>
@@ -19,6 +20,7 @@
 #include <linux/iio/iio.h>
 #include <linux/iio/trigger_consumer.h>
 #include <linux/iio/triggered_buffer.h>
+#include <linux/interrupt.h>
 #include <linux/math64.h>
 #include <linux/minmax.h>
 #include <linux/module.h>
@@ -117,9 +119,15 @@
 #define   ADS112C14_GPIO_CFG_GPIO2_CFG			GENMASK(5, 4)
 #define   ADS112C14_GPIO_CFG_GPIO1_CFG			GENMASK(3, 2)
 #define   ADS112C14_GPIO_CFG_GPIO0_CFG			GENMASK(1, 0)
+#define     ADS112C14_GPIO_CFG_GPIO_CFG_DISABLED	  0
+#define     ADS112C14_GPIO_CFG_GPIO_CFG_INPUT		  1
+#define     ADS112C14_GPIO_CFG_GPIO_CFG_OUTPUT_PUSH_PULL  2
+#define     ADS112C14_GPIO_CFG_GPIO_CFG_OUTPUT_OPEN_DRAIN 3
 
 #define ADS112C14_REG_GPIO_DATA_OUTPUT			0x0C
 #define   ADS112C14_GPIO_DATA_OUTPUT_GPIO3_SRC		BIT(7)
+#define     ADS112C14_GPIO_DATA_OUTPUT_GPIO3_SRC_DAT_OUT  0
+#define     ADS112C14_GPIO_DATA_OUTPUT_GPIO3_SRC_DRDY	  1
 #define   ADS112C14_GPIO_DATA_OUTPUT_GPIO2_SRC		BIT(6)
 #define   ADS112C14_GPIO_DATA_OUTPUT_GPIO3_DAT_OUT	BIT(3)
 #define   ADS112C14_GPIO_DATA_OUTPUT_GPIO2_DAT_OUT	BIT(2)
@@ -251,6 +259,8 @@ struct ads112c14_data {
 	struct regmap *regmap;
 	/* Synchronizes access to register value fields. */
 	struct mutex lock;
+	int drdy_irq;
+	struct completion drdy_completion;
 	bool i2c_crc_enabled;
 	u32 avdd_uV;
 	u32 ext_ref_uV;
@@ -265,6 +275,16 @@ struct ads112c14_data {
 						 ARRAY_SIZE(ads112c14_sys_mon_channels));
 };
 
+static irqreturn_t ads112c14_drdy_irq_handler(int irq, void *private)
+{
+	struct iio_dev *indio_dev = private;
+	struct ads112c14_data *data = iio_priv(indio_dev);
+
+	complete(&data->drdy_completion);
+
+	return IRQ_HANDLED;
+}
+
 static bool ads112c14_writeable_reg(struct device *dev, unsigned int reg)
 {
 	switch (reg) {
@@ -581,12 +601,50 @@ static int ads112c14_prepare_sys_mon_channel(struct ads112c14_data *data,
 	return 0;
 }
 
+static int ads112c14_wait_for_conversion_irq(struct ads112c14_data *data)
+{
+	unsigned long remaining;
+	int ret;
+
+	reinit_completion(&data->drdy_completion);
+	enable_irq(data->drdy_irq);
+
+	ret = regmap_write(data->regmap, ADS112C14_REG_CONVERSION_CTRL,
+			   ADS112C14_CONVERSION_CTRL_START);
+	if (ret)
+		goto out;
+
+	remaining = wait_for_completion_timeout(&data->drdy_completion,
+						msecs_to_jiffies(100));
+	ret = remaining ? 0 : -ETIMEDOUT;
+
+out:
+	disable_irq(data->drdy_irq);
+
+	return ret;
+}
+
+static int ads112c14_wait_for_conversion_poll(struct ads112c14_data *data)
+{
+	u32 reg_val;
+	int ret;
+
+	ret = regmap_write(data->regmap, ADS112C14_REG_CONVERSION_CTRL,
+			   ADS112C14_CONVERSION_CTRL_START);
+	if (ret)
+		return ret;
+
+	return regmap_read_poll_timeout(data->regmap,
+					ADS112C14_REG_STATUS_MSB, reg_val,
+					FIELD_GET(ADS112C14_STATUS_MSB_DRDY, reg_val),
+					1 * USEC_PER_MSEC, 100 * USEC_PER_MSEC);
+}
+
 static int ads112c14_single_conversion(struct ads112c14_data *data,
 				       const struct iio_chan_spec *chan,
 				       u8 *buf, bool for_scan)
 {
 	struct i2c_client *client = to_i2c_client(regmap_get_device(data->regmap));
-	u32 reg_val;
 	int ret;
 
 	guard(mutex)(&data->lock);
@@ -601,15 +659,10 @@ static int ads112c14_single_conversion(struct ads112c14_data *data,
 			return ret;
 	}
 
-	ret = regmap_write(data->regmap, ADS112C14_REG_CONVERSION_CTRL,
-			   ADS112C14_CONVERSION_CTRL_START);
-	if (ret)
-		return ret;
-
-	ret = regmap_read_poll_timeout(data->regmap,
-				       ADS112C14_REG_STATUS_MSB, reg_val,
-				       FIELD_GET(ADS112C14_STATUS_MSB_DRDY, reg_val),
-				       1 * USEC_PER_MSEC, 100 * USEC_PER_MSEC);
+	if (data->drdy_irq)
+		ret = ads112c14_wait_for_conversion_irq(data);
+	else
+		ret = ads112c14_wait_for_conversion_poll(data);
 	if (ret)
 		return ret;
 
@@ -1392,6 +1445,38 @@ static int ads112c14_probe(struct i2c_client *client)
 	if (ret)
 		return ret;
 
+	if (device_property_present(dev, "interrupts")) {
+		data->drdy_irq = fwnode_irq_get_byname(dev_fwnode(dev), "drdy");
+		if (data->drdy_irq < 0)
+			return dev_err_probe(dev, data->drdy_irq,
+					     "failed to get drdy interrupt\n");
+
+		/*
+		 * REVISIT: would probably need to implement a pin controller in
+		 * order to support open drain option here.
+		 */
+		ret = regmap_update_bits(data->regmap, ADS112C14_REG_GPIO_CFG,
+					 ADS112C14_GPIO_CFG_GPIO3_CFG,
+					 FIELD_PREP(ADS112C14_GPIO_CFG_GPIO3_CFG,
+						    ADS112C14_GPIO_CFG_GPIO_CFG_OUTPUT_PUSH_PULL));
+		if (ret)
+			return ret;
+
+		ret = regmap_update_bits(data->regmap, ADS112C14_REG_GPIO_DATA_OUTPUT,
+					 ADS112C14_GPIO_DATA_OUTPUT_GPIO3_SRC,
+					 FIELD_PREP(ADS112C14_GPIO_DATA_OUTPUT_GPIO3_SRC,
+						    ADS112C14_GPIO_DATA_OUTPUT_GPIO3_SRC_DRDY));
+		if (ret)
+			return ret;
+
+		init_completion(&data->drdy_completion);
+
+		ret = devm_request_irq(dev, data->drdy_irq, ads112c14_drdy_irq_handler,
+				       IRQF_NO_AUTOEN, dev_name(dev), indio_dev);
+		if (ret)
+			return ret;
+	}
+
 	ads112c14_populate_tables(data);
 
 	indio_dev->name = info->name;

-- 
2.43.0

