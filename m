Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010019.outbound.protection.outlook.com [52.101.84.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB1593B5303;
	Fri,  9 Oct 2026 14:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791555162; cv=fail; b=EgOX0fWY+8+1BpDcra2lb/H0L/umCjZuBpptFq65169NP5HgSYpXXvy/GBwCSImhCr81gL92xEBNHmlB15NEIMzMclZJbb2HUQYCYY+jKl3dMjOHwyWvCXz7CKyTJ4j7fNm4UOZVwmtfzR/TaVxOUETBBpYAXXKoJK7npXSZ+xo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791555162; c=relaxed/simple;
	bh=FUpkmuy0UfChPwLeF6zhBJDpmp0cOJXagyA7boaJyMM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=i2mC3ygDSC/K3DpcaTHoSpCItcQGQ34q8KpQBTcqCsePRHToO0dgiFF6AFh2FCbOOA44l1rb3H3eehsGI9BI9mjs436oTcQYgM6wRk/c0e+DTfwaSZ4te4j6befAO32E9MjxFnChbIk7q5wXcWbRk4UI5hX0ws4UxDg9OiMlJag=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=p/Xjsaok; arc=fail smtp.client-ip=52.101.84.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="p/Xjsaok"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vrRxO2YGGjoRyKH0I/bnCQ32jRM5XoYMi+6PcxwjlpwTdkUxWClS5OkUfIbv49L1iz3JlQzkZu027+mrKVjKqrQouKkrqlguNGF9jOow3f7jMJbL0TOmSwyHOeLI2QUsw5IuzAaZ7wAHPWYU2XaCOq653Ltb7bZRWrRv6QCM2oHhC9kCfwD2f/hMwC9s93R15jijOlxG952OUwTwZ5kf8LE8Mz0pNd6xxA2TD6aaVvIRqptXnbeNv/6LLawaxWJVUWgu3CrmiCyIYg145peU1s76NsGMD49eI3tm/3/IjCkJcQMTGZUGorL+5q/4aNaRv+k3ArlH5v+CgL+45mJ0ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7paZ4rFzn+jY1E2bUVd8QHzMENFEdO70u0sL+u92l0M=;
 b=zUxUL/b0n7Ngf1CymkP08/jBlbVH+G0MgZey6wl/JhCL8CPqZbdHz+KlCSJpElMMc6b4UWbQtsLOgSDrqiJJvOJJULl/o/S7IksDpC+H5UlY5hkN0m9d7euQKp6qYb8ypUPestdDeWlBU+yHaFIP0fpsxtptJ5hPuUWEHzKkYq4vt4yVaOFULINuOqDIHniA74jp+6a3Vzs2mojYXpr8xzTR+96bnatXe2cRExN1PsYtJiBLKvCUWGSKMiow1JmP3G3O+FLJXqucilw93s81tcIPdJ9sR6fUBDsWswD02IrolxYNDz6lzPk/ZZj5zV2oFYgf6hPxHt2w+RjWWWRR9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=analog.com smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7paZ4rFzn+jY1E2bUVd8QHzMENFEdO70u0sL+u92l0M=;
 b=p/Xjsaokfd0NOsi3rt911JyfRh3KsywL9/6kiYYPleRqF+I3oFKiKKzh34eDL8gwagKKqGYepOC1gRQw0VfZ3FwiBHPzNv2UABO0Kh+2LbbEa5o0B5YsKaKFenUnTBMiUIL7azgyWZsFRObvz4UI/PAJK5g3dGs6NkWpvxJpNP8=
Received: from OS6P279CA0174.NORP279.PROD.OUTLOOK.COM (2603:10a6:e10:38::16)
 by OSKPR02MB11482.eurprd02.prod.outlook.com (2603:10a6:e10:9e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Fri, 9 Oct
 2026 14:12:36 +0000
Received: from WA1PEPF00009B3B.eurprd05.prod.outlook.com
 (2603:10a6:e10:38:cafe::2) by OS6P279CA0174.outlook.office365.com
 (2603:10a6:e10:38::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.21 via Frontend Transport; Fri, 9
 Oct 2026 14:12:32 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 195.60.68.100) smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 WA1PEPF00009B3B.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Fri, 9 Oct 2026 14:12:32 +0000
Received: from SE-MAILARCH01W.axis.com (10.20.40.15) by se-mail10w.axis.com
 (10.20.40.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.39; Fri, 9 Oct
 2026 16:12:24 +0200
Received: from se-mail11w.axis.com (10.20.40.11) by SE-MAILARCH01W.axis.com
 (10.20.40.15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.61; Fri, 9 Oct
 2026 16:12:24 +0200
Received: from se-intmail02x.se.axis.com (10.4.0.28) by se-mail11w.axis.com
 (10.20.40.11) with Microsoft SMTP Server id 15.2.1748.39 via Frontend
 Transport; Fri, 9 Oct 2026 16:12:24 +0200
Received: from pc66231-2602.sto.se.axis.com (pc66231-2602.sto.se.axis.com [10.133.4.42])
	by se-intmail02x.se.axis.com (Postfix) with ESMTP id 46B001DC2;
	Fri,  9 Oct 2026 16:12:24 +0200 (CEST)
Received: by pc66231-2602.sto.se.axis.com (Postfix, from userid 21940)
	id 2D7E230604F5; Fri,  9 Oct 2026 16:12:24 +0200 (CEST)
From: Kanak Shilledar <kanak.shilledar@axis.com>
Date: Fri, 9 Oct 2026 16:12:11 +0200
Subject: [PATCH v6 6/6] iio: imu: inv_icm42607: Add accelerometer calibbias
 support
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20261009-b4-inv_icm42370p-v6-6-e53884f185ff@axis.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=9981;
 i=kanak.shilledar@axis.com; h=from:subject:message-id;
 bh=FUpkmuy0UfChPwLeF6zhBJDpmp0cOJXagyA7boaJyMM=;
 b=owGbwMvMwCV2JPnG7+2HZqUznlZLYsg68c0j/PF7Pqdv9wTFmw7m6W6c72JbvlM9M3Gz38FZt
 73ki+u5O0pZGMS4GGTFFFnOGW2P3p/8T3eOtNMlmDmsTCBDGLg4BWAiv3wZ/qeGRvnpZ7pfuZSz
 7+qh/5bs5pxGr7VOzjrYvlSMVey9YDAjw+bCVOXZ9r8fx82T8DhhyPb+3Y3o1hCvWxln9sfMDyy
 bwwoA
X-Developer-Key: i=kanak.shilledar@axis.com; a=openpgp;
 fpr=CDB0F1C8EAD5B522C7B3A77928221FF065DB55F9
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: WA1PEPF00009B3B:EE_|OSKPR02MB11482:EE_
X-MS-Office365-Filtering-Correlation-Id: 377c5952-38de-4b1e-bfbb-08df260f5c90
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|32650700020|36860700016|1800799024|82310400026|3613699012|921020|56012099006|11063799006|10067099003|18002099003|22082099003|6133799003|13003099007;
X-Microsoft-Antispam-Message-Info:
	+v7pkJZo6f2jAFt5sgpmj9jhBmA9hrbycK6pcy/aoeQDWINKxHcdnJ4m3njPmt3q7o3BoaLz+aQo5mcRUxvqaDPY22rtDZg/On44edeYazHOIoDpbBB7k6EqxdMrP5d6YeKNIHFxWCv3ZJfSMrMaqVHMfZxJgPodpf/5Y3lRMq8UDtGYnEpXa6Mll+eGTWH+Hhnkdkm1wZbbM+mPeoj6HI+n8wIdqibUvMm61n/hKQW9Tvoq3NjztAcF3DKWR/IWzQfWiEZ7R1xZ5Juzl2UUlJUh1LeZprEm1ALhbxoW7ZfJWYBkmdX5zCjYMgSUJ+H/U/3o+pe4vkyHlTLJyG6n24XGFB2Q8P8sHOP2+MY6IZ3s2xYh8bpbJB4bEEbuSsFuGVPbKbaQXCdkGMeRasc0vD2MLeBoSKjpcee+iHGq9/kkrv5CZfzE1lcLqO0G+Q00+MIJ7ZOfLScVfesdVK+3LpYQqKsAEpBQg3OkmMz9VLsuq+GN6E9bmnV3dZ5Nb7yF2Nf6bKM0AhM5J437R6TJ4XnHQ2wvVbTA2sYrOvz9ql7LEO7MHlrp1M7/zbzLXDcDbydeAz6n9AwWeVozysz4qmonrUehIu5kvByOcikAZNhwg4sWnQbZ7zbbszBhANniBIEGYBzpb2c6+R/gUM9SdaYsLUEmLLcPg8XSyHoksHQuHInvdm5ajFWc9wDBihWpirFepi9kp+Yb0E2V/lnrkJdy7RsCoOM1RgoOU3end8w=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(32650700020)(36860700016)(1800799024)(82310400026)(3613699012)(921020)(56012099006)(11063799006)(10067099003)(18002099003)(22082099003)(6133799003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	V54OUwFhjhLJhAX85vaKlIL+veJ+uvXVLddVP5FgBFNShScOyLBPI5NTnRYlbo4YUCC6QtDiQonA/EFMBaZsy/tQSR/7CXzAb+zPaZ68E5gGgqSq7iyBMpBzGRDhoAtC/POPqhIEfyfIQCSWdvBcqu3gaIyMyXPe9lSXmFsplFlvbLFaDuSoy0pdXGMBk1AUHq4lHpfVuel/xxeH/v+dZ33oC9kFmFYi812qliG3cXFqAHHRv3gm4wnMHfj4jfA+EbEYslacUzKobUNaJSb/hqGKBrtD86PFJfgWqji/4WyQMu2xsKxv8QxZNSWT3/8cqdv5Tle95ChSvRkzmIpwDnQx3NDDRrVwUhS97VgRbpNiLMsdPxbHlRBHbd8HpAeyq3U63ljcH5EtEhq2xu01hrO/mTwZNbzTJ+rCqAqbr9XKyVeBA+HCaF6Gt81QZQl2
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2026 14:12:32.8728
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 377c5952-38de-4b1e-bfbb-08df260f5c90
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	WA1PEPF00009B3B.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSKPR02MB11482

Expose IIO_CHAN_INFO_CALIBBIAS on the accelerometer channels. The
registers are stored in MREG1. The calibration bias is written to
OFFSET_USER4 to OFFSET_USER8 registers in MREG1. Reject the out of
limit calibbias values instead of clamping it.

Datasheet: https://www.invensense.tdk.com/en-us/products/3-axis/icm-42370-p
Datasheet: https://www.lcsc.com/product-detail/C5129967.html
Signed-off-by: Kanak Shilledar <kanak.shilledar@axis.com>
---
Note: The accelerometer functionality is tested with Invensense,
ICM42370-P development board.
---
 drivers/iio/imu/inv_icm42607/inv_icm42607.h       |   8 +
 drivers/iio/imu/inv_icm42607/inv_icm42607_accel.c | 189 +++++++++++++++++++++-
 2 files changed, 195 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607.h b/drivers/iio/imu/inv_icm42607/inv_icm42607.h
index eecf4c46cbdb0..f4b46597a2bc5 100644
--- a/drivers/iio/imu/inv_icm42607/inv_icm42607.h
+++ b/drivers/iio/imu/inv_icm42607/inv_icm42607.h
@@ -437,6 +437,14 @@ struct inv_icm42607_sensor_state {
  */
 #define INV_ICM42607_SUSPEND_DELAY_MS			(2 * MSEC_PER_SEC)
 
+/* OFFSET_USERx shared registers two 4-bit MSB fields */
+#define INV_ICM42607_OFFSET_USER_NIBBLE_HI	GENMASK(7, 4)
+#define INV_ICM42607_OFFSET_USER_NIBBLE_LO	GENMASK(3, 0)
+
+/* 12-bit signed offset value split across two registers */
+#define INV_ICM42607_OFFSET_MSB			GENMASK(11, 8)
+#define INV_ICM42607_OFFSET_LSB			GENMASK(7, 0)
+
 typedef int (*inv_icm42607_bus_setup)(struct inv_icm42607_state *);
 
 extern const struct regmap_config inv_icm42607_regmap_config;
diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607_accel.c b/drivers/iio/imu/inv_icm42607/inv_icm42607_accel.c
index 9a3ace3e7fcf9..fb7ede65d9acd 100644
--- a/drivers/iio/imu/inv_icm42607/inv_icm42607_accel.c
+++ b/drivers/iio/imu/inv_icm42607/inv_icm42607_accel.c
@@ -5,6 +5,7 @@
 
 #include <linux/array_size.h>
 #include <linux/bits.h>
+#include <linux/bitfield.h>
 #include <linux/cleanup.h>
 #include <linux/device/devres.h>
 #include <linux/err.h>
@@ -13,6 +14,7 @@
 #include <linux/pm_runtime.h>
 #include <linux/regmap.h>
 #include <linux/types.h>
+#include <linux/units.h>
 
 #include "inv_icm42607.h"
 #include "inv_icm42607_temp.h"
@@ -22,9 +24,11 @@
 	.type = IIO_ACCEL,							\
 	.modified = 1,								\
 	.channel2 = _modifier,							\
-	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),				\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |				\
+		BIT(IIO_CHAN_INFO_CALIBBIAS),					\
 	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),			\
-	.info_mask_shared_by_type_available = BIT(IIO_CHAN_INFO_SCALE),		\
+	.info_mask_shared_by_type_available = BIT(IIO_CHAN_INFO_SCALE) |	\
+		BIT(IIO_CHAN_INFO_CALIBBIAS),					\
 	.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),		\
 	.info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_SAMP_FREQ),	\
 	.scan_index = _index,							\
@@ -56,6 +60,16 @@ static const struct iio_chan_spec inv_icm42607_accel_channels[] = {
 	INV_ICM42607_TEMP_CHAN(INV_ICM42607_ACCEL_SCAN_TEMP),
 };
 
+/*
+ * Calibration bias values, IIO range format int + micro.
+ * Value is limited to +/-1g coded on 12 bits signed. Step is 0.5mg.
+ */
+static const int inv_icm42607_accel_calibbias[] = {
+	-10, 42010, /* Min : -2^11 * 0.0005 * 9.80665	   = -10.042010 m/s²	*/
+	  0,  4903, /* Step: 0.0005 * 9.80665		   = 0.004903 m/s²	*/
+	 10, 37106, /* Max : (2^11 - 1) * 0.0005 * 9.80665 = 10.037106 m/s²	*/
+};
+
 static const int inv_icm42607_accel_scale_nano[][2] = {
 	[INV_ICM42607_ACCEL_FS_16G] = { 0, 4788403 },
 	[INV_ICM42607_ACCEL_FS_8G] = { 0, 2394202 },
@@ -176,6 +190,166 @@ static int inv_icm42607_accel_write_odr(struct iio_dev *indio_dev,
 	return inv_icm42607_set_sensor_conf(st, &conf, IIO_ACCEL);
 }
 
+static int inv_icm42607_accel_read_offset(struct inv_icm42607_state *st,
+		struct iio_chan_spec const *chan, int *val, int *val2)
+{
+	struct device *dev = regmap_get_device(st->map);
+	unsigned int msb_reg, lsb_reg, nib, byte;
+	int offset;
+	s64 val64;
+	s32 bias;
+	int ret;
+	u32 raw;
+
+	if (chan->type != IIO_ACCEL)
+		return -EINVAL;
+
+	switch (chan->channel2) {
+	case IIO_MOD_X:
+		msb_reg = INV_ICM42607_REG_OFFSET_USER4;
+		lsb_reg = INV_ICM42607_REG_OFFSET_USER5;
+		break;
+	case IIO_MOD_Y:
+		msb_reg = INV_ICM42607_REG_OFFSET_USER7;
+		lsb_reg = INV_ICM42607_REG_OFFSET_USER6;
+		break;
+	case IIO_MOD_Z:
+		msb_reg = INV_ICM42607_REG_OFFSET_USER7;
+		lsb_reg = INV_ICM42607_REG_OFFSET_USER8;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	PM_RUNTIME_ACQUIRE_AUTOSUSPEND(dev, pm);
+	ret = PM_RUNTIME_ACQUIRE_ERR(&pm);
+	if (ret)
+		return ret;
+
+	guard(mutex)(&st->lock);
+
+	ret = regmap_read(st->map, msb_reg, &nib);
+	if (ret)
+		return ret;
+
+	ret = regmap_read(st->map, lsb_reg, &byte);
+	if (ret)
+		return ret;
+
+	/* 12 bits signed value */
+	if (chan->channel2 == IIO_MOD_Y)
+		raw = FIELD_PREP(INV_ICM42607_OFFSET_MSB,
+				 FIELD_GET(INV_ICM42607_OFFSET_USER_NIBBLE_LO, nib));
+	else
+		raw = FIELD_PREP(INV_ICM42607_OFFSET_MSB,
+				 FIELD_GET(INV_ICM42607_OFFSET_USER_NIBBLE_HI, nib));
+
+	raw |= FIELD_PREP(INV_ICM42607_OFFSET_LSB, byte);
+	offset = sign_extend32(raw, 11);
+
+	/*
+	 * Convert raw offset to g then to m/s²
+	 * 12 bits signed raw step 0.5mg to g: 5 / 10000
+	 * g to m/s²: 9.806650
+	 * Result in micro (1000000)
+	 * (offset * 5 * 9.806650 * 1000000) / 10000
+	 */
+	val64 = (s64)offset * 5LL * 9806650LL;
+	/* For rounding, add + or - divisor (10000) divided by 2 */
+	bias = DIV_S64_ROUND_CLOSEST(val64, 10000L);
+	*val = bias / (long)MEGA;
+	*val2 = bias % (long)MEGA;
+
+	return IIO_VAL_INT_PLUS_MICRO;
+}
+
+static int inv_icm42607_accel_write_offset(struct iio_dev *indio_dev,
+					   struct iio_chan_spec const *chan,
+					   int val, int val2)
+{
+	struct inv_icm42607_state *st = iio_device_get_drvdata(indio_dev);
+	struct device *dev = regmap_get_device(st->map);
+	s32 min, max;
+	u8 msb, lsb;
+	s16 offset;
+	s64 val64;
+	int ret;
+
+	if (chan->type != IIO_ACCEL)
+		return -EINVAL;
+
+	/* inv_icm42607_accel_calibbias: min - step - max in micro */
+	min = inv_icm42607_accel_calibbias[0] * (long)MEGA -
+	      inv_icm42607_accel_calibbias[1];
+	max = inv_icm42607_accel_calibbias[4] * (long)MEGA +
+	      inv_icm42607_accel_calibbias[5];
+
+	val64 = val * (s64)MEGA;
+	if (val >= 0)
+		val64 += val2;
+	else
+		val64 -= val2;
+
+	if (val64 < min || val64 > max)
+		return -EINVAL;
+
+	/*
+	 * Convert m/s² to g then to raw value
+	 * m/s² to g: 1 / 9.806650
+	 * g to raw 12 bits signed, step 0.5mg: 10000 / 5
+	 * val in micro (1000000)
+	 * val * 10000 / (9.806650 * 1000000 * 5)
+	 */
+	val64 *= 10000LL;
+	offset = DIV_S64_ROUND_CLOSEST(val64, 9806650 * 5);
+
+	/* Value is limited to 12 bits signed, return -EINVAL if out of range */
+	if (offset < -2048 || offset > 2047)
+		return -EINVAL;
+
+	msb = FIELD_GET(INV_ICM42607_OFFSET_MSB, offset);
+	lsb = FIELD_GET(INV_ICM42607_OFFSET_LSB, offset);
+
+	PM_RUNTIME_ACQUIRE_AUTOSUSPEND(dev, pm);
+	ret = PM_RUNTIME_ACQUIRE_ERR(&pm);
+	if (ret)
+		return ret;
+
+	guard(mutex)(&st->lock);
+
+	switch (chan->channel2) {
+	case IIO_MOD_X:
+		/* OFFSET_USER4 upper nibble is shared. */
+		ret = regmap_update_bits(st->map, INV_ICM42607_REG_OFFSET_USER4,
+				INV_ICM42607_OFFSET_USER_NIBBLE_HI,
+				FIELD_PREP(INV_ICM42607_OFFSET_USER_NIBBLE_HI, msb));
+		if (ret)
+			return ret;
+
+		return regmap_write(st->map, INV_ICM42607_REG_OFFSET_USER5, lsb);
+	case IIO_MOD_Y:
+		/* OFFSET_USER7 lower nibble is shared. */
+		ret = regmap_update_bits(st->map, INV_ICM42607_REG_OFFSET_USER7,
+				INV_ICM42607_OFFSET_USER_NIBBLE_LO,
+				FIELD_PREP(INV_ICM42607_OFFSET_USER_NIBBLE_LO, msb));
+		if (ret)
+			return ret;
+
+		return regmap_write(st->map, INV_ICM42607_REG_OFFSET_USER6, lsb);
+	case IIO_MOD_Z:
+		/* OFFSET_USER7 upper nibble is shared. */
+		ret = regmap_update_bits(st->map, INV_ICM42607_REG_OFFSET_USER7,
+				INV_ICM42607_OFFSET_USER_NIBBLE_HI,
+				FIELD_PREP(INV_ICM42607_OFFSET_USER_NIBBLE_HI, msb));
+		if (ret)
+			return ret;
+
+		return regmap_write(st->map, INV_ICM42607_REG_OFFSET_USER8, lsb);
+	default:
+		return -EINVAL;
+	}
+}
+
 static int inv_icm42607_accel_read_raw(struct iio_dev *indio_dev,
 				       struct iio_chan_spec const *chan,
 				       int *val, int *val2, long mask)
@@ -207,6 +381,8 @@ static int inv_icm42607_accel_read_raw(struct iio_dev *indio_dev,
 		return inv_icm42607_accel_read_scale(indio_dev, val, val2);
 	case IIO_CHAN_INFO_SAMP_FREQ:
 		return inv_icm42607_accel_read_odr(st, val, val2);
+	case IIO_CHAN_INFO_CALIBBIAS:
+		return inv_icm42607_accel_read_offset(st, chan, val, val2);
 	default:
 		return -EINVAL;
 	}
@@ -231,6 +407,12 @@ static int inv_icm42607_accel_read_avail(struct iio_dev *indio_dev,
 		*length = (ARRAY_SIZE(inv_icm42607_accel_odr) -
 			   INV_ICM42607_ODR_1600HZ) * 2;
 		return IIO_AVAIL_LIST;
+	case IIO_CHAN_INFO_CALIBBIAS:
+		if (chan->type != IIO_ACCEL)
+			return -EINVAL;
+		*vals = inv_icm42607_accel_calibbias;
+		*type = IIO_VAL_INT_PLUS_MICRO;
+		return IIO_AVAIL_RANGE;
 	default:
 		return -EINVAL;
 	}
@@ -250,6 +432,8 @@ static int inv_icm42607_accel_write_raw(struct iio_dev *indio_dev,
 		return ret;
 	case IIO_CHAN_INFO_SAMP_FREQ:
 		return inv_icm42607_accel_write_odr(indio_dev, val, val2);
+	case IIO_CHAN_INFO_CALIBBIAS:
+		return inv_icm42607_accel_write_offset(indio_dev, chan, val, val2);
 	default:
 		return -EINVAL;
 	}
@@ -265,6 +449,7 @@ static int inv_icm42607_accel_write_raw_get_fmt(struct iio_dev *indio_dev,
 			return -EINVAL;
 		return IIO_VAL_INT_PLUS_NANO;
 	case IIO_CHAN_INFO_SAMP_FREQ:
+	case IIO_CHAN_INFO_CALIBBIAS:
 		return IIO_VAL_INT_PLUS_MICRO;
 	default:
 		return -EINVAL;

-- 
2.43.0

