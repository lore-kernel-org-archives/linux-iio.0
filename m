Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012015.outbound.protection.outlook.com [52.101.66.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9826F4F7982;
	Wed, 30 Sep 2026 14:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790777976; cv=fail; b=NRLRN/Q3DGh2O2GH4OsTyc4DAbFRDrjPn6c5pLkTMhEQ+UCkwhsiNJZT1mtIsnuyf/tSOyjj7Ha+aZZ+oscjbFPSRppeEneb6ZWJ2aknDGgJWi1qrG7mqOsFVg/RU5qKXlWMjNaVNaMI5CdN0zYvBogX0qhTwGXeoZJqWx4Q//M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790777976; c=relaxed/simple;
	bh=gysCf3eLEjbWBQFImeUKgrx/zoeKU+Nyv5hCGW9AyOc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=EFBX+NttdQfJ6NXJIUjBxOEZ8kbVbKh88QsVwdb+B8xL2DIJcQRL0gRArHxEQCF1/oNBorgJCvw3lfavXtqhHjGq0vkzKbBFOYVQxnv5iJu3OBpsK1bYEE+AGS2Bnibxs+flBWVik7yJhQlWkEn2f4Uk1loRVmRa78lVxP1MePY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=cG9Tx9mc; arc=fail smtp.client-ip=52.101.66.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="cG9Tx9mc"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wPH5i7Pj33Ovw1kKcQSpKQEgwBSPSwRkPVP2IKR6TD3OonxPjSk6sh1beF+aFwubxEwnAbWZ3748fLTHKvVqGSySVLqaMEkwHYBZt9DgJKz58PNcb37XP+w+1NSopgSyjW0cSO0bOqFyuGZRAEgMT4rA3tk0avY794YtLS7KjRqv34AMgkBmsvCVIGbHu8upTA314Vqk4nvYZaxNIoVkDjvDyHZ2Dp/Q2JKsyYOJBZb9zPPqFML9DnyFuK4kh0iKwMgQFuUQvsg2r5BkF9XNvDSPWLmce7wxngHJbJD+/YudPM4ZKNPDkR0DJT11XXry2Ev3D1BNZnRUbsKgafF2Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G681tWV9upUK5XrQSb69nlqAvk7DMhidVOboEisjSNo=;
 b=TjPHS+GRnvwWVZzXcyQvi2zEbNmehWcJ3cFlJdswsJ2xG7vk6df3ZFPmdjFkGHzY4DzIQAo/pSltWw4eErT5+DfGopwjO69peEEYIGeEmALwbiI8tdUiUxpdRwwKaD47JAU4kIwaOiF9L9tZ6vsJ2Z2llFu1m81WDWUhAxuKjpGSzM+K/R0DBebzSReTRHotqn/JF6oE2Hh6Wgc+Iw9c8sBtD5vFH1d3oI3NDZWtUvswOh5QqLaIv5/W6DU+0udv+jvj+3PK9m5tcCDeYwQpoJqvYYQPucg77/OIdcqffIcFH/Dp9beIrITlWSjWTWXTAqwV9Ja85cCjg6qmon+DtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=baylibre.com smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G681tWV9upUK5XrQSb69nlqAvk7DMhidVOboEisjSNo=;
 b=cG9Tx9mcp8ddYAS+WAMLfF5SYi/fVKs8cJidZfNvhJ9BMm8zWD3QykCAV/V7qb7aqi7fJjoILKQKb765fbGZIrG/KLpjnI2LIMq7YWeqH4VHLgtuoyy6qsThO9fOYIobCUcP3F5DF56bweG/nUhtdWnY77y5w2aEo4RXbrWmOjQ5U2xO6ONGo4N7z7EIMPSE6osV72v2RtVLI9+OmIoYhjvUjL6R1z+dgPu1g8SDkibDfqlq7gu3ZHNdhIVydpPPJMJu2cgvADUTACNzqO9IBgamGaWz2DYfpvN6xwjAYyZMxWrIDY4oUoic5+ie3/hcJxa6h26c3JR2Y7vTjKXkng==
Received: from AS4P192CA0027.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:5e1::17)
 by AS2PR10MB7372.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:604::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Wed, 30 Sep
 2026 14:19:18 +0000
