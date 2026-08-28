Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011062.outbound.protection.outlook.com [52.101.125.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE60C4746B7;
	Fri, 28 Aug 2026 15:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787929310; cv=fail; b=BTe64jzvycF3fs2kSxnQC1l3nO+LzfcSfPAqARj2RY9ranMwwHUdroKlHgd7htacFyoHcu2Pf6TY1eVesMn5O5OdEjGp/AjdjQRaU9i26bs+GM+dGMMWs4AveH0tyjpPiNc4ZT4i5eo6Oi1hx2sH7e+A/9018Nd0HticoId6tFo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787929310; c=relaxed/simple;
	bh=qhJfL9ywqUS2u1L+mgZ1PbO801mkFH82tI/av3svtyU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P/KTZsG1FIY3xFor4uf2Ri1Rx6xvFyAhTpX2aI8i4HGZfLSWfKsbhwQ0F8YIKV9/4pJA0xnf+e2+57lCDekWGx6HUH1/tavob9KNPPJ3pHnyT5B0BfVbOBJHRDoffCE6Ey03u0R31Dx0VyaT77vFhdFr1fToqeVq/kNhw0dqiwo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=izHiofc3; arc=fail smtp.client-ip=52.101.125.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="izHiofc3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h6guTz2XdECwipyjDsIOVpHMvBodFGnf4Bi7DtkzawS9/bAo7PDEggyUQU4254eCTZ2xiHrIP5p0zl9812KIb3VaJpOsL8HP73u5rjCQ9ba4K9ELaBVJ6zGtyaqP4eh9LeyKfqSbtcWfnW9C/N2yGMLYWzXD9alK2tHA50IIqsvrUJZ6OC+xMTiKNmkjYUNSqlkYXxvClrKZYB2LtnGweY4EkqMqt3qAmKerk4Naq2uF9C4RicFbqoZBu16fGCuRMROfY2IFJ0kKyxOlGvxHkriR3yWPsNlgvlcpxhWX/LSRGJfc5mZ1HUki5yi7L4423q0RZdf+VIFMn/rLppwAfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UpRk999ug27BIfB19CrWOgpoiw5g4tvs5euo+DO8+Qk=;
 b=lZTR4HW1FSJlC3aQwY5f56EWuqQxnjbyaEG6kHqXjB3rCHpHIMJi5JZwZMfnx4NnNy6huwlGI2jp3pEJwwanoB/zXQmll9WouyJG9qDJHzs6hN8O41gCgRIZ88eRuUW+anA77YvgvMslUaBDUPsQTKtzTGzSedqS3kkAlK4lLooUtruB7M+Oztn+Gq0y7OrEfRLmQIEMY3veFFV+639dsoO3oJWGGRVSef2PbrO6j6NHVblhACbaz6rJQ5fIgOtJBEgFTVmg07vUHM56ns17C3lUSPRtXEnflUtem7xjTCegYBVX6Mt6jJF6KjCFFk5z6x+2fwk+aANcu3v36KEhtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=analog.com smtp.mailfrom=renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UpRk999ug27BIfB19CrWOgpoiw5g4tvs5euo+DO8+Qk=;
 b=izHiofc3mKpPKRgZoCFIWI+bHaqLEZNlkZFlQ5Q2ByUg74uXS0vNGPx0L3bP7bTAt9d75Yto/oE5VLuOcTVwQOshzE+mciBotcpQTKkSsoin/PKBZv1e0/MFV2qd5d1C0lsjl1j+awspTwaBJmE58RsG7SzzzkDY9w0/WouBL3M=
Received: from OSTP286CA0001.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:223::9)
 by TY4PR01MB17211.jpnprd01.prod.outlook.com (2603:1096:405:333::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.11; Fri, 28 Aug
 2026 15:01:40 +0000
Received: from OS1PEPF0000D20E.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:223:cafe::42) by OSTP286CA0001.outlook.office365.com
 (2603:1096:604:223::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.11 via Frontend Transport; Fri,
 28 Aug 2026 15:01:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.62.32.50)
 smtp.mailfrom=renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of renesas.com designates
 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 OS1PEPF0000D20E.mail.protection.outlook.com (10.167.240.37) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.8
 via Frontend Transport; Fri, 28 Aug 2026 15:01:40 +0000
Received: from demon-pc (REE-0055761.adwin.renesas.com [10.226.92.7])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id AE13030001E6;
	Sat, 29 Aug 2026 00:01:35 +0900 (JST)
