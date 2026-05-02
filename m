Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013014.outbound.protection.outlook.com [40.107.201.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A78CF2BE03B;
	Sat,  2 May 2026 11:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777720888; cv=fail; b=rFvuKGzUMWWfUy41d8TD0mP5BLspiTjWAF6Pg/hMhI5PO8v1FDU68SSixb4dbfxDPZuV8h9xJXpFIocHPe+TzEIzCPcl3gGvvgffn0U7f8V2tFENCLZ5jwW9WvkEwghoFtdbPQKU/5quvZsDY9+38dYOmFAHIopWnOzCvwC0KxY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777720888; c=relaxed/simple;
	bh=zFY7aO23S30KR1a5jyNdJ0IT+5j0chP38nQqSqv8/9Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gq52xShfVHS3xfKi1RFK/5j+8JShJcpapfTICa2qMFET+iesDI9mjtc6rEFo8ugPBYzw5hx/HKkp2miBKJCoQopwcW/ktmr0JGIk9WhyrvPsc01xYw7vMTJ04hjMW+glS+MwRknBHe5T9AkpD/NkgfKbyTp17GfL9bwvsrJfq68=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=xvViw+Sv; arc=fail smtp.client-ip=40.107.201.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="xvViw+Sv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n1nNfBx2G8XSvqLFk/39IURCyeQTEXcexXJO7nI7K7NpoBG9xBynApyTV2HJ7d3iO3n1QM6VnYk6CPnC/UFv5J36gylycyfIt9UrrUNWZxn7kkMtFdkx+Wvk40sPUvY/p6i0sNoY2hqMN8qfJcCBXIiCkVW0pcRJkMasMJHe8Z+ybCKXbDni6um2BLdq7Lcho79JErQEOL/Bp9v6F3aCX/m0UHgOtf7KaHLOdA/Mp73fofrs3NkuoH8NsSkSeDxHV+Q6Ynl5JHQ91ot9BY2DDrA4GP/4WmDGVUYGpFX/mX5TA5qRC4pgu3ZJtW0ZKVV8Bb2Tyv5gRmsH3c1zqkS9pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9UZCzxxVrs7L+utEUYWoMR0Bkd1q/hb++FR1ZSmylY8=;
 b=KTllYS5ZPTePTY337Nvsg2Q4jNkhCryeTeV4Za8ic32HXMjV4DqGsTek5DBQrMfEdbVgAIx89arhLGB6abwBi1+1aC1+aMHRFVpjWzqgdX5hnULtvNIphQcWYL4c5q5gewXLK8pdbfcbaNSVkB3wcIWo3Ok9f5ts/8ES8L38QZdyEi0byFSNokc9HTRwSnho0k6S2gsQDZuUyDcGIXcImh5nv3htx6b8Ay5e+HIxXSihD/OJmAJ5gO1aUUUbm7Kf+fpHdib0mM4a4MIGtuvSPplxCdSmQnrbTXiD8bB7WpD4Al1N5Pipw4Z9P+4QCz3JbNjhl/oIiEBIXCNddY0XvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9UZCzxxVrs7L+utEUYWoMR0Bkd1q/hb++FR1ZSmylY8=;
 b=xvViw+Svl5Cx0A39ZHjSeiZhi0a1cF5XaiPB7ujlXv97mOZH8/bI/hcuqyWYv0xYq+IdseAT5gth63y+//CjFKZrFBSyq9A0xAIlXWbhVwm0H1xame/XyUoMm/hYaFbrGjGMudQzgGqX7Q52xswY9QwzhjtNq51Y4C/y+QANwgg=
Received: from PH7PR17CA0002.namprd17.prod.outlook.com (2603:10b6:510:324::22)
 by IA0PR12MB8906.namprd12.prod.outlook.com (2603:10b6:208:481::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.23; Sat, 2 May
 2026 11:21:19 +0000
Received: from CY4PEPF0000E9D5.namprd05.prod.outlook.com
 (2603:10b6:510:324:cafe::57) by PH7PR17CA0002.outlook.office365.com
 (2603:10b6:510:324::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9870.23 via Frontend Transport; Sat,
 2 May 2026 11:21:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CY4PEPF0000E9D5.mail.protection.outlook.com (10.167.241.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Sat, 2 May 2026 11:21:18 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Sat, 2 May
 2026 06:20:17 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sat, 2 May
 2026 06:20:15 -0500
Received: from xirsalihe40.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Sat, 2 May 2026 06:20:14 -0500
From: Salih Erim <salih.erim@amd.com>
To: <jic23@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <git@amd.com>
CC: <nuno.sa@analog.com>, <andy@kernel.org>, <dlechner@baylibre.com>,
	<michal.simek@amd.com>, <conall.ogriofa@amd.com>, <erimsalih@gmail.com>,
	<linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Salih Erim <salih.erim@amd.com>
Subject: [PATCH v2 5/5] iio: adc: versal-sysmon: add oversampling support
Date: Sat, 2 May 2026 12:19:51 +0100
Message-ID: <20260502111951.538488-6-salih.erim@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260502111951.538488-1-salih.erim@amd.com>
References: <20260502111951.538488-1-salih.erim@amd.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: salih.erim@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D5:EE_|IA0PR12MB8906:EE_
X-MS-Office365-Filtering-Correlation-Id: 98227c10-d7ba-49e4-8cb6-08dea83ceeab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|36860700016|82310400026|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	anA8xOVZ3EUWeTEu50trRNQ7AUlkLAUhfZeTRMEv0cXqGFvBfaUq47TBwcllt9i0u9LhySMTpipanJJZegECN2sH3aNE/7/VLMe+Vk8HgmpOhIudCSUKQudaSkABj0EqlwyoAs7RJTgbIUJVw+vklWFJhTiLKGMmFO3eRQihL2kdhHDeCBJa2H7AkZfmZcJk1U3aEoZ9uRGo9TYXmVYYA+uM0zTSw3RIdwHIbVoWjFH70VdJSjW4rGwmhuXVYuGsa0sF8fNukjTZq3TzNOa8mKQ/GeMOWKK9rqHzTmFd2saDQ1Qf1XeC1+nOx3cczElc+3Zebb94bSL4gj+QvzuQJAw+oOC4FVQNYtoKPLh149udgYagCzm/1zqZ5yALMsWLjjd4vJe7+eDiDbKiw8bTYs1ntilVojC75JpdeqvO2bKPIBJitS7Z6MOEvgjHSjw1Caom2iVv1doO13gadiqNtumOLhk/Q8UEgxCxS8ekHCJ9lIjCsheHMqnTMuQO72Y7KmZ5QV/TzMjqERUYl22m4QbOdV9IOo6yfZffZTg9ZHBLySDV5jrGLHrbAQSs4zEpwErp5pVN6SOT+ySMW838sfordEo/jzil0HJsZcH8vbR5SFSG0u3SR3QXeAFvWIrl6iq943L+KasU3ih2JJnzwWwD2hMsF73df82WY1mIDNk6CYDbL36Yr9a9Nyxka5nxjgRvM/ovVlvz5p6emcLOyRQxA4Srq/m0EtddSPTsWWk=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(36860700016)(82310400026)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	I9UIC1Y8w7Kkm1+M3iGI/J1NBI44n6cqUZB+v0m0FBeaRcqGSqZJ/fgFk9XmQ75hA1PB4SqEkC6emS/aVZYRPmoiFlRb6cqXxOP9H9MFQBBUutBx+ITRxFAgMGLyX7WCS/zKGgrH+SMUZdV4uVAkeCt5XpfThXI8R2XG+Vxr5ez3sdGd5fRbKupmfuhRt7SOAKm5fPW9Qi41qCRMxMOt23pgN8cnmiRI4XSIWjW/N4YUMeIsmjMf6UVPfQZHgVawot6Hi1YlHV+vbMliabK7EXihHqu4s96FW9x56TPiTwRA3vt4a+ptnKKTrYEUBMd7J/ZIuIcMNCrNKbo4t8KZIeJyay0iLhWPUxSb79g9wPGcI3SXCpuJ+FfN4ycE1hZ3ugtApsTva3QtvCFIxHWt/PQOhskKnapd1KADXD+aYgC+6uP6HHdTFPq1PTl74LBn
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2026 11:21:18.8047
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 98227c10-d7ba-49e4-8cb6-08dea83ceeab
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8906

Add configurable oversampling ratio for supply voltage and temperature
satellite channels. The hardware supports sample counts of 1 (no
averaging), 2, 4, 8, and 16. The userspace-facing values represent
actual sample counts; the driver translates to hardware register
encoding internally.

Oversampling is shared by type: all supply channels share one ratio
and all temperature satellite channels share another. Static
temperature channels (device max/min/max_max/min_min) are hardware-
computed aggregates and do not participate in oversampling.

When oversampling is changed, the driver updates the per-channel
EN_AVG register bitmasks so that all channels in each bank have
hardware averaging enabled or disabled to match the oversampling
configuration.

Register write errors in the per-channel EN_AVG update path are
propagated to userspace.

Signed-off-by: Salih Erim <salih.erim@amd.com>
---
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
 drivers/iio/adc/versal-sysmon-core.c | 137 +++++++++++++++++++++++++++
 drivers/iio/adc/versal-sysmon.h      |  17 ++++
 2 files changed, 154 insertions(+)

diff --git a/drivers/iio/adc/versal-sysmon-core.c b/drivers/iio/adc/versal-sysmon-core.c
index 857fe21db7a..9c3ce8f8fdf 100644
--- a/drivers/iio/adc/versal-sysmon-core.c
+++ b/drivers/iio/adc/versal-sysmon-core.c
@@ -19,6 +19,12 @@
 
 #include "versal-sysmon.h"
 
+/*
+ * Oversampling ratio values exposed to userspace via IIO.
+ * Actual number of samples averaged: 1=none, 2=2x, 4=4x, 8=8x, 16=16x.
+ */
+static const int sysmon_oversampling_avail[] = { 1, 2, 4, 8, 16 };
+
 /* OT and TEMP hysteresis bit positions in SYSMON_TEMP_EV_CFG */
 #define SYSMON_OT_HYST_BIT		BIT(0)
 #define SYSMON_TEMP_HYST_BIT		BIT(1)
@@ -202,6 +208,12 @@ static int sysmon_read_raw(struct iio_dev *indio_dev,
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
 
@@ -438,6 +450,118 @@ static int sysmon_write_event_value(struct iio_dev *indio_dev,
 	return -EINVAL;
 }
 
+static int sysmon_set_avg_enable(struct sysmon *sysmon,
+				 u32 base, u32 count, u32 val)
+{
+	unsigned int i;
+	int ret;
+
+	for (i = 0; i < count; i++) {
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
+					   SYSMON_TEMP_EN_AVG_COUNT,
+					   hw_val ? ~0U : 0);
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
+					   SYSMON_SUPPLY_EN_AVG_COUNT,
+					   hw_val ? ~0U : 0);
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
@@ -450,6 +574,9 @@ static int sysmon_read_label(struct iio_dev *indio_dev,
 
 static const struct iio_info sysmon_iio_info = {
 	.read_raw = sysmon_read_raw,
+	.write_raw = sysmon_write_raw,
+	.write_raw_get_fmt = sysmon_write_raw_get_fmt,
+	.read_avail = sysmon_read_avail,
 	.read_label = sysmon_read_label,
 	.read_event_config = sysmon_read_event_config,
 	.write_event_config = sysmon_write_event_config,
@@ -715,6 +842,10 @@ static int sysmon_parse_fw(struct iio_dev *indio_dev, struct device *dev)
 				.info_mask_separate =
 					BIT(IIO_CHAN_INFO_RAW) |
 					BIT(IIO_CHAN_INFO_PROCESSED),
+				.info_mask_shared_by_type =
+					BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
+				.info_mask_shared_by_type_available =
+					BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
 				.event_spec = has_events ?
 					sysmon_supply_events : NULL,
 				.num_event_specs = has_events ?
@@ -760,6 +891,10 @@ static int sysmon_parse_fw(struct iio_dev *indio_dev, struct device *dev)
 				.info_mask_separate =
 					BIT(IIO_CHAN_INFO_RAW) |
 					BIT(IIO_CHAN_INFO_PROCESSED),
+				.info_mask_shared_by_type =
+					BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
+				.info_mask_shared_by_type_available =
+					BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
 				.scan_type = {
 					.sign = 's',
 					.realbits = 15,
@@ -823,6 +958,8 @@ int sysmon_core_probe(struct device *dev, struct regmap *regmap, int irq)
 	sysmon->indio_dev = indio_dev;
 	sysmon->regmap = regmap;
 	sysmon->irq = irq;
+	sysmon->temp_oversampling = 1;
+	sysmon->supply_oversampling = 1;
 
 	ret = devm_mutex_init(dev, &sysmon->lock);
 	if (ret)
diff --git a/drivers/iio/adc/versal-sysmon.h b/drivers/iio/adc/versal-sysmon.h
index 4f20173de77..9fa7a7486de 100644
--- a/drivers/iio/adc/versal-sysmon.h
+++ b/drivers/iio/adc/versal-sysmon.h
@@ -21,11 +21,13 @@
 #define SYSMON_IMR			0x0048
 #define SYSMON_IER			0x004C
 #define SYSMON_IDR			0x0050
+#define SYSMON_CONFIG			0x0100
 #define SYSMON_ALARM_FLAG		0x1018
 #define SYSMON_TEMP_MAX			0x1030
 #define SYSMON_TEMP_MIN			0x1034
 #define SYSMON_SUPPLY_BASE		0x1040
 #define SYSMON_ALARM_REG		0x1940
+#define SYSMON_SUPPLY_EN_AVG_BASE	0x1958
 #define SYSMON_TEMP_TH_LOW		0x1970
 #define SYSMON_TEMP_TH_UP		0x1974
 #define SYSMON_OT_TH_LOW		0x1978
@@ -37,6 +39,7 @@
 #define SYSMON_TEMP_MAX_MAX		0x1F90
 #define SYSMON_STATUS_RESET		0x1F94
 #define SYSMON_TEMP_SAT_BASE		0x1FAC
+#define SYSMON_TEMP_EN_AVG_BASE		0x24B4
 #define SYSMON_MAX_REG			0x24C0
 
 /* NPI unlock value written to SYSMON_NPI_LOCK */
@@ -53,6 +56,16 @@
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
@@ -85,6 +98,8 @@
  * @masked_temp: currently masked temperature alarm bits
  * @temp_mask: temperature interrupt configuration mask
  * @sysmon_unmask_work: re-enables events after alarm condition clears
+ * @temp_oversampling: current temp oversampling ratio
+ * @supply_oversampling: current supply oversampling ratio
  */
 struct sysmon {
 	struct device *dev;
@@ -98,6 +113,8 @@ struct sysmon {
 	unsigned int masked_temp;
 	unsigned int temp_mask;
 	struct delayed_work sysmon_unmask_work;
+	unsigned int temp_oversampling;
+	unsigned int supply_oversampling;
 };
 
 int sysmon_core_probe(struct device *dev, struct regmap *regmap, int irq);
-- 
2.48.1

