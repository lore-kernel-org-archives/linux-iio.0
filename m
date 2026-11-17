Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.229.56
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794911242;
	b=hFSaEL2RIPHN/GwV2SFDjzjJi0cXopp4VdKS5oTxwatKJ7NvRjtBX25zavjGYSsErVHW
	 6MzGrpTXBY4zi54ZZ6fpaRE59wVsKJ7kPrMsNsYDtr7GpwqiTH5dhrYfOgtpKfsc/6auI
	 PVlc+Wdl0nwqY0XjN0eovUIUx/g9OxV6jxXbdDfgIV0WzgEBh481qMDlPvsBVEPx+o7SK
	 cNQfDmNH3c2P1D7Ki6nao4r20L/xdwRzC4sfx3Q4rqYYty8pKT0nA7yOY6P76LV0jePci
	 n67Vh07d/Eq8hUzrTAOKLYU8LpicfdmiWc8jPJIu/vl/k4+N+/HQ1CJN7uanS+Du8yw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794911242;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:Content-Type:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=e/FOIOsRw3byegVvOtQd+XGFBSava8APWAz2wafIxMo=;
	b=DtJsEZ7hciX0BWgbNQ+KU048s2Z2BhQZKEU1yrVPV6sLnws41MJcDx/68MIeB1lFtHX9
	 Lm3RhbNZNTBMHzIITpXeYks9EoMvNflGkPGEMgQb/U8ThU7Alf5jyayHz3O14k5XjgJqY
	 5catihRbNKzQhD95TR95J9xrT+UCCc4tnQt11ZHI6Lly7rnZUMlo5bROX2lPRef4n6lzw
	 796WPQfUhzINJVbe70NrA4HDm2d7Rav8mMhNX0f/cBt6qDPPjrs33zTnMjJ0m75PiUeP+
	 htsjKh3jPT+9aGi1JaT4237i7QiGEHD5btIVtV72U1NDvlHn3wce30TykPAuQ2mnOOw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=renesas.com;
	spf=pass smtp.mailfrom=renesas.com;
	dkim=pass header.d=renesas.com header.i=@renesas.com header.a=rsa-sha256 header.s=selector1 header.b=JTdJFUhi;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.229.56
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010056.outbound.protection.outlook.com [52.101.229.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 700C1606A338;
	Tue, 17 Nov 2026 10:27:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 700C1606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=renesas.com header.i=@renesas.com header.a=rsa-sha256 header.s=selector1 header.b=JTdJFUhi
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ryrc0p3XnoHdA2TWoH0+XLRPMuBJY5WLDqDEtJa4kjHICRyCYFczanxMtcB78mpoL8hCJBTSz0m2iCZhhvw8XQRRT/l/lPCJsv4rVKnS8yBCpFohYkeRrOTTNrJ9DuUFO84FWYZoMd1yF4IRsr7GRp7huRw9sbA7GpFjRq2C0Sdiy51KSHZ93+HwopGyGby4I3x0hWtuNxuvw+B4gnrQ4fFINYBQvtnzEffWhwTsBRyuxyUD6rYW/6JZJB7PETGab1YXoVFoBUwn2ac68AZgaYYyLtW3QBY1Wi+JOYozBJGGj8lZU7Bs5bjz2HHvN3A+38rNbELHS0sSRzC8IRJbJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e/FOIOsRw3byegVvOtQd+XGFBSava8APWAz2wafIxMo=;
 b=UXasrVmmgxuTZBJXQjyMIaZoXrrGTCECd+Sitx3+ic4cc0kFeYhrUak6bd68KeuQ8kB5iGX6Lw0H+uvPZ3jJqzBDQZdOiKoCpkDp2sNdgrVS8PjyRTaocAzayARUxGrdLD4L+JlCXHUY8XeGxjBnEyiz11o+88KeE5cznNIxvJ2l202wYJjYfGOHynXOfCbMV4+rZIAOowEv7qFIwFWqBlpE6s9S+rbPy0dMsUCevTyen+VhYLfEn100AP+9VsO5Tm/KysM8xNOI6LEjR+vWR7ttEnmj/eGhho+WZvWU1I4NMzxbEG9p+1iNDkhJ3CDd3gkkv7qPrLHtbwGopfvfZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bp.renesas.com smtp.mailfrom=renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e/FOIOsRw3byegVvOtQd+XGFBSava8APWAz2wafIxMo=;
 b=JTdJFUhi63b0lXkb8p0oPKnlmMr5pqOMOiaB+cN9QPdZ6RYa3kN9SGNEEPnsgbLnF3WFbDGiSPTegm91n4S8hMg2k/2pzTfZDexR1BZpnpM5NCPz4rvfEijqKwNTuWxrQbAyYPm4ugj2pQ8UwMv5JcE4hC/GPKFwZkg92uy8sVM=
Received: from TYCP286CA0019.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:263::13)
 by OS9PR01MB18354.jpnprd01.prod.outlook.com (2603:1096:604:4aa::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 10:27:18 +0000
Received: from TY1PEPF00046B4F.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:263:cafe::d) by TYCP286CA0019.outlook.office365.com
 (2603:1096:400:263::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.10 via Frontend Transport; Tue,
 17 Nov 2026 10:27:18 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 8.62.32.50) smtp.mailfrom=renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of renesas.com designates
 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay005p.adwin.renesas.com; pr=E
