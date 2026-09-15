Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E6534C1505;
	Tue, 15 Sep 2026 19:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789499571; cv=none; b=eNkYT89OHuWV+uwTY+Tsl79J/j18Tyr+AFShotyDSDe3MGPGfZvFQZWZbYtOaI4+CPTU0VVDtwQ/12lDJ9xpGYDcjCh03wr8fkfAAwyAuJP7N8auuhCWm23BHyNpI9gY+lMKZyRm4n+1FJmfOGmQQxxkZ0SI+0RnR2w7bZezxE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789499571; c=relaxed/simple;
	bh=xzM05woBVkfvIV7jbQ2MVnr09Rjm1Rr1gF3B2JligmM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RqEjs5BJ1vEuWJhO697JS2INjBFZqeDybnJEUL9k/lAM/WQEjInA/wVuxN5HraXyNMo4WEOe/CIZfcollTFRgUJ2ekcVcRBSD91w/djpGF2reTXVvSDexZGu7GEOhX21sZI6Ofr1dYgK8gSJjuaq6HIHSQeAMy/J83WxMeUhCTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=gFB0Sgp8; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="gFB0Sgp8"
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68FIscB91755371;
	Tue, 15 Sep 2026 15:12:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=VFLS+
	1g7e79+6ZW6qXsNhBJ9H+9IHOM1RJ95G70iZqQ=; b=gFB0Sgp8yAkcMPMNrZLOf
	28+NPaul7le6rI3GuA1droW54UOijdsFE1gmimAHXPgJQhsyj9iQh312Iuq7Bp+6
	U9hSeHuowWvs9Mp7Epm2QTV0QlUCtO7oELFPF3xzb3eRBXahBR0bofVsBDKlB+a9
	9lQFJzwyhedYz7tdZteQFdYFzpO28VLQ2dawFNuj8faHsRQ/ntmD3xPM6TZXxayV
	F7wGdYdFT/iQvj4do1CvqUO3iJhzCjOpx397HdwVK7xaytVonA3+PowArMmVu7/d
	pLLdIewcgF7pks/wKGFvD+dl5FNZ6QeEl6SH/tnS+a4mf1JLPUbzgac0DxdLh9Vt
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4gq43rjpyt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Sep 2026 15:12:42 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 68FJCfe2018954
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 15 Sep 2026 15:12:41 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Tue, 15 Sep 2026 15:12:41 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Tue, 15 Sep 2026 15:12:41 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Tue, 15 Sep 2026 15:12:41 -0400
Received: from work.maxim-ic.internal ([10.66.6.190])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 68FJCPts028116;
	Tue, 15 Sep 2026 15:12:27 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux@analog.com>
CC: <jic23@kernel.org>, <nuno.sa@analog.com>, <dlechner@baylibre.com>,
        <andy@kernel.org>, <Michael.Hennerich@analog.com>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <corbet@lwn.net>,
        <skhan@linuxfoundation.org>, <marcelo.schmitt1@gmail.com>,
        Andy Shevchenko
	<andriy.shevchenko@intel.com>
Subject: [PATCH v2 02/15] iio: Fix typo in vendor name
Date: Tue, 15 Sep 2026 16:12:19 -0300
Message-ID: <8ba81bb20d92fbfd8e4b7ce80093223fcb8534b0.1789494473.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1789494473.git.marcelo.schmitt@analog.com>
References: <cover.1789494473.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: acmET71vuCDuDkpOAtCg5QR3cmCUW1vY
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE1MDI4MCBTYWx0ZWRfXzrJl48BBNmbN
 WE3bkth3W7d2Xb4lyvRSd6jkU165o0zrgQZTrE2jQjlQX9vFqI/SqaEojMk6tYx92RXW6iktHAQ
 C76CzvDW3BCC00TG5W6y45kRrn8g9V/MoZqq5tzym2Vlz2S8Jybr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE1MDI4MCBTYWx0ZWRfXx4AEmdsSHePY
 xC+55szdiAMHY/kzTOv+KGOSEOkY6nmxOqKApwqrbJjBAU4npEpOC/V4cl4RNMsMdQM3rxFXTw1
 JHeNChvmqm1tgT0ZDtn6JDLjO2jWlBbyD0lFPrNwxWuGtkFW2di234fhtkvOy5ejz8dWx08iUSx
 bhJ0fPStRbXTDHDUR+/KPGyjSJhAhoEKqyS0vD2lnQOjKIsn4Q5VrN8Nts/pw/0ONJwiyl8n5f2
 e1IV2iRNsmiRCdFZBISy5dMJLzoUzGlm4u+BuZ6OHUGWEaMMqXCKxt1F9a3SuLuCIIN9SYH8Mhc
 DF4WKgnQPoykpus8I74gXa8nlxNZH0eSPa+pNkvW1TjjcPUug9STzeIoaegENR9xZtpUemdpLv2
 XqUKndOpKq0TQCyDeVpDBuXHFcjFOILeDTCanMGQsFw/7CGQCObuUfAyplWE9gesIJA5Jhm7XRd
 R8KsLBGizRNBZ0XZVlg==
