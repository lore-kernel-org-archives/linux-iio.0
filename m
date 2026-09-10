Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011060.outbound.protection.outlook.com [40.107.74.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 318073C1F31;
	Thu, 10 Sep 2026 08:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789030595; cv=fail; b=PAMjlXQKuIH2ymmhgXYB4KOUCzr5LS7q22llcV2AowE0BqYxkgUqtritKbPYo0toGksiHONvz1krkcANQPxVQxl87vwVDzoMf6vsLTgOk+fNgdQmgNdXlWgusPVAApooq+ku1+RF0/eUeQKo5bpYMnsvBFjeoeDSRgO0yHkvbK8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789030595; c=relaxed/simple;
	bh=jxjxh4Cl8we+R9F8NQugR8naxtU2FZRhlacn3GlZoN0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eXSb27rx/68sz26vKZIaF5s7O78m3IJPs9ylXtVoQ+ZZ43zon24rMimuB1UQ6GfJe4ChzKi4IPIwG3Aaq2xPvjr/r/ypJ/6QXXsKsOCHRf3rC3cm8vLlNFahz6QyDZWPSsrG9k1igZAiWZlpB7RYEElFq5HiH9kUA86uBBvSUNw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=N9hXC6LB; arc=fail smtp.client-ip=40.107.74.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="N9hXC6LB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LvocRzL0QK6z/okjIAmfj1RBLZPE67bIiATnJlEuB9eswXfj4ZEJ519vZg2wdkdKjjv/PM3pTlA9ovgupoZ0qZIrCNWPUeG6KCcYeQWfK1Q/5xxFkNDZUfWknd0lU5o2y0B20gwW+Xrfnm7Iw1MpOckVCEUnado0J3Z8OzHoi89qxvYdix6VBM229RcOtPpH937Dm+XF6dSFqLs8dCG4x01ESC04HUpohiD43cY931rcSBk/I4Sq/p/FsG1i924E5eCnUoZxakcNh7b2UMwhri6MNXvyntl/iduQy2VvjkQMOMGu+cbTQ9Ec9U6wLItXO1iPhAszhJIvLrm84d35XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1+QhvBphoN0w18jf3GgBnUThTLGRvCDjb6zvjQjB6r8=;
 b=aJutIyfY2Y6uTquEhOHxFaHNbhOfxj9ZbZw0Rkgx4+IM74jyvVKfCZrafiyRPjJ0fCoU7qAtfERGMjJY38FL7qM0OsX7k9qork0CTfLLcT/wASm6Euh0FqbdRscffZmLHq0YRzH/vFVW9Ic1Y93RE976vMPhrBSpW0x4yrn32k0a02jAELBWSWx+WXHzutjhWWTCANg5mKod9BtkRyh0KrdfvgA1xmIt/fy4wVUcFq1W+LCbzrYoeFQ4cC0gw5/v80tuY0qfBCxZIBXKQVb7LgEXT0Ye6yPNQrJ9l7C64JDD2p0uplq8VSS2yv4HLQbS64mEP1v/zyW3JgUuCvhhew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=analog.com smtp.mailfrom=renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1+QhvBphoN0w18jf3GgBnUThTLGRvCDjb6zvjQjB6r8=;
 b=N9hXC6LBCeKKAk4b4kvgzXKHDB3MYo6FP2+vSo7zvd1JNJ6ZZ4MkVESWLytWACzziXPpMo0CNpNYpegwdlczsNEYN5U81ypqxyoicvT9pCISilGrT+8ErZGaq5qChEgOSRwalvDs8G2Scv16W1nQ1dVyYhuC1a+NwBZkNNa1fAI=
Received: from OSTP286CA0013.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:223::18)
 by OS7PR01MB14761.jpnprd01.prod.outlook.com (2603:1096:604:394::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.8; Thu, 10 Sep
 2026 08:56:28 +0000
Received: from OS1PEPF0000D213.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:223:cafe::f) by OSTP286CA0013.outlook.office365.com
 (2603:1096:604:223::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.9 via Frontend Transport; Thu, 10
 Sep 2026 08:56:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.62.32.50)
 smtp.mailfrom=renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of renesas.com designates
 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 OS1PEPF0000D213.mail.protection.outlook.com (10.167.240.20) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.5
 via Frontend Transport; Thu, 10 Sep 2026 08:56:27 +0000
