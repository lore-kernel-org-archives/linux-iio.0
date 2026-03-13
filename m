Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C9D43876D6;
	Fri, 13 Mar 2026 11:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773402989; cv=none; b=VVJJClDHUFju3Nlwmy+BK+vqORTnkC0JsZlTnxjozK0ieAL4HXTt0uvVPQo52dzY5U8LErk3Nlj3KR4HJFoCAFZTWybua++84E/Ugb2tcrPX3y/NGbxNQnr+7dH1sggapj37tNCgidqlkLQfHJSbbiIfta5JJsWEBr7Ys0Jp89s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773402989; c=relaxed/simple;
	bh=F/WwZ+V8Xb/k3p4qUYm+5DVVTce69TtV7vbVJD8YzAQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C/PoF6c6Jm6BHyShY5NF1ymewi7QS2kyOgMprrlHqtzu/FC7TgUY3sjeMHKhZTAUKWk4drNRDcEd05RNBZYbT4kO4C6ugyJ37VI0vV7MU+h5h8hmzqbQzFOpKKtD5mQKwTnJjEuK3GxPashwmcUaIujQ38gAokqckGlOxfQGGsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=H2wkd7rw; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="H2wkd7rw"
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62D9tAWX030173;
	Fri, 13 Mar 2026 07:56:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=KDq+H
	GePkSMJQjqRszDVRFVAkCJW9RX9lcykv1Inu/o=; b=H2wkd7rw2055L9Q4M1qGx
	XC4mXY5Igt2/byNo3cYfhtrPMZ1PMfqYi5SPfdrvGgNHCglMebfeV+/v6vPac1jF
	7GxvDzTXyy8ts6+UUJbYycneUKO/4mTE8rv5mho+XQfikYNm9LOk3MChbhQDgIy0
	WiIF1Hbd5YU+6FkbKQnf98a3rz9ZcRdQAM5MAqh0N7/iypP3E9HH7m+z04P2OxN0
	U9iNjLYxuVfBVGlTGYfYDOtMDLPiE9LhBLU8dnzrWIgVUtgmMvaKCzmDZdIJLze0
	9Tsl6T730WWw2N+scOwWujt9P9DzpSJ//72P0fRSo6oOu9bLws1LrOOYWkkD8LtO
	Q==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4cuh766yb5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Mar 2026 07:56:10 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 62DBu9OQ017366
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 13 Mar 2026 07:56:09 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 13 Mar 2026 07:56:09 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 13 Mar 2026 07:56:08 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 13 Mar 2026 07:56:08 -0400
Received: from HYB-b1tGeUj4GP1.ad.analog.com (HYB-b1tGeUj4GP1.ad.analog.com [10.48.65.247])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 62DBtTxL024500;
	Fri, 13 Mar 2026 07:56:01 -0400
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: Michael Hennerich <michael.hennerich@analog.com>,
        Lars-Peter Clausen
	<lars@metafoo.de>,
        Jonathan Cameron <jic23@kernel.org>,
        David Lechner
	<dlechner@baylibre.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
        "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Petre
 Rodan" <petre.rodan@subdimension.ro>,
        Jorge Marques
	<jorge.marques@analog.com>,
        Marcelo Schmitt <marcelo.schmitt@analog.com>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH v3 4/4] iio: accel: adxl372: add support for ADXL371
Date: Fri, 13 Mar 2026 13:54:57 +0200
Message-ID: <20260313115525.85435-5-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260313115525.85435-1-antoniu.miclaus@analog.com>
References: <20260313115525.85435-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: Z4bIkMn9tXlmlqrojVI_zKKOQwDcieTq
X-Authority-Analysis: v=2.4 cv=AI0/m/Lt c=1 sm=1 tr=0 ts=69b3fb5a cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=uXIjobp8t2wMuQ0fPvqm:22 a=gAnH3GRIAAAA:8 a=frw5fpX27FXSdM8m8iwA:9
 a=mpv_7z2a4kGo0ltCk4E8:22
X-Proofpoint-GUID: Z4bIkMn9tXlmlqrojVI_zKKOQwDcieTq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEzMDA5NCBTYWx0ZWRfX73nnZMZpaJvY
 0H6vvEXia8qF4urH/letZlN37hgvqe1qA0DMu8SblzwTnSQUYgYNS3QAqmgsg5WSy5npq5Rargg
 rg5KgRUzhwcYt9Wmvdp3MdWbn0biZ6zdk0Te+SVYJws8wNwI1wU7NllsPHsI+/VH8usPbyhNhgx
 it/TtnqCB38z4wmnpH9L1lhzq5VXrsd+Ydbbfy/emNbEgoMu6ZUc9jwA5DJTB48/mchA9DuXtlK
 EZlgysQG7JWDyXlJqO/NmsllerWtWK/c1+7Xt9SB90YooabZep94Fz2ZNCiu7eEigN1W5epahTx
 /7KbeCxDNbObOI7NiCjY04KViEopw2+e5RcsVqfOhNb/ndPc4PO5tjM/gHvFUOzzrLPtr+lefj4
 nAGiXevq5UHWTzCqdvBJ23/+BcvrTHV+t6o0YcwqSCB5MBF8/x4jRwQLp2Afu9dOpZ6QGiNPP/f
 +HUhl1XFNaF+kfgr7PQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-13_02,2026-03-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 impostorscore=0 spamscore=0 phishscore=0
 bulkscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603130094

