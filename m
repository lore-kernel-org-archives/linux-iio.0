Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011036.outbound.protection.outlook.com [40.107.130.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6CF5556B92;
	Wed, 23 Sep 2026 15:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790177984; cv=fail; b=mkN5zc5iU3WTblI6ZwPp6GQtidcsZ/83QPUJX9xVa84K+GVzCKQTWrk092pomo4FNDAOF/hvzLEN0ZJHrUSo8LNY1dZWMCQYjp/TyehaOXEC1CtPPh8cKP1JWK3PvlzJ/Jss0BLUkyLRnQS5HlcOdhZcBLuCgWaN3lletHyAz2s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790177984; c=relaxed/simple;
	bh=ofv3T1N4qmCzu9rA/FMcqRp/pVU2nNvs3HqchL+FmH0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=NUR7q2fWLq2tJ6T3eN9XRYKMPTJ40ua6fnJ23LXJmx6rlWrK9NOInZ3QEWZdKjqTbeRyKPXnEK2T++0otquCL8DACFOTaDqJJlEYtlBEOgd5QC3Yx087uP3jJNyKcp6YBk8F911iaxEL18KE8Sj+m4u2NoBImyNaO5FP6fdMchE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=G7Brk5Ka; arc=fail smtp.client-ip=40.107.130.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="G7Brk5Ka"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jJS7YOoT0ACJURjdnxG/TgmiyiBeIUiD+hVxPlG8EEZt4gugWn0V3fPHxKuBsKil8SeWUr2pElhBLa04Xw/8z0TOAqsnKc54F3uPScGOLmDd6PA1DHKXGqmszsqTiNNZdgmFKNnJ8BFWrGl83Cc/fGkBc5VHYSCjSbJnqQCwLr+UuQ+ymh8QPy3IxQPvrFZWP7Vf5Bn2ZDpzWAnA95m069Mx+FNRwuSPAuqOSNWReskTvkAlpAbrMC360/P+6wfVCb3k2oM+LKn1bVvbx4qOhbBpPkzJLYI0g6cWSYWwxNHLqr531TnbaTPXUtrTPb4ccdIKcpYb3ViJJqa50AH72Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/jWPdQ1PQn7QYGRe4YmcAhnL6IV2b5nYkP8Ta9zUFmY=;
 b=nIU1ZWzl1pnsnVbqIL9DZPh40CllRNltmbOc18R5BJjyQ8hDGtE6iGF0AxXdleZPnGnUlLAi7oaQdvPDhAd1JvlJKwKN4zWboWy0jSlm1LXCgDWoLHLBvoJzoW96hJ4cWohVD4VefvnZ8GK6YrTbHs7PsqxDf9B4aw9zqHieFdSrYwqbfxMJwFO+UNQ9D1lYO/b9nZayYu4C1SV4UT6vI7i+LBJf0iLf0pL4zYUqXyeWmPH5Kx8X7HS2xCwXeaADifUQQ4wwGOG7pYCuMGG3XLlL5wtEaL1tITwAVtX85mTH2ttF7DG6Rw3dTzmfyKdS9QvQphQtNtDuCktDB39GWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=st-md-mailman.stormreply.com
 smtp.mailfrom=foss.st.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=foss.st.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/jWPdQ1PQn7QYGRe4YmcAhnL6IV2b5nYkP8Ta9zUFmY=;
 b=G7Brk5KauNRK+sIcQrUrgI7HbAMgc67TLgjJ6Jag3zOx3+UPkRpDyhn/qFT8VnM/kXGsFH++GHoJqGHKwFlIPg+VX1xsqshXhhDKVBANG9Ih7RIu2zVViHNbL5ndEu1m05gT1xWFNvzwp9exkRidCgOjV8yQR4L6eI6j/nD4YhqfOtpSt1qYTK/1FJJgSyKj/6HSaGeAFWe4J9XUO+j4g1tILAjv4dW3KGLc9tSGhASkbgGcnCkcqJHGLwM10o+3OSFJqB7symlKNfW724+eSd6d8ItM9E+WotvT+KsPWGncfk1bHEnj2mPdtLo8Sl7Whr8Xms2JzP0u90NutvAbVA==
Received: from PA7P264CA0411.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:39b::6)
 by PAWPR10MB7270.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:2ec::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Wed, 23 Sep
 2026 15:39:37 +0000
