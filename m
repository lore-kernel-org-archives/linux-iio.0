Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010035.outbound.protection.outlook.com [52.101.84.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0868D48F031;
	Fri, 11 Sep 2026 15:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789141981; cv=fail; b=Xq9VO+QEW9Bzok8k8LJz6JDqjP99nBSzJZRfRnYJ9+IW0LaH9Zouk3qVF0/KEaqMFaTmopev0TvjqYUKtG1c+DYxLtLqAFA4Vd7Zv383mRWD2snpIUmJrcxlPP1LqbE/OTPK9Hrw7lWbu59iVBPeHrpNzj6dYsB1TtTLficYgZ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789141981; c=relaxed/simple;
	bh=ivN9sXBp7v9Bt9jTkrWEYG1e250rE8B9wwMOK4GTwPU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=VhqwS2az+Uv3PHBjhO6dZaxPfF2WH1LUeYShwxUnmRZRr2LczcfPmwhIzZ9ZUz+BZX/s+BDYofAX8TVyxYNkFdUhJ+ECKnKVewW7XrwDASTsE9Hyy7kcIwXI4DABehYaAYIpyhb7Fb2deHfUOLIpY9FRAzvmNH2AEwJvInHHTsU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=Gj/13t0/; arc=fail smtp.client-ip=52.101.84.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="Gj/13t0/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FLdC6R4imb9iRWa9sKFD21hoDQ0k0I/rjAJ5cd6RrfmZmzIZcR9IC5826uxD2NvVuJerAHpkOtjA1AltdA5Hpg8gHE/SzeLGbLTfcWCY8uwFDEVlU+vAAUVugYdR3RT0Z3BGBy7i65aJSM++C+DfW0TIdISXWlStOs9x0YHQMC+7wBgtrOhyhI/BVSp0F0y7Fejl75vZDUP6tfcsBIIJJlsFDX1aU2zLfCMIR3uV6LbXAX9odWNxYovu5fGIYYRtVRU6hUnxncQ5JfUESpXJHBWakf2ovh6A7+OOKut2C14+PbJyK8lfV3XTOk3Q8bJGNcE1kYYd5SiBUozBYKEUHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YLaslZg5BjxzDi68+C8/BtXDDsDWknAB614cS3+LlaE=;
 b=C72Fv9ImoKmdiuwR0jodY+uB/G4a9bO1SJBViiMnMxB1ykUojEgsa8v9q5pISVKQZj3qGBo5G0hXLphfHm6KdxPPhzzkIHJZD/wxT0ok/OpZx1obhRwXvwHUJ927bIaarqQujISclKCN3LKCM8F6wCuUcgahbzDSlLu8de1PN4pLodzMkc6KM2RJ74jGML4QYofbmdgO98/pYWV1akPx5OEo5aV0Kjtk3x+ygW74vwNK+CK1w+eJpuVjgKYbjmK2VrY4ejrNzWqWLRml8kaW5A95rrDsB+/1TeixlMbrM/drKRULZEsbi7uoSgAolfO9bUSzNKWQqXCe9FTY9NykoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=kernel.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YLaslZg5BjxzDi68+C8/BtXDDsDWknAB614cS3+LlaE=;
 b=Gj/13t0/rT/VUCUqOr2ke2YLKrxw39LfmGzh3epXoA8jr8olMTlmmraTtxvfcnQ5iYIiR1/yXHij20bFIj4OSaQgRkZLgNns7NlwnhgV7C5gtPwpzMotG7RbbSTdnVFz2cvjW7fvN5qh2XfsdMqUK7EcW0z0YSVTUQkO+hKy/Bq623w+BjsdDS+CJP0U4v+VHflyLqowJ6NotYhP2AR+klIvvdE24VerAMI7jx2B2HqSmzGnuoD2ejs1F/22ezjAuv6LZliKW3bd3Ofj44qyHx3acwK5mNuA7hcCQCZ5BF+Rteb80F6Fr3ktfuriPdfuUrRG0bR3tL2lRW29Q7pkLA==
Received: from LO4P265CA0046.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:2ac::20)
 by GVXPR10MB8001.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.8; Fri, 11 Sep
 2026 15:52:53 +0000
