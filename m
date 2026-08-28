Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010001.outbound.protection.outlook.com [52.101.229.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AB2245C6F7;
	Fri, 28 Aug 2026 15:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787929257; cv=fail; b=DJ/6YOpmaY4ySBfonong0c/CVKcu9XEcnHjK0YBV7z3+8FhldaQ1soUgi1lcX5Tq5ZHAWjBSfd6PF85VtM2BeWJ1s3EmjlRazSy5aV+/pUvYvrK962FAt3td7yZIBIbDMPUvod7z4PW/6P7d5pXv8URiYb91dhXX0YCIa3glEbE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787929257; c=relaxed/simple;
	bh=Bh6pOzZD+q3fBbA3r1I4Etypw3d6Xa67YO3HAY0Wb64=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=R79SFDzpm5eo7XC7ropmw3ukVrpnx+3RnxIGGP2m4ZUndllnjvz1EZQkijgL8n78aKbBcRneAYd1ghb+E/cJZoThpmPF/ylWbQGbanRBu04p6rCmcPmwnvFgXz/SSqJSikpT8F3xZPu5W2BTTY4uuiwLM+wSP1cMYp5WlhYbTJ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=bWz7PMmn; arc=fail smtp.client-ip=52.101.229.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="bWz7PMmn"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XjKzlPG35sWrwCA69xVrQZ0+h8sob4exEeVXnHCzdEB/QSMNgG9o1D1klKmRCEidZJ0MixvefeinjLP4gVRrgf32geQ3iDdwZWAlrCAQXm0ABpPORvQUhNV9bJzOHuhWd9jkhNfrvo2zBQois5uoQ9mo1F3pi/rknwEcVIR1twcf58JwILJ6c2QBrA/OTLVtpCMF3EBiiUjA1Mnm8bVcFFN2/vc7uE1LuFUZ9WKUr09xFOAajVHu6E+dQn8wKsB4jCatMsxIrBhG19WAVI4a78+fl3LcCEkaCFSdBIInEG8YQEWhXzA18Z1tmBJ3av4GetPJbuPo/SZLdhHvZuj+CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kjp1m4yeV2FgVp1DGzDQN73mGu3pOsHxUF3Hpq9UySc=;
 b=wXK0Lt9R+doblGrw0uf7ODSTuuHUohgpFnBZk4rp8+l1tkd/ti6GOvP0W2DrqXh3Z4Ylqqq7BGD1iG6m1MEy1Jmaizc9An6jv7hgKR6PWf2yuRMgNpMezm/vSTCKGpacPSrFkwU2hc+xB8M4F/pSzMC8fBRf9BW5Zf/Gq6xm7bobwCz0KFwD8r9ao00aDplPaq0LYkzp+mZ+ibtTYZB5Y0A58j6MXsYAlsMI0dxOUilbEmxkR1/BBh6WWOQbCe6LV7oFQ7r2hwVDH+4DO9o73cUkx+T8QbpH094kpxGhl0hoqV/R9yiu+Ce1xYdUnjQkec3AEBGYNKjwXIzlnFaL+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=analog.com smtp.mailfrom=renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kjp1m4yeV2FgVp1DGzDQN73mGu3pOsHxUF3Hpq9UySc=;
 b=bWz7PMmn9sf7Q+Gqkyut7CnFDmRSFuA8bnPl7I4xyqXR1HpVY4eswuGHngXxRs9Q7NZSAZmdKVogr07FimXe2AL74LxpbK6vMTaPusYAaIjCdn/hp1s8Uhobqm1j7QRa6JBqoHmaAtzsB/s7C8px1VCWe82WlLHlJM7ts2rTff8=
Received: from TYCP286CA0326.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:3b7::10)
 by TYCPR01MB8453.jpnprd01.prod.outlook.com (2603:1096:400:156::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.11; Fri, 28 Aug
 2026 15:00:48 +0000
Received: from TYO1EPF00005023.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3b7:cafe::35) by TYCP286CA0326.outlook.office365.com
 (2603:1096:400:3b7::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.11 via Frontend Transport; Fri,
 28 Aug 2026 15:00:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.62.32.50)
 smtp.mailfrom=renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of renesas.com designates
 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 TYO1EPF00005023.mail.protection.outlook.com (10.167.240.20) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.8
 via Frontend Transport; Fri, 28 Aug 2026 15:00:47 +0000
