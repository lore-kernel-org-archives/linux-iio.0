Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010067.outbound.protection.outlook.com [52.101.229.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CEB04A091B;
	Mon, 14 Sep 2026 20:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789418294; cv=fail; b=Z7LvRcdHxS/FvMe2A+ZCASzOvrGQsB6U0WR8C7rZQxSlt9+G+F46sYef3dBK9G+9kHrzYKkr4YtHscRdLVKvKgNQ6EJEZs3RkpxEdSPFrDOAXOFDswAY53AmnWyHwFFPg6kHMrOOJkxi4P26e/fngpsJr4zXHZbYw7IWkqWMSXM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789418294; c=relaxed/simple;
	bh=Riiw9jg7Nes+cJGTim5Do3shbLmqCCdrxW9KDla95xY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AjJCL615iDT/2XhR1y0MYeKDA2w9AJWjjMkd250wGS90H2T7Da0PmQ3XIJo9XzFtDXlaIWy+uHZlLoecInOixzzNPK9uxSBXvu9twEovp+ULVnzNddxWoOTFzJJv6TEckLZHHivKtVoT75Oibu/CdxGPKwsPAnLE5GHUe5rjfZI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=anxh9xg9; arc=fail smtp.client-ip=52.101.229.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="anxh9xg9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c4PoEu8EtTr5y0GQWuxVmA8um23a97Dl/QSxYKQhFyH14ccGXs6T9/Vyjt/8rtF1lw/0N6JMtGq+EDwZtcg2QSAdxFFeUAtYVHtGwUMyP6TPm/H3iur1yxVF5ERPKIS33NWIYCePp4vUdOT4ps6DEwaA1pZe5SgjP8/Vg2q4Dufa5u97hcsBSODFrmkdwW2kR21urorZehjLfj6PLxwuk5tx80ijdU6/ffxJdZXfprIfbH4mgmItMDOwjb4b+r9d6KjMrpiAFmpowkXfiM5Lyo6V1SaCPgyAOWddLjHsKRllq+n1uh4NQIZy6W1SO1ecKOrGZAU66VcIneMG4xytkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m9Ae2rIZbL70OsnZKz8mxni2punQpG9eHARa4f6SbZA=;
 b=LGwjx+eAQ47Hgymi8CwFEgK4ud0bYhLvqIkFJkMn//5+bLM0AMdQquFJjy22pTnUbKdC7/jfsX9Jqh/jt3XxoYMV5mbHLQvXFHR04Yvoqf9DqMllQE+HE8OOzsxAZ7q6cwRE8lLZfH6kOzA9XYLh9DgBIhVI4dypDqAby76DAkRh+3PqsUtMbYfXtPuin1vPyfjYrctRrYrpiGg3D8aHbTE1/mgV0I70LaAmL6zEtIs7vvnzEYMmt/B9OOlGro+FBumYffOmuFT8E1WqWkG/kxEnY2s6H3nHvzxyCNHEMuqxVocjYhGyJ+vDfQnMTiN4/fmVEkG1GEBzhokNape4Ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bp.renesas.com smtp.mailfrom=renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m9Ae2rIZbL70OsnZKz8mxni2punQpG9eHARa4f6SbZA=;
 b=anxh9xg9W3a0ryCbgXGqb9DmFdXVHJzlJi1z3oclROAs3Xung/WmT5IeWKSqnFTJYMp/yxk816SC+XX3ZtnR/QtBmnsd2IJOKOEkcYKFnS0Cea0+QWyEM64GrNCkBFxY2pPgSTRPMMUfA+UN88BbG4k7K7MvL0oj8DdfCLWEhNQ=
Received: from TYWP286CA0003.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:178::22)
 by OS9PR01MB17219.jpnprd01.prod.outlook.com (2603:1096:604:40d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Mon, 14 Sep
 2026 20:38:06 +0000
Received: from TYO1EPF00005025.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:178:cafe::9b) by TYWP286CA0003.outlook.office365.com
 (2603:1096:400:178::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.12 via Frontend Transport; Mon,
 14 Sep 2026 20:38:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.62.32.50)
 smtp.mailfrom=renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of renesas.com designates
 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 TYO1EPF00005025.mail.protection.outlook.com (10.167.240.22) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.7
 via Frontend Transport; Mon, 14 Sep 2026 20:38:06 +0000
Received: from demon-pc.localdomain (unknown [10.226.93.156])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id 24EE13000257;
	Tue, 15 Sep 2026 05:38:03 +0900 (JST)
From: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
To: Biju Das <biju.das.jz@bp.renesas.com>,
	William Breathitt Gray <wbg@kernel.org>,
	Lee Jones <lee@kernel.org>
