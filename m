Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011057.outbound.protection.outlook.com [40.107.130.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53D4037A85A;
	Fri, 11 Sep 2026 15:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789141921; cv=fail; b=ZyH11p5R11+05QdrfQZUKUFX2sNwcSMLWwA1blIgDuQbZhrEM8jaZSfhICHhjW8CgTWgB8clKzjmnXPGIVsbhpCWd5aUeimetIJgDxFOb9oC1PBntyvqmx33vkmL4w4tkq9qO2gFbTddeL80fzGq/VL8XKp2cLj8Iv+RO/t2Als=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789141921; c=relaxed/simple;
	bh=1gkW2CpWWCCCx7YuFke8mSHwm4FE16xOCaN8ejQFqbU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=Cbp5XPXsH8fJ/Y5BuXd5XzCQVMwHGA6AjY2ZekXYIbTmGVJjt9Fj5IbBOZ3kP2a/yiHhrdH8pHQv5tKxvpF2tSdmsW7pGfMpDy0EHxc5y0G5Ien3qwIuvmWMtiarMN8vYDd6G3Ypg1idBUslIarFfxzJm7btGALUOp1DaUQRGt4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=OLRCHCcB; arc=fail smtp.client-ip=40.107.130.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="OLRCHCcB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BqAjiBtqy28nd7HbOiAlf1CAkHemtU02Lu101S5xFa+qZwCIIBpNahP3yoqPGvf5nYXIZQi65nQeDMACRfVhRa4TfY90yPfUpp9oqi3F7AWlGcufuFJJloDGdomzIY+aEuxOMI4Iswr6EpcEyVd+ploUu095d2YPGuaAE5+tWCgSRRMscV36LprDkyQ1p6etVfqwBKSDMCndxjF/bbPTHgFeArT8ZHVOUxHUJl1Mwlo7ewvYzTCNdr0LmXparrMabhXVcUKJErmY2095nLaVJx5CceDoOG2xPT7BvR1E76Z9+TcUGf8SsbWX11GaM25HLQIbi0+vlMK51gL8hMbnGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VxDlG7OFZAVcBRct3lRSkcssDxyZrbXQta+zy2Y/nbw=;
 b=G/UDNDs17plV/lXiIaSj4tLPFPqct4aKtkqpHoWiuqKCDxzHByHVYNiwYdLquwI3IMbwM0ttexOtU6p4RxFbOmTZvx5SZxTRX21LJ9goduWLlC7VtjuKMWEg6u4RhwC96AC79fiPedz4iOZjEv90BTV6cMrCs+D2fwcd5OyD8VgrM1wS05qvzstSndFzVjwiFyOv1ZZ0iPlNvdMhIb5yP2dITU0yffeYYlJok6rke61pQsQDroegXlEQj7hM2iLYlJYy+qvgSaLB+G3y7blzDjOBA9x5FTBemZR0z7Hovn68/QqrczRYKFIhA/sQ0drFQ+r78bTXkG2TEWwI4wPdtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=kernel.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VxDlG7OFZAVcBRct3lRSkcssDxyZrbXQta+zy2Y/nbw=;
 b=OLRCHCcBe9AIMRUN8vl2iZ0ASCv8p17JKgPKn7rpOc3wDqyPVTmPkcUOOZRl00Alf0CPMnPIANZ/aW1PCXiGcbKW0+Xg48Ya4zviyxkfwiJoSSLoWJZaZ4hvimPDfvbbEAhxChaHNENJeUi4QXYqYL3xwQi/8ZvHoMe7mL/McwoOGlbYGJatmxZlL/4E8bfGiGnFKL8B0rZ6tVOnWbEDI/2CWChjCvAzLSwKioMocSFmeqdpbOW6soY5Wajjwgb1sUYc3umYLaE/dOyj3GC96nCQIrTV2ucS/4s+CDnGTkpQ0H9ND+6jwQsXuszZ5R78i79GFjW3Ut2JIXb+a9gXrQ==
Received: from VI6PEPF00000210.AUTP296.PROD.OUTLOOK.COM (2603:10a6:808:1::8d0)
 by DU0PR10MB5828.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3bc::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Fri, 11 Sep
 2026 15:51:49 +0000
Received: from MI3PEPF00008484.eurprd02.prod.outlook.com (2603:10a6:298:1::6b)
 by VI6PEPF00000210.outlook.office365.com (2603:10a6:808:1::8d0) with
 Microsoft SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id
 15.21.406.9 via Frontend Transport; Fri, 11 Sep 2026 15:51:48 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 MI3PEPF00008484.mail.protection.outlook.com (10.167.240.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Fri, 11 Sep 2026 15:51:48 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Fri, 11 Sep
 2026 17:57:49 +0200
Received: from localhost (10.48.86.251) by STKDAG1NODE2.st.com (10.75.128.133)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Fri, 11 Sep
 2026 17:51:46 +0200
From: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Date: Fri, 11 Sep 2026 17:51:28 +0200
Subject: [PATCH 6/8] arm64: dts: st: add ADC nodes on stm32mp231
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260911-adc-stm32mp25-v1-v1-6-cef26eecdef2@foss.st.com>
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
	Fabrice Gasnier <fabrice.gasnier@foss.st.com>, Cheick Traore
	<cheick.traore@foss.st.com>
X-Mailer: b4 0.16.0
X-ClientProxiedBy: ENXCAS1NODE2.st.com (10.75.128.138) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MI3PEPF00008484:EE_|DU0PR10MB5828:EE_
X-MS-Office365-Filtering-Correlation-Id: 6812e4be-52c7-45c5-6ff0-08df101c96ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|1800799024|23010399003|7416014|376014|6133799003|10067099003|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	33D4Fo6tJ3eY/3I9/VLTSw5aCINwfyBfAXKhh8kSPtZvVKVf61A20ZqPtlbu7Gja+vWBrk5b59oPB8mIfjcH4fYaLCQh070XfPLy+UD8fDhNVBIG+AZZIoy6rk5xia4G2gQay3RvkxgcstZUzIlF6wjnwYf/cs6J1wAa0vNtX9G1gIz5AdwetzPemPpHeMJ6wzchH8+0xk1010BPEmPpFN2nsqlCavVj3z9iJiV0ONe6Rrms0mLJBtQzZ8J+o4D3nLw95XgPzSSFP4Zgv1YtycnrARum2x5NqixBYGxTDn9KaXB/b6bt12tfVRRNajcTctQnCnJy1Gs+M3OdsjSnTxgZnSXqG/gd8ZiAk4rkzQv8F0rex3vkk+kmECF1FwwI1cm/hAFmGZZ//w51I6GLpCSohEM4DyqJAMgnNNpMuX76FH/N123/njmBD0/tc0ex5lsH2nXEX7b3s9QsNMK+JVeJLtMyWXM5+5mnPDl+O4WyzaEg7JJaE0+CM7hP1oGHiwFFOcajxZA6K4kl7WnxtzgMrATmoRQ8dozeuxRU7zJXR4Vl4Y+zbN+v7fpEdP7LoJcQgvxF4icM+WjrqxSc+wpzNq0MFyBW4rVfqdv/EQqpe7TPo47DRcbaIRnygxsLrWiZvywvB/cGRHnUiBOPrE31EpdQd48Pdf8hSDMtrSZ4DqiOfdXa4LaPdPSfdpG7kWocrwD003NW5PL1uVrRxw==
X-Forefront-Antispam-Report:
	CIP:164.130.1.59;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(1800799024)(23010399003)(7416014)(376014)(6133799003)(10067099003)(18002099003)(22082099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	I1fKcX0esgdoFk3hrzUxO7+fOfglMS2YOF7tZHtcO4cTzwATWV0bBMlrHnPoadRF3glfnUMFnCM2NWhIznvSH9vyNbFbP+vhzO6eYu9zARBq4IXaxfSdeeioypoOHwN1WtV7izRKfBsckmNmFXUphZxtMUs7f8Pr90LogXOPbts5i85ac1W8TZDtBN3kAhp6POr49QKuJH/k7/uUGaONZvDWJcHMuqD+cHbrd04OkQtLWQwuWsNB0WZ4MyXNEC0H3YvtI+iUTt0rudrZ61tDbRoUc9KXvUg7J5t8dRDX41itTdG6OlWY++WFAEpEQuy8FywH9dPYH2KNs3wO2Ixr5LPklvRwUtx2kfax71leHnf55CNrAmPlCibiwZwfITPZe3O8OQkV+gmJ4k9N9zu8BqlEkRXqC5jWy4CAiJAGRqdPDZzajcJIuqhgQ7gd4WdP
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2026 15:51:48.7640
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6812e4be-52c7-45c5-6ff0-08df101c96ff
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.59];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MI3PEPF00008484.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB5828

From: Cheick Traore <cheick.traore@foss.st.com>

Add analog-to-digital converter support on STM32MP23 SoC. It has 3 ADCs,
split into two blocks:
- ADC12 (ADC1 & ADC2) are tightly coupled.
- ADC3 is managed independently.
Define internal voltage channels in the SOC dtsi file, exception made of
vbat/4 channel (to avoid undesired load on it, in case no conversion is
needed on this channel). Choice is let to board implementation (via DT)
to define it.

Signed-off-by: Cheick Traore <cheick.traore@foss.st.com>
Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
---
 arch/arm64/boot/dts/st/stm32mp231.dtsi | 113 +++++++++++++++++++++++++++++++++
 1 file changed, 113 insertions(+)

diff --git a/arch/arm64/boot/dts/st/stm32mp231.dtsi b/arch/arm64/boot/dts/st/stm32mp231.dtsi
index 959500140d98..3aa1efdf9402 100644
--- a/arch/arm64/boot/dts/st/stm32mp231.dtsi
+++ b/arch/arm64/boot/dts/st/stm32mp231.dtsi
@@ -646,6 +646,119 @@ uart7: serial@40370000 {
 				status = "disabled";
 			};
 
+			adc_12: adc@404e0000 {
+				compatible = "st,stm32mp23-adc-core", "st,stm32-adc-core";
+				reg = <0x404e0000 0x400>;
+				interrupts = <GIC_SPI 87 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 88 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&rcc CK_KER_ADC12>;
+				clock-names = "adc";
+				interrupt-controller;
+				#interrupt-cells = <1>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				access-controllers = <&rifsc 58>;
+				status = "disabled";
+
+				adc1: adc@0 {
+					compatible = "st,stm32mp23-adc", "st,stm32-adc";
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
+					compatible = "st,stm32mp23-adc", "st,stm32-adc";
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
+				compatible = "st,stm32mp23-adc-core", "st,stm32-adc-core";
+				reg = <0x404f0000 0x400>;
+				interrupts = <GIC_SPI 89 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&rcc CK_KER_ADC3>;
+				clock-names = "adc";
+				interrupt-controller;
+				#interrupt-cells = <1>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				access-controllers = <&rifsc 59>;
+				status = "disabled";
+
+				adc3: adc@0 {
+					compatible = "st,stm32mp23-adc", "st,stm32-adc";
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

