Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013007.outbound.protection.outlook.com [52.101.83.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22BD13C417E;
	Tue,  6 Oct 2026 07:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791273506; cv=fail; b=L1W2AlvsvSe98mTH+u+5DWZZBm3QqvokE+xqemG1w19bYk1cNYoVDW9+A+ayJ733nNU3XBAioVkXiYp8tPshu7+KCyue2OX32zRAYBB6bf5YLeDvZfC8b4olP/54TDvUqTYqY2IrQ9Z/x7Rc5preG6s7ZVMz9a1IqWcfxkpOB3s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791273506; c=relaxed/simple;
	bh=nHnh1/6xbYe+JOys7C0uzr5v2iWzIIK3qO+MGCTWqvE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=o5rpqoihZPbM3Qno61OqeVH9aZUOwGiYlTvBuQvrkNZ5iOy4n5IV5hsXZYiq/9wmuPVFl8k2/sT3efcEyKofYzDXKEPILqJk6RT8ym3E8qduIhPnNXlaU43q0U2CrjaEmiQVjQ70Tz5C6ZzZGFWagOG0MdwxjXChb0yMyANz0+w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=jaFwWMxt; arc=fail smtp.client-ip=52.101.83.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="jaFwWMxt"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l2TBumpZaZuoxRNVrejrPqb7kqfFSmDmfp/B+Rp8/4jZWcUA/oKPWTNTToYL4I+LWYkZiGwVppYHR8xf3knB1ncbrYLqzusU8GpE4t6Nt1OBL9Y3/B79jAX4HXf0lQou6F4UhPqlKkOu+OFb1zIgveqtHf7uVl/vrCSR1lTzHMOuQWuFZyoBOsVUAGsk25RJy9hm3F8h0eUTD6i4XvTo4WpWfS6Yz4i8Ug5V0cysuxBhc/rgQKo7oAx8Pt1caJ4RGESaFUrRfDPFH9Y85lq1pVO5MLVm/sIQB+QwGluzIhWF6DYWggXIaztOtbnNRNNM/TIToqZ1+FD1mAEMHzt5rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y0tixo4jyRZOXFYsaejltJvVvfuLmNqDWBV0rV4Fdbg=;
 b=Laoae6bKL9ZJ+32F9MiNnUGkMRR7o3HYY+RTg7EINR5SyT5Yikz9i33zOG4ctSbu3gUFmGvCzshivTYutwc6pWc4lq0/LfhU1X4boiBwSdL2dxIV0CrfywpIhju3QD7eXPz0mYGGc+lfaV4xwnzGQB4Y1c83XqYjmzrxgenXFn3mRaiXs6KLnP818T22k7XHtfuwOIv1aRP073nTbtcntsnZ4RciDerY82SEe3oGKUtw6ydDmT6chPzSN240uPmi8o25v0RWbe8xfVJw2iSSCCrZP449CP9YdR6BQyFTjnnM7jqNxF3JqMpwapihtmkN9P8gaeAB0ZcYLwLxXvr/Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=gmail.com smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y0tixo4jyRZOXFYsaejltJvVvfuLmNqDWBV0rV4Fdbg=;
 b=jaFwWMxt5XDJgfgMyM7Xa1SbI9/mpSq1wjNEAFEk8jnnqrfCr31wOHoLrTfw0Q1X49tYtmGF81uLXyWf/lOKKksqJDx232pgEXn47YF4jxFEDvt3usL/ZsI8D7gxVroi2garKYY4ocNWSF4kX3sENlXgwNDwCO7NaozYkAsXZwDkBVFThPVwwuNvwz68uoCJIMHPXlg8aFFIU4PFBcO5KmcRVDhYOJCFBPs11qRiV5m1VTf1ouaQykTMP4viOUHMrN+szaKl2erBFMMhxuW4GnIg9jKV0S5bMv0dPpRQcPjgylYgPpuEDb7HeV3ClC2mSo6Q43Grvas8wQ/3Cd0aBA==
Received: from BE1P281CA0458.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:7f::6) by
 AS8PR10MB6338.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:53e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Tue, 6 Oct
 2026 07:58:17 +0000
