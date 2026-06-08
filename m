Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010035.outbound.protection.outlook.com [40.93.198.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CCB73E51D8;
	Mon,  8 Jun 2026 18:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780943910; cv=fail; b=rw2iPKsmqPH4KezRsMTdfH9aJ99cxi6jGKyY+nxoIxLF0rUlSp7f9qHK/LqCYG+l/OimLbUWa+1tuHx6gJnedb79EPaRjs5E02x6CisNvFptJGyQpwV1suegKM6Yzf4uTKwiz5NAEq2TGyubBahubf7PiK1ZMW0cJoKXCAsa8q4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780943910; c=relaxed/simple;
	bh=yov1iXWqkRaFCK0gj9NQTZhq8firKHOFZoHKFl3VyHI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DhOAaRgUHo5UHyDftODSNK7w4JZfvVg4WK8jp929kEX+F4/gO4Zn1fHgcpJU8ZBN/3n/qKv5eH1XdbcaHmHEAdff0Un+QcXwov6p26rXZCbZkABD9UwCkMaztOtWeDbxLldH3lViNGXmcUV3EUFxIpHnddWeH6BytkeOsCC1xWU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=K10ncKM8; arc=fail smtp.client-ip=40.93.198.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="K10ncKM8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=npeznuCNun2VTnICckgpfAqtEMRzdBzIemWLB/y/iA6xo24eYikVT9Fyi1Xtjq/20Rfbfs1L5N/sYiiU95IHgCgA/gMmwy3uohoScRu7FqEa5aK5raIqnveqDYTvcFZ6yhxBvzDYdAJ9TWtm5ORY5ww1TKM3eeULDqqbUWbvjMUq/bae+WWHdf+CdoFj1f8VO6To8zvhZs4eI7W9XQmkyoowMosihsJoHU4fLq+d2+gGU2mO3JT4USY/OiUoC5zCzz8+TiIQ9Z/WlDKPuOoJC+sAe2/IyU5uzHITPs4Q+RYQH8mZlCkpUvtSjpi50nlTPsp0E4ahAlEkp7HV7i37vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6CK1O7WazX29KQhYF61xs9GMS+O3FvtgFS3hn3epLQ0=;
 b=QRGo08y5T1z2qx1duK8f4SBm4TFgw2eodktyXIDdmu0ovOvf/unLCRINcNJyLjc4lYbiiNMTwBMeil26cNxVnVpiNiqq4zLbEY4KrbX+pbsidQt5DqfpIx3cSg4XKHj+0gOmPbZ/CEl4jHVMt9/s5WBO38Z7Cva+mbhR8TozPDNxdG9y8nvN/hIHmwUcICFjKfkPpe/dQE6578KnHded8nkY7kOgmVrP2+Czs7ju6D4V1pK0hJKE7Yx+l6IFLhip/iKToUUN10Wu3VgDYDbfNgton0CAp2Ie+Rfrug3cDw0YF1Ch0A8BvVbR2TyEie3J9mPJn21Y/D+Pm8ljn1aLLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6CK1O7WazX29KQhYF61xs9GMS+O3FvtgFS3hn3epLQ0=;
 b=K10ncKM8z4J1HS7EzviLjoG9FosdWRQ/ZKD/QN9V/vOFEVKZSgdKX2J4pwJv4c7DpMKOkm8yHb4Vv2yiyQC8E6hUscCBQW/BI2KI8oNz1hgXiDoi+KKkRXrmjyFIQyyo7HJbzjuRrtBu4NLxeEYohkpM5BypNoCZNDmtQ1FZTVA=
Received: from SJ0PR03CA0016.namprd03.prod.outlook.com (2603:10b6:a03:33a::21)
 by MN2PR12MB4318.namprd12.prod.outlook.com (2603:10b6:208:1d8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Mon, 8 Jun 2026
 18:38:18 +0000
Received: from SJ1PEPF00002325.namprd03.prod.outlook.com
 (2603:10b6:a03:33a:cafe::4e) by SJ0PR03CA0016.outlook.office365.com
 (2603:10b6:a03:33a::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.13 via Frontend Transport; Mon, 8
 Jun 2026 18:38:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002325.mail.protection.outlook.com (10.167.242.88) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Mon, 8 Jun 2026 18:38:17 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 8 Jun
 2026 13:38:12 -0500
Received: from xirsalihe40.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Mon, 8 Jun 2026 13:38:11 -0500
From: Salih Erim <salih.erim@amd.com>
To: <jic23@kernel.org>, <andy@kernel.org>
CC: <dlechner@baylibre.com>, <nuno.sa@analog.com>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <conall.ogriofa@amd.com>,
	<michal.simek@amd.com>, <linux@roeck-us.net>, <erimsalih@gmail.com>,
	<linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Salih Erim <salih.erim@amd.com>
Subject: [PATCH v5 5/5] iio: adc: versal-sysmon: add oversampling support
Date: Mon, 8 Jun 2026 19:38:01 +0100
Message-ID: <20260608183801.1257051-6-salih.erim@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260608183801.1257051-1-salih.erim@amd.com>
References: <20260608183801.1257051-1-salih.erim@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002325:EE_|MN2PR12MB4318:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e8467b8-eea3-43ec-7df7-08dec58d1bcb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|7416014|376014|82310400026|1800799024|56012099006|11063799006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	4N1xColXoXIc4U0diG4679NaE3/dcRjrFXZrJ/ZksjNICZRVQr8acGSSBKowkIujWCKWMI/ywbiM4lvXgBMy+Bj9Mr8KowDI92+tjFslaw7LIQhb5jahXzuZsiy+nWT/s8IBxU8ip90xsX36/nMCUxxZD2gERfAR7GAtdY+t75bnRarPTha4IZYvGBDnQRJ0qVsvBl21aobN9XhpbldO/P/YMwkkORfKXbtU3owt+eg4ujtANmVzxCZaM3tRoIibezAoqYxpH0CcYBdNuKojhl5xptia+Yj0rR8LUq9e2LyRYkjYKiltMRPrWFytkI00FxQyiMUw9mkFCl8pPMWqI6l7SyrLvK520w42B9/Tf4DsFG8GJLl+h9sSOdhS+63s2nQjVM0l9DNS1mGCpWOzjMpcwd49xItkNyqQb+3yY1sQUGZjThq3mhDxbh1+R4pwR3o/DNAD/xAj1ohJCesL334HkVFawK0WO42xuidsXDh5J5+iangKMcrLYugrxpLCqyfCCYXC27ibXqO5IsDLyGdckKUQI8n3aFAmK1toYHFEEhr3JhbfwtU8x5f4RWpYUCkhlnguq6YfDpz0kJrXyWv3h64Huiud3s51mOMNDzqBHA1MPr7kIp0aWxZ6+3GJxSZQNDItqlvNnR8dfDvKUQ0eXJEToCTNJyEyvzFOBMZ/dvWA3Z4yqzg9yK1nvjB3ZacYrFdeg5HwCNgpqfqIW9uQjVDJaazFvxMgysZ9/HY=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(7416014)(376014)(82310400026)(1800799024)(56012099006)(11063799006)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	u9Hm0CuS1gI6h69J5UCaxjCWxXmTpJ0g0d02tOkHUMv+dDOavfO+PwTgo3X60xm6IzPgKs7AX9GCA75E/DnqoFwGKJlxCTfZnEkZiiklfrtYl8YJkLDvX5qiPPzlMNOjfIy4M5bpdoZ62s9IdmzUo0X5ImUoK1hZffgbnh7iBalZcdrgKz+iYyXJDSuKQnTLJ3aLcyCu+z5pacLmYuTd/1TfH5xc/uw2YCv302xJwWTv8xN/Hcu+Q7Swy7QjKM9uG0GYE1C/XGD8Jlvpms3trxHT/sZflRfjrPOpxI4qfQruuNQHM9RTccTv6ncEfoo1/h6Nvfgk908fza0/ZuYyFGMpYsd+5K9aGlhUQG1EkxqcQ2duV+uFb4bEsMX9grxppCTQ515f4oOBWlVWDKCm0KhSCZ1kcl+GAapkB/wSRduNvKvTDV2W127lVj0ESLpF
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2026 18:38:17.9765
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e8467b8-eea3-43ec-7df7-08dec58d1bcb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002325.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4318

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
 drivers/iio/adc/versal-sysmon-core.c | 147 ++++++++++++++++++++++++++-
 drivers/iio/adc/versal-sysmon.h      |  17 ++++
 2 files changed, 163 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/versal-sysmon-core.c b/drivers/iio/adc/versal-sysmon-core.c
index 5fbd509089b..389a8887811 100644
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
 /* OT and TEMP hysteresis mode bits in SYSMON_TEMP_EV_CFG */
 #define SYSMON_OT_HYST_MASK		BIT(0)
 #define SYSMON_TEMP_HYST_MASK		BIT(1)
@@ -194,6 +200,12 @@ static int sysmon_read_raw(struct iio_dev *indio_dev,
 
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
@@ -496,6 +508,127 @@ static int sysmon_write_event_value(struct iio_dev *indio_dev,
 	return -EINVAL;
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
+static int sysmon_osr_write(struct sysmon *sysmon, int channel_type, int val)
+{
+	/*
+	 * HW register encoding is sample_count / 2:
+	 * 0=none, 1=2x, 2=4x, 4=8x, 8=16x (not log2-based).
+	 */
+	int hw_val = val >> 1;
+	unsigned int readback;
+	int ret;
+
+	switch (channel_type) {
+	case IIO_TEMP:
+		ret = regmap_update_bits(sysmon->regmap, SYSMON_CONFIG,
+					SYSMON_CONFIG_TEMP_SAT_OSR,
+					FIELD_PREP(SYSMON_CONFIG_TEMP_SAT_OSR,
+						   hw_val));
+		if (ret)
+			return ret;
+
+		/*
+		 * Readback fence: the SysMon CONFIG register resides in the
+		 * PMC domain behind the NoC. A posted write may not reach the
+		 * hardware before the next MMIO access. Reading the register
+		 * back forces the interconnect to complete the write, preventing
+		 * a bus hang on the subsequent access.
+		 */
+		regmap_read(sysmon->regmap, SYSMON_CONFIG, &readback);
+
+		return sysmon_set_avg_enable(sysmon, SYSMON_TEMP_EN_AVG_BASE,
+					     SYSMON_TEMP_EN_AVG_COUNT,
+					     hw_val ? ~0U : 0);
+	case IIO_VOLTAGE:
+		ret = regmap_update_bits(sysmon->regmap, SYSMON_CONFIG,
+					SYSMON_CONFIG_SUPPLY_OSR,
+					FIELD_PREP(SYSMON_CONFIG_SUPPLY_OSR,
+						   hw_val));
+		if (ret)
+			return ret;
+
+		/* Readback fence -- see above */
+		regmap_read(sysmon->regmap, SYSMON_CONFIG, &readback);
+
+		return sysmon_set_avg_enable(sysmon, SYSMON_SUPPLY_EN_AVG_BASE,
+					     SYSMON_SUPPLY_EN_AVG_COUNT,
+					     hw_val ? ~0U : 0);
+	default:
+		return -EINVAL;
+	}
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
@@ -508,6 +641,9 @@ static int sysmon_read_label(struct iio_dev *indio_dev,
 
 static const struct iio_info sysmon_iio_info = {
 	.read_raw = sysmon_read_raw,
+	.write_raw = sysmon_write_raw,
+	.write_raw_get_fmt = sysmon_write_raw_get_fmt,
+	.read_avail = sysmon_read_avail,
 	.read_label = sysmon_read_label,
 	.read_event_config = sysmon_read_event_config,
 	.write_event_config = sysmon_write_event_config,
@@ -811,6 +947,10 @@ static int sysmon_parse_fw(struct iio_dev *indio_dev, struct device *dev,
 			.address = reg,
 			.info_mask_separate =
 				BIT(IIO_CHAN_INFO_PROCESSED),
+			.info_mask_shared_by_type =
+				BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
+			.info_mask_shared_by_type_available =
+				BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
 			.event_spec = irq > 0 ?
 				sysmon_supply_events : NULL,
 			.num_event_specs = irq > 0 ?
@@ -843,7 +983,10 @@ static int sysmon_parse_fw(struct iio_dev *indio_dev, struct device *dev,
 				   (reg - 1) * SYSMON_REG_STRIDE,
 			.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
 			.info_mask_shared_by_type =
-				BIT(IIO_CHAN_INFO_SCALE),
+				BIT(IIO_CHAN_INFO_SCALE) |
+				BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
+			.info_mask_shared_by_type_available =
+				BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
 			.datasheet_name = label,
 		};
 	}
@@ -890,6 +1033,8 @@ int sysmon_core_probe(struct device *dev, struct regmap *regmap)
 
 	sysmon = iio_priv(indio_dev);
 	sysmon->regmap = regmap;
+	sysmon->temp_oversampling = 1;
+	sysmon->supply_oversampling = 1;
 
 	ret = devm_mutex_init(dev, &sysmon->lock);
 	if (ret)
diff --git a/drivers/iio/adc/versal-sysmon.h b/drivers/iio/adc/versal-sysmon.h
index b5861f7e882..ad97ff699dc 100644
--- a/drivers/iio/adc/versal-sysmon.h
+++ b/drivers/iio/adc/versal-sysmon.h
@@ -24,11 +24,13 @@ struct regmap;
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
@@ -40,6 +42,7 @@ struct regmap;
 #define SYSMON_TEMP_MAX_MAX		0x1F90
 #define SYSMON_STATUS_RESET		0x1F94
 #define SYSMON_TEMP_SAT_BASE		0x1FAC
+#define SYSMON_TEMP_EN_AVG_BASE		0x24B4
 #define SYSMON_MAX_REG			0x24C0
 
 /* NPI unlock value written to SYSMON_NPI_LOCK */
@@ -56,6 +59,16 @@ struct regmap;
 /* ISR/IMR temperature and OT alarm mask (bits 9:8) */
 #define SYSMON_TEMP_INTR_MASK		GENMASK(9, 8)
 
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
@@ -85,6 +98,8 @@ struct regmap;
  * @temp_hysteresis: cached DEVICE_TEMP hysteresis in millicelsius
  * @ot_hysteresis: cached OT hysteresis in millicelsius
  * @sysmon_unmask_work: re-enables events after alarm condition clears
+ * @temp_oversampling: current temp oversampling ratio
+ * @supply_oversampling: current supply oversampling ratio
  */
 struct sysmon {
 	struct regmap *regmap;
@@ -105,6 +120,8 @@ struct sysmon {
 	int temp_hysteresis;
 	int ot_hysteresis;
 	struct delayed_work sysmon_unmask_work;
+	unsigned int temp_oversampling;
+	unsigned int supply_oversampling;
 };
 
 int sysmon_core_probe(struct device *dev, struct regmap *regmap);
-- 
2.48.1

