Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010031.outbound.protection.outlook.com [52.101.229.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E039D377007;
	Thu, 10 Sep 2026 08:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789030599; cv=fail; b=YcBuyTSWyFaA1LOABDmGLEiXupfE/7+0GHsC/do8XjyM9J324v19XCITtYxOqS3rx8IQXi+65rKBiRJfMr/LixKsUPhv2JvIdDhYZJnqV0c+ME6PqotA2hVt3oUW/lf3ml5v8pAjBv4ue4BdBZmbJFaDgmYh+Wy8/mCxWrzfMN4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789030599; c=relaxed/simple;
	bh=E+X+v5xuvTJNTYLI25x1EcpqsaslTsjqLC12jaJ6hnY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VVSlZxPk4Fr/3bacCXAtZEY5xfeKttuB4ky8CZ/iSN5Pr1wmjVuNjlfYS7BewqdogomTJDBtI+dMZl3gEwaf3Y+0aU5UrUkvpGZOU5oBlIRGMjhazqWueVGg1dM8chmsike4DbWXQg/dVMB0xEF8JbWjrOqyBbxdbkvcOiAamio=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=I1vE+/Ew; arc=fail smtp.client-ip=52.101.229.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="I1vE+/Ew"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qB16dfjc8+WUYHEdxDaVSpb7DQ0c6Fvil9LPwkEA9ASnYWm+jaIT4hsD819YxwE5EdsaBx11Mf4HsN7YU43beAM4waVy6duto0uJSKiYIAmbI+gpLCPfiL8AV6zs/v0lUornF6HKK+R7z0SiauYJCp/MWTMaamyP04PTFcg7B9LDnNS7k8tC1mfBhGEfmRBSjxeeYCyLnxPGq/x/3Un5mcaPDTOj7UdQORKLjXHz5xJ82jk/+OukhEXUnfj8WXf9zNDArjFzsNzqXNWK6+OIt2mr19+ujihslJ6R3vDNJErw/nKgn6RJvM5FZRw2BJsyxHrvDV5X6rZQ25UO+51K/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JwfK4kooaRmmxLpn+B0A6Q/6auwt5PfKe1I3VSOjjNc=;
 b=YefVP822x+NsCPJavzYHAlIpDog6SFA/W4ijr3tkzUCYrMpNkx91oFqX1TOHejqKdsdl3yCHjTLt1aerpk1Ua19OyKfw4cwjnQHzN4Kh0ygRuYyr8LXx/CDnSYnJDam3DCE7N9cxST9PPkLJHDsp68pOym49KXn/NaPhhAMxDLEEGdcjJKuiWJ3igym4g9ptDavJoqOKJInevE8G11Rxk1dPTnnAeGgiITlhxwjz5unyY5DLUhB7NdWwvmEQwzqUdR96UtYqG41nq9xqqBHS+ZSKwzn8f96D+cCU4LXnc1h6EyfgtX2AdjGhUNL3lH+II0mZh92/qVNC9kZUnkhB4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=analog.com smtp.mailfrom=renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JwfK4kooaRmmxLpn+B0A6Q/6auwt5PfKe1I3VSOjjNc=;
 b=I1vE+/Ew69hjQUBxOeootQObeW9SwYWES8ykTNFEzJeSTSi4SNGdfh4zKZuvYoi88bxaYIufTJFyQGz2KwNYtzaPs01YFdf26Je6cQjbbHT1cmf/WyWBbEgv3AP0eksF+tgC4Aksw9wxCMyqk60slSVrVQj7D2VSUJoNeEsI9og=
Received: from TYCP286CA0139.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:31b::7)
 by OSCPR01MB13256.jpnprd01.prod.outlook.com (2603:1096:604:34d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Thu, 10 Sep
 2026 08:56:33 +0000
Received: from TY2PEPF00005623.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:31b:cafe::1c) by TYCP286CA0139.outlook.office365.com
 (2603:1096:400:31b::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.9 via Frontend Transport; Thu, 10
 Sep 2026 08:56:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.62.32.50)
 smtp.mailfrom=renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of renesas.com designates
 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 TY2PEPF00005623.mail.protection.outlook.com (10.167.240.54) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.5
 via Frontend Transport; Thu, 10 Sep 2026 08:56:33 +0000
Received: from demon-pc (REE-0064895.adwin.renesas.com [10.226.92.160])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id 15E3E3000203;
	Thu, 10 Sep 2026 17:56:28 +0900 (JST)
