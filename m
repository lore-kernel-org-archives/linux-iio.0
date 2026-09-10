Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E6D342C513
	for <linux-iio@vger.kernel.org>; Thu, 10 Sep 2026 21:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789074893; cv=none; b=fS4XTDcxndwcaXrLtM5fL3QyEF4qT4vvMj+pqLqnCpVHHYTyM+pOqjWRLfLMKlYPKoygD5SPnyoqZcpzVrP53Hs8C4Y5guYxTv/k0JawRgrTtIq1Q4SFyBG4WhrMFUvV84l3K47ctx4J5bzMArP+rxGiTuADsW0Hj4JSOXhUyB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789074893; c=relaxed/simple;
	bh=NlAn62+1tvYuJ/QDOCCCJAGBONbgbO7UKHidEAgXFbc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sAGYLc/2QX2SmQ/2WNEAOFxXqfIOCs1roeGl+14m+zPavqUbLtH0RUXAtRtDimsPKrC1vPBpMl2Aw/DFvruTaF6e723gustTW2WW0rpKy7MnaJIgb1/xAXPkDzbFashGFf0iUKeoWPw9Kxt9e37wy5YwkaLtGS9r4A8TB1jQ41o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=ikf71vLN; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="ikf71vLN"
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-4b381337e1fso326636b6e.1
        for <linux-iio@vger.kernel.org>; Thu, 10 Sep 2026 14:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1789074880; x=1789679680; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=C7TzjYhYQHl6A/Cy+Gf5z/r3vfrczkehr4YTwiho+ac=;
        b=ikf71vLNOY+ZsmJo+7AUN6LMbMXF7RZck83AQ6B4NC4K9YQuu7gA6dlJNd/7+cSrok
         OJvbUaNwa+MCpqy0RWGUENAk/qy2LxC3A+YNNRZNwFOGH3hR5D7N1HF9jjOFjlLpw+kV
         QeYsqQ8FbI9sNdjVGlXG9p3NpcK/YPb+BG3DU5N67oAARlHgKz5DZYm0Q0GKGdEZG1pP
         7JWTGJZvo/w+wA9leAnqXkj5cTQK60Ee1rk+98XZcPbuk9wqGfaEfkJnRya2u1S5n1f1
         oXvhNxkopI9YnUF12f90gtwLS3exRTaKi2BU+ieg3MuJfwqnm/EoSurdDXu8hpdJ2wFr
         BGKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789074880; x=1789679680;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=C7TzjYhYQHl6A/Cy+Gf5z/r3vfrczkehr4YTwiho+ac=;
        b=HuDANPrnI9MXKU0ldXuvV3YeYgoGMvtGJd2Af/MuA8+oN3LplCYTrL8wb/uuXGWVWU
         CWQteTyZP8U0qmmWNvk4h+4asIDAD4IoJEXHHEJ2UiczLQIRKtwPmf4ebhnTHdvMp5Rz
         fJR3D3YEtqz6yl5BSQSWMRBNNbyJ6+lvs5Cg/WX9S1E0BLx3OAjdA6v7VVYA9F8ZPMdj
         oroSM6J4jiasCDXJqiQhqaDcDTGGvsJ/Wj8Dc1inTRth+OvgYeqxyGE6OCmtbr8HT/4V
         kKYl3rEN2y8qZFyL52rdY3B+dQ8Dr9GZmhHc9116cF5Q8d4YK1MXQu4KIra9sGjjtN5i
         YxUw==
X-Forwarded-Encrypted: i=1; AKwUvByLyEymZBTrYD6kNGzYz6rP6c/2NzYY/5e0pjTDa219fF1p0JSsJyp7hn2VcS4o7bUKqTaHP941a8M=@vger.kernel.org
X-Gm-Message-State: AFuF++n+3HX7lliGWRg6ScXCMyICx+XGOTEGvGC2d5dxrkB+gAQeOWHd
	lPTx+Bx84VfgeH8n+waiqhIqyukJBRtdmT9RzaEDDXGXgUcbnhtU9gMzGVlsfqZrtty4r1JWNbz
	36OmY
