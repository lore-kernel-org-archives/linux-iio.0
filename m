Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.85.70
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793622104;
	b=H5/vX9OVCZgXAg35PCNV0TB/ahF/MskPFZ2M652Xvy524DEYQx/LF8SQRdeehT79M4fb
	 +/JRnhQ12iADoz0hnkeFKXtfjOv8hDJHsE5r2FE41/h0wOkODSWQDuy+f3mu4AQvKlx4s
	 0NZDIODzys90FhkvbcmAEE7EuFIkh8myeVzpL4VNrl6DRIW6EcDQQrrEVSQDxnHm1iw2/
	 R9rdiKwjpMoDN4uOxBnIM8t+m4r+IRjAKHMdinbFz1TPci+96jXu9FRDtzlxVHRtCau5B
	 Q2yQ130LFsOm5aKUxoXxOCBqiyC5QrNmGPs35os0euz9OB8/yUdCQcToih5o9O/jsTQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793622104;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:Content-Type:
	 X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=DvyUs3cut7Otau6YNaLODzrIPEy4/OZhustEQead/CI=;
	b=svs0E49ypbvPBtdJ58V4jTLus/B7uTj6qvBaVwUlIPMbuCNRsGYlp6SgWv5A6aF8Wfil
	 7tqqEDEI9lw9GBJTPgQyIDafkzDwKf7TmAHgJQrGKnf2GIMqGp9Tn3Nyt8cESrcGlEgmq
	 db+xwmx4F30H8YgVkxozNwNDWOf+5f8Xvn1Xlbyq8sIqlY+QMKhcS2Shl63Yhiu2fgHtL
	 LTbBz0m7dIJ6O2o/Bx9iRQorZAKURMlhXOCyquNoIrX8O5kZqsnGl/q7ZxFKzwXdtqTmN
	 xlTddgFCP4PDnaUXBfMdg0Vx5EbLBNF2RdPQTRlYI9JmsI9ZUK7DQmDPoexKy1c9flQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b="k/VT/8IL";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.85.70
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010070.outbound.protection.outlook.com [52.101.85.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B98060A3819;
	Mon,  2 Nov 2026 12:21:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1B98060A3819
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=k/VT/8IL
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vr8MePTfFmVoIqyvNoevQ7waShNCWwzW7O3P6smVnOWbUKPnKMwJ1xVEpaqutFfMYMc5nikcWJLO+cFlU0n+h0lqu6oMoLtHFbKuAPWwqYvD0/wLgFTI8imnlmUBHxuTubggIPHX0TQU/ZnZj+8eyoMXDC1HpZvlB/b04n5Oi+B/ilUh2sJj69vsB4TZf5CgiKyuwIfqZdmAVBklrI3t+56VsfrUuBdZxECuO+2mnI/YU9Igd71GG0XVnsn+0LFOzAXgVagNlGuzgH9k8fEUPlY5m1Sx9Q9LJgKzQ/H3NRfVjWUbaNSNsnFTGKK2SPkEX9/P8U/4voUj4nxxITHmLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DvyUs3cut7Otau6YNaLODzrIPEy4/OZhustEQead/CI=;
 b=FH6mySQYwN5ZxS/tCCuK4aT5oR+C6FY1f1xh+UJ0IQzxs+M2aJcY8qnLJtP7ZbtAwmKAQ5uW7edFOVqo8KXHSDYLlgE++PeqFfxh2XUjGPtyL1gvBBJk+i8S+GDLZKGDhxT1u3o6i6bOgXsqv9VmvWmPmhGZjSRS2OveR8nRa8DH48GLKDzoJ7NPp1Fw1fHGo+stZr9IQfm64QH00cUwKRLJExbMf9yNIdCfF5oOA6sDRmO2h0KS4tm5EBAfM59D6rVTZYLzW5uUtEZ44aySONGtXW1csYyVsEsAvBs+3d0ppuwjku7UTOt7D+ajg6cFy0dl8BQ62vcFabsvtifxZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DvyUs3cut7Otau6YNaLODzrIPEy4/OZhustEQead/CI=;
 b=k/VT/8ILF8Apfq9q2ZeHsD7Z6+p80/NnD9G7VaxPSOJ2IGbMF8bn6hG/Vcn8rBCVYT/OP1LeYinmd6BSVwcTKQPk1qGiCzaCu2VompmuvEGq5FfvWCFliExj986UfR3h2DE+85zRUOXRXHZrLLnLlo+942MFLXhSlLP15lm0+JM=
Received: from CH2PR08CA0016.namprd08.prod.outlook.com (2603:10b6:610:5a::26)
 by CH3PR12MB8852.namprd12.prod.outlook.com (2603:10b6:610:17d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 12:21:37 +0000
Received: from BN3PEPF00022BC8.namprd05.prod.outlook.com
 (2603:10b6:610:5a:cafe::7e) by CH2PR08CA0016.outlook.office365.com
 (2603:10b6:610:5a::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.11 via Frontend Transport; Mon, 2
 Nov 2026 12:21:37 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN3PEPF00022BC8.mail.protection.outlook.com (10.167.248.214) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Mon, 2 Nov 2026 12:21:37 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 2 Nov
 2026 06:21:36 -0600
Received: from xhdakumarma40.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Mon, 2 Nov 2026 06:21:33 -0600
From: Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
To: Jonathan Cameron <jic23@kernel.org>, Michal Simek <michal.simek@amd.com>,
	Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>, David Lechner
	<dlechner@baylibre.com>, =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
CC: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<amitrkcian2002@gmail.com>, Amit Kumar Mahapatra
	<amit.kumar-mahapatra@amd.com>
Subject: [PATCH 4/6] iio: adc: versal-sysmon: add over-temperature alarm events
Date: Mon, 2 Nov 2026 17:51:10 +0530
Message-ID: <20261102122112.1723130-5-amit.kumar-mahapatra@amd.com>
X-Mailer: git-send-email 2.44.4
In-Reply-To: <20261102122112.1723130-1-amit.kumar-mahapatra@amd.com>
References: <20261102122112.1723130-1-amit.kumar-mahapatra@amd.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF00022BC8:EE_|CH3PR12MB8852:EE_
X-MS-Office365-Filtering-Correlation-Id: 47a981be-6e00-4fda-1319-08df38dbd767
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|7416014|376014|36860700016|82310400026|11063799006|56012099006|261009221227099003|261009223027099003|261028144727099003|261021123027099003|261026121527099003|261021121427099003|261026140227099003|261022105027099003|261022075727099003|10067099003|18092099006|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	37TBs3R1QLr5r8cCxdhHxwaDK/tOXJIcY/z4cVpLp6YbH65YzOvwIpXKrnQxt29ootHGfx2bSLNekXPTtmgY5PNBp7YmVWtfaawiwRAq5eVf4g5aoZeL+pvrSpmk2te7gnR9f8MeR0NskEj8aJeuvFEBp2PbI2BC3B66bYkpB1iEYc0rO7ptpUqEoaQTNIpxnmrVGzabI3eC01wMNwbiAG07yJ+wdTjuX85JKsCyRmqtOXCas+ZkiuwDaf8te10WMXc9hbOJJQAoepfPph/h15P3BIcyQ86ImycQvgFfV2yTZq4v5e8TyaiPWaHCFK1UbL8nObOqFku+2yopsoYuoLOaIPsBH3ROa2TzsB4Np4s3s9sRVsEEYeRPsf9OHp7unTuTxjLXAKXDTIkBTzuwuLogt+8YFLM+1uIfa4a+QZm8hIRPRZjEwndxzSDXVnh/Yp/B/iQ9O1DPYc3bJ+EqZWixHtIUwz3JlRC7TyBcEWBmGC2On80mcpC6wSv6mHUPcBEWFiSW+cG+kCes7yJRFrXpfhCC9ntlW6Sro1OxTTZG/95NLMCXb7tLthWe2xQeJNQeWA4a/GOtd6R1RQT88WkxG824bS/rZfn7cuZR7QDETU5ZlUl0f8PFb84NIFYDpL4Cbou/TlqUU06LosYmbdSNHFkHUAoizOrcqyq1efp2wg19A0LNAMMZRq6nn+uw7MzYW/IxEd+vGMPqVUDI3g==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(7416014)(376014)(36860700016)(82310400026)(11063799006)(56012099006)(261009221227099003)(261009223027099003)(261028144727099003)(261021123027099003)(261026121527099003)(261021121427099003)(261026140227099003)(261022105027099003)(261022075727099003)(10067099003)(18092099006)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	CUgc3x+ztdzwpB5G3iS2RclAXDWGYsKxY0fX0df2lijKWVZj34XcA5vUhekhQ5y7BeANYsbdpde3jlz9mac/z598sx8TL1A7y5A/EmrcoN/auXeug2giOWh48Zs1aPoOji/UJ5oesY9vTOgl4XryK7LtEvTv1FwY9qhzlPXOVA8SHrT4ftmkT8JXBAUa40iRe6+m6LJMV5JgHI0FCFKLO3F0Xqc2nSitwg+vOpAupls5pZBbruZ2fO2814w2XLK5zCErODLvfSMEzBOg6AtkTbuzQc8i1rbL1APv6ekRGyf0LIRkvZABz7r7HxnComC8c/qGT4akn7AAvyGq5T3FjdWXpzJp2epTE0ClY7XqAHwen1xdA4YhiBUateIPwWFneZ3+2+DqiOI/yRpeMyp7U5EYRyUJL6uTleAUXmKJNWOzgvDAfG0RaH+NR2TU2re5
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 12:21:37.2313
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 47a981be-6e00-4fda-1319-08df38dbd767
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF00022BC8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8852

The SysMon has two independent temperature comparators. The driver
exposes only DEVICE_TEMP on interrupt bit 9; the over-temperature alarm
on bit 8, with its own threshold pair at OT_TEMP_TH_LOWER and
OT_TEMP_TH_UPPER, is not reported to userspace at all.

The two are structurally identical: an upper threshold, a lower
threshold acting as the hysteresis floor, and a hysteresis mode bit in
ALARM_CONFIG, bit 0 for OT and bit 1 for DEVICE_TEMP. Per AM006 the
over-temperature shutdown response is a PMC function configured at
design time, so the kernel's role here is threshold configuration and
notification rather than acting on the alarm.

IIO identifies an event by channel, type and direction, and both
comparators are rising thresholds on the same aggregate temperature, so
they cannot share a channel. Add an event-only channel labelled "ot"
carrying the OT thresholds.

The channel is appended after the device tree derived channels because
io-channels phandle arguments are raw array positions, and placing it
earlier would silently repoint existing consumers. It is created only
when the device has an interrupt, as without one it would carry no
events.

Signed-off-by: Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
---
 drivers/iio/adc/versal-sysmon-core.c | 128 ++++++++++++++++++++++-----
 drivers/iio/adc/versal-sysmon.h      |   8 +-
 2 files changed, 113 insertions(+), 23 deletions(-)

diff --git a/drivers/iio/adc/versal-sysmon-core.c b/drivers/iio/adc/versal-sysmon-core.c
index d39aaba9a8b6..bb8737ac5638 100644
--- a/drivers/iio/adc/versal-sysmon-core.c
+++ b/drivers/iio/adc/versal-sysmon-core.c
@@ -34,7 +34,8 @@
  */
 static const int sysmon_oversampling_avail[] = { 1, 2, 4, 8, 16 };
 
-/* TEMP hysteresis mode bit in SYSMON_TEMP_EV_CFG */
+/* Hysteresis mode bits in SYSMON_TEMP_EV_CFG (AM006 ALARM_CONFIG) */
+#define SYSMON_OT_HYST_MASK		BIT(0)
 #define SYSMON_TEMP_HYST_MASK		BIT(1)
 
 /* Compute alarm register offset from a channel address */
@@ -62,9 +63,41 @@ enum sysmon_alarm_bit {
 	SYSMON_BIT_ALARM2 = 2,
 	SYSMON_BIT_ALARM3 = 3,
 	SYSMON_BIT_ALARM4 = 4,
+	SYSMON_BIT_OT = 8,
 	SYSMON_BIT_TEMP = 9,
 };
 
+/*
+ * The two temperature comparators are identical in layout: an upper
+ * threshold, a lower threshold acting as the hysteresis floor, and a
+ * hysteresis cached in millicelsius because the hardware only stores the
+ * two thresholds. DEVICE_TEMP drives bit 9, the over-temperature alarm
+ * bit 8.
+ */
+struct sysmon_comparator {
+	unsigned int th_up;
+	unsigned int th_low;
+	int *hysteresis;
+};
+
+static bool sysmon_chan_is_ot(const struct iio_chan_spec *chan)
+{
+	return chan->address == SYSMON_OT_TH_UP;
+}
+
+static struct sysmon_comparator sysmon_get_comparator(struct sysmon *sysmon,
+						      const struct iio_chan_spec *chan)
+{
+	if (sysmon_chan_is_ot(chan))
+		return (struct sysmon_comparator){
+			SYSMON_OT_TH_UP, SYSMON_OT_TH_LOW, &sysmon->ot_hysteresis
+		};
+
+	return (struct sysmon_comparator){
+		SYSMON_TEMP_TH_UP, SYSMON_TEMP_TH_LOW, &sysmon->temp_hysteresis
+	};
+}
+
 /* Temperature event specification: rising threshold + hysteresis only */
 static const struct iio_event_spec sysmon_temp_events[] = {
 	{
@@ -221,7 +254,8 @@ static int sysmon_read_raw(struct iio_dev *indio_dev,
 static u32 sysmon_get_event_mask(const struct iio_chan_spec *chan)
 {
 	if (chan->type == IIO_TEMP)
-		return BIT(SYSMON_BIT_TEMP);
+		return sysmon_chan_is_ot(chan) ? BIT(SYSMON_BIT_OT) :
+						 BIT(SYSMON_BIT_TEMP);
 
 	return BIT(chan->address / SYSMON_ALARM_BITS_PER_REG);
 }
@@ -340,23 +374,24 @@ static int sysmon_write_event_config(struct iio_dev *indio_dev,
  * cached hysteresis. Called when either upper threshold or hysteresis
  * is written.
  */
-static int sysmon_update_temp_lower(struct sysmon *sysmon)
+static int sysmon_update_temp_lower(struct sysmon *sysmon,
+				    const struct sysmon_comparator *cmp)
 {
 	unsigned int upper_reg;
 	int upper_mc, lower_mc;
 	u32 raw_val;
 	int ret;
 
-	ret = regmap_read(sysmon->regmap, SYSMON_TEMP_TH_UP, &upper_reg);
+	ret = regmap_read(sysmon->regmap, cmp->th_up, &upper_reg);
 	if (ret)
 		return ret;
 
 	sysmon_q8p7_to_millicelsius(upper_reg, &upper_mc);
-	lower_mc = clamp(upper_mc - sysmon->temp_hysteresis,
+	lower_mc = clamp(upper_mc - *cmp->hysteresis,
 			 SYSMON_TEMP_MIN_MC, SYSMON_TEMP_MAX_MC);
 	sysmon_millicelsius_to_q8p7(&raw_val, lower_mc);
 
-	return regmap_write(sysmon->regmap, SYSMON_TEMP_TH_LOW, raw_val);
+	return regmap_write(sysmon->regmap, cmp->th_low, raw_val);
 }
 
 static int sysmon_read_event_value(struct iio_dev *indio_dev,
@@ -374,10 +409,12 @@ static int sysmon_read_event_value(struct iio_dev *indio_dev,
 	guard(mutex)(&sysmon->lock);
 
 	switch (chan->type) {
-	case IIO_TEMP:
+	case IIO_TEMP: {
+		struct sysmon_comparator cmp = sysmon_get_comparator(sysmon, chan);
+
 		switch (info) {
 		case IIO_EV_INFO_VALUE:
-			ret = regmap_read(sysmon->regmap, SYSMON_TEMP_TH_UP, &reg_val);
+			ret = regmap_read(sysmon->regmap, cmp.th_up, &reg_val);
 			if (ret)
 				return ret;
 
@@ -386,12 +423,13 @@ static int sysmon_read_event_value(struct iio_dev *indio_dev,
 			return IIO_VAL_INT;
 
 		case IIO_EV_INFO_HYSTERESIS:
-			*val = sysmon->temp_hysteresis;
+			*val = *cmp.hysteresis;
 			return IIO_VAL_INT;
 
 		default:
 			return -EINVAL;
 		}
+	}
 
 	case IIO_VOLTAGE:
 		offset = sysmon_supply_thresh_offset(chan->address, dir);
@@ -427,7 +465,9 @@ static int sysmon_write_event_value(struct iio_dev *indio_dev,
 	guard(mutex)(&sysmon->lock);
 
 	switch (chan->type) {
-	case IIO_TEMP:
+	case IIO_TEMP: {
+		struct sysmon_comparator cmp = sysmon_get_comparator(sysmon, chan);
+
 		switch (info) {
 		case IIO_EV_INFO_VALUE:
 			if (val < SYSMON_TEMP_MIN_MC || val > SYSMON_TEMP_MAX_MC)
@@ -435,24 +475,25 @@ static int sysmon_write_event_value(struct iio_dev *indio_dev,
 
 			sysmon_millicelsius_to_q8p7(&raw_val, val);
 
-			ret = regmap_write(sysmon->regmap, SYSMON_TEMP_TH_UP, raw_val);
+			ret = regmap_write(sysmon->regmap, cmp.th_up, raw_val);
 			if (ret)
 				return ret;
 
 			/* Recompute lower = upper - hysteresis */
-			return sysmon_update_temp_lower(sysmon);
+			return sysmon_update_temp_lower(sysmon, &cmp);
 
 		case IIO_EV_INFO_HYSTERESIS:
 			if (val < 0 || val > SYSMON_TEMP_MAX_MC - SYSMON_TEMP_MIN_MC)
 				return -EINVAL;
 
-			sysmon->temp_hysteresis = val;
+			*cmp.hysteresis = val;
 
-			return sysmon_update_temp_lower(sysmon);
+			return sysmon_update_temp_lower(sysmon, &cmp);
 
 		default:
 			return -EINVAL;
 		}
+	}
 
 	case IIO_VOLTAGE:
 		offset = sysmon_supply_thresh_offset(chan->address, dir);
@@ -672,6 +713,16 @@ static int sysmon_handle_event(struct iio_dev *indio_dev, u32 event)
 		sysmon->masked_temp |= BIT(SYSMON_BIT_TEMP);
 		return 0;
 
+	case SYSMON_BIT_OT:
+		sysmon_push_event(indio_dev, SYSMON_OT_TH_UP);
+
+		ret = regmap_write(sysmon->regmap, SYSMON_IDR, BIT(SYSMON_BIT_OT));
+		if (ret)
+			return ret;
+
+		sysmon->masked_temp |= BIT(SYSMON_BIT_OT);
+		return 0;
+
 	case SYSMON_BIT_ALARM0:
 	case SYSMON_BIT_ALARM1:
 	case SYSMON_BIT_ALARM2:
@@ -822,23 +873,24 @@ static int sysmon_init_interrupt(struct sysmon *sysmon,
  * Initialize the cached hysteresis for a temperature channel from the
  * current hardware threshold registers: hysteresis = upper - lower.
  */
-static int sysmon_init_hysteresis(struct sysmon *sysmon, int *hysteresis)
+static int sysmon_init_hysteresis(struct sysmon *sysmon,
+				  const struct sysmon_comparator *cmp)
 {
 	unsigned int upper_reg, lower_reg;
 	int upper_mc, lower_mc;
 	int ret;
 
-	ret = regmap_read(sysmon->regmap, SYSMON_TEMP_TH_UP, &upper_reg);
+	ret = regmap_read(sysmon->regmap, cmp->th_up, &upper_reg);
 	if (ret)
 		return ret;
 
-	ret = regmap_read(sysmon->regmap, SYSMON_TEMP_TH_LOW, &lower_reg);
+	ret = regmap_read(sysmon->regmap, cmp->th_low, &lower_reg);
 	if (ret)
 		return ret;
 
 	sysmon_q8p7_to_millicelsius(upper_reg, &upper_mc);
 	sysmon_q8p7_to_millicelsius(lower_reg, &lower_mc);
-	*hysteresis = max(upper_mc - lower_mc, 0);
+	*cmp->hysteresis = max(upper_mc - lower_mc, 0);
 
 	return 0;
 }
@@ -880,6 +932,9 @@ static int sysmon_parse_fw(struct iio_dev *indio_dev, struct device *dev, int ir
 
 	num_static = ARRAY_SIZE(temp_channels);
 	num_chan = size_add(num_temp, size_add(num_static, num_supply));
+	/* The over-temperature channel exists only when events do */
+	if (irq > 0)
+		num_chan = size_add(num_chan, 1);
 	sysmon_channels = devm_kcalloc(dev, num_chan, sizeof(*sysmon_channels), GFP_KERNEL);
 	if (!sysmon_channels)
 		return -ENOMEM;
@@ -960,6 +1015,25 @@ static int sysmon_parse_fw(struct iio_dev *indio_dev, struct device *dev, int ir
 		};
 	}
 
+	/*
+	 * Over-temperature alarm. The OT comparator watches the same
+	 * aggregate temperature as channel 0 but against its own threshold
+	 * pair, and IIO cannot express two rising thresholds on one channel.
+	 * It has no reading of its own, so only event attributes and a label
+	 * are exposed. Appended last, because io-channels phandle arguments
+	 * are raw array positions and inserting it earlier would silently
+	 * repoint every existing consumer.
+	 */
+	if (irq > 0)
+		sysmon_channels[idx++] = (struct iio_chan_spec) {
+			.type = IIO_TEMP,
+			.indexed = 1,
+			.address = SYSMON_OT_TH_UP,
+			.event_spec = sysmon_temp_events,
+			.num_event_specs = ARRAY_SIZE(sysmon_temp_events),
+			.datasheet_name = "ot",
+		};
+
 	indio_dev->num_channels = idx;
 	indio_dev->info = &sysmon_iio_info;
 
@@ -1032,14 +1106,26 @@ int devm_versal_sysmon_core_probe(struct device *dev, struct regmap *regmap)
 		return ret;
 
 	if (irq > 0) {
-		/* Set hysteresis mode for temperature threshold */
+		struct sysmon_comparator cmp;
+
+		/* Set hysteresis mode for both temperature comparators */
 		ret = regmap_set_bits(sysmon->regmap, SYSMON_TEMP_EV_CFG,
-				      SYSMON_TEMP_HYST_MASK);
+				      SYSMON_TEMP_HYST_MASK | SYSMON_OT_HYST_MASK);
 		if (ret)
 			return ret;
 
 		/* Initialize cached hysteresis from hardware registers */
-		ret = sysmon_init_hysteresis(sysmon, &sysmon->temp_hysteresis);
+		cmp = (struct sysmon_comparator){
+			SYSMON_TEMP_TH_UP, SYSMON_TEMP_TH_LOW, &sysmon->temp_hysteresis
+		};
+		ret = sysmon_init_hysteresis(sysmon, &cmp);
+		if (ret)
+			return ret;
+
+		cmp = (struct sysmon_comparator){
+			SYSMON_OT_TH_UP, SYSMON_OT_TH_LOW, &sysmon->ot_hysteresis
+		};
+		ret = sysmon_init_hysteresis(sysmon, &cmp);
 		if (ret)
 			return ret;
 
diff --git a/drivers/iio/adc/versal-sysmon.h b/drivers/iio/adc/versal-sysmon.h
index a21dacc13471..d0a9bb1293c7 100644
--- a/drivers/iio/adc/versal-sysmon.h
+++ b/drivers/iio/adc/versal-sysmon.h
@@ -32,6 +32,8 @@ struct regmap;
 #define SYSMON_SUPPLY_EN_AVG_BASE	0x1958
 #define SYSMON_TEMP_TH_LOW		0x1970
 #define SYSMON_TEMP_TH_UP		0x1974
+#define SYSMON_OT_TH_LOW		0x1978
+#define SYSMON_OT_TH_UP			0x197C
 #define SYSMON_SUPPLY_TH_LOW		0x1980
 #define SYSMON_SUPPLY_TH_UP		0x1C80
 #define SYSMON_TEMP_EV_CFG		0x1F84
@@ -53,8 +55,8 @@ struct regmap;
 #define SYSMON_NO_OF_EVENTS		32
 #define SYSMON_INTR_ALL_MASK		GENMASK(31, 0)
 
-/* ISR/IMR temperature alarm mask (bit 9) */
-#define SYSMON_TEMP_INTR_MASK		BIT(9)
+/* ISR/IMR temperature alarm mask: OT (bit 8) and DEVICE_TEMP (bit 9) */
+#define SYSMON_TEMP_INTR_MASK		GENMASK(9, 8)
 
 /* SYSMON_CONFIG: supply oversampling ratio */
 #define SYSMON_CONFIG_SUPPLY_OSR	GENMASK(17, 14)
@@ -94,6 +96,7 @@ struct regmap;
  * @masked_temp: currently masked temperature alarm bits
  * @temp_mask: temperature interrupt configuration mask
  * @temp_hysteresis: cached DEVICE_TEMP hysteresis in millicelsius
+ * @ot_hysteresis: cached OT hysteresis in millicelsius
  * @sysmon_unmask_work: re-enables events after alarm condition clears
  * @temp_oversampling: current temp oversampling ratio
  * @supply_oversampling: current supply oversampling ratio
@@ -116,6 +119,7 @@ struct sysmon {
 	unsigned int masked_temp;
 	unsigned int temp_mask;
 	int temp_hysteresis;
+	int ot_hysteresis;
 	struct delayed_work sysmon_unmask_work;
 	unsigned int temp_oversampling;
 	unsigned int supply_oversampling;
-- 
2.34.1

