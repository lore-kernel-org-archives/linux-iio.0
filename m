Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.31.26.27
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792496163;
	b=hroUBm3Whxb5KEYlYYqZ5CALPJ4owXnEvl1fycoKti8n75y9AFRivvTKWQmFgqPa4AXc
	 vScfqt+khZSon1MoTepxsUVB3p1HZYpV+y1nLvMDCtMmvkex1qx/4bP1jjPuLYH58Jh8Z
	 WdmNw387xyA6deGZK58Y89ecOVn9Zv5LCDQc4q38nAAHYhV0hBx1QySum0+J8c/8E5tZB
	 rKSKsHVVPdDNR8DIIVKwoVp7J8rtH6/5fG9K6JBrT0HHKh9prYw1gtIRsIuELqA1yWWg3
	 UtnLk0fZ1u0ScATu3e/6stfg+yVusJWtGH2oHhIWg9bh3mAhvaIMjbs51U0fpE+z0Dg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792496163;
	h=DMARC-Filter:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=dQH5tQh2VBkFwyLwWp3LiWKKsiP9zqBVND2m4nXOYw4=;
	b=JOxoONB0qY+cKjfROsdv2OeaWco5yA4OgmqTHtUXn7aQ4BsAwLg/TWOMrfTqhkmJA0mF
	 qfHBD7R2+M+ph9az8SyhSMd50+ehlzQBpSHEaD/N6jDV2EtlOzW78J9LF36y3mmk35JN/
	 FaHWZzyBk9u7PDHMgYD+GKdMJ0P1H20yxP2x7q7kbzozBjl7/1gdTn4BseHrJOo4UpBZC
	 ZX1CtNsJW16UyJkzwKpkjmklr9nzN+egGv0qrTBKym1b0y0cguhPsQ0oDMUXGCILNwl8d
	 NVpbpkivsEYIPsHWoOnDPD9Jx99q+1AHIo4WItQon1/tApfw16Fv62568qwPQU8hNsw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=rudorff.com;
	spf=pass smtp.mailfrom=rudorff.com;
	arc=none smtp.remote-ip=193.31.26.27