X-Authority-Analysis: v=2.4 cv=HZeB3SE8 c=1 sm=1 tr=0 ts=6aa998aa cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=OmVn7CZJonkx5R5zMQLL:22 a=QyXUC8HyAAAA:8 a=gAnH3GRIAAAA:8
 a=MCMPggia4XBponqUwisA:9
X-Proofpoint-GUID: acmET71vuCDuDkpOAtCg5QR3cmCUW1vY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-15_05,2026-09-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 suspectscore=0 malwarescore=0 priorityscore=1501
 spamscore=0 adultscore=0 impostorscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609150280

Correct a typo in vendor company name: "Analog Device" -> "Analog Devices".

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
Change log v1 -> v2:
- Now also fixing Analog Devices possessive suffix usage.

 Documentation/iio/ade9000.rst   |  2 +-
 Documentation/iio/adis16475.rst |  2 +-
 Documentation/iio/adis16480.rst |  2 +-
 Documentation/iio/adis16550.rst |  2 +-
 Documentation/iio/adxl313.rst   |  2 +-
 Documentation/iio/adxl345.rst   |  2 +-
 Documentation/iio/adxl380.rst   |  2 +-
 drivers/iio/adc/Kconfig         | 12 ++++++------
 drivers/iio/dac/ad3552r.c       |  2 +-
 9 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/Documentation/iio/ade9000.rst b/Documentation/iio/ade9000.rst
index 72737b5ec59c..f41660005223 100644
--- a/Documentation/iio/ade9000.rst
+++ b/Documentation/iio/ade9000.rst
@@ -4,7 +4,7 @@
 ADE9000/ADE9078 driver
 ======================
 
-This driver supports Analog Device's ADE9000 and ADE9078 energy measurement
+This driver supports Analog Devices' ADE9000 and ADE9078 energy measurement
 ICs on SPI bus.
 
 1. Supported devices
diff --git a/Documentation/iio/adis16475.rst b/Documentation/iio/adis16475.rst
index 89a388490ab7..0e004f016199 100644
--- a/Documentation/iio/adis16475.rst
+++ b/Documentation/iio/adis16475.rst
@@ -4,7 +4,7 @@
 ADIS16475 driver
 ================
 
-This driver supports Analog Device's IMUs on SPI bus.
+This driver supports Analog Devices' IMUs on SPI bus.
 
 1. Supported devices
 ====================
diff --git a/Documentation/iio/adis16480.rst b/Documentation/iio/adis16480.rst
index cce5f3e01741..7c259070aaaf 100644
--- a/Documentation/iio/adis16480.rst
+++ b/Documentation/iio/adis16480.rst
@@ -4,7 +4,7 @@
 ADIS16480 driver
 ================
 
-This driver supports Analog Device's IMUs on SPI bus.
+This driver supports Analog Devices' IMUs on SPI bus.
 
 1. Supported devices
 ====================
diff --git a/Documentation/iio/adis16550.rst b/Documentation/iio/adis16550.rst
index c9bbc0a857b0..c0d5a975e6ca 100644
--- a/Documentation/iio/adis16550.rst
+++ b/Documentation/iio/adis16550.rst
@@ -4,7 +4,7 @@
 ADIS16550 driver
 ================
 
-This driver supports Analog Device's IMUs on SPI bus.
+This driver supports Analog Devices' IMUs on SPI bus.
 
 1. Supported devices
 ====================
