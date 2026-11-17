Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.228.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794911268;
	b=XvMf8sw24xDCWKxFjac8vkavK4wO8sj/xk0WP0ExkUOFqsIXRcnC8MAgkKyZH4SZidI0
	 wTDJyjbFux94GSpPX/VwRDK28UdkHDac4aaBz6Q/CsvgxRJ4dMugTlAsuVX8nnb8pfjIM
	 pzTgjFhC3suj0yQK4jOOrJoJ9uuvZz2qwdDFkJza80csR1J0GHuzux2AhUwvTjrE5R3Km
	 aC1KpigGA5+cCq8pdglwN1xcTU6JDX5Zmp5elm/6crRxQ3atGg4z5Ie6pqesDepecuGWd
	 3fsdrMIamJt+icrCjVqnSjNPlklDlP3tYMPPBxB2TFPwzs5rcTYTEkVop5enQrzLlbw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794911268;
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
	bh=Ur4TwgQnefBwrtSEK8w1Z3IbtUmZXTmHNZENglaBMIo=;
	b=RwurRFVc9xHJ1EoS86FzuzLEZQuT13Sss3x4SgDYSR7gQI03fAONssCH8dArrPtAs9oT
	 moKPPVf9cAmAnt1sJbaQF8U4Akazei1KIcxX81k6/iLmJH7vA8+mg++XMGGYnilXSmxjz
	 fvQD3TGn3L/WNji25NLCmdt28GrmaJqdEfRDwBmYNAxiDzhoGhe8TJszeep8hfRPii6J3
	 TJzRXUWRLu9FvDqIzrR2zC/IKPwiT3IKccQfDhw7Z2shd36T2NATih3Q1vSYOyyftZ5t0
	 0x/FtAkP31TL14TdN0mCtvRXdXfhyUNKXSGNxad8opRI+WQuNnu4iaaJQgHyOTpyZ6w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=renesas.com;
	spf=pass smtp.mailfrom=renesas.com;
	dkim=pass header.d=renesas.com header.i=@renesas.com header.a=rsa-sha256 header.s=selector1 header.b=WQlSkNjz;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.228.52
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010052.outbound.protection.outlook.com [52.101.228.52])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C8C8606A881;
	Tue, 17 Nov 2026 10:27:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9C8C8606A881
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=renesas.com header.i=@renesas.com header.a=rsa-sha256 header.s=selector1 header.b=WQlSkNjz
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dhwckCG0EwlFJK07Dlm0OTohrwD+q4rDy/PZiJ4IjEsjjp1yPr/SnxiMMK/25aFjt6oTOMUCQCwETnOuyWeX23+RzF77XYEajuWjJyogMd1NOFlNQbKw4wgm0DwC7BW9VViSYy4cegHf89UyOO+bX+nW21VZisFN2F12AZNOh9n0lz6dYUHUoKpWLNUhZR3H0aYX83ReCaVhJ2TB4fZ/3DCMTo+6KeH2I3TX0Vmh1GlaMhMjaCIeWaaMh8NulxIL68XVom5HGUG/H9/axoJdiRsXvSHUGlaVXEl0II3Exc/agoJQDIkxiPotEc4LrKGRShlKw68uIhL/24v318Eb4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ur4TwgQnefBwrtSEK8w1Z3IbtUmZXTmHNZENglaBMIo=;
 b=ImsIgoF2Vx//OXtHhtWoY2qxogAQC/AkDNoAXmI5VHelRrW2RAOcdVoyqfvlm3T0nU86Ngqf8AjZmrr/F5Nsp60WtEHXDR/7eHACDUUBhl93uOzMxjOJ870feymkAjy6hnRY8ADdqi3nO+HCCg7sQR4+h0wYDOiJkopamOq+T6/pfoHO0cVLJTY5hlB4rqxLKv4y4T5OF28qwhZ3D8Br9+K0yrFzommspGCwErjJNc+n8HwMAe7hxE7HF8ctJcBHTGVlIRw5dgXNumMXjyyl8MTmbIhR35q8oKg0rFbZiXKb8R/lBqB5kd7aFVe8Vc1QE3hGXsAgVxxljfGWsbqWkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bp.renesas.com smtp.mailfrom=renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ur4TwgQnefBwrtSEK8w1Z3IbtUmZXTmHNZENglaBMIo=;
 b=WQlSkNjzU5mtLeOUHwBnUVROQu9zSp2BhRhUSjIGM0L50jHlL2xoM9my326ipyVs/GGj31YbIN8wK8fgLHPCiMjNhODVxfpFYujJBitB7b1EhX0TT6FvEgmkbl5atrr/gtZ2EL5rW+xA0Jx3nPzOt9BGHrdpfQit9Z8TQJECaqE=
