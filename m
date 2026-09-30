Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010065.outbound.protection.outlook.com [52.101.69.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDBE051DE07;
	Wed, 30 Sep 2026 14:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790777983; cv=fail; b=cDDZdWHFqg2jSILjkIzdRrB5FYjSUN5ae6n/BbqXBnn/yJOPi2u+QcC7aEzkc9o3BY3hcP+ShYjWdYcXyI6x/Os8nf9PUttdyjoqPOgX8sxxBOPnI1JJwpDALcVjRAopOMQh14McieaagSVCiYr2Sue2beL6JrY5OF9qTEHyWyk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790777983; c=relaxed/simple;
	bh=ofv3T1N4qmCzu9rA/FMcqRp/pVU2nNvs3HqchL+FmH0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=Lu7YWBgHfIN4sqqUDLcnD61zJ57/gyFl9sc5Xv/VMCYVX4eilFhf/CeX2gr7YY0rWBbnTiRO+BXeLGzXFR6SUZ0MSLefcw1empYaB5P0n7bH5clfUVHIunXEbkS6DhYHqTQ0o6LOwJ43yGoAFUR8yAt586Tq9uOKiljcn4FMKBI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=N55t+xVO; arc=fail smtp.client-ip=52.101.69.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="N55t+xVO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yy1illZf8LJD2cXKuyKI/HeeN/uEBPLzJV0NJjOMn9Yj68Cdd/d+LpFRxnDN8QZWykZ8lsIyanjz9Wkfxi/ZhD+584GnAOdxufpKlCvDmx32dG0AtIu3T0dVRlG2qTf7hpBxpqnyhRZuX7Sp7j47Ir4gml3GABH14yQGtss3rjGjypnjXQXOP57klWRmSZFO9kx9LLnQApddT4dpOBZv44m3yBlngiu/ksp/Do85CbTNtVAEyHzTNV89EOAIBdeujt1DydzL2wDFqYBJo/E2L090S7wo4+rfn/EDW7OfhwT2yKdmn67/MLyFzLJO0Q0bN2b7hop7V7OCqAOXzSX5wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/jWPdQ1PQn7QYGRe4YmcAhnL6IV2b5nYkP8Ta9zUFmY=;
 b=HrgvTvM5TtS/6hZyYdBMxWxEAPBcIdUF+5kpsD1PqkmnWZ85n9r1SwHGYwFYUzPpo8yMK5N1ED+xdvGwvhaAwAlmnmcZtg3CE28knZIZZKS3aW8c/lDriTVa3V27IMHPqa+OcDEA0ua+fO0pzNeVAubR8KENaYHXpyJBuK+ZHVshC9vXncu0VZg6BR6zqyDdRJkoQxepXZbD7rP4yRdd2dAMSAafH9vdryP5qp2x4C8HVYLwwHnYe1I0j/A1V5N/XEpQxU3OQg0dSXIOCXgPeuSQAeGsYGcHE68WNZ+2GMmWyV+j52neF3E+wWi9wXsleFVuTGR+n581M5PgX2C6HQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=baylibre.com smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/jWPdQ1PQn7QYGRe4YmcAhnL6IV2b5nYkP8Ta9zUFmY=;
 b=N55t+xVOwRgLrV37WHatGcapjYy+B97nL4nBpTQYn1VQp/w3GotjIb0AVMJWnfkbgALCUZxFPwJ5KgtabV1Pfib/KS04D3qXERTp0nDjiMt3Ee5/bEoZNdk7OyPgN+RhWZfs6d1dsF0FMZD/pOGA2ieOz20F9OZBerQXTE3jbWEP+I8TqKvQQw+UygeeQZFxWXJKJXlBCXkjy8puilsUGJIhDxykPCjOfKCB8hetV3E9Jr49j0sj0QAlBrsC8FV0VBIRE640zx9nJN071qsSCu40qtpaczdAr0G6qrysfAYgxT+iUNRlj9I2QZ5EtyxREVjDv4CiKnwWvCZYQJnUmQ==
Received: from DUZP191CA0038.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:4f8::22)
 by DB8PR10MB3260.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:119::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Wed, 30 Sep
 2026 14:19:22 +0000
