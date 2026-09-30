Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013028.outbound.protection.outlook.com [40.107.159.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B72F04E77F3;
	Wed, 30 Sep 2026 14:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790777967; cv=fail; b=ud8j/89VQzDasXyZHZ2DnBPemhpam86WjlLDmYHhgZKbDbI4uhQPRvZXBoavKaQomRmU9Nht2xeaPfZNkgEgrvN65B6y875mOF+nL2rPCgJMmlHv6auOYxAawlSaHvH03SahqFcYE+DiKPOYl20Pg5EqyMicwyXj7oOuTvAphWs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790777967; c=relaxed/simple;
	bh=5vJvq5/+Ts3dQ1Ku7FbuiRogZ+Xp0YuuoYHjlBrZjA8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=Quh4++clfWu4LXuFgxgIzARKEq6njYgDIyZy4GZsbFuQ+AZsQIhFlSLdDV34ClHStQZ8EKUnuINU6ky2qVVq2vvdv2Chk7r1zHpNKiGSMl0f9Pd3iN4qEkCifwmsZgfNfm24g5T544m1KvJ7gK3IBv4C/DxBpdLr69F0ZRF/J/Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=ZBh0yNk8; arc=fail smtp.client-ip=40.107.159.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="ZBh0yNk8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NCIncjNUuj0dF2nazmxc1clns+zu0uALpZGMc+j6jDJlJh1gWgSJ0H8FErwj45/wIppU9kDOdu4WmDH9X9AGU3PijuaHke8jpH3XhTZFjbTEmZuaW0CJxSp31y59vTEdSCkQIa5tZjbUm6RUhvxEJz2jck4xqIozq9blZOzV/sSkC7DMyNfPMamCOaZHMtRCimSOfhdV1KSnTWLDfVlTCE3m3GLFfRMChy/Xnfp/3ONmQdc+tzTKzc5DoTR38bgChq+FimXaqSyxS8fHgIiKE3PPahp0BhUodW93VvBXx9edXW+BGy/M+6CvM4swZRlMLqkUUCq3IG8xXji/mk3xUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2c1W5aPunJVX0+slMtxZ0XU3mtwUn20NrqA/1eEaUJg=;
 b=HFOt5wQfbO9tqu1E0+2xf4OOIJfsJfrwIUdYtfB+KNBT66RfIHOAEVh1eHxhxfeMdr0lQhGTgfdC5Sp6oJfg0jJpRGikkpu9+fdNwrpu3Wt6we0vYePLbRZztuvopRu34F9b47OW83C/WsoGkesxspQ5bEM0+PrnhN5Rpg19CIEUJAvE1p+L1AM8Z8lfpNecpuqcHXSutgzfMB9feUwkUBMKjnZe6Jvn4MsidWxQa1hIIySts+laxVYWJzTwCgaj0c9ciLWSR/qMIHSf1LrBduZTDuPxb19bXo9esLTw+PfiPRZ6OkZaeKITYQ/YAWn2g7FmxyTRNKuBAsoaeJ8Hwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=baylibre.com smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2c1W5aPunJVX0+slMtxZ0XU3mtwUn20NrqA/1eEaUJg=;
 b=ZBh0yNk8wY5ZaneMvfpwj9zHIFET7amkqTDtXMJeGWxo9Ky0paDPh2p1s6siwsR+4VR5GRcVH0z8Ml/nR5H9J9PKRIayGy4afjAJGdijz+cIFbrO/Ijwd9PDAOgrcSpVfd6b0D39re8SKXo5rr2mD+rO9JfJ2jrwVMFReoE78eWntumREqnuf7e1pZxxLSV3AsoT5oQGgOxR0tRc/ur53wWesp5YKP36MbhCjjRAiyxFr0m72QreQPc4mGQyG3Nfa70HN5Ed6sZ9b9LaRa0svMihCIXBI62S90ytKzbZE69/dFKOeGWc3w/uSOtcUNM0sc1ldQ1xK8PMGeJnxRqwMQ==
Received: from DU7PR01CA0005.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:50f::28) by DB4PR10MB6142.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:38a::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Wed, 30 Sep
 2026 14:19:16 +0000
Received: from DU6PEPF0000A7E4.eurprd02.prod.outlook.com
 (2603:10a6:10:50f:cafe::69) by DU7PR01CA0005.outlook.office365.com
 (2603:10a6:10:50f::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.15 via Frontend Transport; Wed,
 30 Sep 2026 14:19:16 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 164.130.1.59) smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 DU6PEPF0000A7E4.mail.protection.outlook.com (10.167.8.43) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Wed, 30 Sep 2026 14:19:16 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Wed, 30 Sep
 2026 16:25:48 +0200
