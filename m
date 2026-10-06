Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011022.outbound.protection.outlook.com [40.107.130.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22B403C3F4F;
	Tue,  6 Oct 2026 07:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791273506; cv=fail; b=s2Hr8datb7SQUuBXCdffSbjOEnidUaJepNjDxu9oZtt2KGvswxmZ51V59MmlfkeePhLeGpC9zLOIB5xVSJTbuzsXKjhJtjwIRnrXgd+dLyE8p2qw0iz9B4ffOLr+B0yYDAwTYsLWZTpZyaIwzRLNmCT6twL7qcwSqaz+Hf9YQoc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791273506; c=relaxed/simple;
	bh=/x7waFHICjHSQt36vS2G5ERx2ZoOWhPomWKhgObTX84=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=OkZ0XROsO0CKijVDqOil2xV3Q2o/Q35U9pGE2ph3wpuLCs5o8LM1wV97BRQEw2ILUDWk58YToVpwoPEaXqkqsBAajm+PAGok6VDQpu5Ohe9QFR3NmGhpRp7fCqA5Q7Yqi6oXqz8xdR8sxB/az/qPZCNqUtLBfhPq4JH1Vhr5KKA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=CS2USC6P; arc=fail smtp.client-ip=40.107.130.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="CS2USC6P"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W+pIsOJvfCYLYYGU1YXzMScdIczTZLpurZS+InvMKB4FQJM8Va1NC63RwjWJzpW6CwAal+LKViiEGG+oSjnH37zloVCAJt37+USx1cmaBd4NjOkAyv7pCET9k3f+JosVWKymX8Ag+brO8z84OugC3PgGpan90B9QEJmj7rtOfPw6HtBNOUElQoDApudsGRwSg3qYp1Qn2Z7gczfAIdyIT1gb1i+HItAZsxr8znsde1Y6jilq6jBNjwJdVOaxuHmBL9sAWVp2W9EwlXQB5OkbanBDTvsyFZ5/clybHwOS8B00+2L0o02Y51ygMi46VLJvtRbgP+RJaH2HoIERnN0htQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5zj8scsg4D/fZEwf3lms2lNggs1yIcVfj8UxrEI3WyY=;
 b=B5ye4Bdf7dZd+lLMMoEzzXuDZWXDEi00ulImY6xPHQlw2YN0f4xmt7lVNaWhCPBIRd5yGtJYJ34bpBQaaO8z8FLNkVk+S4PolI+2WoAoR8of4Mw0inPBbiJMuKxt+2JynZgQK8nEjL1O0JTYJFk2I6FN0Sh+HWiyMwTcw5Yv3E9UD/I8/P2UqJJxnAOOKhgvtzvab5fq5KNoZS4gaWnt710rmKls21Bci406itlb6G6ZJ3rCv4/Iy/IdpPqk5OxzBX8qe3s+/9VtB/EPLBIg8L9IcmUG6jzL7G/bB9Wbgeh0npURXsbaPcLS1nlekjSO49+Tplm6AWYI1XBF1BrMPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=gmail.com smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5zj8scsg4D/fZEwf3lms2lNggs1yIcVfj8UxrEI3WyY=;
 b=CS2USC6PGkKJ5urtkBZldeD9hM1C0r0gle80b0luoNnHic95zk9f9bdhz9gTRhZIB8rSiEeFdQvOClH5CSJeqtqxsAhQi3PlJw8iNQy5FkhcXyeAhLklcjcwbspBS53nVc51vLYSoQGWvD8rhApxnOJ7RaNconG0rauLt+NUj6jj/DmkvihoGWHeseTEbCDaEJBNNpzP9ytEIxiik4JXxBggR3Io3+byJqSw58lZNWobTUyVlPW2Dj9WfVP2zuwisj/oNWtfCBQtTxcnE6MNKxag1QbLJ+bXG8NQd4LnbXWpDFNttlaT4GHjPMRP7aJUfYL40idFr2CSaKXhcpUsMQ==
Received: from AS9PR06CA0083.eurprd06.prod.outlook.com (2603:10a6:20b:464::27)
 by AS5PR10MB8295.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:655::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Tue, 6 Oct
 2026 07:58:14 +0000
Received: from AMS1EPF00000094.eurprd05.prod.outlook.com
 (2603:10a6:20b:464:cafe::48) by AS9PR06CA0083.outlook.office365.com
 (2603:10a6:20b:464::27) with Microsoft SMTP Server (version=TLS1_3,
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
 15.21.496.14 via Frontend Transport; Tue, 6 Oct 2026 07:58:14 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 6 Oct
 2026 10:04:15 +0200
Received: from localhost (10.252.27.219) by STKDAG1NODE2.st.com
 (10.75.128.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 6 Oct
 2026 09:58:11 +0200
From: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Date: Tue, 6 Oct 2026 09:57:37 +0200
Subject: [PATCH v4 06/15] iio: adc: stm32-adc: add vreg enable option to
 manage diversity
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261006-adc-stm32mp25-v1-v4-6-d31ec75aecf3@foss.st.com>
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
	Fabrice Gasnier <fabrice.gasnier@foss.st.com>, Cheick Traore
	<cheick.traore-ext@st.com>
X-Mailer: b4 0.16.0
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS1EPF00000094:EE_|AS5PR10MB8295:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d5d6598-4722-4b44-1bee-08df237f92ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|36860700016|376014|1800799024|82310400026|7416014|10067099003|11063799006|6133799003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	V8jAS4bBTvcPaZOSjwu3WCGUp+jZdfcJUHn4wrVfV2jaNh5tNdBNgEKAmdDil0tb7BKebp0N2HiVJcLlqhZPUDxYMWw95wCaihlrgeT+J8blCb95y+kiiREiGKMRRmyG4HFwErsCI2LNKFq//L0K7oRAOHComEqdGffh9kYKs8MGnyTHJ86+0vnYPFD7d41Gbqa7ZgUPh0A1SyzZZqq6Tf+alPudcRHHTX2TC40OMENY3WKvWGtAcJliuVROGTO9U1Panp2XdzngVpC56KvO4LHjHG8gNhLQ42w+8OgYcqBc2/lXdUpW6WviSoMssc2BrPpAt0UfiMqofxpgOh0Ivf7VUgxoUIG6A0RgbiNjXONvoj+ozX7fEeNOkG8lQhi/A+sYTT+xhtZNvi1rMLgdPm+b4rIi4usUt2kV9HLTRTffEO4Xy+J7pmSsHy4lvngvhrAAidUxkiJQY8aEz2PPS6f1pqXS44vhjGbHZnCCNWKaP8RVrw4hsGIiYp7Eb8Ce5pLfWfz6T/2asaBdjWzzaTQx+1VZm1tTPz0EJCStkz/jbcsQaP8GpvjJT32jkpvWQHv7yLhy1ReSwZnBM+6GyotBV27T3VVkVYzHUSaYmL7rFt55igOONMJ3jaxRtgtQrA4WOaqRNQgrWxHSvSDZAf8tQBD5yWzeM3pVcftSbtwGgQrdg19+qwxiVNq+WrytstgX+tat8nQ17ZXf7l8RnQ==
X-Forefront-Antispam-Report:
	CIP:164.130.1.60;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(36860700016)(376014)(1800799024)(82310400026)(7416014)(10067099003)(11063799006)(6133799003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	p01NXy3fuHiTEt1CGv9O9r23lslMoZOvU3Vos3PmxHkTTXOZdhVK21Ndxhz5owPADjvG1bDfLn1DA3q8Uf1JhjqmNkXYHvF1Ka/qSGBjvkY4WJOaHLrvOYI047f0eT9pngE2bf145zGTmvtGJEsahzpCVPgIY5O+/Oo7sEwedBRIcWhkFCiprb5pDJMgBM5nWoNqQ7i+g0BLHO1/SXhVWwV6CEYF66Ef3l83pmxWjEzbdaSAcJiOxXfEwH/Nk35E9FfLf2Zrvumd0ycJ91CvxxCyxUxhUmh+jSB/7fS//QeT332+2ba4UiT0CmTLnzI2MY2soKbKrVZBvnMaxCPKu43hJcu18QxKOVHU3o9NeCuhx3AwtJjJQ7DS7q74HttVI19G07eSTwPAJxk7BYjdZIPNbgR7OV8HNHP2WXZNR5vDpgkUw/csi7M7NraCaqFg
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 07:58:14.1927
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d5d6598-4722-4b44-1bee-08df237f92ef
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.60];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS1EPF00000094.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR10MB8295

Add a boolean (has_vregen) in adc configuration structure to prevent
setting the reserved bit (CR_ADVREGEN bit 28) on STM32MP2 SoCs.
This bit is present on earlier stm32h7, stm32mp13 and stm32mp15.
No functional change intended.

Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>
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
index 8b7eb70a882d..0a951a3adff9 100644
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

