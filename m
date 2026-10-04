Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011016.outbound.protection.outlook.com [52.101.125.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F349C3F9294;
	Sun,  4 Oct 2026 17:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791136146; cv=fail; b=Sg8yBX+hIRoiEk6pz9OfSbD7wHfARolc7hRRz/2qi1B2K5j5IveLPfVMJFjPhuuX5sCexLcuqq4kZHcguv1nMRFGTMrBis0Z6VcQNTJkjwyQ8IDl2xGfu/Np1TZQBd1Ag9SpHFuijJMKvyCrLiCviKapKCkVGgiBBaQdz66z2OM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791136146; c=relaxed/simple;
	bh=HD0QXQExBpmgO2J9uR2yo9q4NHJxk6B/vMykEVcGuu8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uXBCrvYZLW9WM+87E62hQRJGBVJ6raeQw50qR2K4jBEcoaZuI6qPYZ2b3lhWy6Fa2bRo7z0YtUvyjMLmGUngjB6cXVK6iK6hZ1A9HriIWpj1s/T71Z35l43sW5/6/pu1VGtHKREFnb8d6MAjzj7oRjduI61OH9/plXDKc8A6/+s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=KGINXBl6; arc=fail smtp.client-ip=52.101.125.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="KGINXBl6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dvHzq20+ddiR6mc7QicONTQRBmk42ELDZvDWA8nKc68R+cKJ4CR3TAUO/659nwPV4tX2q+GnAjQZ+jBOPs1EBklFvr5Ehr//2eeq+pM73BmA4zyqRvRqYJC0GGk4RTy29LdyKAqZVlySOS+cTXbLnjEzHM3ZxnWsaxQoWgvjMFsTDgRAQDaOChnAOsTOSDrqlPwLcUGflN2QbxtYKMgj/dm59XuN07dXy5U6SdQBTXcNO5eC4wj206ud/VaPuMUBjzJaRHPj1bD9nwVHI/EOfrjPBs0UpSgvlPVyIDSWtvlh260SfJmFrRUTBTLPNn+gS1ngx0pU4s2eVBJejO62HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W1au1m664aPV1dEr+16CAyfFsVSHm79bOn15MBCzAS8=;
 b=j19sR20OtVkxgc7p7r9I2QPKZC7hztND2tdvIuEfuapdSoWeZgMdfbUwPTZsX2w35EBQtaLXbdg4tb+/CTfFt02KhcHQL9NEAt8ZWDedfAWvXmgcKSetW7d8UfKMWDyY7r+muMeamQrMCXkQdgFFxeM9ps8rPEfb3VizTdMeyS6O4YZj4ctaLE/ku0R4PmlGzh1hYvckXy4AvPfeb/0LOsXfkmV0Bzg8tzOzHxrttzUSkSCk9q57DqR7Pjy7mO3atQZa8mK9MJDZeLDdlHAFeVGS1wWoYT91LNbVWmzQ9BNV9T+YXOiRZtI6TRmn9IzURlSn0UJ6VnpCF/Wu1JWeYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bp.renesas.com smtp.mailfrom=renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W1au1m664aPV1dEr+16CAyfFsVSHm79bOn15MBCzAS8=;
 b=KGINXBl6mve9vZejbLMyRs0Qbp0B2XckOJxb8lXX6dDE6mbK6EPVS8/qbcP/aTFobJ+hkxAXNFFihj1Ci/Xk035XrBX2DRQTq+tSjFFXBwcVUs38GbxF9ZuDzK0+dpsLVczY25aOFY8cpeWyxxE4KsMQYDbDh9G3Vr9l+jaMTto=
Received: from OS0P286CA0135.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:16b::20)
 by TYYPR01MB12560.jpnprd01.prod.outlook.com (2603:1096:405:19c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Sun, 4 Oct
 2026 17:49:00 +0000
Received: from OS3PEPF0000003C.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:16b:cafe::6a) by OS0P286CA0135.outlook.office365.com
 (2603:1096:604:16b::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Sun, 4
 Oct 2026 17:49:00 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 8.62.32.50) smtp.mailfrom=renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of renesas.com designates
 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 OS3PEPF0000003C.mail.protection.outlook.com (10.167.240.5) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.14
 via Frontend Transport; Sun, 4 Oct 2026 17:48:59 +0000
Received: from demon-pc (unknown [10.226.92.36])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id CFE783000246;
	Mon,  5 Oct 2026 02:48:57 +0900 (JST)
From: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
To: Biju Das <biju.das.jz@bp.renesas.com>,
	William Breathitt Gray <wbg@kernel.org>
