Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010012.outbound.protection.outlook.com [52.101.84.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A6874FD26B;
	Wed, 30 Sep 2026 14:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790777971; cv=fail; b=ukle+S8BSGkpp7K2khtkOVZVJxFSqMsASatudlldAk75mTnzncY+nnZ+amppKJZCG3bkI0RMZDNqDJGr0UbQm7hBJ4p+Zs/WEvXYKv73v32sFI0AU85WxQQR//qR+5feBE3cnEXTqrC4+Q48p1yJsXn0BzAIeowsL6lZ7n6uDSk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790777971; c=relaxed/simple;
	bh=i3adXDOHfku8HbvZYf9v8N8HMWemM/fNDIOazavBL/w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=MY9cXdOrsNkmoBULak6PatlLHMc1lq0LGyLX8XTnywtQO1xr7khjkLWT1c2JrpVTPDthicg17SmWJIldJcJPWpgICQNk4km5L9/TJ5oNEgRdbAUCh4gdLEVk4PIhxJIW7+5HZmAi81qPraBExpaWRxVowsligvFOrPIomJmPOVk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=JD+GI37H; arc=fail smtp.client-ip=52.101.84.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="JD+GI37H"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fFqHN1BN454rY1nZSatsChCaseY+cJuFFX/W+x/BD3Oml2ejEQ/2O2vwx0JFRI3+w1p7jZwX0+RuiOj9nWi1QHb4stBGc51WwcpBF3sTn5JmhLVJJvm/P9l7gz1uVSyjHcC5aDYCZNdYmr39l/YSiIjN+QljlYg8yuJrhkEVixAS4SR7kOqmzvYeCm3seIL7434RtrAEhL2YY0HqRNnVyea6oK95yK0te0mmFebJTwO1qKWmZLsfthUYtaxXZ2qYF7IU5sUsVOj5d6j76MfxLp/paGO2abf2JjGQ3W8180+U6UgqPgT32Zgf/6GktcO2giCQJMVngNhUw1vpk4vnLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0CphBtJFfETMMYL9g8KTvr6X/yFQGXK4A12WUYlObho=;
 b=bkBL66mRUVoQq7pAG8RLb1KnebTdbViFfCBdI1E/WRVhSxch8wD2eP3b85OO3vi2F1axiMWriMxt6sT5LmSsbEk9j3smXADO4Nt4piy9yTTNVk32QdcS8ycvMxGRX8Ec61Fijw+3lTzTNYCLSAc808KBiUj7/196pVTeWenW70ns6hMfVE69YbvxbQEVf44oqOgovKhOYBRL+syKk3Ukw2QEyGJy4JJR+YGuvbJNaiC0Dv57vFo54M6xG7k6Xh0Yae501fRUR1b74TU7QgITVZvRUg1CIlnPTniErx74xWE+lZapUj4qoBUyRoRHtYnWOSrH3lSkdfLluJMEh6nxtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=baylibre.com smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0CphBtJFfETMMYL9g8KTvr6X/yFQGXK4A12WUYlObho=;
 b=JD+GI37HcM9hWH5nqF1pRyxip7PYm88GmNS/KH2B3fQ2+fVj9s/uaHvw+GCyi1jxwp9pms+2BTGuVQbntmuNPqiv05vXqNNkDuFnc5DlTo4UW1M7yG+OZs+t7WSSBesCV0z2Bw8H4K5V1hFLSqn2Zoha/25CIpSYVbcQZy9gQ/OIqKIWx/74D8Qgqp96Ex5hGGq4XYMDN6eVy84qnO9rkJgZzB5JfM2OicwtWYNsPk4Y/hcItlL31PZsUzAG//eEQw5TLiFOWkSeGAuSNqQTAVbfyx9r5if+iATP4bjTmymzCdeb0pECEDo0hci/zSW4eTGFUHw5OU4Oww1rv2XfDA==
Received: from DU7PR01CA0015.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:50f::13) by PAWPR10MB6757.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:331::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Wed, 30 Sep
 2026 14:19:14 +0000
