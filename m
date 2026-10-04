Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011012.outbound.protection.outlook.com [52.101.125.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 765A2473C84;
	Sun,  4 Oct 2026 17:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791136189; cv=fail; b=ELSqAPwMravL1dmuPWGC4gx94d/HEI50yPKuWjxSSzEWHkv0D3I2aPqU9UJFs6rh5fp0YXA8fkXwMd+1dL6dHYd3H64ARWGQk559vAK/yZqXUjonLNtT2D3X2CT0Y/Lbfw5h/ckMqYbOp5nxwrIb14m9Wq3wJT6wNE0FwmzR4n4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791136189; c=relaxed/simple;
	bh=Jib3iLFleCQtwrsnL6r0GaN2UWfJi9NiTQttgNyRAcc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MCfQg2ETNXgjV0BXaDI1SCHHW8EOlhDivypX3ORUgvIFwOmANtT9lGLFfH10RZJBcFX4jua6GOuznAujZzHUMdzSSTh7w3e6qAHT63CFutBD/Xjs/UcwpKa4FzZsjMPD38qDFroXhnWR7UTcG+r/nS4qgIYGsiiL6u08CY1gTAs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=pI35AMGQ; arc=fail smtp.client-ip=52.101.125.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="pI35AMGQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hlfc7t5U8HcgvJzaUnxGnslZQ2SBvp14WqikzRSyligrR8omDvGbQ6XDywSs1z+fV5Olr3ASt3dSlAt7pmPfALooWFi3IgiG/WkXBOd5bTFbLf7R/K1+g7sZQGMGo5Amnb54EBuINvgQCzRzuEX3nwUEDnJ4O5VoKryAl3lTr5HDeYm+Q0BdhQ6/ACl3SjpxQFl2KbSpH/ZgBJQAPUjC3M7C590rgUoxoMtVvrP3jV9L8ktGKwZrxQ1+JYeotlmtE932Q3zxBfhCwxFbN3MQ2IaTj7syZGeVySxd9Tmfif/u11quAoDlsuDe+iZpj6g/2ocbhl7eL8rKXezS76vQGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9BaUiax/Jl+FLOEBHfcUyQSP7tpZAnLdakW08vQR5ZQ=;
 b=VoV8NHwQmpQpAv4rfpQTjgC2/wOBRR0DnTTx4NR9jBs9FFamuwf89H+N/XT5+eK09vr+cZ1Q2s0ZUDMG7V13mqoHYC9NwdL53+xhBu1b1e027qfrR3+p5hSU7wmcDJeDCrFOY9AdF44rluGvnFwFtEcqb4USV/msssuX/hDIGeMSFIksQHdcY7jbNhogT7d9bPo4RG17MXljcp1jRW3fJ+0uYRLBr924YKc9IWRdsiWxHcS4vhISDay5nmrmMuEXDvtbNZHTvVeoejrTtc9kRP/rMXZwx0Mf5VlHoUeYfg96mHS8gY//mu9E20DXIEryMfCvFADy1Irl+3qSAG8mqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bp.renesas.com smtp.mailfrom=renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9BaUiax/Jl+FLOEBHfcUyQSP7tpZAnLdakW08vQR5ZQ=;
 b=pI35AMGQ1Q8NR/vY/yK1zdauEhZ2UTisptW12ahxKPr6IRtgTVjfi0Xwn1f290odMAzhZ7dpfkixepYFEWEixTqyDM8JndnRIxUqY7CnGh9ILxpqzmj1duPx47HBR0KPB/07nF/D8UIxbhyXeZSEciUaL6auo2wlOa+TInB91DQ=
Received: from OS0P286CA0145.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:16b::23)
 by TY4PR01MB14450.jpnprd01.prod.outlook.com (2603:1096:405:239::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Sun, 4 Oct
 2026 17:49:32 +0000
Received: from OS3PEPF0000003C.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:16b:cafe::8) by OS0P286CA0145.outlook.office365.com
 (2603:1096:604:16b::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Sun, 4
 Oct 2026 17:49:32 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 8.62.32.50) smtp.mailfrom=renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of renesas.com designates
 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 OS3PEPF0000003C.mail.protection.outlook.com (10.167.240.5) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.14
 via Frontend Transport; Sun, 4 Oct 2026 17:49:32 +0000
