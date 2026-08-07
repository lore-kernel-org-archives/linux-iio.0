Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66A5D384CD5
	for <linux-iio@vger.kernel.org>; Fri,  7 Aug 2026 21:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786137630; cv=none; b=sk9ECbV3piD+Vb7mfQF8Scq2wMKOpkEmLQ56oOF1DkYWb+jpBHW52L4eFFGgg0dTXX0Ag4xWAfydzjxGN/okCL32gKLMzy1ooYMLnnJmMYXJkWwxFjGGMesKmd7+h0/NxXirL0FLD7PaDm/yJwUEFBJnC8TI6Ng/QA1xj1ldkxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786137630; c=relaxed/simple;
	bh=LOXD6lQpsc5v2fDlCt96BEWcT+3USpZ3SEh817UiXVw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jHJZcUfiMx8W6SNnD0EhNn7kO+rCT5FHUGMcMo2GevGtM6OgNhz8rjF4V2XcuZoZeN560IHKsQr/FNb/q6QUVChN4WvSV5UbTdpF8Gy8Htmmn7AkgebbYmS8D3TgB7gZH1XCI5XX57imQzBmAQhORhMz45WZ7q/eV1yy8FzgmRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=ow5XCauQ; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="ow5XCauQ"
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-44cf70de986so1554731fac.0
        for <linux-iio@vger.kernel.org>; Fri, 07 Aug 2026 14:20:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1786137627; x=1786742427; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TQNemVwVlgoGHybAoiu8NfPpD2hESMvFryh6aBFSse4=;
        b=ow5XCauQHDBqjLyB2BWItxe7HRQvTnOZYOJIW97CvY1HLbQE/3OKTHOoUnU68uETL2
         7fKcspPcG7Bat4NLj6T3mQi33t8Xg8R8NknqZQ+RPyypZjIwSdFTDhfLZcMq/1VZZqYa
         Nb0z0gupn01KwhUhq5RhBwbsDquva/NJBxTno+z5G2FxkAHFAXb6GFd1SRVi6lG78IHr
         Of3wIRp4tmsLA5+v9wThHbUoxv1nHEX7BxTWN7kkxvt3MFfQaA3iep4YzHramye/UVcC
         gOIWB9eIzpsUUiEDmVObiv8/GUD14/i9IZwao8Haa5VmEpbNJStuZW3GXCP3UnsDy/l5
         B/HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786137627; x=1786742427;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TQNemVwVlgoGHybAoiu8NfPpD2hESMvFryh6aBFSse4=;
        b=b846tGxbReNzjCsOR6ZSXvnygZsSXUgvzPKimHIx26OMp4mb3HcEQTvKYFXm9VXvWt
         n7P79I1B53NJJZtX8rOax4qGQBJsYmozaoAWFBhL2eqisw2Z64txi5W7t1gtAy2+FvCc
         9Uy2zaSGmS/zSlu1CcKwPuX0BOMQmOdQB0atvbc3UzY2haAFuHcirDiU36g5UyyTU4Gf
         zxawc9Zvjbw5JVzpAisMbzt8lHkSL2U6QNnFmabEY9hoI6l2bhlUUzVKgMHHJZYXMMqr
         WZ8DGO+g0JQNbwKjIJqsewlUWYElbakxshDbAhTmuFtoxuAnjZ79YObndERlh1v8EtUf
         e7lQ==
X-Forwarded-Encrypted: i=1; AHgh+RqmCJ7ATG+YiZ7Y353VL1PHFSYbfmHARm4wbLYbJPF+l2nPNCbH231+63NgPLm4PQ/xDlntD8QPD3w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJX4t6tzIMpiEuz6vOcXCcjriHeGZapHPys8eR9evi83QBENYp
	E3N5mTfxaHXK3LEcgt4vDXy7t3MrWl9i+X984C9iso2nR23eGsM7ZkuuRuAQFzyOLj4=
X-Gm-Gg: AR+sD125SOYGnHaeSI2Z0E67E0+GWySLvabVPFYANZi21awpmy8XlSmVmjLVM79wVSd
	/l17gHviLKYqxA/bZ2z3gk9qMwIm5JtDglF6UUeQE+MNAeJ67Ps45U8hq3M5HCZlt4ZOLfb7n9J
	xIT5tDWAB5HfvQtX8L1P3FrPjX5MN8gtZIDRs+rKNmiGmaBkdeI8PnPKHeI8eGB56UStOIwdqK2
	m8+lO0qmZpI5wlRvDTZ7oi79p+6c/2r+nqEI2guAipDKHT5BCoaGORo2W8RauQ98psfmc47Gxtp
	9zs8yOlBpdv7NBKMTUNacVsWT7DZQTiqCoaI45bEOkoJ2qFzt/TlX4buai5lLqU7NqPSryTVaVi
	nwZDyW4k5GsjqrZxorXQZfJRyb5c7CVbY0BEfb5GFklzOUxSCTHsU+q5V+tELx8HtpDVbmSF4a9
	Dj/PlAcYPL03Z6wh/JDyehDlUP/4lN/FHuI3RTWr49u3tS+rv14dgRsf8Cq2BIpHs2l45SNRuTV
	U0=
