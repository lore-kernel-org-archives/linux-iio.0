Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.228.41
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794911273;
	b=vmzhm/hIgBAbvAQ/K1jtNTtBv3KjWWZJycARA8+r+BYQEnoDwdMcuhxpa3+Gk1+1BrSZ
	 C9rwASO/S2C0+qHtk/9yPzcfFpgbcBQJ/zvUynZLHf9Pmp3yyRUKmZhetBx/sbDz4rjoh
	 ZqQoDPl8XsemalPl0+0O7xPwIMPbry43F4+FJWgRjvHsB7jC9B5et8PvRtewFcu3V5tuM
	 tM6642DyrMC+Sl/EFPr//OHZl1aSRs0TZ18Bhf2h8eyvbO9eaV9JAG+fJs6H+9KkjGfmZ
	 4QTqgmCNQzvdXO2h/R86DYgxAiXrNOCo1D3yq7xv/9X8VrBWeyVrAz5rgfbIBNtPazA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794911273;
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
	bh=vbrBlxnicbbcPKLNv0Q+LX2VGVw3q8GFuJ0ImWVvtsY=;
	b=cR4DnmuY+ABiaF/Id853aY9njxA1KywljjycjoSBkDo9tfUVZREe4eLHqQs5VGqGNUfQ
	 Y4eo4PeBraxrJ3l4uSbb07xhFdsf2k+Moh5HEkKGwDlSleeJGb+G9S9p4755LWxW27XqC
	 TXS3Gl8FshVyNvjW0j4cNAj7w0mpfBWVRrLeOCbnz4ehg800z4WF98oc8/d/loYw3WnDn
	 tlSrThdgkh2HLeFwtfY83wAEDX/ZaDbK1z//cKkvOUzbEMTvMpsIY766byAWpHsftcn6m
	 urcDZXZu/gtqaCJKJQ5nBWXBuOHVoJj/VaiXrnkG8xknyQ5HzNKB7bGDPYNPF5KB+Yw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=renesas.com;
	spf=pass smtp.mailfrom=renesas.com;
	dkim=pass header.d=renesas.com header.i=@renesas.com header.a=rsa-sha256 header.s=selector1 header.b=OK1wJFHA;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.228.41
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010041.outbound.protection.outlook.com [52.101.228.41])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5079C606A885;
	Tue, 17 Nov 2026 10:27:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5079C606A885
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=renesas.com header.i=@renesas.com header.a=rsa-sha256 header.s=selector1 header.b=OK1wJFHA
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y/rxKA/CTag5zcrRotAG2K9/moc+xbwDDWve6amo7Z0chZ31FaLLfJusNHwcuyRwft1HJhLM5FQnRq/VDkr+S354u+JI+n7v7oss11yJBzJAP6s/GX1P6MiJ3dVFPi4I7fE6WcMtgr2PhjU8n4gFqNdSGgjZFfR7Gq0rTe3hjOiSd9jc3d2JdQ/78ROCHA1tIT3SBP2a6zFsDbcMn0ZfIxrCvnmO2OArR8R4POO4udMuoP3bEqWQjhLIbU+7FP3Ww3KUQbYdcudvzE/lpc4Adwzn8EcO3WFHr4ptsZoTV3kn8TL0KxkF5OllkcqPWlPi4KJ2IixsAN7MwErP2z2zRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vbrBlxnicbbcPKLNv0Q+LX2VGVw3q8GFuJ0ImWVvtsY=;
 b=s35OKbrVBiXI9A/G2etgCJNPIXG0uEcqC2MMQsiqZVz/pjs7bbDdKpAsoLeoH6GlJ/T3e5MEdGeyl42CBH8ulTPE4aV59Pg9Bm1sn/gEzlltpwGGZFxzoUZObNPdEwsLWJaTcV2NE+XejJmqOeomrzNdiOPONsz9yAmixwGlqHd0Ed+JulavhvbZK1mfJHrfAUbwuVwKjWQxIQUSRqYlwBOcv58yn9d/VvoRkRmzYE7CdczvrxtoqUV6IGlrPH/P25XB/spXwBMGnffVbBLzPMUx1cKcYiPAdH3mWqtFJBml37YKOBnhqi8p/SsYM5qInVDjitjSMDGqurSI5CAl0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bp.renesas.com smtp.mailfrom=renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vbrBlxnicbbcPKLNv0Q+LX2VGVw3q8GFuJ0ImWVvtsY=;
 b=OK1wJFHA7sDmycNsUVS9D+aiNj1Eer5Vwhy9LrDk2YfqNTswuCznhoUXlaNG9AsJxe4qPBK+eEGZ6psQGe2T2QFj7v3JtcnAq05EfU8J/cDMTCcCDHkd2soy9e7duJY0vr3IBiFjA2NTA/IFyf+7XryXTIunCmrUTRBxauy4t5g=