Received: from demon-pc (REE-0055761.adwin.renesas.com [10.226.92.7])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id 26F3F3000349;
	Sat, 29 Aug 2026 00:00:42 +0900 (JST)
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
Subject: [PATCH 0/9] iio: adc: rzt2h: add DMA buffer support
Date: Fri, 28 Aug 2026 17:59:33 +0300
Message-ID: <20260828145943.2077589-1-cosmin-gabriel.tanislav.xa@renesas.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYO1EPF00005023:EE_|TYCPR01MB8453:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: b25aa9a4-17ae-486e-7013-08df0515249e
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|7416014|1800799024|23010399003|82310400026|6133799003|10067099003|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info:
	nvdYDdZ/yGmY6CC3H15Cx5zdSkMp8fxai1vsDAwbi++PL8Cq5JFfqsgvZeY9o3WyzaKtaOqgZuhQUuAjqTIalOLYwaZEBfF3ZEVogiVA+q7OT/Fpd3Q7TSMRuEXFd9Ox2Ig80SQWZl78TpifnyHYyPcPBIcLrf+JdvAEzrlZNWFjFCrm+TdvHHGmN9a5bp6alFczPMjyZVGtf9xH75SFGinsv19zZvKa2ALMCRaWxvONN5PkXi4ebEtnz1NP3UCJD26lhv2/jpuqHp2YYB0m24uaOQG1vRAZjax6ql0tr+WFMtvQD9FhsIgDWokEpQsmq1KxPrHj3Cv6WO0OJcWO63wNTB0TJAsTaCJQX/YnijL4z/7RSnXl3phdJJROrcxPr5P45vnydlv5FpNVcxJ09EaILbedECCsT0bpskpZlU7mWr4Grpumd9GLmT+Dl7MGxm/bG57GFmQwcTv7XNsr4jCVZhyRd7llIxA6TdNVv8ET80SKQzPQDW8jB90fq9sHLjZWE1sqKv4UbDuzW1STKmSYuSopUjKEalv77zlZU8NbJ3I0i1QcuLvjFo6zPaRv7bVn/YlJfvFLlL3eve8gimzieck9EwM2J4s4uXq7MEfd4FjHZIokgcmELuM9h6Qm20ObAIk0xAApBNCdHK+GOHH18f1mUTitMkxIsF0iZh+w13SI4bwsggi9kBs7CAfH
X-Forefront-Antispam-Report:
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(376014)(7416014)(1800799024)(23010399003)(82310400026)(6133799003)(10067099003)(56012099006)(11063799006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	iyX5VNcSEuG5MnPxfsF/0fdOpXlpZrG1k754I3z+p6naVnHTyTWge+5Yhk4rJW+XRFnoTmFeO9djsXCTTuD+GdVYe7xvKpzWSxa1rxzRtE/c1Oj0BWRuiFjraaeG9QUrW3dX6HjuC4buvxvpIM5dNhrcQrGV3+xqWumNH6rbEHY/lJ6plblbQ16DxbBe430uineA/o9UK12t81eZEi7UHIYgfDFB9L2nftkBK8jcH4Xulp/RcBzDjkspnIuXY97mQyTSBCaoe+nX0yU1ZTd7X+7hA8RmEmmVNylblNPalrmCmloJtMYffMw3PfgZOknrw0SnqXsLivHGOk6T2JjChewScJPEUIgqiwctvYH8acFxzgRs6VP30c3xuWT+qR4VVLVDBc8r92S3LphEHh7CSgWHnR3t5UO2e6iOrX1tK0s9mGfGK8JUDa79rUA5WQOU
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2026 15:00:47.6215
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b25aa9a4-17ae-486e-7013-08df0515249e
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: TYO1EPF00005023.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB8453

Add DMA-based buffered capture to the Renesas RZ/T2H and RZ/N2H ADC
driver and the necessary device-tree properties. Also add a per-channel
sampling-frequency control.

Capture uses a cyclic DMA transfer into a non-coherent buffer. The DMA
controller has no per-descriptor scatter-gather and each transfer needs
to be of power-of-two width, so the transfer covers the smallest
power-of-two-aligned group of channel registers spanning the enabled
channels, and a consumer kthread compacts each completed period down to
the enabled channels before handing it to the IIO core.

Cosmin Tanislav (9):
  iio: adc: rzt2h: remove unused struct rzt2h_adc::max_channels
  iio: adc: rzt2h: store IRQ in private state
  iio: adc: rzt2h: store the physical address in private state
  iio: adc: rzt2h: claim direct mode on single reads
  iio: adc: rzt2h: implement DMA buffer support
  iio: adc: rzt2h: expose sampling frequency
  dt-bindings: iio: adc: renesas,r9a09g077-adc: document DMA support
  arm64: dts: renesas: r9a09g077: Wire up DMA support for ADC
  arm64: dts: renesas: r9a09g087: Wire up DMA support for ADC

 .../iio/adc/renesas,r9a09g077-adc.yaml        |  12 +
 arch/arm64/boot/dts/renesas/r9a09g077.dtsi    |   6 +
 arch/arm64/boot/dts/renesas/r9a09g087.dtsi    |   6 +
 drivers/iio/adc/Kconfig                       |   2 +
 drivers/iio/adc/rzt2h_adc.c                   | 477 +++++++++++++++++-
 5 files changed, 490 insertions(+), 13 deletions(-)

-- 
2.55.0

