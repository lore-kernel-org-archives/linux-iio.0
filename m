Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010035.outbound.protection.outlook.com [52.101.228.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 841F94734CF;
	Fri, 28 Aug 2026 15:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787929301; cv=fail; b=U7t2l/4XAMl12E3cGWodeuBmR3SaK6aR1CMwtV+lqwscnb5EiWdUZ8PpPW3Q6lZKU44T6MW3HPXCNV90O6wGUDvhPxQUOlzhs1bzy4k1gz6ttp/c08y3ysgjYMJkcymBTGG+H0YJMXPFL7Kz3ZGqQcRqYRBuS1SFyvP09WqNDys=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787929301; c=relaxed/simple;
	bh=XYHRbzfH/8+3wI5VJPVifzfNxPjn8ItsMbJd8Da6qPE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QmjhnhKliGnWDL8uP52EvgKB3nlQDisFiaqM9jcpYMec2Yi32kOzqMIY6eN2GlbhjAAejyGZvUhXc/znIXvgulwctAZZxHDDL8kK2st6wY9HfCukbyrTCvugS4upW5EpVnPvQxUda/OF3lE6qH86ZQdK4MGWPExcC2frlpXALQc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=BYJSWPvh; arc=fail smtp.client-ip=52.101.228.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="BYJSWPvh"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iVLLdPpbRMGjSvf+qMff8SVroCQq0+tp6yVlIYId2AQT2+XeW1HS+ZEWmHTROYozUv4yLckutTq6Tl07IFdmiYGIbxvpD1HEZCGojjO83fx/lc6x5qhq1bPSzJerPL06+eHtyCjeLXZax4okZMp+lWQL1MGZYIJZT69fLqcNoKyQVG0AzQ5b1IklHy2PerFPQyueoNsvCuU+VLhmdDbMuxvadcU0WxGA0kl+W28BScs6vux6MZ2lSL5FSVY1KXd+tNzWf5KqYqx57uzaTG0lE3zB6ceVT0Qb1jZgVE7NOiWFQz2xapLZ9URRr/uS+OQg7mAaek1vK1KdvpM3t9rMww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/c8CKzMYFJ3y4sWEJj+nTFdkCYeFIADt5pC7ovGsTbY=;
 b=pu71bD49rtSsOQCFaDXjWMusDRCY7x01mQbikgnWIcKrZ2SA/1vfNT6MhNW+fA+OuSCFq9OCR+b9TxlojFQNXi+8F45hnYxHhuu0r4JLZ+4x9LvXshXwT2fIMU7M4+hFW7OBwRujTdfLVp/TulhuuWyTm95w/FbotHNou7ucOk9dUIWEQ/6qpUMBh8DXnH/FC/TEd/69mSJLn0YNlvFxfxg5nXjc/7nzTIrwFd6jLo5bD2pJIY5KhlwrXZuDvr5f1687X6snycKesraEwHcsQC93mbdhLyNQjotumdaZSjH7vH2ngz6NOxacn5osgJdX4DxZNEFCR4g2i8wX0jl4Cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=analog.com smtp.mailfrom=renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/c8CKzMYFJ3y4sWEJj+nTFdkCYeFIADt5pC7ovGsTbY=;
 b=BYJSWPvhO7zMDchKt8YNddKRK14p3TTwWODXyXXM8WjyiRVjnzPjMLzbGW1avqsc9aVgqHOJzpehBkRCQLo3wUtg+EaETekAZlnDB0Uu4pR8asOeVhqoog7cEfOzalN3959Rh993eBvdC24jFOj/shgmvYpc1pKwwSKQk+DGikI=
Received: from OS7P286CA0016.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:26d::14)
 by OSZPR01MB8155.jpnprd01.prod.outlook.com (2603:1096:604:1a6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.11; Fri, 28 Aug
 2026 15:01:35 +0000
Received: from OS1PEPF0000D20F.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:26d:cafe::6b) by OS7P286CA0016.outlook.office365.com
 (2603:1096:604:26d::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.11 via Frontend Transport; Fri,
 28 Aug 2026 15:01:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.62.32.50)
 smtp.mailfrom=renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of renesas.com designates
 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 OS1PEPF0000D20F.mail.protection.outlook.com (10.167.240.38) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.8
 via Frontend Transport; Fri, 28 Aug 2026 15:01:34 +0000
