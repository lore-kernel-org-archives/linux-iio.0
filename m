Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011067.outbound.protection.outlook.com [52.101.52.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF5592DF3F2;
	Tue, 16 Jun 2026 13:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781615800; cv=fail; b=KC3E45R5RY29mMwnP/OiWFNihOGp8zHvvT3FfWkce0djKX5nYQYVGZaZ0BLnPxORAd+D3p9uJ3XrqfAy5eBu3vx2gy600xPqp+SIzYzAtWO3EHH1aA1GSBIaHdrielUSzDYDBU4mmz32wg7e1bkqKmmEZsd6bwRT2i8fgBy6nx4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781615800; c=relaxed/simple;
	bh=nETPbPU24zX921USEbvxepFDKLQb0cHuuK+pb7sczlM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NHzR0oWuNx7/2oJ3fkrRbe6huj93bHpOGHvNWhLA3m52yC5KsLS1gMOlBhT5XJluV9rP1xaoiu2lHzFy5jvze0OLxc6RyriYXrHCFiX4I48V7B/C+z9KoIrh2Lj/9DIQy34Lf8voyfRWesvp+AtpQQMcXWHHFcqMzMfRwhjlJdk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=E3sA2F54; arc=fail smtp.client-ip=52.101.52.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="E3sA2F54"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LjrnNAdEXmK3rZbO4CsUNP1/YhMGoLYuu/sKHJ/z8cPl/4PZ2sQEHNsly5Jlo2B9037czqrECHWY4/LhvXzX9ihfZw35MT8F0uZOnwKoH68IZYwJsVTc+r4lNeuqZ4aJQB8Dz8hd7s3nayQLsWn+kcwkmp8Szzv6sPcRYQ0hyRmVR0UIxciR+P9euACKAytiLDazp2kC+1FbWc5hiCz7cuMSJO/uEH63E4DQStvKETsHxFf9uw/Knj9VZWRRuoSaX8AC2nvt5Zzu/BhF44S8dq4b51YzqET+bJPvHMTPLefNc66+56LoKKcOuopdSjS/StLAakgapo2bzjhYAWRA4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7DZ3cm3AVCzau4IMdS3MEwi6wIMjyfJyMOnw8gun9BQ=;
 b=B5FAc3L7j2ICkEsQlI27WwJxXoMYXdKIf2PF/K8/tb3zx8JQAE0z3DTME5V7z+62sA8bFvv3DjuepUKzz+RXBiVR3pHv8PtAyzNYnN2PEH8GPoTWwa3mcducec9aApsXJLaevY+tYCtyixykhSrW09qg9zKcaekH97jc4bZeka/u674lMh6pwDuAH1Le/AAoUGFrMFGcwP5YVGUYB38Pdx+ZxwVI1FWnx/NT6mPmNBojWWNapBPt0SIOHSYuYgsXrhuL57/zWbTS3LuBuG0MX6v91AA6D/ZoqWgpQ2NOUqefIWG1/j0lDsgVL8tD4sw/cLL4o3SkXJCWXmJhqbVCvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7DZ3cm3AVCzau4IMdS3MEwi6wIMjyfJyMOnw8gun9BQ=;
 b=E3sA2F54QguulmfXyY619wzYRRIwzlvACkLgzdLoi6wer2sqBdiC9tWP6qxNL6TiKjNBlda7Q2R+AyacHycgijKfA+TnxIYI29PtSITwZvgcIIilZxu2rNIapdTLVb/C8bAiFc6i+ahU46p8Ane+yMHPZNtW5wiR2pgVcy7MMnM=
Received: from BY1P220CA0044.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:59e::10)
 by PH7PR12MB5854.namprd12.prod.outlook.com (2603:10b6:510:1d5::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Tue, 16 Jun
 2026 13:16:28 +0000
Received: from SJ1PEPF000026C6.namprd04.prod.outlook.com
 (2603:10b6:a03:59e:cafe::9c) by BY1P220CA0044.outlook.office365.com
 (2603:10b6:a03:59e::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.16 via Frontend Transport; Tue,
 16 Jun 2026 13:16:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF000026C6.mail.protection.outlook.com (10.167.244.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Tue, 16 Jun 2026 13:16:28 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 16 Jun
 2026 08:16:23 -0500
Received: from xirsalihe40.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Tue, 16 Jun 2026 08:16:21 -0500
From: Salih Erim <salih.erim@amd.com>
To: <jic23@kernel.org>, <andy@kernel.org>
CC: <dlechner@baylibre.com>, <nuno.sa@analog.com>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <conall.ogriofa@amd.com>,
	<michal.simek@amd.com>, <linux@roeck-us.net>, <erimsalih@gmail.com>,
	<linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Salih Erim <salih.erim@amd.com>
Subject: [PATCH v8 5/5] iio: adc: versal-sysmon: add oversampling support
Date: Tue, 16 Jun 2026 14:15:59 +0100
Message-ID: <20260616131559.3029543-6-salih.erim@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260616131559.3029543-1-salih.erim@amd.com>
References: <20260616131559.3029543-1-salih.erim@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C6:EE_|PH7PR12MB5854:EE_
X-MS-Office365-Filtering-Correlation-Id: ede7e839-b38b-4232-1ee1-08decba979d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|7416014|82310400026|1800799024|23010399003|56012099006|11063799006|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	OqkPlzpgrHSZVmVkljDVCQiAj6DGV2Z8lVeVztIxWohiLW+jFYPcksur0IrXF4KpDxa85b27PLe5j0TK4P0sQ0CtIL7jr376F8CVcs4VjWZNjVv1At4Dea5uzlXBQedY2R3xFd8HshRdO7wY8CBRyBQaQT18DXzU0p7CYg03dqZc3ew3BEjaVC3L/ycD2pwESJP4N24+WM+hqNxX9UGVRq97E7XQ5LDXHamn/wbtXO/rm4RTmj7EtxbPavwQvsU0d51pk1qt4U+8be8eQfTRBXYDkFihyQdwtAUvTnLxXzX2DSdBMFH1wIFfQTT6sQg3dpvObowgSQAZOmpbwfm/jhFLbtwM8Eoc3vQMCbvES8F+y2f6k3z8GyrBc8fHgTaU39vgSiZfLF6xgTqaXt5RgFe2GHn4yISdjiQruyySlZj9M1S8ZYdswKdNmB+xwGkSlb3xtVjinRle2r5imOcAAEuBmlG3gsikCFaEXPkNwIwqPHpXOzfXdspEFPFDAuvYJd8Bzdr/BrmW5o2m3EHVkiIwBbwdZ7O07nlRGd2mmjjEefT5RODWLTENJh6EjRTI7jDCQDo99r+EVpmmto0Lv/+t0LbtBpUwA3nyLc3dlS3bXXnveM23F2C5m2QMcat5iRgqcl8YvNot3nEJlLjqh5ZOFdEN/Aud+9lyMqlOS4aJFtKbYRoqCgLwnWu/VpStL3MF8hUWWJgjpTA+n82EbKQSf5LlS0CE4qKqBqjPdVw=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(376014)(7416014)(82310400026)(1800799024)(23010399003)(56012099006)(11063799006)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	0UUckLYhaj4Dy9gn4R5o7lF5x65mGDx9NimYTP0C5xheyV3C8cXo0fcdj7HtI22Ic5bd8P+aFLMoC1QQd1sjN0U4pAuXs+ttZ86YdkWp2G+kEMMfvOVEkzblAxlkxQNWx5/tNGo0YTxgfG1IEjvrzVFCAwcMXMH15n3rGoHW9e6xt7OA+8oZEbqBe7bCcYEeMYotJY4+3P4SpWqnkPihIRntt/zRK6uhf4U2GRTCatZ8JsrJ+vBnPMeo3zOGv+zW3PZbNgbxGDh9LV6ThKTZz0vqwVv64+Wmvi9BoshtDHuHaTjaSYXVH3uwxpMObi4jiZK7vUmqB4wt1hGL0jbFXdfCeHT4JFUhxDPFTwTqXnnYKZIdGRACy2uw2cd4lu4USj1RVksUrM3Cv/ahDerxU4iCx32sEOr1MryCXNagoIGibkbW5qWNur8BtdkFX9GZ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2026 13:16:28.6218
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ede7e839-b38b-4232-1ee1-08decba979d8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000026C6.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5854

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
Changes in v8:
  - Use unsigned int for val parameter and hw_val in both
    osr_write helpers (Andy)
  - Use ~0 instead of ~0U for avg enable bitmask (Andy)

Changes in v7:
  - Split sysmon_osr_write into sysmon_osr_write_temp and
    sysmon_osr_write_supply; caller dispatches with if/else
    on chan->type (Jonathan)
  - Restore HW encoding comment in both helpers; fix
    cross-reference in sysmon_osr_write_supply

Changes in v6:
  - Fix FIELD_PREP indentation in sysmon_osr_write (Andy)
  - unsigned int for loop index in sysmon_write_raw (Andy)

Changes in v5:
  - Remove unneeded parentheses in i * SYSMON_REG_STRIDE (Andy)
  - Use struct regmap *map local variable in
    sysmon_set_avg_enable (Andy)
  - switch instead of redundant if/if on channel_type (Andy)
  - Add CONFIG register readback fence after oversampling update
    to prevent NoC bus hang from posted writes (found during
    hardware stress testing)

Changes in v4:
  - Return directly from sysmon_set_avg_enable calls, remove
    else after early returns, drop unreachable return 0 (Jonathan)
  - Rename mask defines to SYSMON_CONFIG_SUPPLY_OSR and
    SYSMON_CONFIG_TEMP_SAT_OSR (Jonathan)
  - Drop "bits X:Y" from GENMASK comments (Jonathan)
  - Blank lines after if (ret) return ret blocks (Jonathan)
  - Move oversampling read inside guard(mutex) scope

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
 drivers/iio/adc/versal-sysmon-core.c | 153 ++++++++++++++++++++++++++-
 drivers/iio/adc/versal-sysmon.h      |  17 +++
 2 files changed, 169 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/versal-sysmon-core.c b/drivers/iio/adc/versal-sysmon-core.c
index 8d567f9fa05..309c39b515f 100644
--- a/drivers/iio/adc/versal-sysmon-core.c
+++ b/drivers/iio/adc/versal-sysmon-core.c
@@ -26,6 +26,12 @@
 
 #include "versal-sysmon.h"
 
+/*
+ * Oversampling ratio values exposed to userspace via IIO.
+ * Actual number of samples averaged: 1=none, 2=2x, 4=4x, 8=8x, 16=16x.
+ */
+static const int sysmon_oversampling_avail[] = { 1, 2, 4, 8, 16 };
+
 /* TEMP hysteresis mode bit in SYSMON_TEMP_EV_CFG */
 #define SYSMON_TEMP_HYST_MASK		BIT(1)
 
@@ -165,6 +171,12 @@ static int sysmon_read_raw(struct iio_dev *indio_dev,
 
 	guard(mutex)(&sysmon->lock);
 
+	if (mask == IIO_CHAN_INFO_OVERSAMPLING_RATIO) {
+		*val = (chan->type == IIO_TEMP) ? sysmon->temp_oversampling :
+						 sysmon->supply_oversampling;
+		return IIO_VAL_INT;
+	}
+
 	switch (chan->type) {
 	case IIO_TEMP:
 		if (mask == IIO_CHAN_INFO_SCALE) {
@@ -454,6 +466,132 @@ static int sysmon_write_event_value(struct iio_dev *indio_dev,
 	}
 }
 
+static int sysmon_set_avg_enable(struct sysmon *sysmon,
+				 u32 base, u32 count, u32 val)
+{
+	struct regmap *map = sysmon->regmap;
+	int ret;
+
+	for (unsigned int i = 0; i < count; i++) {
+		ret = regmap_write(map, base + i * SYSMON_REG_STRIDE, val);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static int sysmon_osr_write_temp(struct sysmon *sysmon, unsigned int val)
+{
+	/*
+	 * HW register encoding is sample_count / 2:
+	 * 0=none, 1=2x, 2=4x, 4=8x, 8=16x (not log2-based).
+	 */
+	unsigned int hw_val = val >> 1;
+	unsigned int readback;
+	int ret;
+
+	ret = regmap_update_bits(sysmon->regmap, SYSMON_CONFIG,
+				SYSMON_CONFIG_TEMP_SAT_OSR,
+				FIELD_PREP(SYSMON_CONFIG_TEMP_SAT_OSR, hw_val));
+	if (ret)
+		return ret;
+
+	/*
+	 * Readback fence: the SysMon CONFIG register resides in the
+	 * PMC domain behind the NoC. A posted write may not reach the
+	 * hardware before the next MMIO access. Reading the register
+	 * back forces the interconnect to complete the write, preventing
+	 * a bus hang on the subsequent access.
+	 */
+	regmap_read(sysmon->regmap, SYSMON_CONFIG, &readback);
+
+	return sysmon_set_avg_enable(sysmon, SYSMON_TEMP_EN_AVG_BASE,
+				     SYSMON_TEMP_EN_AVG_COUNT,
+				     hw_val ? ~0 : 0);
+}
+
+static int sysmon_osr_write_supply(struct sysmon *sysmon, unsigned int val)
+{
+	/* HW encoding: sample_count / 2 (see sysmon_osr_write_temp) */
+	unsigned int hw_val = val >> 1;
+	unsigned int readback;
+	int ret;
+
+	ret = regmap_update_bits(sysmon->regmap, SYSMON_CONFIG,
+				SYSMON_CONFIG_SUPPLY_OSR,
+				FIELD_PREP(SYSMON_CONFIG_SUPPLY_OSR, hw_val));
+	if (ret)
+		return ret;
+
+	/* Readback fence -- see sysmon_osr_write_temp for details */
+	regmap_read(sysmon->regmap, SYSMON_CONFIG, &readback);
+
+	return sysmon_set_avg_enable(sysmon, SYSMON_SUPPLY_EN_AVG_BASE,
+				     SYSMON_SUPPLY_EN_AVG_COUNT,
+				     hw_val ? ~0 : 0);
+}
+
+static int sysmon_write_raw(struct iio_dev *indio_dev,
+			    struct iio_chan_spec const *chan,
+			    int val, int val2, long mask)
+{
+	struct sysmon *sysmon = iio_priv(indio_dev);
+	unsigned int i;
+	int ret;
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
+	if (chan->type == IIO_TEMP) {
+		ret = sysmon_osr_write_temp(sysmon, val);
+		if (ret)
+			return ret;
+		sysmon->temp_oversampling = val;
+	} else {
+		ret = sysmon_osr_write_supply(sysmon, val);
+		if (ret)
+			return ret;
+		sysmon->supply_oversampling = val;
+	}
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
@@ -466,6 +604,9 @@ static int sysmon_read_label(struct iio_dev *indio_dev,
 
 static const struct iio_info sysmon_iio_info = {
 	.read_raw = sysmon_read_raw,
+	.write_raw = sysmon_write_raw,
+	.write_raw_get_fmt = sysmon_write_raw_get_fmt,
+	.read_avail = sysmon_read_avail,
 	.read_label = sysmon_read_label,
 	.read_event_config = sysmon_read_event_config,
 	.write_event_config = sysmon_write_event_config,
@@ -756,6 +897,10 @@ static int sysmon_parse_fw(struct iio_dev *indio_dev, struct device *dev, int ir
 			.indexed = 1,
 			.address = reg,
 			.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED),
+			.info_mask_shared_by_type =
+				BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
+			.info_mask_shared_by_type_available =
+				BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
 			.event_spec = irq > 0 ?
 				sysmon_supply_events : NULL,
 			.num_event_specs = irq > 0 ?
@@ -787,7 +932,11 @@ static int sysmon_parse_fw(struct iio_dev *indio_dev, struct device *dev, int ir
 			.address = SYSMON_TEMP_SAT_BASE +
 				   (reg - 1) * SYSMON_REG_STRIDE,
 			.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
-			.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),
+			.info_mask_shared_by_type =
+				BIT(IIO_CHAN_INFO_SCALE) |
+				BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
+			.info_mask_shared_by_type_available =
+				BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
 			.datasheet_name = label,
 		};
 	}
@@ -834,6 +983,8 @@ int devm_versal_sysmon_core_probe(struct device *dev, struct regmap *regmap)
 
 	sysmon = iio_priv(indio_dev);
 	sysmon->regmap = regmap;
+	sysmon->temp_oversampling = 1;
+	sysmon->supply_oversampling = 1;
 
 	ret = devm_mutex_init(dev, &sysmon->lock);
 	if (ret)
diff --git a/drivers/iio/adc/versal-sysmon.h b/drivers/iio/adc/versal-sysmon.h
index 9fe2793757a..bb9a75bf71c 100644
--- a/drivers/iio/adc/versal-sysmon.h
+++ b/drivers/iio/adc/versal-sysmon.h
@@ -23,11 +23,13 @@ struct regmap;
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
 #define SYSMON_SUPPLY_TH_LOW		0x1980
@@ -37,6 +39,7 @@ struct regmap;
 #define SYSMON_TEMP_MAX_MAX		0x1F90
 #define SYSMON_STATUS_RESET		0x1F94
 #define SYSMON_TEMP_SAT_BASE		0x1FAC
+#define SYSMON_TEMP_EN_AVG_BASE		0x24B4
 #define SYSMON_MAX_REG			0x24C0
 
 /* NPI unlock value written to SYSMON_NPI_LOCK */
@@ -53,6 +56,16 @@ struct regmap;
 /* ISR/IMR temperature alarm mask (bit 9) */
 #define SYSMON_TEMP_INTR_MASK		BIT(9)
 
+/* SYSMON_CONFIG: supply oversampling ratio */
+#define SYSMON_CONFIG_SUPPLY_OSR	GENMASK(17, 14)
+
+/* SYSMON_CONFIG: temperature satellite oversampling ratio */
+#define SYSMON_CONFIG_TEMP_SAT_OSR	GENMASK(27, 24)
+
+/* Per-channel averaging enable register counts */
+#define SYSMON_SUPPLY_EN_AVG_COUNT	5
+#define SYSMON_TEMP_EN_AVG_COUNT	2
+
 /* Supply voltage conversion register fields */
 #define SYSMON_MANTISSA_MASK		GENMASK(15, 0)
 #define SYSMON_FMT_MASK			BIT(16)
@@ -77,6 +90,8 @@ struct regmap;
  * @temp_mask: temperature interrupt configuration mask
  * @temp_hysteresis: cached DEVICE_TEMP hysteresis in millicelsius
  * @sysmon_unmask_work: re-enables events after alarm condition clears
+ * @temp_oversampling: current temp oversampling ratio
+ * @supply_oversampling: current supply oversampling ratio
  */
 struct sysmon {
 	struct regmap *regmap;
@@ -96,6 +111,8 @@ struct sysmon {
 	unsigned int temp_mask;
 	int temp_hysteresis;
 	struct delayed_work sysmon_unmask_work;
+	unsigned int temp_oversampling;
+	unsigned int supply_oversampling;
 };
 
 int devm_versal_sysmon_core_probe(struct device *dev, struct regmap *regmap);
-- 
2.48.1

