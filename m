Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F354B221F26
	for <linux-iio@vger.kernel.org>; Thu, 10 Sep 2026 21:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789074882; cv=none; b=JiqdlvQALvd1eXuLDWJnB5HXsspWcWZVhmmb7YEJqqhkg17YJRR/i0ln1I1Gh7/ZIexPIqcdQbtYt3SRuxjkgdigVnZPR8EdwcESHfUZ84YWAC0HU3PqSbVJmNm8idY17dcunJrHlCeGwvuBjCF5xRPjbb3f0LOoLYvWD2k2tEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789074882; c=relaxed/simple;
	bh=VauWigPxn+Z06uluw3jfgiSH2uLFsBfjesGM7iHnEqM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=G7rNZ1JTZMi4hIxFkwCIKRUv0SY7s+dOUTzoBS/Z3dvCYvZQykgmPM1jaU7IlkvNQsfUqIe1weuqoGqNuvAAId1oQnEezqGlGsjbWh87+hvy8ox2a1rIgIgPsbTtlM3Xyejg547+LfJUIho52aU64bLJBgiq3qwXpS7B8JgVFGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=QOdaOJ1o; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="QOdaOJ1o"
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-4b28df1f600so259162b6e.2
        for <linux-iio@vger.kernel.org>; Thu, 10 Sep 2026 14:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1789074872; x=1789679672; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2twO4FOA5lpjNQCxYEeZuWL/IrJEo6qIPnLetgsF0Cc=;
        b=QOdaOJ1o61lBpyuGceeXAwHeeWyCtUEuXrHcpOkeJzBWpqBrvIUEIRs9etaxk2JGRP
         ZLY8jqrNjaJUC1koxks/IihYpU8x+Stuia4JSgHtebD+OcLw82U1eiW6n/yLxHyIdunp
         oaY5d325Gzpwhqa1ObvC0P8eoAj2r3UJVs9Q5L4wJ3cqyMP+MNMPUulXyuVjxTpTimQM
         xJyn9G2p5asrdbsMuY/uRSizva4tgGaBHywZ9DixxYi4RzltBvdN1m8qVWB+CMhbwtFU
         96ELHXoYZbW/HR3icNTHcMekdsWjqIinnaxlD3TzrgLbZ7jmCSRzle3xqct3nhoGyQ2r
         zcZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789074872; x=1789679672;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2twO4FOA5lpjNQCxYEeZuWL/IrJEo6qIPnLetgsF0Cc=;
        b=Y1abVZGOT8RtPVJfPfgYEE3fICc+UxEg1ONA1bed5gU0fTw8K58EC1POvVkp4Nj83e
         pa2OcZ2WTMZ6HSyLX8I08WXkIv/7VWfFfG5ynQ6AGzGYUGeoeUeZxci8Ck1DjZ0RNn9Q
         RVaIzFPRky3i2P6O3R5tv19moWDwNRN9zNNMPSu/CMBZ3Ye68eAUDpmqU1q4A7Epcx+I
         3TInQ+bD+stdk6W5tcVuP6wuCiePgNluLSlXfGAL5VWBl/Mor550Dc21ahaI+C3a7BZ7
         8jeyKbqgNLhwhlNh+IY1KJRVqAVFn0zxs4ek0I2qXdxc6CUthQRgVgV9REhYj+gAWHJZ
         9A7w==
X-Forwarded-Encrypted: i=1; AKwUvBy/YeQyCv6xQ52174yCM6z+NuI+WGoxnjqFY4X0izgK/38kOuoXMiLfHWEb7UvqgjwtHnkuxRVc2mw=@vger.kernel.org
X-Gm-Message-State: AFuF++mGF9WSO/gCz5uKlPe76+kR7nKwtRiN/aP0JLeXYW+QkZfsCdiF
	/O/2ETFIB7R3L5zp7ceBNwqu8xBqUklcR+rSwDbn5Fw+HLWIoshMgpND3qhUuPYC+VM=
