Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011016.outbound.protection.outlook.com [52.101.125.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A7893DD87B;
	Thu, 10 Sep 2026 08:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789030581; cv=fail; b=RZkDAdP4MyjcFCGlEPKxutQzgGfzjeOG7LsCuY3znosBqfvMFLIgKXkhOUJRq/0T0lWTBmYYmbyhV0jTzlvxO6gO/IRuYvnWMJbgtz2EbTA8uMKVbi1apr0sWXIlVXLPVJPykl/7ahn+Ff4xoyMpGw1g/87KG7gOoVpnyR1+FXw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789030581; c=relaxed/simple;
	bh=SVQBYhp8aj0rfLYFKk1RzYVBRmgvQEfCTATnjq/Jba8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tDeRQaD1otyrn1o0NC0oCBqf6OOe4i7y9drkaqaSW4GyJsexe/4rQrlc8XA8/CA8hgiogWrNc59u/NHyrsVrXgms05ern0mcwzigxXwgr+TcwE94HrtK1ISDu9KHjElR60FJ90WNE3k3Stl9C4rCIFy41TnaX1G7ClARzS8kgiY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=nmfKcDNb; arc=fail smtp.client-ip=52.101.125.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="nmfKcDNb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EzpJcBiwJXNE5YadEfEwy1bj+i3PJ93K4yYOCMmhLxAPmTgXQSmKJ0A3KNMmh6LSJ/iX5md+TPVhWqzZSHFQOC4fJMXTKCHcifOyXRBTxWTPr0TRR+rT4N/cgDm8vXAMPxf59qB8wdeiFbKm5L4VetFptSyti1RCpAY4d84UYwKJNz/QTHoIh9oyI0BYmns6aEA6YEgW0IaF0fHOw4/TmArgspY7HoupYvbo02FkJCynHgFadYXonJdfb9RWss/m0L91HKDte0NQbQdAA9Luk8l0PvFPIo3tOXTAHj1i1kndmRNUTE0SMQYCGPhohHwiqW5WS40i2mtrFsnYdnnFnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q97LR8A0Ip0Ay+5lbXFQ9h7q0NjHmwuyXZMP8hkuGvA=;
 b=FJuSujpVlL+gEdArwqM1xTz8H68pI7Us/KhMmkRTXM23c1RwI9+G7/aLcPzPal98VyYEjXzm31DpbGbgn+pGuuaBaTiSxQ6N6eXS9E3cT7GJhscish4ATjpYe/Otq+pBpvW+4PKkMstgQDXUUXgeV8aVicvqQLh2O0PbBqnObQ6mSwrH0RHdnO8+NMB1D8Wocpz1a0WRMNaJhCsxC48NcKaW0CnsMW4qxXj27UZgaaMLvBSXthPtaYxXyt0f3aWQsa3EAi6x0lJtl78ddvJL4MELyklG9KKuVapX7B8npi4SuM+mX8TdhhdyUsu7FRCE/TeJnyrE3DywnFlHq6DSTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=analog.com smtp.mailfrom=renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q97LR8A0Ip0Ay+5lbXFQ9h7q0NjHmwuyXZMP8hkuGvA=;
 b=nmfKcDNb43o4Zz2Um6SNQWzzF6BsEQucatlm6SUT27kqErJw+fffpQ7nQiZ8YRz0paVBincvSs99nV9zWqC3eYQRIsuj7T7BatvKMA4y8wmlBCfwjcqbHO/9TiZAs+rHT3LaZ7hvDA5Tz+mcgmjySutm8q4efVqFG5GGScZbN6U=
Received: from TY4PR01CA0113.jpnprd01.prod.outlook.com (2603:1096:405:378::7)
 by TY7PR01MB17189.jpnprd01.prod.outlook.com (2603:1096:405:32a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Thu, 10 Sep
 2026 08:56:17 +0000
Received: from TY2PEPF00005622.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:378:cafe::46) by TY4PR01CA0113.outlook.office365.com
 (2603:1096:405:378::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.8 via Frontend Transport; Thu, 10
 Sep 2026 08:56:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.62.32.50)
 smtp.mailfrom=renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of renesas.com designates
 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 TY2PEPF00005622.mail.protection.outlook.com (10.167.240.53) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.5
 via Frontend Transport; Thu, 10 Sep 2026 08:56:17 +0000
Received: from demon-pc (REE-0064895.adwin.renesas.com [10.226.92.160])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id 857613000203;
	Thu, 10 Sep 2026 17:56:12 +0900 (JST)
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
	linux-kernel@vger.kernel.org,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v2 7/9] dt-bindings: iio: adc: renesas,r9a09g077-adc: document DMA support
