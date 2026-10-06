Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011034.outbound.protection.outlook.com [52.101.65.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1AF83C4B8E;
	Tue,  6 Oct 2026 07:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791273509; cv=fail; b=o3CqRlYisOKr95h0iE0x2vCQX6xXAVFHRY0sZjrNuXhy2r+dYG7L61rf2amN7f/kMIBzwPgrFakNiTkjlz9YZQHDh8F/RpR5DHMYlUilF41NI1hTg8N+H7JBVY7mJSJYi5b0haJZGzj4SdckUHCExBjOCFek4JzZEVkz+VJIGUg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791273509; c=relaxed/simple;
	bh=ofv3T1N4qmCzu9rA/FMcqRp/pVU2nNvs3HqchL+FmH0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=tXgzfZHsLYBLEdjIhik8Xd3tUya+0gGyrxSD3KGQU10gAr4MI4JMLZtd0KAw7uElTcOy5IR9R0lDGFujVR5BUsI5XMovhhJm2w987oPd+AbdbQjfrBJ4KzezLPzMOrexzwToKIzUGWnvouJ52tIo0ugOMP9PJ4aJvTissCBVwIc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=NksJTt9G; arc=fail smtp.client-ip=52.101.65.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="NksJTt9G"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QBDt99dU9xn330sHk7ciOXkLhAOPB0qnZt4DiTW1leSNeAITttKA6TblbfY4uLuDsmXgDZdwQTgRS21VPHhW5mLqj3iWfQp0Roc1vEpdZTntklroilWTSLWCFanwV5pPWQ1Oj5dAEYVWNJ/jyETL/CnXPjkjul6gdHH5Yqe4Ode38d31dKBkD0DIc9P/YxYUcx4IvEczWui/RVP+cektcNNaHKCDUo/0zgENSu9HkYz01bpMisA9fNMk4htMSaE5mbyQW5bjHpreNRCzcud/bF1V8KwcCOVO2hmXleYxVuglSEPp1PB9O5e4HZKPh2e86iE6/jxhJe29i7jUxrvB0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/jWPdQ1PQn7QYGRe4YmcAhnL6IV2b5nYkP8Ta9zUFmY=;
 b=KNv18MrYifr1khErZZHdRMQA7TEVqFfDGGMQ58dTRmqbh75vkazEUbceIsB5z28D2RYuBZqWkLE+N1CpBcXTaD8rtIiUEEKfU9J4S8h80UDXjqkcOzrCVlYH+ITol7ru6Fe2UfgrrBUDIcDPSPiyDOidILudkPdrVm6WS0VEmhtvd0q01nZP41TzRYi7EbdaHh/WnwHpQC1WR9xJvOYNqDGnjzAQXw4CLygC0fywSGGV2ykRDrXSjvK0vYqOz/oIMIP+FSOA/Vw+Q1Y3Vc2paOlpwMgqsMd6B35Pbjm2M8Q+qJ9IXqeGOoAIXmnbLoYtJ0XrFjZtlFSYrrPc3llxDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=gmail.com smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/jWPdQ1PQn7QYGRe4YmcAhnL6IV2b5nYkP8Ta9zUFmY=;
 b=NksJTt9GJz1uN6Q9AOh4YYicvzcpghtchnYP20ZvdcvaZ4hbSu8K0FE1EngR7IkGyjSxIg2h8cUMao7pfyYFY8LINtXKXgVyxA3dQZX/2OO2wgnBRHYnU6Q2LD1KjsGepGmHNl8c4DzlbkpumqQILbQ0Zg78qQhT/zJLuApaBkllZ7qhU5OMqm0Q0GOqcDIaytXzAjLc0uanmjgMMtVnkHItUwJQoW3pWWI1qmu2C7tiA9QMTuvAPhMFBlyRaMlYOZ1C16iK8rXWgc9STVhIL+6V2DXQoD0EPIRKpvcu5S+BT6O4Ii07I6jrY4kNgCYbMNlR45RR3/zuy2gtSRMTDQ==
Received: from AS9PR06CA0719.eurprd06.prod.outlook.com (2603:10a6:20b:49f::23)
 by VI1PR10MB8231.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:1d1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Tue, 6 Oct
 2026 07:58:20 +0000
Received: from AMS1EPF0000008D.eurprd05.prod.outlook.com
 (2603:10a6:20b:49f:cafe::a) by AS9PR06CA0719.outlook.office365.com
 (2603:10a6:20b:49f::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Tue, 6
 Oct 2026 07:58:18 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 164.130.1.60) smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 AMS1EPF0000008D.mail.protection.outlook.com (10.167.242.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.14 via Frontend Transport; Tue, 6 Oct 2026 07:58:17 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 6 Oct
 2026 10:04:21 +0200
Received: from localhost (10.252.27.219) by STKDAG1NODE2.st.com
 (10.75.128.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 6 Oct
 2026 09:58:17 +0200
From: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Date: Tue, 6 Oct 2026 09:57:44 +0200
Subject: [PATCH v4 13/15] arm64: dts: st: add ADC nodes on stm32mp231
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261006-adc-stm32mp25-v1-v4-13-d31ec75aecf3@foss.st.com>
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
	<cheick.traore@foss.st.com>
X-Mailer: b4 0.16.0
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS1EPF0000008D:EE_|VI1PR10MB8231:EE_
X-MS-Office365-Filtering-Correlation-Id: 2597ce9f-7403-4062-c356-08df237f9515
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|23010399003|1800799024|376014|7416014|6133799003|18002099003|10067099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	FnTipHO0k2ur8utISFh/GrEzns4YXOt83EO/mzSEg1B4+qb9+YZVKqobAvHYT5uE2Zhqp9GJNm5nHXAsspfRG5Q0/NLQIM+JCmbTjc8JHlO/5M6V+XJ8XNgwxJkVioiJdb+1iuv9c/BYFsinHq8UQOCvgYzrozSmAX2dW3xolGfN8aiZu09yP1sRXV1Iq5PxFVBKm8gVrnb9VJMNZmJH0k6kGbkkz3NAxhhZywziOdJ2WJkzZZTGuLQT0KJWFPBnRN3LqBEFwKDBRXkxLKq5Z6kEHd68ORON4pIxJLGp68pLyHMFfEurnd04onLmzUzO+qUciMa21Wk3yK6fqeB9Y9Z6aM3keOLbXrtYxYFwcDKfJkM6aou1JZqlhMVCm88bt9VJ7SwXve3SBxibs9uZooSKnkz3G8QMxiYnBcyDEEo9EBenfLQzIiljCRDASjyH4D8Rotrp83O44FNPHKpJlAjAXziaIt2fpiwqaK4QA5QtkGVuOhaauWPOP1+aQkA+RSk3tPSNWNrOCS9bEQF/BIPYyBF+R8QFaftLo0HaLzgynDEXDzKIqBeR2hj7pmqm3ECaoHcrsrcWrE+pFawFIusqDBGG7La/Mn0opw1dOKE2r0v7CeHvfSXNyw5w2DTLfRLNshR+2d3CGmb0ZkQJkz+zswPFGpICxiSZjVIXKJZkX+4u8aU2itP37zC7ANUECmAHR17IvcP15m0VKAxw9Q==
X-Forefront-Antispam-Report:
	CIP:164.130.1.60;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(23010399003)(1800799024)(376014)(7416014)(6133799003)(18002099003)(10067099003)(22082099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	pt8wCxp7yDKDz4rArXNGo7uc4BJuu8SgGQCyzrSeosS5AH6PTINj36BOIzz6OiEASwBBWaHK3hdMiJ1NyyvCnrNcFhJi6hEL5Z+1qN2POC0JLQTIs94N7pa2wmQw1B+grOIcdCIjZTspi83p2gn6FmB/jJqAcS2ZMdEhORe7evwbM6w1Kc8Ils5xqT6B0ajttDSjLpt7DoYspnnLpBZlNVargqAXXFe0mxdR5vfqKWDkfOCnRIlU6UWuusMnF/eD3tZYxR3pWEdpLe0awAWYJypIsqNTYHq+OCTrGXSGV6yoonk7HRs/BaaUTMkom+KJJjaWeyDZwDuTSGFE1Ks6HwZaDSR1EyK8oL/2QjBsn4GZMSrzZRyKXo3P4vZu6vBZ60f7Tbc5oKnV7wqIelmd6xUDPIquJmBJfkxKCW1SGVjF9NjE64nn+Zb9NcmEbSBy
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 07:58:17.8026
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2597ce9f-7403-4062-c356-08df237f9515
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.60];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS1EPF0000008D.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB8231

From: Cheick Traore <cheick.traore@foss.st.com>

Add analog-to-digital converter support on STM32MP23 SoC. It has 3 ADCs,
split into two blocks:
- ADC1 & ADC2 are tightly coupled.
- ADC3 is managed independently.
Define internal voltage channels in the SOC dtsi file, exception made of
vbat/4 channel (to avoid undesired load on it, in case no conversion is
needed on this channel). Choice is let to board implementation (via DT)
to define it.

Signed-off-by: Cheick Traore <cheick.traore@foss.st.com>
Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
---
Changes in v2:
- Adopt dedicated compatible for each child ADC, drop "st,adc-trigger-sel"
- Drop fallback generic match (serve no purpose)
---
 arch/arm64/boot/dts/st/stm32mp231.dtsi | 112 +++++++++++++++++++++++++++++++++
 1 file changed, 112 insertions(+)

diff --git a/arch/arm64/boot/dts/st/stm32mp231.dtsi b/arch/arm64/boot/dts/st/stm32mp231.dtsi
index 938d6f0098ac..578ab9d4cffc 100644
--- a/arch/arm64/boot/dts/st/stm32mp231.dtsi
+++ b/arch/arm64/boot/dts/st/stm32mp231.dtsi
@@ -646,6 +646,118 @@ uart7: serial@40370000 {
 				status = "disabled";
 			};
 
+			adc_12: adc@404e0000 {
+				compatible = "st,stm32mp23-adc-core";
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
+				power-domains = <&cluster_pd>;
+				status = "disabled";
+
+				adc1: adc@0 {
+					compatible = "st,stm32mp23-adc1";
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
+					compatible = "st,stm32mp23-adc2";
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
+				compatible = "st,stm32mp23-adc-core";
+				reg = <0x404f0000 0x400>;
+				interrupts = <GIC_SPI 89 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&rcc CK_KER_ADC3>;
+				clock-names = "adc";
+				interrupt-controller;
+				#interrupt-cells = <1>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				access-controllers = <&rifsc 59>;
+				power-domains = <&cluster_pd>;
+				status = "disabled";
+
+				adc3: adc@0 {
+					compatible = "st,stm32mp23-adc3";
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