X-Gm-Gg: AYBFou2EWM88YTI4Sz5r8xVcRCY+4XAoq+sZvTy1x3Uq1hQjCmDwbnoVoHQlbH9tkFu
	aL8dl0hZFBVU1C3b0bEdGt7WFios8oXfvV7Q4zYmvUVG0VGnatVVF8AADQPLFGBEnY/lHl1R9p5
	tdDxEt5PPKzFydNkMipJLLNpv7g8JBuv2ZmzCeSvD90RpSwadxNT2qnN+2prwc1Prr8+cwkeKlN
	tT1ZLueXKUPa3zmtLAmUgPqyytDp9HuSs9gbao7Kn2pI/Ic/iKWTraDuPkHVS1H6TF6ElpU77IE
	vlmmAPsOGA+g4mf7jsW/DRb+ssrInxcl8c71kdoBpblJJYXn88PndEeRPEQFCy1+Gn4d+CuI6lV
	q1iuWD9EhOs6Ejm68cFboJ84uemCqPEnK9cTd4D3PbUQsbfruMdyPZtvSqqYlGVZz5BV9rXGjNB
	Q7J3gZI+Xv5YyBkWjOOt83qnqjSLnNZ2dvcPyzFS7BGqSCmBNX8/cgWGlRypLQ8YDOjr7qGjqbF
	mQf
X-Received: by 2002:a05:6808:bc4:b0:4b5:5bfa:2698 with SMTP id 5614622812f47-4c31f29bbdamr637922b6e.20.1789074872096;
        Thu, 10 Sep 2026 14:14:32 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:fbf1:d0da:69e0:11a0])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4c330daa42esm347315b6e.4.2026.09.10.14.14.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 14:14:31 -0700 (PDT)
From: "David Lechner (TI)" <dlechner@baylibre.com>
Date: Thu, 10 Sep 2026 16:13:00 -0500
Subject: [PATCH v3 01/10] iio: adc: ti-ads112c14: add DRDY interrupt
 support
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260910-iio-adc-ti-ads112c14-filter-support-v3-1-e5a9b27ddb1a@baylibre.com>
References: <20260910-iio-adc-ti-ads112c14-filter-support-v3-0-e5a9b27ddb1a@baylibre.com>
In-Reply-To: <20260910-iio-adc-ti-ads112c14-filter-support-v3-0-e5a9b27ddb1a@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: Chris Hall <c-hall@ti.com>, Patrick Edwards <pedwards@ti.com>, 
 Kurt Borja <kuurtb@gmail.com>, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, "David Lechner (TI)" <dlechner@baylibre.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=6077; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=VauWigPxn+Z06uluw3jfgiSH2uLFsBfjesGM7iHnEqM=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBqox1zRAl8t0XV1k72wgNbvQnrebA7vNlJrC0Ik
 pWNHoDHO4eJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaqMdcwAKCRDCzCAB/wGP
 wMVBB/9CVUwz7VYQtx1gS9gLJMycRuNRg16SiZ9JTlJt2lMFkhSWu0doFPx1qwkPOsfkRDAv/3r
 dV5bJwEOwdqHSP8UKnrUgYwrBJarm9j1iA66UoolWmqaqffRIYx7vegFYCj5186NO8hjVk4bdRp
 E3WsDz5Zex6S68jCSCOXvRmPAqpNF+pdTN4FoLPftEL2Ry49nCD+RbQo8QxV2L+q7LHz0jBaMTF
 fPzjvhKk/xqrfMkDWVxjN3ketu2eATUuCI92/njKCVf0zgCcAg1JOnreOwIQ/3WeatB3I/kvb+n
 A7H1sBbxBDfB/OjWw+hJxZrEheRYyvjjveVL7IHiTEPntHPR
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
index 60eab4852ba2..9058ad34bc06 100644
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
 
+	if (fwnode_property_match_string(dev_fwnode(dev), "interrupt-names", "drdy") >= 0) {
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

