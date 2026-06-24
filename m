Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012068.outbound.protection.outlook.com [40.107.200.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0DCD3C2794;
	Wed, 24 Jun 2026 14:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782311975; cv=fail; b=iwmDxV1d+NtZLhksFnbCDaJSqsOD7s/zvXT5Vet3AWs68qHvIqAG26MfePHvUwvMOC0aq+3GI4t/Ylp+29Gp9odiYSuhNpsaY8pqh8HvBN9FCWaSuWDpMwIUXCAdJyMwol4dYdL+fm+rzAhCRi38XRav2eYeQT69Vu3fTtotXOI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782311975; c=relaxed/simple;
	bh=yzFxhWQc5mxZEiy8R5bgsigQ8+kcHZS2mSqWZEOGTkk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qOvWwZIAPqk5K1aDDgwqwlGKJI0o80mB5fv7JMIBm3iJ93ZGycM4WwwKGMTaD3wXLcbyGqf1LdtOYnVjsCXKGFklJOEQakA1GRnxROyJUSy4msr55k8UowRZXqvncwJ2wBSL2b1kSeU0VBjV7Yum9o0LEG1T1na5NZ/PRguQaGs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Es2glisq; arc=fail smtp.client-ip=40.107.200.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Es2glisq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j4BQJiGLcKTD+pp0WPxPWPW4keNJthLqWsFT8mHGyKWRk4vsK0HoPh2vL1yHj/wbEoYCNfiu8xssFZngQ4hPrzXC30k8Gfp/YaXRSfT/ZaIQalWExc6aQQ1bDBAIRlGcMfEKtHvi1qT1ufRH+xd0WMujdNh7CWlhuYMuZcz4BmiHjVLDjNCGt6YwkMV2yZPmQlPa4DiPW4wqDi/8C0BWitgiEczziaJxAO+o7KJ3Up5dgftPpxG7i/uwdMG7hWIbBBrfNKVlZcM3dmA6kAVa35tbyi1/EosQ1SQt9oYAIJf8hljXZntvbwgyVYG8+fAYW6w6XOM8hmililWR5z5vrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FtQkOQ6xL6Gs1JH6WbrTKTzRixQiN7VXwYJe/vlqsqI=;
 b=LlSzDAqXlLm770VEKnPgcU7u4JJI22pG8MSERNDI2iGKOUaIY7wB5rohEau7PtdFyQUBvZfI1jg0kMpxsgn6GEP33eVmyCOhmaoLH1EIgCyIC2g8Vrt6i7PtiZ3pzl5ZiVwqdt4E++Ym/51LBjsffheSkLuPifoeonGIARwYMPQat+vTUhzG7gMfPGHYPVzhvanWxJw51ts27xGOZJb7yMho9/HskdmWPMP0uUKNi2EscDGjmWzkoHiMPALOBd/GkTQs85Ss1SAZJszJvtsbiM23HCMZfucmOfTfMz3KQCpk9XEniNVIrOcOkc2BItaIW+BvpvnHV9IzdOqNO4iKzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FtQkOQ6xL6Gs1JH6WbrTKTzRixQiN7VXwYJe/vlqsqI=;
 b=Es2glisqNpUbxE0p19wI0emiDiKOyXkn1NLkZ1OEs9//xp73yEHQVQ2VJq2vRS7Hf2ZXJyAhHAq7Hu0jIHFgdBlO5br9ydHkxFR5i2D3Y+jSTu3xj7k1Rc9Z/4QZDaueu1tAP0PgoCd4pHC9ktnT3Ed+XHbntDbxs/ad5x3X+p4=
Received: from PH8PR21CA0014.namprd21.prod.outlook.com (2603:10b6:510:2ce::28)
 by DS2PR12MB9664.namprd12.prod.outlook.com (2603:10b6:8:27b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.13; Wed, 24 Jun
 2026 14:39:23 +0000
Received: from SN1PEPF0002BA4D.namprd03.prod.outlook.com
 (2603:10b6:510:2ce:cafe::9d) by PH8PR21CA0014.outlook.office365.com
 (2603:10b6:510:2ce::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.6 via Frontend Transport; Wed, 24
 Jun 2026 14:39:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF0002BA4D.mail.protection.outlook.com (10.167.242.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Wed, 24 Jun 2026 14:39:23 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 24 Jun
 2026 09:38:24 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 24 Jun
 2026 07:38:04 -0700
Received: from xirsalihe40.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 24 Jun 2026 09:38:02 -0500
From: Salih Erim <salih.erim@amd.com>
To: <jic23@kernel.org>, <andy@kernel.org>
CC: <dlechner@baylibre.com>, <nuno.sa@analog.com>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <conall.ogriofa@amd.com>,
	<michal.simek@amd.com>, <sai.krishna.potthuri@amd.com>, <linux@roeck-us.net>,
	<erimsalih@gmail.com>, <git@amd.com>, <linux-iio@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Salih Erim
	<salih.erim@amd.com>, Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: [PATCH v12 5/5] iio: adc: versal-sysmon: add oversampling support
Date: Wed, 24 Jun 2026 15:37:22 +0100
Message-ID: <20260624143722.4047649-6-salih.erim@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260624143722.4047649-1-salih.erim@amd.com>
References: <20260624143722.4047649-1-salih.erim@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4D:EE_|DS2PR12MB9664:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b9f3e73-05ac-4075-926f-08ded1fe625e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|36860700016|1800799024|7416014|376014|82310400026|22082099003|18002099003|11063799006|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info:
	pq4E/ZuGfveU0RfaeHiZaj2HbFBMJ/LGURDMieD+9Zp0bre881KU0HLGqaAhyTM9uDemijdiT6+uE8gfONe7NrMt8MGSV8yO6q9Qs9KD9BPyuK9stAL0tD9pynQV9aUDj1Nt9gMoe7w7TUxbKej5mFNV9f9wKDdLMb+BN1hJPH7ZUxTNqnAN66p5lbXDVnQuZe3jkhl4DyQJbm7SfWU4OGNJOwIjpWN3Y8bPGR59DSwfRVntWp/iUNKPwo+fuQ74df/wDGfcnJ1nS7D95sMFhkp4rTthcQWY46D6IuZ1gwJrjPchf6ASeX0WkhKszBKDZ7OmGEETg1u/Ln3pfX1StzFuIixoCE2qmT8x9xWIDJH4lzFHwcF34d3pHX09ccb/ZLSOxq8DEYqT9y+6YkyDDOiySXDl7snVZcJGOU9DdQ8wrQRs9HVAEnDvkG7K53sazFy0uo1pMs3uGIJ8Q1/cX1jYYN4Y2KWfvsEFh0pYEYe5289SjCs0y5BsQDDA5SU3OnY8eSe4PLHiuX0mXInqg5t4GiIyZxAyT+ndVdzkqB1FeFMPZCSK9pExRJ0FMe5C1Adje+9/7wAKrYqetO2+pu7YN1Phyl1YjOjJ7XTb7xmt9ehbbA5nDZWeWao/W5rb2BRhCXW3a2L0YqS+VUnyh+iJv6XsJcSaeRMRWp9zGPm9fmjX70eMiQRnSu5q0MVub5U+Yc2lZcSlk+cLBLafsA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(36860700016)(1800799024)(7416014)(376014)(82310400026)(22082099003)(18002099003)(11063799006)(56012099006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	CRfkSYzZpl76WglLICQSCVgCAUKyMdzbgp6JZv1QoeOPDfqs8rnK8nL0G6HcE2Z3xvVVD1f96R0jr8Q7snUdUyC1AYe+4HiPjDLEcQiNnreFVC4a3Saf09u5ELF5y+RZjGKJwm4Wv1YsytaXD/Xbt7TbsU19l0Vh9d6onp99PABcGTS4BO7xqT+lteFNWwpXB400Ux+NW6o5V0n2q4bo0XFBfkIh5HJGIbRIJWTs3r/AkVjsjIC94yZpVuH9bCkKOGtCoBcAGxycPbtegLLxg27bkGF6u8/Ih87YiRs9s07cF/K5SCTHxk05ukAAbkymRr174ehgXBiPMJGMFhxtL7N3QYXLam/hlHPPCPOUtScuKLTONXry3ObJNPo9+7pRMD5bm36a8T/86DTM7PE8jQ1vawAfpz6ljE8lEta3lEnzTqndeoQJDs+LnaSzCnRv
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2026 14:39:23.4796
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b9f3e73-05ac-4075-926f-08ded1fe625e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA4D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9664

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
Changes in v12:
  - No code changes

Changes in v11:
  - Add oversampling info_mask bits to static SYSMON_CHAN_TEMP
    macro (Jonathan)

Changes in v10:
  - No code changes

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
 drivers/iio/adc/versal-sysmon-core.c | 159 ++++++++++++++++++++++++++-
 drivers/iio/adc/versal-sysmon.h      |  17 +++
 2 files changed, 174 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/versal-sysmon-core.c b/drivers/iio/adc/versal-sysmon-core.c
index 8f2c502d9cb..1b55d343982 100644
--- a/drivers/iio/adc/versal-sysmon-core.c
+++ b/drivers/iio/adc/versal-sysmon-core.c
@@ -28,6 +28,12 @@
 
 #include "versal-sysmon.h"
 
+/*
+ * Oversampling ratio values exposed to userspace via IIO.
+ * Actual number of samples averaged: 1=none, 2=2x, 4=4x, 8=8x, 16=16x.
+ */
+static const int sysmon_oversampling_avail[] = { 1, 2, 4, 8, 16 };
+
 /* TEMP hysteresis mode bit in SYSMON_TEMP_EV_CFG */
 #define SYSMON_TEMP_HYST_MASK		BIT(1)
 
@@ -42,7 +48,11 @@
 	.address = _address,					\
 	.channel = _chan,					\
 	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
-	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),	\
+	.info_mask_shared_by_type =				\
+		BIT(IIO_CHAN_INFO_SCALE) |			\
+		BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),		\
+	.info_mask_shared_by_type_available =			\
+		BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),		\
 	.datasheet_name = _name,				\
 }
 
@@ -166,6 +176,12 @@ static int sysmon_read_raw(struct iio_dev *indio_dev,
 
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
@@ -465,6 +481,132 @@ static int sysmon_write_event_value(struct iio_dev *indio_dev,
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
@@ -477,6 +619,9 @@ static int sysmon_read_label(struct iio_dev *indio_dev,
 
 static const struct iio_info sysmon_iio_info = {
 	.read_raw = sysmon_read_raw,
+	.write_raw = sysmon_write_raw,
+	.write_raw_get_fmt = sysmon_write_raw_get_fmt,
+	.read_avail = sysmon_read_avail,
 	.read_label = sysmon_read_label,
 	.read_event_config = sysmon_read_event_config,
 	.write_event_config = sysmon_write_event_config,
@@ -768,6 +913,10 @@ static int sysmon_parse_fw(struct iio_dev *indio_dev, struct device *dev, int ir
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
@@ -799,7 +948,11 @@ static int sysmon_parse_fw(struct iio_dev *indio_dev, struct device *dev, int ir
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
@@ -846,6 +999,8 @@ int devm_versal_sysmon_core_probe(struct device *dev, struct regmap *regmap)
 
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

