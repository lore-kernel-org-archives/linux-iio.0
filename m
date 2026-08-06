Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013004.outbound.protection.outlook.com [52.101.83.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC6A02C11D9;
	Thu,  6 Aug 2026 12:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786020422; cv=fail; b=JL3zUXcKjY7oMYrTHfUJvyy/kZNOGMko08+6V5Tm2DZGxlDHcFfU5WOjwmAjtuEu+JCrsalAFldx+jz8uxMr1UFysql8MjVz+KIbhRuDE8PEqw/+cXBQSK/kb3xLoAsuGp4s7FTkLhWFfEIr5Pb0ZvMxvYEtZI6r1Oy7AlTzKtA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786020422; c=relaxed/simple;
	bh=x+oPSweWt8ldCmDFFYBfv1oPMJ68lqk9YwCH6jcrXaU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=jdBrfr2PdxyHOgiA/JbJogdEyBwCjti7haPGj9DWkvYuEABcJqhO+yEsSS0sm3yAcs4buFpvZffHgleWNToZ1Ijf7wi8EkjDwjQjNqX2BGuZdy94YguKA5DxjWOAMsalu39voRNdl80TE9CFhOxhro9ibsyh4pj6VX3zPE0FosQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=oLxwqJ+y; arc=fail smtp.client-ip=52.101.83.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="oLxwqJ+y"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wOnoQam5w/0Z9DipO8GX9vfDYMgqsPVskR40Ks1aDxOmQ5ODwfck+WK3jj540d/P2Idqor6wKceXDiSrlPx8/hd4wI1FS4Qe0jouUboDvg372s9Pkvf1pyHpG4IvY39kTh4rxHMKY6xqfCAODaNLj9UmIhketcz4yz+mx/CWsuCcwClPb1b9hWaeQWNkrjtcG0iYrsHX089tsLXUQu7i2UDRPvb0qbxr2yMjbTZNHFnAlxFH82pMfDR+OcQZFvxdZL24HEDU3HWAVP1xpOU3BsK9STnqr4E2ZAfEqFrhI1A5eGjVecEwsqiQiRG/vBeSMlXMdcca43es4LFxk0OXEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nGbOTueWBY97LucIMfsTRLNFOOqv6BU/po8DzTcrR48=;
 b=ECEgPw8DVdgugCf53fsYoeHwO3sI1QnlK1PMCGUFCX+3HKab/cNhwRoM7VDp43RfGfM0kzjhCFPDcVXS7T7LaeA+PMp5o4kVEGvFrLKtDxQpC9Ifiu0L8dwImN/TncPlStgdrm+E9aYbaQs5JNg3DzobAZidnYYwE6f+zTgVA+Uvd7Si5YEu+JsfAkEM/ZHkjGJDFvypxL7rESLSuAi0EOCXqmb65b8TOQg+wes1xMYpgE+lVpPkoOT+sea/gcQ64KoYxUU54z6lsQAWJUAaYPFbqmwa2VPxby1cAqtPsHM/RQSN6/mY9JTEeQC+RPVKSXeS/3AhxRiz0xivEaSM7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=analog.com smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nGbOTueWBY97LucIMfsTRLNFOOqv6BU/po8DzTcrR48=;
 b=oLxwqJ+yqD+AIrX88O8znOqORnszW0Vp6xhU//uIa0GaEjN3Ln8yZO6TOLVsC27QKShwRCY6PSnBBqH9+DpuzAd0onj3v53Xmjfxw+TSNzDvARUEuJ1nWllCWrf70JDkso5gaKx3RriqoCMa8VZx/1eNG30qAftz/alyeYlK1jg=
Received: from AM0PR10CA0008.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:17c::18)
 by DU0PR02MB8189.eurprd02.prod.outlook.com (2603:10a6:10:311::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.19; Thu, 6 Aug
 2026 12:46:50 +0000
Received: from AM1PEPF000252DD.eurprd07.prod.outlook.com
 (2603:10a6:208:17c:cafe::25) by AM0PR10CA0008.outlook.office365.com
 (2603:10a6:208:17c::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.20 via Frontend Transport; Thu, 6
 Aug 2026 12:46:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 AM1PEPF000252DD.mail.protection.outlook.com (10.167.16.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Thu, 6 Aug 2026 12:46:49 +0000
Received: from se-mail11w.axis.com (10.20.40.11) by se-mail10w.axis.com
 (10.20.40.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.39; Thu, 6 Aug
 2026 14:46:48 +0200
Received: from se-intmail02x.se.axis.com (10.4.0.28) by se-mail11w.axis.com
 (10.20.40.11) with Microsoft SMTP Server id 15.2.1748.39 via Frontend
 Transport; Thu, 6 Aug 2026 14:46:48 +0200
Received: from pc66231-2602.sto.se.axis.com (pc66231-2602.sto.se.axis.com [10.133.4.42])
	by se-intmail02x.se.axis.com (Postfix) with ESMTP id BA37C2A0D;
	Thu,  6 Aug 2026 14:46:48 +0200 (CEST)
Received: by pc66231-2602.sto.se.axis.com (Postfix, from userid 21940)
	id AEFC83062A72; Thu,  6 Aug 2026 14:46:48 +0200 (CEST)
From: Kanak Shilledar <kanak.shilledar@axis.com>
Date: Thu, 6 Aug 2026 14:46:28 +0200
Subject: [PATCH 2/3] iio: accel: Add support for ICM42370P
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20260806-b4-inv_icm42370p-v1-2-670837f5842f@axis.com>
References: <20260806-b4-inv_icm42370p-v1-0-670837f5842f@axis.com>
In-Reply-To: <20260806-b4-inv_icm42370p-v1-0-670837f5842f@axis.com>
To: Jonathan Cameron <jic23@kernel.org>, David Lechner
	<dlechner@baylibre.com>, =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, "Andy
 Shevchenko" <andy@kernel.org>, Rob Herring <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, "Henrik
 Grimler" <henrik.grimler@axis.com>, Jean-Baptiste Maneyrol
	<jean-baptiste.maneyrol@tdk.com>
CC: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <kernel@axis.com>, Kanak Shilledar
	<kanak.shilledar@axis.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=54100;
 i=kanak.shilledar@axis.com; h=from:subject:message-id;
 bh=x+oPSweWt8ldCmDFFYBfv1oPMJ68lqk9YwCH6jcrXaU=;
 b=owGbwMvMwCW2Ztq2Vzx1cgqMp9WSGLJKmizecYfEnb3eWOSYE9yo69qwZWdcpIOZ0O991S96g
 nZFPbrWUcrCIMbFICumyBKZ01DtvtYr6V5R1GmYOaxMIEMYuDgFYCKdtxn+Cp1jlfgY7sAaJxnT
 nqdT5yU76+m3UIN6q1P/Ftu+fnugiOEP/+Eb1ipX0+RnGB/7sZ+jbLlQjeUCyehJletrmO753K7
 lAAA=
X-Developer-Key: i=kanak.shilledar@axis.com; a=openpgp;
 fpr=596C807B47AD4A62DE725ACBAC96B6EA0C7E1E20
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM1PEPF000252DD:EE_|DU0PR02MB8189:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a6c1ce1-798e-488d-8c21-08def3b8c89c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|36860700016|82310400026|1800799024|13003099007|6133799003|10067099003|56012099006|11063799006|5023799004|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	2oGndNmzg9G6Jh7zv665iPR9AlZkUJOCbRRpF9ZQgBTjRl2mmhIxSgONhf9Kkl0vPLDQA5JBwajRgWRqG+tBOZEWyWPJ3oDxgJO9+vvkcxzeqvRdiYuBtZoUxwKJdTjW/KW+FfKFtB1vh8aew+uTfNq1niFQI01SC5tPYCttHvvWIydvR5q7JlgH8ykYB0HeN3kDEmL8Wq7vI3r4zloUVzSE8zjbIC9l8qHQi01p8QHUQwItIxJM0xPN4keUtcD4luTa1hNOejX6gMj5+odl0IAFmBDGkofT84AKGe2jnvIcY8bbAycQSclmrbf5SQUll2G120sIDPpy0MsoHmf/7TBXsX0ugod3zniFEwy4FBXAKhZE64iM7QFVfaRVXYlyxBU1BFWKsaffkhEonNWw3IbloC8rmNkrWtGmbiOvXvCF+fmwKvjh/LTt83Y76eG9Hb9lR3uFXFDahVsCZjevnlq0sG/ZD6Vd/TW0it4Xk6eTdQKWLv0e9SrNxjrS5F2X9ult9Yqf9nSimdLrUHH7rcB9kLjzDzSDA2yZWprMp37wlaUA7eEUyUlK2vcmt8pbwwZUfdVcREBh9kwdBUeAHpWaiAlK8PxSz8rgGp4ERu+yu9y5TNA4WetE0xGYw1uSHV5iTiKWxrtka8Bi6UptDQ==
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(36860700016)(82310400026)(1800799024)(13003099007)(6133799003)(10067099003)(56012099006)(11063799006)(5023799004)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	WNOaI70JZC/ov26Ld9zgJeNrQX9E8KXfDWhA+usdOOl1a58AFtwrrKrLJpkKM8V/fKD7OZQknd2tv52A2tO8xFm0X26irEmS7Ui08clDslCyiIwl5EOXIu9+0r2NTP5HFTOOVVmzk4Ev5CvZkRfdLw8m/JorOnuryBUo8J4+a4MCp2l9uE/XLxCw+iOv2oIRYIg3UuPPX06Q/8Q6R4cy3o8KDWrGMRjmJxf5qL/A0XroM/UcVaP6poR+KLvo66xgz7AVEMTXt4lnR+duHOoIi0MnNcipH/hQUrPNNHj0+7X4L7V6wGFrsPrfRtpahX9Dd9lGoj+hOWr/BridwHHZknMWw6hkYe2tsOGOgd1edEbfSYnxNw5peeglJpfOXQFTkxScLtUHBHeHKphyFFLoBZszYTr4/B7nLOslI6xVihdfR5qSNWNFqa1EUxu0wjD0
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2026 12:46:49.8034
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a6c1ce1-798e-488d-8c21-08def3b8c89c
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM1PEPF000252DD.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR02MB8189

Add support for the Invensense ICM42370P MEMS MotionTracking 3-axis
accelerometer with a built-in temperature sensor. Compared to other
sensors from the same vendor ICM42370 uses a different way of handling
register banks. Although the device supports I2C, SPI, and I3C,
implement only I2C support.  Provide basic support for raw sensor
reads and a sysfs interface for setting the calibration bias. Keep the
embedded temperature sensor enabled because the device design does not
allow it to be turned off.

Signed-off-by: Kanak Shilledar <kanak.shilledar@axis.com>
---
 MAINTAINERS                           |    1 +
 drivers/iio/accel/Kconfig             |   17 +
 drivers/iio/accel/Makefile            |    5 +
 drivers/iio/accel/inv_icm42370.h      |  365 ++++++++++
 drivers/iio/accel/inv_icm42370_core.c | 1251 +++++++++++++++++++++++++++++++++
 drivers/iio/accel/inv_icm42370_i2c.c  |  103 +++
 6 files changed, 1742 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index f7039df58bb0f..adcd8a92e26a4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13568,6 +13568,7 @@ L:	linux-iio@vger.kernel.org
 S:	Maintained
 W:	https://invensense.tdk.com/
 F:	Documentation/devicetree/bindings/iio/accel/invensense,icm42370.yaml
+F:	drivers/iio/accel/inv_icm42370*
 
 INVENSENSE ICM-426xx IMU DRIVER
 M:	Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
diff --git a/drivers/iio/accel/Kconfig b/drivers/iio/accel/Kconfig
index 4094299e2ed81..cef3462e4c79a 100644
--- a/drivers/iio/accel/Kconfig
+++ b/drivers/iio/accel/Kconfig
@@ -487,6 +487,23 @@ config IIO_KX022A_I2C
 	  connected to I2C interface. Supported devices are:
 	    KX022A, KX132-1211, KX132ACR-LBZ
 
+config INV_ICM42370
+	tristate
+	select IIO_BUFFER
+	select IIO_INV_SENSORS_TIMESTAMP
+
+config INV_ICM42370_I2C
+	tristate "InvenSense ICM-42370 I2C driver"
+	depends on I2C
+	select INV_ICM42370
+	select REGMAP_I2C
+	help
+	  This driver supports the InvenSense ICM-42730 motion tracking
+	  devices over I2C.
+
+	  This driver can be built as a module. The module will be called
+	  inv_icm42370_i2c.
+
 config KXSD9
 	tristate "Kionix KXSD9 Accelerometer Driver"
 	select IIO_BUFFER
diff --git a/drivers/iio/accel/Makefile b/drivers/iio/accel/Makefile
index fa440a8592839..6750b03edf518 100644
--- a/drivers/iio/accel/Makefile
+++ b/drivers/iio/accel/Makefile
@@ -49,6 +49,11 @@ obj-$(CONFIG_HID_SENSOR_ACCEL_3D) += hid-sensor-accel-3d.o
 obj-$(CONFIG_IIO_KX022A)	+= kionix-kx022a.o
 obj-$(CONFIG_IIO_KX022A_I2C)	+= kionix-kx022a-i2c.o
 obj-$(CONFIG_IIO_KX022A_SPI)	+= kionix-kx022a-spi.o
+
+obj-$(CONFIG_INV_ICM42370) += inv-icm42370.o
+inv-icm42370-y += inv_icm42370_core.o
+obj-$(CONFIG_INV_ICM42370_I2C) += inv_icm42370_i2c.o
+
 obj-$(CONFIG_KXCJK1013) += kxcjk-1013.o
 obj-$(CONFIG_KXSD9)	+= kxsd9.o
 obj-$(CONFIG_KXSD9_SPI)	+= kxsd9-spi.o
diff --git a/drivers/iio/accel/inv_icm42370.h b/drivers/iio/accel/inv_icm42370.h
new file mode 100644
index 0000000000000..9866a5e970dcd
--- /dev/null
+++ b/drivers/iio/accel/inv_icm42370.h
@@ -0,0 +1,365 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright (C) 2020 Invensense, Inc.
+ * Copyright (C) 2026 Axis Communications AB
+ */
+
+#ifndef INV_ICM42370_H_
+#define INV_ICM42370_H_
+
+#include <linux/bits.h>
+#include <linux/bitfield.h>
+#include <linux/regmap.h>
+#include <linux/mutex.h>
+#include <linux/regulator/consumer.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/common/inv_sensors_timestamp.h>
+
+enum inv_icm42370_chip {
+	INV_CHIP_INVALID,
+	INV_CHIP_ICM42370,
+	INV_CHIP_NB,
+};
+
+/* sensor configuration struct */
+struct inv_icm42370_conf {
+	int mode;
+	int fs;
+	int odr;
+	int filter;
+};
+
+/**
+ * struct inv_icm42370_data - driver state variables
+ * @lock:		lock for serializing multiple register access.
+ * @name:		chip name.
+ * @map:		regmap pointer.
+ * @vdd_supply:		VDD voltage regulator for the chip.
+ * @vddio_supply:	I/O voltage regulator for the chip.
+ * @indio_accel:	accelerometer IIO device.
+ * @sensor_state:	per-sensor state tracking (e.g. power, ODR).
+ * @buffer:		buffer for reading data registers, aligned for DMA.
+ * @accel_calibbias:	accelerometer calibration bias for X, Y, and Z axes.
+ * @fifo:		FIFO state and configuration.
+ * @timestamp:		interrupt timestamp.
+ * @chip:		chip identifier.
+ * @conf:		chip sensors configurations.
+ */
+struct inv_icm42370_data {
+	struct mutex lock;
+	const char *name;
+	struct regmap *map;
+	struct regulator *vdd_supply;
+	struct regulator *vddio_supply;
+	struct iio_dev *indio_accel;
+	struct inv_icm42370_sensor_state *sensor_state;
+	u8 buffer[2] __aligned(IIO_DMA_MINALIGN);
+	s16 accel_calibbias[3];
+	struct inv_icm42370_fifo fifo;
+	s64 timestamp;
+	enum inv_icm42370_chip chip;
+	struct inv_icm42370_conf conf;
+};
+
+#define INV_ICM42370_TEMP_CHAN(_index) \
+	{								\
+		.type = IIO_TEMP,					\
+		.info_mask_separate =					\
+			BIT(IIO_CHAN_INFO_RAW) |			\
+			BIT(IIO_CHAN_INFO_OFFSET) |			\
+			BIT(IIO_CHAN_INFO_SCALE),			\
+		.scan_index = _index,					\
+		.scan_type = {						\
+			.sign = 's',					\
+			.realbits = 16,					\
+			.storagebits = 16,				\
+		},							\
+	}
+
+#define INV_ICM42370_ACCEL_CHAN(_modifier, _index) \
+	{								\
+		.type = IIO_ACCEL,					\
+		.modified = 1,						\
+		.channel2 = _modifier,					\
+		.info_mask_separate =					\
+			BIT(IIO_CHAN_INFO_RAW) |			\
+			BIT(IIO_CHAN_INFO_CALIBBIAS),			\
+		.info_mask_shared_by_type =				\
+			BIT(IIO_CHAN_INFO_SCALE),			\
+		.info_mask_shared_by_type_available =			\
+			BIT(IIO_CHAN_INFO_SCALE) |			\
+			BIT(IIO_CHAN_INFO_CALIBBIAS),			\
+		.info_mask_shared_by_all =				\
+			BIT(IIO_CHAN_INFO_SAMP_FREQ),			\
+		.info_mask_shared_by_all_available =			\
+			BIT(IIO_CHAN_INFO_SAMP_FREQ),			\
+		.scan_index = _index,					\
+		.scan_type = {						\
+			.sign = 's',					\
+			.realbits = 16,					\
+			.storagebits = 16,				\
+			.endianness = IIO_BE,				\
+		},							\
+	}
+
+enum inv_icm42370_accel_scan {
+	INV_ICM42370_ACCEL_SCAN_X,
+	INV_ICM42370_ACCEL_SCAN_Y,
+	INV_ICM42370_ACCEL_SCAN_Z,
+	INV_ICM42370_ACCEL_SCAN_TEMP,
+};
+
+enum inv_icm42370_sensor_mode {
+	INV_ICM42370_SENSOR_MODE_OFF,
+	INV_ICM42370_SENSOR_MODE_STANDBY,
+	INV_ICM42370_SENSOR_MODE_LOW_POWER,
+	INV_ICM42370_SENSOR_MODE_LOW_NOISE,
+	INV_ICM42370_SENSOR_MODE_NB,
+};
+
+enum inv_icm42370_filter {
+	/* Low-Noise mode sensor data filter bandwidth*/
+	INV_ICM42370_UI_FILT_BW_LP_FILTER_BYPASSED,
+	/* Low-Power mode sensor data filter (averaging) */
+	INV_ICM42370_FILTER_AVG_2X,
+	INV_ICM42370_FILTER_AVG_4X,
+	INV_ICM42370_FILTER_AVG_8X,
+	INV_ICM42370_FILTER_AVG_16X,
+	INV_ICM42370_FILTER_AVG_32X,
+	INV_ICM42370_FILTER_AVG_64X,
+	INV_ICM42370_FILTER_AVG_NB,
+};
+
+/**
+ * struct inv_icm42370_sensor_state - sensor state variables
+ * @scales:		table of scales.
+ * @scales_len:		length (nb of items) of the scales table.
+ * @power_mode:		sensor requested power mode (for common frequencies)
+ * @filter:		sensor filter.
+ * @ts:			timestamp module states.
+ */
+struct inv_icm42370_sensor_state {
+	const int *scales;
+	size_t scales_len;
+	enum inv_icm42370_sensor_mode power_mode;
+	enum inv_icm42370_filter filter;
+	struct inv_sensors_timestamp ts;
+};
+
+/* serial bus slew rates */
+enum inv_icm42370_slew_rate {
+	INV_ICM42370_SLEW_RATE_20_60NS,
+	INV_ICM42370_SLEW_RATE_12_36NS,
+	INV_ICM42370_SLEW_RATE_6_19NS,
+	INV_ICM42370_SLEW_RATE_4_14NS,
+	INV_ICM42370_SLEW_RATE_2_8NS,
+	INV_ICM42370_SLEW_RATE_INF_2NS,
+};
+
+/* accelerometer fullscale values */
+enum inv_icm42370_accel_fs {
+	INV_ICM42370_ACCEL_FS_16G,
+	INV_ICM42370_ACCEL_FS_8G,
+	INV_ICM42370_ACCEL_FS_4G,
+	INV_ICM42370_ACCEL_FS_2G,
+	INV_ICM42370_ACCEL_FS_NB,
+};
+
+/* ODR suffixed by LN or LP are Low-Noise or Low-Power mode only */
+enum inv_icm42370_odr {
+	INV_ICM42370_ODR_1_6KHZ_LN = 5,
+	INV_ICM42370_ODR_800HZ_LN,
+	INV_ICM42370_ODR_400HZ,
+	INV_ICM42370_ODR_200HZ,
+	INV_ICM42370_ODR_100HZ,
+	INV_ICM42370_ODR_50HZ,
+	INV_ICM42370_ODR_25HZ,
+	INV_ICM42370_ODR_12_5HZ,
+	INV_ICM42370_ODR_6_25HZ_LP,
+	INV_ICM42370_ODR_3_125HZ_LP,
+	INV_ICM42370_ODR_1_5625HZ_LP,
+	INV_ICM42370_ODR_NB,
+};
+
+enum inv_icm42370_mregs {
+	INV_ICM42370_MREG1,
+	INV_ICM42370_MREG2 = 0x28,
+	INV_ICM42370_MREG3 = 0x50,
+};
+
+/* Temperature sensor filters */
+enum inv_icm42370_temp_filter {
+	INV_ICM42370_TEMP_FILT_BW_DLPF_BYPASS,
+	INV_ICM42370_TEMP_FILT_BW_DLPF_180HZ,
+	INV_ICM42370_TEMP_FILT_BW_DLPF_72HZ,
+	INV_ICM42370_TEMP_FILT_BW_DLPF_34HZ,
+	INV_ICM42370_TEMP_FILT_BW_DLPF_16HZ,
+	INV_ICM42370_TEMP_FILT_BW_DLPF_8HZ,
+	INV_ICM42370_TEMP_FILT_BW_DLPF_4HZ,
+	INV_ICM42370_TEMP_FILT_BW_DLPF_NB,
+};
+
+/* IIO format int + micro */
+static const int inv_icm42370_accel_odr[] = {
+	/* 1.5625Hz */
+	1, 562500,
+	/* 3.125Hz */
+	3, 125000,
+	/* 6.25Hz */
+	6, 250000,
+	/* 12.5Hz */
+	12, 500000,
+	/* 25Hz */
+	25, 0,
+	/* 50Hz */
+	50, 0,
+	/* 100Hz */
+	100, 0,
+	/* 200Hz */
+	200, 0,
+	/* 400Hz */
+	400, 0,
+	/* 800Hz */
+	800, 0,
+	/* 1.6kHz */
+	1600, 0,
+};
+
+#define INV_ICM42370_SENSOR_CONF_INIT { -1, -1, -1, -1 }
+
+/* Registers in USER BANK 1 */
+#define INV_ICM42370_REG_MCLK_RDY 0x0
+#define INV_ICM42370_REG_DEVICE_CONFIG 0x01
+#define INV_ICM42370_REG_SIGNAL_PATH_RESET 0x02
+#define INV_ICM42370_REG_DRIVE_CONFIG1 0x03
+#define INV_ICM42370_REG_DRIVE_CONFIG2 0x04
+#define INV_ICM42370_REG_DRIVE_CONFIG3 0x05
+#define INV_ICM42370_REG_INT_CONFIG 0x06
+#define INV_ICM42370_REG_TEMP_DATA1 0x09
+#define INV_ICM42370_REG_TEMP_DATA0 0x0A
+#define INV_ICM42370_REG_ACCEL_DATA_X1 0x0B
+#define INV_ICM42370_REG_ACCEL_DATA_X0 0x0C
+#define INV_ICM42370_REG_ACCEL_DATA_Y1 0x0D
+#define INV_ICM42370_REG_ACCEL_DATA_Y0 0x0E
+#define INV_ICM42370_REG_ACCEL_DATA_Z1 0x0F
+#define INV_ICM42370_REG_ACCEL_DATA_Z0 0x10
+#define INV_ICM42370_REG_ACCEL_CONFIG0 0x21
+#define INV_ICM42370_REG_PWR_MGMT0 0x1F
+#define INV_ICM42370_REG_INTF_CONFIG6 0x23
+#define INV_ICM42370_REG_FIFO_CONFIG1 0x28
+#define INV_ICM42370_REG_FIFO_WATERMARK 0x29
+#define INV_ICM42370_REG_INT_SOURCE0 0x2B
+#define INV_ICM42370_REG_INT_STATUS 0x3A
+#define INV_ICM42370_REG_TEMP_CONFIG0 0x34
+#define INV_ICM42370_REG_INTF_CONFIG0 0x35
+#define INV_ICM42370_REG_WHO_AM_I 0x75
+#define INV_ICM42370_REG_BLK_SEL_W 0x79
+#define INV_ICM42370_REG_MADDR_W 0x7A
+#define INV_ICM42370_REG_M_W 0x7B
+#define INV_ICM42370_REG_BLK_SEL_R 0x7C
+#define INV_ICM42370_REG_MADDR_R 0x7D
+#define INV_ICM42370_REG_M_R 0x7E
+
+#define INV_ICM42370_DRIVE_CONFIG1_I3C_DDR_MASK GENMASK(5, 3)
+#define INV_ICM42370_DRIVE_CONFIG1_I3C_DDR(_rate) \
+	FIELD_PREP(INV_ICM42370_DRIVE_CONFIG1_I3C_DDR_MASK, (_rate))
+
+#define INV_ICM42370_DRIVE_CONFIG1_I3C_SDR_MASK GENMASK(2, 0)
+#define INV_ICM42370_DRIVE_CONFIG1_I3C_SDR(_rate) \
+	FIELD_PREP(INV_ICM42370_DRIVE_CONFIG1_I3C_SDR_MASK, (_rate))
+#define INV_ICM42370_DRIVE_CONFIG2_I2C_MASK GENMASK(5, 3)
+#define INV_ICM42370_DRIVE_CONFIG2_I2C(_rate) \
+	FIELD_PREP(INV_ICM42370_DRIVE_CONFIG2_I2C_MASK, (_rate))
+#define INV_ICM42370_DRIVE_CONFIG3_SPI_MASK GENMASK(2, 0)
+#define INV_ICM42370_DRIVE_CONFIG3_SPI(_rate) \
+	FIELD_PREP(INV_ICM42370_DRIVE_CONFIG3_SPI_MASK, (_rate))
+
+#define INV_ICM42370_SIGNAL_PATH_RESET_FIFO_FLUSH BIT(2)
+#define INV_ICM42370_FIFO_CONFIG_MODE_MASK BIT(0)
+#define INV_ICM42370_FIFO_CONFIG_BYPASS_MASK BIT(1)
+#define INV_ICM42370_FIFO_CONFIG_STREAM \
+	FIELD_PREP(INV_ICM42370_FIFO_CONFIG_MODE_MASK, 0)
+#define INV_ICM42370_FIFO_CONFIG_STOP_ON_FULL \
+	FIELD_PREP(INV_ICM42370_FIFO_CONFIG_MODE_MASK, 1)
+#define INV_ICM42370_FIFO_CONFIG_BYPASS \
+	FIELD_PREP(INV_ICM42370_FIFO_CONFIG_BYPASS_MASK, 1)
+
+#define INV_ICM42370_INT_CONFIG_INT2_LATCHED BIT(5)
+#define INV_ICM42370_INT_CONFIG_INT2_PUSH_PULL BIT(4)
+#define INV_ICM42370_INT_CONFIG_INT2_ACTIVE_HIGH BIT(3)
+#define INV_ICM42370_INT_CONFIG_INT2_ACTIVE_LOW 0x00
+#define INV_ICM42370_INT_CONFIG_INT1_LATCHED BIT(2)
+#define INV_ICM42370_INT_CONFIG_INT1_PUSH_PULL BIT(1)
+#define INV_ICM42370_INT_CONFIG_INT1_ACTIVE_HIGH BIT(0)
+#define INV_ICM42370_INT_CONFIG_INT1_ACTIVE_LOW 0x00
+
+#define INV_ICM42370_INT_STATUS_FIFO_THS BIT(2)
+#define INV_ICM42370_INT_STATUS_FIFO_FULL BIT(1)
+
+#define INV_ICM42370_INT_SOURCE0_FIFO_THS_INT1_EN BIT(2)
+
+/* Registers in MREG1 USER BANK 1*/
+#define INV_ICM42370_REG_TMST_CONFIG1 0x00
+#define INV_ICM42370_REG_FIFO_CONFIG5 0x01
+#define INV_ICM42370_REG_FIFO_CONFIG6 0x02
+#define INV_ICM42370_REG_INT_CONFIG1 0x05
+#define INV_ICM42370_REG_OFFSET_USER4 0x52
+#define INV_ICM42370_REG_OFFSET_USER5 0x53
+#define INV_ICM42370_REG_OFFSET_USER6 0x54
+#define INV_ICM42370_REG_OFFSET_USER7 0x55
+#define INV_ICM42370_REG_OFFSET_USER8 0x56
+
+#define INV_ICM42370_TMST_CONFIG_TMST_DELTA_EN BIT(2)
+#define INV_ICM42370_TMST_CONFIG_TMST_EN BIT(0)
+
+#define INV_ICM42370_FIFO_CONFIG5_WM_GT_TH BIT(5)
+#define INV_ICM42370_FIFO_CONFIG5_RESUME_PARTIAL_RD BIT(4)
+#define INV_ICM42370_FIFO_CONFIG5_ACCEL_EN BIT(0)
+
+#define INV_ICM42370_INT_CONFIG1_ASYNC_RESET BIT(4)
+
+#define INV_ICM42370_WHOAMI_VALUE 0x0D
+
+#define INV_ICM42370_FIFO_FLUSH_BIT_MASK BIT(2)
+
+#define INV_ICM42370_INTF_CONFIG0_FIFO_COUNT_ENDIAN BIT(5)
+#define INV_ICM42370_INTF_CONFIG0_SENSOR_DATA_ENDIAN BIT(4)
+
+#define INV_ICM42370_FIFO_WATERMARK_VAL(_wm) cpu_to_le16((_wm) & GENMASK(11, 0))
+/* FIFO is 2048 bytes, let 12 samples for reading latency */
+#define INV_ICM42370_FIFO_WATERMARK_MAX (2048 - 12 * 16)
+
+#define INV_ICM42370_PWR_MGMT0(_mode) FIELD_PREP(GENMASK(1, 0), (_mode))
+
+#define INV_ICM42370_ACCEL_CONFIG0_FS(_fs) FIELD_PREP(GENMASK(6, 5), (_fs))
+#define INV_ICM42370_ACCEL_CONFIG0_ODR(_odr) FIELD_PREP(GENMASK(3, 0), (_odr))
+
+#define INV_ICM42370_TEMP_FILT_BW_DLPF(_dlpf) FIELD_PREP(GENMASK(6, 4), (_dlpf))
+
+#define INV_ICM42370_MCLK_RDY_BIT BIT(3)
+#define INV_ICM42370_SOFT_RESET_BIT BIT(4)
+#define INV_ICM42370_ACCEL_MODE_LN 0x03
+
+#define INV_ICM42370_DATA_INVALID -32768
+#define INV_ICM42370_ACCEL_STARTUP_TIME_MS 10
+
+typedef int (*inv_icm42370_bus_setup)(struct inv_icm42370_data *);
+extern const struct regmap_config inv_icm42370_regmap_config;
+
+int inv_icm42370_core_probe(struct regmap *regmap, int chip, int irq,
+			    inv_icm42370_bus_setup bus_setup);
+u32 inv_icm42370_odr_to_period(enum inv_icm42370_odr odr);
+
+int inv_icm42370_core_probe(struct regmap *regmap, int chip, int irq,
+			    inv_icm42370_bus_setup bus_setup);
+
+struct iio_dev *inv_icm42370_accel_init(struct iio_dev *indio_dev,
+					struct inv_icm42370_data *data);
+
+int inv_icm42370_set_accel_conf(struct inv_icm42370_data *dev_data,
+				struct inv_icm42370_conf *conf,
+				unsigned int *sleep_ms);
+
+int inv_icm42370_accel_parse_fifo(struct iio_dev *indio_dev);
+
+#endif
diff --git a/drivers/iio/accel/inv_icm42370_core.c b/drivers/iio/accel/inv_icm42370_core.c
new file mode 100644
index 0000000000000..9f6c302e6f331
--- /dev/null
+++ b/drivers/iio/accel/inv_icm42370_core.c
@@ -0,0 +1,1251 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2020 Invensense, Inc.
+ * Copyright (C) 2026 Axis Communications AB
+ */
+
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/i2c.h>
+#include <linux/irq.h>
+#include <linux/slab.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/pm_runtime.h>
+#include <linux/property.h>
+#include <linux/regmap.h>
+
+#include <linux/iio/common/inv_sensors_timestamp.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
+
+#include "inv_icm42370.h"
+
+const struct regmap_config inv_icm42370_regmap_config = {
+	.name = "inv_icm42370",
+	.reg_bits = 8,
+	.val_bits = 8,
+	.max_register = 0x7E,
+};
+EXPORT_SYMBOL_NS_GPL(inv_icm42370_regmap_config, "IIO_ICM42370");
+
+static const struct inv_icm42370_conf inv_icm42370_default_conf = {
+	.mode = INV_ICM42370_SENSOR_MODE_LOW_NOISE,
+	.fs = INV_ICM42370_ACCEL_FS_16G,
+	.odr = INV_ICM42370_ODR_400HZ,
+	.filter = INV_ICM42370_FILTER_AVG_16X,
+};
+
+static const struct iio_chan_spec inv_icm42370_accel_channels[] = {
+	INV_ICM42370_ACCEL_CHAN(IIO_MOD_X, INV_ICM42370_ACCEL_SCAN_X),
+	INV_ICM42370_ACCEL_CHAN(IIO_MOD_Y, INV_ICM42370_ACCEL_SCAN_Y),
+	INV_ICM42370_ACCEL_CHAN(IIO_MOD_Z, INV_ICM42370_ACCEL_SCAN_Z),
+	INV_ICM42370_TEMP_CHAN(INV_ICM42370_ACCEL_SCAN_TEMP),
+};
+
+/* IIO format int + nano */
+static const int inv_icm42370_accel_scale[] = {
+	/* +/- 16G => 2*16*9.80665 / (2**15) m/s-2 */
+	[2 * INV_ICM42370_ACCEL_FS_16G] = 0,
+	[2 * INV_ICM42370_ACCEL_FS_16G + 1] = 9576807,
+	/* +/- 8G => 2*8*9.80665 / (2**15) m/s-2 */
+	[2 * INV_ICM42370_ACCEL_FS_8G] = 0,
+	[2 * INV_ICM42370_ACCEL_FS_8G + 1] = 4788403,
+	/* +/- 4G => 2*4*9.80665 / (2**15) m/s-2 */
+	[2 * INV_ICM42370_ACCEL_FS_4G] = 0,
+	[2 * INV_ICM42370_ACCEL_FS_4G + 1] = 2394202,
+	/* +/- 2G => 2*2*9.80665 / (2**15) m/s-2 */
+	[2 * INV_ICM42370_ACCEL_FS_2G] = 0,
+	[2 * INV_ICM42370_ACCEL_FS_2G + 1] = 1197101,
+};
+
+/**
+ *  inv_icm42370_odr_to_period() - map ODR to Period
+ *  @odr - enum of ODR value
+ *
+ * Returns the period in nanoseconds
+ */
+u32 inv_icm42370_odr_to_period(enum inv_icm42370_odr odr)
+{
+	static u32 odr_periods[INV_ICM42370_ODR_NB] = {
+		/* reserved values */
+		0,
+		0,
+		0,
+		0,
+		0,
+		/* 1.6kHz */
+		625000,
+		/* 800Hz */
+		1250000,
+		/* 400Hz */
+		2500000,
+		/* 200Hz */
+		5000000,
+		/* 100Hz */
+		10000000,
+		/* 50Hz */
+		20000000,
+		/* 25Hz */
+		40000000,
+		/* 12.5Hz */
+		80000000,
+		/* 6.25Hz */
+		160000000,
+		/* 3.125Hz */
+		320000000,
+		/* 1.5625Hz */
+		640000000,
+	};
+
+	return odr_periods[odr];
+}
+
+/* ODR suffixed by LN or LP are Low-Noise or Low-Power mode only */
+static const int inv_icm42370_accel_odr_conv[] = {
+	INV_ICM42370_ODR_1_6KHZ_LN,   INV_ICM42370_ODR_800HZ_LN,
+	INV_ICM42370_ODR_400HZ,	      INV_ICM42370_ODR_200HZ,
+	INV_ICM42370_ODR_100HZ,	      INV_ICM42370_ODR_50HZ,
+	INV_ICM42370_ODR_25HZ,	      INV_ICM42370_ODR_12_5HZ,
+	INV_ICM42370_ODR_6_25HZ_LP,   INV_ICM42370_ODR_3_125HZ_LP,
+	INV_ICM42370_ODR_1_5625HZ_LP, INV_ICM42370_ODR_NB,
+};
+
+/**
+ * inv_icm42370_mreg_check() - check registers before accessing the registers in other banks
+ *
+ * @map: regmap of the device
+ *
+ * Returns 0 on success, negative errno on error
+ */
+static int inv_icm42370_mreg_check(struct regmap *map)
+{
+	int tmp;
+
+	regmap_read(map, INV_ICM42370_REG_MCLK_RDY, &tmp);
+	if (!(tmp & INV_ICM42370_MCLK_RDY_BIT))
+		return -EINVAL;
+	regmap_read(map, INV_ICM42370_REG_PWR_MGMT0, &tmp);
+	if (tmp != INV_ICM42370_PWR_MGMT0(INV_ICM42370_SENSOR_MODE_LOW_NOISE))
+		return -EINVAL;
+
+	return 0;
+}
+
+/**
+ * inv_icm42370_mreg_write() - routine for writing to other bank registers
+ *
+ * @map: regmap of the device
+ * @bank: register bank being accessed
+ * @addr: address of the register being accessed
+ * @val: value written to the register
+ *
+ * Returns 0 on success, negative errno on error
+ */
+static int inv_icm42370_mreg_write(struct regmap *map, u8 bank, u8 addr, u8 val)
+{
+	int ret;
+
+	ret = inv_icm42370_mreg_check(map);
+	if (ret)
+		return ret;
+
+	ret = regmap_write(map, INV_ICM42370_REG_BLK_SEL_W, bank);
+	if (ret)
+		return -EINVAL;
+
+	ret = regmap_write(map, INV_ICM42370_REG_MADDR_W, addr);
+	if (ret)
+		return -EINVAL;
+
+	ret = regmap_write(map, INV_ICM42370_REG_M_W, val);
+	if (ret)
+		return -EINVAL;
+
+	usleep_range(10, 20);
+	return regmap_write(map, INV_ICM42370_REG_BLK_SEL_W, 0x00);
+}
+
+/**
+ * inv_icm42370_mreg_read() - routine for reading from other bank registers
+ *
+ * @map: regmap of the device
+ * @bank: register bank being accessed
+ * @addr: address of the register being accessed
+ * @val: pointer to store the register's data
+ *
+ * Returns 0 on success, negative errno on error
+ */
+static int inv_icm42370_mreg_read(struct regmap *map, u8 bank, u8 addr, u8 *val)
+{
+	int ret;
+	unsigned int read_val;
+
+	ret = inv_icm42370_mreg_check(map);
+	if (ret)
+		return ret;
+
+	ret = regmap_write(map, INV_ICM42370_REG_BLK_SEL_R, bank);
+	if (ret)
+		return -EINVAL;
+
+	ret = regmap_write(map, INV_ICM42370_REG_MADDR_R, addr);
+	if (ret)
+		return -EINVAL;
+
+	usleep_range(10, 20);
+	ret = regmap_read(map, INV_ICM42370_REG_M_R, &read_val);
+	if (ret)
+		return -EINVAL;
+
+	usleep_range(10, 20);
+	*val = (u8)read_val;
+
+	return regmap_write(map, INV_ICM42370_REG_BLK_SEL_R, 0x00);
+}
+
+/**
+ * inv_icm42370_set_conf() - set sensor configuration
+ *
+ * @data: pointer to struct containing the sensor data
+ * @conf: pointer to configuration data
+ *
+ * Returns 0 on success, negative errno on error
+ */
+static int inv_icm42370_set_conf(struct inv_icm42370_data *data,
+				 const struct inv_icm42370_conf *conf)
+{
+	unsigned int val;
+	int ret;
+
+	/* set PWR_MGMT0 register (accel sensor mode, temp enabled) */
+	val = INV_ICM42370_PWR_MGMT0(conf->mode);
+	ret = regmap_write(data->map, INV_ICM42370_REG_PWR_MGMT0, val);
+	if (ret)
+		return ret;
+
+	msleep(200);
+	/* set ACCEL_CONFIG0 register (accel fullscale & odr) */
+	val = INV_ICM42370_ACCEL_CONFIG0_FS(conf->fs) |
+	      INV_ICM42370_ACCEL_CONFIG0_ODR(conf->odr);
+	ret = regmap_write(data->map, INV_ICM42370_REG_ACCEL_CONFIG0, val);
+	if (ret)
+		return ret;
+
+	msleep(200);
+
+	/* update internal conf */
+	data->conf = *conf;
+
+	return 0;
+}
+
+/**
+ * inv_icm42370_set_pwr_mgmt0() - set the PWR_MGMT0 register for sensor
+ *
+ * @dev_data: pointer to struct containing the sensor data
+ * @accel: enum of sensor power mode
+ * @sleep_ms: pointer to check how long the sensor is in sleep mode
+ *
+ * Returns 0 on success, negative errno on error
+ */
+static int inv_icm42370_set_pwr_mgmt0(struct inv_icm42370_data *dev_data,
+				      enum inv_icm42370_sensor_mode accel,
+				      unsigned int *sleep_ms)
+{
+	enum inv_icm42370_sensor_mode oldaccel = dev_data->conf.mode;
+	unsigned int sleepval;
+	unsigned int val;
+	int ret;
+
+	/* if nothing changed, exit */
+	if (accel == oldaccel)
+		return 0;
+
+	val = INV_ICM42370_PWR_MGMT0(accel);
+	ret = regmap_write(dev_data->map, INV_ICM42370_REG_PWR_MGMT0, val);
+	if (ret)
+		return ret;
+
+	dev_data->conf.mode = accel;
+	dev_data->sensor_state->power_mode = accel;
+
+	/* compute required wait time for sensors to stabilize */
+	sleepval = 0;
+	/* accel startup time */
+	if (accel != oldaccel && oldaccel == INV_ICM42370_SENSOR_MODE_OFF) {
+		/* block any register write for at least 200 µs */
+		usleep_range(200, 300);
+		if (sleepval < INV_ICM42370_ACCEL_STARTUP_TIME_MS)
+			sleepval = INV_ICM42370_ACCEL_STARTUP_TIME_MS;
+	}
+
+	/* deferred sleep value if sleep pointer is provided or direct sleep */
+	if (sleep_ms)
+		*sleep_ms = sleepval;
+	else if (sleepval)
+		msleep(sleepval);
+
+	return 0;
+}
+
+static void inv_icm42370_disable_pm(void *_data)
+{
+	struct device *dev = _data;
+
+	pm_runtime_put_sync(dev);
+	pm_runtime_disable(dev);
+}
+
+/**
+ * inv_icm42370_set_accel_conf() - set configuration data for accelerometer
+ *
+ * @dev_data: pointer to struct containing the sensor data
+ * @conf: pointer to configuration data
+ * @sleep_ms: pointer to check how long the sensor is in sleep mode
+ *
+ * Returns 0 on success, negative errno on error
+ */
+int inv_icm42370_set_accel_conf(struct inv_icm42370_data *dev_data,
+				struct inv_icm42370_conf *conf,
+				unsigned int *sleep_ms)
+{
+	struct inv_icm42370_conf *oldconf = &dev_data->conf;
+	unsigned int val;
+	int ret;
+
+	/* sanitize missing values with current values */
+	if (conf->mode < 0)
+		conf->mode = oldconf->mode;
+	if (conf->fs < 0)
+		conf->fs = oldconf->fs;
+	if (conf->odr < 0)
+		conf->odr = oldconf->odr;
+	if (conf->filter < 0)
+		conf->filter = oldconf->filter;
+
+	/* force power mode against ODR when sensor is on */
+	switch (conf->mode) {
+	case INV_ICM42370_SENSOR_MODE_LOW_POWER:
+	case INV_ICM42370_SENSOR_MODE_LOW_NOISE:
+		if (conf->odr <= INV_ICM42370_ODR_800HZ_LN) {
+			conf->mode = INV_ICM42370_SENSOR_MODE_LOW_NOISE;
+			conf->filter =
+				INV_ICM42370_UI_FILT_BW_LP_FILTER_BYPASSED;
+		} else if (conf->odr == INV_ICM42370_ODR_400HZ) {
+			if (conf->filter == INV_ICM42370_FILTER_AVG_16X ||
+			    conf->filter == INV_ICM42370_FILTER_AVG_32X ||
+			    conf->filter == INV_ICM42370_FILTER_AVG_64X) {
+				conf->mode = INV_ICM42370_SENSOR_MODE_LOW_NOISE;
+			} else {
+				conf->mode = INV_ICM42370_SENSOR_MODE_LOW_POWER;
+			}
+		} else if (conf->odr == INV_ICM42370_ODR_200HZ &&
+			   conf->filter == INV_ICM42370_FILTER_AVG_64X) {
+			conf->mode = INV_ICM42370_SENSOR_MODE_LOW_NOISE;
+			conf->filter =
+				INV_ICM42370_UI_FILT_BW_LP_FILTER_BYPASSED;
+		} else if (conf->odr >= INV_ICM42370_ODR_6_25HZ_LP) {
+			conf->mode = INV_ICM42370_SENSOR_MODE_LOW_POWER;
+			conf->filter = INV_ICM42370_FILTER_AVG_16X;
+		}
+		break;
+	default:
+		break;
+	}
+
+	/* set ACCEL_CONFIG0 register (accel fullscale & odr) */
+	if (conf->fs != oldconf->fs || conf->odr != oldconf->odr) {
+		val = INV_ICM42370_ACCEL_CONFIG0_FS(conf->fs) |
+		      INV_ICM42370_ACCEL_CONFIG0_ODR(conf->odr);
+		ret = regmap_write(dev_data->map,
+				   INV_ICM42370_REG_ACCEL_CONFIG0, val);
+		if (ret)
+			return ret;
+		oldconf->fs = conf->fs;
+		oldconf->odr = conf->odr;
+	}
+
+	/* set PWR_MGMT0 register (accel sensor mode) */
+	return inv_icm42370_set_pwr_mgmt0(dev_data, dev_data->conf.mode,
+					  sleep_ms);
+}
+
+/**
+ * inv_icm42370_setup() - check and setup chip
+ *
+ * @data: pointer to struct containing the sensor data
+ *
+ * Returns 0 on success, a negative error code otherwise.
+ */
+static int inv_icm42370_setup(struct inv_icm42370_data *data,
+			      inv_icm42370_bus_setup bus_setup)
+{
+	const struct device *dev = regmap_get_device(data->map);
+	unsigned int whoami;
+	int ret;
+
+	/* check chip self-identification value */
+	ret = regmap_read(data->map, INV_ICM42370_REG_WHO_AM_I, &whoami);
+	if (ret)
+		return ret;
+
+	if (whoami != INV_ICM42370_WHOAMI_VALUE) {
+		dev_err(dev, "Wrong WHO_AM_I: %d (want 0x%02X)\n",
+				     whoami, INV_ICM42370_WHOAMI_VALUE);
+		return -ENODEV;
+	}
+
+	data->name = "inv_icm42370";
+
+	/* set chip bus configuration */
+	ret = bus_setup(data);
+	if (ret)
+		return ret;
+
+	/* sensor data in big-endian (default) */
+	ret = regmap_set_bits(data->map, INV_ICM42370_REG_INTF_CONFIG0,
+			      INV_ICM42370_INTF_CONFIG0_SENSOR_DATA_ENDIAN);
+	if (ret)
+		return ret;
+
+	return inv_icm42370_set_conf(data, &inv_icm42370_default_conf);
+}
+
+static irqreturn_t inv_icm42370_irq_timestamp(int irq, void *_data)
+{
+	struct inv_icm42370_data *dev_data = _data;
+
+	dev_data->timestamp = iio_get_time_ns(dev_data->indio_accel);
+
+	return IRQ_WAKE_THREAD;
+}
+
+static irqreturn_t inv_icm42370_irq_handler(int irq, void *_data)
+{
+	struct inv_icm42370_data *dev_data = _data;
+	unsigned int status;
+	int ret;
+
+	mutex_lock(&dev_data->lock);
+
+	ret = regmap_read(dev_data->map, INV_ICM42370_REG_INT_STATUS, &status);
+	if (ret)
+		goto out_unlock;
+
+out_unlock:
+	mutex_unlock(&dev_data->lock);
+	return IRQ_HANDLED;
+}
+
+/**
+ * inv_icm42370_irq_init() - initialize int pin and interrupt handler
+ * @data:		driver internal state
+ * @irq:	irq number
+ * @irq_type:	irq trigger type
+ * @open_drain:	true if irq is open drain, false for push-pull
+ *
+ * Returns 0 on success, a negative error code otherwise.
+ */
+static int inv_icm42370_irq_init(struct inv_icm42370_data *data, int irq,
+				 int irq_type, bool open_drain)
+{
+	struct device *dev = regmap_get_device(data->map);
+	u8 val;
+	int ret;
+
+	/* configure INT1 interrupt: default is active low on edge */
+	switch (irq_type) {
+	case IRQF_TRIGGER_RISING:
+	case IRQF_TRIGGER_HIGH:
+		val = INV_ICM42370_INT_CONFIG_INT1_ACTIVE_HIGH;
+		break;
+	default:
+		val = INV_ICM42370_INT_CONFIG_INT1_ACTIVE_LOW;
+		break;
+	}
+
+	switch (irq_type) {
+	case IRQF_TRIGGER_LOW:
+	case IRQF_TRIGGER_HIGH:
+		val |= INV_ICM42370_INT_CONFIG_INT1_LATCHED;
+		break;
+	default:
+		break;
+	}
+
+	if (!open_drain)
+		val |= INV_ICM42370_INT_CONFIG_INT1_PUSH_PULL;
+
+	ret = regmap_write(data->map, INV_ICM42370_REG_INT_CONFIG, val);
+	if (ret)
+		return ret;
+
+	/* Deassert async reset for proper INT pin operation (cf datasheet) */
+	ret = inv_icm42370_mreg_read(data->map, INV_ICM42370_MREG1,
+				     INV_ICM42370_REG_INT_CONFIG1, &val);
+	if (ret)
+		return ret;
+	val &= ~INV_ICM42370_INT_CONFIG1_ASYNC_RESET;
+
+	ret = inv_icm42370_mreg_write(data->map, INV_ICM42370_MREG1,
+				      INV_ICM42370_REG_INT_CONFIG1, val);
+	if (ret)
+		return ret;
+
+	irq_type |= IRQF_ONESHOT;
+	return devm_request_threaded_irq(dev, irq, inv_icm42370_irq_timestamp,
+					 inv_icm42370_irq_handler, irq_type,
+					 "inv_icm42370", data);
+}
+
+/*
+ * Calibration bias values, IIO range format int + micro.
+ * Value is limited to +/-1g coded on 12 bits signed. Step is 0.5mg.
+ */
+static int inv_icm42370_accel_calibbias[] = {
+	-10, 42010, /* min: -2^12 * 0.0005 * 9.80665 = -10.042010 m/s² */
+	0,   4903, /* step: 0.5 * 0.00980655 = 0.004903 m/s² */
+	10,  37106, /* max: (2^12 - 1) * 0.0005 * 9.80665 = 10.037106 m/s² */
+};
+
+/**
+ * inv_icm42370_temp_read() - internal function to access temperature sensor registers
+ *
+ * @dev_data: pointer to struct containing the sensor data
+ * @temp: pointer containing the temperature data in s16 format
+ *
+ * Return 0 on success, negative errno on error
+ */
+static int inv_icm42370_temp_read(struct inv_icm42370_data *dev_data, s16 *temp)
+{
+	struct device *dev = regmap_get_device(dev_data->map);
+	__be16 *raw;
+	int ret;
+
+	pm_runtime_get_sync(dev);
+	mutex_lock(&dev_data->lock);
+
+	raw = (__be16 *)&dev_data->buffer[0];
+	ret = regmap_bulk_read(dev_data->map, INV_ICM42370_REG_TEMP_DATA1, raw,
+			       sizeof(*raw));
+	if (ret)
+		goto exit;
+
+	*temp = (s16)be16_to_cpup(raw);
+
+	/*
+	 * Temperature data is invalid if both accel and gyro are off.
+	 * Return -EBUSY in this case.
+	 */
+	if (*temp == INV_ICM42370_DATA_INVALID)
+		ret = -EBUSY;
+
+exit:
+	mutex_unlock(&dev_data->lock);
+	pm_runtime_mark_last_busy(dev);
+	pm_runtime_put_autosuspend(dev);
+
+	return ret;
+}
+
+/**
+ * inv_icm42370_temp_read_raw() - read data from the temperature sensor
+ *
+ * @indio_dev: pointer to the industrial io struct
+ * @chan: pointer to the iio channel specification
+ * @val: integer part of the value
+ * @val2: decimal part of the value
+ * @mask: mask to differentiate between channel info
+ *
+ * Returns 0 on success, negative errno on error
+ */
+static int inv_icm42370_temp_read_raw(struct iio_dev *indio_dev,
+				      struct iio_chan_spec const *chan,
+				      int *val, int *val2, long mask)
+{
+	struct inv_icm42370_data *dev_data = iio_priv(indio_dev);
+	s16 temp;
+	int ret;
+
+	if (chan->type != IIO_TEMP)
+		return -EINVAL;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		if (!iio_device_claim_direct(indio_dev))
+			return -EBUSY;
+		ret = inv_icm42370_temp_read(dev_data, &temp);
+		iio_device_release_direct(indio_dev);
+		if (ret)
+			return ret;
+		*val = temp;
+		return IIO_VAL_INT;
+	/*
+	 * T°C = (temp / 128) + 25
+	 * Tm°C = 1000 * ((temp / 128) + 25)
+	 * Tm°C = 7.8125 * temp + 25000
+	 * Tm°C = (temp + 3200) * 7.8125
+	 * scale: 1000 / 128 ~= 7.8125
+	 * offset: 3200
+	 */
+	case IIO_CHAN_INFO_SCALE:
+		*val = 7;
+		*val2 = 812500;
+		return IIO_VAL_INT_PLUS_MICRO;
+	case IIO_CHAN_INFO_OFFSET:
+		*val = 3200;
+		return IIO_VAL_INT;
+	default:
+		return -EINVAL;
+	}
+}
+
+/**
+ * inv_icm42370_accel_read_offset() - read offset values from the accelerometer
+ *
+ * @dev_data: pointer to struct containing the sensor data
+ * @chan: pointer to iio channel specification
+ * @val: integer part of the value
+ * @val2: decimal part of the value
+ *
+ * Returns 0 on success, negative errno on error
+ */
+static int inv_icm42370_accel_read_offset(struct inv_icm42370_data *dev_data,
+					  struct iio_chan_spec const *chan,
+					  int *val, int *val2)
+{
+	struct device *dev = regmap_get_device(dev_data->map);
+	s64 val64;
+	s32 bias;
+	unsigned int reg;
+	s16 offset;
+	u8 data[2];
+	int ret;
+
+	if (chan->type != IIO_ACCEL)
+		return -EINVAL;
+
+	switch (chan->channel2) {
+	case IIO_MOD_X:
+		reg = INV_ICM42370_REG_OFFSET_USER4;
+		break;
+	case IIO_MOD_Y:
+		reg = INV_ICM42370_REG_OFFSET_USER6;
+		break;
+	case IIO_MOD_Z:
+		reg = INV_ICM42370_REG_OFFSET_USER7;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	pm_runtime_get_sync(dev);
+	mutex_lock(&dev_data->lock);
+
+	ret = inv_icm42370_mreg_read(dev_data->map, INV_ICM42370_MREG1, reg,
+				     dev_data->buffer);
+	memcpy(data, dev_data->buffer, sizeof(data));
+
+	mutex_unlock(&dev_data->lock);
+	pm_runtime_mark_last_busy(dev);
+	pm_runtime_put_autosuspend(dev);
+	if (ret)
+		return ret;
+
+	/* 12 bits signed value */
+	switch (chan->channel2) {
+	case IIO_MOD_X:
+		offset = sign_extend32(((data[0] & 0xF0) << 4) | data[1], 11);
+		break;
+	case IIO_MOD_Y:
+		offset = sign_extend32(((data[1] & 0x0F) << 8) | data[0], 11);
+		break;
+	case IIO_MOD_Z:
+		offset = sign_extend32(((data[0] & 0xF0) << 4) | data[1], 11);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	/*
+	 * convert raw offset to g then to m/s²
+	 * 12 bits signed raw step 0.5mg to g: 5 / 10000
+	 * g to m/s²: 9.806650
+	 * result in micro (1000000)
+	 * (offset * 5 * 9.806650 * 1000000) / 10000
+	 */
+	val64 = (s64)offset * 5LL * 9806650LL;
+	/* for rounding, add + or - divisor (10000) divided by 2 */
+	if (val64 >= 0)
+		val64 += 10000LL / 2LL;
+	else
+		val64 -= 10000LL / 2LL;
+	bias = div_s64(val64, 10000L);
+	*val = bias / 1000000L;
+	*val2 = bias % 1000000L;
+
+	return IIO_VAL_INT_PLUS_MICRO;
+}
+
+/**
+ * inv_icm42370_accel_write_offset() - write offset values to the accelerometer
+ *
+ * @dev_data: pointer to struct containing the sensor data
+ * @chan: pointer to iio channel specification
+ * @val: integer part of the value
+ * @val2: decimal part of the value
+ *
+ * Returns 0 on success, negative errno on error
+ */
+static int inv_icm42370_accel_write_offset(struct inv_icm42370_data *dev_data,
+					   struct iio_chan_spec const *chan,
+					   int val, int val2)
+{
+	struct device *dev = regmap_get_device(dev_data->map);
+	s64 val64;
+	s32 min, max;
+	unsigned int regval;
+	s16 offset;
+	int ret;
+
+	if (chan->type != IIO_ACCEL)
+		return -EINVAL;
+
+	/* inv_icm42370_accel_calibbias: min - step - max in micro */
+	min = inv_icm42370_accel_calibbias[0] * 1000000L +
+	      inv_icm42370_accel_calibbias[1];
+	max = inv_icm42370_accel_calibbias[4] * 1000000L +
+	      inv_icm42370_accel_calibbias[5];
+	val64 = (s64)val * 1000000LL + (s64)val2;
+	if (val64 < min || val64 > max)
+		return -EINVAL;
+
+	/*
+	 * convert m/s² to g then to raw value
+	 * m/s² to g: 1 / 9.806650
+	 * g to raw 12 bits signed, step 0.5mg: 10000 / 5
+	 * val in micro (1000000)
+	 * val * 10000 / (9.806650 * 1000000 * 5)
+	 */
+	val64 = val64 * 10000LL;
+	/* for rounding, add + or - divisor (9806650 * 5) divided by 2 */
+	if (val64 >= 0)
+		val64 += 9806650 * 5 / 2;
+	else
+		val64 -= 9806650 * 5 / 2;
+	offset = div_s64(val64, 9806650 * 5);
+
+	/* clamp value limited to 12 bits signed */
+	if (offset < -2048)
+		offset = -2048;
+	else if (offset > 2047)
+		offset = 2047;
+
+	pm_runtime_get_sync(dev);
+	mutex_lock(&dev_data->lock);
+
+	switch (chan->channel2) {
+	case IIO_MOD_X:
+		/* OFFSET_USER4 register is shared */
+		ret = inv_icm42370_mreg_read(dev_data->map, INV_ICM42370_MREG1,
+					     INV_ICM42370_REG_OFFSET_USER4,
+					     (u8 *)&regval);
+		if (ret)
+			goto out_unlock;
+		dev_data->buffer[0] = ((offset & 0xF00) >> 4) | (regval & 0x0F);
+		dev_data->buffer[1] = offset & 0xFF;
+
+		ret = inv_icm42370_mreg_write(dev_data->map, INV_ICM42370_MREG1,
+					      INV_ICM42370_REG_OFFSET_USER4,
+					      dev_data->buffer[0]);
+		if (ret)
+			goto out_unlock;
+
+		ret = inv_icm42370_mreg_write(dev_data->map, INV_ICM42370_MREG1,
+					      INV_ICM42370_REG_OFFSET_USER5,
+					      dev_data->buffer[1]);
+		if (ret)
+			goto out_unlock;
+		break;
+	case IIO_MOD_Y:
+		/* OFFSET_USER7 register is shared */
+		ret = inv_icm42370_mreg_read(dev_data->map, INV_ICM42370_MREG1,
+					     INV_ICM42370_REG_OFFSET_USER7,
+					     (u8 *)&regval);
+		if (ret)
+			goto out_unlock;
+		dev_data->buffer[0] = offset & 0xFF;
+		dev_data->buffer[1] = ((offset & 0xF00) >> 8) | (regval & 0xF0);
+
+		ret = inv_icm42370_mreg_write(dev_data->map, INV_ICM42370_MREG1,
+					      INV_ICM42370_REG_OFFSET_USER7,
+					      dev_data->buffer[0]);
+		if (ret)
+			goto out_unlock;
+
+		ret = inv_icm42370_mreg_write(dev_data->map, INV_ICM42370_MREG1,
+					      INV_ICM42370_REG_OFFSET_USER6,
+					      dev_data->buffer[1]);
+		if (ret)
+			goto out_unlock;
+
+		break;
+	case IIO_MOD_Z:
+		/* OFFSET_USER7 register is shared */
+		inv_icm42370_mreg_read(dev_data->map, INV_ICM42370_MREG1,
+				       INV_ICM42370_REG_OFFSET_USER7,
+				       (u8 *)&regval);
+
+		dev_data->buffer[0] = ((offset & 0xF00) >> 4) | (regval & 0x0F);
+		dev_data->buffer[1] = offset & 0xFF;
+
+		ret = inv_icm42370_mreg_write(dev_data->map, INV_ICM42370_MREG1,
+					      INV_ICM42370_REG_OFFSET_USER7,
+					      dev_data->buffer[0]);
+		if (ret)
+			goto out_unlock;
+
+		ret = inv_icm42370_mreg_write(dev_data->map, INV_ICM42370_MREG1,
+					      INV_ICM42370_REG_OFFSET_USER8,
+					      dev_data->buffer[1]);
+		if (ret)
+			goto out_unlock;
+		break;
+	default:
+		ret = -EINVAL;
+		goto out_unlock;
+	}
+
+out_unlock:
+	mutex_unlock(&dev_data->lock);
+	pm_runtime_mark_last_busy(dev);
+	pm_runtime_put_autosuspend(dev);
+	return ret;
+}
+
+/**
+ * inv_icm42370_accel_read_scale() - read scaling data from the accelerometer
+ *
+ * @indio_dev: pointer to the industrial io struct
+ * @val: integer part of the value
+ * @val2: decimal part of the value
+ *
+ * Returns 0 on success, negative errno on error
+ */
+static int inv_icm42370_accel_read_scale(struct iio_dev *indio_dev, int *val,
+					 int *val2)
+{
+	struct inv_icm42370_data *dev_data = iio_priv(indio_dev);
+	unsigned int idx;
+
+	idx = dev_data->conf.fs;
+
+	*val = dev_data->sensor_state->scales[2 * idx];
+	*val2 = dev_data->sensor_state->scales[2 * idx + 1];
+	return IIO_VAL_INT_PLUS_NANO;
+}
+
+/**
+ * inv_icm42370_accel_write_scale() - write scaling data to the accelerometer
+ *
+ * @indio_dev: pointer to the industrial io struct
+ * @val: integer part of the value
+ * @val2: decimal part of the value
+ *
+ * Returns 0 on success, negative errno on error
+ */
+static int inv_icm42370_accel_write_scale(struct iio_dev *indio_dev, int val,
+					  int val2)
+{
+	struct inv_icm42370_data *dev_data = iio_priv(indio_dev);
+	struct device *dev = regmap_get_device(dev_data->map);
+	unsigned int idx;
+	struct inv_icm42370_conf conf = INV_ICM42370_SENSOR_CONF_INIT;
+	int ret;
+
+	for (idx = 0; idx < dev_data->sensor_state->scales_len; idx += 2) {
+		if (val == dev_data->sensor_state->scales[idx] &&
+		    val2 == dev_data->sensor_state->scales[idx + 1])
+			break;
+	}
+
+	if (idx >= dev_data->sensor_state->scales_len)
+		return -EINVAL;
+
+	conf.fs = idx / 2;
+
+	pm_runtime_get_sync(dev);
+	mutex_lock(&dev_data->lock);
+
+	ret = inv_icm42370_set_accel_conf(dev_data, &conf, NULL);
+
+	mutex_unlock(&dev_data->lock);
+	pm_runtime_mark_last_busy(dev);
+	pm_runtime_put_autosuspend(dev);
+
+	return ret;
+}
+
+/**
+ * inv_icm42370_accel_read_odr() - read ODR data from the accelerometer
+ *
+ * @dev_data: pointer to struct containing the sensor data
+ * @val: integer part of the value
+ * @val2: decimal part of the value
+ *
+ * Returns 0 on success, negative errno on error
+ */
+static int inv_icm42370_accel_read_odr(struct inv_icm42370_data *dev_data,
+				       int *val, int *val2)
+{
+	unsigned int odr;
+	unsigned int i;
+
+	odr = dev_data->conf.odr;
+
+	for (i = 0; i < ARRAY_SIZE(inv_icm42370_accel_odr_conv); ++i) {
+		if (inv_icm42370_accel_odr_conv[i] == odr)
+			break;
+	}
+	if (i >= ARRAY_SIZE(inv_icm42370_accel_odr_conv))
+		return -EINVAL;
+
+	*val = inv_icm42370_accel_odr[2 * i];
+	*val2 = inv_icm42370_accel_odr[2 * i + 1];
+
+	return IIO_VAL_INT_PLUS_MICRO;
+}
+
+/**
+ * inv_icm42370_accel_write_odr() - write ODR data to the accelerometer
+ *
+ * @indio_dev: pointer to struct containing the sensor data
+ * @val: integer part of the value
+ * @val2: decimal part of the value
+ *
+ * Returns 0 on success, negative errno on error
+ */
+static int inv_icm42370_accel_write_odr(struct iio_dev *indio_dev, int val,
+					int val2)
+{
+	struct inv_icm42370_data *dev_data = iio_priv(indio_dev);
+	struct inv_sensors_timestamp *ts = &dev_data->sensor_state->ts;
+	struct device *dev = regmap_get_device(dev_data->map);
+	unsigned int idx;
+	struct inv_icm42370_conf conf = INV_ICM42370_SENSOR_CONF_INIT;
+	int ret;
+
+	for (idx = 0; idx < ARRAY_SIZE(inv_icm42370_accel_odr); idx += 2) {
+		if (val == inv_icm42370_accel_odr[idx] &&
+		    val2 == inv_icm42370_accel_odr[idx + 1])
+			break;
+	}
+	if (idx >= ARRAY_SIZE(inv_icm42370_accel_odr))
+		return -EINVAL;
+
+	conf.odr = inv_icm42370_accel_odr_conv[idx / 2];
+
+	pm_runtime_get_sync(dev);
+	mutex_lock(&dev_data->lock);
+
+	ret = inv_sensors_timestamp_update_odr(
+		ts, inv_icm42370_odr_to_period(conf.odr),
+		iio_buffer_enabled(indio_dev));
+	if (ret)
+		goto out_unlock;
+
+	ret = inv_icm42370_set_accel_conf(dev_data, &conf, NULL);
+	if (ret)
+		goto out_unlock;
+
+out_unlock:
+	mutex_unlock(&dev_data->lock);
+	pm_runtime_mark_last_busy(dev);
+	pm_runtime_put_autosuspend(dev);
+
+	return ret;
+}
+
+/**
+ * inv_icm42370_accel_write_raw() - write raw attribute values to the accelerometer
+ * @indio_dev:	pointer to the IIO device structure.
+ * @chan:	pointer to the IIO channel specification.
+ * @val:	integer part of the value to write.
+ * @val2:	fractional part of the value to write.
+ * @mask:	bitmask specifying which attribute to write.
+ *
+ * Returns 0 on success, negative errno on error.
+ */
+static int inv_icm42370_accel_write_raw(struct iio_dev *indio_dev,
+					struct iio_chan_spec const *chan,
+					int val, int val2, long mask)
+{
+	struct inv_icm42370_data *dev_data = iio_priv(indio_dev);
+	int ret;
+
+	if (chan->type != IIO_ACCEL)
+		return -EINVAL;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_SCALE:
+		if (!iio_device_claim_direct(indio_dev))
+			return -EBUSY;
+		ret = inv_icm42370_accel_write_scale(indio_dev, val, val2);
+		iio_device_release_direct(indio_dev);
+		return ret;
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		return inv_icm42370_accel_write_odr(indio_dev, val, val2);
+	case IIO_CHAN_INFO_CALIBBIAS:
+		if (!iio_device_claim_direct(indio_dev))
+			return -EBUSY;
+		ret = inv_icm42370_accel_write_offset(dev_data, chan, val,
+						      val2);
+		iio_device_release_direct(indio_dev);
+		return ret;
+
+	default:
+		return -EINVAL;
+	}
+}
+
+/**
+ * inv_icm42370_accel_read_sensor() - internal function to read accelerometer sensor registers
+ *
+ * @indio_dev: pointer to the industrial io struct
+ * @chan: pointer to iio channel specification
+ * @val: pointer containing accelerometer data in s16 format
+ *
+ * Return 0 on success, negative errno on error
+ */
+static int inv_icm42370_accel_read_sensor(struct iio_dev *indio_dev,
+					  struct iio_chan_spec const *chan,
+					  s16 *val)
+{
+	struct inv_icm42370_data *data = iio_priv(indio_dev);
+	struct device *dev = regmap_get_device(data->map);
+	unsigned int reg;
+	__be16 *value;
+	int ret;
+
+	if (chan->type != IIO_ACCEL)
+		return -EINVAL;
+
+	switch (chan->channel2) {
+	case IIO_MOD_X:
+		reg = INV_ICM42370_REG_ACCEL_DATA_X1;
+		break;
+	case IIO_MOD_Y:
+		reg = INV_ICM42370_REG_ACCEL_DATA_Y1;
+		break;
+	case IIO_MOD_Z:
+		reg = INV_ICM42370_REG_ACCEL_DATA_Z1;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	pm_runtime_get_sync(dev);
+	mutex_lock(&data->lock);
+
+	/* read accel register data */
+	value = (__be16 *)&data->buffer[0];
+	ret = regmap_bulk_read(data->map, reg, value, sizeof(*value));
+	if (ret)
+		goto exit;
+
+	*val = (s16)be16_to_cpup(value);
+
+	if (*val == INV_ICM42370_DATA_INVALID)
+		ret = -EINVAL;
+
+exit:
+	mutex_unlock(&data->lock);
+	pm_runtime_mark_last_busy(dev);
+	pm_runtime_put_autosuspend(dev);
+	return ret;
+}
+
+/**
+ * inv_icm42370_accel_read_raw() - read data from the accelerometer sensor
+ *
+ * @indio_dev: pointer to the industrial io struct
+ * @chan: pointer to the iio channel specification
+ * @val: integer part of the value
+ * @val2: decimal part of the value
+ * @mask: mask to differentiate between channel info
+ *
+ * Returns 0 on success, negative errno on error
+ */
+static int inv_icm42370_accel_read_raw(struct iio_dev *indio_dev,
+				       struct iio_chan_spec const *chan,
+				       int *val, int *val2, long mask)
+{
+	struct inv_icm42370_data *dev_data = iio_priv(indio_dev);
+	s16 value;
+	int ret;
+
+	switch (chan->type) {
+	case IIO_ACCEL:
+		break;
+	case IIO_TEMP:
+		return inv_icm42370_temp_read_raw(indio_dev, chan, val, val2,
+						  mask);
+	default:
+		return -EINVAL;
+	}
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		if (!iio_device_claim_direct(indio_dev))
+			return -EBUSY;
+		ret = inv_icm42370_accel_read_sensor(indio_dev, chan, &value);
+		iio_device_release_direct(indio_dev);
+		if (ret)
+			return ret;
+		*val = value;
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_SCALE:
+		return inv_icm42370_accel_read_scale(indio_dev, val, val2);
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		return inv_icm42370_accel_read_odr(dev_data, val, val2);
+	case IIO_CHAN_INFO_CALIBBIAS:
+		return inv_icm42370_accel_read_offset(dev_data, chan, val,
+						      val2);
+	default:
+		return -EINVAL;
+	}
+}
+
+static const struct iio_info inv_icm42370_info = {
+	.read_raw = inv_icm42370_accel_read_raw,
+	.write_raw = inv_icm42370_accel_write_raw,
+};
+
+struct iio_dev *inv_icm42370_accel_init(struct iio_dev *indio_dev,
+					struct inv_icm42370_data *data)
+{
+	struct device *dev = regmap_get_device(data->map);
+	struct inv_sensors_timestamp_chip ts_chip;
+	int ret;
+
+	data->sensor_state->scales = inv_icm42370_accel_scale;
+	data->sensor_state->scales_len = ARRAY_SIZE(inv_icm42370_accel_scale);
+
+	/*
+	 * clock period is 32kHz (31250ns)
+	 * jitter is +/- 2% (20 per mille)
+	 */
+	ts_chip.clock_period = 31250;
+	ts_chip.jitter = 20;
+	ts_chip.init_period = inv_icm42370_odr_to_period(data->conf.odr);
+	inv_sensors_timestamp_init(&data->sensor_state->ts, &ts_chip);
+
+	indio_dev->name = "inv_icm42370";
+	indio_dev->info = &inv_icm42370_info;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->channels = inv_icm42370_accel_channels;
+	indio_dev->num_channels = ARRAY_SIZE(inv_icm42370_accel_channels);
+
+	ret = devm_iio_device_register(dev, indio_dev);
+	if (ret)
+		return ERR_PTR(ret);
+
+	return indio_dev;
+}
+
+/**
+ * inv_icm42370_core_probe() - initialize and register the ICM-42370 device
+ * @regmap:	register map for accessing the device's registers.
+ * @chip:	chip identifier, must be %INV_CHIP_ICM42370.
+ * @irq:	interrupt number for the device's data-ready signal.
+ * @bus_setup:	callback to configure bus-specific settings (e.g. I2C).
+ *
+ * Returns 0 on success, a negative error code otherwise.
+ */
+int inv_icm42370_core_probe(struct regmap *regmap, int chip, int irq,
+			    inv_icm42370_bus_setup bus_setup)
+{
+	struct device *dev = regmap_get_device(regmap);
+	struct inv_icm42370_data *data;
+	struct iio_dev *indio_dev;
+	struct irq_data *irq_desc;
+	int irq_type;
+	bool open_drain;
+	int ret;
+
+	if (chip != INV_CHIP_ICM42370) {
+		dev_err(dev, "invalid chip = %d\n", chip);
+		return -ENODEV;
+	}
+
+	/* get irq properties, set trigger falling by default */
+	irq_desc = irq_get_irq_data(irq);
+	if (!irq_desc) {
+		dev_err(dev, "could not find IRQ %d\n", irq);
+		return -EINVAL;
+	}
+
+	irq_type = irqd_get_trigger_type(irq_desc);
+	if (!irq_type)
+		irq_type = IRQF_TRIGGER_FALLING;
+
+	open_drain = device_property_read_bool(dev, "drive-open-drain");
+
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	data = iio_priv(indio_dev);
+	data->sensor_state =
+		devm_kzalloc(dev, sizeof(*data->sensor_state), GFP_KERNEL);
+	if (!data->sensor_state)
+		return -ENOMEM;
+
+	mutex_init(&data->lock);
+	data->chip = chip;
+	data->map = regmap;
+
+	data->vdd_supply = devm_regulator_get(dev, "vdd");
+	if (IS_ERR(data->vdd_supply))
+		return PTR_ERR(data->vdd_supply);
+
+	data->vddio_supply = devm_regulator_get(dev, "vddio");
+	if (IS_ERR(data->vddio_supply))
+		return PTR_ERR(data->vddio_supply);
+
+	ret = regulator_enable(data->vdd_supply);
+	if (ret)
+		return ret;
+
+	ret = inv_icm42370_setup(data, bus_setup);
+	if (ret)
+		return dev_err_probe(dev, ret, "Setup failed\n");
+
+	data->indio_accel = inv_icm42370_accel_init(indio_dev, data);
+	if (IS_ERR(data->indio_accel))
+		return PTR_ERR(data->indio_accel);
+
+	ret = inv_icm42370_irq_init(data, irq, irq_type, open_drain);
+	if (ret)
+		return ret;
+
+	/* setup runtime power management */
+	ret = pm_runtime_set_active(dev);
+	if (ret)
+		return ret;
+
+	pm_runtime_get_noresume(dev);
+	pm_runtime_enable(dev);
+	pm_runtime_use_autosuspend(dev);
+	pm_runtime_put(dev);
+
+	return devm_add_action_or_reset(dev, inv_icm42370_disable_pm, dev);
+}
+EXPORT_SYMBOL_NS_GPL(inv_icm42370_core_probe, "IIO_ICM42370");
+
+MODULE_AUTHOR("Kanak Shilledar <kanak.shilledar@axis.com>");
+MODULE_AUTHOR("Henrik Grimler <henrik.grimler@axis.com>");
+MODULE_DESCRIPTION("Invensense device ICM42370 driver");
+MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS("IIO_INV_SENSORS_TIMESTAMP");
diff --git a/drivers/iio/accel/inv_icm42370_i2c.c b/drivers/iio/accel/inv_icm42370_i2c.c
new file mode 100644
index 0000000000000..57e97d66329a1
--- /dev/null
+++ b/drivers/iio/accel/inv_icm42370_i2c.c
@@ -0,0 +1,103 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2020 InvenSense, Inc.
+ * Copyright (C) 2026 Axis Communications AB
+ */
+
+#include <linux/kernel.h>
+#include <linux/device.h>
+#include <linux/module.h>
+#include <linux/mod_devicetable.h>
+#include <linux/i2c.h>
+#include <linux/regmap.h>
+#include <linux/property.h>
+
+#include "inv_icm42370.h"
+
+/**
+ * inv_icm42370_i2c_bus_setup() - I2C bus setup for icm42370
+ *
+ * @data: pointer to struct containing the sensor data
+ *
+ * Returns 0 on success, negative errno on error
+ */
+static int inv_icm42370_i2c_bus_setup(struct inv_icm42370_data *data)
+{
+	unsigned int mask, val;
+	int ret;
+
+	/* set slew rates for I2C */
+	mask = INV_ICM42370_DRIVE_CONFIG2_I2C_MASK;
+	val = INV_ICM42370_DRIVE_CONFIG2_I2C(INV_ICM42370_SLEW_RATE_12_36NS);
+	ret = regmap_update_bits(data->map, INV_ICM42370_REG_DRIVE_CONFIG2,
+				 mask, val);
+	if (ret)
+		return ret;
+
+	/* set slew rates for SPI */
+	mask = INV_ICM42370_DRIVE_CONFIG3_SPI_MASK;
+	val = INV_ICM42370_DRIVE_CONFIG3_SPI(INV_ICM42370_SLEW_RATE_12_36NS);
+	ret = regmap_update_bits(data->map, INV_ICM42370_REG_DRIVE_CONFIG3,
+				 mask, val);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+static int inv_icm42370_probe(struct i2c_client *client)
+{
+	const void *match;
+	enum inv_icm42370_chip chip;
+	struct regmap *regmap;
+
+	if (!i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_I2C_BLOCK))
+		return -EOPNOTSUPP;
+
+	match = device_get_match_data(&client->dev);
+	if (!match)
+		return -EINVAL;
+	chip = (uintptr_t)match;
+
+	regmap = devm_regmap_init_i2c(client, &inv_icm42370_regmap_config);
+	if (IS_ERR(regmap))
+		return PTR_ERR(regmap);
+
+	return inv_icm42370_core_probe(regmap, chip, client->irq,
+				       inv_icm42370_i2c_bus_setup);
+}
+
+/**
+ * device id table is used to identify what device can be supported by this driver
+ */
+static const struct i2c_device_id inv_icm42370_id[] = { { "icm42370",
+							  INV_CHIP_ICM42370 },
+							{} };
+MODULE_DEVICE_TABLE(i2c, inv_icm42370_id);
+
+/**
+ * inv_icm42370_of_matches - struct for all the compatibe strings
+ *
+ */
+static const struct of_device_id inv_icm42370_of_matches[] = {
+	{
+		.compatible = "invensense,icm42370",
+		.data = (void *)INV_CHIP_ICM42370,
+	},
+	{}
+};
+MODULE_DEVICE_TABLE(of, inv_icm42370_of_matches);
+
+static struct i2c_driver inv_icm42370_driver = {
+	.driver = {
+		.name = "inv-icm42370-i2c",
+		.of_match_table = inv_icm42370_of_matches,
+	},
+	.probe = inv_icm42370_probe,
+};
+module_i2c_driver(inv_icm42370_driver);
+
+MODULE_AUTHOR("Kanak Shilledar <kanak.shilledar@axis.com>");
+MODULE_AUTHOR("Henrik Grimler <henrik.grimler@axis.com>");
+MODULE_DESCRIPTION("InvenSense ICM-42370P I2C driver");
+MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS("IIO_ICM42370");

-- 
2.43.0

