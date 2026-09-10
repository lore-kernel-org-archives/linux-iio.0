Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010015.outbound.protection.outlook.com [52.101.228.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2540626ED3E;
	Thu, 10 Sep 2026 08:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789030544; cv=fail; b=Re5PJGHW+PT2RjGwRzbs0yu+2R5XxSxaVHpsMGjd95Wg4h6FiYJHj/Eqm54aUs6a8NHsqRA7Z167kCosbTHiFHBWpp2weR4AIn4nse0cuagFPncirLku/p7zJTdaHDLZGCG05K1QpVJSocRJ30CbRS+Cu/U9BbULP2QuQ3J7/Eg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789030544; c=relaxed/simple;
	bh=2EMu9uzP+yqWV/31rWRvXRr5WMFTo9V0Gv5j5yt5GGI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TEO+vd70c16gRVlypVWakE2qDJPNa/IEJFDmz2GcCeff6C6aEE5WW3gAiXT7aJRO2w8wS+ho4FseoiFhyLnsPGL0JuJfRYvvRKjJp+NkJ9wAZigy1gbK+j1abKktVnGsv6YbMM6hL+6S/b1jsz16pEgYTcHgqvGlT+sPM4/gc6M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=LoQSVr/f; arc=fail smtp.client-ip=52.101.228.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="LoQSVr/f"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w/iax+wL4DOTaAXYnX+EjaM9Vky3PZ7WeMZHQ0ZXS8gusxJ+dqMAuHxg9mviB4fD95bmOGYPlzdurgwczPWpm++0uLWcx/gwR2rUhRAPHdCLQp6N4BcixzVaPxvXv2dAflue5NUPmPUBMGVVdLfCH2IcyTV40cMZ5OiksIKPikQO+n837m9hb2FalYYmafzFBQuev1REH2k0ecym+9zZaOqdD79mDFCL4QXjMly8hgiW5+e0i6XuAjDZ50DwmNL/29A3PVLTMKemjatxafDF4tc0UR6UlxN9K7la/Er4X4mbj1R/ceaExChSt+o26Qrgkg3sXUbGs7ym33CIVIm63A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=00pYQ5WGB29yhK6YjUVR3PZPNbYqz1FovnQY+SUxlXQ=;
 b=o8h7hGMiYuNB8yju3ljr8IbGpmrt9InnVhTWQYnf1oAtZDdGiht6tonKsOnf2N8F2AAH1EyFHDgOLtBY9Ej9MaIV0mo4wVB3V5n0y5DV8IFzKiNwYaczA/UaEmGiiSGby2n4tEP5TenHDpYKDomzbMeTWmuf5IjLxruusUQ6LyM+xwPQgiH+s1F+f5xKzk3xzZkNCPSjdvq6BEeJ5wue/7QkROHKFbKW5UUcqOmiUMCsau0dk5uzenyH3VJHwSYlNgA79UAiisYvyXBdGaSfv51u2vWJBXTMaI+ARm8yYW17RxhxyED09XlfeBo7Exn6H3I1sB3bv3/q5Z2HJL8vLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=analog.com smtp.mailfrom=renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=00pYQ5WGB29yhK6YjUVR3PZPNbYqz1FovnQY+SUxlXQ=;
 b=LoQSVr/fR+azPM7Cv8Jr7RjDTiTOd+/KqWAm+XLs02gHztxKyFkZ+1mOtyROWnd3duxNYweaxTCTDb5z1ZR/u4hBC0POC1OI8RJkE049idCip85YIHVtSgbnMne8gjum3NF+a7x13+sAB3HA7WjmV4g14UWY9GTE1cjJJXPVqZ0=
Received: from TY4PR01CA0105.jpnprd01.prod.outlook.com (2603:1096:405:378::19)
 by TYCPR01MB8174.jpnprd01.prod.outlook.com (2603:1096:400:103::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Thu, 10 Sep
 2026 08:55:36 +0000
Received: from TY2PEPF00005622.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:378:cafe::5e) by TY4PR01CA0105.outlook.office365.com
 (2603:1096:405:378::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.9 via Frontend Transport; Thu, 10
 Sep 2026 08:55:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.62.32.50)
 smtp.mailfrom=renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of renesas.com designates
 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 TY2PEPF00005622.mail.protection.outlook.com (10.167.240.53) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.5
 via Frontend Transport; Thu, 10 Sep 2026 08:55:35 +0000
Received: from demon-pc (REE-0064895.adwin.renesas.com [10.226.92.160])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id 58D0B3000203;
	Thu, 10 Sep 2026 17:55:31 +0900 (JST)
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
Subject: [PATCH v2 0/9] iio: adc: rzt2h: add DMA buffer support
Date: Thu, 10 Sep 2026 11:54:21 +0300
Message-ID: <20260910085430.3173166-1-cosmin-gabriel.tanislav.xa@renesas.com>
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
X-MS-TrafficTypeDiagnostic: TY2PEPF00005622:EE_|TYCPR01MB8174:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 9e7c3a19-1f37-4d67-dd10-08df0f19475b
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|7416014|1800799024|376014|23010399003|82310400026|921020|6133799003|10067099003|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info:
	1rIpZhRz6zWWkxuc4FA1xFClWVdmr/4lj1L6ko6kpBf5nOP5ckT3IYSvW6e6yHeBXcfVWVosftRYyIn7rvFlT4C/9k1RLmLkRKyBE9O5CE4ZRoWjqFBzULB+8gjRLOzxMv5aL1JtjUse1rdnhUNoOnQKSuOrHgGBJaIV7SkBTOF5TwBjQB2H88pw4o0OjmkP14qw/bsE1CeScPRMHOlaAbsVPPV/NaAUHZKW1PTK6IDzf+MyXN+G24KHr5S1zeT9haQ3JJTb7VOnolgzcWGyiRKXKoyVO2Ci4G6J0J4UvOMcLaz3bEWbWtfzfuTgCSlECSIXWxDvblP8j4eSAEQlTCw5sX8Wnx6yFvIfWay5K3H1SRrBqvrOcgmMuSzbCELWPVt0vhtVpAAH4uD7huMBRo3QTdwDol5CZ2VbgpcYhZJAymWiyDL/dc/PdnbfykL/I/COzdUrrsMwzLS6nuuhOdA3aIAAICqgJPikyYKKqfBJuFCriTDRYo6cMXdV7FoLfkhBDL3uckWEQyOIgW7ngZs9nncxR96pFvRXTf3ggR3qfT4g4rSWhCCTAjI6ESfAHT0c/fNNFhNtWjOeeaHIZoxxhQinOclTPffmHeMWynInlDzk4nj+rkXKmIYl14M5LwF5od3jMQ1QLso5S5l+Gl/xBcyIAm6+IhN/7zJMc2t5nEu6PMBTgW1qDiEoVmPQLjLyO2dB4uGpkxgeQ84jgHAeD3sXnU4eRyzJYkxkpnEo4fuoksMQmn0EK7M7ZYdw
X-Forefront-Antispam-Report:
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(7416014)(1800799024)(376014)(23010399003)(82310400026)(921020)(6133799003)(10067099003)(11063799006)(56012099006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	kpWsFAg7gK+ZqQAiSkPhOnvn4gDhchYzcaCw0+hPOKgiP0vJ9f8hxeQE9sAi3T9icD9OotbM90mbo7MsHBPD3cdDwSn0tfN8187Ab1er5YsPFMlO/ls01KlYFdH07Ig/dCDbbmtZSK42gbblu1oBmGP6u2yjDAcFp58QaVIdBxecopvy+tuYt2BDatVqpBAEd+7/fBj4Gwp0N0ijTIJa4EBWgj70nq2sJQBWpOEHv+Vm5urcZ+eGAVxOIEYpet1zHOqAG7W+jQtrsP7UN1zlr8d+mRjExp6nKFERoRrc7fp2CCNyRwv/FeX8APjO/KNN+FUvwc4cKWJB/e+CchzaUW5nYDgrtoLKQm4v96pL2PnaKAqF20HrwaUs4mGf3QMqIimt33Kcts5agihPmGKexNBhn9IHVyWU7EsdhfmtXZcYS7NLkuh0Nd6qpB+uBUbx
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2026 08:55:35.5202
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e7c3a19-1f37-4d67-dd10-08df0f19475b
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: TY2PEPF00005622.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB8174

Add DMA-based buffered capture to the Renesas RZ/T2H and RZ/N2H ADC
driver and the necessary device-tree properties. Also add a per-channel
sampling-frequency control.

Capture uses a cyclic DMA transfer into a non-coherent buffer. The DMA
controller has no per-descriptor scatter-gather and each transfer needs
to be of power-of-two width, so the transfer covers the smallest
power-of-two-aligned group of channel registers spanning the enabled
channels, and a consumer kthread compacts each completed period down to
the enabled channels before handing it to the IIO core.

V2:
 * advance period index on backlog overflow
 * add a comment describing the logic for dropping already overwritten
   periods
 * build dma_slave_config as a compound literal
 * use the local dev instead of adc->dev in rzt2h_adc_setup_dma()
 * sync the DMA buffer to device immediately after allocation to handle
   the zero-fill done by the CPU
 * extend the single read completion timeout to maximum possible
   conversion time + 1 jiffy
 * pick up Conor's Acked-by

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
 drivers/iio/adc/rzt2h_adc.c                   | 499 +++++++++++++++++-
 5 files changed, 509 insertions(+), 16 deletions(-)

-- 
2.55.0

