Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010005.outbound.protection.outlook.com [52.101.229.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 811D549F12B;
	Mon, 14 Sep 2026 20:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789418247; cv=fail; b=DMV37Hg5TZlL8g7coMF62Q3KCXAGlAmUSoJpm38bmyHdDqSweHWGfpjO2Gc99EbE7FmCKJ+cs+PEjWBA8djZaMOUz0ELbnMoCf9pXs1xUPdAtNyCX9rKtCuwX4SnkyGOpeMH73kqpOBwXUkF2TWa3uFpDvMIAEWN3UahWlrRNi4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789418247; c=relaxed/simple;
	bh=AD+zywaqsFMKbiM6GT112mLj0cZM0PDU7j3SenrG+S8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BebppgWlsJpMY/tM70p1Fred3csVYuhJfz+5PhrvPf7DnN+d33Om6Pbe8D6Osh8VSBQx3hPaVRoj2Mcx/c9yHdRU2vXAtLD78ByfI61+PFyetdHlcxDvTAkT6F6kka31sLUevIayl/wYM4ir1F4rbCfzvmhJPLc4QwQniZ6NFQU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=V7yaN6Cu; arc=fail smtp.client-ip=52.101.229.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="V7yaN6Cu"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WxrT5v4Laa/CfD7b8Ghoxnxk6frEym30+b+NTpZJJP0FHu0nNK46g+5INHMJwLR5QHq/fIrdAhjeON1lIaYMJU7MOQdJx8PTLGqbNC8X+OqJvYfqkUxCrCTyNx1a8DFbAI56i79mcXg5JQgSSHPGlw8KoiIi/1fq4KEpPsYIbLKFsoeRzXLiVuemhaTbQ0kxlSTOqr/HxAs4kWecV8F0sOaDk1CGvf0utlZXtNHgGHS2qbLkDmzbgqlMgcmWoaCnxjg4b9NeK3Hl/xw8VWem0PK8ka5mAXZe/d5LR/W3YrxhykCYA6aaVaz7DbjtdVIRPKZ9iZupgAJruSh8x8uSiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GauizuleMuTHo/B2xCiTqWoAUunM8m8JYatwz+NiyaY=;
 b=KFhbsZ5LEeAJFMeEqzQdZaLn9yCQ5AoNSKuSTJMozfnEwrzMp3v1xpxaDaH0+JcXRDWfSYs/Ltpm8ynhYRx4FuUxnV9LlmxT1oSEjzZn+EuVS3Wf1OZioANj1oviJymjgpnDkV2nLk1ZoEYgKcEN8rE/p4h4mlOXM5rHfX+zJGQs3KBVZGmX91kLikKNV+2Gw7cN7kCvX4qSU6YyfAtSa7srHa5hFP3nSzL3DEwgfmzoqeuOQlJBeqJaYTcMLxY8pmcknlAjSQZRi6Qm4PQ8eegqTLXphEizjtZhUZ1u62qD8hLJWrT13bhkKKrhcne9Md6GXEpuQPu8eX8wuF1M9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bp.renesas.com smtp.mailfrom=renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GauizuleMuTHo/B2xCiTqWoAUunM8m8JYatwz+NiyaY=;
 b=V7yaN6CukhG8GNdAFur5omvxcYbupa/3v3g1tm0GqYWAWP5gWmjokNclxvlUwhT2UJFqXx0hfpe2X3/Lk4TbCgp5J+SAnkzqkXmWYoF1tF0wrmPDOK6yt5/XKehsBDN3Vv7U86AgDOfbk2usy9/XnpXjWTVtVQhukS0n6FDOdCo=
Received: from TYCP286CA0275.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:3c9::17)
 by OSOPR01MB12345.jpnprd01.prod.outlook.com (2603:1096:604:2de::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Mon, 14 Sep
 2026 20:37:22 +0000
Received: from TY1PEPF0000BAD8.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c9:cafe::7) by TYCP286CA0275.outlook.office365.com
 (2603:1096:400:3c9::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.12 via Frontend Transport; Mon,
 14 Sep 2026 20:37:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.62.32.50)
 smtp.mailfrom=renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of renesas.com designates
 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 TY1PEPF0000BAD8.mail.protection.outlook.com (10.167.240.37) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.7
 via Frontend Transport; Mon, 14 Sep 2026 20:37:21 +0000
Received: from demon-pc.localdomain (unknown [10.226.93.156])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id 70F173000368;
	Tue, 15 Sep 2026 05:37:19 +0900 (JST)
From: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
To: Biju Das <biju.das.jz@bp.renesas.com>,
	William Breathitt Gray <wbg@kernel.org>,
	Lee Jones <lee@kernel.org>
