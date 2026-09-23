Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013017.outbound.protection.outlook.com [52.101.83.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2E43531625;
	Wed, 23 Sep 2026 15:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790177981; cv=fail; b=m4mfIouxlNrp68hm51HLFmWNYgh9+e4+OTURHQ9F8KGdQTib/ccEkJgoIE0McevrnVYTvCr8SBn3B0C5RoIdw/upi0oDX8MpsGp3ykxnsYEeSHCZ9Zn7eEeaSF/0inkHYfplWYiSha04/5tdF33q+Jt2VUK4Y5Uv8yZ64U3vCqE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790177981; c=relaxed/simple;
	bh=S/QWl2VHjb1ScMjefBY/B+bUvDSpg+awFBwR9pH4A3o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=Xjty27+9C1dOFoJ+QRCI1NLNhTBMpguGqhpEm5qdAEysi0oZ+zSAZC0hduwFO70A+XMcoJ+WPrDBoCY2tvbvUW3q7G0C/Q8pDivdG1YwgNDxoqiBZOi7QCz5+H+R7FdP96qKqRzQPcYQcbzLo3gR1TwqFt8tUHbnxarobZ+g9/4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=NOsCBBtU; arc=fail smtp.client-ip=52.101.83.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="NOsCBBtU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jnAq0JS0dB2Wn5CoetocmucOLNWEdOiXMVZG1AFzzQyYU/vFGAqP9PrfUDy6rJva63ApzJa6ZzaIwKcKiOhtxEwcFY6VslbXVaVgIiDXiuY/scJrg6kXZticJ7UzIyW759xAPpfvPt0NabJ1W5QHm1Kyf9zikLJLiF83jZ8WE9wvXIIZbAgGWLnka0ZOhKdj6Do/85xWlmV6UWPLIdkvjwuw3+35SW6omSzAD00x012hxPjAWSeJp8iUYqUx4MgvOZgD7ToPhNsfKWuSEjZiJGQW1R3NREXwxruZkSLX8JRPYEmLq2BkNwo5rXAkJUdLwZw0qz9Ld9nmzq+3IzJa1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uuYWi3Zj+SVMvmLSjcEdSEWURcRr/IdudWp56ds2h6U=;
 b=br89kanxpSBYFrtZxF2XRtCKTAAAIpFwj1VwoiivJSzAIqMfoDnfx8b/l+BBjzseEC1ZIXDNtKfj6OmecgfRBuG4ALKivLkL4UgRWxun97yhTZE806kUpZvxJ9//E9rtrqGfhYIomnMQVdLYqWyZEf3XqKOwqvMo7ro7txYMWP2Ezrl7oztQsCHEv7H44IEDjJjrQvTZr9Vmf7lTSMGM83K0NMsy68y87kz1B/+TiPkIsO0I0CTMWepcWpRVVaqU7DPlcW6XMHU3Ad36vu1YNWx7KQF/fSIBYG8evgHuJFTUnVpVoighqiCveej6sHH8CsCAHwajSMYhZZtg7IgHsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=st-md-mailman.stormreply.com
 smtp.mailfrom=foss.st.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=foss.st.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uuYWi3Zj+SVMvmLSjcEdSEWURcRr/IdudWp56ds2h6U=;
 b=NOsCBBtUP3pX+Z00GzKfnGP9M2uPQOaG68QfFy+fQ3QMk2YWMPHBASgWJ9Vzoacubmq4zg4D1CIwyqmSOK38tJ5ukYMPSlUi1ZOX/jp/ChXfawdgQ+a2F4saPqy1gaz4SxyLkO3Qw86ao/QxPEzwC3uG6P6wL+AuMf7Be2jd+PZRZDUzSTrxbVf7FhH8udl8MtcdTzMA2pWVrda72PLefltHaE1KxPzDkKKZ0awGmB5e60A0pNHFRWsGZ/zvMvn2wSgwifjdtKBKBFyfesPoukn3nOT+5cV9T/HV6sdRi03tQyH9saiHb5AnkAAbo21dhuDnraxww0Xxxk4PzebuJg==
Received: from PA7P264CA0198.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:36d::14)
 by DB9PR10MB8246.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:4c9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Wed, 23 Sep
 2026 15:39:32 +0000
