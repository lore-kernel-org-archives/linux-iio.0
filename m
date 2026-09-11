Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011060.outbound.protection.outlook.com [40.107.74.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3A604756DC;
	Fri, 11 Sep 2026 13:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789133856; cv=fail; b=UTcpz/+ETDVZthh2qxYpEZWRHrbYwYYhDuJ+7sk2hE55jnDX6+zqMwABV1+ZgYwLt7X5bUjJRSR2OM02OLy+TuqiF8oU+ZLHnvt+rcIlb7qkQx9D9q06olQU+SWEmPR4KtFvud57ulV0zhIuDroLDhdUZKSAcIDLty0hdXgvzU0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789133856; c=relaxed/simple;
	bh=aB+KIkY2EHW63tkhKB8G6CCaQmQFQ5BIWEayUiSey8o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GmuFMf5MwVf3p76isx4CIGiw7n03H48GF1W+hNQpPZq6F7a+3RXAo+vFO/pS13CQE9Jr1xDasYwCr0aNJzCYnbB+KOEstSekSrYCtnnkiSLWX1m1ucCQGOJiM5gYJDrKS07m/0HVBnE9R9TuGFZsY4OmEcAUf/RJ7UsPzAtA+eI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=lcsHyRgN; arc=fail smtp.client-ip=40.107.74.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="lcsHyRgN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EvcWtDVjvcBuLUd1WQQq590WNeh8sDBoWz04l1x6AXAq5K/v8cXUHNsHnhmPGsIZl+OPB8ochCyBSEg3oqe8lj/vCPnqbo6amhP1ZnumOIZ3twhFRFrDsNv95oZmujbO/pQ6Nn3ymNwUf3Ux0MJsTvsSoAR7zTWCToqSmIA5CE8L6J+BEOvVyERSiLZtwWOwqZEV/8nb2rhE8JLSFCeP0MujNZCFD84Jp5X+Yb35/fQqSNroRuQXcC7ax8B3+bAHuQxI7pqajXrwQxbatKmX2dPNflGGJHo5Kpit/rsbZ9kMsRqohOR5XT18G+C+7cF7uHaQ0kWqBG+rAl/dvoUP5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0I5isv5iWqk5U60bUcLixkLXsFeap3x5l4x4t5nm8Cg=;
 b=ffwl9FplQZSoEq4lMc3uH7ODiQbcVAEDGVKFozerSoCT+0JifAOYe7uhJLxc2sVfFKol69lg7oaIK8s016yJ2DZyn7sHZlLvTjuy/3Z3XjrYCmMdHF47gD8VZxMDm8iiS7s6X+Ei/JfOG+knweqrdoL25XojRd5QpeE5u6zfSp2ObWiEPY6kX6+is3tcF3IWAcG6m7MReyK+wRYCnX96iMQk05F+gCUBM3k9mbxXqNRk5EJzSgzobURC8su6R+3ecB6MCIY+oleOUNZUDmE+717H2Z26RoWJiaSR5TCnyej1ETIT/5vrfoOtLRXEATz/UNJf9QOmD/1CAeTbyeh8kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=analog.com smtp.mailfrom=bp.renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=bp.renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0I5isv5iWqk5U60bUcLixkLXsFeap3x5l4x4t5nm8Cg=;
 b=lcsHyRgNLmRu2EiBQXXcdJBY3tg3pUBvIrkWhau1Pg3ZMMl1Vjn12PPOc0sj2t8xGg/CacFsEObdpT1l5Ic9LOiJ8VjUrwoK0GfiqKt9Fyq563/HtDqGubkaxy5qtlN2KnBFiuK535MjEoeXsmjKpoYFcZYnPq2YNVByhdF9DE4=
Received: from TYCP301CA0037.JPNP301.PROD.OUTLOOK.COM (2603:1096:400:380::9)
 by TY3PR01MB10597.jpnprd01.prod.outlook.com (2603:1096:400:319::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.10; Fri, 11 Sep
 2026 13:37:29 +0000
Received: from TYO1EPF00005025.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:380::4)
 by TYCP301CA0037.outlook.office365.com (2603:1096:400:380::9) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.10
 via Frontend Transport; Fri, 11 Sep 2026 13:37:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.62.32.50)
 smtp.mailfrom=bp.renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=bp.renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of bp.renesas.com
 designates 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 TYO1EPF00005025.mail.protection.outlook.com (10.167.240.22) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.5
 via Frontend Transport; Fri, 11 Sep 2026 13:37:29 +0000
Received: from biju-VirtualBox.adwin.renesas.com (ree-0065939.adwin.renesas.com [10.226.92.175])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id C3E083000228;
	Fri, 11 Sep 2026 22:37:23 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Chris Paterson <Chris.Paterson2@renesas.com>,
	Biju Das <biju.das@bp.renesas.com>
