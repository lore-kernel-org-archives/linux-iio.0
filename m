Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013035.outbound.protection.outlook.com [40.93.201.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 340F93822B1;
	Sun, 14 Jun 2026 23:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781480264; cv=fail; b=sEW7artG8ehvmip37/aS4EhvbSSoq6L/OrBaaemg5yXmA3XaLXumTpY+V9IFos+sgQ/XTmw8EoqbeZ4kf+x6p/q4XaVxgrXRyEWB626r3KV3fPAkczdq+mg/WlTCV/knPWOoXPEf7lsDfgumojq4OEpHhSVMojW0T5XbWf83A28=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781480264; c=relaxed/simple;
	bh=QyM2U1LyYPoxwcqGrNDSUxywtCH+3ey0/6x1SZpiLSs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hJYt8tWvXgw+PBcur3Z0+qywJTCgrgf1j5zIevcxhhzoHO3Q5FyYgQFHVyAsZOFC0OMr70vFuWI9xTYCO3VU1pBdu2/BnxDFcYh0N6R+e/wS+0TPtYe+fAjPZbXSOr/G94NcibcO7wfwTNfpheGDwia4I4LZSClEayyNL2sU3o4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=sm12nFR/; arc=fail smtp.client-ip=40.93.201.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="sm12nFR/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xmpabSV4rvMEinzRURUEEzVEQsDUwl/Ks2KjiyApQNaGIavRDY0tGaKEkD2lVBK3GKbn4HnWbqLByqYsZeMQ9QNrQi/32rphe2ktbJNDU1yAJW7+JKGd9UVcma62OEke0E01OEcip3DR6jBkWRX/H+o7E5wLkZsTQT95n18FTyYuABnOIiQp27YSQARu/vKbXY9tKFkeA6aM3OfUFSe7sV30r4DwSKcwIIMsXTT/pfoyo4ROjd881xlXMbERBPuW+xLJdf1BqCNG29BBfSsJPcNAhqYAYDxNwuJ3vXd4/XGOD9cUrXxpVYffvNbO/2eaqOe34LfvKVizrvtUE/fsVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=isMNNNv2ODB+egtfbP6HbDJdMcp0qR+oMsN7x6Ev34A=;
 b=i2IIAmIDzsanCA5ZqJwRuEokjkZcaUrKh3teWQiyZJOM6t/70fQaA//m4DYQILDaQZXONHuXhi1TGxmcrc1HLiJwY4GKvoOUYYhOfSF8Z2gXpEmZbYp0s71zqg3vimzjDgkXlH1wzeib93oG2l7UhSZLG5mBsvAdJ1nvEN2rsYRnBDmgHQHkqbZQB9XzfgeRqAIELxZh2IgbDih9tkav0WE0a41/de+f/eF0TqJQR5mAFJk3NzI0oZg/Lj0JmFG4FgY/kx1nxlr6vdnHRAGhwUbriTLYeSX9wLOLZ0Dh+HHWqFrJangovuula1tdnn0VpY6T4NPmGLhJbG9c+oHyDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=isMNNNv2ODB+egtfbP6HbDJdMcp0qR+oMsN7x6Ev34A=;
 b=sm12nFR/SkAs8oFLiKK4yQ9E4DAPY0OBPk8uNtbJz8I5OCqouGzwMAH3WzPek+mkW6ZEjKBkMxdDJXRFlQFYIMLWgHSW351jBrvKY8pn4V3Rjg+uiy9B6VonoleitdIGeYT84VW7zQmQDipBJmFFm5BGJGHD1wxyRGb9JcQklUM=
Received: from SA0PR11CA0046.namprd11.prod.outlook.com (2603:10b6:806:d0::21)
 by DS5PPFEC0C6BDA1.namprd12.prod.outlook.com (2603:10b6:f:fc00::668) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.13; Sun, 14 Jun
 2026 23:37:35 +0000
Received: from SN1PEPF0002636B.namprd02.prod.outlook.com
 (2603:10b6:806:d0:cafe::a4) by SA0PR11CA0046.outlook.office365.com
 (2603:10b6:806:d0::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.18 via Frontend Transport; Sun,
 14 Jun 2026 23:37:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF0002636B.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Sun, 14 Jun 2026 23:37:34 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Sun, 14 Jun
 2026 18:37:34 -0500
Received: from xirsalihe40.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Sun, 14 Jun 2026 18:37:32 -0500
From: Salih Erim <salih.erim@amd.com>
To: <jic23@kernel.org>, <andy@kernel.org>
CC: <dlechner@baylibre.com>, <nuno.sa@analog.com>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <conall.ogriofa@amd.com>,
	<michal.simek@amd.com>, <linux@roeck-us.net>, <erimsalih@gmail.com>,
	<linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Salih Erim <salih.erim@amd.com>
Subject: [PATCH v7 5/5] iio: adc: versal-sysmon: add oversampling support
Date: Mon, 15 Jun 2026 00:37:22 +0100
Message-ID: <20260614233722.2603459-6-salih.erim@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260614233722.2603459-1-salih.erim@amd.com>
References: <20260614233722.2603459-1-salih.erim@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636B:EE_|DS5PPFEC0C6BDA1:EE_
X-MS-Office365-Filtering-Correlation-Id: c81e6abd-366d-41be-0c7e-08deca6de94c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|7416014|36860700016|23010399003|18002099003|22082099003|6133799003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	hkRuKoqaSezHUiGyn7tdwk0o40iGo0h4m/RwG8RmN+canV4zJzdhDcxhkLMO3Zes1A29qdDOFfShrya0Ezk/8Vs1D9lZK3UPlYbTNcwoOD6TiXZFoQAklZOpT9VfhSKOZkXvltteGlDSyHFvtrAVRn4pHM0WWXLH0JUOadya+fZ8YH51z9EeBskZfZNk9BREfuriIPW4jXXfiq0lD9z+lN7T9vk3isn2+uoMbC/dxKLWihz+m2OZ5oVKByj0jFIGhsBvInHHBDz0iXbUbzgONNqEnjmvS6ldId1R2v4lzXU3tToEwC2Xz4NS2QQcxYpgVYxFsJkTsNHJvEzF/zK5cXhQ3ubiLjGRM3XdIT/YcwUVJ4cWJFNI0x4uKN/cl//iISOpZjNLIYU6PmQy8qd7Zv5mW3EBnr/HP7ON/KAQQJA8NFz2V6EBbgUbjBmf8QBIYyj+O7ELdt0xwdZayKcsRjZhw7ieoW0sNSmTkU9cqDPKiPdg+IfaVXCg1es5Vs8LKhd5d35mreJEg4zX+Czphr6kPHOJLJBRz6gze9QtMCSBZt1HLoeE6/SN7XNxc4WqxIde3W0lJ99209GxwLHOlq7J0d7iUcG6RY1/RJOxZdEPh74CBHpkacWDVXkCnqkG40vHachlhbwMNTifjVBi6FAfGma5CX+xNJt3aVFZKwr/5JIMoq+mdMvcOBcbZRhNOzWT7GfVspmQvCz7/VJZyMl+c1f7G5HYQotwbipUCCw=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(7416014)(36860700016)(23010399003)(18002099003)(22082099003)(6133799003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	btkPkuunP+oTaqfiiCpoIPX1FIrIu/img5IE8WpturqZRtpq6QJRLLtoRGCFYcXY9OG1r5stmRFPgWHrvFwfBm1r/g727ndEzSC8nAbrzB4clN1ERc8VPVAekO5rufZ4MQy/mMOBHHxuyPRC591yd19g0+kx5ownGGTeaexmLNfLeiqWNrsH1UDKQjFcFTGefuEwqB/h7R88F/dloiDGeRTdy70Xx5Drx4311ky89DmeX3Cjqwz1tMpLeqV4To30/oqenxoI0VoORJvkVc6qmVPDK11TwoRztsv/huX70RIkG3BwIvEjjvmnh0qoevJUBcPOxaHtnaeiYeLLkM812pxi6jSvlO/cnXEbrdRA8PWCP8PtqEAi98b/S9dC1mYWUL1NdC/1vglJdBOxpa5X1n6oCC1fFlwL7RPBW4qsVnEDdVjkiqt0wBwVkxwmbRDZ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2026 23:37:34.7110
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c81e6abd-366d-41be-0c7e-08deca6de94c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002636B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPFEC0C6BDA1

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
index 16feb373bc7..d9599a7bc89 100644
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
@@ -460,6 +472,132 @@ static int sysmon_write_event_value(struct iio_dev *indio_dev,
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
+static int sysmon_osr_write_temp(struct sysmon *sysmon, int val)
+{
+	/*
+	 * HW register encoding is sample_count / 2:
+	 * 0=none, 1=2x, 2=4x, 4=8x, 8=16x (not log2-based).
+	 */
+	int hw_val = val >> 1;
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
+				     hw_val ? ~0U : 0);
+}
+
+static int sysmon_osr_write_supply(struct sysmon *sysmon, int val)
+{
+	/* HW encoding: sample_count / 2 (see sysmon_osr_write_temp) */
+	int hw_val = val >> 1;
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
+				     hw_val ? ~0U : 0);
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
@@ -472,6 +610,9 @@ static int sysmon_read_label(struct iio_dev *indio_dev,
 
 static const struct iio_info sysmon_iio_info = {
 	.read_raw = sysmon_read_raw,
+	.write_raw = sysmon_write_raw,
+	.write_raw_get_fmt = sysmon_write_raw_get_fmt,
+	.read_avail = sysmon_read_avail,
 	.read_label = sysmon_read_label,
 	.read_event_config = sysmon_read_event_config,
 	.write_event_config = sysmon_write_event_config,
@@ -761,6 +902,10 @@ static int sysmon_parse_fw(struct iio_dev *indio_dev, struct device *dev,
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
@@ -792,7 +937,11 @@ static int sysmon_parse_fw(struct iio_dev *indio_dev, struct device *dev,
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
@@ -839,6 +988,8 @@ int sysmon_core_probe(struct device *dev, struct regmap *regmap)
 
 	sysmon = iio_priv(indio_dev);
 	sysmon->regmap = regmap;
+	sysmon->temp_oversampling = 1;
+	sysmon->supply_oversampling = 1;
 
 	ret = devm_mutex_init(dev, &sysmon->lock);
 	if (ret)
diff --git a/drivers/iio/adc/versal-sysmon.h b/drivers/iio/adc/versal-sysmon.h
index ca3df017dbb..409dd9298fb 100644
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
 
 int sysmon_core_probe(struct device *dev, struct regmap *regmap);
-- 
2.48.1

