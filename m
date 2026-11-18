Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.72.23
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795015090;
	b=Mv3qN1uJ/JuWS9YArah3u/JgAtq+gsvyQxPYesslKfDxZC798BiFIPSDUdCGV4ucI4qt
	 yFbQOfmuKRbsLzyRzJWJW8uyHudbRc+h6gi/jT5ZwVpbnBhMDlzTF6EkEQ4Plu7Eh2rZ8
	 /nIWZI+ltCp3HO8Q/YywMzSYI3/pRUrpSNDFS5InQzy+qZq+N9eXcmBlc/QOfm14T6v3x
	 8btjJ/mf+eS2+GaUAu0PBX9guqKQiqyHN7RzFo03qwbcmT2zwNo5eRBoTAGVTWtSHjgfJ
	 Qlo9Q4HpvXUgxsRSA11aivtVNx1hpxEEJUrtSwzs8JThdN/qve/bJ8QWJYHsA9oF+Fg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795015090;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-ID:References:In-Reply-To:To:CC:
	 X-Mailer:X-Originating-IP:X-ClientProxiedBy:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=mkgMm3c5VRdfuHAGVkeGQXA2jbL9LAe8vP6tn2p4n94=;
	b=fkiEu3VZkRD0MXuK/EkW1sUObDg71NnxdCnoXBnaXvfJN3Aswh0We+XXcsRVg/7dqv/9
	 7ngypjiQx/Im68QEd7Iq8F/bawgZtzXtb2ZBFA7WQEYGy6/eZB2D40m5635/1ElzRAl3O
	 LrjUgfEJXFHSZdn42hS24fOhhXJU/bXOQddM6NHZkLUzeIv/ViEpFxuNqUfTdbRCNgc0V
	 P/WMeUb41m6leBnoK8YOpVOC49C3cRCX5GGwsyuaNPH8uOC5Nx0I5gSwt2cAM+TpnzRPM
	 X3OB/WuHxlLAE7gZYP3rHWW6d7+FLqiaGAGJcVijrQw6wDogKaX1ECgIG+Dv4IpZigw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=foss.st.com;
	spf=pass smtp.mailfrom=foss.st.com;
	dkim=pass header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=IXpnsWGm;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.72.23
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013023.outbound.protection.outlook.com [52.101.72.23])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCB31606A331;
	Wed, 18 Nov 2026 15:18:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CCB31606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=IXpnsWGm
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aacZSaiND62g6npUXPd8pzR96UHTUZV7cZyAeR82IyqrQwQIq5qYjx1+xzNqHXdxaAQ87ODL22O2uJFUWl059/vmObTaVEj1McTAJebmyb8ku6WfDxrZUku0DznIBbRnDxhKY8uouCnMbzyF2WaERKR2jYekh42kWdJdr14oeTLAJLsozalITv5Vp9VVrsUcGBm8qSAHPEZZhcmwIVFyEKCdk6umwMFEGXMcTwtjtSDaswuJ+iqB5KMGZnuCXLaoc0yW0/XRqvuTfOorj5dGBsH7tMLUNLofDN4yUSOqm8/UYiwR1snUK78JwKynggxciWGXdy9+8zh45r2HuABsKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mkgMm3c5VRdfuHAGVkeGQXA2jbL9LAe8vP6tn2p4n94=;
 b=uEZg1GN7143WuI7iwoTkAhasIV8ltHtdVO5CZtPNN25HRMBvmv8aBRsJL8e/KVKXAx0Aw6qj24FozdO1a1z07dnBPPkS7RD/HBfRXRpJ4DlWIv5IeL8kNrJHWki4LMdXbFGpAi+mV5AjGNKFdnXUZhJ6idjrq2j5j022WZYYlhxVUUbc+7YWWAoymNCSpvlpckJjWORIfQrd7hGxUkJj1dZs/jHOYJyGjGoU76W9LOHl31kJM+ozXzbqhJ3HTZm+G3i97seC8e+IrRjN7ohinILdNL5O+2z+8V9aURdoDLpOgtLl/0fHXIc6RNtVHK+1HWYA1CdiWXDr04qEj03mmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=amd.com smtp.mailfrom=foss.st.com; dmarc=fail
 (p=none sp=none pct=100) action=none header.from=foss.st.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mkgMm3c5VRdfuHAGVkeGQXA2jbL9LAe8vP6tn2p4n94=;
 b=IXpnsWGmJtuWg6dAzSmCtDEJSbkW8gD9r+b1tQRFC4mHouLvkuV466hkupaCBSjdj/Hs334tRFMUPm15VdgOSAoERSZUao4oWq7zAAuRyUftA0GNA1dmiibqXBAg/wr8CQOZarCp21vyV5L8WSZBDNorpNM89Ods8TjVALVfRBAj87H+g4pJI7m/ykA0xhfC9ezRWZjLGyW2e1w4Lc/Ql3fFVSFBUzTJClXzqK0w5Mf4hO+YE4HwSBu34tcyGHjdQ0Fhggsdruq1+oeBuF2QWTMgGNMl2zxGWE8yAnkqzwIGT6ei+VA5E379NvOUwbnMUlxTWHuisHozFJaAO5RGFg==