Cc: linux-iio@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Subject: [PATCH 03/15] counter: rz-mtu3-cnt: remove manual runtime PM handling
Date: Mon, 14 Sep 2026 23:36:02 +0300
Message-ID: <20260914203614.2035277-4-cosmin-gabriel.tanislav.xa@renesas.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260914203614.2035277-1-cosmin-gabriel.tanislav.xa@renesas.com>
References: <20260914203614.2035277-1-cosmin-gabriel.tanislav.xa@renesas.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY1PEPF0000BAD8:EE_|OSOPR01MB12345:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: b1ab49a4-0033-4e4c-8e8b-08df129ffa5e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700016|23010399003|82310400026|1800799024|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	ZVHCoyDB9LWYDwUUSxGVfrAJnNqz1Bgf4X5oRwhEbyIjsVBjR2Klnulz5tqmkJIA0KCQYceX/V5dZK24zPTX7CzqpAtxSTD/S0BPtLqV/AWm117ivx3avr+AtKWtLwSqEkUYHrjVnG5XCWm9FFix1C5hL9IYrvhBeUyJv44JJHx778LXpvCcYXhLfewJyGZ3AhXe2EExLiirxrIVpZguVu+/1QuO1+GnOLwu4DikuzdVw3AezK9oQLlI6O67W+7t61C2kO4o+CQ8J/yeMW76Nf2uFJuU9Ob5sTqfu7velx5Ry+kfCjT8RPX04gGthEfh1UTK9MX29P9wuEQ+V1P13cgy8+G8lGiryEWy4M5vdQGnaPWCjMpBzKIxgvKG4F48L836jvZ5UokEdSwl6+AhUgsi48rlqaosr1NNXvp+HofIneyzs8GiUluMsFvblRZg38rGXAP+JfhyEVFZIKWYjtg22g5QODrBrjrUF+Rb4DR9DA7m27qvGP3LUIOOsQjJHqnxbhNIWyl4U2R8CKsJ0jiJo74ystpNo4OY0fwrd55qyNMRmchHSXYVbHSelepLdx78PN8jAxlxIjC9ZimmCkPqbFYrIHqtkpYCw2755gaWilkT7q09B7dBjNz1eYOLntWRh6VZ2yqYJWLZdqYeXVo4sHCm4kEjdQ8oBWkXItZ9Gebhbf6twLQ8MbJwNIZ+6O+4uHf3jkXTZdIIrw86Tw==
X-Forefront-Antispam-Report:
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700016)(23010399003)(82310400026)(1800799024)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	SkOm1o2KIc9TjV+kM8O0sz7c9DWpscOqd1tId1YR4jLzRHaKdEPWis7/U0aagNsa2iZaivi9TwJNxSi67vN2lvT8qoZkaT5L5VCmWQjYESZ/Ool9FO223dOaCovZxQw37lO6Ye7gdI/RT/uOlQogD2WDublEQjdDgGYy0Vs4m/4DZkZbe1gZhVTwhqLE5qNC7Ui4btbIsxutS2QQnEjd8RQoGbDf/OgVTK45Ix9+5q/IDfcX++Ilavu3bUULVY+19q2vckPpLyyvxZWEfdvhNIh5eMxPbQ36amjdVFWkNL5MTc26OY9lJVUbaAv5TkBvJT8yNgwTZqbblinqm5MgZM8wNiomqRxnlsSTsIsUoYKMT3GZA6MOmKEZFud9wDi9OjyS9X4xTTt7B+7Ii9uXzfmyZJvlVb1uZnLB2uXmmMGTpuCKj95DL6oiWte2YG4H
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2026 20:37:21.8984
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b1ab49a4-0033-4e4c-8e8b-08df129ffa5e
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: TY1PEPF0000BAD8.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSOPR01MB12345

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
 drivers/counter/rz-mtu3-cnt.c | 42 +++--------------------------------
 1 file changed, 3 insertions(+), 39 deletions(-)

diff --git a/drivers/counter/rz-mtu3-cnt.c b/drivers/counter/rz-mtu3-cnt.c
index 4ad71ed3d1e1..6c171a741cc3 100644
--- a/drivers/counter/rz-mtu3-cnt.c
+++ b/drivers/counter/rz-mtu3-cnt.c
@@ -73,7 +73,6 @@
  * @mtu_32bit_max: Cache for 32-bit counters
  */
 struct rz_mtu3_cnt {
-	struct clk *clk;
 	struct mutex lock;
 	struct rz_mtu3_channel *ch;
 	bool count_is_enabled[RZ_MTU3_MAX_LOGICAL_CNTR_CHANNELS];
@@ -808,34 +807,11 @@ static struct counter_comp rz_mtu3_device_ext[] = {
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
@@ -852,20 +828,16 @@ static int rz_mtu3_cnt_probe(struct platform_device *pdev)
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
@@ -879,24 +851,16 @@ static int rz_mtu3_cnt_probe(struct platform_device *pdev)
 
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
2.55.0

