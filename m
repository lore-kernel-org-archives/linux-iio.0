Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0385B3164D6;
	Sat, 21 Mar 2026 10:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774087726; cv=none; b=H9BqepvL+AyVzmd30IIM+jKYiCLKIkBWqSA7LXATT/5Kw9WQBOvMnayKrIkVwWzEyJMUxHC3r0odG/uQ2+/a2KlCYMtkW2Ig8LF8DdOndu+4bLGuHxuR4yf8cVHWZnd4IfIVHOcO85Hfy8g3cFz8aM9C8vng+7dOjHoFB45Oru0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774087726; c=relaxed/simple;
	bh=pStcYONUPeydvPnH26N/mTaKyySSKp5boJuC3CYPAAM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cr+RidWX8JBp6ntbRUOBmvhA5javJgnVA2wiEIM7S+1pJS234/cpdBS0Vn2w3t3uAkhhGxiz2UYDr2utws6M3fkLDcMmr7Peas8SerQ655RT05Um+UFeK3/cBAM1MifAM5yBomAzdPpE1bJB9Fc2+63UHedzpqKkUf4lV0axQvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=1aq1ayqt; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="1aq1ayqt"
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62L8tESk2961633;
	Sat, 21 Mar 2026 06:08:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=xxkKh
	SbNhEy0vnp+MYeBsuQddZiMcL1lmJzG58BEqtA=; b=1aq1ayqt+qQoJoPdrMVw3
	+iUY+khW6vyQsdsvw6pA49wRsEvPefgwrpRNpt3XaIrkN39jv/wWtN3ztDvY8Sfg
	Bxput00odMipidmYlKE5zQ+AfSQ9PNTAlbBcyBrJiCgXhUXLyXmWNbn2zegrxg+n
	YxGzi7ZYVRn2wcvMQDiAHrqEwwNd2BlPx5z89SRZjL0YyuhSZO8XRZQHvO0QMIJy
	ntWM/QAeY5aJQ4VjvzaQ2ceH+fkhUrn8VPaOEjMLos5FUAmkWXEFVXqBiP3k7Dr2
	QCDp0ea6d1VQ5BrV4p2k03t4SyrZktXBvfAv1g0SLayfbA/6oNxMg9/ZNW08pJWM
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4d1r81r4n8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 21 Mar 2026 06:08:23 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 62LA8Mtq041668
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sat, 21 Mar 2026 06:08:22 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Sat, 21 Mar
 2026 06:08:22 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Sat, 21 Mar 2026 06:08:22 -0400
Received: from HYB-b1tGeUj4GP1.ad.analog.com ([10.32.226.156])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 62LA7nOM016475;
	Sat, 21 Mar 2026 06:08:16 -0400
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: Michael Hennerich <michael.hennerich@analog.com>,
        Marcelo Schmitt
	<marcelo.schmitt@analog.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?=
	<nuno.sa@analog.com>,
        Antoniu Miclaus <antoniu.miclaus@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Petre Rodan <petre.rodan@subdimension.ro>,
        Jorge Marques
	<jorge.marques@analog.com>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 4/4] iio: accel: adxl372: add support for ADXL371
Date: Sat, 21 Mar 2026 12:04:59 +0200
Message-ID: <20260321100729.2440-5-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260321100729.2440-1-antoniu.miclaus@analog.com>
References: <20260321100729.2440-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIxMDA4MiBTYWx0ZWRfX/Ffg61XTxOJ4
 9ctxrKU534kpPe0yakGX/vf1jEuZ8IVLEdiR2tWor52S+DhPhE3TZTRDP0EBij2by1vUyGkofdp
 tc1k/uWRJNueeM7MKK0EfzC0NxtUZXzKdlMLlToNQQCV9jl1aLBaj1Ge+HbkBIwmSAbKSzB6zsb
 l2giJPfGOs+c5//pR4W6ugRVbtLS4T4Pa8bA6MTvbTqfYrVFySBnjXhEeHxe1n6ksp7e9qffuFq
 U7LVVDpNkDHp4NKXNBmahNK0Yak49JIzprsr8Rv/sAQRDseGwez/nm2kMcIVqhmoWUntt4TJ3dr
 vmKc5q+KT+K5dzITRZ0KOngbua+bRPNNHL4mlFvLUzBRdSDkbohD/iynNh+7J+98x4pf5hUadvy
 sOBnG0wjTyNd0TtBTv8cdcEzB7g20O3ZoK7Ugqm9NZmi6OFExpy0OuMKL/SeduvK/Uwp2DsWT18
 uphu4ujx+KOpF5+Ju0A==
