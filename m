Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013015.outbound.protection.outlook.com [40.107.159.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86C44318EFF;
	Tue,  1 Sep 2026 14:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788273374; cv=fail; b=tTVUwxKf11WeZNgfLUzsl7AAcymYyG4K9bHYft141Fv+N815XYLgv+Ebl2CUw/vbskokI0Mlvp6PHhN+bM/Q7ufrz7+sDWuQY+3EIy06FwyxtcZzJhhewL3pP0I9S/AE3qC97Bz/WhEY7FaBf7Yf54gK2W+8IuO+n7/8aABXDOg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788273374; c=relaxed/simple;
	bh=sr51mA9NbXRfrp1Uzexr6FNQs5IK4u2wFcikDyF0AnI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=Cv1u3MjrEFK4T0nK/CnBp6QLdqh/1VJdgKjvAL1IXkYsLGEHsTUWrUrPzfSVrTjQ703+pNsGREVO/0l5z5u2ahNgLNYFD4YWmXseP7QW/gogcoscstYIGdwljhp0zXsydNtzRy4ZL486tV2YhIfFRnYjcwThomjHaUHY4b2w3mQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=OMUS1a2B; arc=fail smtp.client-ip=40.107.159.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="OMUS1a2B"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l4kaSKpdjz22WDAHYrC+KBC70j6ug6mmtlJqGDjVYtQ51LrbuCEvzEyzH5/qVzArNRgW/2HSYj5RZfsdyOUmudnB5nOTmz6wi0P8bvJ/4+ZkdDZ4zHow3mLEwsGl25MCGRfiFceHSh3KuUkgaNcNQ3Osob2f+ava/sotg/VXUMUHUVIRcJEFIX08FzjMgiIg5mEtCoIqCSUC+QvdRm/VZF5QTBkfTSpEdgp9NSKJLtJrBhHX+prIPRxwy5s02F1F2C0gnQ1yR+RbSxKlS8u/KTsS5o3SgUGtsz8PG5SWVPoEGObA8yCskmrT7IpS09IkKLf06yhPFoLkdxgEmjdtiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y1tiApY5nOurBRoWduMULkyGkJPmDZLxQXmq6IVgqeQ=;
 b=FQJiXyJmHi/mWD9YeN+Te/WkcKPxousmvVEZWyLp1FhGfAAhI1u56bGjvWZma9agvjMdYPPH2IwPmLKzNIqIs4ukOjSk5Uo+zNdS0rRTp8RHRIv+Nf/q/upGCbwwiMOUxeNgx74wKF1uXxYVK2zkJvWwemxCZMCQJWPm76CVlp05xFpnSers4QkJrOc2XTYCf5vb2LvhCyEZonmMcp6WMaP791YfZQZODYaCOX7nNcWqhiILoSCWjsHaPp8EkRScKVefLbcClcUuUZDHbkBpPiySs6OyzsqLB84GOdKAP/e/LnPGAA7EX9mv0yO42g7Vihl+d7rKf4lSKyfZfHQWJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=analog.com smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y1tiApY5nOurBRoWduMULkyGkJPmDZLxQXmq6IVgqeQ=;
 b=OMUS1a2ByjrLfEOldBfqidol6REH1QNF1/paEwA7GFXKdKNVzgBHF/Q24en2IAY4b1AjIffC1nzaOCKrSh7774XYCL+BMf3qmh5w3UYlqdCrFzYj69eNfdBIeRauXK14HflV8sE2F5w2ZeuvOGHuH8x1UNXlFw+VMS5Nf/+GRyw=
Received: from AS4P190CA0069.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:656::15)
 by AMCPR02MB12428.eurprd02.prod.outlook.com (2603:10a6:20b:771::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 14:36:06 +0000
Received: from AMS1EPF0000004B.eurprd04.prod.outlook.com
 (2603:10a6:20b:656:cafe::c) by AS4P190CA0069.outlook.office365.com
 (2603:10a6:20b:656::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.10 via Frontend Transport; Tue, 1
 Sep 2026 14:36:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 AMS1EPF0000004B.mail.protection.outlook.com (10.167.16.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Tue, 1 Sep 2026 14:36:06 +0000
Received: from se-mail10w.axis.com (10.20.40.10) by se-mail11w.axis.com
 (10.20.40.11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.39; Tue, 1 Sep
 2026 16:36:04 +0200
Received: from se-intmail01x.se.axis.com (10.4.0.28) by se-mail10w.axis.com
 (10.20.40.10) with Microsoft SMTP Server id 15.2.1748.39 via Frontend
 Transport; Tue, 1 Sep 2026 16:36:04 +0200
Received: from pc66231-2602.sto.se.axis.com (pc66231-2602.sto.se.axis.com [10.133.4.42])
	by se-intmail01x.se.axis.com (Postfix) with ESMTP id 9D56A4D08;
	Tue,  1 Sep 2026 16:36:04 +0200 (CEST)
Received: by pc66231-2602.sto.se.axis.com (Postfix, from userid 21940)
	id 79EF2305CBCD; Tue,  1 Sep 2026 16:36:04 +0200 (CEST)
From: Kanak Shilledar <kanak.shilledar@axis.com>
Date: Tue, 1 Sep 2026 16:36:00 +0200
Subject: [PATCH v3 7/8] iio: imu: inv_icm42607: Add accelerometer calibbias
 support
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20260901-b4-inv_icm42370p-v3-7-77cc31642115@axis.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=9298;
 i=kanak.shilledar@axis.com; h=from:subject:message-id;
 bh=sr51mA9NbXRfrp1Uzexr6FNQs5IK4u2wFcikDyF0AnI=;
 b=owGbwMvMwCV2JPnG7+2HZqUznlZLYsia9uiKp+SrZHN5z/PFBw+vW+r9Q+eMz2zurNzKjxe22
 xTf+W/7oKOUhUGMi0FWTJHlnNH26P3J/3TnSDtdgpnDygQyhIGLUwAmYhzG8N+7senapmOFewNt
 MpNndFne3XOf7XBGsdHSGSkzCurNZTsZ/ikVb53ePDH+I9s6g1tuLOfLY1bZTZN5/tpi/jcV2Xl
 8+5gA
X-Developer-Key: i=kanak.shilledar@axis.com; a=openpgp;
 fpr=CDB0F1C8EAD5B522C7B3A77928221FF065DB55F9
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS1EPF0000004B:EE_|AMCPR02MB12428:EE_
X-MS-Office365-Filtering-Correlation-Id: 84a1c0f6-f1dc-49de-f2b4-08df08365b7f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700016|32650700020|23010399003|7416014|376014|6133799003|18002099003|22082099003|13003099007|56012099006|11063799006|3613699012|10067099003|921020;
X-Microsoft-Antispam-Message-Info:
	YyooMUlAv0p9YXRcaoJHsVFMkUwqm0O46Mnb0A+25Oeu6DIcNTqxeJOfEQiwWxBhY602fywNS3ztZA8+BWszEcJuyecZGnuRZlY+mgV+2kd4KmuD89cW3dkinDxdFeZZYUzRJe4hh+yI8pDY0s+9SpBr8xxGUmKujmiVkFm/BNPboKNkKISt5KDctz1ozlikyB4o0Zi08ewT/d2zyoZhnqdvWTWYpeQ4y0XMBlUqtaFLBj0daUqPZ3nw5nTRdlvaXf9eEs+HQA5ElXgSfZ/jqg25cg5QO965vtGWxNmjcWb227KlonNC1hOoXY/2nQ4gp3H4fgAggj0jYICPpLU82z5+9TEINM5iRUpwLnw3Et/F9usoXP+lYxyv/GHA9xoYyghKr8Cl+srHJ7enmGHcXdQPX0JXhBCttWAQSBdyiDcDFm/8jo/AoneC3TlFcC5EekoWyH6tItjL+0ntpT/mW7Ck+0CTxseRYRhGtgNG6Oy+ufF/27EzfOvw8hG3Yo/YrIpnAQo/eb5f4x3oGozmvINseBTCSi063vkf2EJr/LmIkWyAy5ZQFUyyzNSq0aUcZI19qloxepg+LY6xCzL5bygYsqkgGwBrLRYPzZXXc3qMjXp8QPgJgOONRTV8HfXgeo/ersRPkAM72ktjySBAXytyhq0DulB0UfbZRmN/xeyOXkOeuPQETj9srbG2G0XwxA7QoGjP4NKmLyXaDCPyvN0YEw2hCWKXNYYyXHxkVig=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700016)(32650700020)(23010399003)(7416014)(376014)(6133799003)(18002099003)(22082099003)(13003099007)(56012099006)(11063799006)(3613699012)(10067099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	7SGeQVZub4Q763qqmKVidEfFf31vZ2dp6tBEiELDKTYZGOSlUQ/TMyOU1BCTMz2Ulfv8nYpmJ4jGOXH2EPS58gmGIn0KFY8buuQGVARwvnmZaIMtqvaogOmpfnFwN7L10kLFxD7ZO4nkBF6VTeU+UkbAke3lgB1r0ioxcxblqWCF6jODjvgdxE8ELxyGvTB+bdwUEvPI1GQZ60qtQGIWQxJ3W3O5GDqCcPbGYttXsSKGafRuU8e/SmugZscNZoqdbjP0DvrY39DVTp86f9vQ83DzerNOsVyuVbwaNpvqvx9zd0Xl/QHLg8Y5ibW9zI7DSqGZx/bRSq5i+u10D2qE80+B3JEHsNCVs7RvaWnthiZLiEK1GIR75Kqg4cNwwCzh0OJucc9MzonTK5gH7phtsaZV7u3PxRRGlPlTCnR1DsmudU4QlRqa9jzWS+ERWx9u
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 14:36:06.5880
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 84a1c0f6-f1dc-49de-f2b4-08df08365b7f
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS1EPF0000004B.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMCPR02MB12428

Expose IIO_CHAN_INFO_CALIBBIAS on the accelerometer channels. The
registers are stored in MREG1, which can be accessed by the mreg_read
and mreg_write routines. The calibration bias is written to OFFSET_USER4
to OFFSET_USER8 registers in MREG1.

Note: The accelerometer functionality is tested with Invensense,
ICM42370-P development board.

Datasheet: https://www.invensense.tdk.com/en-us/products/3-axis/icm-42370-p
Datasheet: https://www.lcsc.com/product-detail/C5129967.html
Signed-off-by: Kanak Shilledar <kanak.shilledar@axis.com>
---
 drivers/iio/imu/inv_icm42607/inv_icm42607_accel.c | 238 +++++++++++++++++++++-
 1 file changed, 236 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607_accel.c b/drivers/iio/imu/inv_icm42607/inv_icm42607_accel.c
index 318373efeb9e..af2ac9d6a47c 100644
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
+	  0,  4903, /* Step: 0.5 * 0.00980655		   = 0.004903 m/s²	*/
+	 10, 37106, /* Max : (2^11 - 1) * 0.0005 * 9.80665 = 10.037106 m/s²	*/
+};
+
 static const int inv_icm42607_accel_scale_nano[][2] = {
 	[INV_ICM42607_ACCEL_FS_16G] = { 0, 4788403 },
 	[INV_ICM42607_ACCEL_FS_8G] = { 0, 2394202 },
@@ -176,6 +189,221 @@ static int inv_icm42607_accel_write_odr(struct iio_dev *indio_dev,
 	return inv_icm42607_set_sensor_conf(st, &conf, IIO_ACCEL);
 }
 
+static int inv_icm42607_accel_read_offset(struct inv_icm42607_state *st,
+		struct iio_chan_spec const *chan, int *val, int *val2)
+{
+	struct device *dev = regmap_get_device(st->map);
+	u8 buffer_data[2];
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
+	ret = inv_icm42607_mreg_read(st, INV_ICM42607_MREG1, reg, &buffer_data[0]);
+	if (ret)
+		return ret;
+
+	ret = inv_icm42607_mreg_read(st, INV_ICM42607_MREG1, reg + 1,
+				     &buffer_data[1]);
+	if (ret)
+		return ret;
+
+	/* 12 bits signed value */
+	switch (chan->channel2) {
+	case IIO_MOD_X:
+		offset = sign_extend32(((buffer_data[0] & 0xF0) << 4) | buffer_data[1], 11);
+		break;
+	case IIO_MOD_Y:
+		offset = sign_extend32(((buffer_data[1] & 0x0F) << 8) | buffer_data[0], 11);
+		break;
+	case IIO_MOD_Z:
+		offset = sign_extend32(((buffer_data[0] & 0xF0) << 4) | buffer_data[1], 11);
+		break;
+	default:
+		return -EINVAL;
+	}
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
+	u8 hi, lo, regval;
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
+	/* Clamp value limited to 12 bits signed */
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
+		/* OFFSET_USER4 register is shared */
+		ret = inv_icm42607_mreg_read(st, INV_ICM42607_MREG1,
+				INV_ICM42607_REG_OFFSET_USER4, &regval);
+		if (ret)
+			return ret;
+
+		hi = ((offset & 0xF00) >> 4) | (regval & 0x0F);
+		lo = offset & 0xFF;
+
+		ret = inv_icm42607_mreg_write(st, INV_ICM42607_MREG1,
+				INV_ICM42607_REG_OFFSET_USER4, hi);
+		if (ret)
+			return ret;
+
+		ret = inv_icm42607_mreg_write(st, INV_ICM42607_MREG1,
+					      INV_ICM42607_REG_OFFSET_USER5, lo);
+
+		if (ret)
+			return ret;
+		break;
+
+	case IIO_MOD_Y:
+		/* OFFSET_USER7 register is shared */
+		ret = inv_icm42607_mreg_read(st, INV_ICM42607_MREG1,
+					     INV_ICM42607_REG_OFFSET_USER7,
+					     &regval);
+		if (ret)
+			return ret;
+
+		lo = offset & 0xFF;
+		hi = ((offset & 0xF00) >> 8) | (regval & 0xF0);
+
+		ret = inv_icm42607_mreg_write(st, INV_ICM42607_MREG1,
+					      INV_ICM42607_REG_OFFSET_USER7,
+					      hi);
+		if (ret)
+			return ret;
+
+		ret = inv_icm42607_mreg_write(st, INV_ICM42607_MREG1,
+					      INV_ICM42607_REG_OFFSET_USER6,
+					      lo);
+		if (ret)
+			return ret;
+		break;
+
+	case IIO_MOD_Z:
+		/* OFFSET_USER7 register is shared */
+		ret = inv_icm42607_mreg_read(st, INV_ICM42607_MREG1,
+					     INV_ICM42607_REG_OFFSET_USER7,
+					     &regval);
+		if (ret)
+			return ret;
+
+		hi = ((offset & 0xF00) >> 4) | (regval & 0x0F);
+		lo = offset & 0xFF;
+
+		ret = inv_icm42607_mreg_write(st, INV_ICM42607_MREG1,
+					      INV_ICM42607_REG_OFFSET_USER7, hi);
+		if (ret)
+			return ret;
+
+		ret = inv_icm42607_mreg_write(st, INV_ICM42607_MREG1,
+					      INV_ICM42607_REG_OFFSET_USER8, lo);
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
 static int inv_icm42607_accel_read_raw(struct iio_dev *indio_dev,
 				       struct iio_chan_spec const *chan,
 				       int *val, int *val2, long mask)
@@ -207,6 +435,8 @@ static int inv_icm42607_accel_read_raw(struct iio_dev *indio_dev,
 		return inv_icm42607_accel_read_scale(indio_dev, val, val2);
 	case IIO_CHAN_INFO_SAMP_FREQ:
 		return inv_icm42607_accel_read_odr(st, val, val2);
+	case IIO_CHAN_INFO_CALIBBIAS:
+		return inv_icm42607_accel_read_offset(st, chan, val, val2);
 	default:
 		return -EINVAL;
 	}
@@ -250,6 +480,8 @@ static int inv_icm42607_accel_write_raw(struct iio_dev *indio_dev,
 		return ret;
 	case IIO_CHAN_INFO_SAMP_FREQ:
 		return inv_icm42607_accel_write_odr(indio_dev, val, val2);
+	case IIO_CHAN_INFO_CALIBBIAS:
+		return inv_icm42607_accel_write_offset(indio_dev, chan, val, val2);
 	default:
 		return -EINVAL;
 	}
@@ -266,6 +498,8 @@ static int inv_icm42607_accel_write_raw_get_fmt(struct iio_dev *indio_dev,
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

