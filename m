Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011013.outbound.protection.outlook.com [52.101.70.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CF993B8D40;
	Tue,  6 Oct 2026 07:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791273503; cv=fail; b=JYQrx+KEGs5WUgec7wqZYiYAl3OwFcuq+3n6b270KW2VMhhki1r0/L1xTs0LhNqSVcXTjTMDqfBdqYbXfOi9mtefr1FaOz083I/gPMyYweaOBzU5GK798NdAUfcxnvokcMNtsM9z3U8UnLcd04jOW9JHV3PoMCjAPXYbSdRs9Rc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791273503; c=relaxed/simple;
	bh=2YcNbMnzuq2Ia3SJ8Yq95eQaAZE3l+4x+zbIefqK/jM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=Erq/oAhE9wb2i/tmNeR3miRk5vtYzLmNI00Oqo1+Y18EU2ZRLg117B/+Q72liiBZS/tAS8YKozVw1Rma2S1yReoAXAimdEJGai3HBCJKj2uxD3BEoQlxfS/QNp8dgTeqFS9uvJqtJ6yGjxwIX0jtXsa2C4TkWlZxJVJKraiugwE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=KkNYimyi; arc=fail smtp.client-ip=52.101.70.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="KkNYimyi"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y9hBUqGn9zsA7dlHMC+rNfe8P0lR8x300d8LfTamI7FLTKKXObrTtd9qli1iGuEpfW0rEIAVATvvicBhOn6Hh00GT8fSgdnaO2FF3ITxjhZ82gCWP5nd1LD/Ja/bvH2w6BfFtwzVNRnCNS/9pICOUYootR7z0iKLml58gvwWE3UdxVkt0V9utevznPPzwcJlSv8du/IWjnSh7vRC5a7q7bosOy3el3YVwYF/5kfWgYgvlbWNSwkjB2S27ZskqXZeWs/rB+Lj9ayDt/SlmixMieu1txDMNxD1MYvn1X4YLkUvrefr1QFzdAVZMpK2niACQkPD7XJTx/vk+/WtGcmreg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f5VLk113ZLcFsTfj9+QSRoF2V6YjNIJuU552PYhr5oQ=;
 b=V4x1JI8f/sM8CQEx48nIEsjzRGbaNE6ji6oFk/3IsZEFXsp1pURPB7uApLjQzZGCYX9n3GZdyS1L7rUL1bn6jtAzDNTyUn4sU7/1Z7py5Jj04f1a4yQMTzc+Ag8L0lt8cbQN1m+0Or3El7eC3o96+P1KAUboZ2ZPxR5ADVNPJOuBqvM2h3pa/y5hyLjMEB9iqWuqGo/ZjONxuZNJrnJn7pbQ55D9hg6eG+6g0a5YLbzmUzQL/uwyDrrKBDrJHz//mWlHckARi6jPFmQkc1nHzBF0o/HbVlWiAH2VIPU1XdnQyGnbi62IQ6OYop7MNKGj6742yVOMrUndP46C8zrPxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=gmail.com smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f5VLk113ZLcFsTfj9+QSRoF2V6YjNIJuU552PYhr5oQ=;
 b=KkNYimyi6cc6YSwZ4dSEp/iT6QXNi/OAl9NH+LDiMlsTVTo7zEjIcHTaUDVaDLHuj0b6bdvbsz3TNfR+ppbajrcbtXUdYD4dOpYP1tIb1lUr+CXzRM8gekbnXeS+U9+Qz0pZcbW61BRLIwEDmTFtGhMJwGjr+U9CqTkrfpVVhYBnwKADJdU2XZr/4FWUN3M6Gui++1CDLoZbdX0WEJD/xEzeAyrtXODtEAJ1m0qMt08eM0AQHtQrPwwOVYJG7A4yq4bnHVSJg16PVcwwlSUJkVP/f2YCwwHf95ExueZJ5dR7bUYjTfL72uzDOaPcIlY9nhENOJysy8jzAQWXZ3Xn0A==
Received: from AS9PR06CA0076.eurprd06.prod.outlook.com (2603:10a6:20b:464::29)
 by AM0PR10MB3473.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:151::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Tue, 6 Oct
 2026 07:58:14 +0000
Received: from AMS1EPF00000094.eurprd05.prod.outlook.com
 (2603:10a6:20b:464:cafe::6f) by AS9PR06CA0076.outlook.office365.com
 (2603:10a6:20b:464::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Tue, 6
 Oct 2026 07:58:14 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 164.130.1.60) smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 AMS1EPF00000094.mail.protection.outlook.com (10.167.242.91) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.14 via Frontend Transport; Tue, 6 Oct 2026 07:58:13 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 6 Oct
 2026 10:04:14 +0200
Received: from localhost (10.252.27.219) by STKDAG1NODE2.st.com
 (10.75.128.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 6 Oct
 2026 09:58:09 +0200
From: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Date: Tue, 6 Oct 2026 09:57:35 +0200
Subject: [PATCH v4 04/15] iio: adc: stm32-adc: manage characterization
 voltage diversity
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261006-adc-stm32mp25-v1-v4-4-d31ec75aecf3@foss.st.com>
References: <20261006-adc-stm32mp25-v1-v4-0-d31ec75aecf3@foss.st.com>
In-Reply-To: <20261006-adc-stm32mp25-v1-v4-0-d31ec75aecf3@foss.st.com>
To: Jonathan Cameron <jic23@kernel.org>, David Lechner
	<dlechner@baylibre.com>, =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, "Andy
 Shevchenko" <andy@kernel.org>, Rob Herring <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, "Maxime
 Coquelin" <mcoquelin.stm32@gmail.com>, Alexandre Torgue
	<alexandre.torgue@foss.st.com>
CC: Joshua Crofts <joshua.crofts1@gmail.com>, Marek Vasut
	<marex@nabladev.com>, <linux-iio@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	Fabrice Gasnier <fabrice.gasnier@foss.st.com>, Olivier Moysan
	<olivier.moysan@foss.st.com>
X-Mailer: b4 0.16.0
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS1EPF00000094:EE_|AM0PR10MB3473:EE_
X-MS-Office365-Filtering-Correlation-Id: 76eb07a2-a1d0-4f6a-7eeb-08df237f92c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|36860700016|82310400026|23010399003|22082099003|18002099003|11063799006|6133799003|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	uiQ6yjSOX5gng/a7N6l8a6MSlXPfSUkLbTAP+cXthI7m6vcs7GuIlfB3MgbjXYy1LeWmPeQ8OhcXimlCBf1auEiclUVWzKe0NF67AoKA8yki4pQF4ChKFWHdlZLGVSFJzSYpzH6zNAeI9SsbtEFOVTi2XkajAjEa5nB7vInBjQcdWqSqO8fZcffTJeE1IoTnYWv14c7P1pOMGYeKsLXx3AVNk3Ie4qklgRd0SYNPNokx7gRX45c0j+cT7sLeG0OgLLa5ppermrRU6906pSvu/M9G404cspqG2SP/Jr6sTaKyfXs9GDwEysOItahTzgEAtKStrsz3KziLsrVY1o4PzF62h0oXphDFwuMFJYq/HWk37TH7qhqTp+PTD15yX4l2KOhW4QzST1ttG3sFcW2j47IRH6ESrPzEZAg23Dzk2xsYC+gQQmMzPOMcYKMtGw4lbwA+EtEx8uY7UFVW49dp/7y7eG0OgCJ++/cOK8nuNa2tmE42pjdkLXoWNBB4C8vwJBFRDhUsWosNePB3zLZ0QHQlOqRUEjnKWg1dcl7r8CMB+bEj0exkzG/N2KmmNCGdWbyhVNOLM+dSGSKGLmyTEpdX2ih/4y8G2IIU5kMw9Gm/CTokqNJTCaWbchrRIQuhRMvBmsOpcTG+HZlwmv1ctyLayBTxVIwGhHxtTsaoAcpOOt7PITQb+pPHCkqiEW1m1V+tRegx9bNib2WxWTvwxA==
X-Forefront-Antispam-Report:
	CIP:164.130.1.60;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(36860700016)(82310400026)(23010399003)(22082099003)(18002099003)(11063799006)(6133799003)(10067099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	/r0PSq/dxjE927UkCZyDr4mflWOPdGCbWi9+T1ndtqnhRHQa2qY+YNHiJ0wDyQTM7gNEysug20+aHhhFJghEn+joOZOtLe9bcNFRf6MpaKiOiL50VozPgVNP1e3rKr0Ydgf0yjkYfl2ogCjNd4BhwQs8tzEElIdDil4hYerA7Pxw627LkgLV2OoaZLZgtanntB5AoWWrWxZ1FDLf1vbVvScjd1eT4Xz4mnBU+e/mcUUfjaOuxpeMc6xHLi9N4SyvaO8AG/7zdaZMAYJeCHdmoRvk5K/jzMvAlikv70Uewz8eP7ULKs3WcJhJdK/YCIHr2Z7a8YeS2COHurhMzjQhsOIYVMydKqouKiJc1kxR7Fw0RcPpGr3gYK62mQB/F88KGPdpoA7Tc/ToMysBVi9R6WkDQqRWuqMtyDJefgAEwpRZEa5yJWrnGjlr7/2jwhME
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 07:58:13.9320
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 76eb07a2-a1d0-4f6a-7eeb-08df237f92c6
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.60];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS1EPF00000094.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3473

From: Olivier Moysan <olivier.moysan@foss.st.com>

The characterization voltage used to calibrate vrefint depends
on SoC family. Add vref_charac_mV field in stm32_adc_cfg structure
to store the characterization voltage for each SoC, and use it
in Vref computation formula.

Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
---
Changes in v4:
- Adopt S.I. unit convention e.g. mV as advised by Joshua, instead of mv.

Changes in v2:
- Andy's review comments: rename variable to vref_charac_mv (unit suffix).
  Drop the const attribute.
---
 drivers/iio/adc/stm32-adc.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/stm32-adc.c b/drivers/iio/adc/stm32-adc.c
index 600f975f1d7b..23b51a291874 100644
--- a/drivers/iio/adc/stm32-adc.c
+++ b/drivers/iio/adc/stm32-adc.c
@@ -43,7 +43,6 @@
 #define STM32_ADC_TIMEOUT_US		100000
 #define STM32_ADC_TIMEOUT	(msecs_to_jiffies(STM32_ADC_TIMEOUT_US / 1000))
 #define STM32_ADC_HW_STOP_DELAY_MS	100
-#define STM32_ADC_VREFINT_VOLTAGE	3300
 
 #define STM32_DMA_BUFFER_SIZE		PAGE_SIZE
 
@@ -211,6 +210,7 @@ struct stm32_adc;
  * @set_ovs:		routine to set oversampling configuration
  * @smp_cycles:		programmable sampling time (ADC clock cycles)
  * @ts_int_ch:		pointer to array of internal channels minimum sampling time in ns
+ * @vref_charac_mV:	Vref characterization voltage used to measure vrefint calibration value
  */
 struct stm32_adc_cfg {
 	const struct stm32_adc_regspec	*regs;
@@ -230,6 +230,7 @@ struct stm32_adc_cfg {
 	void (*set_ovs)(struct iio_dev *indio_dev, u32 ovs_idx);
 	const unsigned int *smp_cycles;
 	const unsigned int *ts_int_ch;
+	int vref_charac_mV;
 };
 
 /**
@@ -1615,7 +1616,7 @@ static int stm32_adc_read_raw(struct iio_dev *indio_dev,
 		if (mask == IIO_CHAN_INFO_PROCESSED) {
 			if (*val == 0)
 				return -EINVAL;
-			*val = STM32_ADC_VREFINT_VOLTAGE * adc->vrefint.vrefint_cal / *val;
+			*val = adc->cfg->vref_charac_mV * adc->vrefint.vrefint_cal / *val;
 		}
 
 		return ret;
@@ -2713,6 +2714,7 @@ static const struct stm32_adc_cfg stm32f4_adc_cfg = {
 	.stop_conv = stm32f4_adc_stop_conv,
 	.smp_cycles = stm32f4_adc_smp_cycles,
 	.irq_clear = stm32f4_adc_irq_clear,
+	.vref_charac_mV = 3300,
 };
 
 static const unsigned int stm32_adc_min_ts_h7[] = { 0, 0, 0, 4300, 9000 };
@@ -2734,6 +2736,7 @@ static const struct stm32_adc_cfg stm32h7_adc_cfg = {
 	.irq_clear = stm32h7_adc_irq_clear,
 	.ts_int_ch = stm32_adc_min_ts_h7,
 	.set_ovs = stm32h7_adc_set_ovs,
+	.vref_charac_mV = 3300,
 };
 
 static const unsigned int stm32_adc_min_ts_mp1[] = { 100, 0, 0, 4300, 9800 };
@@ -2756,6 +2759,7 @@ static const struct stm32_adc_cfg stm32mp1_adc_cfg = {
 	.irq_clear = stm32h7_adc_irq_clear,
 	.ts_int_ch = stm32_adc_min_ts_mp1,
 	.set_ovs = stm32h7_adc_set_ovs,
+	.vref_charac_mV = 3300,
 };
 
 static const unsigned int stm32_adc_min_ts_mp13[] = { 1000, 1000, 1000, 4300, 9800 };
@@ -2774,6 +2778,7 @@ static const struct stm32_adc_cfg stm32mp13_adc_cfg = {
 	.irq_clear = stm32h7_adc_irq_clear,
 	.ts_int_ch = stm32_adc_min_ts_mp13,
 	.set_ovs = stm32mp13_adc_set_ovs,
+	.vref_charac_mV = 3300,
 };
 
 static const struct of_device_id stm32_adc_of_match[] = {

-- 
2.43.0

