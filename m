Received: from rudorff.com (rudorff.com [193.31.26.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5162470EA9;
	Fri, 16 Oct 2026 14:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.31.26.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792161800; cv=none; b=bmAPOcmofN6fsNhFselmFD9wtODCYit5tuQSKiPg8cOzGJKH1sNMddPp9EltkM9j1iMJhxDshsn73g1C83tLuGZ56Crj0JnDxFlgi6a6Vbdq7TmgU4dVJIG0Tt5t5Hnn8ER4DNXCjSAFrSQn820Z9V2+pfzIber9f8bhHXs3YNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792161800; c=relaxed/simple;
	bh=HWTLZ/xfhqS6D+WMPecnh9DuScq2xNHteg13SpYvi8c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qD9ELjfytto0kz2c2qwDNhrTCcsg/M1WoXc4+MZ6d7mdr9JFk2rI0Z+M5yBMySaeuDK0121YgSvl5IMTDn9+jLTj0IiLT8IANKTfNhzxHgT7SXgVYsvyAactInHwJknwhfvcwI/ofGXg+kkPCGCNElyyrtVCgnM+O2+VXDSltgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rudorff.com; spf=pass smtp.mailfrom=rudorff.com; arc=none smtp.client-ip=193.31.26.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rudorff.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rudorff.com
Received: from [127.0.1.1] (dynamic-002-211-221-196.2.211.pool.telefonica.de [2.211.221.196])
	by rudorff.com (Postfix) with ESMTPSA id BAC7E406C6;
	Fri, 16 Oct 2026 16:43:15 +0200 (CEST)
From: Christoph Rudorff <chris@rudorff.com>
Date: Fri, 16 Oct 2026 16:43:06 +0200
Subject: [PATCH 1/3] iio: light: gp2ap002: add led power supply
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261016-iio-light-gp2ap002-v1-1-7c93312fa8d5@rudorff.com>
References: <20261016-iio-light-gp2ap002-v1-0-7c93312fa8d5@rudorff.com>
In-Reply-To: <20261016-iio-light-gp2ap002-v1-0-7c93312fa8d5@rudorff.com>
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

According to data sheet "Recommended external circuit"
this got up to three supplies, we missed VLED

Now it works (tested on msm8916-samsung-j5):

$ cd /sys/bus/iio/devices/iio\:device1
$ echo 1 > events/in_proximity_thresh_either_en

$ iio_event_monitor /dev/iio\:device1

Event: time: 1791460068846871297, type: proximity, channel: 0,
evtype: thresh, direction: rising

Event: time: 1791460068876669724, type: proximity, channel: 0,
evtype: thresh, direction: falling

...

Signed-off-by: Christoph Rudorff <chris@rudorff.com>
---
 drivers/iio/light/gp2ap002.c | 28 +++++++++++++++++++++++++---
 1 file changed, 25 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/light/gp2ap002.c b/drivers/iio/light/gp2ap002.c
index de29081fd3b2..c03eb0f1988b 100644
--- a/drivers/iio/light/gp2ap002.c
+++ b/drivers/iio/light/gp2ap002.c
@@ -129,6 +129,7 @@
  * @dev: pointer to parent device
  * @vdd: regulator controlling VDD
  * @vio: regulator controlling VIO
+ * @vled: regulator controlling VLED
  * @alsout: IIO ADC channel to convert the ALSOUT signal
  * @hys_far: hysteresis control from device tree
  * @hys_close: hysteresis control from device tree
@@ -142,6 +143,7 @@ struct gp2ap002 {
 	struct device *dev;
 	struct regulator *vdd;
 	struct regulator *vio;
+	struct regulator *vled;
 	struct iio_channel *alsout;
 	u8 hys_far;
 	u8 hys_close;
@@ -169,7 +171,7 @@ static irqreturn_t gp2ap002_prox_irq(int irq, void *d)
 
 	if (val & GP2AP002_PROX_VO_DETECT) {
 		/* Close */
-		dev_dbg(gp2ap002->dev, "close\n");
+		dev_dbg(gp2ap002->dev, "close %i\n", val);
 		ret = regmap_write(gp2ap002->map, GP2AP002_HYS,
 				   gp2ap002->hys_far);
 		if (ret)
@@ -179,7 +181,7 @@ static irqreturn_t gp2ap002_prox_irq(int irq, void *d)
 					IIO_EV_TYPE_THRESH, IIO_EV_DIR_RISING);
 	} else {
 		/* Far */
-		dev_dbg(gp2ap002->dev, "far\n");
+		dev_dbg(gp2ap002->dev, "far %i\n", val);
 		ret = regmap_write(gp2ap002->map, GP2AP002_HYS,
 				   gp2ap002->hys_close);
 		if (ret)
@@ -530,14 +532,22 @@ static int gp2ap002_probe(struct i2c_client *client)
 	if (IS_ERR(gp2ap002->vio))
 		return dev_err_probe(dev, PTR_ERR(gp2ap002->vio),
 				     "failed to get VIO regulator\n");
+	// returns a dummy if not declared:
+	gp2ap002->vled = devm_regulator_get(dev, "vled");
+	if (IS_ERR(gp2ap002->vled))
+		return dev_err_probe(dev, PTR_ERR(gp2ap002->vled),
+				     "failed to get VLED regulator\n");
 
 	/* Operating voltage 2.4V .. 3.6V according to datasheet */
 	ret = regulator_set_voltage(gp2ap002->vdd, 2400000, 3600000);
 	if (ret) {
-		dev_err(dev, "failed to sett VDD voltage\n");
+		dev_err(dev, "failed to set VDD voltage\n");
 		return ret;
 	}
 
+	/* LED voltage 2.4V .. 3.6V according to datasheet */
+	/* nothing to set: it's a simple "regulator-fixed" gpio pin */
+
 	/* VIO should be between 1.65V and VDD */
 	ret = regulator_get_voltage(gp2ap002->vdd);
 	if (ret < 0) {
@@ -560,6 +570,11 @@ static int gp2ap002_probe(struct i2c_client *client)
 		dev_err(dev, "failed to enable VIO regulator\n");
 		goto out_disable_vdd;
 	}
+	ret = regulator_enable(gp2ap002->vled);
+	if (ret) {
+		dev_err(dev, "failed to enable VLED regulator\n");
+		goto out_disable_vio;
+	}
 
 	msleep(20);
 
@@ -635,6 +650,7 @@ static void gp2ap002_remove(struct i2c_client *client)
 	iio_device_unregister(indio_dev);
 	regulator_disable(gp2ap002->vio);
 	regulator_disable(gp2ap002->vdd);
+	regulator_disable(gp2ap002->vled);
 }
 
 static int gp2ap002_runtime_suspend(struct device *dev)
@@ -659,6 +675,7 @@ static int gp2ap002_runtime_suspend(struct device *dev)
 	 */
 	regulator_disable(gp2ap002->vio);
 	regulator_disable(gp2ap002->vdd);
+	regulator_disable(gp2ap002->vled);
 
 	return 0;
 }
@@ -679,6 +696,11 @@ static int gp2ap002_runtime_resume(struct device *dev)
 		dev_err(dev, "failed to enable VIO regulator in resume path\n");
 		goto out_disable_vdd;
 	}
+	ret = regulator_enable(gp2ap002->vled);
+	if (ret) {
+		dev_err(dev, "failed to enable VLED regulator in resume path\n");
+		goto out_disable_vio;
+	}
 
 	msleep(20);
 

-- 
2.39.5