From: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
To: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>,
	Jonathan Cameron <jic23@kernel.org>,
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
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 9/9] arm64: dts: renesas: r9a09g087: Wire up DMA support for ADC
Date: Thu, 10 Sep 2026 11:54:30 +0300
Message-ID: <20260910085430.3173166-10-cosmin-gabriel.tanislav.xa@renesas.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260910085430.3173166-1-cosmin-gabriel.tanislav.xa@renesas.com>
References: <20260910085430.3173166-1-cosmin-gabriel.tanislav.xa@renesas.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY2PEPF00005623:EE_|OSCPR01MB13256:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: d3d35418-90f5-41df-bc1d-08df0f1969cc
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|1800799024|23010399003|7416014|376014|10067099003|18002099003|22082099003|56012099006|11063799006|921020;
X-Microsoft-Antispam-Message-Info:
	07ArrimO77AdVtvy7ajOTyfs8fa0KYrrEt2/DahTmBx4XBPJ40uFsPM2iqJxW5VqXtNo1Ls5u5fTmBtOOnsPUVtdQQD6BC+T3PMs41C7MgCm1IJe1+yb++cIR2ikGqT9MjcrvdsNbGVbYYe+1APLXZ+XxtnkN8KwP0Jp3HSuTkALkjDHXFnxAzcaZR5Ty+eU/x3mmTf6OjircgR/RxQJEoDp4PhTcrB5RI54mNxFKD1A3Wu6qFmha5sX8/LWBXojqLgNCr7lj+6zOCbFj79GN4e8OBQ4NqTIQRrCnZUj52tHhoEZxb+b62OhOJ1JqEBBBZgUBARxtuImjIgJNtyT5FkHJCfjsIYtSqCa+9RcnPo1J/wF+d8ZkTUsaL2D8zgoBl3Z0kJsVj1sMAEE5ivRO545jK7bmhWqrzaXFfIwyfFiFO5uGV23pHnaePGzao2vTEkRHpxpSjKS2JUfPSpmSsg3qWhYiPSNp7Besczkuk7X/Px4+4Hyd7vkYywjStdsxGdE+3lHRPBBDCsyQjmBlgeXNaRVqiNWW9+sKvK6mAmbmc8LEbjIy7PstOPI+8E9Pt9MtG7qRftyGcIVxfqM7IwhgTxP6CX3glKaUImJChftrT49JT4APjqmsWXifvxRBomn7dK0BMlP9TOzrC1bDDPvxlM9oV7F9gdzs9vauQzHU9CCpDhcY/mb7Iu2aN5ih3kRpf73yhouyGu/bS02SUUhfvWH1P9xfyw6ndXh06zBRnAX/fshhCX4ne0r6M+h
X-Forefront-Antispam-Report:
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(1800799024)(23010399003)(7416014)(376014)(10067099003)(18002099003)(22082099003)(56012099006)(11063799006)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	vY6j/Zgm+6/32fDG4sT+Z16HeVxcfnLNKYzCun6iCMwP/RHI1NPhKBGumt2i1FK2d4Vdz+CMGmn2Y0INsecbpY955DP39T0ii1/amoTgo/cmOEm3AGPsotVHfNzVLj2lz19TTQcMq7WR3dlJqtNqgFcDW7bZj5aVb6HmFMcXrTwUdORO9TfWXrTgWj+TGkekNMVqzDOYxKGH5snPmciu47Xt+uUPEppI4FFmEjzQTdZKrVaSW+ImJio9iu7FyYZLhu1sDzwR1nnoAKN5JFSay17s6dgl5fLlqNDxVy4qZ6pD1hcjotLzriOzEFZv6lbVAqNH0ooK/q9viTx+CspO2LfPxzBT+howC2t72mKSTCm+beGg+eOgs9LHg9Qseha6M22B4Lajgniw1fXeIXWEBJuv4nmsySnOno6/bCnLbw7yay6kKwZ2Px1Tlvp8Xioc
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2026 08:56:33.3034
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d3d35418-90f5-41df-bc1d-08df0f1969cc
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: TY2PEPF00005623.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB13256

RZ/N2H (R9A09G087) has three DMA controllers that can be used by
peripherals like the ADC to offload data transfers from the CPU.

Wire up the DMA channels for the ADC peripherals.

Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
---

V2:
 * no changes

 arch/arm64/boot/dts/renesas/r9a09g087.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a09g087.dtsi b/arch/arm64/boot/dts/renesas/r9a09g087.dtsi
index 437f45649ecd..c9acf37db051 100644
--- a/arch/arm64/boot/dts/renesas/r9a09g087.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a09g087.dtsi
@@ -1278,6 +1278,8 @@ adc0: adc@90014000 {
 			clocks = <&cpg CPG_CORE R9A09G087_CLK_PCLKL>,
 				 <&cpg CPG_MOD 206>;
 			clock-names = "adclk", "pclk";
+			dmas = <&dmac0 0x26ba>, <&dmac1 0x26ba>, <&dmac2 0x26ba>;
+			dma-names = "rx", "rx", "rx";
 			power-domains = <&cpg>;
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -1300,6 +1302,8 @@ adc1: adc@90014400 {
 			clocks = <&cpg CPG_CORE R9A09G087_CLK_PCLKL>,
 				 <&cpg CPG_MOD 207>;
 			clock-names = "adclk", "pclk";
+			dmas = <&dmac0 0x26bf>, <&dmac1 0x26bf>, <&dmac2 0x26bf>;
+			dma-names = "rx", "rx", "rx";
 			power-domains = <&cpg>;
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -1322,6 +1326,8 @@ adc2: adc@80008000 {
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
