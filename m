Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013018.outbound.protection.outlook.com [40.107.162.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E6C84FDA4E;
	Wed, 30 Sep 2026 14:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790777977; cv=fail; b=nbJtKXjUH9LJimPmaaAP9XKTFmZqZBI5Kq5VzZnI3CI8VgSzuJ4zYQJ/la6JXjjgzATM4V9vXpP494MSWATg9TCXEmnVC8CRYRB9q70urMO+kPkCqEjK7XnjoHAXrHYAZcAemZLpAXufzG0OVvmo7CmOZ9HYmYMk4WeHZhAPXqY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790777977; c=relaxed/simple;
	bh=Qpp+gf32mxN4HdhHyGkGqixFnM1td+e5+S+xFzGhEl4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=YtJBI6OxvpkOZozmrOs9AUQ/o5/E3d+8MayPC+bdB4t03nruszk6tAbG2NxJjjssTDrofs8QB8f/7Vv/Wv26SFaAMSPI48leKmf9978buSo1qL2cWGGmHS+9jY6Qx+HR9Mkjuy+gnRXDZ92y6/moovPsIv+oGnkRTTtoBlPOzJE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=ml7gTYBp; arc=fail smtp.client-ip=40.107.162.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="ml7gTYBp"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XwI3u/U28u/a+esNIrMk+zataEcV6nb5AsQMMZE3swGPYQRVHCr8DfKksPLyzzztbuLCnug8MDI8RNcMX4l8zLXpFhX8B7deioJ1+ayNgswBmh4fP6Mr+zBXL4A6jVjzcpzb3Me8h5mvP0WKcJEnH1yIqGHj5+yP0x4ChJylkuqiD45OmSH4MOt+kZKCqL5jl85rd5fMA4hskllOZBWxCeQsQNJTQV6bU/B5RGgFl2wWIgPra6/N74dlZ4tjuIkvjdVlcVrh9UjEguHgKERZiEKjlPVs33hG7ulz1iyaHYXNmd855KDRU0Nr7PNRZY1pmcMD/z7sHoYONdTydjQegw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vdh1K9iQ87c6paARyNmLvG+s0MpVfGWxuBQK9qRXNR4=;
 b=MhpmHlYH3IBRZYh549d9a5WJGwlH29rPdKCaCYs622+u618LntB//DT+tC2OBICyHwCsiDfF402lIc/iEPO3flxA8nhT8Nqnor47/QS3O6gAILZKXJewdljMCriNVeiSpJWEGf2cx3DyETWCf10D+lY3cfCA7l+/0H+sZnrz2+OuVWwjRtpgwVfMNcwCJaIakIeKX8kR3V9x1YjUM8AhRNGG31YNxRXbeo3z8PA6t0HI7HXOeZQqFiwA9sWtnBsyJtzC/ElWVDWxSR9/DkyvkZP/QeiT/IsYKwU1pm1D4HuiRiPaUixraiMzCUU2hu6FkPc7IPdTf8LvPuFboZKc4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=baylibre.com smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vdh1K9iQ87c6paARyNmLvG+s0MpVfGWxuBQK9qRXNR4=;
 b=ml7gTYBpO31xFeAJZ7TAdK/zt1FEGZRTGydvJ/Yhy5D6LYlpaolce9tWTKYFw83Zmp6mE4tQJ+RcVeR+ySadBGIIq5EljpWbijsaFyHqCi6tqig+9NI7AVk4at2q8481ghpezMkGBKKZUS67iWw2SJFsXDD8Ob8iYqEyNi3fm37Ff9fsNpjT55Doeiqs6d/MT++f+ErwX+crzn2wcuF/9J3iYQrX+ANx/npNUUawLR19+0P/09FG4qH/GLYZqNH/7qj80hFBnZeiioFu/Ev2iBFvg1/v8tVkKQ+j0Z91+rRIss7VHDUUqQlb0DHtlUkwbL88TMRZAaUhxvkY41yN+w==
Received: from AS4P189CA0038.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:5dd::10)
 by PA2PR10MB8718.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:421::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Wed, 30 Sep
 2026 14:19:22 +0000