Received: from ejcrelay005p.adwin.renesas.com (8.62.32.50) by
 TY1PEPF00046B4F.mail.protection.outlook.com (10.167.253.39) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.4
 via Frontend Transport; Tue, 17 Nov 2026 10:27:18 +0000
Received: from demon-pc.tailc3dc73.ts.net (DEU-5CG5050QD0.adwin.renesas.com [10.226.92.253])
	by ejcrelay005p.adwin.renesas.com (Postfix) with ESMTP id A02AE3000255;
	Tue, 17 Nov 2026 19:27:16 +0900 (JST)
From: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
To: Biju Das <biju.das.jz@bp.renesas.com>,
	William Breathitt Gray <wbg@kernel.org>
Cc: linux-iio@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Subject: [PATCH v3 02/14] counter: rz-mtu3-cnt: remove manual runtime PM handling
Date: Tue, 17 Nov 2026 12:25:55 +0200
Message-ID: <20261117102607.2504551-3-cosmin-gabriel.tanislav.xa@renesas.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261117102607.2504551-1-cosmin-gabriel.tanislav.xa@renesas.com>
References: <20261117102607.2504551-1-cosmin-gabriel.tanislav.xa@renesas.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY1PEPF00046B4F:EE_|OS9PR01MB18354:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: dc3f0cd3-4735-4328-8042-08df44955b8d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|23010399003|36860700016|10067099003|11063799006|56012099006|261022075727099003|261026140227099003|261021121427099003|261021135927099003|261026121527099003|261021123027099003|261022113327099003|261022105027099003|261102123227099003|261028144727099003|261009221227099003|261009221727099003|261009223327099003|261009220027099003|261009223027099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	i5VtuVyr41upc9fjfO/poPdKdoK1VV/KEZIsY83cG4VRRoYjobXxF1gvJQWHMCkqlcyP3OTsZcI5KsRACYa6mW+IrMPiIy2oIPiekv1MERLhDunF4ARJEkOUijBtbzL9nQ9IJPNfTLrVW/pxjITcdTBMqf34I4ahmJnE3DPygVJgl3K8jt0+/hGGT+fkxynzKL75v95oBssTLOcjbZzSA55jkqEpMFJ3vI8tMDjjNcEnrX4MBKZQU0K3sxUvbGYSk9XgfopScO3AnYryVDgCBPtKi+7QMtHIg1W5tZgN61pDPDWR5+PCkrPqQOZbb6Ex0W8uu0Pmv6LY1rBxzVOVBQ1EHMqVtKxA5CIASkF6G1KFX7lMBmCV3TYWNZTaEXQYcrpw0/X2VqTcbbnolgviBSrViWjugN9EjPj0Y6sBP58jpDAlg8Pc0lJ/Y1LipGBK/QUco5rFJ7S1pgrPII2bq3udV0IE5aPVwIKElld3W+Wg7RO2Fp0WEQDfl61ni6g0FAWL3BYVCHMD5b4/FqlzT8Dsi1tQOSwT3n36gpzitimP0UQJeKoGR3Rayx7MdGFgqZgr8cJ3tMQ+FjvHlvAoGCA6ZyWqS3HXuX1CjS68kfluDLFjw2mdqllgbTYQz5VFlghAelyyh/XiwFnjLMrT6hBFA/iAflvFQUzZc8t+H5nD2E69ykOmcQEzEwOQFZnVBwXCo1Et/83Ez9BefVZyAg==
X-Forefront-Antispam-Report:
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay005p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(23010399003)(36860700016)(10067099003)(11063799006)(56012099006)(261022075727099003)(261026140227099003)(261021121427099003)(261021135927099003)(261026121527099003)(261021123027099003)(261022113327099003)(261022105027099003)(261102123227099003)(261028144727099003)(261009221227099003)(261009221727099003)(261009223327099003)(261009220027099003)(261009223027099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	j8vCfRJe/NWaPyMc/fcMDdOIj80EapmbZTuxwhTgXdph0iQ05veGdvT0rO4zywAP60mPooibdP2bgdTtUoNkTWQvN5sS1OrAhRU81cJAe6fJCUlEiTXcGxm3xxnNMHwCSq2dEMOZR2yAPNYpbdTpDAuoe51jjcYBfYB42genMUfx+hGaWH0l9+WiXRqoaVnkDCfQrRVxkg+UkLq+TEjcKMs8hgTvvmkGiBszSSDPe8OGGLYqWBQG4TU61awfw0RND/a35b/Gm0gOAN1EAWK2rlERmUaZAOwLA8NGlSbT5cOSxVnQeslUQsoTBx/UKon4XABsttcdcAS9TI8uqXZmExeq5DUOarPdTJi+iFmcSn2qrxqNp+sOOqKH1cBjcLI6s4lpqUP/uF8jK0GxkgXS9owUWStnKY78RTBrFwZRYfTRjSOxQ3gmYUX6IPmtMLRR
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 10:27:18.6209
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dc3f0cd3-4735-4328-8042-08df44955b8d
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay005p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: TY1PEPF00046B4F.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9PR01MB18354

The clock is already managed by the CPG power domain attached to the
parent device for all supported SoCs.

When runtime PM is enabled on the parent device, __device_attach()
temporarily resumes the parent for the duration of the child's probe and
drops the runtime PM reference afterwards. Runtime PM usage by the child
device also keeps the parent device active.

As a result, explicit runtime PM handling in the counter driver is not
necessary. Remove it.

Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
---

V3:
 * no changes

V2:
 * remove struct rz_mtu3_cnt::clk documentation
 * remove clk.h include

 drivers/counter/rz-mtu3-cnt.c | 44 +++--------------------------------
 1 file changed, 3 insertions(+), 41 deletions(-)

diff --git a/drivers/counter/rz-mtu3-cnt.c b/drivers/counter/rz-mtu3-cnt.c
index bafb8ef82afb..d8f13c5ac525 100644
--- a/drivers/counter/rz-mtu3-cnt.c
+++ b/drivers/counter/rz-mtu3-cnt.c
@@ -5,7 +5,6 @@
  * Copyright (C) 2022 Renesas Electronics Corporation
  */
 
-#include <linux/clk.h>
 #include <linux/counter.h>
 #include <linux/mfd/rz-mtu3.h>
 #include <linux/module.h>
@@ -65,7 +64,6 @@
 /**
  * struct rz_mtu3_cnt - MTU3 counter private data
  *
- * @clk: MTU3 module clock
  * @lock: Lock to prevent concurrent access for ceiling and count
  * @ch: HW channels for the counters
  * @count_is_enabled: Enabled state of Counter value channel
@@ -73,7 +71,6 @@
  * @mtu_32bit_max: Cache for 32-bit counters
  */
 struct rz_mtu3_cnt {
-	struct clk *clk;
 	struct mutex lock;
 	struct rz_mtu3_channel *ch;
 	bool count_is_enabled[RZ_MTU3_MAX_LOGICAL_CNTR_CHANNELS];
@@ -807,34 +804,11 @@ static struct counter_comp rz_mtu3_device_ext[] = {
 				 rz_mtu3_ext_input_phase_clock_select_enum),
 };
 
-static int rz_mtu3_cnt_pm_runtime_suspend(struct device *dev)
-{
-	struct clk *const clk = dev_get_drvdata(dev);
-
-	clk_disable_unprepare(clk);
-
-	return 0;
-}
-
-static int rz_mtu3_cnt_pm_runtime_resume(struct device *dev)
-{
-	struct clk *const clk = dev_get_drvdata(dev);
-
-	clk_prepare_enable(clk);
-
-	return 0;
-}
-
-static DEFINE_RUNTIME_DEV_PM_OPS(rz_mtu3_cnt_pm_ops,
-				 rz_mtu3_cnt_pm_runtime_suspend,
-				 rz_mtu3_cnt_pm_runtime_resume, NULL);
-
 static void rz_mtu3_cnt_pm_disable(void *data)
 {
 	struct device *dev = data;
 
 	pm_runtime_disable(dev);
-	pm_runtime_set_suspended(dev);
 }
 
 static int rz_mtu3_cnt_probe(struct platform_device *pdev)
@@ -851,20 +825,16 @@ static int rz_mtu3_cnt_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	priv = counter_priv(counter);
-	priv->clk = ddata->clk;
 	priv->mtu_32bit_max = U32_MAX;
 	priv->ch = &ddata->channels[RZ_MTU3_CHAN_1];
 	for (i = 0; i < RZ_MTU3_MAX_HW_CNTR_CHANNELS; i++)
 		priv->mtu_16bit_max[i] = U16_MAX;
 
 	mutex_init(&priv->lock);
-	platform_set_drvdata(pdev, priv->clk);
-	clk_prepare_enable(priv->clk);
-	pm_runtime_set_active(&pdev->dev);
 	pm_runtime_enable(&pdev->dev);
 	ret = devm_add_action_or_reset(&pdev->dev, rz_mtu3_cnt_pm_disable, dev);
 	if (ret < 0)
-		goto disable_clock;
+		return ret;
 
 	counter->name = dev_name(dev);
 	counter->parent = dev;
@@ -878,24 +848,16 @@ static int rz_mtu3_cnt_probe(struct platform_device *pdev)
 
 	/* Register Counter device */
 	ret = devm_counter_add(dev, counter);
-	if (ret < 0) {
-		dev_err_probe(dev, ret, "Failed to add counter\n");
-		goto disable_clock;
-	}
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "Failed to add counter\n");
 
 	return 0;
-
-disable_clock:
-	clk_disable_unprepare(priv->clk);
-
-	return ret;
 }
 
 static struct platform_driver rz_mtu3_cnt_driver = {
 	.probe = rz_mtu3_cnt_probe,
 	.driver = {
 		.name = "rz-mtu3-counter",
-		.pm = pm_ptr(&rz_mtu3_cnt_pm_ops),
 	},
 };
 module_platform_driver(rz_mtu3_cnt_driver);
-- 
2.56.0
