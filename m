Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011005.outbound.protection.outlook.com [40.107.74.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3696F429000;
	Mon, 14 Sep 2026 20:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789418282; cv=fail; b=GyVAprK58F4bFGtKyaxDkL1ef2Fw/ewIn+FalPE4IpffKp4rw1agiHteb3NtWMB/C8KByKsIs2tsmBm0+GIQz4gM/uefUNAUF7ytnXbB4EKFB4IhlRr89V9N7FyK4B4fvyTn5U0X3/DVKrBXYj8E+Ha9smkRbbZBQd6gGOmDY0U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789418282; c=relaxed/simple;
	bh=QuCa27XwwZO3xiL2nCpf3COaMT8sSLYHJultcJfkAtI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YaepKQ3yhZdGroaE7tZGZlGm4MBdV3+IC7eHBsDmiAJCEdOmdLMYS7BNcO5Ms0KvKOP8V8Bx1O/Smg4+72yn6wJE89bEHkzu7+PyqIlUBPPvIrJmzJesaujcBurVuac/UWbLKytcRNnnDUcq+tyBBbL85u5slEIcrq7b8gKsEoA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=Apd0BAU8; arc=fail smtp.client-ip=40.107.74.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="Apd0BAU8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m2BZQvKDb1RBm3kgOPuHh5AEZzWvqophaYqKdHNOfceuQglwEpPu24hHCwcb/eqCOYTVgrPcsU1xJd8nNJi1b9kLdOGUDrEH7YwzxrTV5tZnpyqg1CZqxCco9udlqeFwLkxKiOkMUBqQxu7S2lSoIz64nSMUiRlvTZOIHUYnF0XYKeNAhLDJWbWXRHVGdhu/KETcz4TXFUQ91szJiMvH670jP9XQC6iGBSvXGBTfBkZtZL6IEqWoeaIijJoZb/qtIFwwQxggX/e57Zuo++tWT52SuoHw7WA/Vgzgdl/4Wpq0dTcmNA4qq6S+R1TaJS8dBYIUNVNFSsod5C3W0HGSSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3EDYNwMAtGYOpr6G676HE3okbnqXkKujSCKU9gbG+5k=;
 b=mUoUCOKlHyNPdTRcaC6/ah81exoQNuc2+/ErjGKXw2yzi1AmCwcJkVfBT6g6dJc79DgIfU2s1A0V9h0oqFgTsP29MZRsqMffFavJGhwWBCZKuQj3iXZpvaY6QCon3eLCp9/fMsq0lzNXHOqaeZ039xoTs2AlE+8exouGx0NivHD+S0/LSmGy6M2NjBDcjyGM3QIQKeBWe47tAsAKtbZgeGq/mMbnuhCW8Qr3CKvovnfngJ/xyb5+pf04wqa5MedYcnRjSGHgryWtsF+WBjfYi7720yrJEUg0GtaoM4svfKEOxemMUgTihQyMsxBye2Bq6q/MaBsJl5sPlCfYhNT5fA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bp.renesas.com smtp.mailfrom=renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3EDYNwMAtGYOpr6G676HE3okbnqXkKujSCKU9gbG+5k=;
 b=Apd0BAU8bNaGUjt0Mj9dXXwrwY9mhyzurTCPoTQzahURiBS3FbgErVp+L1YBtEAc+wmW3FWR/4Y1ipPXrxF+0Vsa9yKBnjTf/Ra0/d5QI7qsCYRhX18mEK1KvMECkP4RK6hZz4Cp9z0CbDtfCbuZ4W1VbCodyisdXzi12660mQo=
Received: from OS7PR01CA0300.jpnprd01.prod.outlook.com (2603:1096:604:25a::6)
 by OS9PR01MB17415.jpnprd01.prod.outlook.com (2603:1096:604:44e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Mon, 14 Sep
 2026 20:37:55 +0000
Received: from OS1PEPF0000D20D.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:25a:cafe::5f) by OS7PR01CA0300.outlook.office365.com
 (2603:1096:604:25a::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.12 via Frontend Transport; Mon,
 14 Sep 2026 20:37:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.62.32.50)
 smtp.mailfrom=renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of renesas.com designates
 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 OS1PEPF0000D20D.mail.protection.outlook.com (10.167.240.36) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.7
 via Frontend Transport; Mon, 14 Sep 2026 20:37:55 +0000
Received: from demon-pc.localdomain (unknown [10.226.93.156])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id B5D6D3000368;
	Tue, 15 Sep 2026 05:37:52 +0900 (JST)
From: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
To: Biju Das <biju.das.jz@bp.renesas.com>,
	William Breathitt Gray <wbg@kernel.org>,
	Lee Jones <lee@kernel.org>
Cc: linux-iio@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Subject: [PATCH 10/15] counter: rz-mtu3-cnt: cache function values
Date: Mon, 14 Sep 2026 23:36:09 +0300
Message-ID: <20260914203614.2035277-11-cosmin-gabriel.tanislav.xa@renesas.com>
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
X-MS-TrafficTypeDiagnostic: OS1PEPF0000D20D:EE_|OS9PR01MB17415:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 0879bb06-4df9-4bd6-0340-08df12a00e3f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700016|23010399003|82310400026|1800799024|6133799003|10067099003|56012099006|11063799006|22082099003|18002099003|18092099006;
X-Microsoft-Antispam-Message-Info:
	VN2EmY76UbNr+wh7z8obml2eTZm5FIH279TUZFttPnhYK/rQCWmu69/TKF4WcgdNxD+MEHw8m80RaFuvUynYdU3V5ffMizYYLxdwoopE6f5gUjNyXijPgKolLOpLoTlKBtzbpSMPExWoHPk10FJPNDImmy1PMyEngbGi/RKp9DF5DNQEsffCl7SbHRRy3xIvbHdiqR2pYE64WtHUc1izpkaZGzl2vYNo3+chX9/iFrOBWVLH1pyAHI7wrBuHezB7ow8MYdXXORaowdBHEjfRX+vuZJI0GF7kswuqyl44X7J1ou40VavznBEfqkKYs2rdZ37qVG+bb2te2Wsd7i+NOWhDL+7H8rKBylQmmh93NfMxKmuzssIsqZ15/8yfBsZxfgDo24ziQTOS+kWmT46SnVqtZb9VCRQIrNl7s3q1oJOxF+Xhd2SMQhWuzO5vNJfs/q/rAEwY7n6Abe+h8OD9I6aXYYHwt+RNxqOpmfGRRVojlJvVkxqwH0TpYq3dSI0PIg9NLh01qXt3uPOywd2AAxVYFxuNYSJr6gc4+BpODNQp7fsvw6m5INqA6vmhgHsmcHXdjtKDqatPco/IJp1xtmBfAEa1SEvf6NOTzxwaPZA0hGt/wqgX15A6oLZlOEokozr0NrgtfOBdf5oY10tfAGkYaMU+yQT9yXcensgRLAb4HPWabfVEpI1LvdIE3oiDwYVZl8Haluqg9dwlCpp0PA==
X-Forefront-Antispam-Report:
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700016)(23010399003)(82310400026)(1800799024)(6133799003)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003)(18092099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	3PJBgQWEvbM3iATP1BW8zr2fZk0GmJu1E6rG0Z1Bb8yl4joCMEGZgusua0hvDHuc7fHtTZdZndTjQ46Pk9804TWJiHPrbRzk59DnPmZahubIB4U37PY+/Dli9woWHxer3PGjMKOOTHu6k0a9jh2ti7gUW9G1TKoGuCbmyegzK1aRG3gpA03H+hwd5ttFKrPOY53qTThdLmI4QMPbWPtZt+7015pDgw2LW3wbkXawKazzkk/YyfAvh5TtRUri5XEOacHT1GQJjKgGC6N26DUIbfA0y0DMVNjSyqCVo7XMlPnN7Yp/gV23H1TZ12ACGzyJimYVLiYzEuNyjL2cCzeDj+frCFzhAMEggWlDKqUh2cMpr4s0Iqzou0KTtIo0XJajUQUVsf+6/u85Iw/xBVxp5VpSEKx/csEyazfS8NfgC9RmQbMncoVFA68YJ3Hhsga4
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2026 20:37:55.2338
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0879bb06-4df9-4bd6-0340-08df12a00e3f
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: OS1PEPF0000D20D.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9PR01MB17415

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
 drivers/counter/rz-mtu3-cnt.c | 34 +++++++++++++++-------------------
 1 file changed, 15 insertions(+), 19 deletions(-)

diff --git a/drivers/counter/rz-mtu3-cnt.c b/drivers/counter/rz-mtu3-cnt.c
index 68025c6ed409..3e380f69cb45 100644
--- a/drivers/counter/rz-mtu3-cnt.c
+++ b/drivers/counter/rz-mtu3-cnt.c
@@ -77,6 +77,7 @@ struct rz_mtu3_cnt {
 	struct rz_mtu3_channel *ch;
 	u32 ceiling[RZ_MTU3_MAX_LOGICAL_CNTR_CHANNELS];
 	u32 count[RZ_MTU3_MAX_LOGICAL_CNTR_CHANNELS];
+	u8 timer_mode[RZ_MTU3_MAX_LOGICAL_CNTR_CHANNELS];
 	bool count_is_enabled[RZ_MTU3_MAX_LOGICAL_CNTR_CHANNELS];
 };
 
@@ -217,17 +218,11 @@ static int rz_mtu3_count_write(struct counter_device *counter,
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
@@ -259,7 +254,7 @@ static int rz_mtu3_count_function_read(struct counter_device *counter,
 	if (ret)
 		return ret;
 
-	ret = rz_mtu3_count_function_read_helper(ch, counter, function);
+	ret = rz_mtu3_count_function_read_helper(priv, count->id, function);
 	mutex_unlock(&priv->lock);
 
 	return ret;
@@ -298,9 +293,9 @@ static int rz_mtu3_count_function_write(struct counter_device *counter,
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
@@ -393,8 +388,8 @@ static void rz_mtu3_32bit_cnt_setting(struct counter_device *counter)
 	struct rz_mtu3_channel *const ch2 = rz_mtu3_get_ch(counter, 1);
 	struct rz_mtu3_cnt *const priv = counter_priv(counter);
 
-	/* Phase counting mode 1 is used as default in initialization. */
-	rz_mtu3_8bit_ch_write(ch1, RZ_MTU3_TMDR1, RZ_MTU3_TMDR1_PH_CNT_MODE_1);
+	rz_mtu3_8bit_ch_write(ch1, RZ_MTU3_TMDR1,
+			      priv->timer_mode[RZ_MTU3_32_BIT_CH]);
 
 	rz_mtu3_set_ceiling(ch1, RZ_MTU3_32_BIT_CH,
 			    priv->ceiling[RZ_MTU3_32_BIT_CH]);
@@ -412,9 +407,7 @@ static void rz_mtu3_16bit_cnt_setting(struct counter_device *counter, int id)
 	struct rz_mtu3_channel *const ch = rz_mtu3_get_ch(counter, id);
 	struct rz_mtu3_cnt *const priv = counter_priv(counter);
 
-	/* Phase counting mode 1 is used as default in initialization. */
-	rz_mtu3_8bit_ch_write(ch, RZ_MTU3_TMDR1, RZ_MTU3_TMDR1_PH_CNT_MODE_1);
-
+	rz_mtu3_8bit_ch_write(ch, RZ_MTU3_TMDR1, priv->timer_mode[id]);
 	rz_mtu3_set_ceiling(ch, id, priv->ceiling[id]);
 	rz_mtu3_set_count(ch, id, priv->count[id]);
 
@@ -644,7 +637,7 @@ static int rz_mtu3_action_read(struct counter_device *counter,
 	if (ret)
 		return ret;
 
-	ret = rz_mtu3_count_function_read_helper(ch, counter, &function);
+	ret = rz_mtu3_count_function_read_helper(priv, count->id, &function);
 	if (ret) {
 		mutex_unlock(&priv->lock);
 		return ret;
@@ -811,6 +804,7 @@ static int rz_mtu3_cnt_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct counter_device *counter;
 	struct rz_mtu3_cnt *priv;
+	unsigned int i;
 	int ret;
 
 	counter = devm_counter_alloc(dev, sizeof(*priv));
@@ -822,6 +816,8 @@ static int rz_mtu3_cnt_probe(struct platform_device *pdev)
 	priv->ceiling[RZ_MTU3_16_BIT_MTU2_CH] = U16_MAX;
 	priv->ceiling[RZ_MTU3_32_BIT_CH] = U32_MAX;
 	priv->ch = &ddata->channels[RZ_MTU3_CHAN_1];
+	for (i = 0; i < RZ_MTU3_MAX_LOGICAL_CNTR_CHANNELS; i++)
+		priv->timer_mode[i] = RZ_MTU3_TMDR1_PH_CNT_MODE_1;
 
 	mutex_init(&priv->lock);
 
-- 
2.55.0

