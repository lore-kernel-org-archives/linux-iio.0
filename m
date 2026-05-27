Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012026.outbound.protection.outlook.com [52.101.43.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F9EE3FD955;
	Wed, 27 May 2026 11:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779882161; cv=fail; b=JUq+qGjmD+zOYGD2fr8/VAMMLIGi9ASKrTiX5I0lpPW0sLF+YbTDaNuvTU3823EoVUgpmExuqhhrslKOmc2b9tg/TU5iYcb7s5TbyOOlZdBmAKg6suxEEkcG3jVNYE4qBHc0MtaILeeVtu25/UBP8v9ECluRw0LWkY5r6E5+ziU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779882161; c=relaxed/simple;
	bh=i7g48ZJHXCtoAnePf0JHxrhfCvenyOkOKXozI2NfYzU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eUR7Jp105BLhIgH70guY62zdUvVTVZQ9GgSa49p2LvQsqJ5A99oNCYlKgNd/LjcGrlF/dQXIICEEcx1SYW96++XUWWNbgff/xpxKyuFsxm4LB3MX8mnQwQ32G+MyStFiSr5dU5BcjwKUgxyTc0Q0NLnko1ahbgPwXC3H5CPnDmg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=IsypZc9D; arc=fail smtp.client-ip=52.101.43.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="IsypZc9D"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LAm6F7DZogWNwRNu2Rw0eOanipmNFK5J73w2MjhD1UaswZ/aTZlTT7w4Wnb6M6Y0fxu5D250kDTEgOtfL+/8Pmb67swZ1O0Fy4UC88o0mPA+Ym0yMc4LkAh6QY5CfdhyCL3Gj4tsa00mMX03VvzvsMOiuRVKUq+Y72BtItWdLCi0xeY8mG6pc7yKg+tGsGyRlkvrOznBugZnZ1zymUkLh+0KRgqO8ncO/JMjvMxPxPYELhyd54RE3TpGm/o9TG6ylnIYfD99Z5cWNjcIUtDynxNR8ZxV/sJMKpA6gLBCiw1EsLKBgnyn+tqSWVjRUioyzkUusNgn6d6IPK34BPDnBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3p1vOD7YUM8aNyyN6vsZw21rDrvZLCpNMV/feSaNrQs=;
 b=mjdExn+zNY+nVQxueOysFLsCO8yFkqt+wYlbI+wSNtV8SQJzZBV1uuponOndek9v38Tx+dn2u220ModhR1p6e92Klg85EPf60aXjI7hIFPz6VCkg6iw0WgYwBW5igRljhV/qrMXjIlOtFK8FM2mP4sol5KXsr2FXdqAOJEmqmo629vpEGwA9xu7VcLzIKLcrg9mAwkkepFlzdiHPEX7uS2FT6O2UNBV213B5VVCDi4JxMZMlMCO403RQ3x5UTeQlwiMeQQkEuQhCBElMbtSaeuTsI9CufbLNiI1h6KrHH1xvLa7lnXl1FmGhc6iK52vOX0dyzYYMyBmO8WSAbSFt5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3p1vOD7YUM8aNyyN6vsZw21rDrvZLCpNMV/feSaNrQs=;
 b=IsypZc9DKU68hsqwwrP6kYQbKM8vrw9SJ5xeXIBkvzd039w2R7549KI7QFzV8TRIY/vV3d+CSTE45Obj2C7poBxh/hQHWlXUG+AywQ5temnA0TWHD5hWnD6YHEiMIvfpmwGoc1LzEydWw6lh+/LKIY323ui80w7cV1Gp3Cnd9Tw=
Received: from BY3PR03CA0023.namprd03.prod.outlook.com (2603:10b6:a03:39a::28)
 by SJ1PR12MB6266.namprd12.prod.outlook.com (2603:10b6:a03:457::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Wed, 27 May
 2026 11:42:29 +0000
Received: from SJ1PEPF00002322.namprd03.prod.outlook.com
 (2603:10b6:a03:39a:cafe::58) by BY3PR03CA0023.outlook.office365.com
 (2603:10b6:a03:39a::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.12 via Frontend Transport; Wed, 27
 May 2026 11:42:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002322.mail.protection.outlook.com (10.167.242.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Wed, 27 May 2026 11:42:29 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 27 May
 2026 06:42:27 -0500
Received: from xirsalihe40.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 27 May 2026 06:42:26 -0500
From: Salih Erim <salih.erim@amd.com>
To: Jonathan Cameron <jic23@kernel.org>, Andy Shevchenko <andy@kernel.org>
CC: David Lechner <dlechner@baylibre.com>, =?UTF-8?q?Nuno=20S=C3=A1?=
	<nuno.sa@analog.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Conall O'Griofa
	<conall.ogriofa@amd.com>, Michal Simek <michal.simek@amd.com>, Guenter Roeck
	<linux@roeck-us.net>, Salih Erim <erimsalih@gmail.com>,
	<linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Salih Erim <salih.erim@amd.com>
Subject: [PATCH v3 5/5] iio: adc: versal-sysmon: add oversampling support
Date: Wed, 27 May 2026 12:42:11 +0100
Message-ID: <20260527114211.174288-6-salih.erim@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260527114211.174288-1-salih.erim@amd.com>
References: <20260527114211.174288-1-salih.erim@amd.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002322:EE_|SJ1PR12MB6266:EE_
X-MS-Office365-Filtering-Correlation-Id: bc807d91-6427-4f25-41b9-08debbe50865
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|7416014|1800799024|36860700016|18002099003|22082099003|6133799003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	wXdx4lXbWTZd11dfDbLkAgbsJKS0dclcvUOxagG57DDof+nuvO6gPVWVklqh0OaedJSZ4SoPOxsrnfZE2jKCR2JSHInr9D4b7o6P/sfxgUAx5mvtaSViFyrgAGNajd/oiOF8nepr6fMnFcHU/24stIA/mrCetQ0FQ/aicuNBHTfX6CzKsZEuUmbnoexEVdLrJpBv6utu25Ol6XTmK3pgEou4RXaXSn9lhhVOvKy2KJG9r0MXmGGLoUYYrqG7Je/DP8FzTCJcJs2Oi7ZKTcRM6Pc0PqrcRZMHX1xb8BRpTSpvkG6McJab26U1LiWOp0JaSlQIm814Sd6V9vGm83jiHaaJq0Aku1tiKCc/Djhw2r3eZVJ3dNUKopcGrlQae4s9V7/tcZ73fEoEqepVhwePuT16DnTCH1oFPdI72YSPup7Bb4wZnWw5rGBOc2l6OB27dapU7dNQJ7TuQAHCf1OWXH5/2NpTSJ0XyvXqHeALETWVfadEVe+eTNelygqWVUqqkZhKW196fspEbcntSnfWbCITk0xPJdju+97TnMPT8nDPRYPCP4XTwfzaDiEfIIjBQeupwDn7wConCuVkjwdKqu/V7M8j9gXpzFPoKMoRTQEPLDuv96pPcjV2u4rPliUL0WeDLTGwkQWPLUcqkgDO/ZUGr/ubBaAXi6cQIl3EsmAccJuOJChAX1eUNydeWCqLM8rUPSEXUVZdkOmUxIGyM2E678Rlrtbr62T4CeuMMg8=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(7416014)(1800799024)(36860700016)(18002099003)(22082099003)(6133799003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ay82LJyes1jla1hhWP/S+eamuTW3JB4zaepnuQq2dKHBd6GIoOFOf2OLF23j/jJFFz6iJSUEVQRMKcCdIB0BJ+2i2ibYFE+EOaSaUzmxEg+dl3OV5fhDSEWewLxf0xfUErUkEBCpGNDmNYXbkXQN6B9WpYONKhjmrPnH8paGdo4WnAJl7MFtIpwj1HZ0K0e4EY+e+GMbgfPfsDpTsQJjb+igBwTkyEEapcTzu9YHlPam7IX9+9tf70KRofKg3XMY1mFqA6Fls075bKBErC1l6uzFTGprK6T7fFcUDq5hmRqk5B0OOSOBYCfTbvGucl6MSgoT8zAJd4B/33tRQNaJ5jw2iz8MqO85onuZOcZkXJOgzPvW1FbzwwNQRnwD4unynigOpAnAiAN/Sl1r7UuTfqLY+RQPlPUzj/wWh1/aXM8dvFew4ZnTocZiut0tF7xS
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2026 11:42:29.5263
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bc807d91-6427-4f25-41b9-08debbe50865
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002322.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6266

Add support for reading and writing the oversampling ratio through
the IIO oversampling_ratio attribute. The hardware supports averaging
2, 4, 8, or 16 samples, plus a ratio of 1 (no averaging).

Temperature and supply channels share oversampling configuration at
the type level (all temperature channels share one ratio, all supply
channels share another), exposed through info_mask_shared_by_type.

The hardware encoding uses sample_count / 2 in a 4-bit field within
the CONFIG register. Per-channel averaging enable registers must also
be updated to activate or deactivate averaging.

Signed-off-by: Salih Erim <salih.erim@amd.com>
---
Changes in v3:
  - No changes

Changes in v2:
  - EN_AVG per-channel bitmask registers written with all-ones
    instead of boolean 1 when oversampling is enabled
  - EN_AVG write errors propagated to userspace
  - Oversampling limited to satellite temp and supply channels;
    static temp channels do not participate
  - Oversampling exposes actual sample counts (1,2,4,8,16) to
    userspace with internal HW register translation
  - write_raw_get_fmt returns IIO_VAL_INT for oversampling ratio
  - HW encoding documented (sample_count/2, not log2)
  - oversampling_avail is const int[] (type match fix)

 drivers/iio/adc/versal-sysmon-core.c | 136 +++++++++++++++++++++++++++
 drivers/iio/adc/versal-sysmon.h      |  17 ++++
 2 files changed, 153 insertions(+)

diff --git a/drivers/iio/adc/versal-sysmon-core.c b/drivers/iio/adc/versal-sysmon-core.c
index 04977c9c887..7775a4cfa6d 100644
--- a/drivers/iio/adc/versal-sysmon-core.c
+++ b/drivers/iio/adc/versal-sysmon-core.c
@@ -25,6 +25,12 @@
 
 #include "versal-sysmon.h"
 
+/*
+ * Oversampling ratio values exposed to userspace via IIO.
+ * Actual number of samples averaged: 1=none, 2=2x, 4=4x, 8=8x, 16=16x.
+ */
+static const int sysmon_oversampling_avail[] = { 1, 2, 4, 8, 16 };
+
 /* OT and TEMP hysteresis mode bits in SYSMON_TEMP_EV_CFG */
 #define SYSMON_OT_HYST_MASK		BIT(0)
 #define SYSMON_TEMP_HYST_MASK		BIT(1)
@@ -205,6 +211,12 @@ static int sysmon_read_raw(struct iio_dev *indio_dev,
 	unsigned int regval;
 	int ret;
 
+	if (mask == IIO_CHAN_INFO_OVERSAMPLING_RATIO) {
+		*val = (chan->type == IIO_TEMP) ? sysmon->temp_oversampling :
+						 sysmon->supply_oversampling;
+		return IIO_VAL_INT;
+	}
+
 	if (mask != IIO_CHAN_INFO_RAW && mask != IIO_CHAN_INFO_PROCESSED)
 		return -EINVAL;
 
@@ -490,6 +502,117 @@ static int sysmon_write_event_value(struct iio_dev *indio_dev,
 	return -EINVAL;
 }
 
+static int sysmon_set_avg_enable(struct sysmon *sysmon,
+				 u32 base, u32 count, u32 val)
+{
+	int ret;
+
+	for (unsigned int i = 0; i < count; i++) {
+		ret = regmap_write(sysmon->regmap,
+				   base + (i * SYSMON_REG_STRIDE), val);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static int sysmon_osr_write(struct sysmon *sysmon, int channel_type, int val)
+{
+	/*
+	 * HW register encoding is sample_count / 2:
+	 * 0=none, 1=2x, 2=4x, 4=8x, 8=16x (not log2-based).
+	 */
+	int hw_val = val >> 1;
+	int ret;
+
+	if (channel_type == IIO_TEMP) {
+		ret = regmap_update_bits(sysmon->regmap, SYSMON_CONFIG,
+					SYSMON_TEMP_SAT_CONFIG_MASK,
+					FIELD_PREP(SYSMON_TEMP_SAT_CONFIG_MASK,
+						   hw_val));
+		if (ret)
+			return ret;
+		ret = sysmon_set_avg_enable(sysmon, SYSMON_TEMP_EN_AVG_BASE,
+					    SYSMON_TEMP_EN_AVG_COUNT,
+					    hw_val ? ~0U : 0);
+		if (ret)
+			return ret;
+	} else if (channel_type == IIO_VOLTAGE) {
+		ret = regmap_update_bits(sysmon->regmap, SYSMON_CONFIG,
+					SYSMON_SUPPLY_CONFIG_MASK,
+					FIELD_PREP(SYSMON_SUPPLY_CONFIG_MASK,
+						   hw_val));
+		if (ret)
+			return ret;
+		ret = sysmon_set_avg_enable(sysmon, SYSMON_SUPPLY_EN_AVG_BASE,
+					    SYSMON_SUPPLY_EN_AVG_COUNT,
+					    hw_val ? ~0U : 0);
+		if (ret)
+			return ret;
+	} else {
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int sysmon_write_raw(struct iio_dev *indio_dev,
+			    struct iio_chan_spec const *chan,
+			    int val, int val2, long mask)
+{
+	struct sysmon *sysmon = iio_priv(indio_dev);
+	int i, ret;
+
+	if (mask != IIO_CHAN_INFO_OVERSAMPLING_RATIO)
+		return -EINVAL;
+
+	for (i = 0; i < ARRAY_SIZE(sysmon_oversampling_avail); i++) {
+		if (val == sysmon_oversampling_avail[i])
+			break;
+	}
+	if (i == ARRAY_SIZE(sysmon_oversampling_avail))
+		return -EINVAL;
+
+	guard(mutex)(&sysmon->lock);
+
+	ret = sysmon_osr_write(sysmon, chan->type, val);
+	if (ret)
+		return ret;
+
+	if (chan->type == IIO_TEMP)
+		sysmon->temp_oversampling = val;
+	else
+		sysmon->supply_oversampling = val;
+
+	return 0;
+}
+
+static int sysmon_write_raw_get_fmt(struct iio_dev *indio_dev,
+				    struct iio_chan_spec const *chan,
+				    long mask)
+{
+	if (mask == IIO_CHAN_INFO_OVERSAMPLING_RATIO)
+		return IIO_VAL_INT;
+
+	return -EINVAL;
+}
+
+static int sysmon_read_avail(struct iio_dev *indio_dev,
+			     struct iio_chan_spec const *chan,
+			     const int **vals, int *type,
+			     int *length, long mask)
+{
+	if (mask != IIO_CHAN_INFO_OVERSAMPLING_RATIO)
+		return -EINVAL;
+
+	*vals = sysmon_oversampling_avail;
+	*type = IIO_VAL_INT;
+	*length = ARRAY_SIZE(sysmon_oversampling_avail);
+
+	return IIO_AVAIL_LIST;
+}
+
 static int sysmon_read_label(struct iio_dev *indio_dev,
 			     struct iio_chan_spec const *chan,
 			     char *label)
@@ -502,6 +625,9 @@ static int sysmon_read_label(struct iio_dev *indio_dev,
 
 static const struct iio_info sysmon_iio_info = {
 	.read_raw = sysmon_read_raw,
+	.write_raw = sysmon_write_raw,
+	.write_raw_get_fmt = sysmon_write_raw_get_fmt,
+	.read_avail = sysmon_read_avail,
 	.read_label = sysmon_read_label,
 	.read_event_config = sysmon_read_event_config,
 	.write_event_config = sysmon_write_event_config,
@@ -809,6 +935,10 @@ static int sysmon_parse_fw(struct iio_dev *indio_dev, struct device *dev,
 			.info_mask_separate =
 				BIT(IIO_CHAN_INFO_RAW) |
 				BIT(IIO_CHAN_INFO_PROCESSED),
+			.info_mask_shared_by_type =
+				BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
+			.info_mask_shared_by_type_available =
+				BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
 			.event_spec = has_irq ?
 				sysmon_supply_events : NULL,
 			.num_event_specs = has_irq ?
@@ -849,6 +979,10 @@ static int sysmon_parse_fw(struct iio_dev *indio_dev, struct device *dev,
 			.info_mask_separate =
 				BIT(IIO_CHAN_INFO_RAW) |
 				BIT(IIO_CHAN_INFO_PROCESSED),
+			.info_mask_shared_by_type =
+				BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
+			.info_mask_shared_by_type_available =
+				BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
 			.scan_type = {
 				.sign = 's',
 				.realbits = 15,
@@ -902,6 +1036,8 @@ int sysmon_core_probe(struct device *dev, struct regmap *regmap)
 
 	sysmon = iio_priv(indio_dev);
 	sysmon->regmap = regmap;
+	sysmon->temp_oversampling = 1;
+	sysmon->supply_oversampling = 1;
 
 	ret = devm_mutex_init(dev, &sysmon->lock);
 	if (ret)
diff --git a/drivers/iio/adc/versal-sysmon.h b/drivers/iio/adc/versal-sysmon.h
index a78362f95e6..cf69be62709 100644
--- a/drivers/iio/adc/versal-sysmon.h
+++ b/drivers/iio/adc/versal-sysmon.h
@@ -25,11 +25,13 @@ struct regmap;
 #define SYSMON_IMR			0x0048
 #define SYSMON_IER			0x004C
 #define SYSMON_IDR			0x0050
+#define SYSMON_CONFIG			0x0100
 #define SYSMON_TEMP_MAX			0x1030
 #define SYSMON_TEMP_MIN			0x1034
 #define SYSMON_SUPPLY_BASE		0x1040
 #define SYSMON_ALARM_FLAG		0x1018
 #define SYSMON_ALARM_REG		0x1940
+#define SYSMON_SUPPLY_EN_AVG_BASE	0x1958
 #define SYSMON_TEMP_TH_LOW		0x1970
 #define SYSMON_TEMP_TH_UP		0x1974
 #define SYSMON_OT_TH_LOW		0x1978
@@ -41,6 +43,7 @@ struct regmap;
 #define SYSMON_TEMP_MAX_MAX		0x1F90
 #define SYSMON_STATUS_RESET		0x1F94
 #define SYSMON_TEMP_SAT_BASE		0x1FAC
+#define SYSMON_TEMP_EN_AVG_BASE		0x24B4
 #define SYSMON_MAX_REG			0x24C0
 
 /* NPI unlock value written to SYSMON_NPI_LOCK */
@@ -57,6 +60,16 @@ struct regmap;
 /* ISR/IMR temperature and OT alarm mask (bits 9:8) */
 #define SYSMON_TEMP_INTR_MASK		GENMASK(9, 8)
 
+/* Config register: supply oversampling field (bits 17:14) */
+#define SYSMON_SUPPLY_CONFIG_MASK	GENMASK(17, 14)
+
+/* Config register: temp satellite oversampling field (bits 27:24) */
+#define SYSMON_TEMP_SAT_CONFIG_MASK	GENMASK(27, 24)
+
+/* Per-channel averaging enable register counts */
+#define SYSMON_SUPPLY_EN_AVG_COUNT	5
+#define SYSMON_TEMP_EN_AVG_COUNT	2
+
 /* Supply voltage conversion register fields */
 #define SYSMON_MANTISSA_MASK		GENMASK(15, 0)
 #define SYSMON_FMT_MASK			BIT(16)
@@ -85,6 +98,8 @@ struct regmap;
  * @temp_hysteresis: cached DEVICE_TEMP hysteresis in millicelsius
  * @ot_hysteresis: cached OT hysteresis in millicelsius
  * @sysmon_unmask_work: re-enables events after alarm condition clears
+ * @temp_oversampling: current temp oversampling ratio
+ * @supply_oversampling: current supply oversampling ratio
  */
 struct sysmon {
 	struct regmap *regmap;
@@ -101,6 +116,8 @@ struct sysmon {
 	int temp_hysteresis;
 	int ot_hysteresis;
 	struct delayed_work sysmon_unmask_work;
+	unsigned int temp_oversampling;
+	unsigned int supply_oversampling;
 };
 
 int sysmon_core_probe(struct device *dev, struct regmap *regmap);
-- 
2.48.1