Received: from DUZPR01CA0024.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:46b::11) by BR2PR10MB992311.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:2c8:9::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.7; Wed, 18 Nov
 2026 15:18:06 +0000
Received: from MA3PEPF00000408.eurprd04.prod.outlook.com
 (2603:10a6:10:46b:cafe::90) by DUZPR01CA0024.outlook.office365.com
 (2603:10a6:10:46b::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.14 via Frontend Transport; Wed,
 18 Nov 2026 15:18:05 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 164.130.1.60) smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 MA3PEPF00000408.mail.protection.outlook.com (10.167.241.153) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 18 Nov 2026 15:18:05 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Wed, 18 Nov
 2026 16:19:06 +0100
Received: from localhost (10.252.16.78) by STKDAG1NODE2.st.com (10.75.128.133)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Wed, 18 Nov
 2026 16:18:04 +0100
From: Olivier Moysan <olivier.moysan@foss.st.com>
Date: Wed, 18 Nov 2026 16:17:51 +0100
Subject: [PATCH v2 06/11] iio: adc: stm32-mdf: configure cic filters and
 sample rates
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261118-upstream_mdf_v2-v2-6-7939d3c3720a@foss.st.com>
References: <20261118-upstream_mdf_v2-v2-0-7939d3c3720a@foss.st.com>
In-Reply-To: <20261118-upstream_mdf_v2-v2-0-7939d3c3720a@foss.st.com>
To: Jonathan Cameron <jic23@kernel.org>, David Lechner
	<dlechner@baylibre.com>, =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, "Andy
 Shevchenko" <andy@kernel.org>, Rob Herring <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, "Maxime
 Coquelin" <mcoquelin.stm32@gmail.com>, Alexandre Torgue
	<alexandre.torgue@foss.st.com>, Philipp Zabel <p.zabel@pengutronix.de>,
	"Sumit Semwal" <sumit.semwal@linaro.org>, =?utf-8?q?Christian_K=C3=B6nig?=
	<christian.koenig@amd.com>, Philipp Stanner <phasta@kernel.org>, "Arnaud
 Pouliquen" <arnaud.pouliquen@foss.st.com>, Liam Girdwood
	<lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela
	<perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Fabrice Gasnier
	<fabrice.gasnier@foss.st.com>
CC: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-stm32@st-md-mailman.stormreply.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<linux-media@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
	<linaro-mm-sig@lists.linaro.org>, <linux-sound@vger.kernel.org>, "Olivier
 Moysan" <olivier.moysan@foss.st.com>