diff --git a/Documentation/iio/adxl313.rst b/Documentation/iio/adxl313.rst
index 3641193bf647..c448f10745e7 100644
--- a/Documentation/iio/adxl313.rst
+++ b/Documentation/iio/adxl313.rst
@@ -4,7 +4,7 @@
 ADXL313 driver
 ===============
 
-This driver supports Analog Device's ADXL313 on SPI/I2C bus.
+This driver supports Analog Devices' ADXL313 on SPI/I2C bus.
 
 1. Supported devices
 ====================
diff --git a/Documentation/iio/adxl345.rst b/Documentation/iio/adxl345.rst
index 0aa33a852412..28c71fbd45e5 100644
--- a/Documentation/iio/adxl345.rst
+++ b/Documentation/iio/adxl345.rst
@@ -4,7 +4,7 @@
 ADXL345 driver
 ===============
 
-This driver supports Analog Device's ADXL345/375 on SPI/I2C bus.
+This driver supports Analog Devices' ADXL345/375 on SPI/I2C bus.
 
 1. Supported Devices
 ====================
diff --git a/Documentation/iio/adxl380.rst b/Documentation/iio/adxl380.rst
index a1c249dc2e51..969ded211cc9 100644
--- a/Documentation/iio/adxl380.rst
+++ b/Documentation/iio/adxl380.rst
@@ -4,7 +4,7 @@
 ADXL380 driver
 ===============
 
-This driver supports Analog Device's ADXL380/382 on SPI/I2C bus.
+This driver supports Analog Devices' ADXL380/382 on SPI/I2C bus.
 
 1. Supported devices
 ====================
diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 0aca02962947..7f90fea3d1f0 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -105,7 +105,7 @@ config AD4080
 	  called ad4080.
 
 config AD4130
-	tristate "Analog Device AD4130 ADC Driver"
+	tristate "Analog Devices AD4130 ADC Driver"
 	depends on SPI
 	depends on GPIOLIB
 	select IIO_BUFFER
@@ -121,7 +121,7 @@ config AD4130
 	  called ad4130.
 
 config AD4134
-	tristate "Analog Device AD4134 ADC Driver"
+	tristate "Analog Devices AD4134 ADC Driver"
 	depends on SPI
 	select REGMAP_SPI
 	select CRC8
@@ -133,7 +133,7 @@ config AD4134
 	  called ad4134_spi.
 
 config AD4170_4
-	tristate "Analog Device AD4170-4 ADC Driver"
+	tristate "Analog Devices AD4170-4 ADC Driver"
 	depends on SPI
 	select REGMAP_SPI
 	select IIO_BUFFER
@@ -164,7 +164,7 @@ config AD4691
 	  called ad4691.
 
 config AD4695
-	tristate "Analog Device AD4695 ADC Driver"
+	tristate "Analog Devices AD4695 ADC Driver"
 	depends on SPI
 	select IIO_BUFFER
 	select IIO_BUFFER_DMAENGINE
@@ -179,7 +179,7 @@ config AD4695
 	  called ad4695.
 
 config AD4851
-	tristate "Analog Device AD4851 DAS Driver"
+	tristate "Analog Devices AD4851 DAS Driver"
 	depends on SPI
 	depends on PWM
 	select REGMAP_SPI
@@ -347,7 +347,7 @@ config AD7380
 	  called ad7380.
 
 config AD7405
-	tristate "Analog Device AD7405 ADC Driver"
+	tristate "Analog Devices AD7405 ADC Driver"
 	depends on IIO_BACKEND
 	help
 	  Say yes here to build support for Analog Devices AD7405, ADUM7701,
diff --git a/drivers/iio/dac/ad3552r.c b/drivers/iio/dac/ad3552r.c
index 16db94fef9d4..039af514adde 100644
--- a/drivers/iio/dac/ad3552r.c
+++ b/drivers/iio/dac/ad3552r.c
@@ -696,6 +696,6 @@ static struct spi_driver ad3552r_driver = {
 module_spi_driver(ad3552r_driver);
 
 MODULE_AUTHOR("Mihail Chindris <mihail.chindris@analog.com>");
-MODULE_DESCRIPTION("Analog Device AD3552R DAC");
+MODULE_DESCRIPTION("Analog Devices AD3552R DAC");
 MODULE_LICENSE("GPL v2");
 MODULE_IMPORT_NS("IIO_AD3552R");
-- 
2.53.0

