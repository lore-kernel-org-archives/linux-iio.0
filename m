Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011021.outbound.protection.outlook.com [52.101.125.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 650D249F125;
	Mon, 14 Sep 2026 20:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789418278; cv=fail; b=LCyFyzwoNrlGD9wX9t1I6+RVq6Ns3QmzGwIU3ullUTgOXDSMUfV1q8DyeZ2j6Pts+EaoTG+UxD2rRPdy+JWkuFUG8rSMTYlZgET2abN49Rn5dtRGkJeXGUWbzj/1i6+B8gqNeXFNLmKefEqKeWNfSbyCL2TqLQrfRbBfmyc5aMA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789418278; c=relaxed/simple;
	bh=gHtU3lsHSje9A5/MO3GWx1QA8MbRUOnabIKfzt4XwuQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UvUFEB+OZ0IXBntC3T5XSLR2HOTZRz34HrbDkmg4jCcq/5C0Bl5OHmCwGMryPYkhewPC6Y98EmoEaaFK5zLyjgYh878mLOvncqvIoEjf2Dr/eY+5f6jy/95iaitkSjvYQlK93PnNl6luuEQpZ4SFegfozvohThfAaKPzyv1EQ6Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=DFpz+zRp; arc=fail smtp.client-ip=52.101.125.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="DFpz+zRp"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ywDV1mHYMFWAHlqXei8DH4qOJWJCkzLzNKlHiXkFMNLHNv2lNCFaJT2oe6Xdsux6kYcy6AoS4kBOCpfdaF7Ls2x+3xQuOv2PFxbLgR1zom/XyQSkhaaUpAHmR+P4yAiY3c4YLPVFUlhev5Dwq7jP7USDYntaaqImLxXx9N+/uwht4CdLBgbEsoiPbMfEDwXnI6cpkWACgQGQsWX12jfX5Kl2OYwNEuCH9e+a9Q16Fxac4jQxDyofV7yNkKeYXWHf9C+0Rix2jC2Ry54PGSJkaF1gQnFMb9TlkGCUiqkuG3GIswbnRh5F/imbOVa5aA0SIPEV3Yn2xcmTfqyQicZwzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AAWN1tx+ynjw4xNkWP75QtutSb8CS4HMM5Rn1FyfGgk=;
 b=M89dqCMo7FVFu4iQ+DFMwaJdw0QnDiR0qkcv/k7EGfhWc86Dqc6zFZVCIE5z5oHdaC5LcCMzx60K+dNfHWxpeo7J1QhYqr1iXgp15dBlAYBlCkvVJZcw+4JHZgHiArvEzlcSpdfwtbDJ5S7VzY0WgaJ847EpR3yW6Q0NYbtXdNLO/4n+mDUIlig65SyE9LcguVOWQwiWVjNVmLm161bfvb6sJW3y/Y+N+nKt6yNCj01oUUb+471ZtssbeAf18yGdUWSVDMBnCwbJ7B9ny+28kCLYnKa82mTzAnUdDTf+rLq3yiHMDUMq6WT9Ag30NRh6hcgHKgiL/bY3CWdOnY6H1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bp.renesas.com smtp.mailfrom=renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AAWN1tx+ynjw4xNkWP75QtutSb8CS4HMM5Rn1FyfGgk=;
 b=DFpz+zRpo/6Q6U+Qib8e6xcO8yL0rtZL70J11TIKAuos2kboBZHa/s1ww+aPw/41Qi7xGklNS2P3LS9QnmgdzXIPOnUgPA2npFQFrt19GSglextbf+m60ncqIapprZ/Q4+G/lkA1rasXM+GvWrvyIQTsJeWPXd8T1k8XqKzuvvg=
Received: from TYCP301CA0051.JPNP301.PROD.OUTLOOK.COM (2603:1096:400:384::16)
 by OSCPR01MB13257.jpnprd01.prod.outlook.com (2603:1096:604:350::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Mon, 14 Sep
 2026 20:37:51 +0000
Received: from TY2PEPF00005621.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:384:cafe::5) by TYCP301CA0051.outlook.office365.com
 (2603:1096:400:384::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.12 via Frontend Transport; Mon,
 14 Sep 2026 20:37:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.62.32.50)
 smtp.mailfrom=renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of renesas.com designates
 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 TY2PEPF00005621.mail.protection.outlook.com (10.167.240.52) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.7
 via Frontend Transport; Mon, 14 Sep 2026 20:37:51 +0000
Received: from demon-pc.localdomain (unknown [10.226.93.156])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id 4E7343000368;
	Tue, 15 Sep 2026 05:37:49 +0900 (JST)
From: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
To: Biju Das <biju.das.jz@bp.renesas.com>,
	William Breathitt Gray <wbg@kernel.org>,
	Lee Jones <lee@kernel.org>
Cc: linux-iio@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Subject: [PATCH 09/15] counter: rz-mtu3-cnt: cache count values
Date: Mon, 14 Sep 2026 23:36:08 +0300
Message-ID: <20260914203614.2035277-10-cosmin-gabriel.tanislav.xa@renesas.com>
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
X-MS-TrafficTypeDiagnostic: TY2PEPF00005621:EE_|OSCPR01MB13257:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 7fc2701b-6ce0-4d7c-2bfc-08df12a00c2c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|23010399003|82310400026|1800799024|3023799007|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	ph3rcp88aLeRREiSfNooZerPYglqDLvRvDmQI9gF/AZltkDexqsWpp0VKqAUNikIVDgJC6joHnZzPQxN4ySkff3LrBrs2z4/uCD+djzrJ+sdObqZnqKfMx0XLg70noaU5ZzAk6CBBYlG/aFDFEqRwOTGOgOnOFaEH+1Ejbje14Aoo2qrTXZJGacHanQ9F1sSIi0mPGRjBHteh0z7BqlhV3cbkM7ltJfuC5BuCjuyaaHk1rNNvQQq1BfV4wZKFvUntBxhfHYP43PJBn1oL5DWm5MiS27CuJUr1E4Pr/emmMa/7MgeucBgvOdjwWhJDNrd5NQrm1oIRxz9sfl8lx/ENHjhYrfS1lmDkwv2FeHkclWLWxjU5+zyfy+Lntq0tHPNajWKDqH1sMjmbX04VHkm/rIjz5ZuZQUSKvF4fnexE3K8gDC14eO7WSbuWMFTHA1u1UGfrUzimQeogGtrJUR2hjhV0eBPOV5hBfegO5nYn2l6wGAG0j8o9PLOBpqFaf5plXtmHyuq9zKm7wKP2dcpb2CxVzqUufXIWWxKLxj1WnnBVUnwYfrPz2xtF821lyf816IXtT8hvmqqVc2IskI+4IJd0NNSxnVpWJKmDRhmFp0knnu0kYjK1mVil/xSWBsFxYTFN84nSjUulkI/RGeHeo/m2qUAfIMLq213dlLLJUP1SYAXC9N614Cl+gOB3h5wLBfI8Uk4LS8edG/VAG3m/w==
X-Forefront-Antispam-Report:
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(376014)(23010399003)(82310400026)(1800799024)(3023799007)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Q70LBAklrL4ZjjQwL0d+I5zvcUOVdEB+twpn+qRFY5t56cA5Jr3/cOPKUncY5ZpxMJv03zhUHuhwlL0+dgYVazC7O/TNUfYq7w9EUhYuKPWeuDkam2JE914BPbHAhGo36q/6SaVylNqUZjTy1mTAbewiUFCaFM7HbyZh1irzKD+fWeelR6iRz2nZdGYGKIy4ZgkeDZh8iU/DpUnr/NcJYMpq6aUs3i0F2nwH8OHDFdPZG/fqqm8FBVozXKlPy6ldD5cRYCrw1rKl3el6f558oAnnPhinfp3W9kRSKimihCTNuCi/dPJ8eDU6gqEPN5OqfCoKowk+9YujYmNF+V0baCOcQAoss+4lA1HZsJ+x+YzeAC41/BxmaCasgx4qq8ih8+mJKi/AIwrLXOE1l3mcjjnIFh9DDethnl85cTtCTnMYi/CahWJwUVSwXQlPfuwD
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2026 20:37:51.7636
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fc2701b-6ce0-4d7c-2bfc-08df12a00c2c
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: TY2PEPF00005621.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB13257

If an MTU3 channel is used in counting mode, and then in PWM mode, when
returning to counting mode the count value is lost because the TCNT
register is overwritten by PWM mode.

To handle this issue, save the count value on disable and restore it on
enable, and also save it inside rz_mtu3_count_write().

To avoid writing the count value register when the count is disabled,
and to prepare for the removal of the rz_mtu3_lock_if_counter_is_valid()
function which is susceptible to TOCTOU races because of the ch->is_busy
check, only read or write the count value if the count is enabled.

Since runtime PM is ensured to be resumed if the count is enabled, drop
the pm_runtime_get_sync() and pm_runtime_put() calls.

Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
---
 drivers/counter/rz-mtu3-cnt.c | 42 +++++++++++++++++++++++++----------
 1 file changed, 30 insertions(+), 12 deletions(-)

diff --git a/drivers/counter/rz-mtu3-cnt.c b/drivers/counter/rz-mtu3-cnt.c
index b76ad6cb8b6d..68025c6ed409 100644
--- a/drivers/counter/rz-mtu3-cnt.c
+++ b/drivers/counter/rz-mtu3-cnt.c
@@ -76,6 +76,7 @@ struct rz_mtu3_cnt {
 	struct mutex lock;
 	struct rz_mtu3_channel *ch;
 	u32 ceiling[RZ_MTU3_MAX_LOGICAL_CNTR_CHANNELS];
+	u32 count[RZ_MTU3_MAX_LOGICAL_CNTR_CHANNELS];
 	bool count_is_enabled[RZ_MTU3_MAX_LOGICAL_CNTR_CHANNELS];
 };
 
@@ -161,6 +162,23 @@ static void rz_mtu3_set_ceiling(struct rz_mtu3_channel *const ch, int id,
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
@@ -172,12 +190,9 @@ static int rz_mtu3_count_read(struct counter_device *counter,
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
@@ -194,12 +209,9 @@ static int rz_mtu3_count_write(struct counter_device *counter,
 	if (ret)
 		return ret;
 
-	pm_runtime_get_sync(counter->parent);
-	if (count->id == RZ_MTU3_32_BIT_CH)
-		rz_mtu3_32bit_ch_write(ch, RZ_MTU3_TCNTLW, val);
-	else
-		rz_mtu3_16bit_ch_write(ch, RZ_MTU3_TCNT, val);
-	pm_runtime_put(counter->parent);
+	if (priv->count_is_enabled[count->id])
+		rz_mtu3_set_count(ch, count->id, val);
+	priv->count[count->id] = val;
 	mutex_unlock(&priv->lock);
 
 	return 0;
@@ -386,6 +398,8 @@ static void rz_mtu3_32bit_cnt_setting(struct counter_device *counter)
 
 	rz_mtu3_set_ceiling(ch1, RZ_MTU3_32_BIT_CH,
 			    priv->ceiling[RZ_MTU3_32_BIT_CH]);
+	rz_mtu3_set_count(ch1, RZ_MTU3_32_BIT_CH,
+			  priv->count[RZ_MTU3_32_BIT_CH]);
 
 	rz_mtu3_8bit_ch_write(ch1, RZ_MTU3_TIOR, RZ_MTU3_TIOR_IC_BOTH);
 
@@ -402,6 +416,7 @@ static void rz_mtu3_16bit_cnt_setting(struct counter_device *counter, int id)
 	rz_mtu3_8bit_ch_write(ch, RZ_MTU3_TMDR1, RZ_MTU3_TMDR1_PH_CNT_MODE_1);
 
 	rz_mtu3_set_ceiling(ch, id, priv->ceiling[id]);
+	rz_mtu3_set_count(ch, id, priv->count[id]);
 
 	rz_mtu3_8bit_ch_write(ch, RZ_MTU3_TIOR, RZ_MTU3_TIOR_NO_OUTPUT);
 	rz_mtu3_enable(ch);
@@ -447,6 +462,9 @@ static void rz_mtu3_terminate_counter(struct counter_device *counter, int id)
 	struct rz_mtu3_channel *const ch = rz_mtu3_get_ch(counter, id);
 	struct rz_mtu3_channel *const ch1 = rz_mtu3_get_ch(counter, 0);
 	struct rz_mtu3_channel *const ch2 = rz_mtu3_get_ch(counter, 1);
+	struct rz_mtu3_cnt *const priv = counter_priv(counter);
+
+	priv->count[id] = rz_mtu3_get_count(ch, id);
 
 	if (id == RZ_MTU3_32_BIT_CH) {
 		rz_mtu3_disable(ch2);
-- 
2.55.0

