Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.72.31
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795015093;
	b=z51BBAb6jxf7JSDvmWoRiXYh/2C1/9+NzWCzplR4nT091ZzHIwAr4kWfROTu+m9jP0qO
	 yKIqlcUFJIFG5oWTe62IW/6Q1NOs1LC1ftKjJXcB7p4uJMF8bGtRaaSlW0WUXLiCn3W+v
	 h3xQe60Z6aPnF0+2vA3oHfeQ0cau/INc4MA2jkM6TLBdMMO8VO8OFvdoDnTewCth0jjAa
	 YQjczIMqeZbMUgH8GEsbVaHn7/q092fWyV4uHRiSPe5TgNIlSWAgPkrY0BShgdHkpHqCo
	 ow9vOUUzNtHXQWEnSyMMpdLPRYngLOunkJD+wtV0qV4xxdvgqagDNs/aBtIfTTzDE0w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795015093;
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
	bh=ue38d4wJQjL0sQHjAnJQYpbkHCQXhKI5nEkJUrB4zwA=;
	b=aaNgnBhiFw71ne371ZxYsiKmshhYd/1sskL7t0IdfSZ5eieCxbbx6+pe4ULlFU9KlnTz
	 WNbC38d4omCHK0Ittn9lpY1ZxptIFC8563fgXIScX2pyYz8aKHzc379gdSY48W9KX2g/n
	 UHJDb5K6DyuLJiJpEfRaePDHCJVvnIWvCpAvpEw7iRQmqLXj3ewEYwCs4PTY2YmRzCuua
	 4uW8Vl9K/rxFBtEXiVoCzqyomRWiDx6/CjYj5C5jgP/hOOh2sWjYrpchoJon5VjnPCQvt
	 EWMkA4UPlo5h4OBJl79YEDCh+vcpfck1gD+676NjSOS3ug7W5/yPvHTbFIz7bE9Eh6w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=foss.st.com;
	spf=pass smtp.mailfrom=foss.st.com;
	dkim=pass header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=E6TvIfBF;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.72.31
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013031.outbound.protection.outlook.com [52.101.72.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A56660A2618;
	Wed, 18 Nov 2026 15:18:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4A56660A2618
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=E6TvIfBF
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eBrmqPP7bTD+aQRZiBCmO2kiAO+Np2XuTiL65wf/YtntU4PbVJnWqJVGfMPRGkTOjNgWT/cQaa9AaEX0CuAXfN6+npeGd17fRAa4nAYR9KojSiOJxQ+0Rz2f6GFDDydHkX0z1X4+SLYeH2bWJPogMXWF+jkkdl20eefJcBlwZM/R2ZtbaVaQuflCuqEtnTe5RWJPL3BABJGXeKgcoheBM8voE80EBrD1bxz2DqD6sfHX7AT+qCROCf97zNdlbXOBU1ubcpfu2hOdyxSWQzJjH+Y8vBDbLKm1NhehnQHNOoLUpOzBTFDdMYjoZGUe+IMBA7M3OMJxj3p80rbajQC6kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ue38d4wJQjL0sQHjAnJQYpbkHCQXhKI5nEkJUrB4zwA=;
 b=UvJLUcStbd/EQ1M39gbfXbdoOrMd8jQfADH3ZWoYrpmyiT2FyJMXSQlypwZ14Pj86jUDxToW58MDOOOP7KknkYWzoypW762W7qWAFdn1r0Hp0wHgHkFXpfNT+W8URr784lpzaWb2FV3ANjXemzxcvLXS3D42UpZorXm++NmOe5Wc4XyJICN3+Kis6DY2tYcyIo/JK04u/cBMoUbD5f3Mj/vdvxDOrtM2RKHOUlzLpQlBHRAOeBxSf8dutPI+ybB27YZvYKB6grezo2v9Fu4xbhghaBPzRuV5WKO0usvGdVqYMcz5vhL/GlxZd96oWeD6ktd4eTG5c0+ymKpolYL0Tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=amd.com smtp.mailfrom=foss.st.com; dmarc=fail
 (p=none sp=none pct=100) action=none header.from=foss.st.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ue38d4wJQjL0sQHjAnJQYpbkHCQXhKI5nEkJUrB4zwA=;
 b=E6TvIfBFRn44uoREAW270bIZTdEzlgzZlYrTGOPJKkPYBpfcMgsLZW1ICR5yEAQDQ/J6o7nC8qfm9t6W52RwGi/izoD3317NrJuKoIdiKG8OnY/0SBjaNiVyJuTIzC5xPq5RfyVcWb8pqwMBdn+610M22uur5jHjBHZG+3L6nvE6ozAIAuep5GkcYkypEmwJE08Q2EJyM3Gl3wGtWWmdE8FenG9yoLdZkOc6+/uAzBGaitON+HDhd8bZIorWc80Gs3yL4MCSbinOPYdpKQizQaBz2XxMPNXlUeNrgEyH7q3jkb8JwMOTm3PH6CAMxHiQimXZsAJbUwtCahFFdsawMw==
Received: from DUZPR01CA0022.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:46b::12) by PAWPR10MB7174.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:2ed::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.6; Wed, 18 Nov
 2026 15:18:05 +0000