Add support for the Analog Devices ADXL371, a +-200g 3-axis MEMS
accelerometer sharing the same register map as the ADXL372 but with
different ODR values (320/640/1280/2560/5120 Hz vs 400/800/1600/3200/
6400 Hz), different bandwidth values, and different timer scale
factors for activity/inactivity detection.

Due to a silicon anomaly (er001) causing FIFO data misalignment on
all current ADXL371 silicon, FIFO and triggered buffer support is
disabled for the ADXL371 - only direct mode reads are supported.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
Changes in v3:
 - Add ADXL371_ODR_NUM to adxl371_odr enum and use it to size the
   ADXL371 frequency tables.

Changes in v2:
 - Use adxl372_buffer_setup() helper instead of inlining buffer/trigger
   conditional logic in probe.
 - Use designated initializers for ADXL371 frequency tables.

 drivers/iio/accel/Kconfig       | 12 +++---
 drivers/iio/accel/adxl372.c     | 67 ++++++++++++++++++++++++++++-----
 drivers/iio/accel/adxl372.h     |  4 +-
 drivers/iio/accel/adxl372_i2c.c |  7 +++-
 drivers/iio/accel/adxl372_spi.c |  7 +++-
 5 files changed, 77 insertions(+), 20 deletions(-)

diff --git a/drivers/iio/accel/Kconfig b/drivers/iio/accel/Kconfig
index 3d3f8d8673dd..4094299e2ed8 100644
--- a/drivers/iio/accel/Kconfig
+++ b/drivers/iio/accel/Kconfig
@@ -158,24 +158,24 @@ config ADXL372
 	select IIO_TRIGGERED_BUFFER
 
 config ADXL372_SPI
-	tristate "Analog Devices ADXL372 3-Axis Accelerometer SPI Driver"
+	tristate "Analog Devices ADXL371/ADXL372 3-Axis Accelerometer SPI Driver"
 	depends on SPI
 	select ADXL372
 	select REGMAP_SPI
 	help
-	  Say yes here to add support for the Analog Devices ADXL372 triaxial
-	  acceleration sensor.
+	  Say yes here to add support for the Analog Devices ADXL371/ADXL372
+	  triaxial acceleration sensor.
 	  To compile this driver as a module, choose M here: the
 	  module will be called adxl372_spi.
 
 config ADXL372_I2C
-	tristate "Analog Devices ADXL372 3-Axis Accelerometer I2C Driver"
+	tristate "Analog Devices ADXL371/ADXL372 3-Axis Accelerometer I2C Driver"
 	depends on I2C
 	select ADXL372
 	select REGMAP_I2C
 	help
-	  Say yes here to add support for the Analog Devices ADXL372 triaxial
-	  acceleration sensor.
+	  Say yes here to add support for the Analog Devices ADXL371/ADXL372
+	  triaxial acceleration sensor.
 	  To compile this driver as a module, choose M here: the
 	  module will be called adxl372_i2c.
 
diff --git a/drivers/iio/accel/adxl372.c b/drivers/iio/accel/adxl372.c
index b1d611619e16..c5eea32d81db 100644
--- a/drivers/iio/accel/adxl372.c
+++ b/drivers/iio/accel/adxl372.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
- * ADXL372 3-Axis Digital Accelerometer core driver
+ * ADXL371/ADXL372 3-Axis Digital Accelerometer core driver
  *
  * Copyright 2018 Analog Devices Inc.
  */
@@ -183,6 +183,15 @@ enum adxl372_odr {
 	ADXL372_ODR_NUM,
 };
 
