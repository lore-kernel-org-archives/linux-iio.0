Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010004.outbound.protection.outlook.com [52.101.69.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4913493640;
	Fri,  2 Oct 2026 11:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790942104; cv=fail; b=YwwquNb6WUqU8nGfpxr4r7dRMw5nOJs8m07NWlrG6hbmnSUTqWO4tkvqUflAkjZ29ZBtp+S6RbYGyTnzVjQ1yOuHdc9KDtRSs4MS32MhJkzGcUvsBJbxpJpwOAqupU+EGe0OAbQkYfCxr4Yh3uIZ2f0tBe/ayYpEYa91OOjP1oo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790942104; c=relaxed/simple;
	bh=cNzK/7ZmJvesM5/Mxx293MS0eeZZQ+wCNFvrBDqMbZg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=kzrzgGIh4UI5DvaBQU0I/sbHOchCgMcb40ml4xe7+ecfjm1P2CI0+Uz/b6H+3Oew5oFyLX4oKaPOJeY1IOjmyNbS0/Nl4YdNsft1O64NncuUzJ7QpZKgqWDUzStRBXuXAE8X5AkLaJYKSNVrnQ/oWmLIJQNlDRAtxH94RGF7xsQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=PRBp7Vpe; arc=fail smtp.client-ip=52.101.69.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="PRBp7Vpe"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lMAghvX+t4mcIZPt6VpIYaaYykulVfTOWunVXcrLRKOEq2Z8llxHzGVK4idaa7aLQEtWujZFeIynX1ZDXLKVhMVo9nt9BFTKqh4IbvLUOabv9eHbb+V7tJI57F6OYMztOI2ClUDzPc5riDydySY2FcsbIkmuPCC2tvkC9S/agGFOI05m+3E+Bk78vq4VsXg+M/HSASpEoQ+BCXqgcxxdfJGlj8ghX1FVPuyc7OoWaRw+L5eIzYpZ/IUqT7eSqzBFLCXO7+oDSM/F0dR1EvTc7LC7RLoPYrEJwJvLnH0pQMZZtxvpNTKbnCZG2LrHe8FbMGljcNR4AMe9dXnz54dXuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y0GYVzV84w7KxPyNIuxgijCD9jab1mnSyLbzI5v8HJk=;
 b=aGM4GtwNtXfTNgDxKJk778xj8dQJ0T9ldXPLjEXHcJK8U78K/JaTtx10re/C1ZaTgdcu0D1qtGkN0IueK1sichNx6xcn+GVP00NoipJmGEki+4N8YQ1+VcZXpnWaK4kjkB67xbxfMfQMXIIk9FNStDFn8Hc0WSE018mZQ5CxIiTdiy9PXdi95Dw/MEqEzzEa1PRMxyLWh4UDN3Nw0IN7sSUGkgnFTNv35kS69G+cg/Kuj4lqIXVpuQK//H/BdEyrtRHOgGwhp8db7UFVJJ3OuEAstNJU2BqBFWFJBlO9FF52ZeLrXwEs/0a3YtzxtveXEYU7L4/yJvEOrD9xgE0lBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=analog.com smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y0GYVzV84w7KxPyNIuxgijCD9jab1mnSyLbzI5v8HJk=;
 b=PRBp7VpeLyg5GP6v9xTbigg9lkkghJ/Pn3Gk3md6kOWhuAwzwVTBqjNSbW7AFPpGCUCPDIqADmaZIbyiSK5QutZFZWff48tRLnznWW10TPd52boDiMRFtAJe5ZmBF19gtOF+2tOKh5rDuUqzUVOAXNtqDkExwvEVFJlDraY/g4g=
Received: from PAYP264CA0031.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:11f::18)
 by GVUPR02MB11928.eurprd02.prod.outlook.com (2603:10a6:150:35e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Fri, 2 Oct
 2026 11:54:51 +0000
Received: from MAD0EPF000008C2.eurprd05.prod.outlook.com
 (2603:10a6:102:11f:cafe::58) by PAYP264CA0031.outlook.office365.com
 (2603:10a6:102:11f::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.18 via Frontend Transport; Fri, 2
 Oct 2026 11:54:51 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 195.60.68.100) smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 MAD0EPF000008C2.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Fri, 2 Oct 2026 11:54:50 +0000
Received: from se-mail10w.axis.com (10.20.40.10) by se-mail10w.axis.com
 (10.20.40.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.39; Fri, 2 Oct
 2026 13:54:40 +0200
Received: from se-intmail02x.se.axis.com (10.4.0.28) by se-mail10w.axis.com
 (10.20.40.10) with Microsoft SMTP Server id 15.2.1748.39 via Frontend
 Transport; Fri, 2 Oct 2026 13:54:40 +0200
Received: from pc66231-2602.sto.se.axis.com (pc66231-2602.sto.se.axis.com [10.133.4.42])
	by se-intmail02x.se.axis.com (Postfix) with ESMTP id 6B3A0B49;
	Fri,  2 Oct 2026 13:54:40 +0200 (CEST)
Received: by pc66231-2602.sto.se.axis.com (Postfix, from userid 21940)
	id 54CD4305CE17; Fri,  2 Oct 2026 13:54:40 +0200 (CEST)
From: Kanak Shilledar <kanak.shilledar@axis.com>
Date: Fri, 2 Oct 2026 13:54:27 +0200
Subject: [PATCH v5 3/6] iio: imu: inv_icm42607: Initialize gyro based on
 chip_info
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261002-b4-inv_icm42370p-v5-3-c65281b745c9@axis.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4299;
 i=kanak.shilledar@axis.com; h=from:subject:message-id;
 bh=cNzK/7ZmJvesM5/Mxx293MS0eeZZQ+wCNFvrBDqMbZg=;
 b=owGbwMvMwCV2JPnG7+2HZqUznlZLYsjaP7v+6FQRvv1KXMYih/avzl12rcTEc+oFmQnHuOYfy
 rFwmRLyu6OUhUGMi0FWTJHlnNH26P3J/3TnSDtdgpnDygQyhIGLUwAmwrKOkWHmsy0S2uopN75P
 2l48I2OlTrHi6tC+PZukvL6vNM59XPubkeFrma1HuVbv5EqJhdcalr2ecO9hlPUVxWmlbPz3t0w
 3WMABAA==
X-Developer-Key: i=kanak.shilledar@axis.com; a=openpgp;
 fpr=CDB0F1C8EAD5B522C7B3A77928221FF065DB55F9
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MAD0EPF000008C2:EE_|GVUPR02MB11928:EE_
X-MS-Office365-Filtering-Correlation-Id: 02ac82ac-705a-488a-02ba-08df207bf736
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|32650700020|36860700016|1800799024|23010399003|10067099003|260925021311599003|56012099006|260925021911599003|260925022911599003|22082099003|18002099003|11063799006|921020|3613699012;
X-Microsoft-Antispam-Message-Info:
	vP8TZ0LWNEXABOLJwAde4HXogMGdPYJ3ybMc7onQ+ckXcIhR564FT5Mgarnnc3GtH/JU3werHgfNWZgTpx9Kvy9ypbZdtcr+hL6eqp9m+qOIdahDEB13LlrIWmmI+1Z6uRgYsmBxwGYFml4g8crIaM4nKXJsoD0J+43hDrqjYUcqXoZYh531wMCQ7EyehNwYTcNQnFNUjkHevCT5xiAaONnbWfHIYBwZQ4oyKZs7KSSc9ugdUzrJuHnbzu7ZQioLrLSwu7CgJ+ROQzOpuFW5u7CNl5IZN8xH5Mh4gzhNvCLjfxD37+Zb0hhqinVAaRqx36HiuRt4z1oWxlAnsn/ceLOofs3TcvjrB82O5zeIxqX5c0ywQ08jYndWkNuCzLYK/cn3M4eEYEfgolwhYAY+tncG0KJWgn7LKtkA852sGKXFvp3Nk+g5l9C6hcllBhl75JnOPoKOqHCVprwXLT1otYgBqzfu6EQRD3BiPKKCJMmXM6L73G3T2ov5M62BXnn8Al2j3GwDZFHE/vEC+ptYyNnvLI9FlK/8o34INbvlv94XyvSqNRSpSRsZp8W2NLp3HGut3o9oZTfBJJQNnOjtmUOjbwe8dm1vp15RzOz2OehrJEdbBHqjVuUaIvHDfycEYpVWAnyfZll/kzXMuccgphD+vpZNf9kErR3g9Dt7xE0glsOef73Iy7SwkBl+4IAWTEUOx81sNzLYtNfShB2Ei52agbZQHj/ub7egugfNvNZFZMOlONX9yuSx+zAeqM1vpyyb2IO0n8MwgVasWQmXKw==
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(32650700020)(36860700016)(1800799024)(23010399003)(10067099003)(260925021311599003)(56012099006)(260925021911599003)(260925022911599003)(22082099003)(18002099003)(11063799006)(921020)(3613699012);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	BW/VQkL8IgTminFHUK4cJdLk8590ZPqJK38anfwgOU4K4iekhe9Q9umfsG5jn2Z1M6f9XFEWt0tiaWtbkdvCtfCTTqdimxtAF0IGkXpdYg8NWIXKtrLyh0e5lC0owXCkDgfeQvyXCIqT/7B0Yg5BDqSc2RPqVTGAW1rVPS+Scar+wvYXlP4C4ohfFR07kOqIwSZo3ffzHYJjZCFAGQrjBTbXYRYB/T2cLc3K5+mPd+UOPNuNicywRo8nynQ90nwYXjQ4oOt6QMMLFUSGCSVpC25fLfzMQqYjdjJlHfsKlYrihQQPj89QMRtS4TXNoXREAWYWA9w4ldPO6AG4eQ48TQ4Ic6W+JieGJaqTyN5DjswSiE1lQpgWITTOMuaVNCiTDzbLq1tLopGIEVIF9UXwq/rkK76CgXeCQyHfC4cIDzxOWGyNxI8YylZST00m30aN
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2026 11:54:50.9641
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 02ac82ac-705a-488a-02ba-08df207bf736
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MAD0EPF000008C2.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVUPR02MB11928

Update the chip_info struct with a new `has_gyro` property to support,
devices which do not have gyro functionality. This is a precursor to the
next commit which adds support for the Invensense, ICM-42370-P. It is
similar to the existing device except it only has accelerometer. Check
all operations related to gyro with the boolean.

Signed-off-by: Kanak Shilledar <kanak.shilledar@axis.com>
---
 drivers/iio/imu/inv_icm42607/inv_icm42607.h      |  1 +
 drivers/iio/imu/inv_icm42607/inv_icm42607_core.c | 41 +++++++++++++++---------
 2 files changed, 26 insertions(+), 16 deletions(-)

diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607.h b/drivers/iio/imu/inv_icm42607/inv_icm42607.h
index 4d51b0da1aa16..e4075288247b8 100644
--- a/drivers/iio/imu/inv_icm42607/inv_icm42607.h
+++ b/drivers/iio/imu/inv_icm42607/inv_icm42607.h
@@ -130,6 +130,7 @@ struct inv_icm42607_hw {
 	const char *name;
 	const struct inv_icm42607_conf *conf;
 	u8 whoami;
+	bool has_gyro;
 };
 
 /**
diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c b/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c
index 190e998f7b8ef..d974cba66e1be 100644
--- a/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c
+++ b/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c
@@ -96,6 +96,7 @@ const struct inv_icm42607_hw inv_icm42607_hw_data = {
 	.whoami = INV_ICM42607_WHOAMI,
 	.name = "icm42607",
 	.conf = &inv_icm42607_default_conf,
+	.has_gyro = true,
 };
 EXPORT_SYMBOL_NS_GPL(inv_icm42607_hw_data, "IIO_ICM42607");
 
@@ -103,6 +104,7 @@ const struct inv_icm42607_hw inv_icm42607p_hw_data = {
 	.whoami = INV_ICM42607P_WHOAMI,
 	.name = "icm42607p",
 	.conf = &inv_icm42607_default_conf,
+	.has_gyro = true,
 };
 EXPORT_SYMBOL_NS_GPL(inv_icm42607p_hw_data, "IIO_ICM42607");
 
@@ -417,17 +419,21 @@ static int inv_icm42607_set_init_conf(struct inv_icm42607_state *st,
 	unsigned int val;
 	int ret;
 
-	val = FIELD_PREP(INV_ICM42607_PWR_MGMT0_GYRO_MODE_MASK, conf->gyro.mode);
-	val |= FIELD_PREP(INV_ICM42607_PWR_MGMT0_ACCEL_MODE_MASK, conf->accel.mode);
+	val = FIELD_PREP(INV_ICM42607_PWR_MGMT0_ACCEL_MODE_MASK, conf->accel.mode);
+	if (st->hw->has_gyro)
+		val |= FIELD_PREP(INV_ICM42607_PWR_MGMT0_GYRO_MODE_MASK, conf->gyro.mode);
+
 	ret = regmap_write(st->map, INV_ICM42607_REG_PWR_MGMT0, val);
 	if (ret)
 		return ret;
 
-	val = FIELD_PREP(INV_ICM42607_GYRO_CONFIG0_FS_SEL_MASK, conf->gyro.fs);
-	val |= FIELD_PREP(INV_ICM42607_GYRO_CONFIG0_ODR_MASK, conf->gyro.odr);
-	ret = regmap_write(st->map, INV_ICM42607_REG_GYRO_CONFIG0, val);
-	if (ret)
-		return ret;
+	if (st->hw->has_gyro) {
+		val = FIELD_PREP(INV_ICM42607_GYRO_CONFIG0_FS_SEL_MASK, conf->gyro.fs);
+		val |= FIELD_PREP(INV_ICM42607_GYRO_CONFIG0_ODR_MASK, conf->gyro.odr);
+		ret = regmap_write(st->map, INV_ICM42607_REG_GYRO_CONFIG0, val);
+		if (ret)
+			return ret;
+	}
 
 	val = FIELD_PREP(INV_ICM42607_ACCEL_CONFIG0_FS_SEL_MASK, conf->accel.fs);
 	val |= FIELD_PREP(INV_ICM42607_ACCEL_CONFIG0_ODR_MASK, conf->accel.odr);
@@ -435,11 +441,13 @@ static int inv_icm42607_set_init_conf(struct inv_icm42607_state *st,
 	if (ret)
 		return ret;
 
-	val = FIELD_PREP(INV_ICM42607_GYRO_CONFIG1_FILTER_MASK, conf->gyro.filter);
-	ret = regmap_update_bits(st->map, INV_ICM42607_REG_GYRO_CONFIG1,
-				 INV_ICM42607_GYRO_CONFIG1_FILTER_MASK, val);
-	if (ret)
-		return ret;
+	if (st->hw->has_gyro) {
+		val = FIELD_PREP(INV_ICM42607_GYRO_CONFIG1_FILTER_MASK, conf->gyro.filter);
+		ret = regmap_update_bits(st->map, INV_ICM42607_REG_GYRO_CONFIG1,
+					INV_ICM42607_GYRO_CONFIG1_FILTER_MASK, val);
+		if (ret)
+			return ret;
+	}
 
 	val = FIELD_PREP(INV_ICM42607_ACCEL_CONFIG1_FILTER_MASK, conf->accel.filter);
 	ret = regmap_update_bits(st->map, INV_ICM42607_REG_ACCEL_CONFIG1,
@@ -635,10 +643,11 @@ int inv_icm42607_core_probe(struct regmap *regmap,
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

-- 
2.43.0