Received: from MAD0EPF000008B1.eurprd04.prod.outlook.com
 (2603:10a6:102:36d:cafe::46) by PA7P264CA0198.outlook.office365.com
 (2603:10a6:102:36d::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.16 via Frontend Transport; Wed,
 23 Sep 2026 15:39:32 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 MAD0EPF000008B1.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Wed, 23 Sep 2026 15:39:32 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Wed, 23 Sep
 2026 17:46:00 +0200
Received: from localhost (10.252.7.7) by STKDAG1NODE2.st.com (10.75.128.133)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Wed, 23 Sep
 2026 17:39:31 +0200
From: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Date: Wed, 23 Sep 2026 17:39:09 +0200
Subject: [PATCH v2 06/14] iio: adc: stm32-adc: add vreg enable option to
 manage diversity
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260923-adc-stm32mp25-v1-v2-6-46bc019537c6@foss.st.com>
References: <20260923-adc-stm32mp25-v1-v2-0-46bc019537c6@foss.st.com>
In-Reply-To: <20260923-adc-stm32mp25-v1-v2-0-46bc019537c6@foss.st.com>
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
X-MS-TrafficTypeDiagnostic: MAD0EPF000008B1:EE_|DB9PR10MB8246:EE_
X-MS-Office365-Filtering-Correlation-Id: 68c81c9d-eb0f-4323-57c0-08df1988dcdb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700016|376014|7416014|23010399003|6133799003|18002099003|22082099003|11063799006|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	uOHPcIi5QW8ZcTNgziSb83f+FMjBfUkifyS8ZkvAjsg0v/xyUFoNYNag6S0o3S2EOxb2z5b7QPD2qloJWxV9RXEsCDd/8tPf9ELvft42KDsT8G47ta+4jhMxoZYwMFkJxY4hXhCUwdAHqEJc4/cq3QpIz97TMfQB/3c4GeW/+jRtQVB5tTgL8zpb4K3dc+tVyAv0p4lj1ajyGNjo9sgwSkAxm0JEe8KATPd649cY8gutCkaAf29HzqHEGPucKqdWqS/i+714TD6tOdCJEM+dRxdmz8NP/fX8L8TRCr//vNIROZg1nNE8ETMHzMbFLX0842F2KaMzJWb/BNI9ZgGh24U5ylVDBJP4jew3Dw2ahSCOxb46O4URszwv1mgOW/r0TEpLr5BZOILm0il1zy/EbFPFJcLztNJzE0ewnnOVHHgrw7Hu9S5Fz/YUCpRSTOVMuLa3hYJfFS5jQ48L5r1gD9Mq/WkpACsEgedLpXw5xivA6TXz4b39zcUYiktlnICjQ2sxgvMhlDhKufvKchGvSNfh92tY+8a+u5gDOvnpIannCmmmuoYfcI0qfHIVQDDhH/Hmlr1Vrza0G82cSPdgZUmIdl9szQGk5YMHT2utQqA13ORI+ydjL/u0+c5Vh/jPZVV/UofYnSlpA/UgE5Jc2ZsRcIUOJozdmdHRfoyBd7pRvqm+S269vPDcKXLbq4/FoNBtkaM9VTB3qe//0e7hMg==
X-Forefront-Antispam-Report:
	CIP:164.130.1.59;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(7416014)(23010399003)(6133799003)(18002099003)(22082099003)(11063799006)(10067099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	VisltEBIpZYSMZIgMYZm6jTSYn6AeI6RiQDGe6WWVDDL3U+L27XlMYxiZ0sqvUFbpA2MVA94DFFhISa5aOe9o0SGdd7ebsQjww8hf7I6dt0kb7VYN3U69GGh/f5aKhriW6ZnHtMzGSF5LvuFB2TbTW8dHZYzWg0s3dXF9aEQ3gxE0eUOD36EugggT31i0Ny5ftW/lJK3Ursb0c9kfG0GqyIxn/lsxOUhbDo9m2cgTGOzbHqEQCwj3vCflxmeWMnyulrlCPFAMU1/q/G2y9jkSQqrKg8PEPdKZjj1XNZCFyAEE9MHcjsyzTgwj5mjpkcKI/zMfGl+VPrlxBo9CFrVF57uF/HymOrqAglLfPFkTFN8QCwTvr0gNBCAuoXeJ+2aqQNP3b48ZC9RnPWNgnTS6rTiEooCh4vd82Hh4qgTwF+AuC9eyyUrgc98EmmIPDId
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 15:39:32.0239
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 68c81c9d-eb0f-4323-57c0-08df1988dcdb
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.59];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MAD0EPF000008B1.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB8246

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
index ac60c31de7a5..eecdc4cce1b4 100644
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
@@ -2719,6 +2722,7 @@ static const struct stm32_adc_cfg stm32h7_adc_cfg = {
 	.has_linearcal = true,
 	.has_presel = true,
 	.has_oversampling = true,
+	.has_vregen = true,
 	.start_conv = stm32h7_adc_start_conv,
 	.stop_conv = stm32h7_adc_stop_conv,
 	.prepare = stm32h7_adc_prepare,
@@ -2745,6 +2749,7 @@ static const struct stm32_adc_cfg stm32mp1_adc_cfg = {
 	.has_linearcal = true,
 	.has_presel = true,
 	.has_oversampling = true,
+	.has_vregen = true,
 	.start_conv = stm32h7_adc_start_conv,
 	.stop_conv = stm32h7_adc_stop_conv,
 	.prepare = stm32h7_adc_prepare,
@@ -2769,6 +2774,7 @@ static const struct stm32_adc_cfg stm32mp13_adc_cfg = {
 	.adc_info = &stm32mp13_adc_info,
 	.trigs = stm32h7_adc_trigs,
 	.has_oversampling = true,
+	.has_vregen = true,
 	.start_conv = stm32mp13_adc_start_conv,
 	.stop_conv = stm32h7_adc_stop_conv,
 	.prepare = stm32h7_adc_prepare,

-- 
2.43.0