X-Gm-Gg: AYBFou3axPdTrW0WeqQRsM3I5wWu1UK6ZCYE+ywlXFen+jflnxKbe8PPEpFW8smr2Rs
	KNqWqu3y83D2odXq+l3UFxF1TTJ/rxtMLAuzAgXpS2DXpmMJfKGwfWkHhaCFHJ9Vz4VVv5v7IcN
	TQpnEd2JpKGhbUb5MwHeW8HBdi7wzKVLLnFfH2Aa87D5UF2ZkSGx0k2CQCT2ScYix5hqvnN740H
	Avsakk8rbGouJiV6kNguxlSL9jmc4i+2fOAk4Gy9r0RKJcyHbnla44gZmtD/0qG97rvvnjlU2SY
	q5qIF1Qjsk5epGeg7V6yKlqeJdSDCdE4TkW7Zb2jxN03U+AqyHfgBwdbtB8/u38zNr96LvBbjnf
	IYHvU87qof1uG+wPaVaV/N0wRkVvcqjZrqpd6OWIqdVAzLnJJHDJQ5HT+2UjfI2zDQ5Fq0mjNMU
	M3D3APdisJOTGKNAeMCpWuJN03PL3Dpm1Z1/7fPFr5pNRpnb8fLB/n8sb8dT1ZnDFavK6l6AwV3
	8fn
X-Received: by 2002:a05:6808:238c:b0:4b9:e65b:8c2c with SMTP id 5614622812f47-4c31b5c1f1dmr714570b6e.26.1789074879810;
        Thu, 10 Sep 2026 14:14:39 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:fbf1:d0da:69e0:11a0])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4c330daa42esm347315b6e.4.2026.09.10.14.14.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 14:14:38 -0700 (PDT)
From: "David Lechner (TI)" <dlechner@baylibre.com>
Date: Thu, 10 Sep 2026 16:13:05 -0500
Subject: [PATCH v3 06/10] iio: adc: ti-ads112c14: support external clock
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260910-iio-adc-ti-ads112c14-filter-support-v3-6-e5a9b27ddb1a@baylibre.com>
References: <20260910-iio-adc-ti-ads112c14-filter-support-v3-0-e5a9b27ddb1a@baylibre.com>
In-Reply-To: <20260910-iio-adc-ti-ads112c14-filter-support-v3-0-e5a9b27ddb1a@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: Chris Hall <c-hall@ti.com>, Patrick Edwards <pedwards@ti.com>, 
 Kurt Borja <kuurtb@gmail.com>, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, "David Lechner (TI)" <dlechner@baylibre.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3749; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=NlAn62+1tvYuJ/QDOCCCJAGBONbgbO7UKHidEAgXFbc=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBqox2T+V/oKw+pUSGVkVN4NTBA02qbU78qUsHDS
 0h0ehUYggyJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaqMdkwAKCRDCzCAB/wGP
 wAP3CACG0r7acfhY3stdbmMVZVZ3So3i1cz/ll1vDWwet/N9GWrZAjBoEephSKllfj4t0toQg4z
 GhD14J3llATl+2grz8j/K3LTQvwFfLSpnImMy4MUNWHxip21ElBPAl+TCwYbFgQioy6DH3emDFV
 9BBgmKrTtVAZdIFbj2oM56Iv/CUi8yzj0vcSqUTc0zVkx0eQVGjkQoGueVC6mt2vbiefJZ5mx6s
 aJXtpmNpJCPBUEopGejg+duLw7fVb0nb5jUTmRIVvnh4NvL4KESHOWv0kXkN1CDwM7f7KQXg/cS
 MC8t3LUEVPgizHqmhejlO+5NDPi2R5MbNwUzjegJ/s5vwT7C
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Add support for an external clock source to the TI ADS112C14 ADC driver.
The unused fclk_Hz field is added in preparation for filter support.

Signed-off-by: David Lechner (TI) <dlechner@baylibre.com>
---
 drivers/iio/adc/ti-ads112c14.c | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/drivers/iio/adc/ti-ads112c14.c b/drivers/iio/adc/ti-ads112c14.c
