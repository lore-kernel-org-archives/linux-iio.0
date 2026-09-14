Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011046.outbound.protection.outlook.com [40.107.74.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B89554A0925;
	Mon, 14 Sep 2026 20:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789418286; cv=fail; b=dMEhGysBCJTupw4pd36lf0C9h33EgBQz7GJX0xC7/k6Hxb+xadDbHvr3VCH1O9yUiEzlRbIZNUG1idMM4khgtZ22YZLrxrsbnHlawZCUYKqHiePyoC2X65Vi2RlWiNQV2cf99+pEeoeHODb0vC7b7YK65p3f7lkmMruaXqxQtAg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789418286; c=relaxed/simple;
	bh=xc5HNsC1DG5zLbgQ/JcawpnekmMUxkTeUlExKisBmp0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fA3WYwiXsyLrXtQkx92EeRW1jVGdw0AbVTaOJtjiPZhqLajzYV7EtP/z0g4dMGFCoBPbZnOYWcy4fB0mVjwjxfFtxd0R9/VvhO1WwmYBSGGrGqaoSVNc2g7BaBPgjYfyj8ZHmSgjjW2tDmgA3gSV2pQ8UYimf3yckB4wDBhIjkc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=Cc+CeLJT; arc=fail smtp.client-ip=40.107.74.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="Cc+CeLJT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mVAp0Y0M7X60RAtQ3kMkFLcuz7XhvRHGMz20pIvJQDpktoaLYO4P6bKnSLb7L7BvLipTFMpNoZcy5Z2u4Ud1tPgiZQ7XW+7TPNY2T3rAHpPFvLHV0BHn4NgUGW1wLyW1yT+cnZb7gq4NVfq45HA8DpNoEvnSP9GvhxpfI36SyZtsb9CTMpTBPkBYBGH25WNSFupgXEhff8xdp9PvFT3/TNhsQKGLWEGgrE3Ey6LKKG/16JA1LIbRb/R6S5egPOjT+uHdRMSZ6tYiwYZF82PzSvQ2zx6npZ/MME9qYYW/rX2Zvqx8W+NYPMufdseRsRi6a2NjHKPxwPDvuNqHo0zAwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MT2COeaNeCzkcZzV1LlRqeYTXHBHh1MkBlw7jqn06f8=;
 b=SF3cEf83RTPvTyPGsVBAzLLo1F+nhmjjGEM7l9jSYjMMirpJX+/Rgp8muoaacUstjHrE0rlLEiTwEKioVXdUmoKJh1Kp0I1zdVl0hnFdsJpwgXEE7D3skRRreX6qVMFHVdQlC07tif5MeSIBmbsJTg3niU4IgwTNHL5g/lT0ti/OCl5fCoBiMwgCVh5yjxI+sAQyQL0TBh/9tW465wP1XSukZPYeVV/LEFMrzRFlu8s/Z6uzxty77WIwEvl/hl2yunJAFLcnsmxF7QxcNQ5xYvfo3DU5sg4bthUyBB0CagbcjmWhbw857v2c2ApuZouZEQP7ulZhUgral0MXXwFFaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bp.renesas.com smtp.mailfrom=renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MT2COeaNeCzkcZzV1LlRqeYTXHBHh1MkBlw7jqn06f8=;
 b=Cc+CeLJTp4lB8hnHwF/9hjBC2/F4LPBUM52aGi+5phskDk6WfPKo/8lHQ38AlfES9t3rSexLn+4Nm9AZ+oCMKVEhRpPYhWp1Y3ftpT2/FWgEt7Gg73DHFhZ0urnG8uHj41/3iaBFXDwxSyApemuCSmB5t5EQlCwS0ZZ/Jd/5tUw=
Received: from TY4P286CA0072.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:36d::11)
 by OSCPR01MB15595.jpnprd01.prod.outlook.com (2603:1096:604:3c1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Mon, 14 Sep
 2026 20:37:58 +0000
Received: from TY1PEPF0000BAD7.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:36d:cafe::50) by TY4P286CA0072.outlook.office365.com
 (2603:1096:405:36d::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.13 via Frontend Transport; Mon,
 14 Sep 2026 20:37:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.62.32.50)
 smtp.mailfrom=renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of renesas.com designates
 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 TY1PEPF0000BAD7.mail.protection.outlook.com (10.167.240.36) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.7
 via Frontend Transport; Mon, 14 Sep 2026 20:37:58 +0000
