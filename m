Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.31.26.27
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793797361;
	b=1QN6ocR7YWCuNxjohfO91ww0nI7hayTOOJH5XqZuEcR5/DVxhjsIKJ/yNIVMr3u0pBaZ
	 sm23/p3PXIgC1FGzEzSSUiVR0PSRPZPgJVYk4Sk3D4oXCRTgFqbkv0o4gNbCvml9SA0Bp
	 CMvxxDiHQVKHkZzqlfQZQ68CiW9/JOvShDGUFytBL4NXoUXQ5H83F1y5VozWf87odTSsE
	 rhDpZB6AEFOd5z0uan5otz01raT0Q+D1AuhmzYdW01soq5NUN/QalSFrRZo9L8hIaEM3n
	 Tcm1+S4K1oLY24Y1CxsaDcqxcmLafy182nv9HellBTq5eHOoSV90EIfCuUeX7NrF2lQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793797361;
	h=DMARC-Filter:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=J4ABuYWkQ5zq8jCD2Src/25kn3cAI+KRj6yV2g4zeiI=;
	b=xZZF+6/rW9keZC4G8A3OPJgyKKQOobGZ2utgSuZ16xgnuDH38P3oeUDE00m+0WYncJt2
	 HRhg2cGHHiTl1DsV4M9wSGxo9Zq85il8aVjx4GwVGqc06OlLKUujvRK2zSZm0awnwga2Z
	 TDjKCJF5R+zOE7qzWXCialYpJCTCW/ck1ULvffLsCu6KKa8C8pp5tqEguh2zlv/Wf0lLw
	 AhYIfOjiaZ+LZiIkAAIccnxQnFGl9oTs55zdl4EVwXUruZplr3baVwWbl1p6MIPXykOUd
	 biHKegPSEm65OvvfrtNswzqhz7AkIY2dqpuI8fDSsJaOsgwYIuJJQyd/xYxHk84gzmg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=rudorff.com;
	spf=pass smtp.mailfrom=rudorff.com;
	arc=none smtp.remote-ip=193.31.26.27