Received: from ZR1PEPF0000E6AD.eurprd05.prod.outlook.com
 (2603:10a6:600:2ac:cafe::18) by LO4P265CA0046.outlook.office365.com
 (2603:10a6:600:2ac::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.7 via Frontend Transport; Fri, 11
 Sep 2026 15:52:53 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.60)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 ZR1PEPF0000E6AD.mail.protection.outlook.com (10.167.241.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Fri, 11 Sep 2026 15:51:51 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Fri, 11 Sep
 2026 17:57:16 +0200
Received: from localhost (10.48.86.251) by STKDAG1NODE2.st.com (10.75.128.133)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Fri, 11 Sep
 2026 17:51:47 +0200
From: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Date: Fri, 11 Sep 2026 17:51:29 +0200
Subject: [PATCH 7/8] arm64: dts: st: add ADC nodes on stm32mp251
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260911-adc-stm32mp25-v1-v1-7-cef26eecdef2@foss.st.com>
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
	Fabrice Gasnier <fabrice.gasnier@foss.st.com>
X-Mailer: b4 0.16.0
X-ClientProxiedBy: ENXCAS1NODE2.st.com (10.75.128.138) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZR1PEPF0000E6AD:EE_|GVXPR10MB8001:EE_
X-MS-Office365-Filtering-Correlation-Id: d52303ed-4cce-47df-b9f6-08df101c985f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|82310400026|23010399003|36860700016|6133799003|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	B1YIEAAssOI3DWidYsGmiSu13KevfeMWUA/qmgJeGffa0R8I8MaTK2PXD44TzHJy/74Gl4tWhdJ9WvAgpcPfM70TWlX6WagLBYJ93X2kLhYqe2PEPCu3J7DMblYwNcKN5eVySPxLlplkj63WYd1ueKVDH4fl9HZWGy1U/ibuT/B1dhsS5qHk3XI0THcBi1yck9u5EESkcCMYndJas4egjNZRMLqEi8yCxSxbFcrzh4UkHVmavKkD2pVc4lVa1AJmNms3Pu2ZLdCgTiigs8qJjo2xHq55H2Esfhlq3Fn1crCZH0+yjHle7JKfxhWWgjdXkjrOMBEYoSAfjavA02Kca7V+B5UkWrirsBQaKuNCvHpqgl7r3CcITWk7eypbXNkqyBrLIG2IO+KEYHI26CtBptGg4VVSHYCBOzWgltPR/lKaavzFNoHyHTtFKy8sOlirWPCDyrBtJB4S/4jtTaDeSKySqfQ/C5eTzFfP5Sc8kVaZ25zvLZhgZ/yx5UGFsG7q3R/z7IXK/EmsdmmX2I1XqmrkQYETe958QaOGxKpSIyhlznSbF+m5W3pw7B+pnsf4TMc0pjIbWd0hxdtzyMzwbLZsu38/wDdjQtZTenfIMsNKdvFTHqeV1CcT2FkBdQiKErhpcAxLhL0rhWYHqlBOhULn/75FIY7K/Dpy8JskeFg7fxrB4UUa/pjAzZzu4y5pRf6HZnMbWp4nJ3+cuKkKpg==
X-Forefront-Antispam-Report:
	CIP:164.130.1.60;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(82310400026)(23010399003)(36860700016)(6133799003)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	vlLp2WaW7jB9dR67Qe0IiAQo3OoCoKJNhojGX/Sl218odSEVBMp8SeDbeO7ljYHuQ0twTT8RnDAWuQ4uUjD0wPWT2iLgEgVZp/PD5Zwi084tUlHAkrvlPOS/rvOt8j+T1yKQhowmfyDrlLSSSzTCBdsdJQCm4WfZvIZx1q7Y5UgBKopgbtY2RtZbuvcB0meH5WFY50jzCQeMaW1BSvib6mGxbWQNvN+2W/ck8BihEu9nEby8i7KyVn//LJYG9xogAXr3UhkZdSmCH9yK/p+AurBjR51/HvD6VJS/yz4/xoSM1v14PUyRd1QW6YXBXF8nUXfjtpi/3Zs+TRTHPvUXISVDLvmhvncH4N1yzpGb9342fcFhu137c/SEgp3F8GAot6b9NbEOFQCLEPi1Zxe2wvQnT+9Sr9JtDUuq9G4h/KNHkMN4buduXh7Eq/Hrlqvl
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2026 15:51:51.0770
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d52303ed-4cce-47df-b9f6-08df101c985f
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.60];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	ZR1PEPF0000E6AD.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB8001

Add analog-to-digital converter support on STM32MP25 SoC. It has 3 ADCs,
split into two blocks:
- ADC12 (ADC1 & ADC2) are tightly coupled.
- ADC3 is managed independently.
Define internal voltage channels in the SOC dtsi file, exception made of
vbat/4 channel (to avoid undesired load on it, in case no conversion is
needed on this channel). Choice is let to board implementation (via DT)
to define it.

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
---
 arch/arm64/boot/dts/st/stm32mp251.dtsi | 115 +++++++++++++++++++++++++++++++++
 1 file changed, 115 insertions(+)

diff --git a/arch/arm64/boot/dts/st/stm32mp251.dtsi b/arch/arm64/boot/dts/st/stm32mp251.dtsi
index cebfcb985cdb..8925265f1ac2 100644
--- a/arch/arm64/boot/dts/st/stm32mp251.dtsi
+++ b/arch/arm64/boot/dts/st/stm32mp251.dtsi
@@ -1450,6 +1450,121 @@ uart8: serial@40380000 {
 				status = "disabled";
 			};
 
+			adc_12: adc@404e0000 {
+				compatible = "st,stm32mp25-adc-core", "st,stm32-adc-core";
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
+					compatible = "st,stm32mp25-adc", "st,stm32-adc";
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
+					st,adc-trigger-sel = <0>;
+					status = "disabled";
+					channel@14 {
+						reg = <14>;
+						label = "vrefint";
+					};
+				};
+
+				adc2: adc@100 {
+					compatible = "st,stm32mp25-adc", "st,stm32-adc";
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
+					st,adc-trigger-sel = <0>;
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
+				compatible = "st,stm32mp25-adc-core", "st,stm32-adc-core";
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
+					compatible = "st,stm32mp25-adc", "st,stm32-adc";
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
+					st,adc-trigger-sel = <1>;
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