Received: from AMS1EPF0000008D.eurprd05.prod.outlook.com
 (2603:10a6:20b:5e1:cafe::3d) by AS4P192CA0027.outlook.office365.com
 (2603:10a6:20b:5e1::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.15 via Frontend Transport; Wed,
 30 Sep 2026 14:19:17 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 164.130.1.60) smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 AMS1EPF0000008D.mail.protection.outlook.com (10.167.242.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Wed, 30 Sep 2026 14:19:17 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Wed, 30 Sep
 2026 16:25:09 +0200
Received: from localhost (10.252.17.140) by STKDAG1NODE2.st.com
 (10.75.128.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Wed, 30 Sep
 2026 16:19:15 +0200
From: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Date: Wed, 30 Sep 2026 16:18:27 +0200
Subject: [PATCH v3 06/15] iio: adc: stm32-adc: add vreg enable option to
 manage diversity
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260930-adc-stm32mp25-v1-v3-6-406834430d72@foss.st.com>
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
	Fabrice Gasnier <fabrice.gasnier@foss.st.com>, Cheick Traore
	<cheick.traore-ext@st.com>
X-Mailer: b4 0.16.0
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS1EPF0000008D:EE_|AS2PR10MB7372:EE_
X-MS-Office365-Filtering-Correlation-Id: 300c6fcc-8aa8-49aa-c4b0-08df1efdd03c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|23010399003|376014|7416014|1800799024|82310400026|22082099003|18002099003|6133799003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	CeUlXRlrkeXcJ5Z+oqXEbEzLU01NJ8dYf7p0neQrO8SR8mrNIyDvbKRlRcc1vODZUAHG9uG8/yE1FJ6rUaus13zt34f32wqqidzCx5bsnIdvePES94Pjo1AJB3q6G61XRqZDr30cmR6vNenxcpIj3z0oToOOaVwbFxg+8PDNzk590FQYkfE5BhsqmAlbhyTRTEzhfs6DgpAKmM/I8BcWdAQMmHEoD+CveVZZkIcFDWDNdOCQLRFIRTAgBehFxn73KMheeKTZypbmJSypqx9LFqY5JNBjhSh7Ijp7BFdKm1Pgsoe27dSBBdgGrmMrhOWCwyLrfc1yOPzSXkWaEiIEltQvHhAtQRc28uvoFjDpRxsemQSUyHnx8TYB7ie3XU7Tp+GVxnPFrFiqdUjYduc+w6wJOg0MG3KHyHoY9YRbIXnhIJq5MVRgc7gLG4rGTiV6C9bXxOxeQ77NpckU+MXTiT1z85yX3b0Nl2OmXLU2MdzfsGpnqlq6uDZSyomZcaFpXgJGGLEleYE8mbPpTIQcmA/Mg0lRAxERYVVJQrPmSx8mSj6quBnztY3hT6QqpIbKanggRzz+mmgcyTAFaNXWxSG6nYn8geCfiIh5sHF+UPCYmxu/qjX6tj5bO//3/ZuxQhHUsNjzc0gCSUeT7yLEWWnwaYJ+l1nI4ZEG4aYDg6W53LGF0skqM0C+zLwerUH2OlCFCt58PLc3OTS6G6GLfA==
X-Forefront-Antispam-Report:
	CIP:164.130.1.60;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(376014)(7416014)(1800799024)(82310400026)(22082099003)(18002099003)(6133799003)(10067099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	iPUJnF1vjQ6tbVMtouAq7afTjypZOGNg0Ef09ESOUbVBK0xsUxRsn/ESn/XFirzzV4m9x8ulVvqIXJc2zeN/dRJdeVPu+B4J1+4/aiXX3GX1zrS5poGBU0wvhWtNoTASJKK+Alwco+T6GjchhsCD4ybmD/8mJRUZJCYqjgDAIjVjsS7bH6WZmd3IIF+spNoKb0gQvsgRrMBCcG7indPUoaBnOxS1yv0wRsjsChsSRbcYls/HFGoXCKlRnsPtLK3b0O89JBhOpb3G2J7Mh/1vjtG15YnBp14+ZLK9AuwL6RjSy/ebMFigJUs+LYjnd8+lZhIM91Mb7mevwHZMzRIKIAko6ny6WHuBM/aF3/Hdq95xGgA/0arlYx7A2pI9AyaOe8BuV74PA0XkXIPOutNDZOx+u8LZUyFO+HrzDy6x6JhY3QpUVNq/VjREL6Eb4AxM
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 14:19:17.8279
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 300c6fcc-8aa8-49aa-c4b0-08df1efdd03c
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.60];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS1EPF0000008D.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB7372

Add a boolean (has_vregen) in adc configuration structure to prevent
setting the reserved bit (CR_ADVREGEN bit 28) on STM32MP2 SoCs.
This bit is present on earlier stm32h7, stm32mp13 and stm32mp15.
No functional change intended.

Co-developed-by: Cheick Traore <cheick.traore-ext@st.com>
Signed-off-by: Cheick Traore <cheick.traore-ext@st.com>
Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
---
Changes in v2:
- new precursor patch, e.g. split as suggested by Andy and Jonathan, to
  prepare the infrastructure for stm32mp23/25 support.
---
 drivers/iio/adc/stm32-adc.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/stm32-adc.c b/drivers/iio/adc/stm32-adc.c
index 75b1f17f664b..92c6fba10f31 100644
--- a/drivers/iio/adc/stm32-adc.c
+++ b/drivers/iio/adc/stm32-adc.c
@@ -193,6 +193,7 @@ struct stm32_adc;
  * @has_linearcal:	linear calibration support flag
  * @has_presel:		channel preselection support flag
  * @has_oversampling:	oversampling support flag
+ * @has_vregen:		voltage regulator enable/disable flag
  * @prepare:		optional prepare routine (power-up, enable)
  * @start_conv:		routine to start conversions
  * @stop_conv:		routine to stop conversions
@@ -213,6 +214,7 @@ struct stm32_adc_cfg {
 	bool has_linearcal;
 	bool has_presel;
 	bool has_oversampling;
+	bool has_vregen;
 	int (*prepare)(struct iio_dev *);
 	void (*start_conv)(struct iio_dev *, bool dma);
 	void (*stop_conv)(struct iio_dev *);
@@ -961,7 +963,8 @@ static int stm32h7_adc_exit_pwr_down(struct iio_dev *indio_dev)
 
 	/* Exit deep power down, then enable ADC voltage regulator */
 	stm32_adc_clr_bits(adc, STM32H7_ADC_CR, STM32H7_DEEPPWD);
-	stm32_adc_set_bits(adc, STM32H7_ADC_CR, STM32H7_ADVREGEN);
+	if (adc->cfg->has_vregen)
+		stm32_adc_set_bits(adc, STM32H7_ADC_CR, STM32H7_ADVREGEN);
 
 	if (adc->cfg->has_boostmode &&
 	    adc->common->rate > STM32H7_BOOST_CLKRATE)
@@ -2721,6 +2724,7 @@ static const struct stm32_adc_cfg stm32h7_adc_cfg = {
 	.has_linearcal = true,
 	.has_presel = true,
 	.has_oversampling = true,
+	.has_vregen = true,
 	.start_conv = stm32h7_adc_start_conv,
 	.stop_conv = stm32h7_adc_stop_conv,
 	.prepare = stm32h7_adc_prepare,
@@ -2747,6 +2751,7 @@ static const struct stm32_adc_cfg stm32mp1_adc_cfg = {
 	.has_linearcal = true,
 	.has_presel = true,
 	.has_oversampling = true,
+	.has_vregen = true,
 	.start_conv = stm32h7_adc_start_conv,
 	.stop_conv = stm32h7_adc_stop_conv,
 	.prepare = stm32h7_adc_prepare,
@@ -2771,6 +2776,7 @@ static const struct stm32_adc_cfg stm32mp13_adc_cfg = {
 	.adc_info = &stm32mp13_adc_info,
 	.trigs = stm32h7_adc_trigs,
 	.has_oversampling = true,
+	.has_vregen = true,
 	.start_conv = stm32mp13_adc_start_conv,
 	.stop_conv = stm32h7_adc_stop_conv,
 	.prepare = stm32h7_adc_prepare,

-- 
2.43.0