Cc: linux-iio@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Subject: [PATCH 13/15] counter: rz-mtu3-cnt: keep cascade_counts_enable in sync with usage
Date: Mon, 14 Sep 2026 23:36:12 +0300
Message-ID: <20260914203614.2035277-14-cosmin-gabriel.tanislav.xa@renesas.com>
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
X-MS-TrafficTypeDiagnostic: TYO1EPF00005025:EE_|OS9PR01MB17219:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 522b1287-6671-416c-b956-08df12a01511
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|82310400026|36860700016|6133799003|22082099003|18002099003|10067099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	BtDyk5pxcMe+Lrb/JoJUMctRuQw/gZnd0LmA9f1GQNzS1/cpO1vVFa3IzGZhEnBj59D0gOZBWiJfvWOj7LwJfw4DnWO9VrBbWG0ghoa2fTI2L0psDSx7T4xz/P/8cYXMGY7INCH9UccIpWJL2qiV3h2ZN1bQqBlhpv6332eFXszhk7sVTqTwznk7wPNpZm9HSWuwQtKbWK2+zHSMaKvDqD+7mDvv0Tz80KjTgmgNH1ypmkko2kEsYmHc2B3DdAXzNSuSHESCE+LeaO+J441SJILhgr4Vas1ss983Y/BHInbNV4G1FGx5G0JBeH2CMk+swFSLRoupVOakgRdAoFNC4WcnGcQkOB/4hNzOqxIzKi4UfGrChWIP0OALc6Smbbw0gTJqbZJBJPNwqHYv/sYhyjCl+aG7+veCYEvXW1jeHsSduW8JtxNkU6M/GzoXZpLthA/ze/myZkBNI3q7H7Cggw564ZzNRbg6NXLHPtHf+J4EsTufIC4IK5+4eKDHsN/atR5UJ0uZVMuX5WTpj3vznkOP66zQYUcoyqlEBgTHVUNcv+9cj6wc8cgQNE2nSdl4WS9z6bbV7iiefc93UGz2VDlU2p+WK4V6lvxFqLo3Vr4qGHADtaVYqrarLpYC9eS/lTgOAsRE8vIklaN0Vg83iHs60HpbPsstYUiE+MATvZUxmq98nnmg+Dt+kd9oG7p2
X-Forefront-Antispam-Report:
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(82310400026)(36860700016)(6133799003)(22082099003)(18002099003)(10067099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	0/J+j0V7KiGzxvYDXbjTXdhSqkRw1SfI31+noEz0KZJVlyhzN3lSYtnL54tiL4k2KDnV887L7IlXD8zt57gxBS+aB4bBaq+cvIpJjcwkh+oXod146/Z8trfdMmaAaB/MZKOfISzkvbDZiLbWfgYVU5I8J6DWidmD4CDcsiS7LQH/FAwadpLGYvqHRLjVIIQ6UrjrBFYYpfE5fmpcnLdATOhG0I7RJjP+CPu6g+lr8cVhDjeQkK0helQRJfTEnqkW2ONMNPT65xX1AIlkCg9uP8+O1BJeLDva0IRMznAGp353lENWuX2Lt8Lhb+5AuOR3yP2J4bp09sKMdxkC2K46vWMicj8wHRNMKDkBGxopeLNUv0uXwkeKlAkwEUGWPLTyneazQMcovDTEIgJsN/S1zOzhA5oN1WOB96O4kMTsCxsOPBJjD6hqVSaVqNtr844g
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2026 20:38:06.6952
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 522b1287-6671-416c-b956-08df12a01511
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: TYO1EPF00005025.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9PR01MB17219

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

Remove rz_mtu3_is_counter_invalid() checks as it is now guaranteed that
LWA has the proper value if a count is enabled.

Keep the cascade_counts_enable sysfs entry for ABI compatibility.

Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
---
 drivers/counter/rz-mtu3-cnt.c | 94 +++++++----------------------------
 1 file changed, 17 insertions(+), 77 deletions(-)

diff --git a/drivers/counter/rz-mtu3-cnt.c b/drivers/counter/rz-mtu3-cnt.c
index 5fd12941df4c..d519e6ab56ee 100644
--- a/drivers/counter/rz-mtu3-cnt.c
+++ b/drivers/counter/rz-mtu3-cnt.c
@@ -81,6 +81,7 @@ struct rz_mtu3_cnt {
 	bool count_is_enabled[RZ_MTU3_MAX_LOGICAL_CNTR_CHANNELS];
 	bool direction[RZ_MTU3_MAX_LOGICAL_CNTR_CHANNELS];
 	bool mtclkc_mtclkd;
+	bool cascade_enable;
 };
 
 static const enum counter_function rz_mtu3_count_functions[] = {
@@ -102,44 +103,6 @@ static inline struct rz_mtu3_channel *rz_mtu3_get_ch(struct counter_device *coun
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
@@ -195,17 +158,19 @@ static bool rz_mtu3_get_direction(struct rz_mtu3_channel *const ch)
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
@@ -219,12 +184,8 @@ static int rz_mtu3_count_write(struct counter_device *counter,
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
 		rz_mtu3_set_count(ch, count->id, val);
 	priv->count[count->id] = val;
@@ -343,14 +304,9 @@ static int rz_mtu3_count_ceiling_read(struct counter_device *counter,
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
@@ -362,11 +318,8 @@ static int rz_mtu3_count_ceiling_write(struct counter_device *counter,
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
@@ -403,6 +356,7 @@ static void rz_mtu3_32bit_cnt_setting(struct counter_device *counter)
 	struct rz_mtu3_cnt *const priv = counter_priv(counter);
 
 	rz_mtu3_set_phcksel(priv->ch, priv->mtclkc_mtclkd);
+	rz_mtu3_set_lwa(ch1, true);
 
 	rz_mtu3_8bit_ch_write(ch1, RZ_MTU3_TMDR1,
 			      priv->timer_mode[RZ_MTU3_32_BIT_CH]);
@@ -479,6 +433,7 @@ static void rz_mtu3_terminate_counter(struct counter_device *counter, int id)
 	priv->direction[id] = rz_mtu3_get_direction(ch);
 
 	if (id == RZ_MTU3_32_BIT_CH) {
+		rz_mtu3_set_lwa(ch1, false);
 		rz_mtu3_disable(ch2);
 		rz_mtu3_disable(ch1);
 		rz_mtu3_release_channel(ch2);
@@ -549,17 +504,9 @@ static int rz_mtu3_cascade_counts_enable_get(struct counter_device *counter,
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
@@ -569,16 +516,9 @@ static int rz_mtu3_cascade_counts_enable_set(struct counter_device *counter,
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
2.55.0