X-Authority-Analysis: v=2.4 cv=edIwvrEH c=1 sm=1 tr=0 ts=69be6e17 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=Z0pTeXoby7EwIRygza74:22 a=gAnH3GRIAAAA:8 a=BfISoG6HLkOeBhWiyOYA:9
 a=mpv_7z2a4kGo0ltCk4E8:22
X-Proofpoint-ORIG-GUID: khdQUm_DOAmRi7k8_Sh0yiqbF7gZ7QhK
X-Proofpoint-GUID: khdQUm_DOAmRi7k8_Sh0yiqbF7gZ7QhK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-21_03,2026-03-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 adultscore=0 clxscore=1015 phishscore=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 malwarescore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603210082

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
Changes in v4:
 - Drop trailing comma from ADXL371_ODR_NUM enum terminator.

 drivers/iio/accel/Kconfig       | 12 +++----
 drivers/iio/accel/adxl372.c     | 63 +++++++++++++++++++++++++++++----
 drivers/iio/accel/adxl372.h     |  4 ++-
 drivers/iio/accel/adxl372_i2c.c |  7 ++--
 drivers/iio/accel/adxl372_spi.c |  7 ++--
 5 files changed, 75 insertions(+), 18 deletions(-)

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
index 6fd4fe0ec1d9..478ae68f0553 100644
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
 	ADXL372_ODR_NUM
 };
 
+enum adxl371_odr {
+	ADXL371_ODR_320HZ,
+	ADXL371_ODR_640HZ,
+	ADXL371_ODR_1280HZ,
+	ADXL371_ODR_2560HZ,
+	ADXL371_ODR_5120HZ,
+	ADXL371_ODR_NUM
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
 
@@ -1266,10 +1307,15 @@ int adxl372_probe(struct device *dev, struct regmap *regmap,
 
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
@@ -1277,14 +1323,17 @@ int adxl372_probe(struct device *dev, struct regmap *regmap,
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
index 5d135b1150c8..ca2cabf24938 100644
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
@@ -44,12 +44,14 @@ static int adxl372_i2c_probe(struct i2c_client *client)
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
@@ -67,6 +69,7 @@ static struct i2c_driver adxl372_i2c_driver = {
 module_i2c_driver(adxl372_i2c_driver);
 
 MODULE_AUTHOR("Stefan Popa <stefan.popa@analog.com>");
-MODULE_DESCRIPTION("Analog Devices ADXL372 3-axis accelerometer I2C driver");
+MODULE_AUTHOR("Antoniu Miclaus <antoniu.miclaus@analog.com>");
+MODULE_DESCRIPTION("Analog Devices ADXL371/ADXL372 3-axis accelerometer I2C driver");
 MODULE_LICENSE("GPL");
 MODULE_IMPORT_NS("IIO_ADXL372");
diff --git a/drivers/iio/accel/adxl372_spi.c b/drivers/iio/accel/adxl372_spi.c
index e96a355bfe67..1f9c1544e547 100644
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
@@ -35,12 +35,14 @@ static int adxl372_spi_probe(struct spi_device *spi)
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
@@ -58,6 +60,7 @@ static struct spi_driver adxl372_spi_driver = {
 module_spi_driver(adxl372_spi_driver);
 
 MODULE_AUTHOR("Stefan Popa <stefan.popa@analog.com>");
-MODULE_DESCRIPTION("Analog Devices ADXL372 3-axis accelerometer SPI driver");
+MODULE_AUTHOR("Antoniu Miclaus <antoniu.miclaus@analog.com>");
+MODULE_DESCRIPTION("Analog Devices ADXL371/ADXL372 3-axis accelerometer SPI driver");
 MODULE_LICENSE("GPL");
 MODULE_IMPORT_NS("IIO_ADXL372");
-- 
2.43.0