X-Mailer: b4 0.16.0
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MA3PEPF00000408:EE_|BR2PR10MB992311:EE_
X-MS-Office365-Filtering-Correlation-Id: 3846e3ab-79c6-4b2a-5238-08df4587253c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|82310400026|36860700016|1800799024|376014|7416014|22082099003|18002099003|6133799003|3023799007|921020|11063799006|56012099006|261026140227099003|261022075727099003|261009223027099003|261028144727099003|10067099003|261102123227099003|261021123027099003|261021121427099003|261022105027099003;
X-Microsoft-Antispam-Message-Info:
	dqP/zqrOYrz0UhLwub2N43otWSFRO1qRiBCio1h+VU9uD+fYKVSd9AHSmrTTwkgmPHuMvj2VueFMY2AA9kAlOmya1hRlxWgb/3vRTCOX+3j1VLChOvzfOPURNPAsaBqd5HX/Ul8BuH8gC9LASAMy3vdUPBhybWvUYqXJnshFwa7lXSxfRqtKCpXmwUfnqkAlrQNhll/0Zd3GBCSen9lzyuLW9sCdjhGOYvd4En2yjAdxagx4eC/l4HZiQ9yIgHHshC7W/wU6l4+Srqcx2kmLTw4OiCQeoYBADETKPQiOiZvOjfMBpIqMVwbgcS/diw4fzl0KhcQyigymP9c0Q2jeaqAYdPMMMoQQo5QWp6b0xdolFJ0kJcQAp00PXbiowTKkF0/OEicB9gzTTb2qzXgmHpxXTPa1W5t/urxk9ExNWtSR0USK+II7upFgZUXNWYjNi84drV30pDPCT0iG3SOQ+UOLDbecshFL+JqEzlelhGxIE2sTFocMFY2S48uCWiW5i2ue8UIT8bq1lSNQ1IFkleHPrqio7c15kFM/YOHKqIqSbq79dv3b8bRGhc/LuUrsRUz99390xS1FBDH5JFhnVab1IIZyu5AjiPXyAOfNu/ZzPkTZZeIlvmrOFRDr9Ng9Ny8T64gVeC4hXAM07x18Co6/grpsPBg0RF9Qz8EsN3++oUCs+w0udo9HOseloOVcRa+gq6bFlKKkI6UUxjkf2wqY82tyfplRW9VCjN2xCnHwW39QTe71RKqACkMtCTN4
X-Forefront-Antispam-Report:
	CIP:164.130.1.60;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(82310400026)(36860700016)(1800799024)(376014)(7416014)(22082099003)(18002099003)(6133799003)(3023799007)(921020)(11063799006)(56012099006)(261026140227099003)(261022075727099003)(261009223027099003)(261028144727099003)(10067099003)(261102123227099003)(261021123027099003)(261021121427099003)(261022105027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	uNXgwoUbX2Vk3qYEEpuDUWhVXETV7+eEFiK+WqzTwHNG5j6I0tN58Rfsxro7qP939nIw37eDnLAl/3nnIN3KjWCSp9EzTIj1cWdeTDMsWcmrenV4nLJRuE0nYcYimV3nkj6MltvX3KimCva+34PzZRXzJHE3hsNiW8lfJfRTeOfy3q+gjeAPUFEcotCkXywuc4/MSpHEsBJPktfovPewBIBReJGAYa1p1nluvUZy7yw9PuQ/Wg+bT1e7o5jctfiAxzgRZlB4Fhs3V6AJWLS5EJtn3Ynf3CEqQfUWUBQKwvZ2cZSI7GrcbiXwEHaUSV4vh7RbURNq6sR/ycWOGqUc5ReHP0r2jTmuCjWZ/vjmujZ4wSIQ8aBH59++YehwY5+rVbpekN4x282kmvOiYTg9Pnq3yO/bTuu2Urp+Z1r/cAcLnC/DSMOMrpMCnFiHmo/s
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 15:18:05.6443
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3846e3ab-79c6-4b2a-5238-08df4587253c
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.60];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MA3PEPF00000408.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BR2PR10MB992311