Received: from OS7PR01CA0211.jpnprd01.prod.outlook.com (2603:1096:604:252::15)
 by OS7PR01MB18183.jpnprd01.prod.outlook.com (2603:1096:604:4be::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 10:27:47 +0000
Received: from OS3PEPF0000003D.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:252:cafe::4f) by OS7PR01CA0211.outlook.office365.com
 (2603:1096:604:252::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.13 via Frontend Transport; Tue,
 17 Nov 2026 10:27:47 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 8.62.32.50) smtp.mailfrom=renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of renesas.com designates
 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay005p.adwin.renesas.com; pr=E
Received: from ejcrelay005p.adwin.renesas.com (8.62.32.50) by
 OS3PEPF0000003D.mail.protection.outlook.com (10.167.240.6) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.4
 via Frontend Transport; Tue, 17 Nov 2026 10:27:47 +0000
Received: from demon-pc.tailc3dc73.ts.net (DEU-5CG5050QD0.adwin.renesas.com [10.226.92.253])
	by ejcrelay005p.adwin.renesas.com (Postfix) with ESMTP id D37D93000255;
	Tue, 17 Nov 2026 19:27:45 +0900 (JST)
From: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
To: Biju Das <biju.das.jz@bp.renesas.com>,
	William Breathitt Gray <wbg@kernel.org>
Cc: linux-iio@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Subject: [PATCH v3 12/14] counter: rz-mtu3-cnt: keep cascade_counts_enable in sync with usage
Date: Tue, 17 Nov 2026 12:26:05 +0200
Message-ID: <20261117102607.2504551-13-cosmin-gabriel.tanislav.xa@renesas.com>
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
X-MS-TrafficTypeDiagnostic: OS3PEPF0000003D:EE_|OS7PR01MB18183:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 37664c59-cd5e-4d15-0373-08df44956cfe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700016|23010399003|82310400026|261022105027099003|261021121427099003|11063799006|10067099003|56012099006|261026121527099003|261026140227099003|261028144727099003|261022075727099003|261102123227099003|261021123027099003|261009223027099003|18002099003|6133799003|22082099003;
X-Microsoft-Antispam-Message-Info:
	RmYx9lH3KvV0cqKEHT1yJSlE9MgPd/rxfCiGB/LitN3r1HToNHnynxyXvYScLYTvhqXCOToAs2yxcxs7C+u79yCq4juRfSG3SL4iCT7oJ4pCPtmtXrl7PzU1okoCPRdGvFqIQdydgbE+kfayE6BQRwBf6wo5YSF6+dTfUdUKTXSFrxF0yFao8EzubeAf3OIpVwFrumADu5ZAjqYfvIcPLo09J9KYlQCsRjKA9/u0gHZ/vpWSS3oSi5lk2zoqeWfDh6MCwfoaQCGxQl9BCrTgnl1t1YjP4pDtIjbQkIEfLcB6b/d6X19761AkJQhgMfiS1B3TZx0y6MwvbVMTVd8v8cQkJDET/EwawAwsZTYz9TB4ycl5q5yBAezn4Spux2BVdEXH+LFFWedqTfJ2qcVIBm2NY4QijpJ0yuG9hYeN8tT8EHEvvK8PkGdV4RoxOgfyxiTB+fraEpb3/XqLgby/OKdPKFw1QjUVe8F8z1/XJuE9uDoNbVeMonZi19VHu0+Aj/OgPSFRVDSkravYWd0FhpJFvjmTRu1peq8AnqoeJbwlAafPrWXiYZZMFDJN2a4AfgyOHoihnpnlXWwLHId6/yqCt2FvTC+tFtcBz/PUr3l4wJkzA0vX/tDYuMUvVXy7bYiIN4yi3L8NBebiHYtoblDngDzZNqjUWstq9LrBXxh7u9FuOHM/Ko/o1G8eWWBB3mWRulErFBskiSEDhx8jSg==
