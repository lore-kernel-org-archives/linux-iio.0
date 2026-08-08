Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F26BB1A9F97
	for <linux-iio@vger.kernel.org>; Sat,  8 Aug 2026 00:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786148437; cv=none; b=kH+BF2WoK8vqnzQqMPOrzU9djI6XH8RH8VvM+TTC56Lw8i3iEMtHkuOz0dpz3oZ1GQXDmbJ4DVvJohUn3idSj+cd6Bok7TO6+Sr3eYsse0qbm5x05cJEOSC6c5y53Krd7evx7DlTCXDlrxeCW5/W9j2XYK9qx0d+NZJFQg8oolg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786148437; c=relaxed/simple;
	bh=qGiSqDTEB8IueyZdnsJoTvnzBrP8bhh2S9mqNS/Cs8w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=m3HXeWXHvkiiTq6Y6wwbcXI6LqQL3IB1doaelkKSOv05yTroX0MFOV18i+0UrHop/P9xoBZYmz77npswg5IY6MDA2zP8gS4YP4hkn9OmnJIkb1MUnURWyn3JsW5D5qLWM9qs5lUCMCwERTdRlg6Nlc8E6Tisw9HyKtTgKqMvDMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=ZEiTrGD2; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="ZEiTrGD2"
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-7eb61bbeb25so122744a34.1
        for <linux-iio@vger.kernel.org>; Fri, 07 Aug 2026 17:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1786148435; x=1786753235; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=H+3eFTdZbxSJ8d10PJQLTyMN38nlrE1qFgcsHMvaT9c=;
        b=ZEiTrGD2/lpfyql5mQHAsOHpifzZAI78vkaHG7fjyd03JJQY5MSfpRrMdpQV5fCahs
         56NdTjDjY4ZyhnOUGfHWoI+x50CeMhhG9fRst9vEkeFGgUWEzGAZISEY0WKloSYg2RFV
         q+EYq1Pkq2+nkIluiSAOTHCNspEUBaY9nf3WGQSsX+9sk3vvh+6zj0/os6CAAqdc4vGZ
         Gr7FsfS8tac57rJLHbPvA16Bdl04CyO/pA9LuENvTGdjcnG+xg52HwdUuT8+2GeJSsEB
         AdCEftJ7w3CmXuzqD5rUPnRJi0WeVDImMNg9S82rTgakJDjaNS/q6TNNaUmAjGJdfrH3
         kMXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786148435; x=1786753235;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=H+3eFTdZbxSJ8d10PJQLTyMN38nlrE1qFgcsHMvaT9c=;
        b=Yk5ZRjNhysLqDraUgCwzibOadaUdXIBaV4hCLkAbctI5YS3794U5bE+gOHMyDNf/JN
         jw5JwIrQPn8BuUW4qL2i7WmNbmj/x3wb7AlGRZInsk9nduobwFYAGBhgw6X4s/oOYfyz
         FlHFh6bsZ+eeBG97qOyhQ4m9+JgU52nTuWjhbgCvAfOpm0Lh97gU8/reTId9xeQDDEv/
         bALCDxU+u+cWsgDjqhYLkR5dXEFQTCvofyOjBnNb9hv7k1JMyYdruQqAExw1WpmvimZD
         82xuiKlyOu1R2+cblCuWIGGxm6DzLcPXqnwQo8F/HRpP4KDz6BGKrjhwd+SLnqwQ/GOX
         A+WQ==
X-Gm-Message-State: AOJu0Yz22V5Ige4NlCg57VUIQO2uRUs8CoMVa+Uu/A5XUZ+oP9pdkIa4
	2oWzjTCIzFl1Mv3rYC8hhF7aNHptt2L89Afxh8gWK9iCYdw4EsD/6rwyuqMrRJ9ropO6NrJHCNI
	lb1fohN4=
X-Gm-Gg: AR+sD11eHzQNNSUcfGYGTRiK40zRQSI+wsqgRhjdOEsmwpMtNmIIR75uAOKeOyG3w5S
	c8zAC+evifophIZLK1o9m3gbgc4BJ3S5SzjNjp/UhJ0KPpuTWyOOGB7cFrkli0Mis/lB+GwWbiM
	OgrPtXZvK0S98Y+IwIAWpRQVQhl0AOC5es0UqYG+2pPJObzF3EIdgRzhOvtoVP+8bOr63g+RQun
	t02Yg+ICqvmGOBhQgz7H8ip2zCqtdCSBekZ75rfGt2mjo0dSF7Z3F8+IaYozPd0J/6rGan37ikB
	kMj535P7JqgnXUPV7/A4H62euZ5roOpSfsF7Uzv7MWu03EA1FRVRCnOtw8XAYHTg0LrASdlCxtW
	eq0ZnwCYeD2KMr6wPKUaIxCq0rDnGHt8dCbyr+vr2Ez4VVwHyjGYq0qbNyOfgAYELzqcHJt9YAB
	j1ETjEohHjJ/VRVAKwiDbBBKNd2Y+l0GTczRplSji0tLhSX61Yhh29yAPsgys4rluDrA==
X-Received: by 2002:a05:6830:2302:b0:7e6:de36:3f35 with SMTP id 46e09a7af769-7f34ded541dmr8869416a34.10.1786148434873;
        Fri, 07 Aug 2026 17:20:34 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:b714:88c:313d:dee2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f35b5a7616sm2526147a34.8.2026.08.07.17.20.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 17:20:33 -0700 (PDT)
