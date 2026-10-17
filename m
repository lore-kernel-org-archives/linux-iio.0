Received: from rudorff.com (rudorff.com [193.31.26.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 372AC3B9927;
	Sat, 17 Oct 2026 17:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.31.26.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792258099; cv=none; b=nLL0T5Tgw8LcrGL+nscQLdgZ4KMuOIeJQE8R2SN7oKwPO2lp9Ay2YQuPhSmYUf6uAV7WGxCKBdkmkHb3iK/yNPkdyZ9MEuH3GOOLwNMyUbdVSfZ+sAONRCvQEMN4an5jQ/bhLsrhXTAkj5JcDJrdLzCViYyKds0j+nhZlwOY7U8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792258099; c=relaxed/simple;
	bh=lEXOGOAM2PnplJpVidfAUQn+4vonnwzP9JqPpO7Cjc0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bhJVbCc6HTA2MBPQhV4rSBRxLOgbz4sx02bQ6YMMysUDkSQt6WONKdKZAe0qBKYoXDu3I2yZWpZxdDcHVkjbTUXtqoaawktb40z8+ZZ1Rlw5cwpDXkAerZuNkj+xRs2871K6XDCZaKA/RsUS7CYXyBbd+m5+HrdblWAjBCTbmk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rudorff.com; spf=pass smtp.mailfrom=rudorff.com; arc=none smtp.client-ip=193.31.26.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rudorff.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rudorff.com
Received: from [127.0.1.1] (dynamic-002-211-221-196.2.211.pool.telefonica.de [2.211.221.196])
	by rudorff.com (Postfix) with ESMTPSA id 9487B403E0;
	Sat, 17 Oct 2026 19:28:08 +0200 (CEST)
From: Christoph Rudorff <chris@rudorff.com>
Date: Sat, 17 Oct 2026 19:27:42 +0200
Subject: [PATCH v2 2/3] iio: light: gp2ap002: add led power supply
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261017-iio-light-gp2ap002-v2-2-d6879767a446@rudorff.com>
References: <20261017-iio-light-gp2ap002-v2-0-d6879767a446@rudorff.com>
In-Reply-To: <20261017-iio-light-gp2ap002-v2-0-d6879767a446@rudorff.com>
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

The led power might be attached to an extra supply.

Signed-off-by: Christoph Rudorff <chris@rudorff.com>
---
 drivers/iio/light/gp2ap002.c | 101 +++++++++++++++++++++++--------------------
 1 file changed, 55 insertions(+), 46 deletions(-)

diff --git a/drivers/iio/light/gp2ap002.c b/drivers/iio/light/gp2ap002.c
index de29081fd3b2..5e4599e40376 100644
--- a/drivers/iio/light/gp2ap002.c
+++ b/drivers/iio/light/gp2ap002.c
@@ -123,12 +123,26 @@
 #define GP2AP002_CON_OCON_HIGH		(0x3 << GP2AP002_CON_OCON_SHIFT)
 #define GP2AP002_CON_OCON_MASK		(0x3 << GP2AP002_CON_OCON_SHIFT)
 
+/*
+ * @vio: regulator name controlling VIO
+ * @vdd: regulator name controlling VDD
+ * @vled: regulator name controlling VLED (optional)
+ */
+static const char *const gp2ap002_supply_names[] = {
+	"vio", "vdd", "vled"
+};
+enum {
+	SUPPLY_VIO,
+	SUPPLY_VDD,
+	SUPPLY_VLED,
+	NUM_SUPPLIES
+};
+
 /**
  * struct gp2ap002 - GP2AP002 state
  * @map: regmap pointer for the i2c regmap
  * @dev: pointer to parent device
- * @vdd: regulator controlling VDD
- * @vio: regulator controlling VIO
+ * @supplies bulk regulator data
  * @alsout: IIO ADC channel to convert the ALSOUT signal
  * @hys_far: hysteresis control from device tree
  * @hys_close: hysteresis control from device tree
@@ -140,8 +154,7 @@
 struct gp2ap002 {
 	struct regmap *map;
 	struct device *dev;
-	struct regulator *vdd;
-	struct regulator *vio;
+	struct regulator_bulk_data supplies[NUM_SUPPLIES];
 	struct iio_channel *alsout;
 	u8 hys_far;
 	u8 hys_close;
@@ -521,45 +534,52 @@ static int gp2ap002_probe(struct i2c_client *client)
 		}
 	}
 
-	gp2ap002->vdd = devm_regulator_get(dev, "vdd");
-	if (IS_ERR(gp2ap002->vdd))
-		return dev_err_probe(dev, PTR_ERR(gp2ap002->vdd),
-				     "failed to get VDD regulator\n");
+	regulator_bulk_set_supply_names(gp2ap002->supplies,
+		gp2ap002_supply_names,
+		NUM_SUPPLIES);
+
+	ret = devm_regulator_bulk_get(dev,
+		NUM_SUPPLIES,
+		gp2ap002->supplies);
 
-	gp2ap002->vio = devm_regulator_get(dev, "vio");
-	if (IS_ERR(gp2ap002->vio))
-		return dev_err_probe(dev, PTR_ERR(gp2ap002->vio),
-				     "failed to get VIO regulator\n");
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
+	/* LED voltage 2.4V .. 3.6V according to datasheet */
+	/* We need to check this, as dummy or fixed controllers trigger an error. */
+	ret = regulator_is_supported_voltage(gp2ap002->supplies[SUPPLY_VLED].consumer,
+		2400000, 3600000);
+	if (ret == 1) {
+		ret = regulator_set_voltage(gp2ap002->supplies[SUPPLY_VLED].consumer,
+		2400000, 3600000);
+		if (ret) {
+			dev_err(dev, "failed to set VLED voltage\n");
+			return ret;
+		}
+	}
 
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
 
@@ -570,7 +590,7 @@ static int gp2ap002_probe(struct i2c_client *client)
 	ret = gp2ap002_init(gp2ap002);
 	if (ret) {
 		dev_err(dev, "initialization failed\n");
-		goto out_disable_vio;
+		goto out_disable_power;
 	}
 	pm_runtime_get_noresume(dev);
 	pm_runtime_set_active(dev);
@@ -616,10 +636,8 @@ static int gp2ap002_probe(struct i2c_client *client)
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
 
@@ -632,9 +650,8 @@ static void gp2ap002_remove(struct i2c_client *client)
 	pm_runtime_get_sync(dev);
 	pm_runtime_put_noidle(dev);
 	pm_runtime_disable(dev);
+	regulator_bulk_disable(NUM_SUPPLIES, gp2ap002->supplies);
 	iio_device_unregister(indio_dev);
-	regulator_disable(gp2ap002->vio);
-	regulator_disable(gp2ap002->vdd);
 }
 
 static int gp2ap002_runtime_suspend(struct device *dev)
@@ -657,8 +674,7 @@ static int gp2ap002_runtime_suspend(struct device *dev)
 	 * As these regulators may be shared, at least we are now in
 	 * sleep even if the regulators aren't really turned off.
 	 */
-	regulator_disable(gp2ap002->vio);
-	regulator_disable(gp2ap002->vdd);
+	regulator_bulk_disable(NUM_SUPPLIES, gp2ap002->supplies);
 
 	return 0;
 }
@@ -669,23 +685,18 @@ static int gp2ap002_runtime_resume(struct device *dev)
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
@@ -693,10 +704,8 @@ static int gp2ap002_runtime_resume(struct device *dev)
 
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

