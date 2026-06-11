Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011011.outbound.protection.outlook.com [52.101.57.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 838AB3CF1E9;
	Thu, 11 Jun 2026 22:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781216878; cv=fail; b=Iy4eu+xUVLXfCoFLUNIq8L5Rud8mXPEliGKywqfnWMcx41+/dNe1LSXO7FDXRKLtnzjUmp1/wr/ay4XCWGL/s3H4XhSo/ttzPlL/YR47Qglj90tKi8++iZAUD+HWhjyZdl6nUF7SfeHYs9BIEOiMxVRi3fJ2zxEmpGAuhZs4YIg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781216878; c=relaxed/simple;
	bh=ResQTKMsBjVSfNqfI+uyzz9VlQSEVOYfp4FvYahxbRg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hw/Bd7q4SHBRORqFUj0qT/X7Dgy9wKm2R+2yTriuCYNhGNeiWLiIm1yRwCJ90FRLWHpgN0LY9XcTE7Pqb1kZN3tuqj5OFVIsIM9Lp+a/Zncp75Wb1fXkyLWX3jWUmjNg4+Ei3tOoR3SnLIDQ0WhQ49sBIr8PINLigBflazvR2gA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=u22htS2c; arc=fail smtp.client-ip=52.101.57.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="u22htS2c"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bwvCZbKJQfuQbIte7kZABxeQP5GMVEMQ1A/l+Oq3gFfWRE5g6WrB9UbsbtYZHJYMB4/+/oHAQYvUm/oyPz3rBN0JVkWc+nFcrj3V5xCPpqMb5hW5BB0LrwX42FcUsrbTqSJy9jjD0n/VqU8oxbKHWpXzAlVl1abUoY9kBQ8IfAnR2IrivGVYCyuOIPdVyJM1FxWN97S3lxEJ5B6JsPM3G4CaaHU91R3rj8lhYz8UwEgWAzN+W+wnjq4kQBx0G+fVkYnehI0G4DZ5/U4AajqbU6KZ2WvfqJySW0UD6TRW+ZOhFKFLi8oLJ351Cw0G2KAad0pArOfo/H5jTjLqBpgVOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OmAGYd7A5d7A4Z/wuaMOGj+eisTeJD+cCQy2iS0E61A=;
 b=nGlOuFTKaoePt7zXz9onRnKY07nryW0z8gfXoOFpMlLJxac/iJHWvHb2BAe6scarlJiIxwr1CUFKd2gHGdLeLSYQ11u4B14jvzNuEuiVYJLC7p+xDAPht9ty9fKTSgU1fde8RaqefojKGeA0zrk690LUVne43vxGJh/9nzBIsqgQSWva91TyKJb1rpnr+AhN+CRBR3z2donXTNFX9KdWBqniykit0zOoIxUyJ4R9ipSkpRbzWm7cx9p/EFNsHNOsfd2HyQS3222zjuT6B4fqSD41LUDW8s+HzKmSZRzhtFALlpxwDM2dXjbi+rT5O5BuLAsA+Juo02TYxhH344dEZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OmAGYd7A5d7A4Z/wuaMOGj+eisTeJD+cCQy2iS0E61A=;
 b=u22htS2c8uoqZKrEEipiEwjzTZuvBtuv5nwPQtxluQ/pLvBGZp5lm3riTagTTj9uM1jvKuBh2Sn4TRdmj3mmf3e4Vq58/YTIHrE5eZ5bxRc+LW/4DykwcPrRoZKQyiL5tBP0ItG4f/zzD6fZGPRF62+CAWr8Gpxe1DaBpeTodTY=
Received: from CH2PR17CA0012.namprd17.prod.outlook.com (2603:10b6:610:53::22)
 by MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.13; Thu, 11 Jun
 2026 22:27:50 +0000
Received: from CH2PEPF00000147.namprd02.prod.outlook.com
 (2603:10b6:610:53:cafe::8c) by CH2PR17CA0012.outlook.office365.com
 (2603:10b6:610:53::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.14 via Frontend Transport; Thu,
 11 Jun 2026 22:27:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF00000147.mail.protection.outlook.com (10.167.244.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Thu, 11 Jun 2026 22:27:50 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 11 Jun
 2026 17:27:49 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 11 Jun
 2026 17:27:49 -0500
Received: from xirsalihe40.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Thu, 11 Jun 2026 17:27:48 -0500
From: Salih Erim <salih.erim@amd.com>
To: <jic23@kernel.org>, <andy@kernel.org>
CC: <dlechner@baylibre.com>, <nuno.sa@analog.com>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <conall.ogriofa@amd.com>,
	<michal.simek@amd.com>, <linux@roeck-us.net>, <erimsalih@gmail.com>,
	<linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Salih Erim <salih.erim@amd.com>
Subject: [PATCH v6 5/5] iio: adc: versal-sysmon: add oversampling support
Date: Thu, 11 Jun 2026 23:27:38 +0100
Message-ID: <20260611222738.2035062-6-salih.erim@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260611222738.2035062-1-salih.erim@amd.com>
References: <20260611222738.2035062-1-salih.erim@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000147:EE_|MN2PR12MB4488:EE_
X-MS-Office365-Filtering-Correlation-Id: 13f4820f-b1c8-4c66-c454-08dec808abda
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|82310400026|376014|23010399003|1800799024|36860700016|11063799006|56012099006|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	sdDtj7RgP1sNmHzPS/1NB3VD4cz4qqi+/pHpC/hH9hzuwHe41NsokesYcA/FDTl4zelohCkeBuMR4TLgwpAj2Gk/BSl/JF84ZHitxUS04fenQaKkJ5pU1hKcIi1YJGWtF5xqXonipPo80wR5a3w3d9hcQJ5//AidehBWvvBaXmWy4wDT9bEdTm2YT9aWzWuNMy0hbeBaR4ZjRDT9dLPDWXpsp0lzv1ukj1WIoNQ9VeGhlDo4Ews98+2N8erdcssyhQ7JSO69dbp+G7j54tZYf5oiKRgvQv1XzM2hU5PHhtIYvhqWf/vS8Q7TQhpmB0/lOXD+0IcYw9t+COLjSWazKXA29MotDyum5B3HXiLwiCUkWwnY1d3pWFpGbCSTIF6XiJDiRZWrbrIHnQKxgWAJgaM2Ylzm26vBQuVpax86hyrCCzNyfF+uzh5vHwzTltZLp+gosZ5mLJTijxfj5eM+iEMvtjeW71YUaqXqPy/tCQg+vHQMaJPfn71WQ378toM54pTs9KdaRKYUSMocOk3nKyfQl8z4FMqFuvn5MVsS8Y0o65PhF6Wsq/NkfVab56nO2zGgYePVR9XTlygazaq5LZY7KL/5WReY/Z2CQeUBeD/BTjZtA3Wrebl9J9givfvje4RZv4myQcySKxsNDPtaLhNCMNd9HLEsQP2FHQ1CCElKkmRSdoR29nJdGA7Ka2FDm/oQ2pbIfSGIgl/TbW2/pCQ2OTui8s5fkM0gAhEvOjg=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(82310400026)(376014)(23010399003)(1800799024)(36860700016)(11063799006)(56012099006)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	AZaQaIJmsgPnMnxrxky4LAY7aEyVJu6pAx3YU64Q2um3UveSW5xbvxkoRVTRIKQRA6si0uic2UpDmX/Q5NXln4BUFtYKukeLC0HZ8FwgiqtBILnlOVbA2PDB8OvKkKOReLHaagAUZK8zF1QISXacV6vCKlTq3lXwWJxzkMe0y+bpiFyAASwmql+BYLpQy5i1Uj7mvm+mS5KrNrGmWFJd6CVgqe8cz5C47xaIeIXAz+S/CYbG3mIl/3gbTQY5+LNvFGeUZRNRUhaqjlWjYGWSVZE1gGXmcIZzIEhvAV3avtb1LLRwAWT69jSn8gsTmqOX/c1Zo3Y9uaAf9Urr5YzqJ6qEkFs08F5lXshQIi+4mgjzLYBVYMggQ9Lb7SlIsRGsazYbTR6WEjslPgOTgtHDcozra5nVxr3gGwcat+glYCVL0pwhMJA4jBqpFLDz2oM8
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 22:27:50.1165
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 13f4820f-b1c8-4c66-c454-08dec808abda
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000147.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4488

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
 drivers/iio/adc/versal-sysmon-core.c | 147 ++++++++++++++++++++++++++-
 drivers/iio/adc/versal-sysmon.h      |  17 ++++
 2 files changed, 163 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/versal-sysmon-core.c b/drivers/iio/adc/versal-sysmon-core.c
index 20fd3a87d44..fa8f0dc868a 100644
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
@@ -196,6 +202,12 @@ static int sysmon_read_raw(struct iio_dev *indio_dev,
 
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
@@ -515,6 +527,126 @@ static int sysmon_write_event_value(struct iio_dev *indio_dev,
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
+					FIELD_PREP(SYSMON_CONFIG_TEMP_SAT_OSR, hw_val));
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
+					FIELD_PREP(SYSMON_CONFIG_SUPPLY_OSR, hw_val));
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
@@ -527,6 +659,9 @@ static int sysmon_read_label(struct iio_dev *indio_dev,
 
 static const struct iio_info sysmon_iio_info = {
 	.read_raw = sysmon_read_raw,
+	.write_raw = sysmon_write_raw,
+	.write_raw_get_fmt = sysmon_write_raw_get_fmt,
+	.read_avail = sysmon_read_avail,
 	.read_label = sysmon_read_label,
 	.read_event_config = sysmon_read_event_config,
 	.write_event_config = sysmon_write_event_config,
@@ -826,6 +961,10 @@ static int sysmon_parse_fw(struct iio_dev *indio_dev, struct device *dev,
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
@@ -857,7 +996,11 @@ static int sysmon_parse_fw(struct iio_dev *indio_dev, struct device *dev,
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
@@ -904,6 +1047,8 @@ int sysmon_core_probe(struct device *dev, struct regmap *regmap)
 
 	sysmon = iio_priv(indio_dev);
 	sysmon->regmap = regmap;
+	sysmon->temp_oversampling = 1;
+	sysmon->supply_oversampling = 1;
 
 	ret = devm_mutex_init(dev, &sysmon->lock);
 	if (ret)
diff --git a/drivers/iio/adc/versal-sysmon.h b/drivers/iio/adc/versal-sysmon.h
index 2c6cea64ddf..c6b9e496c1c 100644
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
 #define SYSMON_OT_TH_LOW		0x1978
@@ -39,6 +41,7 @@ struct regmap;
 #define SYSMON_TEMP_MAX_MAX		0x1F90
 #define SYSMON_STATUS_RESET		0x1F94
 #define SYSMON_TEMP_SAT_BASE		0x1FAC
+#define SYSMON_TEMP_EN_AVG_BASE		0x24B4
 #define SYSMON_MAX_REG			0x24C0
 
 /* NPI unlock value written to SYSMON_NPI_LOCK */
@@ -55,6 +58,16 @@ struct regmap;
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
@@ -84,6 +97,8 @@ struct regmap;
  * @temp_hysteresis: cached DEVICE_TEMP hysteresis in millicelsius
  * @ot_hysteresis: cached OT hysteresis in millicelsius
  * @sysmon_unmask_work: re-enables events after alarm condition clears
+ * @temp_oversampling: current temp oversampling ratio
+ * @supply_oversampling: current supply oversampling ratio
  */
 struct sysmon {
 	struct regmap *regmap;
@@ -104,6 +119,8 @@ struct sysmon {
 	int temp_hysteresis;
 	int ot_hysteresis;
 	struct delayed_work sysmon_unmask_work;
+	unsigned int temp_oversampling;
+	unsigned int supply_oversampling;
 };
 
 int sysmon_core_probe(struct device *dev, struct regmap *regmap);
-- 
2.48.1

