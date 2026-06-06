Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010036.outbound.protection.outlook.com [52.101.61.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BA6C18A6D4;
	Sat,  6 Jun 2026 05:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780723063; cv=fail; b=Z2l7jaZPmuBL21SglnypGzV4eAJkplWZmB2TY5QW2LhyzwR+FUy5W3zBpha+GFm+7j8Mp0vF7Cb4ONZgeORQtY5b9DgetXu7zcK91xTA8E1QqG+1/qzNa5jnkudhSdkpy004FcG/0/b9nmICZjWCEx0H36fJ+dIVo8yGVg8f/AY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780723063; c=relaxed/simple;
	bh=kunDxsQAP5jOmhXhBeJHguURh1YTTnSgoy3oyGIOUfQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aYcH4+YSkLKOBIoLURrIg3KjfqeGTclFRbHRiBMx7lT+mEDg0pDHr7uzogAl8aE61JKvh2PYmmknGPBIxoMPHbd/xtWSNXbgo7j8hX4rHWzk9ThVUpFYe6zr9lt57B+fX/xn2gTiVdh7fyy3cZrocu2Ftrb1V/eDCaJBizriFxc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=gpd0bHkP; arc=fail smtp.client-ip=52.101.61.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="gpd0bHkP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xAXZCXs/YOMQ9vGmr+UvTBgzV2mJkTqbDUyvrRUYrbB4kI1wPWC6HVEelKIKUauyq7pHqE4NB88Dx6QRF2Alens/+nUcg5cQSjhRJKo764qtGfN3Ev19D0FTUskxmMnGjEOwsaDt/RSBVFk27aIdgmtR24c4wVo81vulkoPHVMhsZHXLvlL2rh1lJQm+GYsxZs19Dp2yz2H/HE/41ovZVr4LboRR2uuAAv+PfU3wOGXsXbI0+sqUrosFw05VwhjTuY16ek86vSmgBMHSgNFyION9CbNtb3ENUbJA3ht25ODrCJNCedaxUi9f0TtgBROAPcTnrpw5p56evV/9fwvxTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cMUmnKJvBqEimGxaaNNUO4bWCkZm/MycSA36o0Uf+9c=;
 b=okIqxNL8HhUYjxJOvT+4LQUAbOVj+SY/s0bERuKMEjlgOo77DaauSfY616Nk1Nad/X+/BfbvFcWuU/GtzwJ246kWNTU+Fofcfh+GQR/wHdmZRU3hsfvr18gQwnxcbBGbak4RAzgTq37grgczPaXFFmu6wFOrFl0g7pq8500+4vsJXG3PsxfT6XLwgNkHjVJQ48Rg7WUV3tmSx8xrdRQZvOZZsO98nMR8vbqkbmc9nkAr8kHJU3oyTyf7vrpKWKuSnQCe1YvlrfqrXSGc4bCSynNUFELL69RvWS4vYPlBDluzOrXIQI4r0FFey/GusnX7kJyd/gPFYE14DrwTEauOyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cMUmnKJvBqEimGxaaNNUO4bWCkZm/MycSA36o0Uf+9c=;
 b=gpd0bHkPPmOQW25ytj9qV1byIDNY8NuDgzJGgrfktypty+sJa7DBdBmJhXGTIEqIBta6/tXe3qwhWuyup3lbyJoVryaEXRpcH2J2tdt4lfmJWM9q3UYqVqhTjk+l69Bdx/6Merc38ajBYEOpDS4ZM6YlMN6BxUSI1aPPmeURH4E=
Received: from SJ0PR13CA0066.namprd13.prod.outlook.com (2603:10b6:a03:2c4::11)
 by BN7PPF2E18BD747.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6ca) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.10; Sat, 6 Jun 2026
 05:17:35 +0000
