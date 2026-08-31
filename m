Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 540DE3BCD12
	for <linux-iio@vger.kernel.org>; Mon, 31 Aug 2026 22:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788215629; cv=none; b=qmcnXMIRJ4Fp7xIG6KSNkq5A8CkzS0byYlub0vtTNp1eazAIxeexw1BrV6c68nteKJwIpacBCWk4cMz/UcmnjPqyC1OyO6qU8amm7DjF7vZ9+LD32E2B/nnIHiVlWh9XR+afNlEF2jMfezp3EYqoN1Jscf3pUlXyTNgjNrlHsTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788215629; c=relaxed/simple;
	bh=NDSDpivYarXePwTSDpiVgkViP53hrWoSMytekojHNS0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dp8D75IdqI+iXY+gBtHb9HEOrkvQAA9iQyDTSJ32hcPMbinPXBGSsbdDbcclLH6wkbIv/Q4NOvmv4LxoxY4TrLbzdap5f19MU1SEQP9QUYJgu70114pHoQCIP8l7hLSieJTjTHZO7lO3Djp9On9R59EcilCTshtdYT0Do+jgrGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=Q1kaeiw7; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="Q1kaeiw7"
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7f3ff92cf4aso4313929a34.1
        for <linux-iio@vger.kernel.org>; Mon, 31 Aug 2026 15:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1788215626; x=1788820426; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iNTRuf05CTvv6ajYQ262DYaZCyLOnZ0DLR4E2AczWeM=;
        b=Q1kaeiw7xTe/mxxX0Zfbv5UULdBruD6h5CKghw5SuG/VAad25xXTf9nUv6N0h0J63b
         mNoYGK3zTsgDLtry48Bc48pJMmr0vb5IMnF7z4r1HSmvzkjebUbTgYV/JwVaw4cx9Pjo
         XO2ePD3m73SUyTUSMK373pnb4u9x5wajjawcGNlbzB/d6GXMcyWGyWHdIJFu5AmYtLf5
         HQpmaYx+kT82anwOIanj+Fb4vx29QpnHT9NIuvX7QpVnE1LKc17S/936znnkaUZggbKq
         xPCyZLuPOboD9qhnCTgugs3bRE6XVLMUFWZ/QQyScS6Ow9UVwf1VvYJC1you8PNsGkQR
         JT7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788215626; x=1788820426;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iNTRuf05CTvv6ajYQ262DYaZCyLOnZ0DLR4E2AczWeM=;
        b=R1NfjmAmtmlvlesNSg8Vc0dhq7tbYt3Xt6QNGjzP1EUtpgWet+hbFJRtDfgSz2x2Dw
         +XO8Zg14YQbn2IDk9wCjPJEnb0IiyepT8GDg7FQn7uDkE/wCOm1h/tVC+l4V3PTlU86c
         Pdm8LNj9nWISS2+Rg/tFzqPAzMpjnA/BGsYncSTEB6XoTnFejpmvPbnybHQqDq91KghM
         hjPyOuzG2vShsRowMAbY40JIwMfM5E+uSQvKYUiQogrllSilQsLcGz+O8ciRwalTE7Kt
         wTO2XkJ6ANDHaatIt0G629kXGIe/jxBNDQSTe/ZRZPwGB0W6JzKFluf0sKfFq50fSPwZ
         xRsw==
X-Forwarded-Encrypted: i=1; AHgh+Rrz6icJYbZ5IGa4LwEGvzxawBkb4Gb7xRjNvz7O/1yEc1z/n23AcVHrziWBHSpU0ti6MbXYdIrveE8=@vger.kernel.org
X-Gm-Message-State: AFuF++n8EyYLZRKGuLi/gFWMGfnC8SQdA0XNJZTgQzqSxAjwzQehOq9g
	vBuLBM5Y3YJoGrsdPMWDYFldXjWYvinRmVR4zS8/4iG5cVkdkIJ+n6Z10AmjtJDh22w=
X-Gm-Gg: AR+sD1226xkc5M2TY2KLts+R0gO5BYgljj5p4+/5YTa3xXWkWhlQh2oCfakhxwvsdKP
	yI9Lm+HppaWzO/4EJfgpOJAqY1RdkHOJZNGDf33FNX13yb7EjhMj1YIGU6oDACCJ6KkkTPbHXp3
	DQdx+zT/TwwEg3UTQAzarCfFLRllqi9qWzmj9vyBeXBlVoWsnqiNk/qEynIjIY5cvbKOChpfVV0
	UHkYRjOTjJ8N/NGEBcq5BsjyJec6F/pQZGyB5CMoKHt6wmax69d3nZUSeDGU+odvci370WnqCq0
	UIiQyNGgxWrVItJuNK4MJqBjrqcGXsM93j+FVaGk3gR2hEjYXvUFjoukB2bt8YXE8Ct42ry+HPn
	C78/V5wpljiq4IRyZkRGBF9PSLSEdPAM/hucmnq6V9uYbYt9sRyuak7ISZ+CPU9F1kXs2e2AsLK
	5vPvgHrFsBRJIEBztudN10qubCwNhy+6pr/XSWVXG6GcXP22pZ4AMDl6HBJhb8woJ0fg==
X-Received: by 2002:a05:6830:2117:b0:7e7:8dc0:3951 with SMTP id 46e09a7af769-7f6879f9436mr5424341a34.8.1788215625827;
        Mon, 31 Aug 2026 15:33:45 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:778b:da9:a8a1:bc78])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f4fa7efe09sm9190551a34.11.2026.08.31.15.33.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 15:33:45 -0700 (PDT)
From: "David Lechner (TI)" <dlechner@baylibre.com>
Date: Mon, 31 Aug 2026 17:33:05 -0500
Subject: [PATCH v5 1/3] iio: adc: ti-ads112c14: add DRDY interrupt support
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260831-iio-adc-ti-ads112c14-continuous-mode-v5-1-76f80a04b94f@baylibre.com>
References: <20260831-iio-adc-ti-ads112c14-continuous-mode-v5-0-76f80a04b94f@baylibre.com>
In-Reply-To: <20260831-iio-adc-ti-ads112c14-continuous-mode-v5-0-76f80a04b94f@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: Chris Hall <c-hall@ti.com>, Patrick Edwards <pedwards@ti.com>, 
 Kurt Borja <kuurtb@gmail.com>, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, "David Lechner (TI)" <dlechner@baylibre.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=6047; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=NDSDpivYarXePwTSDpiVgkViP53hrWoSMytekojHNS0=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBqlgEpK+CHXZEgZyX1eY20//e+JjIuqN/diYxeS
 PFRBARhmw+JATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCapYBKQAKCRDCzCAB/wGP
 wIa/B/9Kaa7VniIy4q2e3CBryijGHVAOgB4nJ5l3/Y8jzDGSvPt6wcH5ELV/8h3PVaeb4USMRMB
 K6Tk2j8zQ10j9vo8imSjuD7Nj0qtbZg8gQ0A18f2mWJUOTL37IOTqOmVBsPmneoG0Yb0t4m65LO
 hJVFeNj1sJACs2jl3wYnekdHJz09zKEVEo07QaIFNbsCvgw4cOEgUH/lPEV1GOMUFIy9bBozl9C
 tKmv/8K5SsgPWMm5phnKz7oF3tXWwXcvYzT9VpON9BKbpovM+/zFQaezipHAl72Iz4Ea//7AqrW
 2/G6b6OuxylfYllrw8IgP99nyIaHTd2iTgBKL/upocvsumrF
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
index 60eab4852ba2..63b819339788 100644
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
 
+	if (device_property_present(dev, "interrupt-names")) {
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

