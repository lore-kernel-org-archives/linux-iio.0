Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012037.outbound.protection.outlook.com [52.101.66.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 103323CEBBA;
	Tue,  6 Oct 2026 07:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791273514; cv=fail; b=Ya/OAaCMB+9vRZxRCFrAtIn7Vbyr4GecBH9FBO00xo0llJ8C+C7VIUWsp//2P9xfugW9bYV0pQoqz9frMXySuqOpdVOHH90k6cp4ed1rr99pUxaOq39UB/pHgD8+Mscapn1TpSMSLfUFhfzF9Z5xrNLl0ZQgmZq+hOLNRz45HxY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791273514; c=relaxed/simple;
	bh=Qpp+gf32mxN4HdhHyGkGqixFnM1td+e5+S+xFzGhEl4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=Cun8GI2XHZKnUzH4nd8Mm+z9uiQhntQ8ZoirqTg1tiC6KQQt0OCkAUrjJiMNBtLmJ8dQBzhlx6Fi5r/RDC7BqNj3fD/ydlCpJ/wcMQJ93vepJ7K/CYq37z4e4BqwyK/kjgMyi3vwQBLRzAVfM27Iu7iPd9sf68BfNzURScpuBuc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=O8eM+gTL; arc=fail smtp.client-ip=52.101.66.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="O8eM+gTL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HitHDxwzFtk/g3e1hu3tw1/6qwlry57Mqe2Epy8htd5FRdhEhgICsgqI8JBDAebup6mhDB4xoGMCj/8jjNdSYgKR4AlK0IGKzK52Si56tEEXFNukkfzumBHjaxneVNTdwaw/bOv5e2aL5KWJBCHQKVf4je0f3oGiF1fORQVC9iWb7DBH6nubue50/Xxys/VSgBP6oiUeTsaIZHLc0HhCJ+kD+CP9EBOx9bQq0kG3a396zghCYB0sMope5nW0vm5tIsc2CSlE+yn9B39AlnCc5yfcT3gepZl6/Dkrtqyi1bGVyhRMMEQA/M7xj+7N3Pz4b6JMaa7yPn4qES2IQrr25Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vdh1K9iQ87c6paARyNmLvG+s0MpVfGWxuBQK9qRXNR4=;
 b=SbXJ0QtCjz6GmCikQWBKAfwK1kcGvlAcrfWx8Ez4DGJiAcKlZhx5y06WQXWDKZukgGVsiEGsN1IT2eaCAmiaDe5nK5SV+wAeylpK48lOI0TAIoutBqNTK4hczalTsyMlyihcIAMzEPYn9ep05G6T+4tyfN6SPEV28NIXJHvCS7eEw/ksi6isDnwS3aYTpW7UfS1jSiQKKCzYYGdur9kZgJGjTj6tyoWSnF4P7H5Ev65dMbswum8gM7M7BSPnXh/086f7RObgc0Sc1TVH2aphMdek7YDdt/PII5/T5Z2SSzPUZByX2jre9RudF4gwjRDiqjXSLzY5SucnuGE5lSnulA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=gmail.com smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vdh1K9iQ87c6paARyNmLvG+s0MpVfGWxuBQK9qRXNR4=;
 b=O8eM+gTLpPkKw75qyuGTCMTUa7qdkbMEdz/jiDJ1S2ooyxMIIQntGKTWUCIY2YW9kDq3dEtv7/TNPsDbUcZMp19zXVBNd/n+5QTrekras0u7UzPPfoIkhzG8AL7IgQRRXVPYrmxvYAt59lGVXeKNnbjZsHv3xzRkTFEJo2nFkM9rASDS7IgnfTDjSVc5hWpeIcXrNyNenIxVZv7h+7+vRxyZJF4cUsDIRouTnEXI0BgIGtnjaeD1COqFmJeB7VAHWlE7i39379hnGNBcaWQRHsh8yfYieWFTwpXU0+L1SRBaLPX9UoiLNGpqHc0H9q03qlQeELG7oMeo1G1jiYqEfQ==
Received: from AS9PR06CA0703.eurprd06.prod.outlook.com (2603:10a6:20b:49f::15)
 by DB4PR10MB6943.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3fd::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.27; Tue, 6 Oct
 2026 07:58:23 +0000
Received: from AMS1EPF0000008D.eurprd05.prod.outlook.com
 (2603:10a6:20b:49f:cafe::3c) by AS9PR06CA0703.outlook.office365.com
 (2603:10a6:20b:49f::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Tue, 6
 Oct 2026 07:58:21 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 164.130.1.60) smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 AMS1EPF0000008D.mail.protection.outlook.com (10.167.242.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.14 via Frontend Transport; Tue, 6 Oct 2026 07:58:21 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 6 Oct
 2026 10:04:22 +0200
Received: from localhost (10.252.27.219) by STKDAG1NODE2.st.com
 (10.75.128.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 6 Oct
 2026 09:58:17 +0200
From: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Date: Tue, 6 Oct 2026 09:57:45 +0200
Subject: [PATCH v4 14/15] arm64: dts: st: add ADC nodes on stm32mp251
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261006-adc-stm32mp25-v1-v4-14-d31ec75aecf3@foss.st.com>
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
	Fabrice Gasnier <fabrice.gasnier@foss.st.com>
X-Mailer: b4 0.16.0
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS1EPF0000008D:EE_|DB4PR10MB6943:EE_
X-MS-Office365-Filtering-Correlation-Id: 7636ea73-9f9f-4071-68f0-08df237f96fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|7416014|1800799024|376014|82310400026|23010399003|22082099003|18002099003|11063799006|260925021911599003|10067099003|260925022911599003|260925021311599003|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info:
	J8y8ZxFko6y+WmCZUxvg9MI1HIDgJIQrLrXQ6X1FhNJiSQ+MCH6xb6tHed/w8IYluu07rbQ9jc6FB5FBWiIsnC7aHw8cpIm/ITwYrOl7ER9cdb9MRwuIEcPbAVhgetsNTk3PkQrluMVTcpUSOTTf/4Yb+9ea+H+3pkYSXwZNqUsLh+4P03E0LIAo99IhLVB6RadD1t5TtKsUm8RlJhCznKQRYsrKR3LkJp1wysJAMGFBICnrkSZ3rmOW8ktFqa/Fm/5bFep/6M65kLs2rqHTBPJbn7agRoXZ8LclrZ9Nyyl3RN12G1ABpjprflQx2tWPuDzM4DN7fsLJ9rhYzqto/NrMHRVMvTzvo/A6+dKVieAvbcaaF4uA4Cg06pLPNZfic0OJGgF1s90pGjKhNmbCcCx3fzGhvKKy0tmjMdaLrygXQGIZyuOB8CnXRQvRTijLMXfirb61SNEjuqST93C42yeaDLtzdis1g9MfvrkUQivFS3IVBeQenbK2qObZKddsWOxxXn1BIBQg8RHTL3Q12yteCJAmppfoTIRG1rnj+PDUL0pnnPSUZhdrNFy9NitHmEcT3ECw6o/YYktmR+vljjbC9ZMZLOhTOrgudLqNMLunveuGqSkpid+RpA1Ug6GrIq6brgHWodQoJIFgxzMiH+aq1ANFWV6P+wmjjcqsNnN+Vo9wHAmQ9MzhmQb2OQBjC8j2iyZv7J+7EwiLyi/fnQ==
X-Forefront-Antispam-Report:
	CIP:164.130.1.60;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(7416014)(1800799024)(376014)(82310400026)(23010399003)(22082099003)(18002099003)(11063799006)(260925021911599003)(10067099003)(260925022911599003)(260925021311599003)(56012099006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	+STfN1oSj3jTc/bQ+uNiK5ZDpYQ6MyQDhnfMmMNYn9nM3sf3JVDNXvuY32BzRQ8RVavE99prkCNGZ5KFsa4WamZ9QKlcrRmZRKvH1aSb4rrToShxY15E0P1BotI12K6t2NItHNyeFcpeZfDvuAtG6PcLXMEm3LVfU25UxhC9sRl5zn2MKxmOq9SXUocpXY3TUmkNYhsGJCNeBUHVY4JKQ2ezbgdqyxZdWg6fI5jlXbRLCmeawkaebvUrSh+aPKkCUaXzaw84/sEHeMVEaRpTw13Hy3t4R8R+YpL9dbt82AgFdMPf37lrhocq9NkYXJBePi07/RGHO7gcVOR7ssHJFJRzyIbtuVPcX9JR8fAaBsIlALVq7OySCWrMM2NGdSCqZ8NYbgdENVa3ulC+QNicI2WZFZiHya7HTnoktUdYT/B9aUgye5S6iuH4VRe6Z2b6
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 07:58:21.0018
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7636ea73-9f9f-4071-68f0-08df237f96fe
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.60];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS1EPF0000008D.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR10MB6943

Add analog-to-digital converter support on STM32MP25 SoC. It has 3 ADCs,
split into two blocks:
- ADC1 and ADC2 are tightly coupled.
- ADC3 is managed independently.
Define internal voltage channels in the SOC dtsi file, exception made of
vbat/4 channel (to avoid undesired load on it, in case no conversion is
needed on this channel). Choice is let to board implementation (via DT)
to define it.

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
---
Changes in v2:
- Adopt dedicated compatible for each child ADC, drop "st,adc-trigger-sel"
- Drop fallback generic match (serve no purpose)
---
 arch/arm64/boot/dts/st/stm32mp251.dtsi | 112 +++++++++++++++++++++++++++++++++
 1 file changed, 112 insertions(+)

diff --git a/arch/arm64/boot/dts/st/stm32mp251.dtsi b/arch/arm64/boot/dts/st/stm32mp251.dtsi
index 82a8a6f1f881..5834755194a1 100644
--- a/arch/arm64/boot/dts/st/stm32mp251.dtsi
+++ b/arch/arm64/boot/dts/st/stm32mp251.dtsi
@@ -1450,6 +1450,118 @@ uart8: serial@40380000 {
 				status = "disabled";
 			};
 
+			adc_12: adc@404e0000 {
+				compatible = "st,stm32mp25-adc-core";
+				reg = <0x404e0000 0x400>;
+				interrupts = <GIC_SPI 87 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 88 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&rcc CK_KER_ADC12>;
+				clock-names = "adc";
+				interrupt-controller;
+				#interrupt-cells = <1>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				power-domains = <&CLUSTER_PD>;
+				access-controllers = <&rifsc 58>;
+				status = "disabled";
+
+				adc1: adc@0 {
+					compatible = "st,stm32mp25-adc1";
+					reg = <0x0>;
+					interrupt-parent = <&adc_12>;
+					interrupts = <0>;
+					dmas = <&hpdma 81 0x20 0x12>;
+					dma-names = "rx";
+					#io-channel-cells = <1>;
+					#address-cells = <1>;
+					#size-cells = <0>;
+					nvmem-cells = <&vrefint>;
+					nvmem-cell-names = "vrefint";
+					status = "disabled";
+					channel@14 {
+						reg = <14>;
+						label = "vrefint";
+					};
+				};
+
+				adc2: adc@100 {
+					compatible = "st,stm32mp25-adc2";
+					reg = <0x100>;
+					interrupt-parent = <&adc_12>;
+					interrupts = <1>;
+					dmas = <&hpdma 82 0x20 0x12>;
+					dma-names = "rx";
+					#io-channel-cells = <1>;
+					#address-cells = <1>;
+					#size-cells = <0>;
+					nvmem-cells = <&vrefint>;
+					nvmem-cell-names = "vrefint";
+					status = "disabled";
+					channel@14 {
+						reg = <14>;
+						label = "vrefint";
+					};
+					channel@15 {
+						reg = <15>;
+						label = "vddcore";
+					};
+					channel@17 {
+						reg = <17>;
+						label = "vddcpu";
+					};
+					channel@18 {
+						reg = <18>;
+						label = "vddgpu";
+					};
+				};
+			};
+
+			adc_3: adc@404f0000 {
+				compatible = "st,stm32mp25-adc-core";
+				reg = <0x404f0000 0x400>;
+				interrupts = <GIC_SPI 89 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&rcc CK_KER_ADC3>;
+				clock-names = "adc";
+				interrupt-controller;
+				#interrupt-cells = <1>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				access-controllers = <&rifsc 59>;
+				power-domains = <&CLUSTER_PD>;
+				status = "disabled";
+
+				adc3: adc@0 {
+					compatible = "st,stm32mp25-adc3";
+					reg = <0x0>;
+					interrupt-parent = <&adc_3>;
+					interrupts = <0>;
+					dmas = <&hpdma 83 0x20 0x12>;
+					dma-names = "rx";
+					#io-channel-cells = <1>;
+					#address-cells = <1>;
+					#size-cells = <0>;
+					nvmem-cells = <&vrefint>;
+					nvmem-cell-names = "vrefint";
+					status = "disabled";
+					channel@14 {
+						reg = <14>;
+						label = "vrefint";
+					};
+					channel@15 {
+						reg = <15>;
+						label = "vddcore";
+					};
+					channel@17 {
+						reg = <17>;
+						label = "vddcpu";
+					};
+					channel@18 {
+						reg = <18>;
+						label = "vddgpu";
+					};
+				};
+			};
+
 			rng: rng@42020000 {
 				compatible = "st,stm32mp25-rng";
 				reg = <0x42020000 0x400>;

-- 
2.43.0