Received: from demon-pc (unknown [10.226.92.36])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id C44783000246;
	Mon,  5 Oct 2026 02:49:29 +0900 (JST)
From: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
To: Biju Das <biju.das.jz@bp.renesas.com>,
	William Breathitt Gray <wbg@kernel.org>
Cc: linux-iio@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Subject: [PATCH v2 11/15] counter: rz-mtu3-cnt: cache external input phase clock value
Date: Sun,  4 Oct 2026 20:47:48 +0300
Message-ID: <20261004174752.507499-12-cosmin-gabriel.tanislav.xa@renesas.com>
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
X-MS-TrafficTypeDiagnostic: OS3PEPF0000003C:EE_|TY4PR01MB14450:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 0b509499-537d-485d-b047-08df223fd8ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|23010399003|1800799024|376014|82310400026|18002099003|22082099003|6133799003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	CR+15N3+cIFvBacS6sdyx++AAWBrHfAO96pml/XdNsiu/Qf55NBXQz748yW1M69MZJ8lDxDlvFUoDqxUGUaJWtD1Pqmy0Yr8VM2DjgNxg4PY/xwwZkV9Q4nWi1yjh9VP8PEUXfJV1V3PCrFyG9bqXyv6LVS8dWOFLAYkH5vDPOU3JfZ3ww8dSfQT9WPTQJ6SgVxUd241lzb+/OUeiptLZufs/KKOo9l994G7QDNZ6IFPk4ff6vUm3Jn5xwBVBNHsO3I7ZHS0ZqIjWYA3BA57PqNQKMXbN+uhX05eGYRFwsisReiZcaK5qq8jOMvBXucrpHLIfzYg55QQJAYLP1yMUMIOMsEwXkZSAG/0M6y/65pQE0lTy856Ek0fVx1UhiEFQ7vnx0YfynGIou1kujGi4fZINE9qIpMCoxtIhAx1zwC+M9er9H0qzwOJngZ34XPALVELpB/+1/zSsnMUqeelLSN5P8nFXLhc27wbuG8F0d34EaS6tyg7OkW7q5dKviuceII3xPCH3KeiY4+ijTR+zlMW/gHoSWxmJc3wMQJPcQyxJCuOQjgC8qOquGseqS/MpgdiO7c+htvkY/gk3IvLEnLRT6TWv34+bNMPC641o0WhmQ8y81zJjwpAgoyYPnKJ6tkMcW0BPP8UAfp2IvK0zXHgfavXHfiJv9JFsnkmwb8NdZpHrItBpE662G/Q+PFBbLClxSst0dz49Wxsm73ufQ==
X-Forefront-Antispam-Report:
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(1800799024)(376014)(82310400026)(18002099003)(22082099003)(6133799003)(10067099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ccRC4dJEWd7r+UrC5UidrybT0FC+J11Vvz+pwG5mLU9GozWk1vQBVL8xMd+Z4r+b2n2rAxxoPNOl7Hvqz4za0O0ZjehQ6O3V3g62afrRHfUgBT1iUiCAj+/SYYnFmcRSQru84TKhefhbZHvjdaboBgsCdgbAoFBPAbJu889SvYlG/0qBF5D29jIE4IAL2N7MzlTrLOJGPjp3ELjgj3FPUOdXmerazt2LlZxt9KGIV9GqPrg5RnCqLNS8WfVITINuSmTVtEIwhSNgj5fiemIJSxXLx3GVbjudfEznw/AYhwcM25kMCDYwdS7I8anBiMcRv88RSU4ffOgNwuwWwDA9F32y9z20tsJ/QKXD5l0fYOyVrAP7yQgdKU8OzQFwX0Oksxi2sT9m6NqXHk2EAQ0psDJr+7etyw3XRAKH+42gUpq79mqN1X/FwQRSyJfh4YB1
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2026 17:49:32.3682
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b509499-537d-485d-b047-08df223fd8ba
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: OS3PEPF0000003C.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB14450

PHCKSEL selects between MTCLKA-MTCLKB and MTCLKC-MTCLKD pins for the
external input phase clock.

PHCKSEL only affects the 16-bit count backed by MTU2 and the 32-bit
count.

Cache the value written to external_input_phase_clock_select and restore
it on enable to bring the external_input_phase_clock_select sysfs entry
in line with the other entries.

Initialize the cached value to true, matching PHCKSEL's reset value so
behavior is unchanged for a count that gets enabled without
external_input_phase_clock_select being written explicitly.

Always use the cached PHCKSEL value to remove the need to access
registers while counts might not be enabled.

Only restore it for the count backed by MTU2 as changing PHCKSEL for
MTU1 does not affect the pins used for the external input phase clock.

Check if any of these counts are enabled before writing the new PHCKSEL
value.

This prevents writing registers without actually owning the channel,
as the busy check inside ch->is_busy can race with PWM operations.

Since runtime PM is ensured to be resumed if the count is enabled, drop
the pm_runtime_get_sync() and pm_runtime_put() calls.

Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
---

V2:
 * add struct rz_mtu3_cnt::mtclkc_mtclkd documentation

 drivers/counter/rz-mtu3-cnt.c | 36 +++++++++++++++++++----------------
 1 file changed, 20 insertions(+), 16 deletions(-)

diff --git a/drivers/counter/rz-mtu3-cnt.c b/drivers/counter/rz-mtu3-cnt.c
index 3557a524a1b3..b1714ab1f7db 100644
--- a/drivers/counter/rz-mtu3-cnt.c
+++ b/drivers/counter/rz-mtu3-cnt.c
@@ -69,6 +69,7 @@
  * @ceiling: Cache for ceiling values
  * @count: Cache for count values
  * @timer_mode: Cache for timer mode values
+ * @mtclkc_mtclkd: Cache for external input phase clock select value
  */
 struct rz_mtu3_cnt {
 	struct mutex lock;
@@ -77,6 +78,7 @@ struct rz_mtu3_cnt {
 	u32 count[RZ_MTU3_MAX_LOGICAL_CNTR_CHANNELS];
 	u8 timer_mode[RZ_MTU3_MAX_LOGICAL_CNTR_CHANNELS];
 	bool count_is_enabled[RZ_MTU3_MAX_LOGICAL_CNTR_CHANNELS];
+	bool mtclkc_mtclkd;
 };
 
 static const enum counter_function rz_mtu3_count_functions[] = {
@@ -178,6 +180,12 @@ static void rz_mtu3_set_count(struct rz_mtu3_channel *const ch, int id,
 		rz_mtu3_16bit_ch_write(ch, RZ_MTU3_TCNT, count);
 }
 
+static void rz_mtu3_set_phcksel(struct rz_mtu3_channel *const ch, bool enable)
+{
+	rz_mtu3_shared_reg_update_bit(ch, RZ_MTU3_TMDR3, RZ_MTU3_TMDR3_PHCKSEL,
+				      enable);
+}
+
 static int rz_mtu3_count_read(struct counter_device *counter,
 			      struct counter_count *count, u64 *val)
 {
@@ -390,6 +398,8 @@ static void rz_mtu3_32bit_cnt_setting(struct counter_device *counter)
 	struct rz_mtu3_channel *const ch2 = rz_mtu3_get_ch(counter, 1);
 	struct rz_mtu3_cnt *const priv = counter_priv(counter);
 
+	rz_mtu3_set_phcksel(priv->ch, priv->mtclkc_mtclkd);
+
 	rz_mtu3_8bit_ch_write(ch1, RZ_MTU3_TMDR1,
 			      priv->timer_mode[RZ_MTU3_32_BIT_CH]);
 
@@ -409,6 +419,8 @@ static void rz_mtu3_16bit_cnt_setting(struct counter_device *counter, int id)
 	struct rz_mtu3_channel *const ch = rz_mtu3_get_ch(counter, id);
 	struct rz_mtu3_cnt *const priv = counter_priv(counter);
 
+	if (id == RZ_MTU3_16_BIT_MTU2_CH)
+		rz_mtu3_set_phcksel(priv->ch, priv->mtclkc_mtclkd);
 	rz_mtu3_8bit_ch_write(ch, RZ_MTU3_TMDR1, priv->timer_mode[id]);
 	rz_mtu3_set_ceiling(ch, id, priv->ceiling[id]);
 	rz_mtu3_set_count(ch, id, priv->count[id]);
@@ -571,17 +583,13 @@ static int rz_mtu3_ext_input_phase_clock_select_get(struct counter_device *count
 						    u32 *ext_input_phase_clock_select)
 {
 	struct rz_mtu3_cnt *const priv = counter_priv(counter);
-	unsigned long tmdr;
 	int ret;
 
 	ret = rz_mtu3_lock_if_ch0_is_enabled(priv);
 	if (ret)
 		return ret;
 
-	pm_runtime_get_sync(counter->parent);
-	tmdr = rz_mtu3_shared_reg_read(priv->ch, RZ_MTU3_TMDR3);
-	pm_runtime_put(counter->parent);
-	*ext_input_phase_clock_select = test_bit(RZ_MTU3_TMDR3_PHCKSEL, &tmdr);
+	*ext_input_phase_clock_select = priv->mtclkc_mtclkd;
 	mutex_unlock(&priv->lock);
 
 	return 0;
@@ -597,11 +605,10 @@ static int rz_mtu3_ext_input_phase_clock_select_set(struct counter_device *count
 	if (ret)
 		return ret;
 
-	pm_runtime_get_sync(counter->parent);
-	rz_mtu3_shared_reg_update_bit(priv->ch, RZ_MTU3_TMDR3,
-				      RZ_MTU3_TMDR3_PHCKSEL,
-				      ext_input_phase_clock_select);
-	pm_runtime_put(counter->parent);
+	if (priv->count_is_enabled[RZ_MTU3_16_BIT_MTU2_CH] ||
+	    priv->count_is_enabled[RZ_MTU3_32_BIT_CH])
+		rz_mtu3_set_phcksel(priv->ch, ext_input_phase_clock_select);
+	priv->mtclkc_mtclkd = ext_input_phase_clock_select;
 	mutex_unlock(&priv->lock);
 
 	return 0;
@@ -631,8 +638,6 @@ static int rz_mtu3_action_read(struct counter_device *counter,
 	struct rz_mtu3_channel *const ch = rz_mtu3_get_ch(counter, count->id);
 	struct rz_mtu3_cnt *const priv = counter_priv(counter);
 	enum counter_function function;
-	bool mtclkc_mtclkd;
-	unsigned long tmdr;
 	int ret;
 
 	ret = rz_mtu3_lock_if_count_is_enabled(ch, priv, count->id);
@@ -649,10 +654,8 @@ static int rz_mtu3_action_read(struct counter_device *counter,
 	*action = COUNTER_SYNAPSE_ACTION_NONE;
 
 	if (count->id != RZ_MTU3_16_BIT_MTU1_CH) {
-		tmdr = rz_mtu3_shared_reg_read(priv->ch, RZ_MTU3_TMDR3);
-		mtclkc_mtclkd = test_bit(RZ_MTU3_TMDR3_PHCKSEL, &tmdr);
-		if ((mtclkc_mtclkd && is_signal_ab) ||
-		    (!mtclkc_mtclkd && !is_signal_ab)) {
+		if ((priv->mtclkc_mtclkd && is_signal_ab) ||
+		    (!priv->mtclkc_mtclkd && !is_signal_ab)) {
 			mutex_unlock(&priv->lock);
 			return 0;
 		}
@@ -814,6 +817,7 @@ static int rz_mtu3_cnt_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	priv = counter_priv(counter);
+	priv->mtclkc_mtclkd = true;
 	priv->ceiling[RZ_MTU3_16_BIT_MTU1_CH] = U16_MAX;
 	priv->ceiling[RZ_MTU3_16_BIT_MTU2_CH] = U16_MAX;
 	priv->ceiling[RZ_MTU3_32_BIT_CH] = U32_MAX;
-- 
2.55.0