index efea1e22d067..0e4584b4675e 100644
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
@@ -82,6 +83,8 @@
 #define     ADS112C14_DEVICE_CFG_BOCS_10_uA		  3
 
 #define   ADS112C14_DEVICE_CFG_CLK_SEL			BIT(3)
+#define     ADS112C14_DEVICE_CFG_CLK_SEL_INTERNAL	  0
+#define     ADS112C14_DEVICE_CFG_CLK_SEL_EXTERNAL	  1
 #define   ADS112C14_DEVICE_CFG_CONV_MODE		BIT(2)
 #define     ADS112C14_DEVICE_CFG_CONV_MODE_CONTINUOUS	  0
 #define     ADS112C14_DEVICE_CFG_CONV_MODE_SINGLE_SHOT	  1
@@ -178,6 +181,8 @@ static const u32 ads112c14_pga_gains_x10[] = {
 	200, 320, 500, 640, 1000, 1280, 2000, 2560,	/* 8 - 15 */
 };
 
+#define ADS112C14_INTERNAL_CLK_Hz 4096000
+
 #define ADS112C14_I2C_CRC8_POLYNOMIAL 0x07
 DECLARE_CRC8_TABLE(ads112c14_crc8_table);
 
@@ -268,6 +273,7 @@ struct ads112c14_data {
 	struct iio_trigger *drdy_trig;
 	/* Synchronizes access to register value fields. */
 	struct mutex lock;
+	long fclk_Hz;
 	int drdy_irq;
 	struct completion drdy_completion;
 	bool continuous_mode;
@@ -1536,6 +1542,7 @@ static int ads112c14_probe(struct i2c_client *client)
 	const struct ads112c14_chip_info *info;
 	struct iio_dev *indio_dev;
 	struct ads112c14_data *data;
+	struct clk *clk;
 	bool need_avdd_ref, need_ext_ref;
 	u32 refp_uV = 0;
 	u32 refn_uV = 0;
@@ -1628,6 +1635,18 @@ static int ads112c14_probe(struct i2c_client *client)
 		return dev_err_probe(dev, -EINVAL,
 				     "external reference measurements require either refp-supply or ti,refp-refn-resistor-ohms property\n");
 
+	clk = devm_clk_get_optional_enabled(dev, NULL);
+	if (IS_ERR(clk))
+		return dev_err_probe(dev, PTR_ERR(clk), "failed to get clk\n");
+
+	if (clk) {
+		data->fclk_Hz = clk_get_rate(clk);
+		if (!data->fclk_Hz)
+			return dev_err_probe(dev, -EINVAL, "clk rate is 0\n");
+	} else {
+		data->fclk_Hz = ADS112C14_INTERNAL_CLK_Hz;
+	}
+
 	/* It takes some time for the internal reference to stabilize. */
 	fsleep(10 * USEC_PER_MSEC);
 
@@ -1698,6 +1717,10 @@ static int ads112c14_probe(struct i2c_client *client)
 			return dev_err_probe(dev, data->drdy_irq,
 					     "failed to get drdy interrupt\n");
 
+		if (clk)
+			return dev_err_probe(dev, -EINVAL,
+					     "cannot use both DRDY and CLK - they share the same pin\n");
+
 		/*
 		 * REVISIT: would probably need to implement a pin controller in
 		 * order to support open drain option here.
@@ -1737,6 +1760,22 @@ static int ads112c14_probe(struct i2c_client *client)
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
+		ret = regmap_update_bits(data->regmap, ADS112C14_REG_DEVICE_CFG,
+					 ADS112C14_DEVICE_CFG_CLK_SEL,
+					 FIELD_PREP(ADS112C14_DEVICE_CFG_CLK_SEL,
+						    ADS112C14_DEVICE_CFG_CLK_SEL_EXTERNAL));
+		if (ret)
+			return ret;
+	}
+
 	ads112c14_populate_tables(data);
 
 	indio_dev->name = info->name;

-- 
2.43.0

