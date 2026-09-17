Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011026.outbound.protection.outlook.com [52.101.70.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D78B653447E;
	Thu, 17 Sep 2026 13:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789652320; cv=fail; b=jgx965GJAF46+LAQY7IV6//+ztPIhLXKJVar4TJUmUbgn/VVmdscnCLvMQhDpeVVOiEviunAhCb85ideDbx24wc7VZG8ubcXupVwxCVuvcp/gClw0gQ/+69zhbh/cUXspBlB2keA4rEKW4bsCIliRjYjUY4+qYKMjHWU9xN0QmU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789652320; c=relaxed/simple;
	bh=l4GqSv2seyuWh+ODg2ZABEe4nkxIWlRKw2gsijugvXE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=fm5IVhPhUjV7CB2Xj2XuKtGmFjiw4Gto8iBf3Cxxycpvn0D7s4eM8OQWhCmZwEDL+R0cM6Gbbn+GY7pV9pXL51hizSLSDV0bXtkAdDM1HAXMsNwzXA4WS5bfORDpiTVjWbf9Jlsv7weoPnKGw0JD8BXZXGMZqB0EmJy5w73vXKE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=TnUVI6T+; arc=fail smtp.client-ip=52.101.70.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="TnUVI6T+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jnYUljfwchbhHq/Sw0ptsZFo1VbOCthXhl8HMD+9fSOQeT9Rm822eXFbC14bcYTGegLu7ms/4UoezKroXQTYOJDrf/+hevO3h9nVtIZNemHSDutH2oHfjXryyku9aWSrwz9dhHQimC2JjhKr2Js617N6RTeJHH70LEFLZlpkAcZULiybD2uuRF0Va6Heh16MSRgBonebZkida4eUUT9aKHFIoZJn0HDpsnA+nhJr8uHFq0RHeiyiXbLzsLMQTqT0xS1YH5HmLO/tQU3y5XQ7uZsUk+HcJ/b0baQxU8pzMF864obpuRZGn16TnWhfrHiGqjMHjYueQtev8iZy/Mnz3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=96C+sSrMLO2ySS+Ar1PVzIe91a+kOQ3dzjDV/N0eJMY=;
 b=rOsDZBP/mWgsiiewX6JAXM+9hwA78H2g6S/9e81X/hG/rx+00eEwJ2mcSYP3eAvT4aqQTzKeFbsiyCxFW3ky76O0Y1QaWIj8aNKFZlAzdAOfNwXpDhUVbcSkFKGBKo0oXp6c4kqsAUsrcMxiCk7Sk9iYyRO3qKRc3b8datcxFM44PbldYsZJQqufeH/LnRyAq/u6V//EhiYo77mqD1X3EIoheiYj+dZfv00AGTVlzMjgoz/Uuma/aCk40GVhHp9givib9sCnPk0jooOFan2QMb90zvCuW2l9Lh87WDPjJoeo5Gr387tfs/x060a+dc057aXQWcUy9g/9UMALYfhFoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=analog.com smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=96C+sSrMLO2ySS+Ar1PVzIe91a+kOQ3dzjDV/N0eJMY=;
 b=TnUVI6T+UWzWebJHi0nFbglTA4TU+uKIjx6b/XC52iYbTP1S/3w1TfUS2ADcXS7RaV0Vm2jzNhllkvVNLjbR8Dri9XSBILUlTVOGLUQns6O4jACEpxsoe9V4an/aH+03qb6QJOKGett5zqy+lfEuMKp+VCjde8i4v9veYx+yM/8=
Received: from AM8P190CA0030.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:219::35)
 by AMBPR02MB12323.eurprd02.prod.outlook.com (2603:10a6:20b:77a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.12; Thu, 17 Sep
 2026 13:38:24 +0000
Received: from AM2PEPF00070CF2.eurprd02.prod.outlook.com
 (2603:10a6:20b:219:cafe::9f) by AM8P190CA0030.outlook.office365.com
 (2603:10a6:20b:219::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.12 via Frontend Transport; Thu,
 17 Sep 2026 13:38:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 AM2PEPF00070CF2.mail.protection.outlook.com (10.167.242.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Thu, 17 Sep 2026 13:38:24 +0000
Received: from se-mail10w.axis.com (10.20.40.10) by se-mail10w.axis.com
 (10.20.40.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.39; Thu, 17 Sep
 2026 15:38:20 +0200
Received: from se-intmail01x.se.axis.com (10.4.0.28) by se-mail10w.axis.com
 (10.20.40.10) with Microsoft SMTP Server id 15.2.1748.39 via Frontend
 Transport; Thu, 17 Sep 2026 15:38:20 +0200
Received: from pc66231-2602.sto.se.axis.com (pc66231-2602.sto.se.axis.com [10.133.4.42])
	by se-intmail01x.se.axis.com (Postfix) with ESMTP id EFF93321D;
	Thu, 17 Sep 2026 15:38:19 +0200 (CEST)
Received: by pc66231-2602.sto.se.axis.com (Postfix, from userid 21940)
	id D6CB330628B1; Thu, 17 Sep 2026 15:38:19 +0200 (CEST)
From: Kanak Shilledar <kanak.shilledar@axis.com>
Date: Thu, 17 Sep 2026 15:38:20 +0200
Subject: [PATCH v4 5/5] iio: imu: inv_icm42607: Add accelerometer calibbias
 support
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20260917-b4-inv_icm42370p-v4-5-fd9373f123c9@axis.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=8657;
 i=kanak.shilledar@axis.com; h=from:subject:message-id;
 bh=l4GqSv2seyuWh+ODg2ZABEe4nkxIWlRKw2gsijugvXE=;
 b=owGbwMvMwCV2JPnG7+2HZqUznlZLYsha/dZbkcH12c1ly/kC9YSkNf+z76wWbjY6cHRPWVPFo
 3jjOc+XdpSyMIhxMciKKbKcM9oevT/5n+4caadLMHNYmUCGMHBxCsBEdHUY/rvJmJj8OM88f+qu
 vZVJaV1sE2azsasxOnDFH5AQ6/oiv4OR4UlDrbd5wfSj107Ot3tavcpk9xOf190RdrdPZt1c/u4
 5PwcA
X-Developer-Key: i=kanak.shilledar@axis.com; a=openpgp;
 fpr=CDB0F1C8EAD5B522C7B3A77928221FF065DB55F9
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM2PEPF00070CF2:EE_|AMBPR02MB12323:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d91ba1f-59b6-4e86-0bd1-08df14c0f25a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|23010399003|32650700020|7416014|376014|82310400026|3613699012|6133799003|56012099006|11063799006|921020|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	npTDrBB2d2BQiCMpiexmYKTEc+0CqKelFPqJayM3zojrTGWDhPkJx2nD6rtC+FlfMVKHoqOugk3drHBR02vk0cEG/mtwI8+qy4KZCY34q0BNDe4g2Ejp/tGXKOAH03XaCfRggT5XQxvT8dt8C0+RhQeUZAq36DsH9ufSiC64tjWWgtr0pXzZ6uJx+coBxcjijCx/qIa7GzgOfu0CpcLLCokOqX7R0QJKLX2veZh+Y0dYkRKyXOGePMyqi8KrsKcI8twklWh2lFaf4YAbBZ6QtqO+mMXF5Is/VDE9Hni3wNaJuMt2JBq98D0Dg1LRX76lPeAPLCUCtTsijY9lKRjAwwtccXzx1AgAo1XOCnHqUZs6KzKP+m0o9QGk5t1N8UEkCh2CBEvEcuIwWWHjYfLFBsclxPECP6reATdzdrYYOzl9P+VeYq4Y7pO0P5nWu3g/ZajradYS7yuahhbl34i2AmzWlEkYrcPAPOgRLK+1HSHvKfneL/zLRIZzFljR+s485+MTLsGYGe+huWp4Q3erKhrrGdMoOUeeVrZpyG9YL2y2cSIt+AE07z89zFIGrjANrORjihjvgwh0rBJU2wOENfh8HDFdiOSwEru9MY0vn08ztEzJcwNV6wyvzGWe3LbXG9szf7a4RF8tjqUGCXLW+SAWNqDpNqVvuQ8Z9eV18PIBsjfGlsc1AkhOST6KbJWTnnpnI5FWzeyh1f4NexaZshpmdWCe7lOtNoRVgwJ5BHs=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(23010399003)(32650700020)(7416014)(376014)(82310400026)(3613699012)(6133799003)(56012099006)(11063799006)(921020)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	K4hRPb7VDXnhXQqSq/4kgAbG1AmRh5Nh6DnDIS44mhPHL2V32w1AsjiaPh4UsQ0BL5M9VAXlNbmwMZOAhsuEhkrYATi8fl0KU8HAoQQfq5JvThrSeqXNxbduYJFpPJnGbarYHDBQKR11Q++v/XwqCkRAbbuWBHXibuDGvngOU6p0oLjDN1OwegzCYTqQ5941VrDy32qx/Ggygr4QpapSGnFERKtvE3am+ixNpLF80tGjjXun8Z4aLLtDtwyzCPTyvayAJ1VpGxVQ0s2UzVN/6hMawrr1uynmC8SOrDA1vDBVhEFFD5vNmpaEV9kl/I6jNDucjFyrH5/TGUdWtlsiFdeA1c0yMsukoBNgNdGe0RDw7CeWY9Hnl21QGftmy9DiiW0erSkJBO4SU7LAkQ8QMFr2Qd0qkcRz5/8UoJ7Gn/fXRzElE+xmEG9tFibF3Ql9
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 13:38:24.1651
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d91ba1f-59b6-4e86-0bd1-08df14c0f25a
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM2PEPF00070CF2.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMBPR02MB12323

Expose IIO_CHAN_INFO_CALIBBIAS on the accelerometer channels. The
registers are stored in MREG1. The calibration bias is written to
OFFSET_USER4 to OFFSET_USER8 registers in MREG1. Reject the out of
limit calibbias values instead of clamping it.

Note: The accelerometer functionality is tested with Invensense,
ICM42370-P development board.

Datasheet: https://www.invensense.tdk.com/en-us/products/3-axis/icm-42370-p
Datasheet: https://www.lcsc.com/product-detail/C5129967.html
Signed-off-by: Kanak Shilledar <kanak.shilledar@axis.com>
---
 drivers/iio/imu/inv_icm42607/inv_icm42607_accel.c | 194 +++++++++++++++++++++-
 1 file changed, 192 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607_accel.c b/drivers/iio/imu/inv_icm42607/inv_icm42607_accel.c
index 8f61bc9014526..39c5a3f80b2eb 100644
--- a/drivers/iio/imu/inv_icm42607/inv_icm42607_accel.c
+++ b/drivers/iio/imu/inv_icm42607/inv_icm42607_accel.c
@@ -13,6 +13,7 @@
 #include <linux/pm_runtime.h>
 #include <linux/regmap.h>
 #include <linux/types.h>
+#include <linux/units.h>
 
 #include "inv_icm42607.h"
 #include "inv_icm42607_temp.h"
@@ -22,9 +23,11 @@
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
@@ -56,6 +59,16 @@ static const struct iio_chan_spec inv_icm42607_accel_channels[] = {
 	INV_ICM42607_TEMP_CHAN(INV_ICM42607_ACCEL_SCAN_TEMP),
 };
 
+/*
+ * Calibration bias values, IIO range format int + micro.
+ * Value is limited to +/-1g coded on 12 bits signed. Step is 0.5mg.
+ */
+static int inv_icm42607_accel_calibbias[] = {
+	-10, 42010, /* Min : -2^11 * 0.0005 * 9.80665	   = -10.042010 m/s²	*/
+	  0,  4903, /* Step: 0.0005 * 9.80655		   = 0.004903 m/s²	*/
+	 10, 37106, /* Max : (2^11 - 1) * 0.0005 * 9.80665 = 10.037106 m/s²	*/
+};
+
 static const int inv_icm42607_accel_scale_nano[][2] = {
 	[INV_ICM42607_ACCEL_FS_16G] = { 0, 4788403 },
 	[INV_ICM42607_ACCEL_FS_8G] = { 0, 2394202 },
@@ -176,6 +189,171 @@ static int inv_icm42607_accel_write_odr(struct iio_dev *indio_dev,
 	return inv_icm42607_set_sensor_conf(st, &conf, IIO_ACCEL);
 }
 
+static int inv_icm42607_accel_read_offset(struct inv_icm42607_state *st,
+		struct iio_chan_spec const *chan, int *val, int *val2)
+{
+	struct device *dev = regmap_get_device(st->map);
+	unsigned int lo_val, hi_val;
+	unsigned int reg;
+	s16 offset;
+	s64 val64;
+	s32 bias;
+	int ret;
+
+	if (chan->type != IIO_ACCEL)
+		return -EINVAL;
+
+	switch (chan->channel2) {
+	case IIO_MOD_X:
+		reg = INV_ICM42607_REG_OFFSET_USER4;
+		break;
+	case IIO_MOD_Y:
+		reg = INV_ICM42607_REG_OFFSET_USER6;
+		break;
+	case IIO_MOD_Z:
+		reg = INV_ICM42607_REG_OFFSET_USER7;
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
+	ret = regmap_read(st->map, reg, &lo_val);
+	if (ret)
+		return ret;
+
+	ret = regmap_read(st->map, reg + 1, &hi_val);
+	if (ret)
+		return ret;
+
+	/* 12 bits signed value */
+	switch (chan->channel2) {
+	case IIO_MOD_X:
+	case IIO_MOD_Z:
+		offset = sign_extend32(((lo_val & 0xF0) << 4) | hi_val, 11);
+		break;
+	case IIO_MOD_Y:
+		offset = sign_extend32(((hi_val & 0x0F) << 8) | lo_val, 11);
+		break;
+	default:
+		return -EINVAL;
+	}
+	/*
+	 * Convert raw offset to g then to m/s²
+	 * 12 bits signed raw step 0.5mg to g: 5 / 10000
+	 * g to m/s²: 9.806650
+	 * Result in micro (1000000)
+	 * (offset * 5 * 9.806650 * 1000000) / 10000
+	 */
+	val64 = (s64)offset * 5LL * 9806650LL;
+	/* For rounding, add + or - divisor (10000) divided by 2 */
+	if (val64 >= 0)
+		val64 += 10000LL / 2LL;
+	else
+		val64 -= 10000LL / 2LL;
+
+	bias = div_s64(val64, 10000L);
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
+	val64 = (s64)val * (s64)MEGA;
+	if (val >= 0)
+		val64 += (s64)val2;
+	else
+		val64 -= (s64)val2;
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
+	val64 = val64 * 10000LL;
+
+	/* For rounding, add + or - divisor (9806650 * 5) divided by 2 */
+	if (val64 >= 0)
+		val64 += 9806650 * 5 / 2;
+	else
+		val64 -= 9806650 * 5 / 2;
+	offset = div_s64(val64, 9806650 * 5);
+
+	/* Value is limited to 12 bits signed, return -EINVAL if out of range */
+	if (offset < -2048 || offset > 2047)
+		return -EINVAL;
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
+					 GENMASK(7, 4), (offset & 0xF00) >> 4);
+		if (ret)
+			return ret;
+
+		return regmap_write(st->map, INV_ICM42607_REG_OFFSET_USER5,
+				    offset & 0xFF);
+	case IIO_MOD_Y:
+		/* OFFSET_USER7 lower nibble is shared. */
+		ret = regmap_update_bits(st->map, INV_ICM42607_REG_OFFSET_USER7,
+					 GENMASK(3, 0), (offset & 0xF00) >> 8);
+		if (ret)
+			return ret;
+
+		return regmap_write(st->map, INV_ICM42607_REG_OFFSET_USER6,
+				    offset & 0xFF);
+	case IIO_MOD_Z:
+		/* OFFSET_USER7 upper nibble is shared. */
+		ret = regmap_update_bits(st->map, INV_ICM42607_REG_OFFSET_USER7,
+					 GENMASK(7, 4), (offset & 0xF00) >> 4);
+		if (ret)
+			return ret;
+
+		return regmap_write(st->map, INV_ICM42607_REG_OFFSET_USER8,
+				    offset & 0xFF);
+	default:
+		return -EINVAL;
+	}
+}
+
 static int inv_icm42607_accel_read_raw(struct iio_dev *indio_dev,
 				       struct iio_chan_spec const *chan,
 				       int *val, int *val2, long mask)
@@ -207,6 +385,8 @@ static int inv_icm42607_accel_read_raw(struct iio_dev *indio_dev,
 		return inv_icm42607_accel_read_scale(indio_dev, val, val2);
 	case IIO_CHAN_INFO_SAMP_FREQ:
 		return inv_icm42607_accel_read_odr(st, val, val2);
+	case IIO_CHAN_INFO_CALIBBIAS:
+		return inv_icm42607_accel_read_offset(st, chan, val, val2);
 	default:
 		return -EINVAL;
 	}
@@ -231,6 +411,12 @@ static int inv_icm42607_accel_read_avail(struct iio_dev *indio_dev,
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
@@ -250,6 +436,8 @@ static int inv_icm42607_accel_write_raw(struct iio_dev *indio_dev,
 		return ret;
 	case IIO_CHAN_INFO_SAMP_FREQ:
 		return inv_icm42607_accel_write_odr(indio_dev, val, val2);
+	case IIO_CHAN_INFO_CALIBBIAS:
+		return inv_icm42607_accel_write_offset(indio_dev, chan, val, val2);
 	default:
 		return -EINVAL;
 	}
@@ -266,6 +454,8 @@ static int inv_icm42607_accel_write_raw_get_fmt(struct iio_dev *indio_dev,
 		return IIO_VAL_INT_PLUS_NANO;
 	case IIO_CHAN_INFO_SAMP_FREQ:
 		return IIO_VAL_INT_PLUS_MICRO;
+	case IIO_CHAN_INFO_CALIBBIAS:
+		return IIO_VAL_INT_PLUS_MICRO;
 	default:
 		return -EINVAL;
 	}

-- 
2.43.0