Received: from localhost (10.252.17.140) by STKDAG1NODE2.st.com
 (10.75.128.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Wed, 30 Sep
 2026 16:19:15 +0200
From: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Date: Wed, 30 Sep 2026 16:18:28 +0200
Subject: [PATCH v3 07/15] iio: adc: stm32-adc: preferred style cleanup
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260930-adc-stm32mp25-v1-v3-7-406834430d72@foss.st.com>
References: <20260930-adc-stm32mp25-v1-v3-0-406834430d72@foss.st.com>
In-Reply-To: <20260930-adc-stm32mp25-v1-v3-0-406834430d72@foss.st.com>
To: Jonathan Cameron <jic23@kernel.org>, David Lechner
	<dlechner@baylibre.com>, =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, "Andy
 Shevchenko" <andy@kernel.org>, Rob Herring <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, "Maxime
 Coquelin" <mcoquelin.stm32@gmail.com>, Alexandre Torgue
	<alexandre.torgue@foss.st.com>
CC: Marek Vasut <marex@nabladev.com>, <linux-iio@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	Fabrice Gasnier <fabrice.gasnier@foss.st.com>
X-Mailer: b4 0.16.0
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU6PEPF0000A7E4:EE_|DB4PR10MB6142:EE_
X-MS-Office365-Filtering-Correlation-Id: 2aabe796-3875-4627-26a8-08df1efdcf88
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|36860700016|7416014|1800799024|82310400026|376014|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	L4Pp+JxPtLUB76LN2fYMWxcntQWBkW1d0fme2f9TPogrOJ0JCa/jAbN5uUpMbZVxi8BfEII+5b4GsdrLGCbvf052tp0E1lsL1rr99tWPSzf14ywUpB/AmO7G36jTyxiQ6xsrnARFp7R/qHUVRwzUff86yy1gyMYZRN0gnXUsjq+wGfQqp8wNBmQgs4eC7AP5ksAjcO3aF/MXcbyjxqLEMRQqZqq0j/llu3ZLmbhJcWYd7/KmSE78HkLJDPLsNyjAhBofhZmQO/y7sQB2V2bmBbbyyKKrGJbi82oNN1dG9K4H22ZDK9DS9LxOwoVxch4Qv0rCAkAOHPv+FnTH/zzH4L+5GVl6Hnwt94LXzdkTfx9jtA6MmLpH0iZwjy661ohIez+Ew4/XnLXuxk2BAniBEvxPHG+Gr+2ew22NNBtKaUmKhU9h9YcgCDs7/NGXWlzHMVg+FnYRyFZFYs891WXK6V6AcxUsHC8ucDxoEsfbzjgaDxYgw1Yfmy1XbZw0B1veJJop8cIHqpiZ2yaEblDV0oi8JKIItQ3eLemzZhCAXTIvGiYJeFAhZgsektm9C+iYtsEUfw7W9f18w0ixe1WAcU8O+KpuUx7fblVwCZ2UhjzhJ0pgzd7DLuwcjB3KUV6ewXBFWHmvfpPTkypyMi6ktv7zYIRkFVf505um60INhU+3ugPzDj78LYo9JcN9TYjAxwqKK1bmSYtrqtqlxglpYQ==
X-Forefront-Antispam-Report:
	CIP:164.130.1.59;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(36860700016)(7416014)(1800799024)(82310400026)(376014)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	WcwlaTjzQGxoYxOKkqcQe+sGQ4qRTSG795IPJKk+/m3WRgDjwG+MVgeg3Ksvll/dpHc+aRMTLpKq51jyZLv79cWiBTiWuNzZzSh2EDE6D/NBufOOcXlTblTrTAITXhxmlYU9S3Rx73dotpgNYL9gkbRtty2ajUtU+n6lAuaGnr/9QWa7xH6Xxu9jibfrGlaYOrwc0JTkxulw77TdwL8thfxnfuet/yFhYBV0X0aN2HjeqyHL0FASVmlMmKlHBDWMj0crVUcPWBd+expUwnOqzTr1IGeouZMz5Mf2Ko66kHMFKlbJ02yo4umquMdCh598s6+9kk/zFrTdreZsV5+GWIlis+6NZL7QUBC7TYsWiWLkBhb/vlqPXrANy0T+NLetSWYcdet8bVXqyR/X6cHFxz61k9KDzL8AdhDygXsdzNw9u/TUCHR3gtE+qxAjt0RX
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 14:19:16.6146
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2aabe796-3875-4627-26a8-08df1efdcf88
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.59];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF0000A7E4.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR10MB6142

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
index 9c99c5044c47..dcaf305edec2 100644
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
index 92c6fba10f31..c1979f1f1738 100644
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