Received: from TY4P286CA0123.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:37c::13)
 by OS3PR01MB8489.jpnprd01.prod.outlook.com (2603:1096:604:195::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 10:27:36 +0000
Received: from TY1PEPF0000BAD7.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:37c:cafe::a8) by TY4P286CA0123.outlook.office365.com
 (2603:1096:405:37c::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.14 via Frontend Transport; Tue,
 17 Nov 2026 10:27:36 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 8.62.32.50) smtp.mailfrom=renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of renesas.com designates
 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay005p.adwin.renesas.com; pr=E
Received: from ejcrelay005p.adwin.renesas.com (8.62.32.50) by
 TY1PEPF0000BAD7.mail.protection.outlook.com (10.167.240.36) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.4
 via Frontend Transport; Tue, 17 Nov 2026 10:27:35 +0000
Received: from demon-pc.tailc3dc73.ts.net (DEU-5CG5050QD0.adwin.renesas.com [10.226.92.253])
	by ejcrelay005p.adwin.renesas.com (Postfix) with ESMTP id EEC3E3000255;
	Tue, 17 Nov 2026 19:27:33 +0900 (JST)
From: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
To: Biju Das <biju.das.jz@bp.renesas.com>,
	William Breathitt Gray <wbg@kernel.org>
Cc: linux-iio@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Subject: [PATCH v3 08/14] counter: rz-mtu3-cnt: cache count values
Date: Tue, 17 Nov 2026 12:26:01 +0200
Message-ID: <20261117102607.2504551-9-cosmin-gabriel.tanislav.xa@renesas.com>
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
X-MS-TrafficTypeDiagnostic: TY1PEPF0000BAD7:EE_|OS3PR01MB8489:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: a178e341-c9c1-4fcf-5302-08df449565e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|23010399003|36860700016|10067099003|11063799006|56012099006|261021121427099003|261026121527099003|261021123027099003|261102123227099003|261009223027099003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	0dzswdQhlBwgrdjsPV6EnewM+jHj/CfEzqQgVoBghwQPN0AfaDuwWcC2vDXZq6nEToWCVPuPWxJv+JoRbpt9FFpbAghl64RqUL4Ew7rrPNMvMGglCj3Fdfaa6Qhxhfir5TDFVanuDoetHNLs8Dlr9Jwy49ojX1reVE0brqJEWyVG2pypLRjxFCx5ErlMxG9NZeOyDCXOtDBUe8eTPDRf+H0MYDS4EujVIelv0c/bAkI5EjKEtgr5knU01EpqG4D+lWSPdGtYbUJqggFxZ2+QjzPeqbgMy6D+lZLt+LkMp5tpQzNx7pL/Pyi4Nnl3EqQqhndrGNqLDBbY+NZnwFt9Etpl5jsw68//wsWFMSwaTcnHeGx+Rfz3GG+f6AIQ0dVYkBHPMltn71LpM/YEkyR8woZmf0s1aad0Kls3LRwE0GfDjajYqoDVp8ggtFDXQyDEzkXUH16uoAMuLUDRFlfLE/vsTmbKsPjy2+DnTXMrEuFFaTdr5HVrFiwNefgbg0qL0GejbpeWK+T9dSVysRHwF56UkGGzk1C+5qnJeank3zOOqadm0EVjwsvNT4FXkTmgFxCoz9NNqTraanK4YSikhKVzhk0wg3/LFxQZDsaj72VyGlvH5OfubbSuuEzJTyWmIgYlry/b4NtgmKrK4Fn4+qwPxLNyWhh9PSvhl6dXm1nOgIvLGbnJFnQ2H9pF/c7vxkWwzQbhXX52hIHVCMwJeg==
X-Forefront-Antispam-Report:
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay005p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(23010399003)(36860700016)(10067099003)(11063799006)(56012099006)(261021121427099003)(261026121527099003)(261021123027099003)(261102123227099003)(261009223027099003)(18002099003)(22082099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	nldywAgbKOS0lgxXtrvNHO+NwF4+lHwKJw4fRsdcshFQgVOmecAXSdbgcoP88dnw+8Q3o/rg+tkrRAkEI3/DepTvIQf+z5HKzWBBNeiBa2HlRMXDB0+AztmQIBGNb6RoRtPurHRrbjO7Y0zjm9m2lS81YHWhHXawRty1CgQ3sJkxh4/gD2bFYqdpBM6o0UXzb1yNnkYd+UNDjj9j2eS5sg4GZ9SuBdC9Wj+tI7WZSNFnolua8PAxUYUAGruPwO82vYLIaP9/VkjzOwSv6UyUYoHtfgOyZxBNlDj19AXyuXAq/WqBkxw56sHJ/eGy2nJ00YAQjPGueArLV/LosFCkTSt7t7IQRNQKWupW9xo00kwsCh2NoPxT5ntZ5z1sn/vkQIFjgjmbxQl12FV4yNmyM1kQJWUbGgW/df1HLGvyAbbGUC3Wilom3YL7012Fs0jG
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 10:27:35.9861
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a178e341-c9c1-4fcf-5302-08df449565e7
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay005p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: TY1PEPF0000BAD7.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB8489

If an MTU3 channel is used in counting mode, and then in PWM mode, when
returning to counting mode the count value is lost because the TCNT
register is overwritten by PWM mode.

To handle this issue, save the count value on disable and restore it on
enable, and also save it inside rz_mtu3_count_write().

To avoid writing the count value register when the count is disabled,
and to prepare for the removal of the rz_mtu3_lock_if_counter_is_valid()
function which is susceptible to TOCTOU races because of the ch->is_busy
check, only read or write the count value if the count is enabled.

Mask the count value to the channel's width before caching it, so an
out-of-range write to a 16-bit channel is truncated the same way
a direct register write would have been.

Since runtime PM is ensured to be resumed if the count is enabled, drop
the pm_runtime_get_sync() and pm_runtime_put() calls.

Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
---

V3:
 * no changes

V2:
 * add struct rz_mtu3_cnt::count documentation
 * mask 16-bit counter value to preserve behavior

 drivers/counter/rz-mtu3-cnt.c | 47 ++++++++++++++++++++++++++---------
 1 file changed, 35 insertions(+), 12 deletions(-)

diff --git a/drivers/counter/rz-mtu3-cnt.c b/drivers/counter/rz-mtu3-cnt.c
index ff89ad409270..98e09e052aec 100644
--- a/drivers/counter/rz-mtu3-cnt.c
+++ b/drivers/counter/rz-mtu3-cnt.c
@@ -67,11 +67,13 @@
  * @ch: HW channels for the counters
  * @count_is_enabled: Enabled state of Counter value channel
  * @ceiling: Cache for ceiling values
+ * @count: Cache for count values
  */
 struct rz_mtu3_cnt {
 	struct mutex lock;
 	struct rz_mtu3_channel *ch;
 	u32 ceiling[RZ_MTU3_MAX_LOGICAL_CNTR_CHANNELS];
+	u32 count[RZ_MTU3_MAX_LOGICAL_CNTR_CHANNELS];
 	bool count_is_enabled[RZ_MTU3_MAX_LOGICAL_CNTR_CHANNELS];
 };
 
@@ -157,6 +159,23 @@ static void rz_mtu3_set_ceiling(struct rz_mtu3_channel *const ch, int id,
 	rz_mtu3_8bit_ch_write(ch, RZ_MTU3_TCR, RZ_MTU3_TCR_CCLR_TGRA);
 }
 
+static u32 rz_mtu3_get_count(struct rz_mtu3_channel *const ch, int id)
+{
+	if (id == RZ_MTU3_32_BIT_CH)
+		return rz_mtu3_32bit_ch_read(ch, RZ_MTU3_TCNTLW);
+	else
+		return rz_mtu3_16bit_ch_read(ch, RZ_MTU3_TCNT);
+}
+
+static void rz_mtu3_set_count(struct rz_mtu3_channel *const ch, int id,
+			      u32 count)
+{
+	if (id == RZ_MTU3_32_BIT_CH)
+		rz_mtu3_32bit_ch_write(ch, RZ_MTU3_TCNTLW, count);
+	else
+		rz_mtu3_16bit_ch_write(ch, RZ_MTU3_TCNT, count);
+}
+
 static int rz_mtu3_count_read(struct counter_device *counter,
 			      struct counter_count *count, u64 *val)
 {
@@ -168,12 +187,9 @@ static int rz_mtu3_count_read(struct counter_device *counter,
 	if (ret)
 		return ret;
 
-	pm_runtime_get_sync(counter->parent);
-	if (count->id == RZ_MTU3_32_BIT_CH)
-		*val = rz_mtu3_32bit_ch_read(ch, RZ_MTU3_TCNTLW);
-	else
-		*val = rz_mtu3_16bit_ch_read(ch, RZ_MTU3_TCNT);
-	pm_runtime_put(counter->parent);
+	if (priv->count_is_enabled[count->id])
+		priv->count[count->id] = rz_mtu3_get_count(ch, count->id);
+	*val = priv->count[count->id];
 	mutex_unlock(&priv->lock);
 
 	return 0;
@@ -184,18 +200,19 @@ static int rz_mtu3_count_write(struct counter_device *counter,
 {
 	struct rz_mtu3_channel *const ch = rz_mtu3_get_ch(counter, count->id);
 	struct rz_mtu3_cnt *const priv = counter_priv(counter);
+	u32 count_val = val;
 	int ret;
 
+	if (count->id != RZ_MTU3_32_BIT_CH)
+		count_val &= U16_MAX;
+
 	ret = rz_mtu3_lock_if_counter_is_valid(counter, ch, priv, count->id);
 	if (ret)
 		return ret;
 
-	pm_runtime_get_sync(counter->parent);
-	if (count->id == RZ_MTU3_32_BIT_CH)
-		rz_mtu3_32bit_ch_write(ch, RZ_MTU3_TCNTLW, val);
-	else
-		rz_mtu3_16bit_ch_write(ch, RZ_MTU3_TCNT, val);
-	pm_runtime_put(counter->parent);
+	if (priv->count_is_enabled[count->id])
+		rz_mtu3_set_count(ch, count->id, count_val);
+	priv->count[count->id] = count_val;
 	mutex_unlock(&priv->lock);
 
 	return 0;
@@ -382,6 +399,8 @@ static void rz_mtu3_32bit_cnt_setting(struct counter_device *counter)
 
 	rz_mtu3_set_ceiling(ch1, RZ_MTU3_32_BIT_CH,
 			    priv->ceiling[RZ_MTU3_32_BIT_CH]);
+	rz_mtu3_set_count(ch1, RZ_MTU3_32_BIT_CH,
+			  priv->count[RZ_MTU3_32_BIT_CH]);
 
 	rz_mtu3_8bit_ch_write(ch1, RZ_MTU3_TIOR, RZ_MTU3_TIOR_IC_BOTH);
 
@@ -398,6 +417,7 @@ static void rz_mtu3_16bit_cnt_setting(struct counter_device *counter, int id)
 	rz_mtu3_8bit_ch_write(ch, RZ_MTU3_TMDR1, RZ_MTU3_TMDR1_PH_CNT_MODE_1);
 
 	rz_mtu3_set_ceiling(ch, id, priv->ceiling[id]);
+	rz_mtu3_set_count(ch, id, priv->count[id]);
 
 	rz_mtu3_8bit_ch_write(ch, RZ_MTU3_TIOR, RZ_MTU3_TIOR_NO_OUTPUT);
 	rz_mtu3_enable(ch);
@@ -443,6 +463,9 @@ static void rz_mtu3_terminate_counter(struct counter_device *counter, int id)
 	struct rz_mtu3_channel *const ch = rz_mtu3_get_ch(counter, id);
 	struct rz_mtu3_channel *const ch1 = rz_mtu3_get_ch(counter, 0);
 	struct rz_mtu3_channel *const ch2 = rz_mtu3_get_ch(counter, 1);
+	struct rz_mtu3_cnt *const priv = counter_priv(counter);
+
+	priv->count[id] = rz_mtu3_get_count(ch, id);
 
 	if (id == RZ_MTU3_32_BIT_CH) {
 		rz_mtu3_disable(ch2);
-- 
2.56.0