From: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: linux-iio@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Subject: [PATCH 9/9] arm64: dts: renesas: r9a09g087: Wire up DMA support for ADC
Date: Fri, 28 Aug 2026 17:59:42 +0300
Message-ID: <20260828145943.2077589-10-cosmin-gabriel.tanislav.xa@renesas.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260828145943.2077589-1-cosmin-gabriel.tanislav.xa@renesas.com>
References: <20260828145943.2077589-1-cosmin-gabriel.tanislav.xa@renesas.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS1PEPF0000D20E:EE_|TY4PR01MB17211:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 01691fe5-0ff5-4caa-a832-08df051543fa
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|82310400026|36860700016|7416014|1800799024|376014|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	3FmBCBzPDS9tNrs8IUtdxI6eDxjFCZAfHq6BCha8gr2FQMcGbZ1y8TyXjnu8mOrxXkK3RJIo4he+1w5XsKEoXmcooi3X+YE4JB90gqx/kLswEDkgnk/Oe+OM2hA8gagv0VgX8yVeMnAqNiMcorFaUCBvhE/2FMSHKV4ZmMMKjB99VjWW5O7W+Y7GBxzgdP0CwMQrffWc7CUDJRIkWt7SnOTZKlVXRFueCbh88Bvf+cC4txpoEu2P2uOn+q0MHWYQevVBB1mgzRefFr3ABRKL04ir39BFNLT74lW1fyta9wd+KvBk7EawmgXBfZTJnEgVv5zCq/UD+P3/3YRsFgnTpUIppBLyVEAKNyBf+ClKRhzqH8sSarJdMmmfosF5b1FCJaqrr2JIvG0HnpROFjL6TeFHXVlSSNSlwpQuKfkZ2zxUzLr1ahZ0yh9prkx6Hhby3iquqmM1OZGqe1dxVMRq5oAuyQaiComp/JxwcEaERp6yAJEcW5ZLeSy8jZE0KTVR6q+uo6wM8b3uHKcDHNtLqEluoegL6y9DDSaicXbDJi2BTPlfYcujGTPlk9k/ZNawb7qAeObnkcFkt9Cb7Y1F1ZEwWfkI817bNW9jTlJjPEB93SjDsgchx2pRtmm357mPs2Jf3RKgozIK7tXFZS3ZRa3A5Kg9QIRMwyCuT6EASpmGNOfmGEl7DBQNXcxeRjodm8q+YTEkLPxRltnNSCB9MQ==
X-Forefront-Antispam-Report:
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(82310400026)(36860700016)(7416014)(1800799024)(376014)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	N3pVX4S/Px/1KUttcXct3+Qd5+6xlGPbDJtAVzDFzJNAAieVDbCRhK6/4weoV8poibZmWmCx6nRK2PFZ/nuxgS6+hrmkJtc3VGe1eNyeNgoVlxZ6ladjutbmhlCwM1hNeuWgkadDWwfcHwQpLacu+dym7D2px6FFtUI0zXL047xzwqaz7Q7WrqajRtAtmi4hd+TFfCOaJ58aMPrn9TTbLYV3XPbik/0SZIGGDsVs2JddNT9qNhu8wFGHBCPW+fJ9tIjDf8w7/1sQaXE6J9GsBNfCKovaobWp+6tQGGjJi0xHz+jalvFZbmBb6jLSv0GgQyu6gR8vmAJ/ROT3ZO0x6fdv5JFGHD7WhdIjN7InvL4PaQ6OiETu93F/h2GNwoACu08syzgdmc7NothFBsRILkPzy+JAVHUVzHvVSXoo9u6TmAk7dGkdOC9LE/IqzmXE
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2026 15:01:40.2219
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 01691fe5-0ff5-4caa-a832-08df051543fa
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: OS1PEPF0000D20E.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB17211

RZ/N2H (R9A09G087) has three DMA controllers that can be used by
peripherals like the ADC to offload data transfers from the CPU.

Wire up the DMA channels for the ADC peripherals.

Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a09g087.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a09g087.dtsi b/arch/arm64/boot/dts/renesas/r9a09g087.dtsi
index 57ac38df3e51..9e8c6610f0da 100644
--- a/arch/arm64/boot/dts/renesas/r9a09g087.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a09g087.dtsi
@@ -1238,6 +1238,8 @@ adc0: adc@90014000 {
 			clocks = <&cpg CPG_CORE R9A09G087_CLK_PCLKL>,
 				 <&cpg CPG_MOD 206>;
 			clock-names = "adclk", "pclk";
+			dmas = <&dmac0 0x26ba>, <&dmac1 0x26ba>, <&dmac2 0x26ba>;
+			dma-names = "rx", "rx", "rx";
 			power-domains = <&cpg>;
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -1260,6 +1262,8 @@ adc1: adc@90014400 {
 			clocks = <&cpg CPG_CORE R9A09G087_CLK_PCLKL>,
 				 <&cpg CPG_MOD 207>;
 			clock-names = "adclk", "pclk";
+			dmas = <&dmac0 0x26bf>, <&dmac1 0x26bf>, <&dmac2 0x26bf>;
+			dma-names = "rx", "rx", "rx";
 			power-domains = <&cpg>;
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -1282,6 +1286,8 @@ adc2: adc@80008000 {
 			clocks = <&cpg CPG_CORE R9A09G087_CLK_PCLKL>,
 				 <&cpg CPG_MOD 225>;
 			clock-names = "adclk", "pclk";
+			dmas = <&dmac0 0x26c4>, <&dmac1 0x26c4>, <&dmac2 0x26c4>;
+			dma-names = "rx", "rx", "rx";
 			power-domains = <&cpg>;
 			#address-cells = <1>;
 			#size-cells = <0>;
-- 
2.55.0