Received: from demon-pc (REE-0064895.adwin.renesas.com [10.226.92.160])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id 685903000228;
	Thu, 10 Sep 2026 17:56:23 +0900 (JST)
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
Subject: [PATCH v2 8/9] arm64: dts: renesas: r9a09g077: Wire up DMA support for ADC
Date: Thu, 10 Sep 2026 11:54:29 +0300
Message-ID: <20260910085430.3173166-9-cosmin-gabriel.tanislav.xa@renesas.com>
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
X-MS-TrafficTypeDiagnostic: OS1PEPF0000D213:EE_|OS7PR01MB14761:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 3a88ebc5-a459-49f9-f256-08df0f19667e
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|82310400026|23010399003|376014|7416014|10067099003|18002099003|22082099003|56012099006|11063799006|921020;
X-Microsoft-Antispam-Message-Info:
	fJOrQDsx/OkKcCgeMQ82M6J1ImD5MW2Kf7SpGCpnM+1Ko8rkVd1Px4f/H90O7wdZQK45BERxhqx4dF06nrq4fK5I/ZcXpzwAk6lhDKMfKLJxgdfmxWALPTQ9/Yw/w371JNSoi+3sKbNR/78UC3ookojxxZeK6+w7jHetd3mnHX/R/381qKcrEL2qtKSg0rIW0SXNANJuHu0wfTLcKUW87PGVdviR/m5vFc/wKgk3otx1eNDt1RfY+lDFFI85RpY+gFISov96+EdXf3SaKFSpPQOE9ZTgeyffsXRtQm+OYmNy8kiKcqWK6+Xm8+isn2e4/YK/1dM2riTrhf8rsX7dOcUZAclXRslvWxyas+RFt5qWnk33QzGrjtri4fyPJvm7dxyRtOel7C8GlW0MGtGAdz9Tas4nkLb7/Xvtjof9wkvX+11IOx/Z5W2OkBkLQlxjnPZ6CrAqwXrvLfIquyFuIwP7Q/wCwO/nsq+uz4UwkR8sHYP1BxOnwncJvZqyXDQ713+ZLqQcskBX1z6+YTqg6A3jlD5mvwSzEZnCQHg1dPYpcq7xD8hxvF6CCU9yqJD0OofpiwXucAvXgBYOS9LfcMHfYfhOb+Wsf4E2dYOBgF7bos2SBUyT/AiiAxFqPXHFObu7Isbum/e1M7IGOr6/c7+DN9XXwQ+PlyTjdQiKyHu1IF2ocObvS9OubLdsPBYfGpiU1ciJJHvdDFbjjBxCFzahFG5lH9iHjcGaeQsKqfnJYFuVBD6x8J/AXzCpxGI8
X-Forefront-Antispam-Report:
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(82310400026)(23010399003)(376014)(7416014)(10067099003)(18002099003)(22082099003)(56012099006)(11063799006)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Loe46bhhkrcTLsjZ7Xk6vWlabc3w2v8u8and+qGceoxHMarmsCdq/SQDFL8bnKC7F6pw7IUaUCc5QvRWwlcXgzhqZLzvepwoCGH9VIB6gEcUSkC8atpyRucJutFdMWmuLa7hm0iChJajrXYQUJYpkmTc6TxycLeaI4/V0i4l0DB5VS2S7o1JO8FWcX0SHwHHYjTPAxcicSXaWBsQhsR+CeIJVaRhWAYK6YRtMywuPhc+WpFsX4DpXSIyApf0UvU/qGTAG+NkcIoa6dtYYNqaTHUqsLkrMLYxzzjnAKZAdOj2GR5i1w4rgmBOL9Ym5xL2yh2/EdqLudcsHXoah1qWXYRv8WzRAhH51mHS80is0rxnhV3uuXTZ2qmlCf4JYFEJWYI6Aw2FTeiRGgQu8OAFaQ8bQjCEim1BwJAiumd2T2CyaxC4ldAfN+YvxkoNqaLq
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2026 08:56:27.7477
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a88ebc5-a459-49f9-f256-08df0f19667e
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: OS1PEPF0000D213.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7PR01MB14761

RZ/T2H (R9A09G077) has three DMA controllers that can be used by
peripherals like the ADC to offload data transfers from the CPU.

Wire up the DMA channels for the ADC peripherals.

Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
---

V2:
 * no changes

 arch/arm64/boot/dts/renesas/r9a09g077.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a09g077.dtsi b/arch/arm64/boot/dts/renesas/r9a09g077.dtsi
index 42883338a6fd..5ea10361e300 100644
--- a/arch/arm64/boot/dts/renesas/r9a09g077.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a09g077.dtsi
@@ -1275,6 +1275,8 @@ adc0: adc@90014000 {
 			clocks = <&cpg CPG_CORE R9A09G077_CLK_PCLKL>,
 				 <&cpg CPG_MOD 206>;
 			clock-names = "adclk", "pclk";
+			dmas = <&dmac0 0x26ba>, <&dmac1 0x26ba>, <&dmac2 0x26ba>;
+			dma-names = "rx", "rx", "rx";
 			power-domains = <&cpg>;
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -1297,6 +1299,8 @@ adc1: adc@90014400 {
 			clocks = <&cpg CPG_CORE R9A09G077_CLK_PCLKL>,
 				 <&cpg CPG_MOD 207>;
 			clock-names = "adclk", "pclk";
+			dmas = <&dmac0 0x26bf>, <&dmac1 0x26bf>, <&dmac2 0x26bf>;
+			dma-names = "rx", "rx", "rx";
 			power-domains = <&cpg>;
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -1319,6 +1323,8 @@ adc2: adc@80008000 {
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