Received: from rudorff.com (rudorff.com [193.31.26.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38DD4606A319;
	Tue, 20 Oct 2026 11:36:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 38DD4606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rudorff.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rudorff.com
Received: from [127.0.1.1] (dynamic-002-211-221-196.2.211.pool.telefonica.de [2.211.221.196])
	by rudorff.com (Postfix) with ESMTPSA id 1B27D403D1;
	Tue, 20 Oct 2026 13:35:53 +0200 (CEST)
From: Christoph Rudorff <chris@rudorff.com>
Date: Tue, 20 Oct 2026 13:35:39 +0200
Subject: [PATCH v3 2/3] iio: light: gp2ap002: add led power supply
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261020-iio-light-gp2ap002-v3-2-b7e0946c9e79@rudorff.com>
References: <20261020-iio-light-gp2ap002-v3-0-b7e0946c9e79@rudorff.com>
In-Reply-To: <20261020-iio-light-gp2ap002-v3-0-b7e0946c9e79@rudorff.com>
To: Linus Walleij <linusw@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 Christoph Rudorff <chris@rudorff.com>
X-Mailer: b4 0.16.0

tested on samsung-j5

v2: Use regulator bulk api.
v3: pretty up, rename vled to leda

Signed-off-by: Christoph Rudorff <chris@rudorff.com>
---
 drivers/iio/light/gp2ap002.c | 84 ++++++++++++++++++++------------------------
 1 file changed, 38 insertions(+), 46 deletions(-)

diff --git a/drivers/iio/light/gp2ap002.c b/drivers/iio/light/gp2ap002.c
index de29081fd3b2..551792ab3972 100644
--- a/drivers/iio/light/gp2ap002.c
+++ b/drivers/iio/light/gp2ap002.c
@@ -123,12 +123,18 @@
 #define GP2AP002_CON_OCON_HIGH		(0x3 << GP2AP002_CON_OCON_SHIFT)
 #define GP2AP002_CON_OCON_MASK		(0x3 << GP2AP002_CON_OCON_SHIFT)
 
+enum {
+	SUPPLY_VIO,
+	SUPPLY_VDD,
+	SUPPLY_LEDA,
+	NUM_SUPPLIES
+};
+
 /**
  * struct gp2ap002 - GP2AP002 state
  * @map: regmap pointer for the i2c regmap
  * @dev: pointer to parent device
- * @vdd: regulator controlling VDD
- * @vio: regulator controlling VIO
+ * @supplies: bulk regulator data
  * @alsout: IIO ADC channel to convert the ALSOUT signal
  * @hys_far: hysteresis control from device tree
  * @hys_close: hysteresis control from device tree
@@ -140,8 +146,7 @@
 struct gp2ap002 {
 	struct regmap *map;
 	struct device *dev;
-	struct regulator *vdd;
-	struct regulator *vio;
+	struct regulator_bulk_data supplies[NUM_SUPPLIES];
 	struct iio_channel *alsout;
 	u8 hys_far;
 	u8 hys_close;
@@ -444,6 +449,11 @@ static int gp2ap002_probe(struct i2c_client *client)
 	struct regmap *regmap;
 	int num_chan;
 	const char *compat;
+	static const char *const gp2ap002_supply_names[NUM_SUPPLIES] = {
+		[SUPPLY_VIO] = "vio",
+		[SUPPLY_VDD] = "vdd",
+		[SUPPLY_LEDA] = "leda",
+	};
 	u8 val;
 	int ret;
 
@@ -521,45 +531,38 @@ static int gp2ap002_probe(struct i2c_client *client)
 		}
 	}
 
-	gp2ap002->vdd = devm_regulator_get(dev, "vdd");
-	if (IS_ERR(gp2ap002->vdd))
-		return dev_err_probe(dev, PTR_ERR(gp2ap002->vdd),
-				     "failed to get VDD regulator\n");
+	regulator_bulk_set_supply_names(gp2ap002->supplies,
+					gp2ap002_supply_names,
+					NUM_SUPPLIES);
 
-	gp2ap002->vio = devm_regulator_get(dev, "vio");
-	if (IS_ERR(gp2ap002->vio))
-		return dev_err_probe(dev, PTR_ERR(gp2ap002->vio),
-				     "failed to get VIO regulator\n");
+	ret = devm_regulator_bulk_get(dev, NUM_SUPPLIES, gp2ap002->supplies);
+
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to get regulators\n");
 
-	/* Operating voltage 2.4V .. 3.6V according to datasheet */
-	ret = regulator_set_voltage(gp2ap002->vdd, 2400000, 3600000);
+	/* vdd operating voltage 2.4V .. 3.6V according to datasheet */
+	ret = regulator_set_voltage(gp2ap002->supplies[SUPPLY_VDD].consumer, 2400000, 3600000);
 	if (ret) {
-		dev_err(dev, "failed to sett VDD voltage\n");
+		dev_err(dev, "failed to set VDD voltage\n");
 		return ret;
 	}
-
 	/* VIO should be between 1.65V and VDD */
-	ret = regulator_get_voltage(gp2ap002->vdd);
+	ret = regulator_get_voltage(gp2ap002->supplies[SUPPLY_VDD].consumer);
 	if (ret < 0) {
 		dev_err(dev, "failed to get VDD voltage\n");
 		return ret;
 	}
-	ret = regulator_set_voltage(gp2ap002->vio, 1650000, ret);
+	ret = regulator_set_voltage(gp2ap002->supplies[SUPPLY_VIO].consumer, 1650000, ret);
 	if (ret) {
 		dev_err(dev, "failed to set VIO voltage\n");
 		return ret;
 	}
 
-	ret = regulator_enable(gp2ap002->vdd);
+	ret = regulator_bulk_enable(NUM_SUPPLIES, gp2ap002->supplies);
 	if (ret) {
-		dev_err(dev, "failed to enable VDD regulator\n");
+		dev_err(dev, "failed to enable regulators\n");
 		return ret;
 	}
-	ret = regulator_enable(gp2ap002->vio);
-	if (ret) {
-		dev_err(dev, "failed to enable VIO regulator\n");
-		goto out_disable_vdd;
-	}
 
 	msleep(20);
 
@@ -570,7 +573,7 @@ static int gp2ap002_probe(struct i2c_client *client)
 	ret = gp2ap002_init(gp2ap002);
 	if (ret) {
 		dev_err(dev, "initialization failed\n");
-		goto out_disable_vio;
+		goto out_disable_power;
 	}
 	pm_runtime_get_noresume(dev);
 	pm_runtime_set_active(dev);
@@ -616,10 +619,8 @@ static int gp2ap002_probe(struct i2c_client *client)
 	pm_runtime_put_noidle(dev);
 out_disable_pm:
 	pm_runtime_disable(dev);
-out_disable_vio:
-	regulator_disable(gp2ap002->vio);
-out_disable_vdd:
-	regulator_disable(gp2ap002->vdd);
+out_disable_power:
+	regulator_bulk_disable(NUM_SUPPLIES, gp2ap002->supplies);
 	return ret;
 }
 
@@ -633,8 +634,7 @@ static void gp2ap002_remove(struct i2c_client *client)
 	pm_runtime_put_noidle(dev);
 	pm_runtime_disable(dev);
 	iio_device_unregister(indio_dev);
-	regulator_disable(gp2ap002->vio);
-	regulator_disable(gp2ap002->vdd);
+	regulator_bulk_disable(NUM_SUPPLIES, gp2ap002->supplies);
 }
 
 static int gp2ap002_runtime_suspend(struct device *dev)
