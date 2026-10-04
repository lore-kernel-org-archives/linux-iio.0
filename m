Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010003.outbound.protection.outlook.com [52.101.228.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 959354749E9;
	Sun,  4 Oct 2026 17:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791136201; cv=fail; b=Jj1Q22r1g+4MxKJop3kc4dj14WSFrFdIxW/4we3OOJIt4MUY841Ji+T2FXyMkwQ1S2ZEbeXDqac00i4s0CsHhzRMLoJs084nvbJ2xXzJH+o338JZwWjrYxr7XN2hTJ7Lg+jLbQ3gywFwXeuf+sHftv7tYWEKYXkwsSFNMFjiQWY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791136201; c=relaxed/simple;
	bh=Uv6nKqJWGYXXIrAAjxqYENRdVKFsTb5II0QTn1iBmxo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VzFLOwVG8PRWHtyFGDcszXBcLEbk5/9OVHkuf4nCO795gIwliikK1B+Mq/eSld8Yz/EHYEnOjJ8xhKzSacbsLWPwUy6O8iQJErXdlLdn8DJ6odMLeTmZ6Qnp1DbL2u/OMa56qlQYSMHM0PsdkD96WWyr3cEAOM4HHo5kSbOq0iw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=ogTsXVTr; arc=fail smtp.client-ip=52.101.228.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="ogTsXVTr"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JtZp04g3pnvzwr2TluuQMecYvGorzSE6DQnfhdYPYuSIi0Ml8AG2RoSVnVTGfmnGfzHmTj01eHkImVkF2UZ9oY22WErwhoDNr20Z88PQhF6VndKTz5kXRT4k9CYvsx3pxWFCb80JO54sMfTfZAcvMQv1bYGLHd/FcRkr7TIKEscDwEpPc6FbZq6L0N+lABn5Y2Wn8S207/56XmoWr7XpVKGXDJEnCynFiOwfP3Ovcwk9goaOrvA+Q3C9CyyVNmYMMFTojefQza6ClO7n2i8rHZQLoVSmrX6p4qz0w3WNjN0ENfuHgVwFIlCBhTogYlTarn3w+p0ucmWnNTmmb6q9DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZzFU+dOr31Ogz8AJlwII+ddrxSrgIEJfEGM3py1PLvE=;
 b=vT/NYgSbVEd8TaR5pc1qqg22K75toFREKrWwtpYPNi/iHDGoUYVSsnQPok+m3TRLga1GUpRYFg70L87u+jHXBzc0x4WKFsNTI59kUrvmJqtx4oMvqXao4EyP7ipGgcYBPFa/ttiEUVaO2JSIger9+yzoCDosHo6EIrLSJvi+i2ucNz1Eyn4wK1St+kBhDc8NsVN3aS9rJFO7M2sBY5TisGnTAhLmem2LGbAleNCqbTqbJ8OQAlBpAtvnofwPH3Q15fOWbB0b2+etVvqwYqDUJY4KL67k2kto2NYtoudAXaRb98tVnBnX3c39aqgk/y60dIByW3sgZghhsjXwqtaXfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bp.renesas.com smtp.mailfrom=renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZzFU+dOr31Ogz8AJlwII+ddrxSrgIEJfEGM3py1PLvE=;
 b=ogTsXVTrMD5yxwVfZoYV+QBqPUoOQ4RSerCWsm570Lannn1ImGOqoEGvnaTnanTeSwRnwTtuqsbjrjuLpGNzibsKowu8kOP1P41DClQNL0sVEYnCellQA1Tu1tqKqfgmFHBFZdFCiRlJzXs8hNnvSdmKPU8fIKlqy1S88FGdImk=
Received: from OSTPR01CA0011.jpnprd01.prod.outlook.com (2603:1096:604:220::8)
 by TYWPR01MB10968.jpnprd01.prod.outlook.com (2603:1096:400:394::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Sun, 4 Oct
 2026 17:49:41 +0000
Received: from OS3PEPF0000003D.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:220:cafe::23) by OSTPR01CA0011.outlook.office365.com
 (2603:1096:604:220::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Sun, 4
 Oct 2026 17:49:41 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 8.62.32.50) smtp.mailfrom=renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of renesas.com designates
 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 OS3PEPF0000003D.mail.protection.outlook.com (10.167.240.6) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.14
 via Frontend Transport; Sun, 4 Oct 2026 17:49:41 +0000
Received: from demon-pc (unknown [10.226.92.36])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id 79C623000256;
	Mon,  5 Oct 2026 02:49:39 +0900 (JST)
From: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
To: Biju Das <biju.das.jz@bp.renesas.com>,
	William Breathitt Gray <wbg@kernel.org>
Cc: linux-iio@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Subject: [PATCH v2 14/15] counter: rz-mtu3-cnt: drop conditional locks
Date: Sun,  4 Oct 2026 20:47:51 +0300
Message-ID: <20261004174752.507499-15-cosmin-gabriel.tanislav.xa@renesas.com>
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
X-MS-TrafficTypeDiagnostic: OS3PEPF0000003D:EE_|TYWPR01MB10968:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 49e67b8e-eb7d-4567-ba7c-08df223fde3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|23010399003|1800799024|376014|82310400026|18002099003|22082099003|6133799003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	AA0T5vfx/ga05v3sWz5j5G6D5Zm7nNUgjbvcf/rjhTmasnXNRaqswiSs9MUV4m5j8x73TlVAe5gy6EAqAzdfoSTwethQZ+JJz5zOUO9rmKyBpw7HMuWeJJ01rIa763suIEM7SaDrcgiFtLAJXx3pZGcKeG5xSnL8f7mX4Cv8/Mw2G5hpFerS0h0Tx1qc2qFZEq4fP5wwN+vJ7PN1G1QQVcvmTrbnvUR5ck/VkB2JjrYnnPc5/Oqx61Jo5U4fei6RKbQGkuNQ649VXJoqILhYoRUjUfr1l/+U7FTKYwp7sarbKdqg67SMH3NuRDkD533G+ihqBqoq++OZ0x8/cTx+gxwqFlkztgmHA3R89iu15gWpbUVLMpqjbiG0yYe0zwklN+hM+5EZaQSLH97pve4vfqpoAwNosQb/VyJMesvjHbV/GHQzaQHoPsWC93Ig0NxnbH/y6xVlSfYW4K3EFTWzu1QBJEkku9rr4d9Pg+u9MzXUMH6jEekRTW4S9aj0yNvx2SRmB4QAsRvXaFxBo+CXfGv2+uxprU5iASQc9Qh2SgyfviqpsdRsYN55H/8ACqKoU1za8vCWc7xS1SzvZdNydOQU9p39aIQPEmnA8LY7uAizU7zrs7UFFb42scNAwqq3uI/ciqRoCM1VXNbvRH7tLc3VpAaz1BVLPzvN62PxOae7lnm9Es1zfZePuye8JywLwgR9ozxtCmKKsYlRh+42Bg==
X-Forefront-Antispam-Report:
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(1800799024)(376014)(82310400026)(18002099003)(22082099003)(6133799003)(10067099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Hkm46BQkAtXvvH+ZAmVQ+06L07BQbdMPzKt7YRuq3oBxVM512XVQixU8OFNA5+pojHKJGlIDlBLNVEeM7uIPgHPulqrFWjjKInT0gbqxxdbEZEvwgwhV6EnrkuWl27TVX7DOpy7VIKiLFsxob3GO15cQjwrYFNpSbaZ1k2FxVEit8Us0QPDLVeSoFbGQCaJR0fBRSXDOZkPFPfbLYwTHmg7o1eqM4f1GjATBPJcxFXNuLWhEbmjmQQobGDVoIXAw/IPyTF5v3SYkX49wsOrmubJj3DSyapnYlVR3OzLhZ2Ge0x1fS2dOmwEXhN0KVPZWnu8Hu4Zw8SFqZ2AEwA9cmrKOrZTdQGY7L8X0K54OlKVnJnICYqi+SmnRRWIyiMeGs7BKyFCzMq+7lnRwWpEXB+l44GerbksJAL8aHmq8Sd60k4ek5g4Ytpr7sC9wkq1I
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2026 17:49:41.6085
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 49e67b8e-eb7d-4567-ba7c-08df223fde3c
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: OS3PEPF0000003D.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB10968

All read and write operations now only access the hardware if the
respective count is enabled.

As a count cannot be enabled without the underlying MTU channel(s) being
claimed as busy by the count driver, drop conditional locks and replace
them with simple locks.

Use guard() where possible.

Remove the conditional locking functions as there are no users left.

Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
---

V2:
 * no changes

 drivers/counter/rz-mtu3-cnt.c | 120 ++++++++--------------------------
 1 file changed, 26 insertions(+), 94 deletions(-)

diff --git a/drivers/counter/rz-mtu3-cnt.c b/drivers/counter/rz-mtu3-cnt.c
index 9be65df799af..d1d955ee67f1 100644
--- a/drivers/counter/rz-mtu3-cnt.c
+++ b/drivers/counter/rz-mtu3-cnt.c
@@ -104,20 +104,6 @@ static inline struct rz_mtu3_channel *rz_mtu3_get_ch(struct counter_device *coun
 	return &priv->ch[ch_id];
 }
 
-static int rz_mtu3_lock_if_count_is_enabled(struct rz_mtu3_channel *const ch,
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
-	return 0;
-}
-
 static void rz_mtu3_set_ceiling(struct rz_mtu3_channel *const ch, int id,
 				u64 ceiling)
 {
@@ -171,11 +157,11 @@ static int rz_mtu3_count_read(struct counter_device *counter,
 	struct rz_mtu3_channel *const ch = rz_mtu3_get_ch(counter, count->id);
 	struct rz_mtu3_cnt *const priv = counter_priv(counter);
 
-	mutex_lock(&priv->lock);
+	guard(mutex)(&priv->lock);
+
 	if (priv->count_is_enabled[count->id])
 		priv->count[count->id] = rz_mtu3_get_count(ch, count->id);
 	*val = priv->count[count->id];
-	mutex_unlock(&priv->lock);
 
 	return 0;
 }
@@ -190,11 +176,11 @@ static int rz_mtu3_count_write(struct counter_device *counter,
 	if (count->id != RZ_MTU3_32_BIT_CH)
 		count_val &= U16_MAX;
 
-	mutex_lock(&priv->lock);
+	guard(mutex)(&priv->lock);
+
 	if (priv->count_is_enabled[count->id])
 		rz_mtu3_set_count(ch, count->id, count_val);
 	priv->count[count->id] = count_val;
-	mutex_unlock(&priv->lock);
 
 	return 0;
 }
@@ -227,18 +213,11 @@ static int rz_mtu3_count_function_read(struct counter_device *counter,
 				       struct counter_count *count,
 				       enum counter_function *function)
 {
-	struct rz_mtu3_channel *const ch = rz_mtu3_get_ch(counter, count->id);
 	struct rz_mtu3_cnt *const priv = counter_priv(counter);
-	int ret;
 
-	ret = rz_mtu3_lock_if_count_is_enabled(ch, priv, count->id);
-	if (ret)
-		return ret;
+	guard(mutex)(&priv->lock);
 
-	ret = rz_mtu3_count_function_read_helper(priv, count->id, function);
-	mutex_unlock(&priv->lock);
-
-	return ret;
+	return rz_mtu3_count_function_read_helper(priv, count->id, function);
 }
 
 static int rz_mtu3_count_function_write(struct counter_device *counter,
@@ -248,11 +227,6 @@ static int rz_mtu3_count_function_write(struct counter_device *counter,
 	struct rz_mtu3_channel *const ch = rz_mtu3_get_ch(counter, count->id);
 	struct rz_mtu3_cnt *const priv = counter_priv(counter);
 	u8 timer_mode;
-	int ret;
-
-	ret = rz_mtu3_lock_if_count_is_enabled(ch, priv, count->id);
-	if (ret)
-		return ret;
 
 	switch (function) {
 	case COUNTER_FUNCTION_QUADRATURE_X4:
@@ -270,14 +244,14 @@ static int rz_mtu3_count_function_write(struct counter_device *counter,
 		 *  - need to add RZ_MTU3_TMDR1_PH_CNT_MODE_3
 		 *  - need to add RZ_MTU3_TMDR1_PH_CNT_MODE_5
 		 */
-		mutex_unlock(&priv->lock);
 		return -EINVAL;
 	}
 
+	guard(mutex)(&priv->lock);
+
 	if (priv->count_is_enabled[count->id])
 		rz_mtu3_8bit_ch_write(ch, RZ_MTU3_TMDR1, timer_mode);
 	priv->timer_mode[count->id] = timer_mode;
-	mutex_unlock(&priv->lock);
 
 	return 0;
 }
@@ -288,11 +262,8 @@ static int rz_mtu3_count_direction_read(struct counter_device *counter,
 {
 	struct rz_mtu3_channel *const ch = rz_mtu3_get_ch(counter, count->id);
 	struct rz_mtu3_cnt *const priv = counter_priv(counter);
-	int ret;
 
-	ret = rz_mtu3_lock_if_count_is_enabled(ch, priv, count->id);
-	if (ret)
-		return ret;
+	guard(mutex)(&priv->lock);
 
 	if (priv->count_is_enabled[count->id])
 		priv->direction[count->id] = rz_mtu3_get_direction(ch);
@@ -300,8 +271,6 @@ static int rz_mtu3_count_direction_read(struct counter_device *counter,
 	*direction = priv->direction[count->id] ?
 		COUNTER_COUNT_DIRECTION_FORWARD : COUNTER_COUNT_DIRECTION_BACKWARD;
 
-	mutex_unlock(&priv->lock);
-
 	return 0;
 }
 
@@ -311,9 +280,9 @@ static int rz_mtu3_count_ceiling_read(struct counter_device *counter,
 {
 	struct rz_mtu3_cnt *const priv = counter_priv(counter);
 
-	mutex_lock(&priv->lock);
+	guard(mutex)(&priv->lock);
 	*ceiling = priv->ceiling[count->id];
-	mutex_unlock(&priv->lock);
+
 	return 0;
 }
 
@@ -324,32 +293,26 @@ static int rz_mtu3_count_ceiling_write(struct counter_device *counter,
 	struct rz_mtu3_channel *const ch = rz_mtu3_get_ch(counter, count->id);
 	struct rz_mtu3_cnt *const priv = counter_priv(counter);
 
-	mutex_lock(&priv->lock);
-
 	switch (count->id) {
 	case RZ_MTU3_16_BIT_MTU1_CH:
 	case RZ_MTU3_16_BIT_MTU2_CH:
-		if (ceiling > U16_MAX) {
-			mutex_unlock(&priv->lock);
+		if (ceiling > U16_MAX)
 			return -ERANGE;
-		}
 		break;
 	case RZ_MTU3_32_BIT_CH:
-		if (ceiling > U32_MAX) {
-			mutex_unlock(&priv->lock);
+		if (ceiling > U32_MAX)
 			return -ERANGE;
-		}
 		break;
 	default:
 		/* should never reach this path */
-		mutex_unlock(&priv->lock);
 		return -EINVAL;
 	}
 
+	guard(mutex)(&priv->lock);
+
 	if (priv->count_is_enabled[count->id])
 		rz_mtu3_set_ceiling(ch, count->id, ceiling);
 	priv->ceiling[count->id] = ceiling;
-	mutex_unlock(&priv->lock);
 
 	return 0;
 }
@@ -454,9 +417,8 @@ static int rz_mtu3_count_enable_read(struct counter_device *counter,
 {
 	struct rz_mtu3_cnt *const priv = counter_priv(counter);
 
-	mutex_lock(&priv->lock);
+	guard(mutex)(&priv->lock);
 	*enable = priv->count_is_enabled[count->id];
-	mutex_unlock(&priv->lock);
 
 	return 0;
 }
@@ -467,17 +429,17 @@ static int rz_mtu3_count_enable_write(struct counter_device *counter,
 	struct rz_mtu3_cnt *const priv = counter_priv(counter);
 	int ret = 0;
 
-	mutex_lock(&priv->lock);
+	guard(mutex)(&priv->lock);
 
 	if (priv->count_is_enabled[count->id] == enable)
-		goto exit;
+		return 0;
 
 	if (enable) {
 		pm_runtime_get_sync(counter->parent);
 		ret = rz_mtu3_initialize_counter(counter, count->id);
 		if (ret) {
 			pm_runtime_put(counter->parent);
-			goto exit;
+			return ret;
 		}
 
 		priv->count_is_enabled[count->id] = true;
@@ -487,32 +449,16 @@ static int rz_mtu3_count_enable_write(struct counter_device *counter,
 		pm_runtime_put(counter->parent);
 	}
 
-exit:
-	mutex_unlock(&priv->lock);
-
 	return ret;
 }
 
-static int rz_mtu3_lock_if_ch0_is_enabled(struct rz_mtu3_cnt *const priv)
-{
-	mutex_lock(&priv->lock);
-	if (priv->ch->is_busy && !(priv->count_is_enabled[RZ_MTU3_16_BIT_MTU1_CH] ||
-				   priv->count_is_enabled[RZ_MTU3_32_BIT_CH])) {
-		mutex_unlock(&priv->lock);
-		return -EINVAL;
-	}
-
-	return 0;
-}
-
 static int rz_mtu3_cascade_counts_enable_get(struct counter_device *counter,
 					     u8 *cascade_enable)
 {
 	struct rz_mtu3_cnt *const priv = counter_priv(counter);
 
-	mutex_lock(&priv->lock);
+	guard(mutex)(&priv->lock);
 	*cascade_enable = priv->cascade_enable;
-	mutex_unlock(&priv->lock);
 
 	return 0;
 }
@@ -522,9 +468,8 @@ static int rz_mtu3_cascade_counts_enable_set(struct counter_device *counter,
 {
 	struct rz_mtu3_cnt *const priv = counter_priv(counter);
 
-	mutex_lock(&priv->lock);
+	guard(mutex)(&priv->lock);
 	priv->cascade_enable = cascade_enable;
-	mutex_unlock(&priv->lock);
 
 	return 0;
 }
@@ -533,14 +478,9 @@ static int rz_mtu3_ext_input_phase_clock_select_get(struct counter_device *count
 						    u32 *ext_input_phase_clock_select)
 {
 	struct rz_mtu3_cnt *const priv = counter_priv(counter);
-	int ret;
-
-	ret = rz_mtu3_lock_if_ch0_is_enabled(priv);
-	if (ret)
-		return ret;
 
+	guard(mutex)(&priv->lock);
 	*ext_input_phase_clock_select = priv->mtclkc_mtclkd;
-	mutex_unlock(&priv->lock);
 
 	return 0;
 }
@@ -549,17 +489,13 @@ static int rz_mtu3_ext_input_phase_clock_select_set(struct counter_device *count
 						    u32 ext_input_phase_clock_select)
 {
 	struct rz_mtu3_cnt *const priv = counter_priv(counter);
-	int ret;
 
-	ret = rz_mtu3_lock_if_ch0_is_enabled(priv);
-	if (ret)
-		return ret;
+	guard(mutex)(&priv->lock);
 
 	if (priv->count_is_enabled[RZ_MTU3_16_BIT_MTU2_CH] ||
 	    priv->count_is_enabled[RZ_MTU3_32_BIT_CH])
 		rz_mtu3_set_phcksel(priv->ch, ext_input_phase_clock_select);
 	priv->mtclkc_mtclkd = ext_input_phase_clock_select;
-	mutex_unlock(&priv->lock);
 
 	return 0;
 }
@@ -585,14 +521,11 @@ static int rz_mtu3_action_read(struct counter_device *counter,
 {
 	const bool is_signal_ab = (synapse->signal->id == SIGNAL_A_ID) ||
 				  (synapse->signal->id == SIGNAL_B_ID);
-	struct rz_mtu3_channel *const ch = rz_mtu3_get_ch(counter, count->id);
 	struct rz_mtu3_cnt *const priv = counter_priv(counter);
 	enum counter_function function;
 	int ret;
 
-	ret = rz_mtu3_lock_if_count_is_enabled(ch, priv, count->id);
-	if (ret)
-		return ret;
+	mutex_lock(&priv->lock);
 
 	ret = rz_mtu3_count_function_read_helper(priv, count->id, &function);
 	if (ret) {
@@ -611,6 +544,8 @@ static int rz_mtu3_action_read(struct counter_device *counter,
 		}
 	}
 
+	mutex_unlock(&priv->lock);
+
 	switch (function) {
 	case COUNTER_FUNCTION_PULSE_DIRECTION:
 		/*
@@ -637,12 +572,9 @@ static int rz_mtu3_action_read(struct counter_device *counter,
 		break;
 	default:
 		/* should never reach this path */
-		mutex_unlock(&priv->lock);
 		return -EINVAL;
 	}
 
-	mutex_unlock(&priv->lock);
-
 	return 0;
 }
 
-- 
2.55.0
