Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012030.outbound.protection.outlook.com [52.101.66.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFCD73CF201;
	Tue,  1 Sep 2026 14:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788273379; cv=fail; b=WP9n5Ipy8EYwWph/zc8RBkjQZwiJqrWse32/FS0tYxxHc6nKHERgooQXNYJea5CTnFdUtuSW3JP59twjMgS2+ltcDQuhXTApRkns4TdTlKGzTFCSFhwUnus5PF8M+rC7NuIQDZTV+sbc/14jRZW9eCpSXfBkIrJEOUFtnbXNp1s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788273379; c=relaxed/simple;
	bh=ZHGODs3RsxVAyFBmbdEusNuUodBwFubg8eotaDBGIdA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=de8LRLB87im4+W+oR16LX+r8ISnSHcD1D5L01oabI9iwm7zqtfd8FS5EecJd6ddeX5REPF1YrHzc2A4qUpQs3vbeb0D9+d/yrlbkMAkJIFvJkI7fuFjcs0EyByFxM5LjhdrvMq+rLNxjj6CdPc98XirF787uMdqL1SUoCo6QHR4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=WamMDwJ/; arc=fail smtp.client-ip=52.101.66.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="WamMDwJ/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VOyGasy3Kd4Egx5jznI1TwHOZ85cdr1XOYkiLb8/m7DpVe9AFGfbmdgqY6gobOXReBV2Qbb3BK2zwfo1oGblcbOEr7dxnxJpL69x7sQqRH96nq4umoRDY0AqHm2gWKpA1EW/u0P2E/CO8mf1Awsce0d5W1oq2cW/cXnK/bubB+ZTQ9fDwNPJ85/lgB/AMcRAiSRDFgwqODndWJoqwjIxrOHsYBR3GT6hXrxYaQ69R22YSH9bZieSHc3DA/9nVUVRpHX7OKgJi9zCDLhgij8Isr7OrtbA0nGM/idGOTX7HYH5HAcI1CL+UKdxwibtyy6SQ2+9g/BWrye78S4JM9oGaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+9k8ojMm0cmfCSNT3wKoV+nrS8Yl3BwpQ5JBw7M8upY=;
 b=H0eDkAQc4sIDea527cbEe+Ze3cdyKftXWYW8KCOHz8Y2X1BVu0gg9f3HG20ZGghiu/7LaOjCqBtqmRhuLzBM5ZF8iwT+sJZQb99Rg+q0yFMevQbgUoELfuL+pV3D2/B5P0sOhstQL0yaRzyV0TerRpCoj8UzECeXArLtETWFuirlLE+5QZjMojeJChLvgFwYI7wUUKn9uVkjcbX3uuUuyNCzZadf/mom2LmP+JI3A0pJvQBf+87mLnXfXUOdUAQ+Iv8u/qsAePSdg3j4KPGB19T8+jMGAgW5d5wtpmfnAcfExBVcHv4OZiFvRGdl8z9OK3U0741luLfnFdLfkdQZcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=analog.com smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+9k8ojMm0cmfCSNT3wKoV+nrS8Yl3BwpQ5JBw7M8upY=;
 b=WamMDwJ/9sczjQIKnpYr0WLgfuYAcTsto7/6hNV36dYRkZSYBE/zs4j1vQ92oJg6fWhz6YeNg1l7Z0sTwXBYi0d24qhXQWk0X+3z86qp4M46h02UnxVGmzL3moGnPIEv/QaBiznCdXPOmtMDiVCQh30pHBg6nvO2xGloAXOdiuw=
Received: from AS9PR06CA0329.eurprd06.prod.outlook.com (2603:10a6:20b:45b::35)
 by AS8PR02MB6744.eurprd02.prod.outlook.com (2603:10a6:20b:252::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 14:36:14 +0000
Received: from AMS1EPF0000009C.eurprd02.prod.outlook.com
 (2603:10a6:20b:45b:cafe::5b) by AS9PR06CA0329.outlook.office365.com
 (2603:10a6:20b:45b::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.10 via Frontend Transport; Tue, 1
 Sep 2026 14:36:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 AMS1EPF0000009C.mail.protection.outlook.com (10.167.242.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Tue, 1 Sep 2026 14:36:14 +0000
Received: from SE-MAILARCH01W.axis.com (10.20.40.15) by se-mail10w.axis.com
 (10.20.40.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.39; Tue, 1 Sep
 2026 16:36:05 +0200
Received: from se-mail10w.axis.com (10.20.40.10) by SE-MAILARCH01W.axis.com
 (10.20.40.15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.61; Tue, 1 Sep
 2026 16:36:04 +0200
Received: from se-intmail02x.se.axis.com (10.4.0.28) by se-mail10w.axis.com
 (10.20.40.10) with Microsoft SMTP Server id 15.2.1748.39 via Frontend
 Transport; Tue, 1 Sep 2026 16:36:04 +0200
Received: from pc66231-2602.sto.se.axis.com (pc66231-2602.sto.se.axis.com [10.133.4.42])
	by se-intmail02x.se.axis.com (Postfix) with ESMTP id A0E582DF8;
	Tue,  1 Sep 2026 16:36:04 +0200 (CEST)
Received: by pc66231-2602.sto.se.axis.com (Postfix, from userid 21940)
	id 779E6305CBC9; Tue,  1 Sep 2026 16:36:04 +0200 (CEST)
From: Kanak Shilledar <kanak.shilledar@axis.com>
Date: Tue, 1 Sep 2026 16:35:58 +0200
Subject: [PATCH v3 5/8] iio: imu: inv_icm42607: Add support for ICM-42370-P
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260901-b4-inv_icm42370p-v3-5-77cc31642115@axis.com>
References: <20260901-b4-inv_icm42370p-v3-0-77cc31642115@axis.com>
In-Reply-To: <20260901-b4-inv_icm42370p-v3-0-77cc31642115@axis.com>
To: Henrik Grimler <henrik.grimler@axis.com>, Jonathan Cameron
	<jic23@kernel.org>, David Lechner <dlechner@baylibre.com>,
	=?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, Andy Shevchenko
	<andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, "Jean-Baptiste
 Maneyrol" <jean-baptiste.maneyrol@tdk.com>, Joshua Crofts
	<joshua.crofts1@gmail.com>, Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
	Chris Morgan <macromorgan@hotmail.com>
CC: Kanak Shilledar <kanak.shilledar@axis.com>, <kernel@axis.com>,
	<linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5577;
 i=kanak.shilledar@axis.com; h=from:subject:message-id;
 bh=ZHGODs3RsxVAyFBmbdEusNuUodBwFubg8eotaDBGIdA=;
 b=owGbwMvMwCV2JPnG7+2HZqUznlZLYsia9ujyDUYjzal8X7SeVGz/tPsH3zOeoi7rzNJC76KWu
 7taoht4O0pZGMS4GGTFFFnOGW2P3p/8T3eOtNMlmDmsTCBDGLg4BWAi1TKMDNfOTvudmXH//qMl
 iwuDVc4fF/heevlg5UOLD/X/rjHmsTUz/A9hlDh6cPN8ns1tj3UEzrJ+SsjQmq324sgPrdsdoSF
 ptawA
X-Developer-Key: i=kanak.shilledar@axis.com; a=openpgp;
 fpr=CDB0F1C8EAD5B522C7B3A77928221FF065DB55F9
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS1EPF0000009C:EE_|AS8PR02MB6744:EE_
X-MS-Office365-Filtering-Correlation-Id: 74cd7cf1-51d7-49f6-a443-08df0836603b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|1800799024|82310400026|36860700016|32650700020|921020|6133799003|3613699012|56012099006|10067099003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	hTJkhq4+rJ5lSKkyMnNMO3HCc4jcVDGzsZKPcv3POOxhldozbNmkd5QZxHYEKyjd6YCSOHwOEgldI4V0ELqlYZUEiJjmJUEXOVCROwXyQlAqXKvGoYvRCPyKh5vPVbATP1VlXB+1enMLb/p4v3l5J1s8d0UB1pw0H0CI3rgeLrmru24fsg9FLrAZCMHk+o/pxP93+MvM4Oy3IazpxMfrE3bYCs7Emf6Rb0oEWZwpUid85lviU8t0oG8IuxeKGbo1t8r6GXNa2d+AoFc29z2A+PyC2qH6OG0PSKr0pflJ4JkPU2uAAnBJ79xNJAZAVovQxmtsFyrjZQtuLnCEkoh9nHizQtlUAo7mycwvqnoIN8KharAzxPWingCoyemyQyolVcN/N2qalJ59FmKPv75hST71N3ybQTNE/ls6xvqSLGiHDjJmLROQflKHAsN9qYQMndii4GoKR9uSlOaEPJrtBg2Fgod4i2zWaOXADr5+LZyV5geQfDPlY1wLs8i+YhuXH3MvV2csxA0xPdFcj0Z3hSbFphVtc69LmjEd6sXdeOqQMv+727JUHWlEli26SEm+qmAu+IZHPVrrptc4YDLhIyeLtYcnlcSB6CntvE201CL9XByZNZk8UDRi87aomNAqNkflTlmvoPSb3WOGwYWBCXDlu3/DfHp8AYNuPiY1EC0r7UBYp158/U90/Z2XcQNskVSMn0yy5u4sF/+WwCwupTM3cVG2sD2m0RWKDAibbhc=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(1800799024)(82310400026)(36860700016)(32650700020)(921020)(6133799003)(3613699012)(56012099006)(10067099003)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	6y9GX/gYP5r6B70D8I6vS0AFdeier71lhzDwPBoB0lNzcU0OMV8HloLyUc/wBIWOJUjlR/iE6KeWalzImnSeOhX/CUfjWlI4jZ4GkmM9kCXqGJ6Qy6HhZRzGQOryhroNwqlzwW2Z8GM5kHneKgf5XtH9lnl+I3riNXkGZV66PYLzoVzBw/Cq7NXC7aEtkGcKvIBELkX4b9scv9wIgw3rfBengQ8tMqm0O2FkiytNMH3j4SX62cD9cV888qvXFLJ/GQJGgzBPK4rGPSqflG/ahmZQ6zM862KsDPJffEr7HlYB9tCmL2UR/ZVSsXRB9sjAVPJ9CA/ctUqCBeyavj2n15fju2fdErz72egTiQeBFjDfUeIetb2xSwGwzfm8kyjXu8CKVxrT0HIDzvu48YPXjVad+CFejpElywJ3OmjDyIQQ4tDvOG2vObzjvzPIUs4d
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 14:36:14.5334
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 74cd7cf1-51d7-49f6-a443-08df0836603b
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS1EPF0000009C.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR02MB6744

Add support for the Invensense ICM-42370-P MEMS MotionTracking 3-axis
accelerometer with built-in temperature sensor. This device is almost
identical to the existing Invensense ICM-42607-P IMU, but lacks
gyroscope. The device supports I2C, SPI and I3C, implement only I2C
support. Provide basic support for raw sensor reads via sysfs. There is
also a built-in temperature sensor but it can not be turned off.

Datasheet: https://www.invensense.tdk.com/en-us/products/3-axis/icm-42370-p
Datasheet: https://www.lcsc.com/product-detail/C5129967.html
Signed-off-by: Kanak Shilledar <kanak.shilledar@axis.com>
---
 drivers/iio/imu/inv_icm42607/inv_icm42607.h      |  2 +
 drivers/iio/imu/inv_icm42607/inv_icm42607_core.c | 56 ++++++++++++++++++++----
 drivers/iio/imu/inv_icm42607/inv_icm42607_i2c.c  |  8 ++++
 3 files changed, 58 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607.h b/drivers/iio/imu/inv_icm42607/inv_icm42607.h
index fa85cf738cc0..a183a8566617 100644
--- a/drivers/iio/imu/inv_icm42607/inv_icm42607.h
+++ b/drivers/iio/imu/inv_icm42607/inv_icm42607.h
@@ -368,6 +368,7 @@ struct inv_icm42607_sensor_state {
 #define INV_ICM42607_REG_WHOAMI				0x75
 #define INV_ICM42607P_WHOAMI				0x60
 #define INV_ICM42607_WHOAMI				0x67
+#define INV_ICM42370P_WHOAMI				0x0D
 
 /*
  * Timings as listed in section 3 of datasheet, all values listed in datasheet
@@ -392,6 +393,7 @@ typedef int (*inv_icm42607_bus_setup)(struct inv_icm42607_state *);
 extern const struct regmap_config inv_icm42607_regmap_config;
 extern const struct inv_icm42607_hw inv_icm42607_hw_data;
 extern const struct inv_icm42607_hw inv_icm42607p_hw_data;
+extern const struct inv_icm42607_hw inv_icm42370p_hw_data;
 extern const struct dev_pm_ops inv_icm42607_pm_ops;
 
 const struct iio_mount_matrix *
diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c b/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c
index 7eb486ff673b..e77d72e0f7bc 100644
--- a/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c
+++ b/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c
@@ -92,6 +92,17 @@ static const struct inv_icm42607_conf inv_icm42607_default_conf = {
 	},
 };
 
+/* Chip initial default configuration */
+static const struct inv_icm42607_conf inv_icm42370_default_conf = {
+	.gyro = { },
+	.accel = {
+		.mode = INV_ICM42607_SENSOR_MODE_OFF,
+		.fs = INV_ICM42607_ACCEL_FS_4G,
+		.odr = INV_ICM42607_ODR_100HZ,
+		.filter = INV_ICM42607_FILTER_BW_25HZ,
+	},
+};
+
 const struct inv_icm42607_hw inv_icm42607_hw_data = {
 	.whoami = INV_ICM42607_WHOAMI,
 	.name = "icm42607",
@@ -106,6 +117,13 @@ const struct inv_icm42607_hw inv_icm42607p_hw_data = {
 };
 EXPORT_SYMBOL_NS_GPL(inv_icm42607p_hw_data, "IIO_ICM42607");
 
+const struct inv_icm42607_hw inv_icm42370p_hw_data = {
+	.whoami = INV_ICM42370P_WHOAMI,
+	.name = "icm42370p",
+	.conf = &inv_icm42370_default_conf,
+};
+EXPORT_SYMBOL_NS_GPL(inv_icm42370p_hw_data, "IIO_ICM42607");
+
 const struct iio_mount_matrix *
 inv_icm42607_get_mount_matrix(struct iio_dev *indio_dev,
 			      const struct iio_chan_spec *chan)
@@ -617,16 +635,38 @@ int inv_icm42607_core_probe(struct regmap *regmap,
 	pm_runtime_set_autosuspend_delay(dev, INV_ICM42607_SUSPEND_DELAY_MS);
 	pm_runtime_use_autosuspend(dev);
 
-	/* Initialize IIO device for Accel */
-	st->indio_accel = inv_icm42607_accel_init(st);
-	if (IS_ERR(st->indio_accel))
-		return PTR_ERR(st->indio_accel);
+	switch (st->hw->whoami) {
+	case INV_ICM42607_WHOAMI:
+	case INV_ICM42607P_WHOAMI:
+		/*
+		 * Invensense, ICM42607 and ICM42607P both have accelerometer
+		 * and gyroscope functionality.
+		 */
+		st->indio_accel = inv_icm42607_accel_init(st);
+		if (IS_ERR(st->indio_accel))
+			return PTR_ERR(st->indio_accel);
+
+		st->indio_gyro = inv_icm42607_gyro_init(st);
+		if (IS_ERR(st->indio_gyro))
+			return PTR_ERR(st->indio_gyro);
+
+		break;
+	case INV_ICM42370P_WHOAMI:
+		/*
+		 * Invensense, ICM42370P has only accelerometer functionality.
+		 * Thus, set the gryo property to NULL.
+		 */
+		st->indio_accel = inv_icm42607_accel_init(st);
+		if (IS_ERR(st->indio_accel))
+			return PTR_ERR(st->indio_accel);
 
-	/* Initialize IIO device for Gyro */
-	st->indio_gyro = inv_icm42607_gyro_init(st);
-	if (IS_ERR(st->indio_gyro))
-		return PTR_ERR(st->indio_gyro);
+		st->indio_gyro = NULL;
 
+		break;
+	default:
+		/* No WHOAMI value matched */
+		return dev_err_probe(dev, -ENODEV, "Failed to find a matching WHO_AM_I value\n");
+	}
 	return 0;
 }
 EXPORT_SYMBOL_NS_GPL(inv_icm42607_core_probe, "IIO_ICM42607");
diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607_i2c.c b/drivers/iio/imu/inv_icm42607/inv_icm42607_i2c.c
index e903106af84a..82480ae6879c 100644
--- a/drivers/iio/imu/inv_icm42607/inv_icm42607_i2c.c
+++ b/drivers/iio/imu/inv_icm42607/inv_icm42607_i2c.c
@@ -64,6 +64,10 @@ static const struct i2c_device_id inv_icm42607_id[] = {
 		.name = "icm42607p",
 		.driver_data = (kernel_ulong_t)&inv_icm42607p_hw_data,
 	},
+	{
+		.name = "icm42370p",
+		.driver_data = (kernel_ulong_t)&inv_icm42370p_hw_data,
+	},
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, inv_icm42607_id);
@@ -76,6 +80,10 @@ static const struct of_device_id inv_icm42607_of_matches[] = {
 		.compatible = "invensense,icm42607p",
 		.data = &inv_icm42607p_hw_data,
 	},
+	{
+		.compatible = "invensense,icm42370p",
+		.data = &inv_icm42370p_hw_data,
+	},
 	{ }
 };
 MODULE_DEVICE_TABLE(of, inv_icm42607_of_matches);

-- 
2.43.0