X-Received: by 2002:a05:6808:2507:b0:495:f67c:d96a with SMTP id 5614622812f47-4b1ab96cf62mr1661945b6e.12.1786137627228;
        Fri, 07 Aug 2026 14:20:27 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:b714:88c:313d:dee2])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4b1af0bafa1sm508068b6e.7.2026.08.07.14.20.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 14:20:25 -0700 (PDT)
From: "David Lechner (TI)" <dlechner@baylibre.com>
Date: Fri, 07 Aug 2026 16:19:46 -0500
Subject: [PATCH v3 1/3] iio: adc: ti-ads112c14: add DRDY interrupt support
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260807-iio-adc-ti-ads112c14-continuous-mode-v3-1-76e0d30e6c6b@baylibre.com>
References: <20260807-iio-adc-ti-ads112c14-continuous-mode-v3-0-76e0d30e6c6b@baylibre.com>
In-Reply-To: <20260807-iio-adc-ti-ads112c14-continuous-mode-v3-0-76e0d30e6c6b@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: Chris Hall <c-hall@ti.com>, Patrick Edwards <pedwards@ti.com>, 
 Kurt Borja <kuurtb@gmail.com>, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, "David Lechner (TI)" <dlechner@baylibre.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=6042; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=LOXD6lQpsc5v2fDlCt96BEWcT+3USpZ3SEh817UiXVw=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBqdkv8nw46oZ11cbi+i0AWM1bCN8+ycW0fGrBXU
 87/JcTovaSJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCanZL/AAKCRDCzCAB/wGP
 wI2PCACVi9GZ6joum7tbm2Vqgwu5UUAShfZFj30FlvSqkZPh5Dz9qk3h80AxQ5hoNd75dp4rI+z
 4B5LVHCWAIrsBtFJoolANNk+nU+tMGe7tgzG+NReY47n5DxJQ8IQ+s45z0s62OkJLUG+Qpqaqr2
 Feitmxy6Ldp8pjDpgTs7ykCDwF8g2prxx5btRnhzTnwuqzlvHj+SGslRhqN8PC0MjenPfIaMc4D
 c7M/S/9kePk1R0LGgMGdZuI7k/YAUTiLUYF801OXqfZqOBaN6IRn5d6X34GHlrFF4d1IALxi8vn
 IsdVZUi7R9t0tiJD3iqgVxN6vx2pGzZxYnXDKDSo+E/gyLmm
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
 drivers/iio/adc/ti-ads112c14.c | 100 ++++++++++++++++++++++++++++++++++++-----
 1 file changed, 90 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/adc/ti-ads112c14.c b/drivers/iio/adc/ti-ads112c14.c
index 60eab4852ba2..457d2db28d3f 100644
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
@@ -581,12 +601,45 @@ static int ads112c14_prepare_sys_mon_channel(struct ads112c14_data *data,
 	return 0;
 }
 
+static int ads112c14_wait_for_conversion_irq(struct ads112c14_data *data)
+{
+	unsigned long remaining;
+	int ret;
+
+	reinit_completion(&data->drdy_completion);
+
+	ret = regmap_write(data->regmap, ADS112C14_REG_CONVERSION_CTRL,
+			   ADS112C14_CONVERSION_CTRL_START);
+	if (ret)
+		return ret;
+
+	remaining = wait_for_completion_timeout(&data->drdy_completion,
+						msecs_to_jiffies(100));
+
+	return remaining ? 0 : -ETIMEDOUT;
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
@@ -601,15 +654,10 @@ static int ads112c14_single_conversion(struct ads112c14_data *data,
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
 
@@ -1391,6 +1439,38 @@ static int ads112c14_probe(struct i2c_client *client)
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
+				       0, dev_name(dev), indio_dev);
+		if (ret)
+			return ret;
+	}
+
 	ads112c14_populate_tables(data);
 
 	indio_dev->name = info->name;

-- 
2.43.0