@@ -657,8 +657,7 @@ static int gp2ap002_runtime_suspend(struct device *dev)
 	 * As these regulators may be shared, at least we are now in
 	 * sleep even if the regulators aren't really turned off.
 	 */
-	regulator_disable(gp2ap002->vio);
-	regulator_disable(gp2ap002->vdd);
+	regulator_bulk_disable(NUM_SUPPLIES, gp2ap002->supplies);
 
 	return 0;
 }
@@ -669,23 +668,18 @@ static int gp2ap002_runtime_resume(struct device *dev)
 	struct gp2ap002 *gp2ap002 = iio_priv(indio_dev);
 	int ret;
 
-	ret = regulator_enable(gp2ap002->vdd);
+	ret = regulator_bulk_enable(NUM_SUPPLIES, gp2ap002->supplies);
 	if (ret) {
-		dev_err(dev, "failed to enable VDD regulator in resume path\n");
+		dev_err(dev, "failed to enable regulators in resume path\n");
 		return ret;
 	}
-	ret = regulator_enable(gp2ap002->vio);
-	if (ret) {
-		dev_err(dev, "failed to enable VIO regulator in resume path\n");
-		goto out_disable_vdd;
-	}
 
 	msleep(20);
 
 	ret = gp2ap002_init(gp2ap002);
 	if (ret) {
 		dev_err(dev, "re-initialization failed\n");
-		goto out_disable_vio;
+		goto out_disable_power;
 	}
 
 	/* Re-activate the IRQ */
@@ -693,10 +687,8 @@ static int gp2ap002_runtime_resume(struct device *dev)
 
 	return 0;
 
-out_disable_vio:
-	regulator_disable(gp2ap002->vio);
-out_disable_vdd:
-	regulator_disable(gp2ap002->vdd);
+out_disable_power:
+	regulator_bulk_disable(NUM_SUPPLIES, gp2ap002->supplies);
 	return ret;
 }
 

-- 
2.39.5