Received: from MA3PEPF00000408.eurprd04.prod.outlook.com
 (2603:10a6:10:46b:cafe::9c) by DUZPR01CA0022.outlook.office365.com
 (2603:10a6:10:46b::12) with Microsoft SMTP Server (version=TLS1_3,
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
 15.21.615.4 via Frontend Transport; Wed, 18 Nov 2026 15:18:04 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Wed, 18 Nov
 2026 16:19:04 +0100
Received: from localhost (10.252.16.78) by STKDAG1NODE2.st.com (10.75.128.133)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Wed, 18 Nov
 2026 16:18:02 +0100
From: Olivier Moysan <olivier.moysan@foss.st.com>
Date: Wed, 18 Nov 2026 16:17:49 +0100
Subject: [PATCH v2 04/11] iio: adc: stm32-mdf: add serial interfaces
 support
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
Message-ID: <20261118-upstream_mdf_v2-v2-4-7939d3c3720a@foss.st.com>
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
X-MS-TrafficTypeDiagnostic: MA3PEPF00000408:EE_|PAWPR10MB7174:EE_
X-MS-Office365-Filtering-Correlation-Id: ea831d3b-62bd-4836-94e8-08df458724bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|23010399003|82310400026|36860700016|921020|261022075727099003|11063799006|261026140227099003|56012099006|261026121527099003|261028144727099003|261022105027099003|261021123027099003|261021135927099003|261021121427099003|10067099003|261102130727099003|261102123227099003|261009221227099003|261009223027099003|18002099003|22082099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	HYDRnk5sdU2RlGnS3Se0Yf+k3LzAkIMoCGOOACj139dVUZinMo6XOxatWamQtxd0gNxMNUYBPKNGerheUs4DH4YCa4A6zColcCpFygKgFdObB6HIuPrSn+JJAnSg634Mjtlnc8rN93CuPttwUJWixQTtwe0gt2f7GrSESW8vXOjmhthTYn8zl38Ctf4IZA5DmuPi+mBv8UPOOI7lxvFmjBbU7NPCkSWqSAl6X6khiC5erM7gZmthSV1o+5kvO6/7wDbn2gAVXIg95avIQE9wProngTE0g8RMsYSLugAcRtz56L6fWwJLMEjAcPZ/+SFnCHyx7Mg+hlW35B+xyVvcXDnBGXlk3QQhRrurHUXis3P6i1mxCWTbfWCpSkubs+zRJWFKqUy1lj/54+kq3Y1bLfd+0j8M1loyWgQxYvGtDw71TIC/fRtjFiZc9f+9TcUYur0gSalZ2o3nxwbA/6I/hi4mcE27hHx/Sb0twlLzmNOE7e+WZjuTrtWZN299fYrC1HF+paRaJJN+qTD2ZZxLNNqScNYjTLNwupu7irxhOuO6xVwpTmco83IfNKnRd+ySSt0xW2YR8J1Nk52Ht47jtq6HZbBFNxn/cf3FnNH7u+cqsRMSJrz/R4liX9Fyw0BE+ZNwPPZ81Rogt2dW7dIrk7+/5ryVNJqzLV6sZEoWCQn+VYOO/HorwGwX6yG4bl9K2k4/PG5FwT2BExSB5qYq3nv3srWGPuHKAbQKRG+1zgr2T96R6W9xh3glR0WHuHOG
X-Forefront-Antispam-Report:
	CIP:164.130.1.60;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(23010399003)(82310400026)(36860700016)(921020)(261022075727099003)(11063799006)(261026140227099003)(56012099006)(261026121527099003)(261028144727099003)(261022105027099003)(261021123027099003)(261021135927099003)(261021121427099003)(10067099003)(261102130727099003)(261102123227099003)(261009221227099003)(261009223027099003)(18002099003)(22082099003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	arerOmY2sq6kH4ftCMK1HSd5QUnzI8+4E0+jAl6CY4hDK/qh2xbAZnlA6wQHd3VXe/2rtcyMlIpR9csTQ6ZSsua5QEr0N0SeQZ2z/J4UtDNeqKlf6NV65vklaB3M976rOl5WgA2IhkRCaJn+g6cDed66oJ2JUqIuWC+48WCawIOcv5ecIt2SHL9s+pLDoKntRy/vSDKJ+G/P6lRCmF6VqX6a5fQj/ZFn0L4u8AYbwEyvMuGdl30cGsi4zi+U+Us9iTc6nMkyqRM/+BZda+icBD3bAFaDLA4DqENp8WAmNcr4lb+rPqwPy2+T1Fl1LA0gk8ceu8iz+Xkb9ucfqafScHNNto7Db7Q1OT/R9Lr1eXn7HtJNVVe1/EqETUck/j870LmspcqWKpbXx0j+C7H4kUyDq4a+T+KMuXNjppzSArMGBzVv0j09MJgrNzUwyY6K
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 15:18:04.7967
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ea831d3b-62bd-4836-94e8-08df458724bb
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.60];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MA3PEPF00000408.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB7174

The MDF serial interfaces receive the bitstreams from external sigma delta
modulators supporting SPI and Manchester protocols.

Select an external serial clock or an MDF CCK output, validate the clock
requirements of each mode and program the serial interface.
Expose reference-counted start and stop helpers so that multiple filters
can share an interface.

Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
---
 drivers/iio/adc/Makefile           |   2 +-
 drivers/iio/adc/stm32-mdf-core.c   |  34 +++++-
 drivers/iio/adc/stm32-mdf-serial.c | 223 +++++++++++++++++++++++++++++++++++++
 drivers/iio/adc/stm32-mdf.h        |  49 ++++++++
 4 files changed, 306 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
index d5fc809c33ca..811ef85a88fb 100644
--- a/drivers/iio/adc/Makefile
+++ b/drivers/iio/adc/Makefile
@@ -147,7 +147,7 @@ obj-$(CONFIG_STM32_ADC) += stm32-adc.o
 obj-$(CONFIG_STM32_DFSDM_ADC) += stm32-dfsdm-adc.o
 obj-$(CONFIG_STM32_DFSDM_CORE) += stm32-dfsdm-core.o
 obj-$(CONFIG_STM32_MDF_CORE) += stm32-mdf.o
-stm32-mdf-y := stm32-mdf-core.o
+stm32-mdf-y := stm32-mdf-core.o stm32-mdf-serial.o
 obj-$(CONFIG_STMPE_ADC) += stmpe-adc.o
 obj-$(CONFIG_SUN20I_GPADC) += sun20i-gpadc-iio.o
 obj-$(CONFIG_SUN4I_GPADC) += sun4i-gpadc-iio.o
diff --git a/drivers/iio/adc/stm32-mdf-core.c b/drivers/iio/adc/stm32-mdf-core.c
index 4e462c6c42bc..5b5d2d4cbb5c 100644
--- a/drivers/iio/adc/stm32-mdf-core.c
+++ b/drivers/iio/adc/stm32-mdf-core.c
@@ -748,8 +748,13 @@ static int stm32_mdf_core_probe(struct platform_device *pdev)
 	if (ret < 0)
 		return ret;
 
+	INIT_LIST_HEAD(&priv->mdf.sitf_list);
 	INIT_LIST_HEAD(&priv->mdf.filter_list);
 
+	ret = stm32_mdf_sitf_init(&pdev->dev, &priv->mdf);
+	if (ret)
+		return ret;
+
 	platform_set_drvdata(pdev, priv);
 
 	pm_runtime_get_noresume(&pdev->dev);
@@ -785,8 +790,15 @@ static int stm32_mdf_core_suspend(struct device *dev)
 {
 	struct stm32_mdf *mdf = dev_get_drvdata(dev);
 	struct stm32_mdf_priv *priv = to_stm32_mdf_priv(mdf);
+	struct stm32_mdf_sitf *sitf;
 	int ret;
 
+	list_for_each_entry(sitf, &mdf->sitf_list, entry) {
+		ret = regmap_read(sitf->regmap, MDF_SITFCR_REG, &sitf->sitfcr);
+		if (ret)
+			return ret;
+	}
+
 	ret = pm_runtime_force_suspend(dev);
 	if (ret)
 		return ret;
@@ -794,7 +806,9 @@ static int stm32_mdf_core_suspend(struct device *dev)
 	regcache_cache_only(priv->regmap, true);
 	regcache_mark_dirty(priv->regmap);
 
-	/* Balance regmap_mmio_attach_clk() clk_prepare() */
+	/* Balance regmap_mmio_attach_clk() for the SITFs and the core. */
+	list_for_each_entry(sitf, &mdf->sitf_list, entry)
+		clk_unprepare(priv->kclk);
 	clk_unprepare(priv->kclk);
 
 	return pinctrl_pm_select_sleep_state(dev);
@@ -804,6 +818,8 @@ static int stm32_mdf_core_resume(struct device *dev)
 {
 	struct stm32_mdf *mdf = dev_get_drvdata(dev);
 	struct stm32_mdf_priv *priv = to_stm32_mdf_priv(mdf);
+	struct stm32_mdf_sitf *sitf;
+	unsigned int prepared = 0;
 	int ret;
 
 	ret = pinctrl_pm_select_default_state(dev);
@@ -825,8 +841,24 @@ static int stm32_mdf_core_resume(struct device *dev)
 		goto err_cache;
 	}
 
+	list_for_each_entry(sitf, &mdf->sitf_list, entry) {
+		ret = clk_prepare(priv->kclk);
+		if (ret)
+			goto err_sitf;
+		prepared++;
+
+		ret = regmap_write(sitf->regmap, MDF_SITFCR_REG, sitf->sitfcr);
+		if (ret)
+			goto err_sitf;
+	}
+
 	return pm_runtime_force_resume(dev);
 
+err_sitf:
+	while (prepared) {
+		clk_unprepare(priv->kclk);
+		prepared--;
+	}
 err_cache:
 	clk_unprepare(priv->kclk);
 err_clk:
diff --git a/drivers/iio/adc/stm32-mdf-serial.c b/drivers/iio/adc/stm32-mdf-serial.c
new file mode 100644
index 000000000000..6ba3be019847
--- /dev/null
+++ b/drivers/iio/adc/stm32-mdf-serial.c
@@ -0,0 +1,223 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * This file is part of STM32 MDF driver
+ *
+ * Copyright (C) 2023-2026, STMicroelectronics - All Rights Reserved
+ */
+
+#include <linux/cleanup.h>
+#include <linux/clk.h>
+#include <linux/clk/clk-conf.h>
+#include <linux/clk-provider.h>
+#include <linux/device.h>
+#include <linux/export.h>
+#include <linux/list.h>
+#include <linux/of.h>
+#include <linux/regmap.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
+#include <linux/string.h>
+
+#include "stm32-mdf.h"
+
+enum {
+	STM32_MDF_SCKSRC_CCK0,
+	STM32_MDF_SCKSRC_CCK1,
+	STM32_MDF_SCKSRC_CLK,
+	STM32_MDF_SCKSRC_NONE,
+};
+
+static const char * const stm32_mdf_sitf_modes[] = {
+	[STM32_MDF_MODE_SPI] = "spi",
+	[STM32_MDF_MODE_LF_SPI] = "lf_spi",
+	[STM32_MDF_MODE_MANCHESTER_R] = "manchester_r",
+	[STM32_MDF_MODE_MANCHESTER_F] = "manchester_f",
+};
+
+static const struct regmap_config stm32_sitf_regmap_cfg = {
+	.reg_bits = 32,
+	.val_bits = 32,
+	.reg_stride = sizeof(u32),
+	.max_register = MDF_SITFCR_REG,
+	.fast_io = true,
+	/* Do not use regcache as it does not support single register map */
+};
+
+/**
+ * stm32_mdf_sitf_start() - Enable an MDF serial interface
+ * @sitf: Serial interface to enable
+ *
+ * Enable the serial interface and increment its active-user count on success.
+ * Each successful call must be balanced by stm32_mdf_sitf_stop().
+ *
+ * Return: 0 on success, or a negative error code on failure.
+ */
+int stm32_mdf_sitf_start(struct stm32_mdf_sitf *sitf)
+{
+	int ret;
+
+	guard(spinlock)(&sitf->lock);
+
+	ret = regmap_set_bits(sitf->regmap, MDF_SITFCR_REG, MDF_SITFCR_SITFEN);
+	if (!ret)
+		sitf->refcnt++;
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(stm32_mdf_sitf_start);
+
+/**
+ * stm32_mdf_sitf_stop() - Release an MDF serial interface user
+ * @sitf: Serial interface to release
+ *
+ * Decrement the active-user count and disable the serial interface when the
+ * last user releases it.
+ *
+ * Return: 0 on success, -EPERM if there are no active users, or a negative
+ * error code if disabling the interface fails.
+ */
+int stm32_mdf_sitf_stop(struct stm32_mdf_sitf *sitf)
+{
+	int ret = 0;
+
+	guard(spinlock)(&sitf->lock);
+
+	if (!sitf->refcnt) {
+		dev_err(sitf->dev, "Unbalanced serial interface stop ?\n");
+		return -EPERM;
+	}
+
+	sitf->refcnt--;
+
+	if (!sitf->refcnt)
+		ret = regmap_clear_bits(sitf->regmap, MDF_SITFCR_REG, MDF_SITFCR_SITFEN);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(stm32_mdf_sitf_stop);
+
+static int stm32_mdf_sitf_get_clk(struct device *dev, struct device_node *np,
+				  struct stm32_mdf_sitf *sitf)
+{
+	struct clk *sck;
+	int ret;
+
+	/* SITF nodes have no device to apply their assigned clock configuration. */
+	ret = of_clk_set_defaults(np, false);
+	if (ret)
+		return dev_err_probe(dev, ret, "Can't configure serial clock for %pOF\n", np);
+
+	sitf->scksrc = STM32_MDF_SCKSRC_NONE;
+	/* Optional clock. Clock not needed in Manchester mode. */
+	if (!of_property_present(np, "clocks"))
+		return 0;
+
+	sck = devm_get_clk_from_child(dev, np, NULL);
+	if (IS_ERR(sck))
+		return dev_err_probe(dev, PTR_ERR(sck), "Can't get serial clock for %pOF\n", np);
+
+	sitf->sck = sck;
+	if (!strncmp(__clk_get_name(sck), STM32_MDF_CCK0, sizeof(STM32_MDF_CCK0)))
+		sitf->scksrc = STM32_MDF_SCKSRC_CCK0;
+	else if (!strncmp(__clk_get_name(sck), STM32_MDF_CCK1, sizeof(STM32_MDF_CCK1)))
+		sitf->scksrc = STM32_MDF_SCKSRC_CCK1;
+	else
+		sitf->scksrc = STM32_MDF_SCKSRC_CLK;
+
+	return 0;
+}
+
+static int stm32_mdf_sitf_parse(struct device *dev, struct device_node *np,
+				struct stm32_mdf_sitf *sitf)
+{
+	const char *str;
+	int ret, mode;
+	u32 idx, sitfcr;
+
+	ret = of_property_read_u32(np, "reg", &idx);
+	if (ret)
+		return dev_err_probe(dev, ret, "Could not get interface index for %pOF\n", np);
+
+	if (idx % 0x80) {
+		dev_err(dev, "Unexpected reg property value [%x]\n", idx);
+		return -EINVAL;
+	}
+
+	idx = (idx >> 7) - 1;
+	if (idx > sitf->mdf->nbf) {
+		dev_err(dev, "Interface index [%d] exceeds maximum [%d]\n", idx, sitf->mdf->nbf);
+		return -EINVAL;
+	}
+
+	ret = of_property_read_string(np, "st,sitf-mode", &str);
+	if (ret)
+		return dev_err_probe(dev, ret, "Could not get interface mode for %pOF\n", np);
+
+	mode = match_string(stm32_mdf_sitf_modes, ARRAY_SIZE(stm32_mdf_sitf_modes), str);
+	if (mode < 0) {
+		dev_err(dev, "Unknown serial interface mode [%s]\n", str);
+		return mode;
+	}
+
+	sitf->mode = mode;
+	sitfcr = FIELD_PREP(MDF_SITFCR_SITFMOD_MASK, mode);
+
+	ret = stm32_mdf_sitf_get_clk(dev, np, sitf);
+	if (ret)
+		return ret;
+
+	if (mode == STM32_MDF_MODE_SPI && sitf->scksrc == STM32_MDF_SCKSRC_NONE) {
+		dev_err(dev, "Missing clock for serial interface [%d] in SPI mode\n", idx);
+		return -EINVAL;
+	}
+
+	if (mode == STM32_MDF_MODE_LF_SPI && (sitf->scksrc != STM32_MDF_SCKSRC_CCK0 &&
+					      sitf->scksrc != STM32_MDF_SCKSRC_CCK1)) {
+		dev_err(dev, "Missing CCKx clock for serial interface [%d] in LF_SPI mode\n", idx);
+		return -EINVAL;
+	}
+
+	sitf->id = idx;
+	sitf->node = of_fwnode_handle(np);
+	spin_lock_init(&sitf->lock);
+
+	sitfcr |= FIELD_PREP(MDF_SITFCR_SCKSRC_MASK, sitf->scksrc);
+
+	return regmap_set_bits(sitf->regmap, MDF_SITFCR_REG, sitfcr);
+}
+
+int stm32_mdf_sitf_init(struct device *dev, struct stm32_mdf *mdf)
+{
+	struct stm32_mdf_sitf *sitf;
+	void __iomem *base;
+	int ret;
+
+	for_each_available_child_of_node_scoped(dev->of_node, child) {
+		if (!of_node_name_eq(child, "sitf"))
+			continue;
+
+		sitf = devm_kzalloc(dev, sizeof(*sitf), GFP_KERNEL);
+		if (!sitf)
+			return -ENOMEM;
+		sitf->dev = dev;
+		sitf->mdf = mdf;
+
+		base = devm_of_iomap(dev, child, 0, NULL);
+		if (IS_ERR(base))
+			return PTR_ERR(base);
+
+		sitf->regmap = stm32_mdf_regmap_init(dev, mdf->kclk, base,
+						     &stm32_sitf_regmap_cfg);
+		if (IS_ERR(sitf->regmap))
+			return dev_err_probe(dev, PTR_ERR(sitf->regmap),
+					     "Failed to init SITF regmap\n");
+
+		ret = stm32_mdf_sitf_parse(dev, child, sitf);
+		if (ret)
+			return ret;
+
+		list_add(&sitf->entry, &mdf->sitf_list);
+	}
+
+	return 0;
+}
diff --git a/drivers/iio/adc/stm32-mdf.h b/drivers/iio/adc/stm32-mdf.h
index e3617b181e28..fa689954d7c1 100644
--- a/drivers/iio/adc/stm32-mdf.h
+++ b/drivers/iio/adc/stm32-mdf.h
@@ -19,6 +19,9 @@
 #define MDF_IPIDR_REG 0xff8
 #define MDF_SIDR_REG 0xffc
 
+/* Registers offsets relative to sitf base address */
+#define MDF_SITFCR_REG 0x00 /* 0x80 * x + offset */
+
 /* Registers offsets relative to filter base address */
 #define MDF_BSMXCR_REG 0x00 /* 0x84 * x + offset */
 #define MDF_DFLTCR_REG 0x04
@@ -177,8 +180,49 @@
 #define STM32_MDF_CCK0 "clk_cck0"
 #define STM32_MDF_CCK1 "clk_cck1"
 
+enum stm32_sitf_mode {
+	STM32_MDF_MODE_LF_SPI,
+	STM32_MDF_MODE_SPI,
+	STM32_MDF_MODE_MANCHESTER_R,
+	STM32_MDF_MODE_MANCHESTER_F,
+	STM32_MDF_MODE_NB,
+};
+
+/*
+ * struct stm32_mdf_sitf - STM32 MDF serial interface data
+ * @entry: serial interface list head
+ * @dev: pointer to parent device
+ * @regmap: regmap for register read/write
+ * @mdf: mdf common data pointer
+ * @node: serial interface node handle
+ * @sck: sitf clock handle
+ * @base: sitf registers base cpu addr
+ * @lock: sitf state manegement lock
+ * @refcnt: sitf usage reference counter
+ * @scksrc: sitf clock source
+ * @id: serial interface index
+ * @mode: sitf mode
+ * @sitfcr: sitf configuration register backup
+ */
+struct stm32_mdf_sitf {
+	struct list_head entry;
+	struct device *dev;
+	struct regmap *regmap;
+	struct stm32_mdf *mdf;
+	struct fwnode_handle *node;
+	struct clk *sck;
+	void __iomem *base;
+	spinlock_t lock; /* Manage race conditions on sitf state */
+	unsigned int refcnt;
+	unsigned int scksrc;
+	u32 id;
+	u32 mode;
+	u32 sitfcr;
+};
+
 /*
  * struct stm32_mdf - STM32 MDF driver common data (for all instances)
+ * @sitf_list: pointer to serial interfaces list
  * @filter_list: pointer to filter interfaces list
  * @kclk: kernel clock shared by the core and its children
  * @fproc: processing clock frequency
@@ -186,6 +230,7 @@
  * @nb_interleave: number of interleaved filters
  */
 struct stm32_mdf {
+	struct list_head sitf_list;
 	struct list_head filter_list;
 	struct clk *kclk;
 	unsigned long fproc;
@@ -224,3 +269,7 @@ int stm32_mdf_core_lock_kclk_rate(struct stm32_mdf *mdf);
 void stm32_mdf_core_unlock_kclk_rate(struct stm32_mdf *mdf);
 unsigned long stm32_mdf_core_get_cck(struct stm32_mdf *mdf);
 
+int stm32_mdf_sitf_init(struct device *dev, struct stm32_mdf *mdf);
+int stm32_mdf_sitf_start(struct stm32_mdf_sitf *sitf);
+int stm32_mdf_sitf_stop(struct stm32_mdf_sitf *sitf);
+

-- 
2.43.0

