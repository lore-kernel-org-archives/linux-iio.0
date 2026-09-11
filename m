Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010042.outbound.protection.outlook.com [52.101.228.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29C65466B01;
	Fri, 11 Sep 2026 13:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789133832; cv=fail; b=H6mCjTSgoSiLZxU3q6V6AVgtvwTbdiXMFYJLFG4lTXdB2M/5Zs53YSGD+B5IEfTyZrCp9jQkTstfT0Qqu5nBZxr5thEjwD4pAcK0sisO7v8clOpZWgCUjdZuoMYsCLanhepdCSKQzqTBaY1uUNcEn3eHwcUV1UVk2RCN58GMidU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789133832; c=relaxed/simple;
	bh=LwJp+B3DnSbtzU0+Q3ualyTUEyxdTlR70mcm30/WdWE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=c2vWvdN3+5Zdtot+hk648Y/9o085ZZAtL3peNXAT03IiefwjNzABAJX70SO2mvNvZfP5Xa26y4kxGVQE3MzZh4/qSH3a1d7ehtrVMoqnVnTHsb0vQhLTdPI2ySYUaIugxYn7FKoHSPU5JK57TZFjZ/fVJysoE0LR94tJLBHdAwM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=j4RfCaSa; arc=fail smtp.client-ip=52.101.228.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="j4RfCaSa"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y3j6Kq3g9BZe1kmv3IzFEzfNcBEm8P0jQAVrgippTO9vnCRhj25roUO+a6ijF0PskwW4sbDNHCfcJEqplxsGqY9XzXbyYZ0HtIYQvHIwNJiAFgwvkYj8b3TruZcGlhwfgVeqd/m2TPNh0Uk8DnGZzuK5zgnAmtQA/9RFHMAVkAbGwJmBKw4z3aopwth1ffoUkjEDdgBCgYcbpBq5TepDfRZfezWprD6oMj5m83Pj1fMyyeEEi9upf+f2f+pzGMAxlnWxmysp3UQ5AArzkY7qTwPCbov52DxgiCVLrFgUjxP/P7Wodu8cvkJAYdPE3bfaVUVxI+NOp8iYQ2eGjU5wDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sKJQPZMITPdBKO8jBpxnBIpiHT3KMixSl6Jsuc5nq3w=;
 b=Q+tg2wZmW3AoR0rJ9qbwWsjQGHJh1Z5hs8vXXqpB9JHlV+n1a0lE3OL+POSqeo+dMGpOIZiJLKBYbR2ZL4pd3ETJcijldK5dqkCNxmUCoT/sbPPsiHC+ttOThkFLrbawRDOzWRZxBcKi6/jT7QBJdZXIiRyr49cTVaGUe/pcq1aO1p0IuKFOxcaV9GHdltqJbNFLQAqVW2keHrcsjFm+IcpyBhpmfhAUufF0q/xAne4+rSbSCGMxgglHnq5lTSdi98CtmGYnQRnzWFz8Mzg6cYtBmfRCiGUe61TPzPA/zXXfW6ftNLCR7S0+8fRYI5piqgrlzcvFihFLut1YfcTsdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=analog.com smtp.mailfrom=bp.renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=bp.renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sKJQPZMITPdBKO8jBpxnBIpiHT3KMixSl6Jsuc5nq3w=;
 b=j4RfCaSal0XoFywtfyZq1Beg5KP8qSPfX6ApU86iux4HnxYZV3dujQqEPgJIoE5UNCyOUrlU7PB6U4V86pvgI6RmBT73Dwv2LDVRb51FYePsZQDNYylPxprKypA32atTwjBD7T5JJPYtB3wFsJWkIAgSBVQiFXoZ7g3g1lBiCLE=
Received: from OS7PR01CA0031.jpnprd01.prod.outlook.com (2603:1096:604:257::17)
 by OSCPR01MB16425.jpnprd01.prod.outlook.com (2603:1096:604:348::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Fri, 11 Sep
 2026 13:37:05 +0000
Received: from OS3PEPF0000003B.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:257:cafe::a8) by OS7PR01CA0031.outlook.office365.com
 (2603:1096:604:257::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.10 via Frontend Transport; Fri,
 11 Sep 2026 13:37:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.62.32.50)
 smtp.mailfrom=bp.renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=bp.renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of bp.renesas.com
 designates 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 OS3PEPF0000003B.mail.protection.outlook.com (10.167.240.4) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.5
 via Frontend Transport; Fri, 11 Sep 2026 13:37:04 +0000
Received: from biju-VirtualBox.adwin.renesas.com (ree-0065939.adwin.renesas.com [10.226.92.175])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id 98AF43000250;
	Fri, 11 Sep 2026 22:36:56 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	linux-iio@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	Chris Paterson <Chris.Paterson2@renesas.com>,
	Biju Das <biju.das@bp.renesas.com>
Subject: [PATCH 0/5] Add ADC support for RZ/G3L TSU
Date: Fri, 11 Sep 2026 14:36:43 +0100
Message-ID: <20260911133653.115553-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS3PEPF0000003B:EE_|OSCPR01MB16425:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: e7d9adb4-d2d7-41b2-a587-08df1009c4a6
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|23010399003|36860700016|376014|7416014|18002099003|13003099007|56012099006|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	PJgJyhFyHvcEPsjCZF+S3+et/O8E1J96WK6B1n3qx9AqjYs7rK5gbQtHwHqBV/pWSRiZmqdNM0DR7yBQlQ6j+NAnsNlBKTtVDP51JBDSHKyXYJaoZ0UgZGFIUlZlocTHsXZi00/xGr6b6zCa6pSrHUjmFTdOVN9dSrZiq0ViYYr4X0YbgockfSHyHxcR2/JaaxloiymcoIuxyZSdExZAyvMMP105bknw5HX7kV+KSCTaqqkvE+L6TvINxhFAFqW/9eWl5mawAy630MsT2d4aimtJHfXlRf5tV1CESM8xeVoOe3G96L1/ANm7jmF9cEN/o2XUYFZkXa9+/HD6WipMK2UkmZvukFkmg4MFPfvFX/CdFxCWbTAeKoBCrYljPd8vUmPxHt+NnpoKxZYlbGMIbABHJNgxwrr467bsaSXpBf0yiWInxZiJ4iOrNRKrOKBEwbFInplBcNspr4reMQjTr5cVRRXxbuVz7ft2S7RSYbA8gp9YWy+FufRCsOew7V+vJCHx66W0A5fQ07jZoVgXyiHe01Lh6Hahyq41iymDrAp4P5fmrSWAXrkTOwrzq0MDjJCrhgiH6NwOVBxo9+xzwlR34DqCKxRLAltYVBXFkatYm93BzbJT5CKFtWsCYToo1Btc9Xm6KR1/yi5rgmipKQgv92xLTKdJWVDF5nFv18RdWUO4IcqWBFGfExYjFaJDN+cj7EVgXR4RvPpCnWpkPg==
X-Forefront-Antispam-Report:
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(23010399003)(36860700016)(376014)(7416014)(18002099003)(13003099007)(56012099006)(10067099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	LjlLqZBopdhasEX+qhA2kbS8svjAvFSBqdAzJ7hUd8Sgn1G9GsTQqBuwtltykVlIM3QM7frpp2wmGUOW75WPWq7A15utwWpvOw/94gD+OL2Ti1HHweLfjNp19m3u+6L62lHq+HYGVE5SxQWL23Ox749gE5QpaUuYEzA7if428Ujb6PioT5/ulF/j1B3PpPD6pnNv3TpeH2JfoT457YgL1YyR5iWNHH0tT2Lv5rN1VSemlAXV4qdosRffKTpqyTqdiFIyjnz0oQwv8DpOGxgBDR/kx/oc2B5zFAbBmLCUXLCghSzBQ4tALOHHONoJUar/SoFeJvYFAfY2RaoEtxdhDUVw4Vz7mtn5Y4UpeyXh0Ef5urjSbpBvd6DVD7jSyB2f3ZnUWcMtylIXMz//zvcjuTS3/7BDbiAGAnPl7YDFpS6pp7EaSOP82zxgNDOtHI8l
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2026 13:37:04.9275
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e7d9adb4-d2d7-41b2-a587-08df1009c4a6
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: OS3PEPF0000003B.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB16425

On the RZ/G3L, ADC1 is connected to the TSU, whereas it is connected to
ADC0 on the RZ/G3S. There are no ADCR0 to ADCR7 registers on the RZ/G3L,
and the INTEN bits in the ADINT registers are also different. Add ADC
support for the TSU (a.k.a. ADC1).

The SoC dtsi patch depends on [1]
[1] https://lore.kernel.org/all/20260911131629.111564-2-biju.das.jz@bp.renesas.com/

Biju Das (5):
  dt-bindings: iio: adc: renesas,rzg2l-adc: Make '#io-channel-cells'
    required for R9A08G045
  dt-bindings: iio: adc: renesas,rzg2l-adc: Document RZ/G3L ADC for TSU
  iio: adc: rzg2l_adc: Add RZ/G3L ADC support for TSU
  clk: renesas: r9a08g046: Add TSU,ADC1 clocks and reset
  arm64: dts: renesas: r9a08g046: Enable TSU

 .../bindings/iio/adc/renesas,rzg2l-adc.yaml   | 28 +++++++-
 arch/arm64/boot/dts/renesas/r9a08g046.dtsi    | 66 +++++++++++++++++++
 drivers/clk/renesas/r9a08g046-cpg.c           | 10 +++
 drivers/iio/adc/rzg2l_adc.c                   |  9 +++
 4 files changed, 112 insertions(+), 1 deletion(-)

-- 
2.43.0