Received: from SJ1PEPF00001CE7.namprd03.prod.outlook.com
 (2603:10b6:a03:2c4:cafe::e2) by SJ0PR13CA0066.outlook.office365.com
 (2603:10b6:a03:2c4::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.10 via Frontend Transport; Sat, 6
 Jun 2026 05:17:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF00001CE7.mail.protection.outlook.com (10.167.242.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Sat, 6 Jun 2026 05:17:34 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Sat, 6 Jun
 2026 00:17:34 -0500
Received: from xirsalihe40.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Sat, 6 Jun 2026 00:17:33 -0500
From: Salih Erim <salih.erim@amd.com>
To: Jonathan Cameron <jic23@kernel.org>, Andy Shevchenko <andy@kernel.org>
CC: David Lechner <dlechner@baylibre.com>, =?UTF-8?q?Nuno=20S=C3=A1?=
	<nuno.sa@analog.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Conall O'Griofa
	<conall.ogriofa@amd.com>, Michal Simek <michal.simek@amd.com>, Guenter Roeck
	<linux@roeck-us.net>, Salih Erim <erimsalih@gmail.com>,
	<linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Salih Erim <salih.erim@amd.com>
Subject: [PATCH v4 5/5] iio: adc: versal-sysmon: add oversampling support
Date: Sat, 6 Jun 2026 06:17:07 +0100
Message-ID: <20260606051707.535281-6-salih.erim@amd.com>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20260606051707.535281-1-salih.erim@amd.com>
References: <20260606051707.535281-1-salih.erim@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE7:EE_|BN7PPF2E18BD747:EE_
X-MS-Office365-Filtering-Correlation-Id: d1c22ecf-310e-4761-473e-08dec38aeb20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700016|82310400026|1800799024|22082099003|18002099003|6133799003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	fAzq+X/gP/RaX8I9ctHR+WVvOW7xi3O2UTTc9k3wEdBnt+6czr+EzSVlpR2kVTWjUT9UUaAtvwldEaxJVI/w8Qo8mOCEn1xpDWkAVRjJhP0wq+hWIshzF0qmLgfxGRtJBB/m+fWi1Kers23JjNFadv2awbh+Nm41G57ZvcqcQfRsgfofgFJdpHnUWczuuS8JvbihrWCHEK34kLxTQQEDSlnyCHExLX4eurM+BnhOKCNR45FusCT2xovyrankyN4Kd8PRdPLl+0yfVmunQTsUDsKX6A1Lvf+fFfOvc3ow/7zZRC+5x1YYQ+XlsY1RE0NR3LjoCgbxyglsWShdhpiz3xfuer5H8+/EYd7RE+F0YKywqOE/nOdd3RIkfvILz4eN3p/Pho/uycxOSpA/kDjt9idCw2/2opP4e9MdD54s+p0Np8lkdoIFsflhwGeUxGkHci0F9+oyjI9njoksgoturnonDxFAX7L0mYFrfPITaWE17AHCUVC3JJRE9RHcxr0d+NlwlmQVv33MZVU9eu0yY9l7BWGq7SC8j3619FByBl2Vc5y8tEVS5+x0p37ZNBV7uKbZskTp4UuviXX4TnuzRGq1ddUGLobC2UNzzOsmeuECVtJxwUFEPLwNTvN9H6HYggoZFVtzr5C48alUO0h74frVz08u3KIrt9Iwu1fagspQjezoxjIG9DzD+uH29QyJCPzO/t5zqZJ4RI0LStU+ZtGmIazxQueU/R2DkEzWKbk=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700016)(82310400026)(1800799024)(22082099003)(18002099003)(6133799003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	LFcDlbBTh62i1RdrO6Q3x/j/K+3eFTmV4Db1cfkzPr+uB96J15RyY3jhVv+tyFZNVASQliF+jAaKxEmT8D7nqhIOhhYYGOhwrGeBC4nmQNdNcytllvd+OVas8D9TKwe73YzaUlaFbqVtGdYa5e4XRm7z8nyWqO5RSfvu9/Ps6GxDhLcL/6aQ/Gm+bjmfvRyo9kVfalcpQDg6JAH7xmqd/ykAWxh5kzwxUBS/hIW3KRYKoIUkr5D6dkCu/m7D76n7bb3dARFFPln7zGLNYZJynMfgmJ5BWKk7YQooqVrVzeT7muIdIkD1+TF39gqsFGAvqgis0LfqYmszmPcRivSjia/o7nivKshWCNUlIsZ3zwWhytkS1SxSF7CFyjPI1ZR5WI1A1cZa1tvGU8kN3Zpfiose8y+2vu4jkBJO6qFo9A3WNS2XodjddZ1vzGkLhOur
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2026 05:17:34.9735
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d1c22ecf-310e-4761-473e-08dec38aeb20
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF2E18BD747

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

 drivers/iio/adc/versal-sysmon-core.c | 135 ++++++++++++++++++++++++++-
 drivers/iio/adc/versal-sysmon.h      |  17 ++++
 2 files changed, 151 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/versal-sysmon-core.c b/drivers/iio/adc/versal-sysmon-core.c
index e87974c641a..8a8ca4506cb 100644
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
@@ -193,6 +199,12 @@ static int sysmon_read_raw(struct iio_dev *indio_dev,
 
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
@@ -498,6 +510,115 @@ static int sysmon_write_event_value(struct iio_dev *indio_dev,
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
+					SYSMON_CONFIG_TEMP_SAT_OSR,
+					FIELD_PREP(SYSMON_CONFIG_TEMP_SAT_OSR,
+						   hw_val));
+		if (ret)
+			return ret;
+
+		return sysmon_set_avg_enable(sysmon, SYSMON_TEMP_EN_AVG_BASE,
+					     SYSMON_TEMP_EN_AVG_COUNT,
+					     hw_val ? ~0U : 0);
+	}
+
+	if (channel_type == IIO_VOLTAGE) {
+		ret = regmap_update_bits(sysmon->regmap, SYSMON_CONFIG,
+					SYSMON_CONFIG_SUPPLY_OSR,
+					FIELD_PREP(SYSMON_CONFIG_SUPPLY_OSR,
+						   hw_val));
+		if (ret)
+			return ret;
+
+		return sysmon_set_avg_enable(sysmon, SYSMON_SUPPLY_EN_AVG_BASE,
+					     SYSMON_SUPPLY_EN_AVG_COUNT,
+					     hw_val ? ~0U : 0);
+	}
+
+	return -EINVAL;
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
@@ -510,6 +631,9 @@ static int sysmon_read_label(struct iio_dev *indio_dev,
 
 static const struct iio_info sysmon_iio_info = {
 	.read_raw = sysmon_read_raw,
+	.write_raw = sysmon_write_raw,
+	.write_raw_get_fmt = sysmon_write_raw_get_fmt,
+	.read_avail = sysmon_read_avail,
 	.read_label = sysmon_read_label,
 	.read_event_config = sysmon_read_event_config,
 	.write_event_config = sysmon_write_event_config,
@@ -810,6 +934,10 @@ static int sysmon_parse_fw(struct iio_dev *indio_dev, struct device *dev,
 			.address = reg,
 			.info_mask_separate =
 				BIT(IIO_CHAN_INFO_PROCESSED),
+			.info_mask_shared_by_type =
+				BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
+			.info_mask_shared_by_type_available =
+				BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
 			.event_spec = has_irq ?
 				sysmon_supply_events : NULL,
 			.num_event_specs = has_irq ?
@@ -842,7 +970,10 @@ static int sysmon_parse_fw(struct iio_dev *indio_dev, struct device *dev,
 				   ((reg - 1) * SYSMON_REG_STRIDE),
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
@@ -890,6 +1021,8 @@ int sysmon_core_probe(struct device *dev, struct regmap *regmap)
 
 	sysmon = iio_priv(indio_dev);
 	sysmon->regmap = regmap;
+	sysmon->temp_oversampling = 1;
+	sysmon->supply_oversampling = 1;
 
 	ret = devm_mutex_init(dev, &sysmon->lock);
 	if (ret)
diff --git a/drivers/iio/adc/versal-sysmon.h b/drivers/iio/adc/versal-sysmon.h
index e06d2379c23..cbdef21c133 100644
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
@@ -86,6 +99,8 @@ struct regmap;
  * @temp_hysteresis: cached DEVICE_TEMP hysteresis in millicelsius
  * @ot_hysteresis: cached OT hysteresis in millicelsius
  * @sysmon_unmask_work: re-enables events after alarm condition clears
+ * @temp_oversampling: current temp oversampling ratio
+ * @supply_oversampling: current supply oversampling ratio
  */
 struct sysmon {
 	struct regmap *regmap;
@@ -106,6 +121,8 @@ struct sysmon {
 	int temp_hysteresis;
 	int ot_hysteresis;
 	struct delayed_work sysmon_unmask_work;
+	unsigned int temp_oversampling;
+	unsigned int supply_oversampling;
 };
 
 int sysmon_core_probe(struct device *dev, struct regmap *regmap);
-- 
2.48.1

