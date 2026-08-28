Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011041.outbound.protection.outlook.com [52.101.125.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 261B8472F60;
	Fri, 28 Aug 2026 15:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787929294; cv=fail; b=EGgGDc8CMN4xzcLACCtyFbBvkXTbHT8ezsnpsoPmfbA0hrb11dwZb+AJWP0CO47PwjIB0q1O0K9anxC1vlfMKlp+MzbzS8QLofRdNVvOEACj2M6mRub2XyNphGt73JOBs5znwZhvU4oeUxSbhGf68Z+JeZ4hEkwQ94BhBOVP9tI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787929294; c=relaxed/simple;
	bh=2fU37cj3up0wpUZc1ItOqEouwnw0erYsArmj8iIHkYk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gl2VWuNJuT7tXFNq6zv+C41/KIdfDhOElETprxw29wZSb1M8bXI33VnNRzHyKggHqHZo3CITvK56tS1FBE0TNGSLuPbSzS0YwPzj5sNZJe1tCfYWmFgjM2i7/7gIP3rcXofvrEykMBdlohwOZUMKqSNt418jsM/TD670cho6lgs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=eBY3L4qx; arc=fail smtp.client-ip=52.101.125.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="eBY3L4qx"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nRu9VnkxtjTChzY1w5s40AQ5dGjMAK4mYBqz5cyt1RYhokNvXMEp/A9LJ+SiE7VWcno4XDA6+sPUpJ/EcivYV3K0rtgBGs/herUadqYbwtls4weexSDjl0JdRN/cH2cs7+8IpEke+pa1mTxuLZV8X6o/2GiLKDj+U4f7RUnjv03LSUdRR1IzPoqovpnXtyi/Ooek7i5kx7wluViR+MTukojtskrmfyeif/GRcd6AWX+4x3j95bQYhtORdkzBxaVQwpc9nuVnkJke1uDFS988Q0IMXOM5+/9aEO3vuCcCv98O6EAsnGMxPYVg7F7maPdKK3J9RFROyhrvbFbzD4ia2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PEHveKNNDaRvvOvWDi+LiKS2Pewg4yAr7Pwv+UeNomA=;
 b=r8SRAYb2Af7nSmb5aNwh53xq1b1BmpFJHYo7ZDVUFRPjN/DECTNVzPR3ufjTsSL2KUNnxd8nOkKB4ZTVanbTK3Gp9kzho/23juwqw/pvI1VSkhU4LHkCBmFwZTJHeR+4rMNNFBw/Wf8eQCZThJofC+Dy/nce8PQ8BuaPIQ50PBc/oC9ZrfaSApbsZ5sqFTJoY3Vu5uVWueW9FgbyMMq0d/yVkPQjZ/APS+PAZ60i5bpu0E1wVeKsNH1VgnxhZrTjcjryeF+MFuasOT6Yt3hfuTy/j0/lpjZGeeJMTO2YY/5grCAfJ8kbiMAYZ/aBPTmcuss7ULsiIANBA57TWIynCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=analog.com smtp.mailfrom=renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PEHveKNNDaRvvOvWDi+LiKS2Pewg4yAr7Pwv+UeNomA=;
 b=eBY3L4qxAouiBdIdg7SUtK5BHFESSTqUKC9NR3kMpdFcL+ZJBPTRsLrOEjKgbgQyKHhsEzBJ47nzNhdu8CnvC8wjgW35FsUqNdTLOqjWHNmmLkN9v3t+XFz6a7qpwaK00iD9hfsaehRV8AFPssJ4BV+eBmF/6jzRCu9jpt6DUvM=
Received: from OS3PR01CA0040.jpnprd01.prod.outlook.com (2603:1096:604:dd::9)
 by TY4PR01MB13855.jpnprd01.prod.outlook.com (2603:1096:405:1f8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.11; Fri, 28 Aug
 2026 15:01:29 +0000
Received: from OS1PEPF0000D214.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:dd:cafe::a8) by OS3PR01CA0040.outlook.office365.com
 (2603:1096:604:dd::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.11 via Frontend Transport; Fri,
 28 Aug 2026 15:01:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.62.32.50)
 smtp.mailfrom=renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of renesas.com designates
 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 OS1PEPF0000D214.mail.protection.outlook.com (10.167.240.21) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.8
 via Frontend Transport; Fri, 28 Aug 2026 15:01:28 +0000
Received: from demon-pc (REE-0055761.adwin.renesas.com [10.226.92.7])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id 36B7B300009E;
	Sat, 29 Aug 2026 00:01:23 +0900 (JST)
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
Subject: [PATCH 7/9] dt-bindings: iio: adc: renesas,r9a09g077-adc: document DMA support
Date: Fri, 28 Aug 2026 17:59:40 +0300
Message-ID: <20260828145943.2077589-8-cosmin-gabriel.tanislav.xa@renesas.com>
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
X-MS-TrafficTypeDiagnostic: OS1PEPF0000D214:EE_|TY4PR01MB13855:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: ef8ad174-65c7-4171-92fc-08df05153d2f
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|1800799024|23010399003|376014|7416014|18002099003|22082099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info:
	VXXz3wypehFZkmsc1cgN/UuqSLXiq/qcIgjwBJ4dUyUNsvYfNC477D3y985R9emK/iwjV9PTthsWXsYb7bUBWWT7mujDuBc+D1D2oAQw6A+FOkl9wSj3QvdNerpu8GkQVrt67XIOw4pgLLWiZxdK/oWP972QaCergUk3BMVvC/gpkCASuUb0gpFmoA8PGtrcU3c1D7za16dqzHf0cW3H6K2bL2eSP4V5Ad6mG/sMCMoBu0t7MSYEeRp6/h1Lr57PZ2dxBi6QihIMNYdc+zihdTV79NLT/IKlcc+8M7Fepik7LVSgTK1o3H5g9hmZL0auHTx5jgxFuUeIUoZreSwg61Dsd3X/aqMxVnC7Fqbwi7O1YlVpZW/BS2qEB2E5exFLgyPWHjnCehIcj4slJ2/3FOSMZFZF0c4U7u2MVURWHuKVjIH+xmQZlouZwduc4g3BvXu+XhfrFN9q4KYX/4trz0YfeuyzYLqxLY6XvGIS/VYt4lb5V47tZqWlSc2WHNz7I4Uys0JGnoYPNHvSA8fcJpojbsjKZ0jIWW9asszKB/C020+26rbW1xirGYsjBUvvhYgujC4oM76Io1MnBO3vdQpStZTHN7Nxj1zVe6sPgVKxb3OgmVqt94HmeOTFqxmwhk+mzAf1KH3XWdCKkX+XNJwzF7gALAe4j7nfErKtoDrX3gX0rjLbwHi0u5Kv+lBoj4uWrRrw2roRk+25XxDQZg==
X-Forefront-Antispam-Report:
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(1800799024)(23010399003)(376014)(7416014)(18002099003)(22082099003)(56012099006)(11063799006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	SVSQ3B8G+iuHsWrV31E/ptBHsT7zsOwr4mBHFJyiPqcSGC0UYJu6BUfaYXvIzLchXAU3JfmpPlky+b1PuTOM1gX0rTOxC17txmJT4S7zDh2irvIT1qmoK+kTFDdMKEXovwlO6xMWbwpdtmd2pQPGOjgEgJA/LlgoD547x/TN9SOSXyBLIIUgL3SVzySmS6pTCtgU+05HmRoZpACg9z49KCmigBVlGZwO9s0fliCQJxHS/5ZwGP8CxEBQ/VLo+BAi55lUUnDAcCw5LJ3LiocLvUopZgBl2ryYJZQvf/kHOClMQRkVyF0rb8hvcJLazXtl0CDUef7C8+ptLEJO1OPZLSAPPgSORW5xjYplCQMCmU/mioYoxkN0NT1Gq9OT2Lz152NbyaaoZvYMPCBU4AsIMU6aZQb31R018genY/1VhIwK0EbHMDcSzFCE+9O0shmQ
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2026 15:01:28.8258
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ef8ad174-65c7-4171-92fc-08df05153d2f
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: OS1PEPF0000D214.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB13855

The ADC can transfer conversion results to memory over DMA.

Allow up to three DMA specifiers, as the ADC conversion DMA request can
be routed to any of the SoC's three DMA controllers.

Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
---
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

