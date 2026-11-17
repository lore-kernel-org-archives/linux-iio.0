Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.125.0
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794911277;
	b=s7jOXwG/J7QCfGiPxWt0aspEPUJaTTKLJRzNNTXQ2X9SHec6Qw1wx06q8QI2htuz2zUs
	 DQCT34BpkVxteRTAfZ9ZtnzGrN9QOoKV6gT2fvdb/jPSOPSPK95vEpvpnH2nlP1fIEo20
	 800bFL4qd5J06qjIOsz+AWE8dOm7fxUs44bqxgDSUvtpLeW4fiJPhKRB+87nqzlqv0fuF
	 2fsKD3HSi+0/E3M+sTTKtHoBc3PrVgh01fKsVYMHwvdrgjsGlrzAoG20SDzEnPMYJSCTg
	 0KXhYqfFvOxT4Q6tMtOYcPU4YTc0yAClluBmkLpdogY0auXDaNk9D/RIeqmu1AkZWdQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794911277;
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
	bh=VDEm6G3mV6ckwx3QJub/LYcXh1wgwYuGzICLhje5b/Q=;
	b=MUXpUdavI7RoBEVeH1wToVpuB+yHHuuRznnv1mg9eaIDgokItCjxP/vnJDT6OLjOOqbz
	 xhyK/zTwtYNVRVwDf9B2BHhdUJfPsLKAY5ClS2zQ+AC+Ir+DQHB+ppdUx9OYomgQ1ACbl
	 xQeCo1zR2pVH88GXfvgW+UK8s6oUov7OsxIny4cOIjHKoHy5wYvgXhh1G4sgMGheTs9wQ
	 BnZMH7OTShGxZb3/SYvg69cnLPpO4yZ9x6H8aTG1huDSSM95RdWlXmfHygu88izNrM6LM
	 hj+9nASkCVn0x/pZlHDCA94VPGo6HFWwP3wWdTnDxKip/Tyz/mx1qZxwaWn8dLH67TQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=renesas.com;
	spf=pass smtp.mailfrom=renesas.com;
	dkim=pass header.d=renesas.com header.i=@renesas.com header.a=rsa-sha256 header.s=selector1 header.b=MMX3aWFU;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.125.0
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011000.outbound.protection.outlook.com [52.101.125.0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDAEA606A8A6;
	Tue, 17 Nov 2026 10:27:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EDAEA606A8A6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=renesas.com header.i=@renesas.com header.a=rsa-sha256 header.s=selector1 header.b=MMX3aWFU
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fabT/s7eQLG1GR2Qnz5ZRhFX/xxIR9CP3SH5fsXYHsf1tIlK24bcg49FSdM8roKNM2Fu/vxvRUhhMpnafknROK6XWl/qgqJguPc/iQMaehTf7mrRsO8Zt4qYEOBNOar7X/Bz6wDSIXsSP+dO1+N3VqWukY3WMWsViGrCTJVsAWCTVDGbA48PbX/eELHzkqq8ESJRY0NPCESQzjOocWDYKpnGq1M2Y8XM4gKgKOhnVxBEYo/fCmiH8TbajlIy8y0KcqxQaFA+TvuJIe23pk9GCz7UPj9ufXA4u/5GdZTPBUF3jaOGd3qjTDCnmvA4MwUvFjjm+SIRbPhuBpOOQwObBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VDEm6G3mV6ckwx3QJub/LYcXh1wgwYuGzICLhje5b/Q=;
 b=NCfKoCh1kDkJiB76byRrTV8Kn/ApgEbTNQp5OrqfVg3JgW9kIOoFOUAbvkHF46VNjcNHZOcr+8LfrSmEJcIwRZcIHBfe3RUWFB4t/8zx6ZTeAhG87FC2/2hPdh8Y7rfjxIvv5TtUjqS80QM52uve7vccY/FO7kw8WET3xELEIiX2TuNC79EB6Gf9wBMuhQvEwi6cOY3O8lW4OrVNWUQN6aisZuI9jC/wd7mBGDfbGhwT8gBk1e3rJj6vC2qW0pAcEloFpnohy/eku76ASHO+f9wXHOj66PzDDhg7VMxGvPWNcF9eySIEiL4GebexYIerp6mj6xM+zoYSrzIMMixDRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bp.renesas.com smtp.mailfrom=renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VDEm6G3mV6ckwx3QJub/LYcXh1wgwYuGzICLhje5b/Q=;
 b=MMX3aWFUkVbxxW8R+Wj9pQHEJ0tvjro0/azD6IjfdAaZUSpRM2qrZdjeku+fz6DDKI7kcyzfFom1PgCFtKgwElqMR7SnXcaR28Zdz2dPYbXAF37a9gGBWLVmVS6dhlXFbHIjD/SeUjhb450jBn1Iwt9asLnxgLATa+cnkhePTuI=
Received: from OS3PR01CA0003.jpnprd01.prod.outlook.com (2603:1096:604:dc::8)
 by TY4PR01MB14782.jpnprd01.prod.outlook.com (2603:1096:405:259::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 10:27:50 +0000
Received: from OS3PEPF0000003B.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:dc:cafe::9) by OS3PR01CA0003.outlook.office365.com
 (2603:1096:604:dc::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.13 via Frontend Transport; Tue,
 17 Nov 2026 10:27:50 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 8.62.32.50) smtp.mailfrom=renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of renesas.com designates
 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay005p.adwin.renesas.com; pr=E
Received: from ejcrelay005p.adwin.renesas.com (8.62.32.50) by
 OS3PEPF0000003B.mail.protection.outlook.com (10.167.240.4) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.5
 via Frontend Transport; Tue, 17 Nov 2026 10:27:50 +0000
Received: from demon-pc.tailc3dc73.ts.net (DEU-5CG5050QD0.adwin.renesas.com [10.226.92.253])
	by ejcrelay005p.adwin.renesas.com (Postfix) with ESMTP id B76953000255;
	Tue, 17 Nov 2026 19:27:48 +0900 (JST)
From: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
To: Biju Das <biju.das.jz@bp.renesas.com>,
	William Breathitt Gray <wbg@kernel.org>
Cc: linux-iio@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Subject: [PATCH v3 13/14] counter: rz-mtu3-cnt: drop conditional locks
Date: Tue, 17 Nov 2026 12:26:06 +0200
Message-ID: <20261117102607.2504551-14-cosmin-gabriel.tanislav.xa@renesas.com>
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
X-MS-TrafficTypeDiagnostic: OS3PEPF0000003B:EE_|TY4PR01MB14782:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 91d24d65-d846-47de-4d32-08df44956ebd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700016|23010399003|82310400026|10067099003|261021123027099003|56012099006|11063799006|261022105027099003|261026140227099003|261021121427099003|261028144727099003|261102123227099003|261009223027099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	EewQptBN4Xet8Lo5uZ63MqKLJOOgexhgY9C5II4DNH3pJdxGg80CJpjilk+2ugD+TysRSp3500G5rNeK15tBRI2IpfAuKHmnL1HWOByQyZpX1XZmgzOKZ39YG0/SgxRn5e9lImVoWx7C7oZXuWTrY184TJ29Jy9XfQSPsQ6RPecFuGL8GXKC7HAX+oQQ14PWGcXRIN/FaddObS/pj1u/1hga68GsxH6STQ8jlIiY6uCZhIsYFbxcLYgqXxRWWnUADG3gYZv/jPvXz+EC9wUF6Kws4yH/ukWdK5dih+9x2K4OAGJjtEChZ/W3Mz8qp9tUuz+erJpGyKXP25ELhapNG564YNHe5DtgdJQ1EPPLfTuDJ5DoR16/8QW/Ib4qRYtOFPpwjhPPeQ95f4R4+qm193KpNyG6VC4Dl7UKyw5IOtJ15r/ptIfJfMqz/P3A4K22hzr62S+8b5/3Bj02p4DXbC4j2cHEIiQCJklJ7koujFgAE0BsAqyRnXCqpig3R8A4G99NkLyCFBD5b2OugKDUeLJPN2HV7FWkxtcfe/uW556dAoDtKe//Lfc8JldOvHinVxjYFEyWBuD9OORl1wyGlUf0Rs0GDtoP8mQ4CCLR8LKpJ3wVs/dc6iwISEfKb1mss4v1N03Fqa9Gn07h71vTCpUc4It84rgOnsJelV0EEeMcniDEm52kxciQahzpTRvZLRdf5R4tO7vWFHFqdbGDjQ==
X-Forefront-Antispam-Report:
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay005p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700016)(23010399003)(82310400026)(10067099003)(261021123027099003)(56012099006)(11063799006)(261022105027099003)(261026140227099003)(261021121427099003)(261028144727099003)(261102123227099003)(261009223027099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	bA8OMUj9806uzmdYWhfmiWSFYCUzXp6URgtgEt7vcY2CEXQPqe2llmela2sStPFzybbYxNIlHDbl9cxlHWby3dlwi/sMscvGbYc5kZZFQH7oW34fGd9d+483Rw+9O0DJw0AQVK+6eDBf0VQng8kUmDCQoJo+CbTMyA9Co7plC7o7GlMp4+mQ2FKvTv6h/4q2TgF9nRlX0+uNiYeARRBW9rUlB1Y5zBGY5OXQQEBMJUAoCv3SpX/S7Qn3WtYmecCkp9wIG+oS0fER3gb601nLOrXrbP3SMQ3QrtLSPHNxexIEADpQDzszLyoPMqheo2p24Oepo/Z6OEGmMuUb2HEAZNAqeMjtkdPIJ/s860sE8fV9UIjBmBjnyaG3uJiNz7iW92guv5pvh9ZZ7RI9aqNnK+eDG0ieoyrM37SZQyjWHkx/w8a9F40Me1hFDF9ZaByB
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 10:27:50.7969
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 91d24d65-d846-47de-4d32-08df44956ebd
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay005p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: OS3PEPF0000003B.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB14782

All read and write operations now only access the hardware if the
respective count is enabled.

As a count cannot be enabled without the underlying MTU channel(s) being
claimed as busy by the count driver, drop conditional locks and replace
them with simple locks.

Use guard() where possible.

Remove the conditional locking functions as there are no users left.

Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
---

V3:
 * adapt to "put runtime PM ref if counter init fails" changes

V2:
 * no changes

 drivers/counter/rz-mtu3-cnt.c | 120 ++++++++--------------------------
 1 file changed, 26 insertions(+), 94 deletions(-)

diff --git a/drivers/counter/rz-mtu3-cnt.c b/drivers/counter/rz-mtu3-cnt.c
index 07dd7f588911..8252dee6d04d 100644
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
 		if (ret < 0) {
 			pm_runtime_put(counter->parent);
-			goto exit;
+			return ret;
 		}
 	} else {
 		rz_mtu3_terminate_counter(counter, count->id);
@@ -486,32 +448,16 @@ static int rz_mtu3_count_enable_write(struct counter_device *counter,
 
 	priv->count_is_enabled[count->id] = enable;
 
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
@@ -521,9 +467,8 @@ static int rz_mtu3_cascade_counts_enable_set(struct counter_device *counter,
 {
 	struct rz_mtu3_cnt *const priv = counter_priv(counter);
 
-	mutex_lock(&priv->lock);
+	guard(mutex)(&priv->lock);
 	priv->cascade_enable = cascade_enable;
-	mutex_unlock(&priv->lock);
 
 	return 0;
 }
@@ -532,14 +477,9 @@ static int rz_mtu3_ext_input_phase_clock_select_get(struct counter_device *count
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
@@ -548,17 +488,13 @@ static int rz_mtu3_ext_input_phase_clock_select_set(struct counter_device *count
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
@@ -584,14 +520,11 @@ static int rz_mtu3_action_read(struct counter_device *counter,
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
@@ -610,6 +543,8 @@ static int rz_mtu3_action_read(struct counter_device *counter,
 		}
 	}
 
+	mutex_unlock(&priv->lock);
+
 	switch (function) {
 	case COUNTER_FUNCTION_PULSE_DIRECTION:
 		/*
@@ -636,12 +571,9 @@ static int rz_mtu3_action_read(struct counter_device *counter,
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
2.56.0
