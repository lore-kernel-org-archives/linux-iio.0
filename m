Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011035.outbound.protection.outlook.com [40.107.130.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3009A48C8A9;
	Fri, 11 Sep 2026 15:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789141916; cv=fail; b=ndSJp5mnXk34N1ndnpjhLmXtETgU/5EA+80SGTUTc+KLsCPMOhwZSApuhWaZ9AsYJnsM/TrYiBB9LSOUA78LBs3jwkFLy/QpYKzI4wLzGptznI2ZEYd4xQQHyew3/85xynxGTQCmIhJ+6CCFaMvNMBI0C7tXsp3Ds5BFtQHCXJ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789141916; c=relaxed/simple;
	bh=yl3NfKJ8/bcN+sgYoRnr6ICTGmhGmagstDoviNqtDXM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=bVrUM1T6JBZH9/V+isE9iiTgtcAS4/4JH9H08uMtjvISip8hqlMdRnzuM1+A2hSZ9fMI6qTHcyHGZkQKk7zuzq6b9guXu1QGSpC+CCBCz9fAASozDr2ZuQrSj3X5W9cZ8GwImM6eH3z6umpk0sq4UBnkhFqzw1CO4Y5R5ogukXA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=I/B0/GGn; arc=fail smtp.client-ip=40.107.130.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="I/B0/GGn"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EXz32bloMIZ90sbYD/SJ/SxepS1+PC4o7+OTELhuQ/HFX5QCSdAiWMjVVlX0X9UralpXMzbcCVKTCMZJG9YECp/GI2VWknrtddI2KAjfZ8DZ7Cd/aO0JARVTHMbpDzKfqlH7nTF9Lg83oGSVRy/WU0vEth+crwBJ7J/4yHuhZysnlki1MzBFYMoj+WiZsnmuwLIPR5q2yzXlOewoh0CiLd7XBK3A9B2paGqe2lzhDuknEB5oet1qVXd1Pi5R7c5ukrPY0Ouxg7ZmK7yMsj/IW2/1evYY4kwNklAKeDJa6fOjROAvn/CVXvAL+Dt7z06bHaAOZuLeSDUOViaJmEOeZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3YpgAexFraiJ5QcnNyH5P/IhuWA0pl74qR/PCzIRsxU=;
 b=tHdFOKKud437emdkvP7+hN4w1X0EO4oYW6iuAT/Azk5+moB2VVdHFVV0tbc3yik4Mw4k0VgRY8Gexco/xviKd6xGCrQ2Nm21cnME80VX9lvEJQZ+nEEHMf5K6juHRRbA+kHN08vr7YEQpm3JNmhLhP/Gb8g6eECAQo2HMb1WpD+xDVhtBPE0KKYbhEealekCeF4oHPlPV/J+NUGZetNV05AhLvjDo6NvKzADZoygNNMBcmtaqHvCBs2fPihQ7vil6/jQqG692jtm1QzSMLN2EQ5U9CDrXkRSM4zNl9I5Lk2tJLHF6rQnJ75bWDMpV0wzusLY7suKHmcAByuIT5JjmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=kernel.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3YpgAexFraiJ5QcnNyH5P/IhuWA0pl74qR/PCzIRsxU=;
 b=I/B0/GGnW1pRQnlmp+R0iwOCV960PSgyE+eF1EyoJDnDxnSmSProkWKiWqQf1T3hzokpA39DzaLm64y1Yv2Jb7kx9N5g4a350YKVwWoQ7YW6Wa2GLx3wt0R6T/mkTHqMlUdT4s8dp2301mffq1E2fEInnaAH72U6k2YL9VYhJ7ddUWMqhpax6zwHJwf0gH80Uvux1eC52Je7A8a/X8k9kIhyfgxruqmkxes7W56OBSKtWr1YWRhNpeU/gCvmYw+EQEyx+hIMXnlLXs/nvmH/NTAwL11n6Lf2GeIXcopeH8sCcaiMUq07kx7P2VX/dVmZS9nChF70C1luwTuBvPgiqw==
Received: from LO4P265CA0047.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:2ac::14)
 by AS2PR10MB7178.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:60e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Fri, 11 Sep
 2026 15:51:46 +0000
