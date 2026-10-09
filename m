Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013046.outbound.protection.outlook.com [52.101.72.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22A5F3D3D05;
	Fri,  9 Oct 2026 14:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791555154; cv=fail; b=kXVA/+9Btt5AuHVuCLatRLNOhoiGICAqx/b/EMg3Hd6BfunNooUFpCDhCa7Ji1lMyEpoqrveYzRfR0VHI9JgLZ3PFsQBSGOLwTHJpgJIfnOZneaTKD2F+iQ0ewoQtzILzG3fmh9eqMF1AtWoIIQPZiTzJep+6bnawim0Milx5uc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791555154; c=relaxed/simple;
	bh=NVa//4cZQD5FDU6OSRp6DyBGfrYqB+u7i+Qi55bOT8Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=oxvwLsrJAwVXhTlR8TDJWkRnlvWmIf+1qe0+tMCq8qm8QQSqdoKVcFwl+eqfCzBy4JNjyKV8IYWSij27bXZoHQ53oWjhFlqaLHDTbQxDoVlSAWsOog0ieERTz/3NIjmNOFXFjpjXAywKc2BLiGnO73RL37bcNSbyw78br+ai0us=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=nZLYmPi6; arc=fail smtp.client-ip=52.101.72.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="nZLYmPi6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aQ1D3vXsgBu7QpfkeuwgMN40/JPPeshBeySuQ0GzEGGkR3EPVmcIrWZgVDmuWTn1ot9/1FPhIBCiSG8EkZHaNNfHGTg7h8ZU1dQeAJ+6pUMk+jJTcLpCl+cDoOwj7QA5vaCOlj39hpE7UOx/26Zy4wS5AmnNZOPIxrk3a1YrlRI3dYcUyvCc5Y26ApvMItDBtu7xVTNwd7u/x9/hcnsoeEhJA2tYfS/KLMtEWRZnOv1yGx8vAU6z7QmIk8HSY/WyuFOKWTkfikgxIn840JjhJfCAamGcw/HWPUomZnTG0nTX0ITW8ixPF6h+uFMtYsqpKYLty2RCxTQ3stCt2Mag0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ddTGIk8TXsWsUVCvO9hGFrF6y9ty4V6ztcMczNpznMg=;
 b=vLxw+QYLq55tjNHYyHumWCgj5xaYqrxVCqClVt44bSbXhmdKOuYs6o36v4YNG2XqS6YEkSpeCwzg2LnOt35R97dwbiCFT0U75/CJO78IJUt/lXmMoaeK2xjMMKRQVrtFrDGElXF5maxQ0VUl/ufR33cRP53+4vNCXlhH0GYJk2L4WxbyzJFTKhSxxk7EB3DGU9G15jh1RLHXo91MgvMK7k0Bacsztd/4PRbxwY3K689YzQbNfkqoBdptQlexCXcuNJFj5F9j7bcqhn3W2yDDp99NvMjiZwh/u7LUGZVI23frV08SSoUSkPI0eOqQHzk6tVQ7k3wlKMbBSia4TnbCfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=analog.com smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ddTGIk8TXsWsUVCvO9hGFrF6y9ty4V6ztcMczNpznMg=;
 b=nZLYmPi6y3OZ4UFA5Z2ziKKxrRBd+/wEtbLqFntsTCSM1CTAT8FZbDOMM6dGudz3LyKOa/KPXOq0XIblo+Hgje9E36UYu0B1HYdtCPrdkhMCsxugvg0puPwS6nE8WKnSbwIYfdDkyk+5TPrgpypjZj8LSAIQdpq/g8Ou5E8baEw=
Received: from OS6P279CA0178.NORP279.PROD.OUTLOOK.COM (2603:10a6:e10:38::19)
 by PA1PR02MB11861.eurprd02.prod.outlook.com (2603:10a6:102:563::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.16; Fri, 9 Oct
 2026 14:12:28 +0000
Received: from WA1PEPF00009B3B.eurprd05.prod.outlook.com
 (2603:10a6:e10:38:cafe::2) by OS6P279CA0178.outlook.office365.com
 (2603:10a6:e10:38::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Fri, 9
 Oct 2026 14:12:27 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 195.60.68.100) smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 WA1PEPF00009B3B.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Fri, 9 Oct 2026 14:12:26 +0000
Received: from se-mail10w.axis.com (10.20.40.10) by se-mail10w.axis.com
 (10.20.40.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.39; Fri, 9 Oct
 2026 16:12:24 +0200
Received: from se-intmail01x.se.axis.com (10.4.0.28) by se-mail10w.axis.com
 (10.20.40.10) with Microsoft SMTP Server id 15.2.1748.39 via Frontend
 Transport; Fri, 9 Oct 2026 16:12:24 +0200
Received: from pc66231-2602.sto.se.axis.com (pc66231-2602.sto.se.axis.com [10.133.4.42])
	by se-intmail01x.se.axis.com (Postfix) with ESMTP id 3808E1E13;
	Fri,  9 Oct 2026 16:12:24 +0200 (CEST)
Received: by pc66231-2602.sto.se.axis.com (Postfix, from userid 21940)
	id 2AF3230604F3; Fri,  9 Oct 2026 16:12:24 +0200 (CEST)
From: Kanak Shilledar <kanak.shilledar@axis.com>
Date: Fri, 9 Oct 2026 16:12:09 +0200
Subject: [PATCH v6 4/6] iio: imu: inv_icm42607: Add support for ICM-42370-P
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261009-b4-inv_icm42370p-v6-4-e53884f185ff@axis.com>
References: <20261009-b4-inv_icm42370p-v6-0-e53884f185ff@axis.com>
In-Reply-To: <20261009-b4-inv_icm42370p-v6-0-e53884f185ff@axis.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4942;
 i=kanak.shilledar@axis.com; h=from:subject:message-id;
 bh=NVa//4cZQD5FDU6OSRp6DyBGfrYqB+u7i+Qi55bOT8Y=;
 b=owGbwMvMwCV2JPnG7+2HZqUznlZLYsg68c3dpZ1VS9hFsrC7xNau+Oohtk+qz3LcLLQK36tfu
 +1nP9Omo5SFQYyLQVZMkeWc0fbo/cn/dOdIO12CmcPKBDKEgYtTACby8zzD/yo16/PtIR+Zi19u
 ipriUzH33spVcW/OGV7t92Lb3RR9koOR4RhX6J60CzMnfClYeV1s1zshpstyXr9+iTu4iSwLvJV
 Wxw0A
X-Developer-Key: i=kanak.shilledar@axis.com; a=openpgp;
 fpr=CDB0F1C8EAD5B522C7B3A77928221FF065DB55F9
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: WA1PEPF00009B3B:EE_|PA1PR02MB11861:EE_
X-MS-Office365-Filtering-Correlation-Id: 41943140-73d0-4d86-5db5-08df260f5880
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|82310400026|32650700020|1800799024|36860700016|6133799003|18002099003|22082099003|13003099007|921020|3613699012|11063799006|10067099003|260925022911599003|260925021311599003|260925021911599003|56012099006;
X-Microsoft-Antispam-Message-Info:
	cz3TvGkjDLZfL+fd/QB3bp/2aVdLfuJV7jCYTi9QDKwNHU4tgfuI8koAjCqKhBZHBRZ4SNWNkX9H5nbpQrV2lifdK9oDmfRPxyCovrFZcAfg4OolghObfMucSl8b+5DDj5GcsaFTCyeHVt/pz8C57s3wy4tbZ7frxcQwAIz34+HfuZhWinevEdTRR3lf/XnW2zKSk5VXusrGO+QfFz9MGBXcQmZBE7WHrhDIcWh6fiW3cpcNWEYuVO2goNzfo6ERUyK2zHJRvyiNLa3I5TO1jtFYjKB//W9rH4iRAdtDX2DCfsKaifQpx8spZ7nDURhO8n5Xa1H3rRoihY6B6sqjdg7qYXq8EqT9+Si1TKaIFgayE7KYLk0FCax+oPBRu9mWSjoI6xG6G/Up/KOm14U4ejIZyIORhGWjhohmDyI13v9jcGRxPHnxsKT+5aWTrD+s735hby6omAFZtW/X/YE7ku9a3c9tjxbKuex27nn8EyWCn7OJAQahwPiwmHUvvg3KiYdAX8wHgL5S36BCUofB22xrcpG6A/gbKiflyoBy/uLN63C0HZWuO7idWI8kf0yKgj1fiNPzyoYwaTiig5dcpy9flxvib6qtKIkb7tO1RotpCt0A+2DKL7TnYEGzllHbC/xdSrpfHh4aBaS/I+7X6ICd5lzX9ZYUN3Oa7IPIRR8VXgKc9SD9TceU3drxecDBKwVqV4xfv467cZ9XmAgvTNluWcTkd4Atcq00V/d37e3S93NQ7qvkIPjjSsgkY+cbgSM1a89Ih4D1VCMzqBmz7gXoBCVdVpM6TP0gQ89E1CY=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(82310400026)(32650700020)(1800799024)(36860700016)(6133799003)(18002099003)(22082099003)(13003099007)(921020)(3613699012)(11063799006)(10067099003)(260925022911599003)(260925021311599003)(260925021911599003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	vcjqsetzL5Kt7lDtraU8TO1Mekbnp9I6QR6w7Ss6bvBYgoRLuxEVoLa2eu2wwKURXY42BFKi/wIuyy8yFaHluYedcpJYFMngVVlwbZt0zfoUB4dC6QFYqT8XEz7IeDko3ZO19h8EK6DMPf4acWZZs8gJAMQSP9rmqvKQupFURsXK0CyyR5SVYdSNVfZg17D858l/KoWWyU3Do+lewKE4t9ITYuw8IRHqy+jdyBzQkN91xXklp8/6ti1Xz7XUaCCCQcA6ij8vmtVPwDIjGaGdVGgxY+GkqoKoeJy5HdvICbKUjnNteW9aKvV1sWu7OgYIB2WG1L0qXm2nFFehxMDd3kVkmR6n8soEI2z+P6wW67veizHYOQU+pwJ+++NsUuWR/rDe2brwVvSc4Ed1uHHoDLK7z7kFbKPBNVBh5E6KvwiRG/s+z5nXkoNJEIbRH+SZ
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2026 14:12:26.0550
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 41943140-73d0-4d86-5db5-08df260f5880
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	WA1PEPF00009B3B.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR02MB11861

Add support for the Invensense ICM-42370-P MEMS MotionTracking 3-axis
accelerometer with built-in temperature sensor. This device is almost
identical to the existing Invensense ICM-42607-P IMU, but lacks
gyroscope. The device supports I2C, SPI and I3C. Implement only I2C
support for now, and provide support for raw sensor reads via sysfs.
There is also a built-in temperature sensor but it can not be turned off
similar to the ICM-42607.

While at it, change so dev_err_probe() is returned
when the WHO_AM_I read fails.

Datasheet: https://www.invensense.tdk.com/en-us/products/3-axis/icm-42370-p
Reviewed-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Signed-off-by: Kanak Shilledar <kanak.shilledar@axis.com>
---
 drivers/iio/imu/inv_icm42607/inv_icm42607.h      |  2 ++
 drivers/iio/imu/inv_icm42607/inv_icm42607_core.c | 24 ++++++++++++++++++++++--
 drivers/iio/imu/inv_icm42607/inv_icm42607_i2c.c  |  6 ++++++
 3 files changed, 30 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607.h b/drivers/iio/imu/inv_icm42607/inv_icm42607.h
index e4075288247b8..674a9896fabb3 100644
--- a/drivers/iio/imu/inv_icm42607/inv_icm42607.h
+++ b/drivers/iio/imu/inv_icm42607/inv_icm42607.h
@@ -367,6 +367,7 @@ struct inv_icm42607_sensor_state {
 #define INV_ICM42607_REG_FIFO_DATA			0x3F
 
 #define INV_ICM42607_REG_WHOAMI				0x75
+#define INV_ICM42370P_WHOAMI				0x0D
 #define INV_ICM42607P_WHOAMI				0x60
 #define INV_ICM42607_WHOAMI				0x67
 
@@ -391,6 +392,7 @@ struct inv_icm42607_sensor_state {
 typedef int (*inv_icm42607_bus_setup)(struct inv_icm42607_state *);
 
 extern const struct regmap_config inv_icm42607_regmap_config;
+extern const struct inv_icm42607_hw inv_icm42370p_hw_data;
 extern const struct inv_icm42607_hw inv_icm42607_hw_data;
 extern const struct inv_icm42607_hw inv_icm42607p_hw_data;
 extern const struct dev_pm_ops inv_icm42607_pm_ops;
diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c b/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c
index 46274ecfa7b94..75c9617e5d1e7 100644
--- a/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c
+++ b/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c
@@ -77,6 +77,15 @@ const struct regmap_config inv_icm42607_regmap_config = {
 EXPORT_SYMBOL_NS_GPL(inv_icm42607_regmap_config, "IIO_ICM42607");
 
 /* chip initial default configuration */
+static const struct inv_icm42607_conf inv_icm42370_default_conf = {
+	.accel = {
+		.mode = INV_ICM42607_SENSOR_MODE_OFF,
+		.fs = INV_ICM42607_ACCEL_FS_4G,
+		.odr = INV_ICM42607_ODR_100HZ,
+		.filter = INV_ICM42607_FILTER_BW_25HZ,
+	},
+};
+
 static const struct inv_icm42607_conf inv_icm42607_default_conf = {
 	.gyro = {
 		.mode = INV_ICM42607_SENSOR_MODE_OFF,
@@ -92,6 +101,13 @@ static const struct inv_icm42607_conf inv_icm42607_default_conf = {
 	},
 };
 
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
@@ -486,7 +502,7 @@ static int inv_icm42607_setup(struct inv_icm42607_state *st,
 
 	ret = regmap_read(st->map, INV_ICM42607_REG_WHOAMI, &val);
 	if (ret)
-		return ret;
+		return dev_err_probe(dev, ret, "WHOAMI read failed\n");
 
 	/* Warn, but don't fail. */
 	if (val != st->hw->whoami)
@@ -648,7 +664,11 @@ int inv_icm42607_core_probe(struct regmap *regmap,
 	pm_runtime_set_autosuspend_delay(dev, INV_ICM42607_SUSPEND_DELAY_MS);
 	pm_runtime_use_autosuspend(dev);
 
-	/* Initialize IIO device for Accel */
+	/*
+	 * Invensense, ICM42607 and ICM42607P both have accelerometer
+	 * and gyroscope functionality. Whereas, Invensense, ICM42370P
+	 * has only accelerometer.
+	 */
 	st->indio_accel = inv_icm42607_accel_init(st);
 	if (IS_ERR(st->indio_accel))
 		return PTR_ERR(st->indio_accel);
diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607_i2c.c b/drivers/iio/imu/inv_icm42607/inv_icm42607_i2c.c
index e903106af84a8..9f34199ce2949 100644
--- a/drivers/iio/imu/inv_icm42607/inv_icm42607_i2c.c
+++ b/drivers/iio/imu/inv_icm42607/inv_icm42607_i2c.c
@@ -58,6 +58,9 @@ static int inv_icm42607_probe(struct i2c_client *client)
 
 static const struct i2c_device_id inv_icm42607_id[] = {
 	{
+		.name = "icm42370p",
+		.driver_data = (kernel_ulong_t)&inv_icm42370p_hw_data,
+	}, {
 		.name = "icm42607",
 		.driver_data = (kernel_ulong_t)&inv_icm42607_hw_data,
 	}, {
@@ -70,6 +73,9 @@ MODULE_DEVICE_TABLE(i2c, inv_icm42607_id);
 
 static const struct of_device_id inv_icm42607_of_matches[] = {
 	{
+		.compatible = "invensense,icm42370p",
+		.data = &inv_icm42370p_hw_data,
+	}, {
 		.compatible = "invensense,icm42607",
 		.data = &inv_icm42607_hw_data,
 	}, {

-- 
2.43.0