Received: from DU6PEPF0000A7E4.eurprd02.prod.outlook.com
 (2603:10a6:10:50f:cafe::4f) by DU7PR01CA0015.outlook.office365.com
 (2603:10a6:10:50f::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.16 via Frontend Transport; Wed,
 30 Sep 2026 14:19:14 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 164.130.1.59) smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 DU6PEPF0000A7E4.mail.protection.outlook.com (10.167.8.43) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Wed, 30 Sep 2026 14:19:14 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Wed, 30 Sep
 2026 16:25:46 +0200
Received: from localhost (10.252.17.140) by STKDAG1NODE2.st.com
 (10.75.128.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Wed, 30 Sep
 2026 16:19:13 +0200
From: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Date: Wed, 30 Sep 2026 16:18:25 +0200
Subject: [PATCH v3 04/15] iio: adc: stm32-adc: manage characterization
 voltage diversity
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260930-adc-stm32mp25-v1-v3-4-406834430d72@foss.st.com>
References: <20260930-adc-stm32mp25-v1-v3-0-406834430d72@foss.st.com>
In-Reply-To: <20260930-adc-stm32mp25-v1-v3-0-406834430d72@foss.st.com>
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
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU6PEPF0000A7E4:EE_|PAWPR10MB6757:EE_
X-MS-Office365-Filtering-Correlation-Id: ffddf0de-833c-4471-0cbf-08df1efdce06
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|82310400026|7416014|376014|36860700016|1800799024|18002099003|22082099003|6133799003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	SmH5dZegM9yIhuecvBPkNQEvwMiFz2dmdV0Kul5thuWT7wrwVnH4o9QXDxUiRcuSTLmnkNmAv7ERRKPvbkC+pAKXHAXp6QEEEyAp57brgdc9SflwbQIyGqULsPsgEVn/YcoxWe7ufwEib7It15CPXNMgnTB7AoFr9iHtFhJgcC0zFgPyOgtw6mj0SjnBBDPJv4PFup3MH88KcCo4jiF4QgswxQScI46s90uRVPIRJ53lX0BHCXRJtzxYzeUM0Hq0lsrE7NyyOvVUFGo15xpxuWkuoOD2xIWo5MD6tgzAEyI491G3UWXf49Mr1ekyA0ujs2ha+M+Dna4S3AiJxn8SLfEv1bNDL4ojInXcO/Po+/GoahmJLEWt/sWC37bqkY3cOlqTQRrN6c5iwzjCN5lV1h820QJjCRaDOaMXoP6OyaOF0A+NQqV6XaBGg0MPivQECjB6P8Nqwm9nXePgsBX3m97uqZowxigqPG3bNGuutRfegoVqItkhXNvhYAvZ6lqBxkRRurhkzehGaiMKOneRhWWJqoP9Rn9Bu73TQ91AfJa+tpkyZuRkJtHnbdGTxV3YyB3rgBPK+mjQ7+9jeF1QFl28v1MQ/4s6YsOIl65cay+D0aaWCqJITHSNjY0GfN8BN/TCOJNWIm4EpRvy9lz2Z9eopc8X6tuM30axNGb4Ib9V3/YGpAF4S4uV5UYScVS1+T8EoZUJpU5UxyR9GEwE8A==
X-Forefront-Antispam-Report:
	CIP:164.130.1.59;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(82310400026)(7416014)(376014)(36860700016)(1800799024)(18002099003)(22082099003)(6133799003)(10067099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	4/lWhSGRmk8mxd3CAgtGS3bk5o3knj5emRoN6s0uYh8l+rpeBHoRbNruKlkSdUjf1kC1zztVDyA+CHXT6Txs5efoYzWHLMhkiGSOJEhLMFNj2ZQJ0jM6J+nV6WOWVCDx0xz+ZRSpCHF8V69l3FAWDvLhbdtfhMkbqvY1ZqZIwDRJk+A5aM4YlAj8ViNYXYUmtUn4CtIu6w1z454ntf0UGHD8WQTo0zgLn4RqRXReo9nq4UDqI5+HdNRffjXYBH03uvBGVHHJpQEGIbHd7F0di/cRBRs31mdEcUGryNioxSzQjYQuIQXrEDEPIqprxPl8vYkJcEyRKQOHvTTBZnZL+jQKYiqk1rbsBn5CPWSMAxFPD+4OK1UL2VUwM0WgAaOyp4mE/1bVHAwndWlwSEtF3ts3pxepyovjEPC5CVAL8opnCETXKBIda6RvjdCvOgwv
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 14:19:14.0734
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ffddf0de-833c-4471-0cbf-08df1efdce06
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.59];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF0000A7E4.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB6757

From: Olivier Moysan <olivier.moysan@foss.st.com>

The characterization voltage used to calibrate vrefint depends
on SoC family. Add vref_charac_mv field in stm32_adc_cfg structure
to store the characterization voltage for each SoC, and use it
in Vref computation formula.

Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
---
Changes in v2:
- Andy's review comments: rename variable to vref_charac_mv (unit suffix).
  Drop the const attribute.
---
 drivers/iio/adc/stm32-adc.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/stm32-adc.c b/drivers/iio/adc/stm32-adc.c
index 600f975f1d7b..fa46803d54be 100644
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
+ * @vref_charac_mv:	Vref characterization voltage used to measure vrefint calibration value
  */
 struct stm32_adc_cfg {
 	const struct stm32_adc_regspec	*regs;
@@ -230,6 +230,7 @@ struct stm32_adc_cfg {
 	void (*set_ovs)(struct iio_dev *indio_dev, u32 ovs_idx);
 	const unsigned int *smp_cycles;
 	const unsigned int *ts_int_ch;
+	int vref_charac_mv;
 };
 
 /**
@@ -1615,7 +1616,7 @@ static int stm32_adc_read_raw(struct iio_dev *indio_dev,
 		if (mask == IIO_CHAN_INFO_PROCESSED) {
 			if (*val == 0)
 				return -EINVAL;
-			*val = STM32_ADC_VREFINT_VOLTAGE * adc->vrefint.vrefint_cal / *val;
+			*val = adc->cfg->vref_charac_mv * adc->vrefint.vrefint_cal / *val;
 		}
 
 		return ret;
@@ -2713,6 +2714,7 @@ static const struct stm32_adc_cfg stm32f4_adc_cfg = {
 	.stop_conv = stm32f4_adc_stop_conv,
 	.smp_cycles = stm32f4_adc_smp_cycles,
 	.irq_clear = stm32f4_adc_irq_clear,
+	.vref_charac_mv = 3300,
 };
 
 static const unsigned int stm32_adc_min_ts_h7[] = { 0, 0, 0, 4300, 9000 };
@@ -2734,6 +2736,7 @@ static const struct stm32_adc_cfg stm32h7_adc_cfg = {
 	.irq_clear = stm32h7_adc_irq_clear,
 	.ts_int_ch = stm32_adc_min_ts_h7,
 	.set_ovs = stm32h7_adc_set_ovs,
+	.vref_charac_mv = 3300,
 };
 
 static const unsigned int stm32_adc_min_ts_mp1[] = { 100, 0, 0, 4300, 9800 };
@@ -2756,6 +2759,7 @@ static const struct stm32_adc_cfg stm32mp1_adc_cfg = {
 	.irq_clear = stm32h7_adc_irq_clear,
 	.ts_int_ch = stm32_adc_min_ts_mp1,
 	.set_ovs = stm32h7_adc_set_ovs,
+	.vref_charac_mv = 3300,
 };
 
 static const unsigned int stm32_adc_min_ts_mp13[] = { 1000, 1000, 1000, 4300, 9800 };
@@ -2774,6 +2778,7 @@ static const struct stm32_adc_cfg stm32mp13_adc_cfg = {
 	.irq_clear = stm32h7_adc_irq_clear,
 	.ts_int_ch = stm32_adc_min_ts_mp13,
 	.set_ovs = stm32mp13_adc_set_ovs,
+	.vref_charac_mv = 3300,
 };
 
 static const struct of_device_id stm32_adc_of_match[] = {

-- 
2.43.0