Received: from ZR1PEPF0000E6AD.eurprd05.prod.outlook.com
 (2603:10a6:600:2ac:cafe::4d) by LO4P265CA0047.outlook.office365.com
 (2603:10a6:600:2ac::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.15 via Frontend Transport; Fri,
 11 Sep 2026 15:51:44 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.60)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 ZR1PEPF0000E6AD.mail.protection.outlook.com (10.167.241.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Fri, 11 Sep 2026 15:51:44 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Fri, 11 Sep
 2026 17:57:11 +0200
Received: from localhost (10.48.86.251) by STKDAG1NODE2.st.com (10.75.128.133)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Fri, 11 Sep
 2026 17:51:43 +0200
From: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Date: Fri, 11 Sep 2026 17:51:24 +0200
Subject: [PATCH 2/8] iio: adc: stm32-adc: manage characterization voltage
 diversity
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260911-adc-stm32mp25-v1-v1-2-cef26eecdef2@foss.st.com>
References: <20260911-adc-stm32mp25-v1-v1-0-cef26eecdef2@foss.st.com>
In-Reply-To: <20260911-adc-stm32mp25-v1-v1-0-cef26eecdef2@foss.st.com>
To: Jonathan Cameron <jic23@kernel.org>, David Lechner
	<dlechner@baylibre.com>, =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, "Andy
 Shevchenko" <andy@kernel.org>, Rob Herring <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, "Maxime
 Coquelin" <mcoquelin.stm32@gmail.com>, Alexandre Torgue
	<alexandre.torgue@foss.st.com>
CC: Marek Vasut <marex@nabladev.com>, <linux-iio@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	Fabrice Gasnier <fabrice.gasnier@foss.st.com>, Olivier Moysan
	<olivier.moysan@foss.st.com>
X-Mailer: b4 0.16.0
X-ClientProxiedBy: ENXCAS1NODE2.st.com (10.75.128.138) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZR1PEPF0000E6AD:EE_|AS2PR10MB7178:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d78f2ab-4df0-4de1-8799-08df101c9482
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|23010399003|36860700016|376014|7416014|6133799003|18002099003|22082099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info:
	CRCG0xF6g+bz78KS7dUOWZ5O4mcUJpEMkrkgL43i72Ie6sK6N5wf4RgpF66avL2CrWuCtP/y7UCf0JQo6BzOG9nhh8mxOsAuqJJ4hnvVvgQxtqme3eWMJjr/w7cSOA8hD85irBx7dI6XO0Ex3kPeWa5Xg2tZ9igo+M9O0ycKRyNIrYKoau5TBxg/cYDRxpofd6b56DKfHpYdyUrHHBWZALkFRGQbGNjAgLqUPpoakSVDrAxJdLmv1lMwmrllvTmHwS4lyehSjixH6lkOdKgnd6C/XHVGC+J1gvFIQLtqPWTeJQCHyPCioX2P7zUO/KjcIDRX4m/EtjsF9XEbTDWCvdRz6CiUks8OhO8xpFNNbhlPLp0CJpJMxJZJRMnXHjy7KUIlOJzEqno3Z9MmtAXqPUUQJNj5EYy9ky6UlKyManlscnGbpGQOspcBsQOC2re4kr+bUUwzF9AfkMFpLiFp6vaYW0UyjkdNSRzsHwbHbfeGCNd56AWviBNjXqL/9B++jqEXFP233waYIWJgbvHU3nYz9xs1KBZ8gLTRdqCJqQCrIwzwWKIzO9sWymu9YOQ/VuuBsBULUpJCOSQt71kKafeptmzxEDI/LAW1W9xQZti4x9y32L85xvSclqtFy9bepVsFFbwjU7atA5tvzlN0tCnx0eZnRtfJa2stYOVVUZbmusIVBde2/YmUlrjseMf4qZq53VzIqUPiM1uvtCqGBQ==
X-Forefront-Antispam-Report:
	CIP:164.130.1.60;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(23010399003)(36860700016)(376014)(7416014)(6133799003)(18002099003)(22082099003)(56012099006)(11063799006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	s9jThMFE8jRdDRuXKiBCA1L279+ZfFYvyDERZAzUfhB4zd2OXiwdyuBSy9577GsRpNGLHoZidhjDEzL2kKE4ME63/7oP4ofOZRXuLJwDcx45Xyh077J25ZxfcVbXnmhDr14/K2PDE+2S1pAU95JYfhnGA0kZFKEP0ubBN91jN2/tE1m+28eHz7BqKZI/yjqsRPrWjPyLesFRbEFgM0e+w73e9uX5Z1ayRkyUxoXVX2kR60zpKdcL/zFsOfm+ZX7fwz6mP6DHlTw3wa2chIzu6DXGwBA50pJ8SfXhxUqi1MM3dRhT0MDAmVYuX2ytPA92hvbQOKEkh8YmjXw7yih+1kcLZ8EKS58xrfxWWaN1EvRZ9Hq3gS4XpOdZHCdCH6HcjeP6unLM4SmjeYWO1AoE+U/w6MLgducsJjpHU8QfYY1yYiQesc4V3L25Okb2h4HQ
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2026 15:51:44.5938
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d78f2ab-4df0-4de1-8799-08df101c9482
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.60];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	ZR1PEPF0000E6AD.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB7178

From: Olivier Moysan <olivier.moysan@foss.st.com>

The characterization voltage used to calibrate vrefint depends
on SoC family. Add vref_charac field in stm32_adc_cfg structure
to store the characterization voltage for each SoC, and use it
in vref computation formula.

Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
---
 drivers/iio/adc/stm32-adc.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/stm32-adc.c b/drivers/iio/adc/stm32-adc.c
index 5c6c06b269be..183b3474cad1 100644
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
+ * @vref_charac:	Vref characterization voltage (mv) used to measure vrefint calibration value
  */
 struct stm32_adc_cfg {
 	const struct stm32_adc_regspec	*regs;
@@ -230,6 +230,7 @@ struct stm32_adc_cfg {
 	void (*set_ovs)(struct iio_dev *indio_dev, u32 ovs_idx);
 	const unsigned int *smp_cycles;
 	const unsigned int *ts_int_ch;
+	const int vref_charac;
 };
 
 /**
@@ -1610,7 +1611,7 @@ static int stm32_adc_read_raw(struct iio_dev *indio_dev,
 			ret = -EINVAL;
 
 		if (mask == IIO_CHAN_INFO_PROCESSED)
-			*val = STM32_ADC_VREFINT_VOLTAGE * adc->vrefint.vrefint_cal / *val;
+			*val = adc->cfg->vref_charac * adc->vrefint.vrefint_cal / *val;
 
 		iio_device_release_direct(indio_dev);
 		return ret;
@@ -2702,6 +2703,7 @@ static const struct stm32_adc_cfg stm32f4_adc_cfg = {
 	.stop_conv = stm32f4_adc_stop_conv,
 	.smp_cycles = stm32f4_adc_smp_cycles,
 	.irq_clear = stm32f4_adc_irq_clear,
+	.vref_charac = 3300,
 };
 
 static const unsigned int stm32_adc_min_ts_h7[] = { 0, 0, 0, 4300, 9000 };
@@ -2723,6 +2725,7 @@ static const struct stm32_adc_cfg stm32h7_adc_cfg = {
 	.irq_clear = stm32h7_adc_irq_clear,
 	.ts_int_ch = stm32_adc_min_ts_h7,
 	.set_ovs = stm32h7_adc_set_ovs,
+	.vref_charac = 3300,
 };
 
 static const unsigned int stm32_adc_min_ts_mp1[] = { 100, 100, 100, 4300, 9800 };
@@ -2745,6 +2748,7 @@ static const struct stm32_adc_cfg stm32mp1_adc_cfg = {
 	.irq_clear = stm32h7_adc_irq_clear,
 	.ts_int_ch = stm32_adc_min_ts_mp1,
 	.set_ovs = stm32h7_adc_set_ovs,
+	.vref_charac = 3300,
 };
 
 static const unsigned int stm32_adc_min_ts_mp13[] = { 100, 0, 0, 4300, 9800 };
@@ -2763,6 +2767,7 @@ static const struct stm32_adc_cfg stm32mp13_adc_cfg = {
 	.irq_clear = stm32h7_adc_irq_clear,
 	.ts_int_ch = stm32_adc_min_ts_mp13,
 	.set_ovs = stm32mp13_adc_set_ovs,
+	.vref_charac = 3300,
 };
 
 static const struct of_device_id stm32_adc_of_match[] = {

-- 
2.43.0