Received: from DU6PEPF0000A7E3.eurprd02.prod.outlook.com
 (2603:10a6:10:4f8:cafe::8e) by DUZP191CA0038.outlook.office365.com
 (2603:10a6:10:4f8::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.15 via Frontend Transport; Wed,
 30 Sep 2026 14:19:22 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 164.130.1.59) smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 DU6PEPF0000A7E3.mail.protection.outlook.com (10.167.8.41) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Wed, 30 Sep 2026 14:19:22 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Wed, 30 Sep
 2026 16:25:53 +0200
Received: from localhost (10.252.17.140) by STKDAG1NODE2.st.com
 (10.75.128.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Wed, 30 Sep
 2026 16:19:20 +0200
From: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Date: Wed, 30 Sep 2026 16:18:34 +0200
Subject: [PATCH v3 13/15] arm64: dts: st: add ADC nodes on stm32mp231
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260930-adc-stm32mp25-v1-v3-13-406834430d72@foss.st.com>
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
	Fabrice Gasnier <fabrice.gasnier@foss.st.com>, Cheick Traore
	<cheick.traore@foss.st.com>
X-Mailer: b4 0.16.0
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU6PEPF0000A7E3:EE_|DB8PR10MB3260:EE_
X-MS-Office365-Filtering-Correlation-Id: f49ab55d-05a3-46e8-4f57-08df1efdd301
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|36860700016|23010399003|1800799024|10067099003|11063799006|56012099006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	x49RGjXQaUpckmDbacdWKrRjlKdnyVaStxK0VxTF4QlwJSdUqqM8Ob/J6uTPKUAmJpM6QfRNWAMmE/0D8JHRo0/5vO92chySF2DibmIV2q17qc12jwMyQNIXr1sBVCurlZAgMpa8so5iQZBn5PaTxe7TqeSSMiL56MuwpPyuen3bzTyGtSUS5vAhrCQ5LI5jhGgGlJZYiIlggqY5wwSiyN28U+srEXNe7xQ3U9WVFOInk2xlsnPdIvsH3D5jrgVtGvRwGhJipVwAeJ18BegPLhWsOCFiaNwCHWtaGJr///uVKAiLpYDqdU+6Kv+TdrNQ5+dQo3e5joZo1YbqYdftaSP2k3HtA7L3HZHxrKv4Gsp5opknfa22znuaWyKwhDjMhalPQyu1sb7VmAgHpG4+8aMtwBowpUWy12WTjHfRFe0O4R0e2v+yiIhhmqlo6JbS4iCPH7etEr3JveoZOt4OQVxuLwZvMS8SOi4ze6T1OCkyvSXFM9QZmCcKObooebknZ+i+y7hXFqFzdY3Tq4QPomrMzxQox7RUlg1Jaxm2YjwP1KaVUtDoL0DUb7W1xPMS7vxp6rWjhSxTEaCeZS42mPHdXvHXF06rkEj0c5OFbYDYWaojnYyms/Et7f1aHd3cLAG/h6GLASd3nFDXyT7CNklL/ABJfUSgcttpIh9ojtInh8zn51PTc8i8JHz+i8SBwFgQaZzWL1X3xUnOPHvb2g==
X-Forefront-Antispam-Report:
	CIP:164.130.1.59;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(36860700016)(23010399003)(1800799024)(10067099003)(11063799006)(56012099006)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	SKY6sBK66M/X2yBHAPT0KtOc8GSYpi3d26ty2Lo1qsgAX/iimdlQOptc99PZOltGVi6CkDbWXBclhL1JYYMUXJ20wt5HdF4SSxkIJOCsCMZmaUP5VdEs8orrYOn7Jrmc51RadmYICFadM/4HeqJuiam90P9KjfA686SuoMxNx4hnWA8XQ1UXcGcY6+9B/SlmqQnI+a4dWLUCt7lT4xEHKI65+O498RM1rZS8bG2dLXWlBF68GMu1jnXzRSTkEjlv9XQiW/sgODh5QgQ3Ec4M32SCMLm0zySwZgHlqGXZR1m0+53ltsUbkmirfqObd/jc4Hwbv//dmQ9hoZyoILxZ6qf4jj+hysq5rLvK47aCFz2dm3GpfHKz7Wc6uecnbYGE3R7oj8XXdTiDFk/ZA1SPRIs5KIlwP9xEashM33ZR1zsenagsFLrFg/+UaNU2hxn1
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 14:19:22.4384
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f49ab55d-05a3-46e8-4f57-08df1efdd301
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.59];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF0000A7E3.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3260

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