Date: Thu, 10 Sep 2026 11:54:28 +0300
Message-ID: <20260910085430.3173166-8-cosmin-gabriel.tanislav.xa@renesas.com>
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
X-MS-TrafficTypeDiagnostic: TY2PEPF00005622:EE_|TY7PR01MB17189:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: a13495ee-35e0-42aa-3590-08df0f196018
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|376014|7416014|23010399003|82310400026|56012099006|11063799006|18002099003|22082099003|10067099003|921020;
X-Microsoft-Antispam-Message-Info:
	eQ7Zgamt+szpMU8YtfdPdMHlmc2M5Ta45EC5Enm6vlFib5zgxkOXqJef+4iZ1wSg4kvo1SBkaNpdWMbKZDRVEYvDiR7BHoTGQwQfx4VEJ490+l01RKGIanDPkKvkrpgchea94h/3NcJM8zxoEYDxBvdd+pnP0mXeOyiLG8TXZ+Z7VrREtVR0eWGqyU1mxLIRDCeI8B1P5HW70yyTKtTM92pk3ybWzFx/KRTcAYOsUcPtGnojr//vYEuc+YAgtvsxlFnlbgccMaSTGLFnovVPZlrNxHh0yiCG8iQD3ewMu3b282QwDmHm0T69jfg/xkOZeumRTl/UVjJpH6T9L4UKPloJsBSateJNfvCgiZWAVvOdhOfGDM9HsfJjVfavl9vd0x/U3EzFVthT+F4yS6ynNJ3XcJfLP0jAhIegrhbirI7mUlAOusf9XFUU+4rWagpJRDjRe9KNTap+3JW6TjCKrw00LSNB5Nm6gynvR0+GvmIsULAGDWoCUxAbaedqQDFQ3TYd1f8U84EIQHRGKrwvKSGGcjKrsJU+1ebajxWBgUiCmk1MU4XCiHDxjItNtn6yZKTinuYDefukLLylKS+Df3jO/ZA8AaHxXbQvjztvj4998HjPfvlEjsVjdmLW2X6fgf9MACZipg9JogkHfX5Yv4hMz9LD52lhnpYHuUjooS3G5Lh0zVfMP0Q4OuuW2Ikx6/GFBioSH4bSTzybcNMnzU/eMWINtbKIa2aCDU3FI8XnCZwCXsGnj2CyW77pWe67
X-Forefront-Antispam-Report:
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(376014)(7416014)(23010399003)(82310400026)(56012099006)(11063799006)(18002099003)(22082099003)(10067099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Xp7JehBf9ahFALJhraZsDGLYiboGFUOXtsBvxCsqFnHLKsCCLvvfLY+SpwZeZj2OPOqtgdzwsC7bhmZXuGBT4krdvGP/FanBbDAQI0bhcH8GLzR25+C9JKS+kWpSnaYNpT8ccZEzNB9pfSO5MEi6dUzdn3mJYqPoHV5yMNxs8jNdydG3bD6weBs9VBLZHJwyUMG8XpviZdMdc/7LJYgGg/6moxLbpdxC3sY/TCZDyNr9XcdAitLEInvOKsJ+lL3hlAfpOEsvPw15ENKh1m91E2+PhP5IomwDEHREQfRpeYyEHG6l3WtuCM3ZEbpfmxMrBOXJIph5ki0wsjakfNMyd99nK//prpLrhOgSyOmA+C19Y3mnvn0eL+4PNZ7/zyleLxCsQguE+9H8PUkV0lLURbijuHMbpEFu8NFd3mYZJEJ9KhxurK7h+jK4lhA9Z+HA
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2026 08:56:17.0194
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a13495ee-35e0-42aa-3590-08df0f196018
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: TY2PEPF00005622.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7PR01MB17189

The ADC can transfer conversion results to memory over DMA.

Allow up to three DMA specifiers, as the ADC conversion DMA request can
be routed to any of the SoC's three DMA controllers.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
---

V2:
 * pick up Conor's Acked-by

 .../bindings/iio/adc/renesas,r9a09g077-adc.yaml      | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/renesas,r9a09g077-adc.yaml b/Documentation/devicetree/bindings/iio/adc/renesas,r9a09g077-adc.yaml
index dc0206b28231..4b5934ac296b 100644
--- a/Documentation/devicetree/bindings/iio/adc/renesas,r9a09g077-adc.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/renesas,r9a09g077-adc.yaml
@@ -57,6 +57,18 @@ properties:
       - const: adclk
       - const: pclk
 
+  dmas:
+    minItems: 1
+    maxItems: 3
+    description:
+      Must contain a list of references to DMA RX specifiers.
+
+  dma-names:
+    minItems: 1
+    maxItems: 3
+    items:
+      const: rx
+
   power-domains:
     maxItems: 1
 
-- 
2.55.0
