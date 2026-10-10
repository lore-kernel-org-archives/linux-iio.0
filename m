Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 724163DB339
	for <linux-iio@vger.kernel.org>; Sat, 10 Oct 2026 06:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791615236; cv=none; b=ivUiRyfMZYYRnFPCE8ARASi0YRpOBxO3a6p+hagLH7Gn+K08LMaEclVZ6I1IWa4wPJkMQpT9m15E/+Q+jyW9tVCjvdBiKXJ19YfdKAa6zLz24zon3OpLRE4S6CZIp1oyfvZbmqjYvEcFJYBmKRawPb3wp2h7ys/Dj9D2XL5kERo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791615236; c=relaxed/simple;
	bh=B/kHXVE12QnA9mi1Z6GgRqHoK7Ayw7XLiDZ492DM+tM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WT67wyiI//BnzuCF2uWKVT6+lX61zVok9khj3ivuIJVf7cEhlnapNdB6Xirlyjpy4Hp3AqpUOt1NMAsRDh6z1RAMu60gCZBXFlvu00cYaKRn9OOe19zkLiw4Hxhay4GWLB4q2j9hcQr7HYtJxMFHH3J20dCH65oXq94hk5JfbIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DzfqXZpX; arc=none smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DzfqXZpX"
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-356b1e20700so723334eec.1
        for <linux-iio@vger.kernel.org>; Fri, 09 Oct 2026 23:53:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791615234; x=1792220034; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AFImlOZb2wbRTDKx/9iuFhDiHEuwy5A5BWStW8aQ1JU=;
        b=DzfqXZpX+L6JaL1MPfrfzXs+8yIl1YFByisaqktQPf7ZHZmMHkxOOzwTugmHDau0v6
         v27gVN74TzqRm8MmXAeOFa5lHurhWc6aSms0JuVfOoITM0frj4wWTLCBjayvH9gxzSCL
         byzZ0Yin9hlUzUQrT2giKVJkY1KyxySRa7Olx0vgXByhIhqcvIf+gQULUzAeqUy9zR9j
         FOhVIWTXuXGcCMrwQrvEWWrSElOUrXrAZECTcAVSizL7t0oHPbE7H2ZXyz5mlZpoKLUo
         cI49Z0OeL1ia4NLfv3VTjINu3rQnP1LPxBdxq+Em94uiG26nlzTzWHMhi6TPaDmRU619
         V/2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791615234; x=1792220034;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AFImlOZb2wbRTDKx/9iuFhDiHEuwy5A5BWStW8aQ1JU=;
        b=spiH588MbfS9cFORXSrkHsFAma5BlxJog0yrLvavNTXKFuf0e7qO0Qgm/2q3sro6N4
         ymu1+accLHh9HfPEgsjzZM6pYdSljL1xHXTCtulhczehw4PNa2iIOaEHBO6Apkg7ENR1
         URrLw+IGtY+ZkpCSx5Fi8UJoi8sYHTzKFbAy9GwaLW3yo26uKyrxxpZ1Lbgatv/YeNo8
         p4b/VvKPjA5T8tC0bqd4TKiFHuutbnWDOgUgqaSncviBK/Q8lP7vGOl+vDTvTT/Lmobb
         d0fF4lwmErK8fJt639cIM4AhUQwfGANLIOymtiCUNmt+32g4YKbXrqDyAHOe7LqIL5tf
         j6qw==
X-Forwarded-Encrypted: i=1; AKwUvByhcI032McAWMZmJVh7l33uCoQd2N46Lm2d9xgxfsvHFZdBErLvol8rVEqWQAJmeWlspOIAmVAnBvE=@vger.kernel.org
X-Gm-Message-State: AFq9FYLYqShWIhyOqPY2CcyQ3NoooGai9O2lTL8zOQ2WSSLtpTLHFCK5
	Cm31DhnxxK6MDVHJN0RbNGvaz7pfzc7GVXX5SNM8dXPVzg0pElTITcf1
