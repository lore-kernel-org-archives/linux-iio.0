Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013010.outbound.protection.outlook.com [40.107.162.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D09B51C353;
	Thu, 17 Sep 2026 13:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789652317; cv=fail; b=cmZo/W0O6oabqxYft/ONr9kPpkFOHfIM6HF76RTylOjqhLPBC4pntCB0yd/yFxbO2ZLgtSh+Yf7pxYYdotNOag/k1R1zIn2Js/vqTJ6qddB4yAX1XB0E8kNU9BwlZ1EKrmRaB5wMz19tdiXRqPlASCOD8wzGf69J6pxF0xi5NO0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789652317; c=relaxed/simple;
	bh=cJq5uDL1ESnIFCKkrXIM21iETIJjN6xwXRfEYjGWRpc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=kVt0Kamxv8M2a2d8r73DpiFifi1+Ec56B4ND9RilMJpEF4UJtAFg2Om0U3gj9Mbj5MOTmxKtvu3pjaUNi9XoSzD0OjBtAf4r7RGos5y1ZaVa9XVEoMPFzD17P8p1j/BHA/GGEh1zyooLNb69FGtuWWigBpJQIo5FyvdfKVMTtsI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=ZFDE1IqV; arc=fail smtp.client-ip=40.107.162.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="ZFDE1IqV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gTN2Zeeti8ryi9AMdGAZgwx9Bgie8z1264qxMHtff4Bg28YFGw2Xp+QaFWhOC3WZZvPYXh2L2KHjXXEZ9xWzH5+8rrNmDywaoKV4GNjDMdm2Gkaa/iEmPm2tfFz3Ej+boecyK9w2jxAqOYWyuNpWNi7yC2Qt1r4NW/ZmFurvta8xt11RttL8CgquvJBTB7jR2siDClmk26xCVr5OOmWdhr3EdluZ42fmcb3qnzYYMnr9RPXpB61Ar7kICXcKiwfDdzD+P7w5SDeL6BoBs1it5alX7+qAsLdZWGMoUEuvw1NDjPQAA1UmovDKb8XsFXvZ2AtR4bkDCa84Rkz3j7KqAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qibcBhyUs5qnSQepHSzuKaOtlmzCVIEI5pcZLceEF4g=;
 b=XMv6uLawuy2Rn1rAhrS/iea+9hjidZtTVpsoclkEq++D+tG/ysscDfcbTqBsl/B0Jt7tNm68VNbJLkpEcZDFyMekohbQnWEudiANqCJWLSxPPlkrzcvP9TXeh8/31EGTTbym5FQoCdATXqpQpijfEfF85IdraoXC4S/UyayL0zgS6C3LJcdKLY11v5ArZ0SBG3yzvkVkSFD04xFHNaosgKatWwEc95bHk69Gi8dr0/zbj67a+AqExStjTzNku2tUEoaIYCatTdZdXXKZQ+MYzbUy/TGIVkeOjr6jLfL3/zHxc7u9uNzOy72ESX0EIWk+ebbQHjZ4KKmbnqZLwOd8vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=analog.com smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qibcBhyUs5qnSQepHSzuKaOtlmzCVIEI5pcZLceEF4g=;
 b=ZFDE1IqVXla/jpd/9z8Gw+35UBYSXc8Kz/zbsX5S8Ss0VN8AnCnRwAcLZQMPo2UDKoSWKK93NNShnTDBGaPW8YRpJL5YVAZTtR95QSqKsF3MHpvaQWI9hJDuI7L/Gat4xDQ8+9sj8Bjay0jrJiU2VsmdfHjPwMs84nShlbS5/+M=
Received: from AM8P190CA0001.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:219::6)
 by DB8PR02MB5835.eurprd02.prod.outlook.com (2603:10a6:10:11f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Thu, 17 Sep
 2026 13:38:23 +0000
Received: from AM2PEPF00070CF2.eurprd02.prod.outlook.com
 (2603:10a6:20b:219:cafe::79) by AM8P190CA0001.outlook.office365.com
 (2603:10a6:20b:219::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.11 via Frontend Transport; Thu,
 17 Sep 2026 13:38:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 AM2PEPF00070CF2.mail.protection.outlook.com (10.167.242.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Thu, 17 Sep 2026 13:38:23 +0000
Received: from se-mail10w.axis.com (10.20.40.10) by se-mail10w.axis.com
 (10.20.40.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.39; Thu, 17 Sep
 2026 15:38:19 +0200
Received: from se-intmail01x.se.axis.com (10.4.0.28) by se-mail10w.axis.com
 (10.20.40.10) with Microsoft SMTP Server id 15.2.1748.39 via Frontend
 Transport; Thu, 17 Sep 2026 15:38:19 +0200
Received: from pc66231-2602.sto.se.axis.com (pc66231-2602.sto.se.axis.com [10.133.4.42])
	by se-intmail01x.se.axis.com (Postfix) with ESMTP id DFB7F2F24;
	Thu, 17 Sep 2026 15:38:19 +0200 (CEST)
Received: by pc66231-2602.sto.se.axis.com (Postfix, from userid 21940)
	id D4432305C41F; Thu, 17 Sep 2026 15:38:19 +0200 (CEST)
From: Kanak Shilledar <kanak.shilledar@axis.com>
Date: Thu, 17 Sep 2026 15:38:18 +0200
Subject: [PATCH v4 3/5] iio: imu: inv_icm42607: Add support for ICM-42370-P
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260917-b4-inv_icm42370p-v4-3-fd9373f123c9@axis.com>
References: <20260917-b4-inv_icm42370p-v4-0-fd9373f123c9@axis.com>
In-Reply-To: <20260917-b4-inv_icm42370p-v4-0-fd9373f123c9@axis.com>
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
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=5387;
 i=kanak.shilledar@axis.com; h=from:subject:message-id;
 bh=cJq5uDL1ESnIFCKkrXIM21iETIJjN6xwXRfEYjGWRpc=;
 b=owGbwMvMwCV2JPnG7+2HZqUznlZLYsha/dZ7l/tHsa0MYn8VPOrrtwXzdf/lCJnqc3HGFWaHt
 nXXPs641VHKwiDGxSArpshyzmh79P7kf7pzpJ0uwcxhZQIZwsDFKQATebOW4X/FRHszU83Dfr8Z
 pTWeGZhYH3jxoDC/4OctWeN1tkwnp7xgZLg503Dnwsc7tknLbUr//jU0I/GUvbyCLuPEabN/33L
 Oy2AHAA==
X-Developer-Key: i=kanak.shilledar@axis.com; a=openpgp;
 fpr=CDB0F1C8EAD5B522C7B3A77928221FF065DB55F9
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM2PEPF00070CF2:EE_|DB8PR02MB5835:EE_
X-MS-Office365-Filtering-Correlation-Id: 1aaba196-28e0-4ef1-9853-08df14c0f1c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|32650700020|36860700016|7416014|82310400026|376014|23010399003|1800799024|3613699012|921020|11063799006|56012099006|10067099003|18002099003|22082099003|13003099007;
X-Microsoft-Antispam-Message-Info:
	lgXuHgWo7v1yPKklbMojzgg8y0gTgCijqDxhht1xfLCjSFls00PBZES1FOl2B3uMrnNkf1GJnTHmLoz6xTUKwvKpSfmFQUcTVqGpt73jp/NTIkV1+Okort/gF6M87QI0ZSZt2QAlqeTvNFdeX4X7P/yakXdIpF3XIuHUzd/WGkmmy3f2qCzp5kJIDqjMlgCZJKjgOx8LOE8KNO66my5cHvCLJSSX+9NJi/5TpIkhIO4E7M43teb7n5yz6Gu34IW9YvbaKEA0a8UyipqJMi5qp/8kCJzq8iO6BS5t0/uTjZ4fD9a4zsrNFHM85wnLqrEoyNSjucU94BNUXhxgFZgLS9Y9iIIhfg1TLh0M7N/y+32DIf/6YpE4Nfp6r5rlX09gu/a9n82BTvN/MEUtobwJUcNVsETkvH5K6LeQBrMPYQkjNDldjj6oKylazztftRrUltUQvwC7VqWEJxK2jq63l3OROxu6+da820YFme/BR0cK8epx8wTElpN/6vdQSzllhpqyt9rDd2UWMyPwozYPWybbWr+64DWpYR1C0ty8y27MmPgbVIsUW2tYjhdwmSzLSABHj5ZkRSKqhcMR77A45hNGBVuPnXuuA0rJ26HDTdoUIqDqUp9UDifJN7/zahMTgYiGNSFGzbo5suWnfCFbbiFuOrnxryK/eX90BjQoVIcjFGIqkUxcvyP/lbND6OZGu2ytCXI2oT+gIqfG+L58/Mkng7B5Xow9JrMTnOTTgzM=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(32650700020)(36860700016)(7416014)(82310400026)(376014)(23010399003)(1800799024)(3613699012)(921020)(11063799006)(56012099006)(10067099003)(18002099003)(22082099003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	hapiDjtDwlWKEcuVYiJrekK9hJFMnK2VfOnKHv0Bxk07l8WMcgS8QL7vaSxS+kkfJFunYSKLM4Ec9P4krVRxtfaOjDByGgyXqkmVwlqJg3nFb5h49/qiZWhjQvvGq4vrhPfNaQnK901PqK529qWq15/GYghlRst1+/A0iYU8ko567tfdW16NG3E06YF77DR/dMpzLenFrRocHzJO4o4TmZMT+jyh4CDLvYfQoMMNeXIWAzu+Hk4CI6BqlqT7Oup+vOQvEx8zwYZ+PZJstxgNYbCDsvZyMopDTS7dQnclfrxJt84qDFiv4UvD/0aOf4N/Xxk68mC1JT+u3GeCTF9MHc6FHKyTpqsgp91KFXjTfuSgS7qx6utNzz1Ws5/9eZzjD3FSh7nXI7ZDt4mWVsxdhZFGfPqUv3kFq116j4YQU2tCrSGJtskBzCstQYMftkZc
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 13:38:23.1871
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1aaba196-28e0-4ef1-9853-08df14c0f1c4
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM2PEPF00070CF2.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR02MB5835

Add support for the Invensense ICM-42370-P MEMS MotionTracking 3-axis
accelerometer with built-in temperature sensor. This device is almost
identical to the existing Invensense ICM-42607-P IMU, but lacks
gyroscope. The device supports I2C, SPI and I3C, implement only I2C
support. Provide basic support for raw sensor reads via sysfs. There is
also a built-in temperature sensor but it can not be turned off similar
to the ICM-42607. Return with `dev_err_probe()` when WHO_AM_I read
fails.

Datasheet: https://www.invensense.tdk.com/en-us/products/3-axis/icm-42370-p
Datasheet: https://www.lcsc.com/product-detail/C5129967.html
Signed-off-by: Kanak Shilledar <kanak.shilledar@axis.com>
---
 drivers/iio/imu/inv_icm42607/inv_icm42607.h      |  3 ++
 drivers/iio/imu/inv_icm42607/inv_icm42607_core.c | 35 ++++++++++++++++++++----
 drivers/iio/imu/inv_icm42607/inv_icm42607_i2c.c  |  6 ++++
 3 files changed, 38 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607.h b/drivers/iio/imu/inv_icm42607/inv_icm42607.h
index 4d51b0da1aa16..ca5f59eb436c0 100644
--- a/drivers/iio/imu/inv_icm42607/inv_icm42607.h
+++ b/drivers/iio/imu/inv_icm42607/inv_icm42607.h
@@ -130,6 +130,7 @@ struct inv_icm42607_hw {
 	const char *name;
 	const struct inv_icm42607_conf *conf;
 	u8 whoami;
+	bool has_gyro;
 };
 
 /**
@@ -366,6 +367,7 @@ struct inv_icm42607_sensor_state {
 #define INV_ICM42607_REG_FIFO_DATA			0x3F
 
 #define INV_ICM42607_REG_WHOAMI				0x75
+#define INV_ICM42370P_WHOAMI				0x0D
 #define INV_ICM42607P_WHOAMI				0x60
 #define INV_ICM42607_WHOAMI				0x67
 
@@ -392,6 +394,7 @@ typedef int (*inv_icm42607_bus_setup)(struct inv_icm42607_state *);
 extern const struct regmap_config inv_icm42607_regmap_config;
 extern const struct inv_icm42607_hw inv_icm42607_hw_data;
 extern const struct inv_icm42607_hw inv_icm42607p_hw_data;
+extern const struct inv_icm42607_hw inv_icm42370p_hw_data;
 extern const struct dev_pm_ops inv_icm42607_pm_ops;
 
 const struct iio_mount_matrix *
diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c b/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c
index 190e998f7b8ef..114e7afcda391 100644
--- a/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c
+++ b/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c
@@ -92,10 +92,27 @@ static const struct inv_icm42607_conf inv_icm42607_default_conf = {
 	},
 };
 
+static const struct inv_icm42607_conf inv_icm42370_default_conf = {
+	.accel = {
+		.mode = INV_ICM42607_SENSOR_MODE_OFF,
+		.fs = INV_ICM42607_ACCEL_FS_4G,
+		.odr = INV_ICM42607_ODR_100HZ,
+		.filter = INV_ICM42607_FILTER_BW_25HZ,
+	},
+};
+
+const struct inv_icm42607_hw inv_icm42370p_hw_data = {
+	.whoami = INV_ICM42370P_WHOAMI,
+	.name = "icm42370p",
+	.conf = &inv_icm42370_default_conf,
+};
+EXPORT_SYMBOL_NS_GPL(inv_icm42370p_hw_data, "IIO_ICM42607");
+
 const struct inv_icm42607_hw inv_icm42607_hw_data = {
 	.whoami = INV_ICM42607_WHOAMI,
 	.name = "icm42607",
 	.conf = &inv_icm42607_default_conf,
+	.has_gyro = true,
 };
 EXPORT_SYMBOL_NS_GPL(inv_icm42607_hw_data, "IIO_ICM42607");
 
@@ -103,6 +120,7 @@ const struct inv_icm42607_hw inv_icm42607p_hw_data = {
 	.whoami = INV_ICM42607P_WHOAMI,
 	.name = "icm42607p",
 	.conf = &inv_icm42607_default_conf,
+	.has_gyro = true,
 };
 EXPORT_SYMBOL_NS_GPL(inv_icm42607p_hw_data, "IIO_ICM42607");
 
@@ -468,7 +486,7 @@ static int inv_icm42607_setup(struct inv_icm42607_state *st,
 
 	ret = regmap_read(st->map, INV_ICM42607_REG_WHOAMI, &val);
 	if (ret)
-		return ret;
+		return dev_err_probe(dev, ret, "WHOAMI read failed\n");
 
 	/* Warn, but don't fail. */
 	if (val != st->hw->whoami)
@@ -630,15 +648,20 @@ int inv_icm42607_core_probe(struct regmap *regmap,
 	pm_runtime_set_autosuspend_delay(dev, INV_ICM42607_SUSPEND_DELAY_MS);
 	pm_runtime_use_autosuspend(dev);
 
-	/* Initialize IIO device for Accel */
+	/*
+	 * Invensense, ICM42607 and ICM42607P both have accelerometer
+	 * and gyroscope functionality. Whereas, Invensense, ICM42370
+	 * has only accelerometer.
+	 */
 	st->indio_accel = inv_icm42607_accel_init(st);
 	if (IS_ERR(st->indio_accel))
 		return PTR_ERR(st->indio_accel);
 
-	/* Initialize IIO device for Gyro */
-	st->indio_gyro = inv_icm42607_gyro_init(st);
-	if (IS_ERR(st->indio_gyro))
-		return PTR_ERR(st->indio_gyro);
+	if (st->hw->has_gyro) {
+		st->indio_gyro = inv_icm42607_gyro_init(st);
+		if (IS_ERR(st->indio_gyro))
+			return PTR_ERR(st->indio_gyro);
+	}
 
 	return 0;
 }
diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607_i2c.c b/drivers/iio/imu/inv_icm42607/inv_icm42607_i2c.c
index e903106af84a8..cfafba2e3e68e 100644
--- a/drivers/iio/imu/inv_icm42607/inv_icm42607_i2c.c
+++ b/drivers/iio/imu/inv_icm42607/inv_icm42607_i2c.c
@@ -63,6 +63,9 @@ static const struct i2c_device_id inv_icm42607_id[] = {
 	}, {
 		.name = "icm42607p",
 		.driver_data = (kernel_ulong_t)&inv_icm42607p_hw_data,
+	}, {
+		.name = "icm42370p",
+		.driver_data = (kernel_ulong_t)&inv_icm42370p_hw_data,
 	},
 	{ }
 };
@@ -75,6 +78,9 @@ static const struct of_device_id inv_icm42607_of_matches[] = {
 	}, {
 		.compatible = "invensense,icm42607p",
 		.data = &inv_icm42607p_hw_data,
+	}, {
+		.compatible = "invensense,icm42370p",
+		.data = &inv_icm42370p_hw_data,
 	},
 	{ }
 };

-- 
2.43.0