Received: from AMS1EPF0000008E.eurprd05.prod.outlook.com
 (2603:10a6:20b:5dd:cafe::67) by AS4P189CA0038.outlook.office365.com
 (2603:10a6:20b:5dd::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.16 via Frontend Transport; Wed,
 30 Sep 2026 14:19:22 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 164.130.1.60) smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 AMS1EPF0000008E.mail.protection.outlook.com (10.167.242.85) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Wed, 30 Sep 2026 14:19:22 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Wed, 30 Sep
 2026 16:25:15 +0200
Received: from localhost (10.252.17.140) by STKDAG1NODE2.st.com
 (10.75.128.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Wed, 30 Sep
 2026 16:19:21 +0200
From: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Date: Wed, 30 Sep 2026 16:18:35 +0200
Subject: [PATCH v3 14/15] arm64: dts: st: add ADC nodes on stm32mp251
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260930-adc-stm32mp25-v1-v3-14-406834430d72@foss.st.com>
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
	Fabrice Gasnier <fabrice.gasnier@foss.st.com>
X-Mailer: b4 0.16.0
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS1EPF0000008E:EE_|PA2PR10MB8718:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e3d93a4-ca31-499e-b81d-08df1efdd2e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|7416014|23010399003|1800799024|82310400026|260925021911599003|260925022911599003|260925021311599003|10067099003|11063799006|56012099006|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	AApTi2LkfcFRJhtoAytU/47eWcLJDdnYW7N1LFwzZ6rvELacJEG2hSqVmosYQuZXfFG9kwiwpJcX32YXjRIHRCA62fF/DdkcnNm0Xst8aG5ktW7xx2QXl0UTrLYjiR/3Tr7NQDs/eHxRNnHYIQGIio4EDXzkUJu4qe5a24W9aGw2zdgpEB7FX+0BWk67CfjzRe+MIESql6eSxYrmz1SH1/BzGU90WgRTw/zOc6bTZsMqGQDNNlJFkEdzMSYuzr2mrInXkXBc2sOprGijTwVGnO+uM0TLLjFHUDwWVW0wn5bFIjLbicRP7JDHaphWtVIxbIK0uMn5K+crngpvTNwr0gWDMtWhEV7vGMHmeR5cUMIn9mYIykPYHKLg5PMV3ie3FqFHq8E5+jp8hLBVhilKIjHdiysUJHaAefRIKHfOAIYsy+zZHx+PumEUShVh8bGsyjGMUmYrYlE4h9bgMrWqzZIn7JQ8XH6WpBh+RHxlQgwOD781wJqbWyCUWt/OoURhRFnWmtPXbvvgnlnL1E1TCdr/VGTpBrDEzS5wvy/CXQP341APwJwsuAqoZKYQQaU1gBwlDioUG1zLWMXb5DJMkO1MS0+MTxq/DU94l+eUpF7EM0ROUbX+Gv3o7cqK53GqEr/2DsHC328/DqzFiybVlNkRcYlMTQbH6h/SfXfG9Q3x2Dm5thYws1fyejpe5S3jVDYllqPIlcCixoBjjdbTjw==
X-Forefront-Antispam-Report:
	CIP:164.130.1.60;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(376014)(7416014)(23010399003)(1800799024)(82310400026)(260925021911599003)(260925022911599003)(260925021311599003)(10067099003)(11063799006)(56012099006)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	sXYDDnInxf7ePov3TcKUKxJweneTMw0KrGVJccwffex/zZgR7ls3Sa6F7MOM5UENjALayb54uO97y7PimS88pPglQ0CnBL8+8X29W6N7RPdxGsg5JrnVnzlRx0en2g/Hv/rfpxC9A5RPuF9fcQAGLOvcD9Z7qdwGROv+XARyhDhK35n3lid8EIENliQUZ7Wzm72/Lp3KJ7r9noIZoDJgyLf2/N+GVAOqU0jumiDZXah2tl5pTRCQmeJWrLNQ4ZALL7CwuKw0Rk9DVgfjT/ZTJnQ1MCaiFj9yEK9chOILuOgDOEGzyTdgIwTk94NdHMjMKwNY5Z/2ldBbH9lsu6lTZPkXcPQDezoBOWIn0/NCNpwXEMWViDYwQPFKOXGqYMqcRdTOHcm5vrOdKKWIUZBBgxNsFGYKml+0VnCD+ce5phbF4uMs+Qr9tntL8AZ3eOfF
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 14:19:22.3007
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e3d93a4-ca31-499e-b81d-08df1efdd2e8
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.60];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS1EPF0000008E.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR10MB8718

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