From: "David Lechner (TI)" <dlechner@baylibre.com>
Date: Fri, 07 Aug 2026 19:19:46 -0500
Subject: [PATCH 1/5] iio: adc: ti-ads112c14: support external clock
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260807-iio-adc-ti-ads112c14-filter-support-v1-1-4d3ba00caf18@baylibre.com>
References: <20260807-iio-adc-ti-ads112c14-filter-support-v1-0-4d3ba00caf18@baylibre.com>
In-Reply-To: <20260807-iio-adc-ti-ads112c14-filter-support-v1-0-4d3ba00caf18@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "David Lechner (TI)" <dlechner@baylibre.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3113; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=qGiSqDTEB8IueyZdnsJoTvnzBrP8bhh2S9mqNS/Cs8w=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBqdnYvkokHIEA5xvJYAQO9hcrbwLzgKLWjBL2dt
 zF4xVdHKGWJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCanZ2LwAKCRDCzCAB/wGP
 wGA5CACBkeabgpw1sbNcQ/SZpsdApWZh5P7awA65AZQyBZfdkDErytOXODpo+m2twrZTHvTja1Y
 gawWUrYszm2qEnYBWLFwWI3dZ7cq5IfoCejEROzN8JBNOf/Y259+WV3XayJB34OeX1FMke5rppj
 enK0CRXUiIWBvdlaryCCC+Nl2fhmG+D1pNBVINtFSh47Fjq+4NXKmjV1iOymYKnIyM6NXVKfqb0
 WOy/20JfJ2I55qg5vCvEvw/MSxWnuunoOOoHX3VMM1TixW2I/6CjtcL2INOxXkwwAOBWUJPIUPI
 +i1Py3LfrrJ3bpoOMZcy+wYaA4ELXWi5vj9m8Nmu1ZsyEtdq
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Add support for external an external clock source to the TI ADS112C14
ADC driver. The unused fclk_hZ field is added in preparation for filter
support.

Signed-off-by: David Lechner (TI) <dlechner@baylibre.com>
---
 drivers/iio/adc/ti-ads112c14.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/iio/adc/ti-ads112c14.c b/drivers/iio/adc/ti-ads112c14.c
index fa6eeaf81738..5f03e6985efa 100644
--- a/drivers/iio/adc/ti-ads112c14.c
+++ b/drivers/iio/adc/ti-ads112c14.c
@@ -11,6 +11,7 @@
 #include <linux/bitfield.h>
 #include <linux/bitmap.h>
 #include <linux/cleanup.h>
+#include <linux/clk.h>
 #include <linux/completion.h>
 #include <linux/crc8.h>
 #include <linux/delay.h>
@@ -178,6 +179,8 @@ static const u32 ads112c14_pga_gains_x10[] = {
 	200, 320, 500, 640, 1000, 1280, 2000, 2560,	/* 8 - 15 */
 };
 
+#define ADS112C14_INTERNAL_CLK_Hz 4096000
+
 #define ADS112C14_I2C_CRC8_POLYNOMIAL 0x07
 DECLARE_CRC8_TABLE(ads112c14_crc8_table);
 
@@ -268,6 +271,7 @@ struct ads112c14_data {
 	struct iio_trigger *drdy_trig;
 	/* Synchronizes access to register value fields. */
 	struct mutex lock;
+	long fclk_Hz;
 	int drdy_irq;
 	struct completion drdy_completion;
 	bool i2c_crc_enabled;
@@ -1516,6 +1520,7 @@ static int ads112c14_probe(struct i2c_client *client)
 	const struct ads112c14_chip_info *info;
 	struct iio_dev *indio_dev;
 	struct ads112c14_data *data;
+	struct clk *clk;
 	bool need_avdd_ref, need_ext_ref;
 	u32 refp_uV = 0;
 	u32 refn_uV = 0;
@@ -1608,6 +1613,12 @@ static int ads112c14_probe(struct i2c_client *client)
 		return dev_err_probe(dev, -EINVAL,
 				     "external reference measurements require either refp-supply or ti,refp-refn-resistor-ohms property\n");
 
+	clk = devm_clk_get_optional_enabled(dev, NULL);
+	if (IS_ERR(clk))
+		return dev_err_probe(dev, PTR_ERR(clk), "failed to get clk\n");
+
+	data->fclk_Hz = clk ? clk_get_rate(clk) : ADS112C14_INTERNAL_CLK_Hz;
+
 	/* It takes some time for the internal reference to stabilize. */
 	fsleep(10 * USEC_PER_MSEC);
 
@@ -1678,6 +1689,10 @@ static int ads112c14_probe(struct i2c_client *client)
 			return dev_err_probe(dev, data->drdy_irq,
 					     "failed to get drdy interrupt\n");
 
+		if (clk)
+			return dev_err_probe(dev, -EINVAL,
+					     "cannot use both DRDY and CLK - they share the same pin\n");
+
 		/*
 		 * REVISIT: would probably need to implement a pin controller in
 		 * order to support open drain option here.
@@ -1717,6 +1732,20 @@ static int ads112c14_probe(struct i2c_client *client)
 			return ret;
 	}
 
+	if (clk) {
+		ret = regmap_update_bits(data->regmap, ADS112C14_REG_GPIO_CFG,
+					 ADS112C14_GPIO_CFG_GPIO3_CFG,
+					 FIELD_PREP(ADS112C14_GPIO_CFG_GPIO3_CFG,
+						    ADS112C14_GPIO_CFG_GPIO_CFG_INPUT));
+		if (ret)
+			return ret;
+
+		ret = regmap_set_bits(data->regmap, ADS112C14_REG_DEVICE_CFG,
+				      ADS112C14_DEVICE_CFG_CLK_SEL);
+		if (ret)
+			return ret;
+	}
+
 	ads112c14_populate_tables(data);
 
 	indio_dev->name = info->name;

-- 
2.43.0

