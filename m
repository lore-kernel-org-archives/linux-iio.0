Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 092CF38BF67
	for <linux-iio@vger.kernel.org>; Fri, 24 Jul 2026 20:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784924032; cv=none; b=tOEISR/BNjw2TDTL3oMq4/jkQHOz8L8ToC4DPjZ63ayiDuAWdsoNXVCslv1+9UQ3ttxfO7U8cV+iB3PnkmA8jTl/EoyrqLPMd9kB258Lm0LTsw5c60s+rDI5GHLWXRU3gsZwk2AwrbPBq3iRt8GTue867ccFQPaSLdlgFQJFH7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784924032; c=relaxed/simple;
	bh=VwRp5cVL30GJlj3wO3D26AsHQN19yEwSh6UVq6RANXA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pSW1DlXDoRhJ19heoyIao0DTPJzP0H4E0JkutYdQXrzj5sh2Xd9Kn8x8gs2uWtKQ/GezPPtpZjyI2rwoiOyOmHY8ZHMDuWD2hS6mPHmaqeGGiqF0f8kRLeK+vp8t5AxGTPrlHluN3gqqdSOISM+/qKeiz9PJ/Zv9H/aUGMbLcmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=nxfpRzCd; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="nxfpRzCd"
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-4560d6f82edso423079fac.3
        for <linux-iio@vger.kernel.org>; Fri, 24 Jul 2026 13:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1784924017; x=1785528817; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=e10cpwXyP0kwYSe5mqmMQqJO1Y4QT7IxpGgJ8dCsjI8=;
        b=nxfpRzCdiPKRZetDbwiTnyRGhYzDbAA0MqzYzbBCRRgP7Ns2bXTp02Mm18QG0AVYe4
         82xsPRz+mXPrvXhqlDQBHWDrcSWoAsifs06Mf9VI78Eyi/JqbbEIaEDm/WuJLIsqRiVn
         YL4mRYfgA1183P3yD3JC52Jyy+4YvgA/rUnmvg/To8rsBT2g0J4z1r/Gmde+8lNoxgzD
         njZq7AMCd//DPdhE2oS0L7CXl4B4TzcyVPIkCNQbf7U/9DeaSIsGWrmp1MpATCVSkJaO
         sFzONEUjIsDmB/tqEGYxqEOHY0Iy6qo/W4Ft7q4p3IQlDBTZPb4hXzV2jULwvNG4LWjh
         VgnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784924017; x=1785528817;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=e10cpwXyP0kwYSe5mqmMQqJO1Y4QT7IxpGgJ8dCsjI8=;
        b=pTcHA8h5DGIFJVkmpHQ60Dt0jLrCrUH3rj6X+/PDEEDhD2lxP5ZYz4ZyNORAWqYbgH
         GvOvqJXCYqTXD38oBTx4GM4DO5KBzp115yrWkKC+mFZSHYaqGG7ZJWsxKIGGT+SHPn+7
         Jzk1gQBdjCOW/0eevgr2AlI6xTNUUxf2eRgbeiXboWnTHv34uozQAgP00nMBJGrGTcLA
         7WF3nKeJSsqAbDObJrWVizgxzbwSaFHIAUfXVYEISEPH4w5XzctKNbPV5ajqkvRYdv+v
         n4VMjlkIqJgYGWLNXvS1b2ocad+XP2DIiuxWemEtTAE83Bb+oQb8xF3SFMnMSOthfaKR
         P0dQ==
X-Forwarded-Encrypted: i=1; AHgh+RrRWypTZ7FpNmQh4VzwoR30dhmTVlGPhA607KGPsRsIahwdwOaH/qIDbfkPPncPauLCy1VdKZglcRk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrJOW3zHKq30nVPHLkJGy0oTwbagnqUHduKqLKb+6fuO676LTn
	fiXanaTHHhZqV3njNelaanCeXr5hJMhwgdDB9KtuoX6agTuNku0qNSDbx439PAepbN4=
X-Gm-Gg: AR+sD130wt+tm7QqD18bOaelZSxxrLOBlTxPrQb0FcpwF3iKmVJ6Mc8ua4b52Heui9M
	aldwwCE1Ji2st+Onbvz6y2pRWBYwWYURFaj7pqLCI1OkAkMAI+Ia21voLE/KWkqJjs5bwiL5kqi
	r2OLElGmYnxlfB+btGmo4td4fxxrbugkv9sU8Maa+OChaf8/rZjE2tfvJUtL/yZQPNTWONnf5NN
	C22/tUa69YhPHc/lQ7XtVhI46SESaey6ERkUD8Zx4lUhBZcYYgxVgZWa+xYDgNnW7jFKYa6uBAn
	nGQ61nxqi/aWfHLtuaZ8btzz9xuyYx5UTL6XQILnzdbVjkxNHi6VKSLH68eGzXeKkFojD+zH20s
	GTgKYA7w4WjCjA04VJlijfWiwjO3q/f+efHpOKbFQGsRbpKtC1TN1HbX5LzOfIinXCmeia5F/X3
	gxaVGDf15rhBAkoIEz
