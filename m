Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011004.outbound.protection.outlook.com [40.107.208.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 432FF33A00C;
	Wed, 17 Jun 2026 18:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781719346; cv=fail; b=ZL601GSlKvazlnXHv7958MrVNQlmIeHWlmkTB8btoqdSTmac6aZP4EfUCWhzReBWgTZa1uHWFvYwGPW6r0RcbtKdF6mFuhkeqT8YPDUfPD/ADxGi7C0cfFGAi8kCFVee/AVQSkMmjvBMVgYQEPBqAV72sieC9nhwkvx+aGlljVs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781719346; c=relaxed/simple;
	bh=6qtF2t2XYMBzGx94yfO9bewzmCtC3C5bg9IuDdMVW5Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eXF3vbOMbO3wuN6uhZnOgiU+zLfzaLuNJ5yuWU8+a5N7GBzAc3Rw0p7B0ZTq6eEUenChBYfBeVnHCl6hD27EnMtZvhRzeRFVR6YTdI7NQP+Baui0M37lRLwhEQSvm/9t7Cxbh5xY5Ge6ZRfwzUFUbOguMiaA1DigF78lH42Znfo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=rrpuA9Qf; arc=fail smtp.client-ip=40.107.208.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="rrpuA9Qf"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e6uYcyg7grYK1swZko8F2vVEEQWCzlPJ08vi/svYfb0qF7ehI3SicOplUxHVMZoG42oYLNAwyjuT/tYS+iwDqOKsc2FyPFR1mkr/ckKZP7IBnQGRfr52pl8lQB36wI0iKpyj7UDCaGXFUXu9ISIqV33jasWKcvqo31EPG/q5ehlCJ9oeNaWX0gnG3hK5H90UuhKMs/fN02KxHQKGIUiWBIj+4A13sLlMtY6EGq/c9s18R8SeJ+otN6q2we76pkcLvjDUa7hssu9TKlgP6DCTgBoB7GoJ1MsiF+g3FcrDf16rU2zGsnODjnZIvvuV+J8Br4hqjcir2IHFoo9E4yRlzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZLE4Y4YxQHnuK28pJwBaBKGWSSGUdf31vsqUax46GxQ=;
 b=k8V23FDhEAeI9lFGjdKQnkvEz5353O+NRpoxnBwbl/yDSRAAKlnOhEor4M/gHHVKSmH/eWpUddq6wzCFh2qXOZqpPRHbGKqU2rRrmK43vfgLQ72ue8VXqkMf0Z5RcM2r453V+Z+HaB2voWTxiES+N7bjw5p+VJzWwgb5+KZAq1UgUjJdOuKO9RMH512UMx/CpzjwadJ2ARf3aMzIsIu44o3Isodfc38EH3AOR4IoHSSZND1bCkV4AEsxTj8a7Isj1nm2P1Nf5WeLItqil9DkYDKOiRX/KvGYkXIV55Huz+YvUTq56Is2Zrx110PqZCdOzu0c4wLjy6nmQERX5LQxng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZLE4Y4YxQHnuK28pJwBaBKGWSSGUdf31vsqUax46GxQ=;
 b=rrpuA9QfCrEnXqk8aA3MqbBn7CtRi6oeVnCH3JBdOA6AHJ1GkxHaAjsek4Jr3jMbynThb6feASqIrNg5/ZCVV3MFV0QJqStLVaelZfUTEHWzfWtn85TcuM/kYGFtcOc0fs3WTylKJT2O9XzbnMIE1qnZq2HCX8kwh1sjMRCYWHo=
Received: from MW4PR04CA0223.namprd04.prod.outlook.com (2603:10b6:303:87::18)
 by CH3PR12MB8971.namprd12.prod.outlook.com (2603:10b6:610:177::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.14; Wed, 17 Jun
 2026 18:02:16 +0000
Received: from CO1PEPF000066EA.namprd05.prod.outlook.com
 (2603:10b6:303:87:cafe::22) by MW4PR04CA0223.outlook.office365.com
 (2603:10b6:303:87::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.18 via Frontend Transport; Wed,
 17 Jun 2026 18:02:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CO1PEPF000066EA.mail.protection.outlook.com (10.167.249.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Wed, 17 Jun 2026 18:02:13 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 17 Jun
 2026 13:02:03 -0500
Received: from xirsalihe40.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 17 Jun 2026 13:02:01 -0500
From: Salih Erim <salih.erim@amd.com>
To: <jic23@kernel.org>, <andy@kernel.org>
CC: <dlechner@baylibre.com>, <nuno.sa@analog.com>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <conall.ogriofa@amd.com>,
	<michal.simek@amd.com>, <linux@roeck-us.net>, <erimsalih@gmail.com>,
	<linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Salih Erim <salih.erim@amd.com>, "Andy
 Shevchenko" <andriy.shevchenko@intel.com>
Subject: [PATCH v9 5/5] iio: adc: versal-sysmon: add oversampling support
Date: Wed, 17 Jun 2026 19:01:47 +0100
Message-ID: <20260617180147.3370346-6-salih.erim@amd.com>
X-Mailer: git-send-email 2.44.4
In-Reply-To: <20260617180147.3370346-1-salih.erim@amd.com>
References: <20260617180147.3370346-1-salih.erim@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000066EA:EE_|CH3PR12MB8971:EE_
X-MS-Office365-Filtering-Correlation-Id: 4cccda32-31e3-438b-ddd4-08decc9a8f34
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700016|82310400026|23010399003|1800799024|22082099003|18002099003|6133799003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	Jwa6HoL8ZiStRIeD3DxJm/Q/U6TJkdOMyLAYwopBgBUZjgckzeULOinJBDMtW1mHgGS2hh11pTquxxy3VBQEbWHEBxPM59tCtAduXjveeFZx9MNdjaVu689i8AFiQVIvgRBOguDtHeEQQCUTkaSrC6lzyLrFkss6a7s26fjTAG3NQgYBjMUMzbpBw3OGzXwqt3SQw2iYM1snW/I4I8xRHhsTIs7WMvZ08sr58IVMTQfSZszUVQS1LhJhxFlsgVKevY7/EY/s0rwtaBjoz2YKvig4UArT2YnMOW9qjqJB5AU9fy1lgtmi8AEHnNu4b4RYOCGIABFDXtO34xYRiYwUNMZq8urVdx0ttOOBpyW/QBM/xh3IrTg5QQ3ZCXk/XLmqEpwMYxr6lkjhwZU2Ll9Gldpv9YuaT63jLGZyxLZ7FwUlLPTJco9mdFXn+8aaJBeZEj5k5P2afihcBX0iRaSitrLYrd+bFe6rlEi4AVp+2lheEZMjUfSmNOOlxKKQOOHEgXq/cJCAEYIiJkfBPxl1T8SdA/9Vnc7kh2cJcYlqfkUG+41wJmoGlvMkCosihTLURysNAmYqR6/EfOlnKNyRAfwov8Xja/n7+rM+6qm55J6NxnU9BBtwQCSJhUTjbE3Bjd91enyvQ8WxWE5lWYeRWHsObVZ+XbYMewYK3vRcPbU7zflHxeemhSIFmtEB5UujN0qtDTMeKZYIbdIB53AoivY9XIFhWWjusZmeHHUlahM=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700016)(82310400026)(23010399003)(1800799024)(22082099003)(18002099003)(6133799003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	E1JaL/jtO8AVgPi9H5tGd4PwVwTNsaEQ5h6oVb8b0BNKCWs7PdoXLl5tAEvrIKBSSeO2kcAASAuAo7E+WLIyUFG62cutAqejKmYnXI0i1/40tElUGNTy3ONdhIC/v26s1PWQeXTGrhjIORta5Wog6W25+fixHLvl7k+y/CZwKu/UtVwjMrUkHtWNiU8REA43QJb+dYfArvmGpLEvxhb+/aZSgpWZObk3TW9zm1Jltwi0r4cfDYivEExr9IRMBMX5HGwHcdNin173eOOo/TpKqufJwIfjN28Y+wcQB3dYJeacxM+GUSIE8xnVi6EBwcALUAyrJTNY1cqxeexZHsNayxTZwiSP9dVFbzg6sHniwc3M0w8Q5jPGDKdSuRR1Gd9IhMDhYDJKS0OdcEAbwzTMueFY6jAVjHv/eY+kP+F9pbjKtdX8//oVAq6JvWfq/EOr
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2026 18:02:13.1438
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cccda32-31e3-438b-ddd4-08decc9a8f34
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000066EA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8971

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
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
---
Changes in v9:
  - Add Reviewed-by tag from Andy Shevchenko
  - No code changes

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
index 19a8edd8919..16f474c1bff 100644
--- a/drivers/iio/adc/versal-sysmon-core.c
+++ b/drivers/iio/adc/versal-sysmon-core.c
@@ -27,6 +27,12 @@
 
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
@@ -451,6 +463,132 @@ static int sysmon_write_event_value(struct iio_dev *indio_dev,
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
@@ -463,6 +601,9 @@ static int sysmon_read_label(struct iio_dev *indio_dev,
 
 static const struct iio_info sysmon_iio_info = {
 	.read_raw = sysmon_read_raw,
+	.write_raw = sysmon_write_raw,
+	.write_raw_get_fmt = sysmon_write_raw_get_fmt,
+	.read_avail = sysmon_read_avail,
 	.read_label = sysmon_read_label,
 	.read_event_config = sysmon_read_event_config,
 	.write_event_config = sysmon_write_event_config,
@@ -754,6 +895,10 @@ static int sysmon_parse_fw(struct iio_dev *indio_dev, struct device *dev, int ir
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
@@ -785,7 +930,11 @@ static int sysmon_parse_fw(struct iio_dev *indio_dev, struct device *dev, int ir
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
@@ -832,6 +981,8 @@ int devm_versal_sysmon_core_probe(struct device *dev, struct regmap *regmap)
 
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

