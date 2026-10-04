Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011006.outbound.protection.outlook.com [40.107.74.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAD73474255;
	Sun,  4 Oct 2026 17:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791136181; cv=fail; b=rh7/6QSAz65KpYY17chN3lzlXrHs2wZs2ksUTrWBcusJsla9dw/iMBFECs7hwY0nXQwRKC2e64zFq3/K4MlmKJN+x18OUZK32rFQA/FPT9OLVfTEy+MP5zTi5/7NWEfyDFSFlqCTh/hrDiiOFzMpKTspTpimZ9LQzJPy8PQ6EdQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791136181; c=relaxed/simple;
	bh=Eqzjlw1Z0Kc9QKnWBh1Go4r/gHGZGQGp3cbfFmPFoDM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OxWRrQE/KqEWyS5nEzS47Zyhcgl8PEkr6b3yeoXH/Po9L1GUm1fqT5QmxUzLIahFz/3zCiynv0FKE09ISsdRgc9UV4EjY2Ug2okAi2yLdOzRLSlkAoqnAcsaAYrTk7G/9LYQQIMXPtUH/1UKeuq+PcOYplnzEOusMIXuJBeeGrQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=N3O9zP1r; arc=fail smtp.client-ip=40.107.74.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="N3O9zP1r"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b5Yl2PzspRfj6YbKFDv0ImS+keKJK10nbkOHwPC+lcG3IYFrqi/d2NudpgQAMLJPbv1vEGhnT62yb0H+VQy3dv6e1OTgIWctJiXmpU7AImi18TnFK/dWKSObClr1zGs5G3hPrEyD5AZsCZ/8Q51YlQGKJMgh9A2nwuYgd9Dt4VuzOVpCnTFHr5QDxHAm7QLSlspLpm3S4KMBjF9fEQGBANroKgn8d5ApmxM1kUYuS/HaOzbzzvLOHkevBjytP+3Go0HEKL+FSk9ibJLQ+TvNEPhHVQT7Zg/T2fWLaarKF6waQ3u6boqfwRcyLSO4oJwuhqMc6iEaBL83/uD4tSE0wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B8uB2BA4Hs5u9TCjRXZnMYZxitigf+c7yMortf2m6JI=;
 b=w5x4CzMldIqgIb88Lft4bf5+2Y2Ni7VPyUyYy+pwRm4FihomCwN+7FXrsupWH5G3cBPYh2gdJ3oGiWbwOJzDHshYfUGznyqKOg4BSHhwErvBxlAara1KTwaDCGrhHVirg8qslZLL7n6lqbPPE8XSCpfWT5eo4zTfyhOOfw5v7aFluG3dXdzIAIYRGtpzozgt7XUAKuLWYi1l8VvuaU81YK0rzXF89SJxChVtPPmvKoF3a05yJ4P8RQbtwiiaq7Wfd51QdL9NDiPk6PTJr1x9agNrDbCQtbcBt2LY0La2o0fR+xOZcVmPo5AEGejNbbH/pOuvoAEQXnxy0CLYLOCEFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bp.renesas.com smtp.mailfrom=renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B8uB2BA4Hs5u9TCjRXZnMYZxitigf+c7yMortf2m6JI=;
 b=N3O9zP1rj6m3PZhTYwWGGAUvktKMn+ipviOh5uGf+mEEXMo8ZIizkp5jY/jjT1cJk70cZAYQAIvWT8mqgNAqC78fV0fSm+bJbsZb2ACD4f/rtwwbSZTbRN/3Wnci14npnx5ZvpDlRaiS57zWJBAtAWoj0BHSDNB3y7TBFxdUtP0=
Received: from OS7PR01CA0069.jpnprd01.prod.outlook.com (2603:1096:604:253::15)
 by TY4PR01MB15967.jpnprd01.prod.outlook.com (2603:1096:405:2bc::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Sun, 4 Oct
 2026 17:49:28 +0000
Received: from OS1PEPF0000D216.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:253:cafe::a5) by OS7PR01CA0069.outlook.office365.com
 (2603:1096:604:253::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Sun, 4
 Oct 2026 17:49:28 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 8.62.32.50) smtp.mailfrom=renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of renesas.com designates
 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 OS1PEPF0000D216.mail.protection.outlook.com (10.167.240.23) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.14
 via Frontend Transport; Sun, 4 Oct 2026 17:49:28 +0000
Received: from demon-pc (unknown [10.226.92.36])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id 7E5E53000253;
	Mon,  5 Oct 2026 02:49:26 +0900 (JST)
From: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
To: Biju Das <biju.das.jz@bp.renesas.com>,
	William Breathitt Gray <wbg@kernel.org>
Cc: linux-iio@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Subject: [PATCH v2 10/15] counter: rz-mtu3-cnt: cache function values
Date: Sun,  4 Oct 2026 20:47:47 +0300
Message-ID: <20261004174752.507499-11-cosmin-gabriel.tanislav.xa@renesas.com>
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
X-MS-TrafficTypeDiagnostic: OS1PEPF0000D216:EE_|TY4PR01MB15967:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: a0d284b3-c62a-455b-09e2-08df223fd6a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|23010399003|36860700016|1800799024|10067099003|56012099006|6133799003|11063799006|18092099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	SB26XvJu2TdSpd4Lp0i9AWwqbWh1TjpHSBQHuuLh1fgSvkFwKdu2vISQKOOcqQFXIJWd6RxGlxRVWgyvTcdz+mvODAySd6KtSShMj7k+JpmKatoIMNQ51uBG1PJIAgsp5o/viulkBpS3YeskEM6hza0vyPrgGSCmyy78yt+EPhpUxhNbgYlvuio756Mie8iuuaiQrYcohYfC2o8rgd5O8AEyohPde1o+bVOH4VTRqXo1WRHYRKx7jh+aIKIXDd61xTaVwlFBfqxeFlUN2bJeC9ONCU0eHnT7LidlDeTG3PGw5OrhY/snMlNlGM8tOWYd3TJLQciUqLtuf1LWYeMj77+bwhNjDeILmSYJ/vI9tT5xGLIB/cJ3KOo+zhjkABk/UYSpUnpy7Zlyq6xwHky/4DRx5cd1PXfeyVax4AifqSwnWP+LAKopc3SESU9mTEsT2wNVDABKtlpFQTvlmkITWe93HDu5prrIpzmM764drpqaktbMzRqRL5eth1vWBXyRJECknMOgEAa0pbn1h/+xOdNS8+zkuvCNvvmmJ/WOPIkM27QNq7y8W3blJVb649YPUVE3kajJ2ioLHUEdy697iheW57id1mj9OnMXtgv34kY65yyC27Y7rk7ExLzbJEFNTPC93m9Nj6/KZOP8jmq4praOQ/volY7iYI621VHSxZnh+THoVLwrcnvKN66FeJnlNB0mEsVHYDFmFlFHciyKWQ==
X-Forefront-Antispam-Report:
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(23010399003)(36860700016)(1800799024)(10067099003)(56012099006)(6133799003)(11063799006)(18092099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	3PyFhgSa/TQeSQMa3NYo0TGhMlSGJzpiB8iqPVXL0ql4KlVhTKdGFdvK7Z328Mq2tZqFX/Hwmilng1tD5huK4T+TbYfd1oiXSrqnJMOX/gdIwqZAv3QDhla23hvKcrIBIpv62+/6al/GqA/opPIocZn8Mz7jxrQyRb2M/DUO/b2gumvF3JoCKl3BG24md53alN5TdVI2NzV31k3B83wlow461E467ZaYNdUsueL8z965Z65Gi3bpIQPeR5DeJCLQmUSoO4N6n8qMg/atql9nGT/o14zM0qh1/DDSJVh2zSdlXe1AUVVFv14wCUZUQ4bO3umNPdri3qtm4xPlvfjReZ8cs8y79EExbTYVJDMVAIbFdZ0hr7svjBMLQPt/pfsmjkGanEVE57ZU66/y+cbeuSWF/8yPpzDC3hBWRXwDeKy3ofy+FiiTy8OMGFkO2/e8
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2026 17:49:28.8417
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a0d284b3-c62a-455b-09e2-08df223fd6a1
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: OS1PEPF0000D216.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB15967

If an MTU3 channel is used in a specific phase counting mode, when
disabling it and enabling it again, the user set mode is lost because
the timer mode register (TMDR1) is initialized to the default value.

Save the timer mode after setting it and restore it on enable.
Use the cached value to determine the function in
rz_mtu3_count_function_read_helper().

Avoid writing the TMDR1 register when the count is disabled to prevent
writing registers without actually owning the channel, as the busy check
inside ch->is_busy can race with PWM operations.

Since runtime PM is ensured to be resumed if the count is enabled, drop
the pm_runtime_get_sync() and pm_runtime_put() calls.

Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
---

V2:
 * add struct rz_mtu3_cnt::timer_mode documentation

 drivers/counter/rz-mtu3-cnt.c | 35 ++++++++++++++++-------------------
 1 file changed, 16 insertions(+), 19 deletions(-)

diff --git a/drivers/counter/rz-mtu3-cnt.c b/drivers/counter/rz-mtu3-cnt.c
index 61cf26e20471..3557a524a1b3 100644
--- a/drivers/counter/rz-mtu3-cnt.c
+++ b/drivers/counter/rz-mtu3-cnt.c
@@ -68,12 +68,14 @@
  * @count_is_enabled: Enabled state of Counter value channel
  * @ceiling: Cache for ceiling values
  * @count: Cache for count values
+ * @timer_mode: Cache for timer mode values
  */
 struct rz_mtu3_cnt {
 	struct mutex lock;
 	struct rz_mtu3_channel *ch;
 	u32 ceiling[RZ_MTU3_MAX_LOGICAL_CNTR_CHANNELS];
 	u32 count[RZ_MTU3_MAX_LOGICAL_CNTR_CHANNELS];
+	u8 timer_mode[RZ_MTU3_MAX_LOGICAL_CNTR_CHANNELS];
 	bool count_is_enabled[RZ_MTU3_MAX_LOGICAL_CNTR_CHANNELS];
 };
 
@@ -218,17 +220,11 @@ static int rz_mtu3_count_write(struct counter_device *counter,
 	return 0;
 }
 
-static int rz_mtu3_count_function_read_helper(struct rz_mtu3_channel *const ch,
-					      struct counter_device *const counter,
+static int rz_mtu3_count_function_read_helper(struct rz_mtu3_cnt *const priv,
+					      int id,
 					      enum counter_function *function)
 {
-	u8 timer_mode;
-
-	pm_runtime_get_sync(counter->parent);
-	timer_mode = rz_mtu3_8bit_ch_read(ch, RZ_MTU3_TMDR1);
-	pm_runtime_put(counter->parent);
-
-	switch (timer_mode & RZ_MTU3_TMDR1_PH_CNT_MODE_MASK) {
+	switch (priv->timer_mode[id]) {
 	case RZ_MTU3_TMDR1_PH_CNT_MODE_1:
 		*function = COUNTER_FUNCTION_QUADRATURE_X4;
 		return 0;
@@ -260,7 +256,7 @@ static int rz_mtu3_count_function_read(struct counter_device *counter,
 	if (ret)
 		return ret;
 
-	ret = rz_mtu3_count_function_read_helper(ch, counter, function);
+	ret = rz_mtu3_count_function_read_helper(priv, count->id, function);
 	mutex_unlock(&priv->lock);
 
 	return ret;
@@ -299,9 +295,9 @@ static int rz_mtu3_count_function_write(struct counter_device *counter,
 		return -EINVAL;
 	}
 
-	pm_runtime_get_sync(counter->parent);
-	rz_mtu3_8bit_ch_write(ch, RZ_MTU3_TMDR1, timer_mode);
-	pm_runtime_put(counter->parent);
+	if (priv->count_is_enabled[count->id])
+		rz_mtu3_8bit_ch_write(ch, RZ_MTU3_TMDR1, timer_mode);
+	priv->timer_mode[count->id] = timer_mode;
 	mutex_unlock(&priv->lock);
 
 	return 0;
@@ -394,8 +390,8 @@ static void rz_mtu3_32bit_cnt_setting(struct counter_device *counter)
 	struct rz_mtu3_channel *const ch2 = rz_mtu3_get_ch(counter, 1);
 	struct rz_mtu3_cnt *const priv = counter_priv(counter);
 
-	/* Phase counting mode 1 is used as default in initialization. */
-	rz_mtu3_8bit_ch_write(ch1, RZ_MTU3_TMDR1, RZ_MTU3_TMDR1_PH_CNT_MODE_1);
+	rz_mtu3_8bit_ch_write(ch1, RZ_MTU3_TMDR1,
+			      priv->timer_mode[RZ_MTU3_32_BIT_CH]);
 
 	rz_mtu3_set_ceiling(ch1, RZ_MTU3_32_BIT_CH,
 			    priv->ceiling[RZ_MTU3_32_BIT_CH]);
@@ -413,9 +409,7 @@ static void rz_mtu3_16bit_cnt_setting(struct counter_device *counter, int id)
 	struct rz_mtu3_channel *const ch = rz_mtu3_get_ch(counter, id);
 	struct rz_mtu3_cnt *const priv = counter_priv(counter);
 
-	/* Phase counting mode 1 is used as default in initialization. */
-	rz_mtu3_8bit_ch_write(ch, RZ_MTU3_TMDR1, RZ_MTU3_TMDR1_PH_CNT_MODE_1);
-
+	rz_mtu3_8bit_ch_write(ch, RZ_MTU3_TMDR1, priv->timer_mode[id]);
 	rz_mtu3_set_ceiling(ch, id, priv->ceiling[id]);
 	rz_mtu3_set_count(ch, id, priv->count[id]);
 
@@ -645,7 +639,7 @@ static int rz_mtu3_action_read(struct counter_device *counter,
 	if (ret)
 		return ret;
 
-	ret = rz_mtu3_count_function_read_helper(ch, counter, &function);
+	ret = rz_mtu3_count_function_read_helper(priv, count->id, &function);
 	if (ret) {
 		mutex_unlock(&priv->lock);
 		return ret;
@@ -812,6 +806,7 @@ static int rz_mtu3_cnt_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct counter_device *counter;
 	struct rz_mtu3_cnt *priv;
+	unsigned int i;
 	int ret;
 
 	counter = devm_counter_alloc(dev, sizeof(*priv));
@@ -823,6 +818,8 @@ static int rz_mtu3_cnt_probe(struct platform_device *pdev)
 	priv->ceiling[RZ_MTU3_16_BIT_MTU2_CH] = U16_MAX;
 	priv->ceiling[RZ_MTU3_32_BIT_CH] = U32_MAX;
 	priv->ch = &ddata->channels[RZ_MTU3_CHAN_1];
+	for (i = 0; i < RZ_MTU3_MAX_LOGICAL_CNTR_CHANNELS; i++)
+		priv->timer_mode[i] = RZ_MTU3_TMDR1_PH_CNT_MODE_1;
 
 	mutex_init(&priv->lock);
 
-- 
2.55.0