X-Forefront-Antispam-Report:
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay005p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700016)(23010399003)(82310400026)(261022105027099003)(261021121427099003)(11063799006)(10067099003)(56012099006)(261026121527099003)(261026140227099003)(261028144727099003)(261022075727099003)(261102123227099003)(261021123027099003)(261009223027099003)(18002099003)(6133799003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	yZ2A9jySzuf1L4+2mntPeucZ2vCw/I7sCTDaSr7KzTFBuYOb0C9tB3R7vfJgwPnvqeUWgo/5Fc8EVSH/rIQ2Noqw5RNeCBHBimZ+GGCwYXgd/b/BxjJnC5GOq/lbTSj83xffRiOM67sY4CW9y/wNIhAAv6jxC6Rh76e8GWJAe5t5PLWsZYBmkh8FoDK6Y6ewPt0oem/y0Lc/tIlFcZbMUiuKcGyrQsPbAWzGlVJMoPD2f81VBH23TwcVSSJih+A/KE6ik993ldrN6LAD5ofdcn+R8xxVytOc3QShLR7L3g8POQK8Jm7qVuvvBcDeqIWzmRoJLT9jsVdVHCbmburTNP/bqmY05LC6TGE0SNuQdpFKeSY1mptcePNpjY/iwlf/sfp6TjTtHsR6/+cuBxsKRfv0Vzp3h+GMJRg8CrxcXF8dKayi0jEOvV+DBdvIdvmU
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 10:27:47.8661
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 37664c59-cd5e-4d15-0373-08df44956cfe
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay005p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: OS3PEPF0000003D.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7PR01MB18183

LWA is enabled/disabled by writing 1/0 to the cascade_counts_enable
sysfs entry.

The 32-bit channel cannot function without LWA being enabled, and the
16-bit channels cannot function with LWA enabled.

PWM mode cannot function with LWA enabled.

It is possible to accidentally leave LWA enabled while trying to use PWM
mode, leading to unintended access to the TGRA or TGRB registers of
MTU1 and MTU2, which should not be accessed while LWA is enabled.

It is also possible to toggle LWA while PWM is enabled on MTU2, as the
checks inside rz_mtu3_lock_if_ch0_is_enabled() do not check if MTU2 is
busy, even if this setting affects MTU2.

To handle this, write 1 to the LWA bit when enabling the 32-bit channel,
and automatically write 0 to it when disabling the 32-bit channel, to
ensure that LWA is always in the correct state for any possible usage.

Remove rz_mtu3_is_counter_invalid() checks as it is now guaranteed
that LWA has the proper value if a count is enabled.

This also drops the busy check that rz_mtu3_lock_if_counter_is_valid()
carried. A count cannot be enabled without the underlying MTU channel
being claimed as busy by the count driver itself, so the check is
redundant.

Keep the cascade_counts_enable sysfs entry for ABI compatibility.

Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
---

V3:
 * no changes

V2:
 * add struct rz_mtu3_cnt::cascade_counts_enable documentation
 * move rz_mtu3_set_lwa() call after rz_mtu3_disable()
 * mention the removed busy check in the message

 drivers/counter/rz-mtu3-cnt.c | 95 +++++++----------------------------
 1 file changed, 18 insertions(+), 77 deletions(-)

diff --git a/drivers/counter/rz-mtu3-cnt.c b/drivers/counter/rz-mtu3-cnt.c
index e3578850f024..07dd7f588911 100644
--- a/drivers/counter/rz-mtu3-cnt.c
+++ b/drivers/counter/rz-mtu3-cnt.c
@@ -71,6 +71,7 @@
  * @timer_mode: Cache for timer mode values
  * @mtclkc_mtclkd: Cache for external input phase clock select value
  * @direction: Cache for direction values
+ * @cascade_enable: Cache for cascade_counts_enable value
  */
 struct rz_mtu3_cnt {
 	struct mutex lock;
@@ -81,6 +82,7 @@ struct rz_mtu3_cnt {
 	bool count_is_enabled[RZ_MTU3_MAX_LOGICAL_CNTR_CHANNELS];
 	bool direction[RZ_MTU3_MAX_LOGICAL_CNTR_CHANNELS];
 	bool mtclkc_mtclkd;
+	bool cascade_enable;
 };
 
 static const enum counter_function rz_mtu3_count_functions[] = {
@@ -102,44 +104,6 @@ static inline struct rz_mtu3_channel *rz_mtu3_get_ch(struct counter_device *coun
 	return &priv->ch[ch_id];
 }
 
-static bool rz_mtu3_is_counter_invalid(struct counter_device *counter, int id)
-{
-	struct rz_mtu3_cnt *const priv = counter_priv(counter);
-	unsigned long tmdr;
-
-	pm_runtime_get_sync(counter->parent);
-	tmdr = rz_mtu3_shared_reg_read(priv->ch, RZ_MTU3_TMDR3);
-	pm_runtime_put(counter->parent);
-
-	if (id == RZ_MTU3_32_BIT_CH && test_bit(RZ_MTU3_TMDR3_LWA, &tmdr))
-		return false;
-
-	if (id != RZ_MTU3_32_BIT_CH && !test_bit(RZ_MTU3_TMDR3_LWA, &tmdr))
-		return false;
-
-	return true;
-}
-
-static int rz_mtu3_lock_if_counter_is_valid(struct counter_device *counter,
-					    struct rz_mtu3_channel *const ch,
-					    struct rz_mtu3_cnt *const priv,
-					    int id)
-{
-	mutex_lock(&priv->lock);
-
-	if (ch->is_busy && !priv->count_is_enabled[id]) {
-		mutex_unlock(&priv->lock);
-		return -EINVAL;
-	}
-
-	if (rz_mtu3_is_counter_invalid(counter, id)) {
-		mutex_unlock(&priv->lock);
-		return -EBUSY;
-	}
-
-	return 0;
-}
-
 static int rz_mtu3_lock_if_count_is_enabled(struct rz_mtu3_channel *const ch,
 					    struct rz_mtu3_cnt *const priv,
 					    int id)
@@ -195,17 +159,19 @@ static bool rz_mtu3_get_direction(struct rz_mtu3_channel *const ch)
 	return !!(tsr & RZ_MTU3_TSR_TCFD);
 }
 
+static void rz_mtu3_set_lwa(struct rz_mtu3_channel *const ch, bool enable)
+{
+	rz_mtu3_shared_reg_update_bit(ch, RZ_MTU3_TMDR3, RZ_MTU3_TMDR3_LWA,
+				      enable);
+}
+
 static int rz_mtu3_count_read(struct counter_device *counter,
 			      struct counter_count *count, u64 *val)
 {
 	struct rz_mtu3_channel *const ch = rz_mtu3_get_ch(counter, count->id);
 	struct rz_mtu3_cnt *const priv = counter_priv(counter);
-	int ret;
-
-	ret = rz_mtu3_lock_if_counter_is_valid(counter, ch, priv, count->id);
-	if (ret)
-		return ret;
 
+	mutex_lock(&priv->lock);
 	if (priv->count_is_enabled[count->id])
 		priv->count[count->id] = rz_mtu3_get_count(ch, count->id);
 	*val = priv->count[count->id];
@@ -220,15 +186,11 @@ static int rz_mtu3_count_write(struct counter_device *counter,
 	struct rz_mtu3_channel *const ch = rz_mtu3_get_ch(counter, count->id);
 	struct rz_mtu3_cnt *const priv = counter_priv(counter);
 	u32 count_val = val;
-	int ret;
 
 	if (count->id != RZ_MTU3_32_BIT_CH)
 		count_val &= U16_MAX;
 
-	ret = rz_mtu3_lock_if_counter_is_valid(counter, ch, priv, count->id);
-	if (ret)
-		return ret;
-
+	mutex_lock(&priv->lock);
 	if (priv->count_is_enabled[count->id])
 		rz_mtu3_set_count(ch, count->id, count_val);
 	priv->count[count->id] = count_val;
@@ -347,14 +309,9 @@ static int rz_mtu3_count_ceiling_read(struct counter_device *counter,
 				      struct counter_count *count,
 				      u64 *ceiling)
 {
-	struct rz_mtu3_channel *const ch = rz_mtu3_get_ch(counter, count->id);
 	struct rz_mtu3_cnt *const priv = counter_priv(counter);
-	int ret;
-
-	ret = rz_mtu3_lock_if_counter_is_valid(counter, ch, priv, count->id);
-	if (ret)
-		return ret;
 
+	mutex_lock(&priv->lock);
 	*ceiling = priv->ceiling[count->id];
 	mutex_unlock(&priv->lock);
 	return 0;
@@ -366,11 +323,8 @@ static int rz_mtu3_count_ceiling_write(struct counter_device *counter,
 {
 	struct rz_mtu3_channel *const ch = rz_mtu3_get_ch(counter, count->id);
 	struct rz_mtu3_cnt *const priv = counter_priv(counter);
-	int ret;
 
-	ret = rz_mtu3_lock_if_counter_is_valid(counter, ch, priv, count->id);
-	if (ret)
-		return ret;
+	mutex_lock(&priv->lock);
 
 	switch (count->id) {
 	case RZ_MTU3_16_BIT_MTU1_CH:
@@ -407,6 +361,7 @@ static void rz_mtu3_32bit_cnt_setting(struct counter_device *counter)
 	struct rz_mtu3_cnt *const priv = counter_priv(counter);
 
 	rz_mtu3_set_phcksel(priv->ch, priv->mtclkc_mtclkd);
+	rz_mtu3_set_lwa(ch1, true);
 
 	rz_mtu3_8bit_ch_write(ch1, RZ_MTU3_TMDR1,
 			      priv->timer_mode[RZ_MTU3_32_BIT_CH]);
@@ -485,6 +440,7 @@ static void rz_mtu3_terminate_counter(struct counter_device *counter, int id)
 	if (id == RZ_MTU3_32_BIT_CH) {
 		rz_mtu3_disable(ch2);
 		rz_mtu3_disable(ch1);
+		rz_mtu3_set_lwa(ch1, false);
 		rz_mtu3_release_channel(ch2);
 		rz_mtu3_release_channel(ch1);
 	} else {
@@ -552,17 +508,9 @@ static int rz_mtu3_cascade_counts_enable_get(struct counter_device *counter,
 					     u8 *cascade_enable)
 {
 	struct rz_mtu3_cnt *const priv = counter_priv(counter);
-	unsigned long tmdr;
-	int ret;
 
-	ret = rz_mtu3_lock_if_ch0_is_enabled(priv);
-	if (ret)
-		return ret;
-
-	pm_runtime_get_sync(counter->parent);
-	tmdr = rz_mtu3_shared_reg_read(priv->ch, RZ_MTU3_TMDR3);
-	pm_runtime_put(counter->parent);
-	*cascade_enable = test_bit(RZ_MTU3_TMDR3_LWA, &tmdr);
+	mutex_lock(&priv->lock);
+	*cascade_enable = priv->cascade_enable;
 	mutex_unlock(&priv->lock);
 
 	return 0;
@@ -572,16 +520,9 @@ static int rz_mtu3_cascade_counts_enable_set(struct counter_device *counter,
 					     u8 cascade_enable)
 {
 	struct rz_mtu3_cnt *const priv = counter_priv(counter);
-	int ret;
 
-	ret = rz_mtu3_lock_if_ch0_is_enabled(priv);
-	if (ret)
-		return ret;
-
-	pm_runtime_get_sync(counter->parent);
-	rz_mtu3_shared_reg_update_bit(priv->ch, RZ_MTU3_TMDR3,
-				      RZ_MTU3_TMDR3_LWA, cascade_enable);
-	pm_runtime_put(counter->parent);
+	mutex_lock(&priv->lock);
+	priv->cascade_enable = cascade_enable;
 	mutex_unlock(&priv->lock);
 
 	return 0;
-- 
2.56.0