Received: from demon-pc (REE-0055761.adwin.renesas.com [10.226.92.7])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id EE3CF3000349;
	Sat, 29 Aug 2026 00:01:29 +0900 (JST)
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
Subject: [PATCH 8/9] arm64: dts: renesas: r9a09g077: Wire up DMA support for ADC
Date: Fri, 28 Aug 2026 17:59:41 +0300
Message-ID: <20260828145943.2077589-9-cosmin-gabriel.tanislav.xa@renesas.com>
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
X-MS-TrafficTypeDiagnostic: OS1PEPF0000D20F:EE_|OSZPR01MB8155:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: bc1c4b2c-e593-4674-4690-08df05154091
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|7416014|376014|82310400026|36860700016|10067099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	n79XUHJLmXXyOBHASOJp3SZkU1au6P531dIjItdJW90t5nbMcGSegOQLDGJQqOwyL8v5ZVqimPfQbTZpFHrcauRPReiBsObBC4NPNdQp0m/VJQ0wcwOUg4fdoo9hDgZiDiz66ujhMEgcCvSeuZrjAJiCgIHwnhlWTFXRkC5UjnPy15AOpqETdFp1kN1MAgiDWbyrI1lGDWMg4H2D22raPpKVHA7lrBHM8/BYX8/LWyIWPrU7Fv89Z8DJ6CJp5AV0L9D7tydBGErrwqKg1OywA0AaRPxcsZCCIxvTCUOrw0FqUrOSha7yDUKieM8WGYclayfULQJ936LrFYfYX1WP3mDCFJS2+TGMI4ikYx3gOq+JW5VXyqh2vTlkJfjK/EFPtiqG15H/SZ7QZGvuOJhsFQfb+nFKyr59YqXFglb2uKtFlFTOmT2TeNVdEoray2N7tAPq5atOwmYUOGaojwibgX2DK2nOxgOu35dCqliefFZav0R0GCzIm5muwR2mEi7fqx/MhTFI4JqfnIEOS3n2FytYqw2yV7TJ3y/muJIvkk+VijWTkDlxsytwYXkUx/p6RqBoAuXBjA6Ett3jtT3QLSFtvj9oi93Dk1Vplfyhg74WAPzL48peF6X1rQtVzary4OmFsxUmSjy0YtSdTZkg55VdSBP3XCLUPGnYLieg+7Ah9JvoaeW9/y3CWkdJMK6v1TstpxZ9UOfoSIHUW8IKKw==
X-Forefront-Antispam-Report:
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(7416014)(376014)(82310400026)(36860700016)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	DPuNSF/N5UAejeD1zo6uHZW39Q8zRMmbFsI2Jcw7CyPDMRCp0MvlkYHigDOKEN407II9MBhOE1OMmQDbk0E6l5E0XNesu6qRwoKdxy8BE/H9hjmsuJKOCGnhspeLlolYE0FJkHgSIhtp2tpkdq5m+3qIQ6QYNM0CgYUvayE1QyJ4sow51XSVgrgFDkrYIgWchVimG3LFxdZsi431JmB++PmLkrJPwD/hRjlZgY+H2hqUt1813CMnizAC7NMK+4NnGy9wPrBAw5N3hkS22Vlrt/V9Xi7CqbNjeAnmtYKwRn6fGCmKaYAGe2kYazZGvSRhuvRk1d5bzcg79W+od5pWyRqAdzd8rbgUSw9oVZW3ZMyK/UfMBEVsFR1PCBXuMgO6wk9VXG49ctC6Yrli1iCf7asfW9HuB/BrUoSqAKPuWafCDxPM1zMRonTn+gP756r6
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2026 15:01:34.4989
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bc1c4b2c-e593-4674-4690-08df05154091
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: OS1PEPF0000D20F.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB8155

RZ/T2H (R9A09G077) has three DMA controllers that can be used by
peripherals like the ADC to offload data transfers from the CPU.

Wire up the DMA channels for the ADC peripherals.

Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a09g077.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a09g077.dtsi b/arch/arm64/boot/dts/renesas/r9a09g077.dtsi
index cd34df024769..f54f8d640f02 100644
--- a/arch/arm64/boot/dts/renesas/r9a09g077.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a09g077.dtsi
@@ -1235,6 +1235,8 @@ adc0: adc@90014000 {
 			clocks = <&cpg CPG_CORE R9A09G077_CLK_PCLKL>,
 				 <&cpg CPG_MOD 206>;
 			clock-names = "adclk", "pclk";
+			dmas = <&dmac0 0x26ba>, <&dmac1 0x26ba>, <&dmac2 0x26ba>;
+			dma-names = "rx", "rx", "rx";
 			power-domains = <&cpg>;
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -1257,6 +1259,8 @@ adc1: adc@90014400 {
 			clocks = <&cpg CPG_CORE R9A09G077_CLK_PCLKL>,
 				 <&cpg CPG_MOD 207>;
 			clock-names = "adclk", "pclk";
+			dmas = <&dmac0 0x26bf>, <&dmac1 0x26bf>, <&dmac2 0x26bf>;
+			dma-names = "rx", "rx", "rx";
 			power-domains = <&cpg>;
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -1279,6 +1283,8 @@ adc2: adc@80008000 {
 			clocks = <&cpg CPG_CORE R9A09G077_CLK_PCLKL>,
 				 <&cpg CPG_MOD 225>;
 			clock-names = "adclk", "pclk";
+			dmas = <&dmac0 0x26c4>, <&dmac1 0x26c4>, <&dmac2 0x26c4>;
+			dma-names = "rx", "rx", "rx";
 			power-domains = <&cpg>;
 			#address-cells = <1>;
 			#size-cells = <0>;
-- 
2.55.0