+enum adxl371_odr {
+	ADXL371_ODR_320HZ,
+	ADXL371_ODR_640HZ,
+	ADXL371_ODR_1280HZ,
+	ADXL371_ODR_2560HZ,
+	ADXL371_ODR_5120HZ,
+	ADXL371_ODR_NUM,
+};
+
 enum adxl372_bandwidth {
 	ADXL372_BW_200HZ,
 	ADXL372_BW_400HZ,
@@ -231,6 +240,37 @@ static const int adxl372_bw_freq_tbl[ADXL372_ODR_NUM] = {
 	[ADXL372_BW_3200HZ] = 3200,
 };
 
+static const int adxl371_samp_freq_tbl[ADXL371_ODR_NUM] = {
+	[ADXL371_ODR_320HZ] = 320,
+	[ADXL371_ODR_640HZ] = 640,
+	[ADXL371_ODR_1280HZ] = 1280,
+	[ADXL371_ODR_2560HZ] = 2560,
+	[ADXL371_ODR_5120HZ] = 5120,
+};
+
+static const int adxl371_bw_freq_tbl[ADXL371_ODR_NUM] = {
+	[ADXL371_ODR_320HZ] = 160,
+	[ADXL371_ODR_640HZ] = 320,
+	[ADXL371_ODR_1280HZ] = 640,
+	[ADXL371_ODR_2560HZ] = 1280,
+	[ADXL371_ODR_5120HZ] = 2560,
+};
+
+const struct adxl372_chip_info adxl371_chip_info = {
+	.name = "adxl371",
+	.samp_freq_tbl = adxl371_samp_freq_tbl,
+	.bw_freq_tbl = adxl371_bw_freq_tbl,
+	.num_freqs = ARRAY_SIZE(adxl371_samp_freq_tbl),
+	.act_time_scale_us = 4125,
+	.act_time_scale_low_us = 8250,
+	.inact_time_scale_ms = 16,
+	.inact_time_scale_low_ms = 32,
+	.max_odr = ADXL371_ODR_5120HZ,
+	/* Silicon erratum (er001) causes FIFO data misalignment on ADXL371 */
+	.fifo_supported = false,
+};
+EXPORT_SYMBOL_NS_GPL(adxl371_chip_info, "IIO_ADXL372");
+
 const struct adxl372_chip_info adxl372_chip_info = {
 	.name = "adxl372",
 	.samp_freq_tbl = adxl372_samp_freq_tbl,
@@ -241,6 +281,7 @@ const struct adxl372_chip_info adxl372_chip_info = {
 	.inact_time_scale_ms = 13,
 	.inact_time_scale_low_ms = 26,
 	.max_odr = ADXL372_ODR_6400HZ,
+	.fifo_supported = true,
 };
 EXPORT_SYMBOL_NS_GPL(adxl372_chip_info, "IIO_ADXL372");
 
@@ -1217,8 +1258,8 @@ static int adxl372_buffer_setup(struct iio_dev *indio_dev)
 		return -ENOMEM;
 
 	st->peak_datardy_trig = devm_iio_trigger_alloc(dev, "%s-dev%d-peak",
-							indio_dev->name,
-							iio_device_id(indio_dev));
+						       indio_dev->name,
+						       iio_device_id(indio_dev));
 	if (!st->peak_datardy_trig)
 		return -ENOMEM;
 
@@ -1265,10 +1306,15 @@ int adxl372_probe(struct device *dev, struct regmap *regmap,
 
 	indio_dev->channels = adxl372_channels;
 	indio_dev->num_channels = ARRAY_SIZE(adxl372_channels);
-	indio_dev->available_scan_masks = adxl372_channel_masks;
 	indio_dev->name = chip_info->name;
 	indio_dev->info = &adxl372_info;
-	indio_dev->modes = INDIO_DIRECT_MODE | INDIO_BUFFER_SOFTWARE;
+
+	if (chip_info->fifo_supported) {
+		indio_dev->modes = INDIO_DIRECT_MODE | INDIO_BUFFER_SOFTWARE;
+		indio_dev->available_scan_masks = adxl372_channel_masks;
+	} else {
+		indio_dev->modes = INDIO_DIRECT_MODE;
+	}
 
 	ret = adxl372_setup(st);
 	if (ret < 0) {
@@ -1276,14 +1322,17 @@ int adxl372_probe(struct device *dev, struct regmap *regmap,
 		return ret;
 	}
 
-	ret = adxl372_buffer_setup(indio_dev);
-	if (ret < 0)
-		return ret;
+	if (chip_info->fifo_supported) {
+		ret = adxl372_buffer_setup(indio_dev);
+		if (ret < 0)
+			return ret;
+	}
 
 	return devm_iio_device_register(dev, indio_dev);
 }
 EXPORT_SYMBOL_NS_GPL(adxl372_probe, "IIO_ADXL372");
 
 MODULE_AUTHOR("Stefan Popa <stefan.popa@analog.com>");
-MODULE_DESCRIPTION("Analog Devices ADXL372 3-axis accelerometer driver");
+MODULE_AUTHOR("Antoniu Miclaus <antoniu.miclaus@analog.com>");
+MODULE_DESCRIPTION("Analog Devices ADXL371/ADXL372 3-axis accelerometer driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/iio/accel/adxl372.h b/drivers/iio/accel/adxl372.h
index 3ce06609446c..353a8b3a9d76 100644
--- a/drivers/iio/accel/adxl372.h
+++ b/drivers/iio/accel/adxl372.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0+ */
 /*
- * ADXL372 3-Axis Digital Accelerometer
+ * ADXL371/ADXL372 3-Axis Digital Accelerometer
  *
  * Copyright 2018 Analog Devices Inc.
  */
@@ -20,8 +20,10 @@ struct adxl372_chip_info {
 	unsigned int inact_time_scale_ms;
 	unsigned int inact_time_scale_low_ms;
 	unsigned int max_odr;
+	bool fifo_supported;
 };
 
+extern const struct adxl372_chip_info adxl371_chip_info;
 extern const struct adxl372_chip_info adxl372_chip_info;
 
 int adxl372_probe(struct device *dev, struct regmap *regmap,
diff --git a/drivers/iio/accel/adxl372_i2c.c b/drivers/iio/accel/adxl372_i2c.c
index 3f97126a87a1..40acfa611c83 100644
--- a/drivers/iio/accel/adxl372_i2c.c
+++ b/drivers/iio/accel/adxl372_i2c.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
- * ADXL372 3-Axis Digital Accelerometer I2C driver
+ * ADXL371/ADXL372 3-Axis Digital Accelerometer I2C driver
  *
  * Copyright 2018 Analog Devices Inc.
  */
@@ -46,12 +46,14 @@ static int adxl372_i2c_probe(struct i2c_client *client)
 }
 
 static const struct i2c_device_id adxl372_i2c_id[] = {
+	{ "adxl371", (kernel_ulong_t)&adxl371_chip_info },
 	{ "adxl372", (kernel_ulong_t)&adxl372_chip_info },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, adxl372_i2c_id);
 
 static const struct of_device_id adxl372_of_match[] = {
+	{ .compatible = "adi,adxl371", .data = &adxl371_chip_info },
 	{ .compatible = "adi,adxl372", .data = &adxl372_chip_info },
 	{ }
 };
@@ -69,6 +71,7 @@ static struct i2c_driver adxl372_i2c_driver = {
 module_i2c_driver(adxl372_i2c_driver);
 
 MODULE_AUTHOR("Stefan Popa <stefan.popa@analog.com>");
-MODULE_DESCRIPTION("Analog Devices ADXL372 3-axis accelerometer I2C driver");
+MODULE_AUTHOR("Antoniu Miclaus <antoniu.miclaus@analog.com>");
+MODULE_DESCRIPTION("Analog Devices ADXL371/ADXL372 3-axis accelerometer I2C driver");
 MODULE_LICENSE("GPL");
 MODULE_IMPORT_NS("IIO_ADXL372");
diff --git a/drivers/iio/accel/adxl372_spi.c b/drivers/iio/accel/adxl372_spi.c
index 0e199feb405e..438e2bef5b77 100644
--- a/drivers/iio/accel/adxl372_spi.c
+++ b/drivers/iio/accel/adxl372_spi.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
- * ADXL372 3-Axis Digital Accelerometer SPI driver
+ * ADXL371/ADXL372 3-Axis Digital Accelerometer SPI driver
  *
  * Copyright 2018 Analog Devices Inc.
  */
@@ -37,12 +37,14 @@ static int adxl372_spi_probe(struct spi_device *spi)
 }
 
 static const struct spi_device_id adxl372_spi_id[] = {
+	{ "adxl371", (kernel_ulong_t)&adxl371_chip_info },
 	{ "adxl372", (kernel_ulong_t)&adxl372_chip_info },
 	{ }
 };
 MODULE_DEVICE_TABLE(spi, adxl372_spi_id);
 
 static const struct of_device_id adxl372_of_match[] = {
+	{ .compatible = "adi,adxl371", .data = &adxl371_chip_info },
 	{ .compatible = "adi,adxl372", .data = &adxl372_chip_info },
 	{ }
 };
@@ -60,6 +62,7 @@ static struct spi_driver adxl372_spi_driver = {
 module_spi_driver(adxl372_spi_driver);
 
 MODULE_AUTHOR("Stefan Popa <stefan.popa@analog.com>");
-MODULE_DESCRIPTION("Analog Devices ADXL372 3-axis accelerometer SPI driver");
+MODULE_AUTHOR("Antoniu Miclaus <antoniu.miclaus@analog.com>");
+MODULE_DESCRIPTION("Analog Devices ADXL371/ADXL372 3-axis accelerometer SPI driver");
 MODULE_LICENSE("GPL");
 MODULE_IMPORT_NS("IIO_ADXL372");
-- 
2.43.0

