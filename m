Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010022.outbound.protection.outlook.com [52.101.84.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2EFD3F54BD;
	Fri,  9 Oct 2026 14:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791555155; cv=fail; b=O8GZaAhhm2qeg4JdeTr5W5N6iOgbiK0Pg0aD66HVdrBneGedAyGSRdcVttfNRgFZlvO4XZFtB2l2awcV4iL90B8pH/3NqtOB1n/MqIpM8aA5kD05pk2vegJu4md1SXr3YF09dXoURFNOul7zD5aklUXvy/lgLbCSdj+5LUiOYA0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791555155; c=relaxed/simple;
	bh=BRyWze2f6WhfTjhzvNs9evgEKhGtIRpUvlLt2rMXTKc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=mO3qP37cg6cq+nMa5UREulo5l7t0w80F3zhYs4TJQ+Qh85OenzGU8YGfQk+4Mh4HGl1YFggNlAyZuvAhRiws/a4jN9KwC+744SW871s3FhIiyG3jDuEhTyOuaepgGsrrlBvZu8u4psslW3O7evHSX1bj0Y56qixu2tpiF4LJWkc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=K9LOYUax; arc=fail smtp.client-ip=52.101.84.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="K9LOYUax"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YlANht6wfTCRP2NQa7tyIPw7r0iTMT7xb2Vv1rB03CfwXv1R6PjvdekJBcwjpcq8zsOrgc2rqpmQ+cCGBqUk4jadii7WfOFw46IGaYMC5gy73xCnXuyd3U9nf/FIz4dbWlrWllHT4yEoQ1rz6wAiXbLo3ONW5BLDNeqGTDjaCQsWn+b5lDGd9f/bzsJVbFseAIJuw7PHbcBL2Uw4xC8DqXoulldk6V5WZ1JxVWfOAflNJ/49sqOGvPQPH1KmHHj5omIHtbLyp9jJZKND3ljXLoQ8kRaeFDKLeiE/d6PcFeB/EgK+EzBEqSVAZqeypaCFUKtiS+c/+Mx2UYOFfaRtFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rHRcrs7QvB/TZvjwvOWwlMq4m50vbSDIKrDhU+2+nz8=;
 b=sumZCuZNIDbKc1kTZfbMkaqoj/u/4CStx+pkBwiylFlpC6b3LnPKyeaMKumAVyVkpUnL/Us4tkeknFu301XAY5BUbQ9hp9E2yQE5hcACGeL848GlGZ4DicWwKZnVp3HXVe7lJIRN0p05p0JPyf0w1NRm1HFCJa7IN/mwP0UVpW7YnWS262NpKoFsn9YZaBXke8//SKUPrCOHwy9WYGm9t3XsmRDgSuQpys88P4Cy8qhgz8o8pWxvDctMEVj82odbqZdLdU28haCkJr9FbLIRZp1tgLj2r+PD1GU3JDxUa4rscVL1Y0Nr4P2jV/wYy7fhlpGYVpksM/Qxsp+AAmCgBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=analog.com smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rHRcrs7QvB/TZvjwvOWwlMq4m50vbSDIKrDhU+2+nz8=;
 b=K9LOYUaxY9yXBYNXP9RTNusst1mN9654pgGB+/w1n6ee26f1Uf8oHfIxBfRV5Dp2RT09UktgHocWHJfFtbYmFjRBYKPCRosHF2tXlmhq6YNSF1Vkqkd4VWR1hHHca8Im5he7+n7+2lKYWpfqiEZgDdvASh85osr7b9lgkRGXt5k=
Received: from DUZPR01CA0226.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b4::13) by PA4PR02MB6653.eurprd02.prod.outlook.com
 (2603:10a6:102:d7::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Fri, 9 Oct
 2026 14:12:29 +0000
Received: from MAD0EPF000008AB.eurprd04.prod.outlook.com
 (2603:10a6:10:4b4:cafe::4c) by DUZPR01CA0226.outlook.office365.com
 (2603:10a6:10:4b4::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Fri, 9
 Oct 2026 14:12:28 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 195.60.68.100) smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 MAD0EPF000008AB.mail.protection.outlook.com (10.167.241.183) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Fri, 9 Oct 2026 14:12:27 +0000
Received: from se-mail10w.axis.com (10.20.40.10) by se-mail11w.axis.com
 (10.20.40.11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.39; Fri, 9 Oct
 2026 16:12:24 +0200
Received: from se-intmail01x.se.axis.com (10.4.0.28) by se-mail10w.axis.com
 (10.20.40.10) with Microsoft SMTP Server id 15.2.1748.39 via Frontend
 Transport; Fri, 9 Oct 2026 16:12:24 +0200
Received: from pc66231-2602.sto.se.axis.com (pc66231-2602.sto.se.axis.com [10.133.4.42])
	by se-intmail01x.se.axis.com (Postfix) with ESMTP id 362B51DDF;
	Fri,  9 Oct 2026 16:12:24 +0200 (CEST)
Received: by pc66231-2602.sto.se.axis.com (Postfix, from userid 21940)
	id 29B4830604F2; Fri,  9 Oct 2026 16:12:24 +0200 (CEST)
From: Kanak Shilledar <kanak.shilledar@axis.com>
Date: Fri, 9 Oct 2026 16:12:08 +0200
Subject: [PATCH v6 3/6] iio: imu: inv_icm42607: Initialize gyro based on
 chip_info
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261009-b4-inv_icm42370p-v6-3-e53884f185ff@axis.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5241;
 i=kanak.shilledar@axis.com; h=from:subject:message-id;
 bh=BRyWze2f6WhfTjhzvNs9evgEKhGtIRpUvlLt2rMXTKc=;
 b=owGbwMvMwCV2JPnG7+2HZqUznlZLYsg68c3dil1n6p4sF9Ggl3tit4hGv3zQyq56KUV1if2NF
 J2pf/m+dpSyMIhxMciKKbKcM9oevT/5n+4caadLMHNYmUCGMHBxCsBE/v9iZNio5VC78wtPh6BY
 eOHGvGbflIi5/meebF04SeVEyhF5yd+MDA8Efe7xrp11azG/+YeOjYt4BGL3VmxvdU5seuuo0li
 1mRcA
X-Developer-Key: i=kanak.shilledar@axis.com; a=openpgp;
 fpr=CDB0F1C8EAD5B522C7B3A77928221FF065DB55F9
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MAD0EPF000008AB:EE_|PA4PR02MB6653:EE_
X-MS-Office365-Filtering-Correlation-Id: b53bcc69-100b-477f-dce1-08df260f598c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|32650700020|36860700016|1800799024|82310400026|3613699012|921020|56012099006|260925021311599003|11063799006|10067099003|260925022911599003|260925021911599003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	JzsCBghQMAL50j8nnOWMYSjd70BERaTRw18WSPgL3A2XJjafsXSQpRC35l5RMm2c9i8ku17ZcOvHmL8SAgz9aO+vWKbWxFTRu2dBiVs5unCS7+UtVDToxAO2nVQeYV8JDP5BE3xW97NV9TmPZ6AGa+sPxXpaDcs4BvmhWUD0t+wCvoUOgGPOO4atPI+KLlpPE4u5tBleN4PFuJRmWRTdAZlo5J/mO3E0ZbQBvDUYXBEdhFGHRZGGOEAqPJSTcgVG/tn2JqUO61WIo+KZ4PDbnrnxEPJqjPgxUU8rxT5me7Qp2mV1z7ir1g0BWB821YzzMJlIcoruNTYu30hD+jOkclZqPr96Ysei/DW1qzxeSSIilkZxZQ+2MxRP9303pBQjDv+KwIzmnHnEkTFYYTrXYx2ktQ32h4v5c0KFvPlORPZuxCzof8ko4chewJaNU+SGBeieifMW4DubfLK1pCrvf/zwyiOwqxeAQAdDjHx+sBByTlrio6jg/Oh3WibpYiIelwlTmO4uFNDpewVN7Oeqcv/BmF9cxuBP/wyMjtSIhMrvzRNs545VjVIUJ0ygRQId+P+/uSJBrVmbf7opGQJSwzkl/Kh2OmjONnfgSzt8FzALn9Srefxm1ZKfDkPW4+WnMbKloq0FUCIZNjLP4hNpdNoAZQz0iLzhE9F6fQzqa/303vqXIPsA+cLtucdH+MpKX5NxAZlTKXlFLLpJhZOwMZ2B1tcoEbysnxyhNzUaZCDIkM4iLAVN7GnwlxIboF/+YW4DX2oA1rFzDv6YKA8Izw==
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(32650700020)(36860700016)(1800799024)(82310400026)(3613699012)(921020)(56012099006)(260925021311599003)(11063799006)(10067099003)(260925022911599003)(260925021911599003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	zsPzTdrSFzKagAuaVm0BOClrz2HgNQUY28yuUMpFTHVNuUWUFbLnV/WQbP1wvck98EI3M/JFzKY1h/OSzHBlRpuRZB4/A8XvwF0TqXregcjFBLa6JZ4DPuzOdSJcpstd9TJm4Mi16zqp9pJdz2AQotZcI9+wu4PV8gm7N/JEep66id5X8jgT5RuJVx9Uv9APflNc92nxwR+6QErEcBVv7l98WYE1RQd/wfEYowwh9ew4s+/3M5OuBVMD9MwR3i1dzbpEK91SDr5Y9FpDNbXbc6zLURgqg8uC9ZChbNzrelzw28GzbB/E+s5Dx7d9oK2ir4cpxYABjdjDk7v9xOHGm58rzinX7taevorlRsWLq6g60K+O61+/j7wXAVSGlsosxAYd0XdN8rq9o9lLSJfIs+gqW/twO//kpRDTYf6OqdFEvxFGnkOAKASdMPrMi6w4
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2026 14:12:27.7820
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b53bcc69-100b-477f-dce1-08df260f598c
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MAD0EPF000008AB.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR02MB6653

Update the chip_info struct with a new `has_gyro` property to support,
devices which do not have gyro functionality. This is a precursor for
adding support for the Invensense, ICM-42370-P. It is similar to the
existing device except it only has accelerometer. Check all operations
related to gyro with the boolean.

Signed-off-by: Kanak Shilledar <kanak.shilledar@axis.com>
---
 drivers/iio/imu/inv_icm42607/inv_icm42607.h      |  1 +
 drivers/iio/imu/inv_icm42607/inv_icm42607_core.c | 57 ++++++++++++++++--------
 2 files changed, 39 insertions(+), 19 deletions(-)

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
index 190e998f7b8ef..46274ecfa7b94 100644
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
 
@@ -160,7 +162,11 @@ int inv_icm42607_get_pwr_mgmt0(struct inv_icm42607_state *st,
 	if (ret)
 		return ret;
 
-	*gyro = FIELD_GET(INV_ICM42607_PWR_MGMT0_GYRO_MODE_MASK, val);
+	if (st->hw->has_gyro)
+		*gyro = FIELD_GET(INV_ICM42607_PWR_MGMT0_GYRO_MODE_MASK, val);
+	else
+		*gyro = INV_ICM42607_SENSOR_MODE_OFF;
+
 	*accel = FIELD_GET(INV_ICM42607_PWR_MGMT0_ACCEL_MODE_MASK, val);
 
 	return 0;
@@ -176,6 +182,10 @@ static int inv_icm42607_set_pwr_mgmt0(struct inv_icm42607_state *st,
 	s64 disable_wait;
 	int ret;
 
+	/* Disable gyro if has_gyro is not set */
+	if (!st->hw->has_gyro)
+		gyro = INV_ICM42607_SENSOR_MODE_OFF;
+
 	ret = inv_icm42607_get_pwr_mgmt0(st, &oldgyro, &oldaccel);
 	if (ret)
 		return ret;
@@ -417,29 +427,37 @@ static int inv_icm42607_set_init_conf(struct inv_icm42607_state *st,
 	unsigned int val;
 	int ret;
 
-	val = FIELD_PREP(INV_ICM42607_PWR_MGMT0_GYRO_MODE_MASK, conf->gyro.mode);
-	val |= FIELD_PREP(INV_ICM42607_PWR_MGMT0_ACCEL_MODE_MASK, conf->accel.mode);
+	if (st->hw->has_gyro)
+		val = FIELD_PREP(INV_ICM42607_PWR_MGMT0_ACCEL_MODE_MASK, conf->accel.mode) |
+		      FIELD_PREP(INV_ICM42607_PWR_MGMT0_GYRO_MODE_MASK, conf->gyro.mode);
+	else
+		val = FIELD_PREP(INV_ICM42607_PWR_MGMT0_ACCEL_MODE_MASK, conf->accel.mode);
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
+		val = FIELD_PREP(INV_ICM42607_GYRO_CONFIG0_FS_SEL_MASK, conf->gyro.fs) |
+		      FIELD_PREP(INV_ICM42607_GYRO_CONFIG0_ODR_MASK, conf->gyro.odr);
+		ret = regmap_write(st->map, INV_ICM42607_REG_GYRO_CONFIG0, val);
+		if (ret)
+			return ret;
+	}
 
-	val = FIELD_PREP(INV_ICM42607_ACCEL_CONFIG0_FS_SEL_MASK, conf->accel.fs);
-	val |= FIELD_PREP(INV_ICM42607_ACCEL_CONFIG0_ODR_MASK, conf->accel.odr);
+	val = FIELD_PREP(INV_ICM42607_ACCEL_CONFIG0_FS_SEL_MASK, conf->accel.fs) |
+	      FIELD_PREP(INV_ICM42607_ACCEL_CONFIG0_ODR_MASK, conf->accel.odr);
 	ret = regmap_write(st->map, INV_ICM42607_REG_ACCEL_CONFIG0, val);
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
@@ -635,10 +653,11 @@ int inv_icm42607_core_probe(struct regmap *regmap,
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