Cc: linux-iio@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Subject: [PATCH v2 03/15] counter: rz-mtu3-cnt: remove manual runtime PM handling
Date: Sun,  4 Oct 2026 20:47:40 +0300
Message-ID: <20261004174752.507499-4-cosmin-gabriel.tanislav.xa@renesas.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261004174752.507499-1-cosmin-gabriel.tanislav.xa@renesas.com>
References: <20261004174752.507499-1-cosmin-gabriel.tanislav.xa@renesas.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS3PEPF0000003C:EE_|TYYPR01MB12560:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 54a5a60a-1d3c-4d82-bdc7-08df223fc568
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|23010399003|1800799024|376014|82310400026|18002099003|22082099003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	kZiVrI40JDCgnZsjdYZn8O2MukZdqXpnouUxXpf9P6e0WJHEFgIC5eE7IZgM8ngNaan67ClvLY4XbxGwp+fTDYKZM9SOo+yVmcQKSJWdfgkARrxg4zv8GxSElRrSQ6cNr7O2++5xBSxwN9gxFoP3XCAC4iIjSmdGaGXLM4uHN3XGUOHP+/AlgXOpqy+Bc+UczF3qljgRpdl6154R8Gae8lQ6hBGopVHgSKHcpuqKdWwA92rWoKFg6Sx5QjfWV3kWW9EBsYqTTXp8i8c3NrlRTR6elmizgvj9hQqwg+gJoGKkb5gOPxyMLZ6QgwrLzfp8nG/2olzuC1LaUfF9xd7E6aGptp/0IVAK5Rf20ZepTg3roZGqlVRLDnhVNbTmMxQpuMWsNLRRyhybcR/jyomphWZiBgrORst9SmTnYLrG1lvl+oeC61IcByzaHtLHFE02E1LJ5+7WWayzXRvAkPAbmvBihPHzt3fWrZzf+bGCeOHJccvL01MCl1GDV4pETVw3U9Ltc5HT0L2OP8g7RD/fWQ6psUN1ZtCxxMOOGRF0M9g6f7b8QTBrvoFmVUn6kuE8EUlkiYq8aifQI/n1NJgfgO7oFa3+D2V3wQL007hMwCAQOb+YIMsK7UdF/F/OkAjQmi7EHHMuu9Nw9/UxrSX9a5w0QLKN8cpRNaYSNCaEm8FipKbXnP9Mrmvy8z9X73owHgWIetYGPZ6FUViNgmqUXg==
X-Forefront-Antispam-Report:
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(1800799024)(376014)(82310400026)(18002099003)(22082099003)(10067099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	/I0hiTlHLJOoRTM1vG65pOpyq5g8oCBSocy6KGD0X+vsht6oc4FuGtgNfOlAifgAVbCoGQJfZ1wQUsOcX/zFahnwIwLnmQuWpwVCFNdSvE2S7iXeYJGw2xkPGAgdqmJcU0zgiLaf5Qn9farm+vGwu2Vra8Njq5bUl+eKsxltaDYMMvr2GzglZlTs+3SnEkbq/URKr9Vb+Edo9pfRk9wJZT9efAnFMOn0hOcr2cFgENyi1a+Vay8QbmafFSq3de5ClLr1kBqMfkLQY9ePjlrhWVwXhD58FxGfsimx0soIjuRKbyCBVUUXp/oIBUx62MNXf3xq1pL3HMujxYx9oN72WSMniYSXqNgpo2F0D3aovy3ya0KN0T3+TV5jsy3mdGnXi06xRuOCoKOIW6GDK78mht2TuFH6cbjdKbpll9U9raM1pg5n0H7rQBuMq1MxEH2W
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2026 17:48:59.9526
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 54a5a60a-1d3c-4d82-bdc7-08df223fc568
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: OS3PEPF0000003C.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB12560

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

V2:
 * remove struct rz_mtu3_cnt::clk documentation
 * remove clk.h include

 drivers/counter/rz-mtu3-cnt.c | 44 +++--------------------------------
 1 file changed, 3 insertions(+), 41 deletions(-)

diff --git a/drivers/counter/rz-mtu3-cnt.c b/drivers/counter/rz-mtu3-cnt.c
index 4ad71ed3d1e1..ecbb89c7e14a 100644
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
@@ -808,34 +805,11 @@ static struct counter_comp rz_mtu3_device_ext[] = {
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
@@ -852,20 +826,16 @@ static int rz_mtu3_cnt_probe(struct platform_device *pdev)
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
@@ -879,24 +849,16 @@ static int rz_mtu3_cnt_probe(struct platform_device *pdev)
 
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