X-Gm-Gg: AYBFou2KvCnh06iUSw3H1WYRlth41qfa+v2zse00C2LK4pp4gqBkufb9vwWRdF+uFx8
	y7DtpWqghHlt+OI69iahc5nQBkuN/52EJZmMJN4KW3MiYs2jrnR6IRVuh96vECp2QiuxeqBR6J9
	f10c0EC6xXBI+7ymlZ62dIe//tuEGM73hxoRo6a/kOqVUUEwlz7Y+NQVVuRO0W40fakJ+HM9tLy
	pTzhfyvn2InmL/yKEVGwssCD0bbGA0+PCPFZpTH2Ku9kCTC60ZN1EBN9MVYPQYTukvAMDM0+BVn
	0ap89VMnOdvJcGzH9mr+dkrJ03gfeNjTFrfuxELupPKIc/Wr7M0DA2D1MSVIrVaxcKHiUeAcwFX
	Y+KvAjx3B4NTnHDdHEXLNXuO+aFtaSJ47UKkTf4ZCgjIjL9+uwen/+h6z8Aex7BXPVFFpP5Zr2U
	kWh2KdG6rQFS9gAywU3SEyvo0B19MJaEIs83/nl+JF57O3KiczmXtIRlL2lDZRWN8nexwEa+wfp
	2T2IaEOax+eJBzys0M9udShtLZTZTury9ZcC1s=
X-Received: by 2002:a05:693c:4151:20b0:34c:5841:3e12 with SMTP id 5a478bee46e88-3537dfec887mr6030970eec.9.1791615234389;
        Fri, 09 Oct 2026 23:53:54 -0700 (PDT)
Received: from [192.168.100.70] (host-200-61-172-117.iplanisp.com.ar. [200.61.172.117])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537cacb5e9sm13009650eec.20.2026.10.09.23.53.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 23:53:53 -0700 (PDT)
From: Kurt Borja <kuurtb@gmail.com>
Date: Sat, 10 Oct 2026 03:52:48 -0300
Subject: [PATCH v5 09/10] iio: adc: ti-ads1262: support REFOUT and VBIAS
 regulators
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261010-ads126x-v5-9-49e331cb2fed@gmail.com>
References: <20261010-ads126x-v5-0-49e331cb2fed@gmail.com>
In-Reply-To: <20261010-ads126x-v5-0-49e331cb2fed@gmail.com>
To: Kurt Borja <kuurtb@gmail.com>, Jonathan Cameron <jic23@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, David Lechner <dlechner@baylibre.com>
Cc: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4743; i=kuurtb@gmail.com;
 h=from:subject:message-id; bh=B/kHXVE12QnA9mi1Z6GgRqHoK7Ayw7XLiDZ492DM+tM=;
 b=kA0DAAoWFmBDOPSf1GYByyZiAGrJ4ObItW+k+56RRDGBpsBYh0Goz3F/yEpQAVc+RmLO0fjU8
 oh1BAAWCgAdFiEEh2Ci9uJabu1OwFXfFmBDOPSf1GYFAmrJ4OYACgkQFmBDOPSf1GYFhgD7BWpD
 WOvRz34uayTSGwQV28ZFz0RaMZJyDN5bTgbfjj8A/2zp0MiA1jYleD9jlbVVORPRVoSiQCze86v
 pbHO2DcUB
X-Developer-Key: i=kuurtb@gmail.com; a=openpgp;
 fpr=54D3BE170AEF777983C3C63B57E3B6585920A69A

Register the "refout" and "vbias" regulators to be able to use them as
common mode supplies.

Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
 drivers/iio/adc/Kconfig      |   1 +
 drivers/iio/adc/ti-ads1262.c | 120 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 121 insertions(+)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 6d5df9c041ac..1d05ba6e9886 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -1904,6 +1904,7 @@ config TI_ADS1262
 	tristate "Texas Instruments ADS1262"
 	depends on SPI
 	select REGMAP
+	select REGULATOR
 	select IIO_BUFFER
 	select IIO_TRIGGERED_BUFFER
 	help
diff --git a/drivers/iio/adc/ti-ads1262.c b/drivers/iio/adc/ti-ads1262.c
index 0606e712feec..5bb41b70353f 100644
--- a/drivers/iio/adc/ti-ads1262.c
+++ b/drivers/iio/adc/ti-ads1262.c
@@ -24,6 +24,7 @@
 #include <linux/property.h>
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
+#include <linux/regulator/driver.h>
 #include <linux/spi/spi.h>
 #include <linux/string.h>
 #include <linux/types.h>