X-Received: by 2002:a05:6871:3586:b0:434:5c90:9d87 with SMTP id 586e51a60fabf-457a0c7f856mr5713452fac.12.1784924017196;
        Fri, 24 Jul 2026 13:13:37 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:b635:d463:c98:cc75])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-457675260b4sm8309042fac.17.2026.07.24.13.13.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 13:13:36 -0700 (PDT)
From: "David Lechner (TI)" <dlechner@baylibre.com>
Date: Fri, 24 Jul 2026 15:13:10 -0500
Subject: [PATCH 1/2] iio: adc: ti-ads112c14: add DRDY interrupt support
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260724-iio-adc-ti-ads112c14-continuous-mode-v1-1-9eb0b7a4f020@baylibre.com>
References: <20260724-iio-adc-ti-ads112c14-continuous-mode-v1-0-9eb0b7a4f020@baylibre.com>
In-Reply-To: <20260724-iio-adc-ti-ads112c14-continuous-mode-v1-0-9eb0b7a4f020@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: Chris Hall <c-hall@ti.com>, Patrick Edwards <pedwards@ti.com>, 
 Kurt Borja <kuurtb@gmail.com>, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, "David Lechner (TI)" <dlechner@baylibre.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=5321; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=VwRp5cVL30GJlj3wO3D26AsHQN19yEwSh6UVq6RANXA=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBqY8dhVqrZO9pH3olcBwoVGpz/yeEXJwvJXx6Oz
 O2PILXByteJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCamPHYQAKCRDCzCAB/wGP
 wOe/B/4rioD7rZDQIGcwcfJwTigRl1QItuNyThoe/OrIPOBePUKvjznf/j5+wl9NmWSvMKm3Qlg
 8qyfghUJVpI9Sc/51ArHntPxqr0hnicAfR4t5UKvn/WOtQuAGlglLUa/YmQGzBFdDOAj61QAwSq
 CbJ4gJjzICotVpkYex9UJby3dwO/Y/sgCG5lKFUIESEZkDPBkZ6E9VZc7E3+Lr3OO/bECTsBsPf
 5xnvdof8dPlzOa26eeGBD3keP8AjPs4oVjmVm2C+dkYxlAi7GdzkTHHbsSAvdXvlwz9NKQPLPsG
 Z45l19c8Mrawi2/iH+s8M1DeGBKADw5EZuoxYv0TEvr2CQD+
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
 drivers/iio/adc/ti-ads112c14.c | 82 ++++++++++++++++++++++++++++++++++++++----
 1 file changed, 75 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/adc/ti-ads112c14.c b/drivers/iio/adc/ti-ads112c14.c
index 8ad8caee0ff7..57e301c15314 100644
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
@@ -601,17 +621,33 @@ static int ads112c14_single_conversion(struct ads112c14_data *data,
 			return ret;
 	}
 
+	if (data->drdy_irq) {
+		reinit_completion(&data->drdy_completion);
+		enable_irq(data->drdy_irq);
+	}
+
 	ret = regmap_write(data->regmap, ADS112C14_REG_CONVERSION_CTRL,
 			   ADS112C14_CONVERSION_CTRL_START);
-	if (ret)
+	if (ret) {
+		if (data->drdy_irq)
+			disable_irq(data->drdy_irq);
 		return ret;
+	}
 
-	ret = regmap_read_poll_timeout(data->regmap,
-				       ADS112C14_REG_STATUS_MSB, reg_val,
-				       FIELD_GET(ADS112C14_STATUS_MSB_DRDY, reg_val),
-				       1 * USEC_PER_MSEC, 100 * USEC_PER_MSEC);
-	if (ret)
-		return ret;
+	if (data->drdy_irq) {
+		ret = wait_for_completion_timeout(&data->drdy_completion,
+						  msecs_to_jiffies(100));
+		disable_irq(data->drdy_irq);
+		if (ret == 0)
+			return -ETIMEDOUT;
+	} else {
+		ret = regmap_read_poll_timeout(data->regmap,
+					       ADS112C14_REG_STATUS_MSB, reg_val,
+					       FIELD_GET(ADS112C14_STATUS_MSB_DRDY, reg_val),
+					       1 * USEC_PER_MSEC, 100 * USEC_PER_MSEC);
+		if (ret)
+			return ret;
+	}
 
 	/*
 	 * When doing buffered read, we don't check the CRC, but rather pass it
@@ -1392,6 +1428,38 @@ static int ads112c14_probe(struct i2c_client *client)
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