Received: from WA1PEPF000099CE.eurprd04.prod.outlook.com
 (2603:10a6:b10:7f:cafe::80) by BE1P281CA0458.outlook.office365.com
 (2603:10a6:b10:7f::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Tue, 6
 Oct 2026 07:58:17 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 164.130.1.59) smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 WA1PEPF000099CE.mail.protection.outlook.com (10.167.242.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.14 via Frontend Transport; Tue, 6 Oct 2026 07:58:17 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 6 Oct
 2026 10:04:57 +0200
Received: from localhost (10.252.27.219) by STKDAG1NODE2.st.com
 (10.75.128.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 6 Oct
 2026 09:58:11 +0200
From: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Date: Tue, 6 Oct 2026 09:57:38 +0200
Subject: [PATCH v4 07/15] iio: adc: stm32-adc: preferred style cleanup
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261006-adc-stm32mp25-v1-v4-7-d31ec75aecf3@foss.st.com>
References: <20261006-adc-stm32mp25-v1-v4-0-d31ec75aecf3@foss.st.com>
In-Reply-To: <20261006-adc-stm32mp25-v1-v4-0-d31ec75aecf3@foss.st.com>
To: Jonathan Cameron <jic23@kernel.org>, David Lechner
	<dlechner@baylibre.com>, =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, "Andy
 Shevchenko" <andy@kernel.org>, Rob Herring <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, "Maxime
 Coquelin" <mcoquelin.stm32@gmail.com>, Alexandre Torgue
	<alexandre.torgue@foss.st.com>
CC: Joshua Crofts <joshua.crofts1@gmail.com>, Marek Vasut
	<marex@nabladev.com>, <linux-iio@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	Fabrice Gasnier <fabrice.gasnier@foss.st.com>
X-Mailer: b4 0.16.0
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: WA1PEPF000099CE:EE_|AS8PR10MB6338:EE_
X-MS-Office365-Filtering-Correlation-Id: 7326842e-591e-42b8-ce09-08df237f94de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|7416014|36860700016|23010399003|22082099003|10067099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	3RrMCyibjC7EGkHs/j3fhKl85NcxQ07LT0bcAMQvWHU2Mmpj1x4na86/sCJzIZPYSCFgQfl+o6ZUbS8JUB3qyuk0V7i8CaddM0qlCAsCKYVmA29nW7aug9dqSnTaR3qJGKn9gXq9NAiPFn9z3ND89J4BEeFKoUVv5RVSaz2aN/3t4Y5o3dMW09yO84qRf9BwoOYwc1ilVeNua+Hd4JGrr5dZFTiLudoW4hYlIqY4+5sao3tMhzhCDQQeeKv9mhZGuVHJYv1wndJeTNlhQNT0Ai7D32E/YEPaYfvKXr5CLTi+5mLLqgqnW45p4HGwzln3sMOUKIk51Wik4nm8esUBWSzKeHtobUy7lYGx4RBo8HIosQ4gwJ7XPl1MmivfHvuWN4xG+UB4Omt8TlIiHazYETRlFGyGLi9YaulTmyPGt1UcoRfDk8aCArZNYjQlbPccKOXu3I2a6cacVSlSzafAFFCVddzefGJUsdgZeRcTFKKqbUT0U59GXMO2AhAlFsIZOgTQ0FZb1KWgsQEmmMcvxF3s5Fz5Q56BFX6I+ubJ9K/mVTaNvRL/gzVCaBErOOpZgOm2kBfYZGjF4c7gv8mvJkiUIfi66jRBcx9w1dtS6xD2ANjEyFO3QxNYZImgm3GVZLlIxp5qJorOTS6Ee19IMBhExKRC//3pjadqyZN4vydQAGaYva/ofis5yQ/WAkmpuNtH9TReXe1GRhd7kRrcdg==
X-Forefront-Antispam-Report:
	CIP:164.130.1.59;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(7416014)(36860700016)(23010399003)(22082099003)(10067099003)(18002099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	/d5RD94kt/AlpQUyJuZMqBEXjsYy46zLgXG2VWlGnHnwJKSD/NXoazUNwwR5TRoE/UYsO94i1ylpibqQzLtkSxUq1u7dyH2AQbFUNgTEGasqLsmjXVGlo+SX81ecQsPNn16QT86PPheinQOWGinLK/cQH9UB6MmTPd620XempIZrPDskaw2f56B8oJlOzReuX/Ojj5sfnZPwu4k3av1GRPtEGOjhT7JwJbl/Ij6+75Qur5/+kzfZDYFOirogMsNBg/TP7FK497Af7trCyPW/R9p5rLSEuJu5EU+Owkl2/LOhm/bmUfzvx1HnTLxfarBxYUiqEXAKrzQik7pUohgDWtOrjnAOiuTw7r5m37xpITa4w8RRo4552UNXsHvi1Q9gfAzW5J1zLJnsWXlrBQHiHzfzGMOHPfoymA6wYE4tWSZePj/F3/P81NaqH+kvPKfg
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 07:58:17.4191
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7326842e-591e-42b8-ce09-08df237f94de
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.59];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	WA1PEPF000099CE.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB6338

Adopt preferred style for the terminator entry for an IIO driver, remove
trailing commas in the terminator entries. Also wrap to 100 chars/line.

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
---
Changes in v3:
- new precursor patch to ease stm32mp2 support.
---
 drivers/iio/adc/stm32-adc-core.c | 19 +++++--------------
 drivers/iio/adc/stm32-adc.c      |  2 +-
 2 files changed, 6 insertions(+), 15 deletions(-)

diff --git a/drivers/iio/adc/stm32-adc-core.c b/drivers/iio/adc/stm32-adc-core.c
index 051875a67bda..745063b37b52 100644
--- a/drivers/iio/adc/stm32-adc-core.c
+++ b/drivers/iio/adc/stm32-adc-core.c
@@ -895,20 +895,11 @@ static const struct stm32_adc_priv_cfg stm32mp13_adc_priv_cfg = {
 };
 
 static const struct of_device_id stm32_adc_of_match[] = {
-	{
-		.compatible = "st,stm32f4-adc-core",
-		.data = (void *)&stm32f4_adc_priv_cfg
-	}, {
-		.compatible = "st,stm32h7-adc-core",
-		.data = (void *)&stm32h7_adc_priv_cfg
-	}, {
-		.compatible = "st,stm32mp1-adc-core",
-		.data = (void *)&stm32mp1_adc_priv_cfg
-	}, {
-		.compatible = "st,stm32mp13-adc-core",
-		.data = (void *)&stm32mp13_adc_priv_cfg
-	}, {
-	},
+	{ .compatible = "st,stm32f4-adc-core", .data = (void *)&stm32f4_adc_priv_cfg },
+	{ .compatible = "st,stm32h7-adc-core", .data = (void *)&stm32h7_adc_priv_cfg },
+	{ .compatible = "st,stm32mp1-adc-core",	.data = (void *)&stm32mp1_adc_priv_cfg },
+	{ .compatible = "st,stm32mp13-adc-core", .data = (void *)&stm32mp13_adc_priv_cfg },
+	{ }
 };
 MODULE_DEVICE_TABLE(of, stm32_adc_of_match);
 
diff --git a/drivers/iio/adc/stm32-adc.c b/drivers/iio/adc/stm32-adc.c
index 0a951a3adff9..e3719b29dcb1 100644
--- a/drivers/iio/adc/stm32-adc.c
+++ b/drivers/iio/adc/stm32-adc.c
@@ -392,7 +392,7 @@ static const struct stm32_adc_trig_info stm32f4_adc_trigs[] = {
 	{ TIM5_CH3, STM32_EXT12 },
 	{ TIM8_CH1, STM32_EXT13 },
 	{ TIM8_TRGO, STM32_EXT14 },
-	{}, /* sentinel */
+	{ }
 };
 
 /*

-- 
2.43.0