Received: from demon-pc.localdomain (unknown [10.226.93.156])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id 4ADE63000368;
	Tue, 15 Sep 2026 05:37:56 +0900 (JST)
From: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
To: Biju Das <biju.das.jz@bp.renesas.com>,
	William Breathitt Gray <wbg@kernel.org>,
	Lee Jones <lee@kernel.org>
Cc: linux-iio@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Subject: [PATCH 11/15] counter: rz-mtu3-cnt: cache external input phase clock value
Date: Mon, 14 Sep 2026 23:36:10 +0300
Message-ID: <20260914203614.2035277-12-cosmin-gabriel.tanislav.xa@renesas.com>
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
X-MS-TrafficTypeDiagnostic: TY1PEPF0000BAD7:EE_|OSCPR01MB15595:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 9f00e145-32b1-412f-6d64-08df12a0105c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|82310400026|36860700016|6133799003|18002099003|22082099003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	Ax4gG09j//aYxSmNgQU918vB8RQrVQ/G5aQHXnzbYmwH6A7Ggyf/cHjhcOD4yaclRUKmDMZwRc4JGoCmJmo4C1g+KBDmdqRhNj5dq6PmJ770RHmzJnPoL5NU4+uvhHaFYyVfhIejCOcMR5WbOJvmx/eVCXrOUEY9P6q7zaeEzZVAmEh54qOfxa/15oMQcraYaYW0vXOZGSvK6FcSgPK2TGm2J8uz6qLwWM8l23PJfp52/qtf1G51dnlgAsuRYtJqu93GBXGaSvUAA9pAfs/j1bzRyJpRYbDoobStejkcYV6dyeEplb+WTffdlFLuYhjXRuuWEARoyeAOoZ19ebWv9Qaql67qf5y/6kMMynouX3rndA0KKstyPuvHArYcL5YgkPhQTL1dGHxR24SC+2T4FbApRqD4rEv13h9CdQ3CbanxepBfqfTLptBpT+DX+/Gp7XViaABFLFCBZquD74lPhZdFMFSPRJthfC0wIbZbR1ZQ/UN9a4y9Xy+xvu3r2yt3rbJ1p3No2gW7Fatyde9ehQY9TyHM1FXgf3O8bAR14nY8MK4SioT7ApyrnA+kIpMeMY1BD84veuvg2L8mq8+Ki8APfp/ImEj0gTLQWJIIkd2hT72NO/SNuUoW0/0ZWhBLxbVvXmDxvBunvC24og+xAZL0LVhuFMXPXvqKyDV2MEr/+4SkBV2no4M+gWPoPo8sAiM9ek/jhJCCVDGdBt9UTQ==
X-Forefront-Antispam-Report:
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(82310400026)(36860700016)(6133799003)(18002099003)(22082099003)(10067099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	xCtMf/Vg8BG7Jvz7M9qefHPNyaxAnZUkKsUQP5wnh7WGYZwU85xQHUk96q8Cu19cGrl7OkRr4JnsIfXe1SGRMJZwFFhB9G0YtIyn5ZUxSoTukaG9Xi+O6Dxsu61ZkYgh0S1JBvUsFIMUZdc3BvhG/EM85w9tekfCrFTIBs4b9F0wQstGf+/fxvN+HmWcc/j0CwuBJOblX78SIAOxC86CWH8dfLrE2Y4C/CbVob1+owVBER1bGIL2SSHt3OLYh9nt3xDPD1C/qOtlzA3a95mdfE4SrMK7tFFJYd5KqNqJQh5o+163dHZCrd3sP+8BlnAAiQmpnu9X32wmaMpvlnHeU0v44IS30hlrfLaMaGtfBWeu8Rb1i2tJpXhp1enkrHO5LgjLO+4jVR9kR5G6mUgRdsgoImFBhiBbYu5VZ8D7Rgv1dGQvQIzgNRsm56e90HTB
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2026 20:37:58.7960
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f00e145-32b1-412f-6d64-08df12a0105c
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: TY1PEPF0000BAD7.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB15595

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
 drivers/counter/rz-mtu3-cnt.c | 35 +++++++++++++++++++----------------
 1 file changed, 19 insertions(+), 16 deletions(-)

diff --git a/drivers/counter/rz-mtu3-cnt.c b/drivers/counter/rz-mtu3-cnt.c
index 3e380f69cb45..a26b8b71c9a6 100644
--- a/drivers/counter/rz-mtu3-cnt.c
+++ b/drivers/counter/rz-mtu3-cnt.c
@@ -79,6 +79,7 @@ struct rz_mtu3_cnt {
 	u32 count[RZ_MTU3_MAX_LOGICAL_CNTR_CHANNELS];
 	u8 timer_mode[RZ_MTU3_MAX_LOGICAL_CNTR_CHANNELS];
 	bool count_is_enabled[RZ_MTU3_MAX_LOGICAL_CNTR_CHANNELS];
+	bool mtclkc_mtclkd;
 };
 
 static const enum counter_function rz_mtu3_count_functions[] = {
@@ -180,6 +181,12 @@ static void rz_mtu3_set_count(struct rz_mtu3_channel *const ch, int id,
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
@@ -388,6 +395,8 @@ static void rz_mtu3_32bit_cnt_setting(struct counter_device *counter)
 	struct rz_mtu3_channel *const ch2 = rz_mtu3_get_ch(counter, 1);
 	struct rz_mtu3_cnt *const priv = counter_priv(counter);
 
+	rz_mtu3_set_phcksel(priv->ch, priv->mtclkc_mtclkd);
+
 	rz_mtu3_8bit_ch_write(ch1, RZ_MTU3_TMDR1,
 			      priv->timer_mode[RZ_MTU3_32_BIT_CH]);
 
@@ -407,6 +416,8 @@ static void rz_mtu3_16bit_cnt_setting(struct counter_device *counter, int id)
 	struct rz_mtu3_channel *const ch = rz_mtu3_get_ch(counter, id);
 	struct rz_mtu3_cnt *const priv = counter_priv(counter);
 
+	if (id == RZ_MTU3_16_BIT_MTU2_CH)
+		rz_mtu3_set_phcksel(priv->ch, priv->mtclkc_mtclkd);
 	rz_mtu3_8bit_ch_write(ch, RZ_MTU3_TMDR1, priv->timer_mode[id]);
 	rz_mtu3_set_ceiling(ch, id, priv->ceiling[id]);
 	rz_mtu3_set_count(ch, id, priv->count[id]);
@@ -569,17 +580,13 @@ static int rz_mtu3_ext_input_phase_clock_select_get(struct counter_device *count
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
@@ -595,11 +602,10 @@ static int rz_mtu3_ext_input_phase_clock_select_set(struct counter_device *count
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
@@ -629,8 +635,6 @@ static int rz_mtu3_action_read(struct counter_device *counter,
 	struct rz_mtu3_channel *const ch = rz_mtu3_get_ch(counter, count->id);
 	struct rz_mtu3_cnt *const priv = counter_priv(counter);
 	enum counter_function function;
-	bool mtclkc_mtclkd;
-	unsigned long tmdr;
 	int ret;
 
 	ret = rz_mtu3_lock_if_count_is_enabled(ch, priv, count->id);
@@ -647,10 +651,8 @@ static int rz_mtu3_action_read(struct counter_device *counter,
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
@@ -812,6 +814,7 @@ static int rz_mtu3_cnt_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	priv = counter_priv(counter);
+	priv->mtclkc_mtclkd = true;
 	priv->ceiling[RZ_MTU3_16_BIT_MTU1_CH] = U16_MAX;
 	priv->ceiling[RZ_MTU3_16_BIT_MTU2_CH] = U16_MAX;
 	priv->ceiling[RZ_MTU3_32_BIT_CH] = U32_MAX;
-- 
2.55.0