Subject: [PATCH 3/5] iio: adc: rzg2l_adc: Add RZ/G3L ADC support for TSU
Date: Fri, 11 Sep 2026 14:36:46 +0100
Message-ID: <20260911133653.115553-4-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260911133653.115553-1-biju.das.jz@bp.renesas.com>
References: <20260911133653.115553-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYO1EPF00005025:EE_|TY3PR01MB10597:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 5f4a9036-ccab-4b23-34b7-08df1009d344
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|82310400026|1800799024|376014|36860700016|10067099003|56012099006|11063799006|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	4/e0sXqRqRAFhaAE1fYjI3l0RK4+bfB0+hbA76Nm+OyCkBuFxgNJt32OTuNtIaLBf3k+tzJ7jfXDEpsEIMbDAx+fkqQTr/PmSEzEUOLmrRBJY45LCylT7MvQQiBaEvHM93JmXgcVvvytMlD6DOVP3q7c643hsQ9pDWgcLEPikzcYeHS/hc97UE4lEmXGG5QX0zjA2I42MOSVePdqOzXYaIu7o6KfU4cgZsuwsA/R2YzuURc5yGqOT2Eo+Q2AOJYzZZM2E/2pgO6JVheQzS+xcjptks/KJ7thSNOHto4mPy8+bTiXP1ex5P6PIitzkKNsm61LjCHr3XdgzB+H+tE6jbQTai09OXlm+5E7bqeAHgdVOW2zeZEcd4PckoYEwuIa7VGPcRhFtdCN8i7rMEWmzRKV8w6bwerk5SLGkTLp7btvPLKR2p4kdgmz0PLFdmk8AykWWFRivVl126vwoiFzSZ2RU0qK2iLmHfqcFWxNPibf9oGX6KxDw2eLpvX2omBrz9R4CuEmNCtAVaLVHQiK56PkldUt4rUbALp711UeDsFTpo9kPTJyYmxF1yQkwSrO6cBUZ+HQ/lFcrdpCYqs8wjY5w95I77p/QVR7xFXCOojPDlAKbPq0CmJuFBR83tJI5FWHBZMWRCHPGK0tDCymdYPxt+4Bv7wVpLDClsNME/F26+rKWkJhEFaat4ebGBffk9rZmcjUS9xDxBEU95DlwQ==
X-Forefront-Antispam-Report:
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(82310400026)(1800799024)(376014)(36860700016)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	OMDtsZpzPBeUF4F+318Wo4LhVYaM3ZQPJJqZreprfXryK2ifxapfyfqCagmrmP7/GCDbZGLwCn4w7mNRZwdLAJdNCM6xYdAO+UnK33mgKft1bU1iqUfI/Z3dHBn7uJ8PLfxuyAy5W67IE0WEflrttT2Kts53qL/UUFTk9W/8ZkgZBc13w340nn98ACjqkBJMaGjpF17UnQUIk7DDAsuinVA5xPMkWBU+36k1TrC0Bzmw2OH9IAWWAPJZpk+Iq9+wRAkybQZndH/YibCg7O4yoUDnHw5GjqtJlw7bslB/5/mlWZvdtL6Dddgxn81JU07EFgqc4kYGYDRWBbbkRrHixfsIGGfToia/er2+82pUHmnnBHysQRWM8UEMDYc1YMyY7k57sXq8ifbbE9CA5M2/O3j/dXp0/D4MLwdRL7Z3RuO3xA1yhWIAJQBtGJaCOPtC
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2026 13:37:29.4611
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f4a9036-ccab-4b23-34b7-08df1009d344
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: TYO1EPF00005025.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB10597

Add renesas,r9a08g046-adc1 compatible string and its hardware
parameters for the ADC1 IP on RZ/G3L, which is dedicated to
the on-chip TSU (thermal sensor unit).

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/iio/adc/rzg2l_adc.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/iio/adc/rzg2l_adc.c b/drivers/iio/adc/rzg2l_adc.c
index 408fbf8c29cc..35eaebfbdd77 100644
--- a/drivers/iio/adc/rzg2l_adc.c
+++ b/drivers/iio/adc/rzg2l_adc.c
@@ -500,8 +500,17 @@ static const struct rzg2l_adc_hw_params rzg3s_hw_params = {
 	.adint_inten_mask = GENMASK(11, 0),
 };
 
+static const struct rzg2l_adc_hw_params rzg3l_adc1_hw_params = {
+	.num_channels = 9,
+	.default_adcmp = 0x1d,
+	.default_adsmp = { 0x7f, 0xff },
+	.adsmp_mask = GENMASK(7, 0),
+	.adint_inten_mask = BIT(8),
+};
+
 static const struct of_device_id rzg2l_adc_match[] = {
 	{ .compatible = "renesas,r9a08g045-adc", .data = &rzg3s_hw_params },
+	{ .compatible = "renesas,r9a08g046-adc1", .data = &rzg3l_adc1_hw_params },
 	{ .compatible = "renesas,rzg2l-adc", .data = &rzg2l_hw_params },
 	{ }
 };
-- 
2.43.0

