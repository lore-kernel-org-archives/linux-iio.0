Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013039.outbound.protection.outlook.com [52.101.72.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 351A83C5826;
	Tue,  1 Sep 2026 14:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788273378; cv=fail; b=Ez9TVjQ19/K3UfBmaXqIW18ZJY79tbXad666wvPXq17SHRGrJM4qAdGx39/3KlI3b4/M176OG5jouInC64StKbuX/ylBTxhDSUpdEsfD0fkdnGqoV+xWf8fX/QNfkCd9qVzCzovTRHQiN+XAsF2SE5bu2wPulJBXz1SgyuPPW1Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788273378; c=relaxed/simple;
	bh=pFN/oL3nsfqOktGXOZRuzDJioPVKrdv3tqVeNYEAliE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=tQS66XP0R66RUejCKHpMmQE7kEaH6sdZruZvelH6IEuLIYm1D451gtPSJBeLMAbOf51QRMl02atJMEzHmDZDGJaeLbKsEt6SSwyjMxHHkfhkIw3LvxWQfSZy2s+nae5pOk7YZRLw4nayfL1RExNglU3EWaemDGaPhw28FWjdaSg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=BOboJlJW; arc=fail smtp.client-ip=52.101.72.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="BOboJlJW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TZWKBKedmGvOTYUPd7H93iTeGKjZOosZSis7TDZmZOX37+ANfp7GhIqbDvE46QZMu0IJ0EpBCGz2pvQatbpROjL60kUQ9G03HEWD3mUzLW7lBnNQk1QdJr88T1Vp5xW9a7w/wpY24eQRNHm064a94B6EbpEaU6cb3sKfQfbIxrGmeu4pxPjirfvNCqrQ8lfIVCetY3HBQH7Q05+z2H0mHPk3cVG8Rt5Q737u8V6fTCaCi2qr0XQ9kebnyu73sbZZhchF1Odd2wWYmXDuBq5R6YSPB/4vhM/TgBnME2/pYbiAH6WW3+tKVE5jwBGUtHSZ6tIBVT5eZBKkcH55HRFTGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LuPCBiVrk2sfy9OoMsydbiSR4dSMRYtIB9X3CZq4X7Y=;
 b=aPaXXe0HisPyQ9W7VuRzapi+n3KqxKoISYAXvHUI0LPnL9W5TzBjinVb2D95NypK5O/KbxfrBSPYb1/jP9sES1a5mazoHiXJsfrfYHZTLnLW24GHh5YlvZpkTkW+Csylgj7Pt2UlkLH1Rp+LE9YC6RhYmqXPQiaFiK3B36t7cIW7XU6X55xxSDaVs4975z4/B+1ADoc+EMXMtTHgMZRxKbq1ykxkPOs1ImEvL88DOEG1WxSmWaU1Brs2Ld9TJBk/9UnFh5aKQL0wHgGSR6g2DLXiQkbvhFnDw1CI0K7GxT5gp4Gx4x2xdrVLpWUkPm+0kOxOmOv6xL92/qz6Fg9PuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=analog.com smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LuPCBiVrk2sfy9OoMsydbiSR4dSMRYtIB9X3CZq4X7Y=;
 b=BOboJlJWm+gQ7Zs4oy0RFkvbOGdxN6i9RkI3mdiOe8Xokwx1IUChg9CqeO5kvKKvg29LZh1ta6phy3v4WbII/9P1OZvjUx+HHQlRjqgHAM7HCtlL3J4JuiOVHyXGufol30kYlI0cMl7jOGoyKiCPH1dZIMx6bkPcKkGr/ckQxHs=
Received: from AS4P190CA0069.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:656::15)
 by AM0PR02MB5793.eurprd02.prod.outlook.com (2603:10a6:208:18b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 14:36:09 +0000
Received: from AMS1EPF0000004B.eurprd04.prod.outlook.com
 (2603:10a6:20b:656:cafe::93) by AS4P190CA0069.outlook.office365.com
 (2603:10a6:20b:656::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.10 via Frontend Transport; Tue, 1
 Sep 2026 14:36:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 AMS1EPF0000004B.mail.protection.outlook.com (10.167.16.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Tue, 1 Sep 2026 14:36:09 +0000
Received: from se-mail10w.axis.com (10.20.40.10) by se-mail11w.axis.com
 (10.20.40.11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.39; Tue, 1 Sep
 2026 16:36:04 +0200
Received: from se-intmail02x.se.axis.com (10.4.0.28) by se-mail10w.axis.com
 (10.20.40.10) with Microsoft SMTP Server id 15.2.1748.39 via Frontend
 Transport; Tue, 1 Sep 2026 16:36:04 +0200
Received: from pc66231-2602.sto.se.axis.com (pc66231-2602.sto.se.axis.com [10.133.4.42])
	by se-intmail02x.se.axis.com (Postfix) with ESMTP id AD7622E8C;
	Tue,  1 Sep 2026 16:36:04 +0200 (CEST)
Received: by pc66231-2602.sto.se.axis.com (Postfix, from userid 21940)
	id 7B1A9305CBCF; Tue,  1 Sep 2026 16:36:04 +0200 (CEST)
From: Kanak Shilledar <kanak.shilledar@axis.com>
Date: Tue, 1 Sep 2026 16:36:01 +0200
Subject: [PATCH v3 8/8] iio: imu: inv_icm42607: Add gyroscope calibbias
 support
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260901-b4-inv_icm42370p-v3-8-77cc31642115@axis.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=9661;
 i=kanak.shilledar@axis.com; h=from:subject:message-id;
 bh=pFN/oL3nsfqOktGXOZRuzDJioPVKrdv3tqVeNYEAliE=;
 b=owGbwMvMwCV2JPnG7+2HZqUznlZLYsia9uhKU3Yi76+OKZ1R8067THETTXB/0l1y8eDqcCP3X
 94ZtjeLO0pZGMS4GGTFFFnOGW2P3p/8T3eOtNMlmDmsTCBDGLg4BWAiQRWMDBOVWT6UvnjD9KLy
 3v3qBBFr++2H5L7t5b66+V6i0NNU/fMM/xMN42de3bao6vRaLv2vJkkuL37JmK+emSLv4NvwJyJ
 +Dj8A
X-Developer-Key: i=kanak.shilledar@axis.com; a=openpgp;
 fpr=CDB0F1C8EAD5B522C7B3A77928221FF065DB55F9
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS1EPF0000004B:EE_|AM0PR02MB5793:EE_
X-MS-Office365-Filtering-Correlation-Id: 2be8631c-00ed-46ea-952b-08df08365d01
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|32650700020|376014|1800799024|7416014|23010399003|82310400026|921020|3613699012|6133799003|10067099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	t3xv93DHLMmHWZEDU0T0+a42apWVXF+usDABrxpCnO0pbL6qB38bdIkPfMj2tjmnqfbcqRQp7lGacYNiV98XgEn7Ru/cCgURrz7yVVnueMNW5vDSp9MVTh7EtDEcfVOGjEhk2UvbTrWjb78j+WfX86IeEEVbYjbbBN410Kt97lr9cvVREpy23e+SQvop5bA4K2ChPjNDlkSWiXxYqeEy5Q19htaobBrTWAyofvLtYXDK/zK3GEiW8qNvV64nhNi+7N6KY8GP2r/vbCTrPR/L6LKfvhsmLDrrNdJDeOl9s2fPdGjHFk21msBdXcNiTGVf3vHUvQUqoYvA0oFxDDXZ3j+ByuKH3PRmstDnnDr4RVbHqO+i6k566Nr9mI9XLvwc47dFIsWSLdicnEO5+bH7ypvpEPkRncRUblBAXZPKy9g3+ZJWloWVYZsLdBwsEcbsB0FNGg6gxFC7Ebv9C3UTCCOkah2+GfOoR1YpWtPYQlqmy/+9v2H6egsnS+MtriyCf1NOS4GU1pNVsWlw6ec1vS/GIP12up8JX5iz4RwVodR8xo0VGXve5yFSiM0zwVgC94yoVk3iZTZ/v2Z2gi7UUZqpTCrmfhvYbrLHHSLGz6OLcpuPnqbIZc6BsV5EsgSKyISGBE0qUSCu/JLjv2njY/tS8E/GnqureJRPyJniaBYZVJdz9plKmDEgHc/2BYIxJin1wulMdEk0A0EPUl/9s4/Ab6MCbG/wHtCqYYLEkaU=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(32650700020)(376014)(1800799024)(7416014)(23010399003)(82310400026)(921020)(3613699012)(6133799003)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Yybs6xGh652nT+ALubQQVSjriWOdqD/28yXGUx3GEu37kSmIgZ63S7KtVwVjIeUSe7NDlqSg16H6NKcycA06KDgZo7wCLJVB1UFBsJuBoDHlEQxztI2barmzN0GdIgY33eVs7Mn9/7tnTcA84FSxdsQdzIuknXs2Q4RKNL8O2q0EGFcP4Cf8MkH3k6HMHEaxhRtI9/uq0KcTc1n8IUfRl5e8e52oF0JoKIc8lf2URbU5W2tWwM5gF0zruzQdqzYTD7bKl188vuIWZs5x0lPwI7/t45kvWFVR9DlgepP39+DtlDjh9zT07jDiSt12H3eZ0LmDGUbKO8mcv9NdK6C5Q2aopT5wzeZkiCrLJKaqJhVSsZXdJkfzOBiZhn4WYXGoSzRFTPysB3mNCxk7aykGc1I7JE4iGGR3d57/26R0iNiMa4NQTM3IQAV6u9vGw0DY
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 14:36:09.1148
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2be8631c-00ed-46ea-952b-08df08365d01
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS1EPF0000004B.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR02MB5793

Expose IIO_CHAN_INFO_CALIBBIAS on the gyroscope channels. The
registers are stored in MREG1, which can be accessed by the mreg_read
and mreg_write routines. The calibration bias is written to OFFSET_USER0
to OFFSET_USER3 registers in MREG1.

Note: The gyroscope calibbias functionality is not tested on actual
hardware.

Datasheet: https://www.invensense.tdk.com/en-us/products/3-axis/icm-42370-p
Datasheet: https://www.lcsc.com/product-detail/C5129967.html
Signed-off-by: Kanak Shilledar <kanak.shilledar@axis.com>
---
 drivers/iio/imu/inv_icm42607/inv_icm42607_gyro.c | 233 ++++++++++++++++++++++-
 1 file changed, 231 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607_gyro.c b/drivers/iio/imu/inv_icm42607/inv_icm42607_gyro.c
index fb9bacee4e8d..58647cbd4ea4 100644
--- a/drivers/iio/imu/inv_icm42607/inv_icm42607_gyro.c
+++ b/drivers/iio/imu/inv_icm42607/inv_icm42607_gyro.c
@@ -13,6 +13,7 @@
 #include <linux/pm_runtime.h>
 #include <linux/regmap.h>
 #include <linux/types.h>
+#include <linux/units.h>
 
 #include "inv_icm42607.h"
 #include "inv_icm42607_temp.h"
@@ -22,9 +23,11 @@
 	.type = IIO_ANGL_VEL,							\
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
@@ -63,6 +66,16 @@ static const int inv_icm42607_gyro_scale_nano[][2] = {
 	[INV_ICM42607_GYRO_FS_250DPS] = { 0, 133158 },
 };
 
+/*
+ * Calibration bias values, IIO range format int + micro.
+ * Value is limited to +/-64 dps coded on 12 bits signed. Step is 1/32 dps.
+ */
+static int inv_icm42607_gyro_calibbias[] = {
+	-1, 117011, /* Min : -2^11 * (1/32) * (pi/180)	    = -1.117011 rad/s	*/
+	 0,    545, /* Step: (1/32) * (pi/180)		    = 0.000545 rad/s	*/
+	 1, 116465, /* Max : (2^11 - 1) * (1/32) * (pi/180) = 1.116465 rad/s	*/
+};
+
 static int inv_icm42607_gyro_read_scale(struct iio_dev *indio_dev,
 					int *val, int *val2)
 {
@@ -173,6 +186,209 @@ static int inv_icm42607_gyro_write_odr(struct iio_dev *indio_dev,
 	return inv_icm42607_set_sensor_conf(st, &conf, IIO_ANGL_VEL);
 }
 
+static int inv_icm42607_gyro_read_offset(struct inv_icm42607_state *st,
+					 struct iio_chan_spec const *chan,
+					 int *val, int *val2)
+{
+	struct device *dev = regmap_get_device(st->map);
+	s16 offset;
+	s64 val64;
+	u8 lo, hi;
+	s32 bias;
+	int ret;
+
+	if (chan->type != IIO_ANGL_VEL)
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
+		ret = inv_icm42607_mreg_read(st, INV_ICM42607_MREG1,
+					     INV_ICM42607_REG_OFFSET_USER0, &lo);
+		if (ret)
+			return ret;
+		ret = inv_icm42607_mreg_read(st, INV_ICM42607_MREG1,
+					     INV_ICM42607_REG_OFFSET_USER1, &hi);
+		if (ret)
+			return ret;
+		offset = sign_extend32(((hi & 0x0F) << 8) | lo, 11);
+		break;
+
+	case IIO_MOD_Y:
+		ret = inv_icm42607_mreg_read(st, INV_ICM42607_MREG1,
+					     INV_ICM42607_REG_OFFSET_USER2, &lo);
+		if (ret)
+			return ret;
+		ret = inv_icm42607_mreg_read(st, INV_ICM42607_MREG1,
+					     INV_ICM42607_REG_OFFSET_USER1, &hi);
+		if (ret)
+			return ret;
+		offset = sign_extend32((((hi & 0xF0) >> 4) << 8) | lo, 11);
+		break;
+
+	case IIO_MOD_Z:
+		ret = inv_icm42607_mreg_read(st, INV_ICM42607_MREG1,
+					     INV_ICM42607_REG_OFFSET_USER3, &lo);
+		if (ret)
+			return ret;
+		ret = inv_icm42607_mreg_read(st, INV_ICM42607_MREG1,
+					     INV_ICM42607_REG_OFFSET_USER4, &hi);
+		if (ret)
+			return ret;
+		offset = sign_extend32(((hi & 0x0F) << 8) | lo, 11);
+		break;
+
+	default:
+		return -EINVAL;
+	}
+
+	/*
+	 * Convert raw offset to dps then to rad/s
+	 * 12 bits signed raw, step 1/32 dps
+	 * dps to rad/s: pi / 180
+	 * Result in micro (1000000): offset * 5760 / (pi * 1e6)  [inverse below]
+	 * offset * pi * 1e6 / 5760, using pi*1e6 ~= 3141593
+	 */
+	val64 = (s64)offset * 3141593LL;
+	if (val64 >= 0)
+		val64 += 5760LL / 2LL;
+	else
+		val64 -= 5760LL / 2LL;
+
+	bias = div_s64(val64, 5760L);
+	*val = bias / (long)MEGA;
+	*val2 = bias % (long)MEGA;
+
+	return IIO_VAL_INT_PLUS_MICRO;
+}
+
+static int inv_icm42607_gyro_write_offset(struct iio_dev *indio_dev,
+					  struct iio_chan_spec const *chan,
+					  int val, int val2)
+{
+	struct inv_icm42607_state *st = iio_device_get_drvdata(indio_dev);
+	struct device *dev = regmap_get_device(st->map);
+	u8 hi, lo, regval;
+	s64 min64, max64;
+	s16 offset;
+	s64 val64;
+	int ret;
+
+	if (chan->type != IIO_ANGL_VEL)
+		return -EINVAL;
+
+	/* inv_icm42607_gyro_calibbias: min - step - max in micro */
+	min64 = (s64)inv_icm42607_gyro_calibbias[0] * MEGA -
+		inv_icm42607_gyro_calibbias[1];
+	max64 = (s64)inv_icm42607_gyro_calibbias[4] * MEGA +
+		inv_icm42607_gyro_calibbias[5];
+
+	val64 = (s64)val * (s64)MEGA;
+	if (val >= 0)
+		val64 += (s64)val2;
+	else
+		val64 -= (s64)val2;
+
+	if (val64 < min64 || val64 > max64)
+		return -EINVAL;
+
+	/*
+	 * Convert rad/s to dps then to raw 12-bit signed value, step 1/32 dps
+	 * offset = val(rad/s, micro) * 5760 / (pi * 1e6), pi*1e6 ~= 3141593
+	 */
+	val64 = val64 * 5760LL;
+	if (val64 >= 0)
+		val64 += 3141593LL / 2LL;
+	else
+		val64 -= 3141593LL / 2LL;
+	offset = div_s64(val64, 3141593LL);
+
+	if (offset < -2048)
+		offset = -2048;
+	else if (offset > 2047)
+		offset = 2047;
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
+		/* OFFSET_USER1 register is shared with Y */
+		ret = inv_icm42607_mreg_read(st, INV_ICM42607_MREG1,
+					     INV_ICM42607_REG_OFFSET_USER1, &regval);
+		if (ret)
+			return ret;
+
+		lo = offset & 0xFF;
+		hi = ((offset & 0xF00) >> 8) | (regval & 0xF0);
+
+		ret = inv_icm42607_mreg_write(st, INV_ICM42607_MREG1,
+					      INV_ICM42607_REG_OFFSET_USER0, lo);
+		if (ret)
+			return ret;
+		ret = inv_icm42607_mreg_write(st, INV_ICM42607_MREG1,
+					      INV_ICM42607_REG_OFFSET_USER1, hi);
+		if (ret)
+			return ret;
+		break;
+
+	case IIO_MOD_Y:
+		/* OFFSET_USER1 register is shared with X */
+		ret = inv_icm42607_mreg_read(st, INV_ICM42607_MREG1,
+					     INV_ICM42607_REG_OFFSET_USER1, &regval);
+		if (ret)
+			return ret;
+
+		lo = offset & 0xFF;
+		hi = ((offset & 0xF00) >> 4) | (regval & 0x0F);
+
+		ret = inv_icm42607_mreg_write(st, INV_ICM42607_MREG1,
+					      INV_ICM42607_REG_OFFSET_USER2, lo);
+		if (ret)
+			return ret;
+		ret = inv_icm42607_mreg_write(st, INV_ICM42607_MREG1,
+					      INV_ICM42607_REG_OFFSET_USER1, hi);
+		if (ret)
+			return ret;
+		break;
+
+	case IIO_MOD_Z:
+		/* OFFSET_USER4 register is shared with accel X */
+		ret = inv_icm42607_mreg_read(st, INV_ICM42607_MREG1,
+					     INV_ICM42607_REG_OFFSET_USER4, &regval);
+		if (ret)
+			return ret;
+
+		lo = offset & 0xFF;
+		hi = ((offset & 0xF00) >> 8) | (regval & 0xF0);
+
+		ret = inv_icm42607_mreg_write(st, INV_ICM42607_MREG1,
+					      INV_ICM42607_REG_OFFSET_USER3, lo);
+		if (ret)
+			return ret;
+		ret = inv_icm42607_mreg_write(st, INV_ICM42607_MREG1,
+					      INV_ICM42607_REG_OFFSET_USER4, hi);
+		if (ret)
+			return ret;
+		break;
+
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static int inv_icm42607_gyro_read_raw(struct iio_dev *indio_dev,
 				      struct iio_chan_spec const *chan,
 				      int *val, int *val2, long mask)
@@ -204,6 +420,8 @@ static int inv_icm42607_gyro_read_raw(struct iio_dev *indio_dev,
 		return inv_icm42607_gyro_read_scale(indio_dev, val, val2);
 	case IIO_CHAN_INFO_SAMP_FREQ:
 		return inv_icm42607_gyro_read_odr(st, val, val2);
+	case IIO_CHAN_INFO_CALIBBIAS:
+		return inv_icm42607_gyro_read_offset(st, chan, val, val2);
 	default:
 		return -EINVAL;
 	}
@@ -228,6 +446,13 @@ static int inv_icm42607_gyro_read_avail(struct iio_dev *indio_dev,
 		*length = (ARRAY_SIZE(inv_icm42607_gyro_odr) -
 			   INV_ICM42607_ODR_1600HZ) * 2;
 		return IIO_AVAIL_LIST;
+	case IIO_CHAN_INFO_CALIBBIAS:
+		if (chan->type != IIO_ANGL_VEL)
+			return -EINVAL;
+		*vals = inv_icm42607_gyro_calibbias;
+		*type = IIO_VAL_INT_PLUS_MICRO;
+		*length = ARRAY_SIZE(inv_icm42607_gyro_calibbias);
+		return IIO_AVAIL_RANGE;
 	default:
 		return -EINVAL;
 	}
@@ -247,6 +472,8 @@ static int inv_icm42607_gyro_write_raw(struct iio_dev *indio_dev,
 		return ret;
 	case IIO_CHAN_INFO_SAMP_FREQ:
 		return inv_icm42607_gyro_write_odr(indio_dev, val, val2);
+	case IIO_CHAN_INFO_CALIBBIAS:
+		return inv_icm42607_gyro_write_offset(indio_dev, chan, val, val2);
 	default:
 		return -EINVAL;
 	}
@@ -263,6 +490,8 @@ static int inv_icm42607_gyro_write_raw_get_fmt(struct iio_dev *indio_dev,
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

