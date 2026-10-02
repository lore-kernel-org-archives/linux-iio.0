Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011039.outbound.protection.outlook.com [52.101.65.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17CC1492199;
	Fri,  2 Oct 2026 11:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790942093; cv=fail; b=DIrgfDCYheeHdhE+B+r3KzOS69XSWQXaHKGOzz96PqxSJjXNsb6KVcIjDPKy+szunQ0obSTMTJLvu5IGFlAl8XkwGj2+1MB1Lvj5UXMegm5e67bVMOoR3oqaM0R9YQQjR0ysjRRFRYd+uxnSVVfha/QQv5DL04xRmzL9WmEdxKA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790942093; c=relaxed/simple;
	bh=vnW2nY7BpjaPk0NhtjT/BRk5opcByT4S2qw2U9+GHCI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=KgAAKn03pY2Kh0rV62+ALYkIg/GtYLR/N9L5n+5oUvJZ0fzQWc+spE+Ph9NIncV9y1cHPvuwF5ej/D08cyQK9ap1XaJIigbE+UWNQX+eMOMU4vqDjSNLzK1LdQGQX/QLu8SJrkgQD1RDeYB4ervzMoApCJGj7CvIaHZ36zHxVYA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=VXxfNcu4; arc=fail smtp.client-ip=52.101.65.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="VXxfNcu4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TC8yGE2zXu2O1efnAMxETcowAkRaW7iqxE1h40nt/9Se7iWUXk+aVgEU0d3wca9nrMNillG1NK2qgDPncP4NLlVbK1sK4PKuhpdmWXwxTh9I+34+Awclq5zMTdHmLvWHsTXSjQFx0HMCLr9pUdPIgIYc0s+I8SMdvMZUyQ/htvrTJG+nFJVg5U07pwj2pH8LHNJeUkjMl+2tEsFn3+6oCIxYr79Jp8Glyy55Geb0AVzVsg+WM5DszKFmzOJA+G4M+Wp5XMGrYwcRfDU4CkVakXaWggtb4SKi0bfK7a9Te2+esazctiGgxsHN1i9ZSlsLwaTEXXeYOPxFZYIo59g0Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iVMYu5v16+d2vX3fvoRTOjc2xyWG9fIshl8ZtnykIUU=;
 b=DSSjPW+DKncPJ2NcGlZFQGU2mDqzs5EriQnH/1dTJC5glaysSiEeFIQr0iS3ZvoF6/VmfQuzIhxyozrNbLMoUVI/0nmOZ75z3g+JlrxLTHUQTvrPzwD2fjAdTvumCu3PhWbD8BmHOOA6rot47OzZ0PmYZmq8RYSZ30GUAYsA/m+kDeg3Ngf+DR8EDFJJuZmwfGbO+7ptcUs+tbu9lzU58oSoficEhcHvfMeJdz9+Oi4ZUvLSDeBLdZXhNJQoyY0UceDR0tbBvmopCwsuL305H73IanlQeHO0d8ceVya4f3JPVbRanU3XGUQfNs273J+K8gHvk3AAcraBIpQWeqxMIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=analog.com smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iVMYu5v16+d2vX3fvoRTOjc2xyWG9fIshl8ZtnykIUU=;
 b=VXxfNcu4fv7dyHANYPHraPWmVNeeSvYxigC3yJXEft6qIFboXpjFNMRRPdQt7P8rUwO0lCt1oLLh1WAxvsV1Y9mgGNIU+v3PzYLRqdtGq2lO5l7NHkj3jsGj5sSgL7+qTQUVD8EIawSSDli0yCJ/BxT5LOemHreFOvnQSma6kB8=
Received: from PAZP264CA0095.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1fb::19)
 by VI1PR02MB6205.eurprd02.prod.outlook.com (2603:10a6:800:186::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Fri, 2 Oct
 2026 11:54:43 +0000
Received: from AM7PEPF00000056.EURPRD83.prod.outlook.com
 (2603:10a6:102:1fb:cafe::a9) by PAZP264CA0095.outlook.office365.com
 (2603:10a6:102:1fb::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.19 via Frontend Transport; Fri, 2
 Oct 2026 11:54:43 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 195.60.68.100) smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 AM7PEPF00000056.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.3 via Frontend Transport; Fri, 2 Oct 2026 11:54:43 +0000
Received: from se-mail11w.axis.com (10.20.40.11) by se-mail11w.axis.com
 (10.20.40.11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.39; Fri, 2 Oct
 2026 13:54:40 +0200
Received: from se-intmail01x.se.axis.com (10.4.0.28) by se-mail11w.axis.com
 (10.20.40.11) with Microsoft SMTP Server id 15.2.1748.39 via Frontend
 Transport; Fri, 2 Oct 2026 13:54:40 +0200
Received: from pc66231-2602.sto.se.axis.com (pc66231-2602.sto.se.axis.com [10.133.4.42])
	by se-intmail01x.se.axis.com (Postfix) with ESMTP id 721674A60;
	Fri,  2 Oct 2026 13:54:40 +0200 (CEST)
Received: by pc66231-2602.sto.se.axis.com (Postfix, from userid 21940)
	id 58635305CE20; Fri,  2 Oct 2026 13:54:40 +0200 (CEST)
From: Kanak Shilledar <kanak.shilledar@axis.com>
Date: Fri, 2 Oct 2026 13:54:30 +0200
Subject: [PATCH v5 6/6] iio: imu: inv_icm42607: Add accelerometer calibbias
 support
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20261002-b4-inv_icm42370p-v5-6-c65281b745c9@axis.com>
References: <20261002-b4-inv_icm42370p-v5-0-c65281b745c9@axis.com>
In-Reply-To: <20261002-b4-inv_icm42370p-v5-0-c65281b745c9@axis.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=8641;
 i=kanak.shilledar@axis.com; h=from:subject:message-id;
 bh=vnW2nY7BpjaPk0NhtjT/BRk5opcByT4S2qw2U9+GHCI=;
 b=owGbwMvMwCV2JPnG7+2HZqUznlZLYsjaP7sh6GBtv2x27ef4mUz1aQqbJk/Y4Lji4R1Z9ms2q
 cznUtJ3dZSyMIhxMciKKbKcM9oevT/5n+4caadLMHNYmUCGMHBxCsBEQqUZ/sr8X311lrLxihTj
 t0zzZrxb/66xadLGLy/7ZSYf8w8RmPCJ4X/O09RXLH1Ws09891w+Uc/40mte3/Ot87zjo/adSm3
 iV+MCAA==
X-Developer-Key: i=kanak.shilledar@axis.com; a=openpgp;
 fpr=CDB0F1C8EAD5B522C7B3A77928221FF065DB55F9
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM7PEPF00000056:EE_|VI1PR02MB6205:EE_
X-MS-Office365-Filtering-Correlation-Id: 4195c3ed-a9e2-4cfa-1f91-08df207bf29f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|82310400026|32650700020|376014|7416014|36860700016|921020|18002099003|22082099003|13003099007|3613699012|6133799003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info:
	Ms1q5w5GoYja7oN+YvWVCVCwYv5/hAwzzvUzjYHMT5sWk0hnpEQFpfmfvW9CrKX6hbNmx/9w2XStTvFhxSBfG+GSWYdzLKO4TmBt7GDdGdqpU3PrH+xeqvwL/0ODXxHljt//U7vYsJKFKuB0z5cfcBavOpylapu+yAjR4Vo3klF4nED2uhL0idcgDEzQyw7ZV/pIVpRGxW0JVNG50lrah4RhKmrvUZhLYNG2m3rzaIUsb3Qi/1SZkUxdu45YQZMv6LOPBXJHMSox+/j9sfmGwfoF7S/yJeSSYHOUQKao0kHeTioeOUYIvoBXAisRnSiXcCM8NlS829RJbgvbSvHsyDjOMpdHIZKEbgQ+mJJNo1mp0V8/RRxtkFdJtNJdrX/Wecbc7UeJHuFSz0OWMHcU4gOwWp1C+GxL7BtFoZSSQ0Plf7bGhOaIXN5/Xdxo9XrxwZM/JvzOGxGElAXYtFX0ZFFHUiE+LRGvAMKXWbgQg4Y6SwWBEgZybNbbTUS01QpFnIO125/54i8eQjFoYrTnZR9/o6fX9uTFdfVYJ2mgW4xCsgLeWtZiJxpk9FBNdtnIHt0ZTs/mn7J3C3q67wLCd9Viur4l2DNLR4HrDpoCE1fFOt/0Hl9X/cX2i7lnA7Kzh2+Y5DPA+6xK3mOq6Sl+We2P/E27qGXVeo8QZ90vksl1QaOIDCmvqcLW0mPvZf7Nx+1jXiRDOGAJ2P9hdrwlq/Md38Trs3Tvyq7URZm04l0=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(82310400026)(32650700020)(376014)(7416014)(36860700016)(921020)(18002099003)(22082099003)(13003099007)(3613699012)(6133799003)(56012099006)(11063799006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	YJ6nIIgoNZ9ZXPRKSENXBaKc7LvbAeXcU0lnDuLbxNHH4kluMjYL6XYPKVKcEt/gJLjHhKnSwRsBdLKRq/6STk9RXktwOHO588+UPgRAhqeB9vxpKTl4azY43hoBectzRdnjwjtY8lmZQ1xIeKh6N2w26bTzSxHei6hiRojkkKEcgi+hcz+Pg8FcQR3OItqVgSZcTK8B2cQmSRRJF9y5EGE0kZeqeNAK4mNZRI5jDMiFzVzIZ0G2X1ni8Ea3CWLOp9I18Xb8th6OmF9dPObn0uFD+bVPLb8yFICHXaJJRvLY3Nk50rmrpNYv6uV+tY925MabH7kB4NoSnrfo2e0Vpq0MecVwqAU5ukQAvEFa5MWZFzX53/iOyU3dr/djggsJYpbVsC6SYZAZUMgYzGQLn58vvBOs03PPaAIxPggO5zsAhl3ZGCAV3RrPHYTmKa7E
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2026 11:54:43.3082
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4195c3ed-a9e2-4cfa-1f91-08df207bf29f
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM7PEPF00000056.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR02MB6205

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
index 9a3ace3e7fcf9..98cef0058b64c 100644
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
+static const int inv_icm42607_accel_calibbias[] = {
+	-10, 42010, /* Min : -2^11 * 0.0005 * 9.80665	   = -10.042010 m/s²	*/
+	  0,  4903, /* Step: 0.0005 * 9.80665		   = 0.004903 m/s²	*/
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