Received: from rudorff.com (rudorff.com [193.31.26.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B706606EEAB;
	Wed,  4 Nov 2026 13:02:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9B706606EEAB
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rudorff.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rudorff.com
Received: from [127.0.1.1] (dynamic-002-211-221-196.2.211.pool.telefonica.de [2.211.221.196])
	by rudorff.com (Postfix) with ESMTPSA id CFE9140B57;
	Wed,  4 Nov 2026 14:02:38 +0100 (CET)
From: Christoph Rudorff <chris@rudorff.com>
Date: Wed, 04 Nov 2026 14:02:28 +0100
Subject: [PATCH v4 2/3] iio: light: gp2ap002: add led power supply
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
Message-Id: <20261104-iio-light-gp2ap002-v4-2-fa1cbaad2ce5@rudorff.com>
References: <20261104-iio-light-gp2ap002-v4-0-fa1cbaad2ce5@rudorff.com>
In-Reply-To: <20261104-iio-light-gp2ap002-v4-0-fa1cbaad2ce5@rudorff.com>
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

Problem: no irq received. Not working.

According to datasheet page 8 "Recommended external circuit",
it got tree pins to supply: vio, vdd and vled->leda.

We were missing to power the led (pin leda)

* add leda regulator
* use regulator_bulk_*()
* pretty up set voltages

Tested on samsung-j5 (msm8916)

Signed-off-by: Christoph Rudorff <chris@rudorff.com>

v2: Use regulator bulk api.
v3: pretty up, rename vled to leda
v4: add namespace "GP2AP002", use separate value for setting vdd,
    moved static supply-data back to global, more readable imho
---
 drivers/iio/light/gp2ap002.c | 92 +++++++++++++++++++++-----------------------
 1 file changed, 43 insertions(+), 49 deletions(-)

diff --git a/drivers/iio/light/gp2ap002.c b/drivers/iio/light/gp2ap002.c
index de29081fd3b2..db4edcc9b849 100644
--- a/drivers/iio/light/gp2ap002.c
+++ b/drivers/iio/light/gp2ap002.c
@@ -123,12 +123,24 @@
 #define GP2AP002_CON_OCON_HIGH		(0x3 << GP2AP002_CON_OCON_SHIFT)
 #define GP2AP002_CON_OCON_MASK		(0x3 << GP2AP002_CON_OCON_SHIFT)
 
+enum {
+	GP2AP002_SUPPLY_VIO,
+	GP2AP002_SUPPLY_VDD,
+	GP2AP002_SUPPLY_LEDA,
+	GP2AP002_NUM_SUPPLIES
+};
+
+static const char *const gp2ap002_supply_names[GP2AP002_NUM_SUPPLIES] = {
+	[GP2AP002_SUPPLY_VIO] = "vio",
+	[GP2AP002_SUPPLY_VDD] = "vdd",
+	[GP2AP002_SUPPLY_LEDA] = "leda",
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
@@ -140,8 +152,7 @@
 struct gp2ap002 {
 	struct regmap *map;
 	struct device *dev;
-	struct regulator *vdd;
-	struct regulator *vio;
+	struct regulator_bulk_data supplies[GP2AP002_NUM_SUPPLIES];
 	struct iio_channel *alsout;
 	u8 hys_far;
 	u8 hys_close;
@@ -445,7 +456,7 @@ static int gp2ap002_probe(struct i2c_client *client)
 	int num_chan;
 	const char *compat;
 	u8 val;
-	int ret;
+	int ret, vdd_volt;
 
 	indio_dev = devm_iio_device_alloc(dev, sizeof(*gp2ap002));
 	if (!indio_dev)
@@ -521,45 +532,39 @@ static int gp2ap002_probe(struct i2c_client *client)
 		}
 	}
 
-	gp2ap002->vdd = devm_regulator_get(dev, "vdd");
-	if (IS_ERR(gp2ap002->vdd))
-		return dev_err_probe(dev, PTR_ERR(gp2ap002->vdd),
-				     "failed to get VDD regulator\n");
+	regulator_bulk_set_supply_names(gp2ap002->supplies,
+					gp2ap002_supply_names,
+					GP2AP002_NUM_SUPPLIES);
 
-	gp2ap002->vio = devm_regulator_get(dev, "vio");
-	if (IS_ERR(gp2ap002->vio))
-		return dev_err_probe(dev, PTR_ERR(gp2ap002->vio),
-				     "failed to get VIO regulator\n");
+	ret = devm_regulator_bulk_get(dev, GP2AP002_NUM_SUPPLIES, gp2ap002->supplies);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to get regulators\n");
 
-	/* Operating voltage 2.4V .. 3.6V according to datasheet */
-	ret = regulator_set_voltage(gp2ap002->vdd, 2400000, 3600000);
+	/* vdd operating voltage 2.4V .. 3.6V according to datasheet */
+	ret = regulator_set_voltage(gp2ap002->supplies[GP2AP002_SUPPLY_VDD].consumer,
+				    2400000, 3600000);
 	if (ret) {
-		dev_err(dev, "failed to sett VDD voltage\n");
+		dev_err(dev, "failed to set VDD voltage\n");
 		return ret;
 	}
-
 	/* VIO should be between 1.65V and VDD */
-	ret = regulator_get_voltage(gp2ap002->vdd);
-	if (ret < 0) {
+	vdd_volt = regulator_get_voltage(gp2ap002->supplies[GP2AP002_SUPPLY_VDD].consumer);
+	if (vdd_volt < 0) {
 		dev_err(dev, "failed to get VDD voltage\n");
-		return ret;
+		return vdd_volt;
 	}
-	ret = regulator_set_voltage(gp2ap002->vio, 1650000, ret);
+	ret = regulator_set_voltage(gp2ap002->supplies[GP2AP002_SUPPLY_VIO].consumer,
+				    1650000, vdd_volt);
 	if (ret) {
 		dev_err(dev, "failed to set VIO voltage\n");
 		return ret;
 	}
 
-	ret = regulator_enable(gp2ap002->vdd);
+	ret = regulator_bulk_enable(GP2AP002_NUM_SUPPLIES, gp2ap002->supplies);
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
 
@@ -570,7 +575,7 @@ static int gp2ap002_probe(struct i2c_client *client)
 	ret = gp2ap002_init(gp2ap002);
 	if (ret) {
 		dev_err(dev, "initialization failed\n");
-		goto out_disable_vio;
+		goto out_disable_power;
 	}
 	pm_runtime_get_noresume(dev);
 	pm_runtime_set_active(dev);
@@ -616,10 +621,8 @@ static int gp2ap002_probe(struct i2c_client *client)
 	pm_runtime_put_noidle(dev);
 out_disable_pm:
 	pm_runtime_disable(dev);
-out_disable_vio:
-	regulator_disable(gp2ap002->vio);
-out_disable_vdd:
-	regulator_disable(gp2ap002->vdd);
+out_disable_power:
+	regulator_bulk_disable(GP2AP002_NUM_SUPPLIES, gp2ap002->supplies);
 	return ret;
 }
 
@@ -633,8 +636,7 @@ static void gp2ap002_remove(struct i2c_client *client)
 	pm_runtime_put_noidle(dev);
 	pm_runtime_disable(dev);
 	iio_device_unregister(indio_dev);
-	regulator_disable(gp2ap002->vio);
-	regulator_disable(gp2ap002->vdd);
+	regulator_bulk_disable(GP2AP002_NUM_SUPPLIES, gp2ap002->supplies);
 }
 
 static int gp2ap002_runtime_suspend(struct device *dev)
@@ -657,8 +659,7 @@ static int gp2ap002_runtime_suspend(struct device *dev)
 	 * As these regulators may be shared, at least we are now in
 	 * sleep even if the regulators aren't really turned off.
 	 */
-	regulator_disable(gp2ap002->vio);
-	regulator_disable(gp2ap002->vdd);
+	regulator_bulk_disable(GP2AP002_NUM_SUPPLIES, gp2ap002->supplies);
 
 	return 0;
 }
@@ -669,23 +670,18 @@ static int gp2ap002_runtime_resume(struct device *dev)
 	struct gp2ap002 *gp2ap002 = iio_priv(indio_dev);
 	int ret;
 
-	ret = regulator_enable(gp2ap002->vdd);
+	ret = regulator_bulk_enable(GP2AP002_NUM_SUPPLIES, gp2ap002->supplies);
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
@@ -693,10 +689,8 @@ static int gp2ap002_runtime_resume(struct device *dev)
 
 	return 0;
 
-out_disable_vio:
-	regulator_disable(gp2ap002->vio);
-out_disable_vdd:
-	regulator_disable(gp2ap002->vdd);
+out_disable_power:
+	regulator_bulk_disable(GP2AP002_NUM_SUPPLIES, gp2ap002->supplies);
 	return ret;
 }
 

-- 
2.39.5