@@ -1122,6 +1123,121 @@ static irqreturn_t ads1262_irq_handler(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
+static int ads1262_vbias_enable(struct regulator_dev *rdev)
+{
+	struct ads1262 *st = rdev_get_drvdata(rdev);
+
+	guard(mutex)(&st->xfer_lock);
+
+	return regmap_set_bits(st->regmap, ADS1262_POWER_REG,
+			       ADS1262_POWER_VBIAS_MASK);
+}
+
+static int ads1262_vbias_disable(struct regulator_dev *rdev)
+{
+	struct ads1262 *st = rdev_get_drvdata(rdev);
+
+	guard(mutex)(&st->xfer_lock);
+
+	return regmap_clear_bits(st->regmap, ADS1262_POWER_REG,
+				 ADS1262_POWER_VBIAS_MASK);
+}
+
+static int ads1262_vbias_is_enabled(struct regulator_dev *rdev)
+{
+	struct ads1262 *st = rdev_get_drvdata(rdev);
+
+	guard(mutex)(&st->xfer_lock);
+
+	return regmap_test_bits(st->regmap, ADS1262_POWER_REG,
+				ADS1262_POWER_VBIAS_MASK);
+}
+
+static int ads1262_vbias_get_voltage(struct regulator_dev *rdev)
+{
+	struct ads1262 *st = rdev_get_drvdata(rdev);
+
+	if (!st->avdd_uV)
+		return -EINVAL;
+
+	return DIV_ROUND_CLOSEST(st->avdd_uV + st->avss_uV, 2);
+}
+
+static const struct regulator_ops ads1262_vbias_regulator_ops = {
+	.enable = ads1262_vbias_enable,
+	.disable = ads1262_vbias_disable,
+	.is_enabled = ads1262_vbias_is_enabled,
+	.get_voltage = ads1262_vbias_get_voltage,
+};
+
+static int ads1262_refout_is_enabled(struct regulator_dev *rdev)
+{
+	struct ads1262 *st = rdev_get_drvdata(rdev);
+
+	guard(mutex)(&st->xfer_lock);
+
+	return regmap_test_bits(st->regmap, ADS1262_POWER_REG,
+				ADS1262_POWER_INTREF_MASK);
+}
+
+static int ads1262_refout_get_voltage(struct regulator_dev *rdev)
+{
+	struct ads1262 *st = rdev_get_drvdata(rdev);
+
+	/* The internal reference 2.5 V is measured above AVSS */
+	return st->avss_uV + ADS1262_INTERNAL_REFERENCE_uV;
+}
+
+static const struct regulator_ops ads1262_refout_regulator_ops = {
+	.is_enabled = ads1262_refout_is_enabled,
+	.get_voltage = ads1262_refout_get_voltage,
+};
+
+static const struct regulator_desc ads1262_vbias_regulator_desc = {
+	.name = "vbias",
+	.of_match = "vbias",
+	.regulators_node = "regulators",
+	.supply_name = "avdd",
+	.ops = &ads1262_vbias_regulator_ops,
+	.type = REGULATOR_VOLTAGE,
+	.owner = THIS_MODULE,
+};
+
+static const struct regulator_desc ads1262_refout_regulator_desc = {
+	.name = "refout",
+	.of_match = "refout",
+	.regulators_node = "regulators",
+	.supply_name = "avdd",
+	.ops = &ads1262_refout_regulator_ops,
+	.type = REGULATOR_VOLTAGE,
+	.owner = THIS_MODULE,
+};
+
+static int ads1262_register_regulators(struct ads1262 *st)
+{
+	struct device *dev = &st->spi->dev;
+	struct regulator_config config = {
+		.dev = dev,
+		.driver_data = st,
+	};
+	struct regulator_dev *rdev;
+
+	struct fwnode_handle *reg_node __free(fwnode_handle) =
+		device_get_named_child_node(dev, "regulators");
+	if (!reg_node)
+		return 0;
+
+	rdev = devm_regulator_register(dev, &ads1262_refout_regulator_desc,
+				       &config);
+	if (IS_ERR(rdev))
+		return PTR_ERR(rdev);
+
+	rdev = devm_regulator_register(dev, &ads1262_vbias_regulator_desc,
+				       &config);
+
+	return PTR_ERR_OR_ZERO(rdev);
+}
+
 static int ads1262_dev_configure(struct ads1262 *st)
 {
 	struct device *dev = &st->spi->dev;
@@ -1907,6 +2023,10 @@ static int ads1262_spi_probe(struct spi_device *spi)
 	if (ret)
 		return dev_err_probe(dev, ret, "failed to configure device\n");
 
+	ret = ads1262_register_regulators(st);
+	if (ret)
+		return ret;
+
 	ret = ads1262_populate_tables(indio_dev);
 	if (ret)
 		return ret;

-- 
2.55.0