MDF output sample rates depend on the serial clock and the decimation
applied by the CIC and reshape filters. Add the calculations needed to
derive these settings from a requested sampling frequency.

Compute CIC gain and data scaling for the selected filter order and
decimation to maximize output signal dynamic.

Check serial and processing clock constraints, and configure the CCK
rate when needed.

Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
---
 drivers/iio/adc/stm32-mdf-adc.c | 404 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 404 insertions(+)

diff --git a/drivers/iio/adc/stm32-mdf-adc.c b/drivers/iio/adc/stm32-mdf-adc.c
index 411af78911c9..eae7a4fa1485 100644
--- a/drivers/iio/adc/stm32-mdf-adc.c
+++ b/drivers/iio/adc/stm32-mdf-adc.c
@@ -182,6 +182,64 @@ static const unsigned int stm32_mdf_hpf_cutoff_ratio[] = {
  * where N is filter order and D the CIC decimation factor.
  * Following table gives the maximum decimation ratio for filter order [0..5].
  */
+static const unsigned int stm32_mdf_cic_max_decim_sitf[] = {
+512, 512, 512, 322, 76, 32
+};
+
+/* Gain (dB) x 10 according to scale value in hex */
+static const struct stm32_mdf_scales stm32_mdf_scale_table[] = {
+	{0x20, -482, -2558},
+	{0x21, -446, -1706},
+	{0x22, -421, -1280},
+	{0x23, -386, -853},
+	{0x24, -361, -640},
+	{0x25, -326, -427},
+	{0x26, -301, -320},
+	{0x27, -266, -213},
+	{0x28, -241, -160},
+	{0x29, -206, -107},
+	{0x2A, -181, -80},
+	{0x2B, -145, -53},
+	{0x2C, -120, -40},
+	{0x2D, -85,  -27},
+	{0x2E, -60,  -20},
+	{0x2F, -25,  -13},
+	{0x00, 0,    10},
+	{0x01, 35,   15},
+	{0x02, 60,   20},
+	{0x03, 95,   30},
+	{0x04, 120,  40},
+	{0x05, 156,  60},
+	{0x06, 181,  80},
+	{0x07, 216,  120},
+	{0x08, 241,  160},
+	{0x09, 276,  240},
+	{0x0A, 301,  320},
+	{0x0B, 336,  480},
+	{0x0C, 361,  640},
+	{0x0D, 396,  960},
+	{0x0E, 421,  1280},
+	{0x0F, 457,  1920},
+	{0x10, 482,  2560},
+	{0x11, 517,  3840},
+	{0x12, 542,  5120},
+	{0x13, 577,  7680},
+	{0x14, 602,  10240},
+	{0x15, 637,  15360},
+	{0x16, 662,  20480},
+	{0x17, 697,  30720},
+	{0x18, 722,  40960},
+};
+
+/* Prime number 1000 x log10 table */
+static const struct stm32_mdf_log10 stm32_mdf_log_table[] = {
+	{2, 301}, {3, 477}, {5, 699}, {7, 845}, {11, 1041}, {13, 1114}, {17, 1230}, {19, 1279},
+	{23, 1362}, {29, 1462}, {31, 1491}, {37, 1568}, {41, 1613}, {43, 1633}, {47, 1672},
+	{53, 1724}, {59, 1771}, {61, 1785}, {67, 1826}, {71, 1851}, {73, 1863}, {79, 1898},
+	{83, 1919}, {89, 1949}, {97, 1987}, {101, 2004}, {103, 2013}, {107, 2029}, {109, 2037},
+	{113, 2053}, {127, 2104}
+};
+
 static bool stm32_mdf_adc_readable_reg(struct device *dev, unsigned int reg)
 {
 	switch (reg) {
@@ -271,6 +329,352 @@ static struct stm32_mdf_adc *stm32_mdf_get_filter_by_handle(struct stm32_mdf *md
 	return NULL;
 }
 
+static int stm32_mdf_adc_compute_scale(struct device *dev, unsigned int decim,
+				       unsigned int order, unsigned int data_size)
+{
+	unsigned long max = ARRAY_SIZE(stm32_mdf_log_table);
+	unsigned int prime_factors[16];
+	unsigned int num, div, logd = 0;
+	int i, j, scale;
+
+	/* Decompose decimation ratio D, as prime number factors, to compute log10(D) */
+	j = 0;
+	num = decim;
+	while (num > 1) {
+		i = 0;
+		while (i < max) {
+			div = stm32_mdf_log_table[i].raw;
+			if (!(num % div)) {
+				prime_factors[j] = stm32_mdf_log_table[i].log;
+				num = num / div;
+				j++;
+				break;
+			}
+			i++;
+		}
+		if (i == max) {
+			dev_warn(dev, "Failed to set scale. Output signal may saturate.\n");
+			return 0;
+		}
+	}
+
+	for (i = 0; i < j; i++)
+		logd += prime_factors[i];
+
+	/* scale = 20 * ((DS - 1) * log10(2) - NF * log10(D)) */
+	scale = 20 * ((data_size - 1) * stm32_mdf_log_table[0].log - order * logd);
+
+	return scale;
+}
+
+static int stm32_mdf_adc_apply_filters_config(struct stm32_mdf_adc *adc, unsigned int scale)
+{
+	struct stm32_mdf_adc *adc_inter;
+	u32 msk, val;
+	int ret, cnt = 0;
+
+	/* Apply conf from filter0 to interleaved filters if any */
+	if (MDF_IS_FILTER0(adc) && adc->mdf->nb_interleave) {
+		list_for_each_entry(adc_inter, &adc->mdf->filter_list, entry) {
+			if (MDF_IS_INTERLEAVED_FILT_NOT_0(adc_inter)) {
+				adc_inter->datsrc = adc->datsrc;
+				adc_inter->cicmode = adc->cicmode;
+				adc_inter->decim_cic = adc->decim_cic;
+				adc_inter->nbdis = adc->nbdis;
+				adc_inter->hpf_cutoff = adc->hpf_cutoff;
+
+				stm32_mdf_adc_apply_filters_config(adc_inter, scale);
+				cnt++;
+			}
+		}
+		if (cnt != adc->mdf->nb_interleave - 1) {
+			dev_err(adc->dev, "Interleaved filter number [%d] / expected [%d]\n",
+				cnt, adc->mdf->nb_interleave - 1);
+			return -EINVAL;
+		}
+	}
+
+	/* Configure delay */
+	ret = regmap_update_bits(adc->regmap, MDF_DLYCR_REG, MDF_DLYCR_SKPDLY_MASK, adc->delay);
+	if (ret)
+		return ret;
+
+	/* Configure NBDIS */
+	if (adc->nbdis) {
+		ret = regmap_update_bits(adc->regmap, MDF_DFLTCR_REG, MDF_DFLTCR_NBDIS_MASK,
+					 FIELD_PREP(MDF_DFLTCR_NBDIS_MASK, adc->nbdis));
+		if (ret)
+			return ret;
+	}
+
+	/* Configure CICR */
+	msk = MDF_SITFCR_SCKSRC_MASK | MDF_DFLTCICR_CICMOD_MASK |
+	      MDF_DFLTCICR_MCICD_MASK | MDF_DFLTCICR_SCALE_MASK;
+	val = FIELD_PREP(MDF_SITFCR_SCKSRC_MASK, adc->datsrc) |
+	      FIELD_PREP(MDF_DFLTCICR_CICMOD_MASK, adc->cicmode) |
+	      FIELD_PREP(MDF_DFLTCICR_MCICD_MASK, adc->decim_cic - 1) |
+	      FIELD_PREP(MDF_DFLTCICR_SCALE_MASK, scale);
+
+	ret = regmap_update_bits(adc->regmap, MDF_DFLTCICR_REG, msk, val);
+	if (ret)
+		return ret;
+
+	/* Configure RSFR & HPF */
+	if (adc->hpf_cutoff == STM32_MDF_HPF_BYPASS)
+		val = MDF_DFLTRSFR_HPFBYP;
+	else
+		val = FIELD_PREP(MDF_DFLTRSFR_HPFC_MASK, adc->hpf_cutoff);
+	val |= adc->rsflt_bypass ? MDF_DFLTRSFR_RSFLTBYP : 0;
+	msk = MDF_DFLTRSFR_RSFLTBYP | MDF_DFLTRSFR_HPFBYP | MDF_DFLTRSFR_HPFC_MASK;
+
+	return regmap_update_bits(adc->regmap, MDF_DFLTRSFR_REG, msk, val);
+}
+
+static int stm32_mdf_adc_set_filters_config(struct iio_dev *indio_dev, unsigned int decim)
+{
+	struct stm32_mdf_adc *adc = iio_priv(indio_dev);
+	struct device *dev = &indio_dev->dev;
+	unsigned int decim_cic, decim_rsflt = 1;
+	unsigned int data_size = STM32_MDF_DATA_RES, order = adc->cicmode;
+	u64 max;
+	int i, d, log, scale, max_scale, gain_lin;
+
+	if (!adc->rsflt_bypass) {
+		decim_rsflt = 4;
+		data_size -= 2;
+
+		/* Check if total decimation factor is a multiple of reshape filter decimation */
+		if (decim % decim_rsflt) {
+			dev_err(dev, "Total decimation factor [%d] not multiple of [%d]\n",
+				decim, decim_rsflt);
+			return -EINVAL;
+		}
+	}
+
+	decim_cic = DIV_ROUND_CLOSEST(decim, decim_rsflt);
+	if (decim_cic < MDF_DFLTCICR_MCICD_MIN ||
+	    decim_cic > stm32_mdf_cic_max_decim_sitf[order]) {
+		dev_err(dev, "Decimation factor [%d] out of range for CIC filter order [%d]\n",
+			decim_cic, adc->cicmode);
+		return -EINVAL;
+	}
+
+	/*
+	 * Compute scaling:
+	 * max scale = 20 * log10( 2 exp DS / D exp NF )
+	 * - DS = max data size at scale output (RSFLT on: DS = 22 / RSFLT off: DS = 24)
+	 * - NF = Main CIC filter order
+	 */
+	if (is_power_of_2(decim_cic)) {
+		/*
+		 * Decimation ratio is a power of 2: D = 2 exp n
+		 * max scale = 20 * (DS - n * NF) * log10(2)
+		 */
+		log = stm32_mdf_log_table[0].log;
+
+		/* Compute max scale (dB) * 1000 */
+		max_scale = (20 * (data_size - 1 - (order * (fls(decim_cic) - 1))) * log);
+	} else {
+		/*
+		 * Decimation ratio is not a power of 2
+		 * max scale = 20 * ((DS - 1) * log10(2) - NF * log10(D))
+		 */
+		max_scale = stm32_mdf_adc_compute_scale(dev, decim_cic, order, data_size);
+	}
+
+	dev_dbg(dev, "Filter order [%d], decimation [%d], data size [%d], max scale [%d]\n",
+		order, decim_cic, data_size, max_scale / 1000);
+
+	/*
+	 * Find scale register setting.
+	 * Limit max_scale accuracy to first decimal for comparison with scale table values.
+	 */
+	max_scale = DIV_ROUND_CLOSEST(max_scale, 100);
+	i = ARRAY_SIZE(stm32_mdf_scale_table) - 1;
+	while (i > 0) {
+		if (stm32_mdf_scale_table[i].gain_db < max_scale)
+			break;
+		i--;
+	};
+	scale = stm32_mdf_scale_table[i].scale;
+	gain_lin = stm32_mdf_scale_table[i].gain_lin;
+
+	dev_dbg(dev, "Set scale to [%d]dB: [0x%x]\n", stm32_mdf_scale_table[i].gain_db / 10, scale);
+
+	adc->decim_cic = decim_cic;
+
+	/*
+	 * Calculate maximum DFLT output filter
+	 * max = K * G
+	 * - Fastsinc (order 0):	G = 2 * d^2 * gain_lin
+	 * - Sinc order 1 to 5:		G = d^N * gain_lin
+	 * - RSFLT off:			K = 1, d = decim
+	 * - RSFLT on:			K = 2.98, d = decim_cic
+	 * N = CIC filter order, decim = total decimation ratio, decim_cic = CIC decimation ratio
+	 * gain_lin is multiplied by a 10 factor in stm32_mdf_scale_table, and K with a 100 factor.
+	 */
+	if (adc->rsflt_bypass) {
+		d = decim;
+		max = 100;
+	} else {
+		d = decim_cic;
+		max = 298;
+	}
+
+	if (order) {
+		i = 0;
+		while (i < order) {
+			max *= d;
+			i++;
+		}
+	} else {
+		max *= 2 * d * d;
+	}
+
+	if (gain_lin > 0) {
+		max *= gain_lin;
+		max = DIV_ROUND_CLOSEST_ULL(max, 1000);
+	}
+	if (gain_lin < 0) {
+		max = DIV_ROUND_CLOSEST_ULL(max, -gain_lin);
+		max = DIV_ROUND_CLOSEST_ULL(max,  10);
+	}
+
+	adc->dflt_max = max;
+
+	dev_dbg(dev, "DFLT maximum output [%d]\n", adc->dflt_max);
+
+	return stm32_mdf_adc_apply_filters_config(adc, scale);
+}
+
+static int stm32_mdf_adc_check_clock_config(struct stm32_mdf_adc *adc, unsigned long *sck_freq)
+{
+	unsigned long cck_expected_freq;
+	unsigned int ratio, cic_ratio;
+	int ret, error = 0;
+
+	/*
+	 * The CCK rate is requested by its consumer through the clock framework.
+	 * The serial interface clock sck (aka cck) is derived from MDF kernel clock frequency.
+	 * The kernel clock rate may have been changed by another consumer, or MDF dividers
+	 * may have been updated through clk_get_rate() call.
+	 * Ensure that kernel clock rate and MDF dividers, still provide the right sck/cck rate
+	 */
+	cck_expected_freq = stm32_mdf_core_get_cck(adc->mdf);
+	if (*sck_freq != cck_expected_freq) {
+		dev_dbg(adc->dev, "Wrong sck_freq [%lu]Hz. Expected [%lu]Hz.\n",
+			*sck_freq, cck_expected_freq);
+		error |= STM32_MDF_ERR_SCK_FREQ;
+	}
+
+	/*
+	 * Mode SPI:    check Fproc >= 4 * Fsck
+	 * Mode LF SPI: check Fproc >= 2 * Fsck
+	 */
+	ratio = DIV_ROUND_CLOSEST(adc->mdf->fproc, *sck_freq);
+	if ((adc->sitf->mode == STM32_MDF_MODE_SPI && ratio <= 4) ||
+	    (adc->sitf->mode == STM32_MDF_MODE_LF_SPI && ratio <= 2)) {
+		dev_dbg(adc->dev, "Wrong Fproc/Fsck ratio [%d]. sitf mode [%d], RSFLT [%s]\n",
+			ratio, adc->sitf->mode, adc->rsflt_bypass ? "off" : "on");
+		error |= STM32_MDF_ERR_MODE_RATIO;
+	}
+
+	/* RSFLT enabled: check Fproc > 24 * Fsck / (MCICD+1) */
+	cic_ratio = DIV_ROUND_CLOSEST(24, adc->decim_cic);
+	if (!adc->rsflt_bypass && ratio <= cic_ratio)
+		error |= STM32_MDF_ERR_DECIM_RATIO;
+
+	/* If we found an error, try to restore clocks initial settings */
+	if (error) {
+		ret = stm32_mdf_core_restore_cck(adc->mdf);
+		if (ret < 0)
+			goto err;
+
+		*sck_freq = clk_get_rate(adc->sitf->sck);
+		if (!*sck_freq) {
+			ret = -EINVAL;
+			goto err;
+		}
+	}
+
+	return 0;
+
+err:
+	dev_err(adc->dev, "Wrong clock configuration [0x%x]. Clock recovering returned [%d]\n",
+		error, ret);
+
+	return ret;
+}
+
+static int __maybe_unused mdf_adc_set_samp_freq(struct iio_dev *indio_dev)
+{
+	struct stm32_mdf_adc *adc = iio_priv(indio_dev);
+	struct device *dev = &indio_dev->dev;
+	unsigned int decim_ratio;
+	unsigned long delta, delta_ppm, sck_freq, sample_freq = adc->requested_sample_freq;
+	u64 nbdis;
+	int ret;
+
+	sck_freq = clk_get_rate(adc->sitf->sck);
+	if (!sck_freq) {
+		dev_err(dev, "Unexpected serial clock frequency: 0Hz\n");
+		ret = -EINVAL;
+		goto err;
+	}
+
+	/*
+	 * In analog use cases, the sampling frequency may not be already set in IIO sysfs.
+	 * (In audio use cases, the sampling frequency is always provided on stream startup)
+	 * If requested sampling frequency is 0, set a default frequency.
+	 * The default frequency is computed from the default decimation ratio.
+	 * This ensures that a filter configuration can be found whatever the selected filter
+	 * order. (Most constrained case is order 5)
+	 */
+	if (!sample_freq)
+		sample_freq = sck_freq / MDF_DEFAULT_DECIM_RATIO;
+
+	ret = stm32_mdf_adc_check_clock_config(adc, &sck_freq);
+	if (ret)
+		goto err;
+
+	decim_ratio = DIV_ROUND_CLOSEST(sck_freq, sample_freq);
+
+	delta = abs(sck_freq - (decim_ratio * sample_freq));
+	delta_ppm = (1000000 * delta) / sck_freq;
+	if (delta_ppm > 1000)
+		dev_warn(dev, "Sample rate deviation [%lu] ppm: [%lu] vs [%lu] Hz\n",
+			 delta_ppm, sck_freq / decim_ratio, sample_freq);
+	else if (delta)
+		dev_dbg(dev, "Sample rate deviation [%lu] ppm: [%lu] vs [%lu] Hz\n",
+			delta_ppm, sck_freq / decim_ratio, sample_freq);
+
+	/*
+	 * Convert settling time into a minimum number of output sample to discard before releasing
+	 * the data. This allows to drop the samples affected by the impulse response of the
+	 * filter and wait for stable data.
+	 */
+	nbdis = DIV_ROUND_UP_ULL((u64)adc->stu * sample_freq, 1000000);
+	if (nbdis > MDF_DFLTCR_NBDIS_MAX) {
+		dev_warn(dev, "NBDIS [%llu] too large. Force to [%lu]\n",
+			 nbdis, MDF_DFLTCR_NBDIS_MAX);
+		adc->nbdis = MDF_DFLTCR_NBDIS_MAX;
+	} else {
+		adc->nbdis = nbdis;
+		dev_dbg(dev, "Settling time [%u] us. NBDIS set to [%u] samples\n",
+			adc->stu, adc->nbdis);
+	}
+
+	ret = stm32_mdf_adc_set_filters_config(indio_dev, decim_ratio);
+	if (ret < 0)
+		goto err;
+
+	adc->sample_freq = DIV_ROUND_CLOSEST(sck_freq, decim_ratio);
+	adc->decim_ratio = decim_ratio;
+
+err:
+	return ret;
+}
+
 static int stm32_mdf_get_sitf(struct device *dev, struct stm32_mdf_adc *adc,
 			      struct fwnode_handle *sitf_node)
 {

-- 
2.43.0