Received: from MAD0EPF000008B0.eurprd04.prod.outlook.com
 (2603:10a6:102:39b:cafe::a5) by PA7P264CA0411.outlook.office365.com
 (2603:10a6:102:39b::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.16 via Frontend Transport; Wed,
 23 Sep 2026 15:39:37 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 MAD0EPF000008B0.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Wed, 23 Sep 2026 15:39:37 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Wed, 23 Sep
 2026 17:46:05 +0200
Received: from localhost (10.252.7.7) by STKDAG1NODE2.st.com (10.75.128.133)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Wed, 23 Sep
 2026 17:39:36 +0200
From: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Date: Wed, 23 Sep 2026 17:39:15 +0200
Subject: [PATCH v2 12/14] arm64: dts: st: add ADC nodes on stm32mp231
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260923-adc-stm32mp25-v1-v2-12-46bc019537c6@foss.st.com>
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
	<cheick.traore@foss.st.com>
X-Mailer: b4 0.16.0
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MAD0EPF000008B0:EE_|PAWPR10MB7270:EE_
X-MS-Office365-Filtering-Correlation-Id: 0cb6d20b-b2de-41b9-c192-08df1988dfda
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700016|376014|7416014|23010399003|6133799003|18002099003|22082099003|11063799006|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	/nZ+AMHUXGpyiFDFGpQzf79lWeK6PyCfWkPe4/ptHqyJlcRbvywocHal/v+W/vtzE9q9jq7ZSlIsmjRq5zpT/uV+75CWyvf1tLZZwkfpgA0GT13/R2/hQ1kVBqM9ZQGP9mtcGoE/jGoiqsXyIb40ac4ExVTJegZLFyQe5Hi6c0ZP4qpd4XUw3lbEeCJSJNGsA1kzTTVuJo+2GlZqV1BmKSnq4aScS47J6UK6PCRR8xTUEY5vWIY8QpGZ2YV9KirLQw6Nm7+Aga+M8UZ6u+KaKru0QAStPuwZgjnXo0BnjTDWR0lLedFRD7LmzbAvYEQxFg0puTqZu4EW4mGsbryKqWWLmDJhpk9R5V+WrjJfLCRqXUKWyjIrT5HwVtmkOc+zPDms9+srEce/7v2eR2cn2Ew1PZyy8sBeOP2eIw44Z+Li/fW5nf4rGfpeHvW12XCudIJmVyz5mRF4p0cSKKTjBPh2qt3bZ8NwIG6EsqnBGwcevUPZ/Q9EqynWKRi9PUjs8kyobYQnfG2PDPkBxn2NeE6dTF5aoDUiNJNHR0r82QtFKF/vzvfGDX79ptpTrzgUYGG18wdTCwK0JI+4gODJ9k8AGtCNaRqyA0gnb26dDXP+Jl8XWvv9ChlQl6pU33T1KCH5o1PH/vJE5Ux6hI1RqDjDv0yizqxX4ZmJ38pS7HZnXuBhtSsEkZaBetL633o1YvEEsPrXlACvhk6FjZllrA==
X-Forefront-Antispam-Report:
	CIP:164.130.1.59;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(7416014)(23010399003)(6133799003)(18002099003)(22082099003)(11063799006)(10067099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	28zQwGKS+56Gcx0477uc0DJcCl49XQ5St3w7x0p+/GTbzxJGc6Uv7jGt2dcuQiGcrzxlsJvF5jf0bZOlGTSQZxwRQPNY/gwcLcq0qHKyIQLpmOghXNLmu/NDm0Q0QNS516vnVcgO5mhnKSC7WTwccV5TMuIMarNy7vUJ4PwIa+58YuJEMLOn8TpxxM3s/4ouyW9wMECtoZPto+P6KY67/BRFZ0ZwgEaidUYrnbqo0VHSJelcsJiGnGxCy5JrF8/xkA6fXMXPUgT437/a/CFlmAnx6VI2sKRGA+X+FKLLeYj98Ci9WuVqzw/9tM0to48vR9Tufjdd4wnJ09InGFeflupfQEl2OChC5vbVn6Y6nVfjl97ItOUxybkSGIiJiw1RI0sWnaQyMOBE/61KoSYo/pWnaRRoWXd/ovA2vUzo8uVXoAPvdv9/uhE03rnS/kKf
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 15:39:37.0632
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cb6d20b-b2de-41b9-c192-08df1988dfda
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.59];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MAD0EPF000008B0.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB7270

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

