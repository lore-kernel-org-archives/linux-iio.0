Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011013.outbound.protection.outlook.com [40.107.74.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BBAF4734F2;
	Sun,  4 Oct 2026 17:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791136196; cv=fail; b=s/OcXM+IQtHD1MjXlq7ZU0Ea2zeL6Rr/4fiSIpj0KmsTUQa6XDI4vhoMlb5GznUOmwL66V7GON0kAAHYMEjtZ9nJZQYOKKCJqOdBqJoVLvQikYg/e9aj2Zs6sZAdg0nGUqB/0+ncPUY3KuKfrdW3zQRF/Y+RcLG69WfaaxSBCeU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791136196; c=relaxed/simple;
	bh=SaeaxicBS4W8AuLA5PwANUitVIeZ6zjFDitnEUfITyM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UA2ec3ZXdLUKs/HR4Znkuuigs+HZvNpDEPzp+saCzuZXKqXLthTNB0E+LroI/BSwzNu3adrG98bmnMx1Ji4X5O5DHW7aUX86cRjsniqARO+d7DWsoOmX6plwRMk5rLcRjGSSthNcvknt88Is8B7nYotD4vx+ailWPudUnpJSJOU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=PfqUXqvf; arc=fail smtp.client-ip=40.107.74.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="PfqUXqvf"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HkSZudx46iovwli7PewWwuMDWaDxUVxu+Qq4ZE+3a2AjjnVFvEPDxQ2aB3YB4bXwv+iD8eP7FrGQsuRGnvXo3LWkzCOeAUR2ie4FF0ualWgFhC6Boxfe1S7Ko721QocE6BS8wzP8pSCcqVY7YPs5ZO+Ge3m0PQ+ZHBRa0Hotsmi7lMYn2Qwxxt72rWNCVj7+cSsnGVZ66z10KK1X0WDsGt0txzO97FZXZ+0ssMYnfspnVju772KQj894ksYtgwVAtk7CwmRtWZZIJlGJbVy255deagPTv5n4aLny6IcNZ8wKaIahjPtTMtSzgXDpgRtdgq9Gks9EtWc76Hbv14KujA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e51aERvsGPUrJeYC++KkBhiPg/kxtwGpKBbFuct2bXc=;
 b=tiWsb5KvLIESwh04cNpbmkSMd92gx1Pi0LeGxbcMtx0VXh2Dv7s8Ob5uGiJwyYGdD+9nXViu5ZvavOw/uhd6e4nlOCeCSRKhd1b4y2qfAWthdeosPuZCGIQhO+uOMsyiXqUD8xs3VvNPzbdi/eurqyAFzjs9OLqziEi1i5Jl+cfv0neSKusf2dNRsje1b0p6Vso1CGyBR6Xu+ugCCj5e8jIIHA6HgTf9V/1YxQ+BRMxxJvzUfYeyUosmBJHXnWWIYUUZ+Cc/7b2KZL/ZAjkGvjWRRR6GFAuSNph+N5KvXQbmxhj/06Ujsd1jB2suZ3jRpJnmB4XmC4AbdVAXlY6g2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bp.renesas.com smtp.mailfrom=renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e51aERvsGPUrJeYC++KkBhiPg/kxtwGpKBbFuct2bXc=;
 b=PfqUXqvf3uY9htIzcNc9okx23pFEk5KHb03C5+gwa56wRQHzt2P/mH9BPZd+leQhle/shhj5MWj4RToBgMXjmtsn/39l99/waM36meNYha/Da4oVI+tnKTGm04Xr0nDpdPzj4sbtLuPbPLC5lfmLqb/H+1VOcXBUJJPoc0wxTRs=
Received: from OS3PR01CA0074.jpnprd01.prod.outlook.com (2603:1096:604:da::7)
 by TYYPR01MB12210.jpnprd01.prod.outlook.com (2603:1096:405:f8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Sun, 4 Oct
 2026 17:49:38 +0000
Received: from OS1PEPF0000D213.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:da:cafe::6b) by OS3PR01CA0074.outlook.office365.com
 (2603:1096:604:da::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.9 via Frontend Transport; Sun, 4
 Oct 2026 17:49:38 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 8.62.32.50) smtp.mailfrom=renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of renesas.com designates
 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 OS1PEPF0000D213.mail.protection.outlook.com (10.167.240.20) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.14
 via Frontend Transport; Sun, 4 Oct 2026 17:49:38 +0000
Received: from demon-pc (unknown [10.226.92.36])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id 5D2303000256;
	Mon,  5 Oct 2026 02:49:36 +0900 (JST)
From: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
To: Biju Das <biju.das.jz@bp.renesas.com>,
	William Breathitt Gray <wbg@kernel.org>
Cc: linux-iio@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Subject: [PATCH v2 13/15] counter: rz-mtu3-cnt: keep cascade_counts_enable in sync with usage
Date: Sun,  4 Oct 2026 20:47:50 +0300
Message-ID: <20261004174752.507499-14-cosmin-gabriel.tanislav.xa@renesas.com>
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
X-MS-TrafficTypeDiagnostic: OS1PEPF0000D213:EE_|TYYPR01MB12210:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: b698d2a6-7f67-4e55-a7e0-08df223fdc5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|23010399003|1800799024|376014|82310400026|22082099003|18002099003|6133799003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	WWUPMvjRFNd1CQyOviUkVJC5ZWxfe/ET7z8OWVwE1gDXLdO3otVlPdk2ixZFDFjdUPvDi8bJTHLpai0Xe/cw33Hv2Kuz/TH1dDutGGyqWEyU0XAJX+8ZTuKaOIgB2yZH2hycYenHL3OUGnJiPrL/rF7oZ7S4yIHcEGdFARqKhGMeSUDnPPWxLXy0aSCDawYrAZJjJmy3fdthVLl3rNQc7DCNzEkVk55uXLsQF9EqyXQJ/ku2DfG237qUWo/WpRlS2GkFKr1W2kXaSbmEypqd9ABpQr4GWtP/94+sH4SmB4hIE1KOrcSsh1k+iFfzOQfl8Gto7a8JwkKQ167JI/O/RAbJAqmlZhZaoY1WM5yUBzGtFbDB3CyYFop36vyZlYvN5lriHmweRBow8+PJpfGj1klJY0dWg1QDxJ47uC0UtVbUPn3MBRpakU3tjorILv3zyVAHM4ZfNugS+HHONl240PPs5x3MH9bbuz/wDGco6bKIAeMA/bcJBNYuPYk96f3k2oDPx+KGNvFpuNtE5NpyjVVZM3ZfYjQ8fpQ7yYURd4FJ8ZWX1zuXSmOPcfHbZlqeaVT1mYAXop3DA74Nt4hKS9b23nOgIHgCnCQ9dNF/Wiz9S+u6yhkA+aDnau8iWY51/HAs1U/t+r3t0pEGpKZjoY1q451iCeeABV+aRxAhWk5tT9aAu8ljPilTer6a+GHA0XvAfXOlVPM8uAlHDUiuag==
X-Forefront-Antispam-Report:
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(1800799024)(376014)(82310400026)(22082099003)(18002099003)(6133799003)(10067099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	PvbS1HjIFlfWSXmVP8r+h/I2Yq15+0DEjsY3NYLUbgUwwSwh8hhw2/pS3lgbuNwWBivaS/FljaF8pIVcWM1TVRu4kd42jAEysbgUT5xHRLul06WJt8gDnQDhnJ3P5z/9FgB3uV0QlkDReYDctc3Y+mwlJP48mX2gAdug9+PdgbqZjQADv4fRreVElxQrfe7fOePRjXZVIppNYH7YWnYBFU3GukoXh0ofqoHFGH//FcPFLUIKLc4/wKiH7ESLqY7NsaBW73dDvzEOSj7oeSsQMNoxVzXdokfNXb8AdkRBWnu7lijL7iZRyJLk3LIVr2QjCQPEd52D4DhbuDLjOzco/PtmbeNDrZr6Fbs1td5HojziE5SEwP4NUOIHivVzJOF9eTI9tGYg/yKV31uTgbWAvqhfpAcIu1bnI3xgSK/o85OdguYy7OZleOZs8w38nBnY
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2026 17:49:38.4815
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b698d2a6-7f67-4e55-a7e0-08df223fdc5f
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: OS1PEPF0000D213.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB12210

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

V2:
 * add struct rz_mtu3_cnt::cascade_counts_enable documentation
 * move rz_mtu3_set_lwa() call after rz_mtu3_disable()
 * mention the removed busy check in the message

 drivers/counter/rz-mtu3-cnt.c | 95 +++++++----------------------------
 1 file changed, 18 insertions(+), 77 deletions(-)

diff --git a/drivers/counter/rz-mtu3-cnt.c b/drivers/counter/rz-mtu3-cnt.c
index e36c61ae35d1..9be65df799af 100644
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
@@ -553,17 +509,9 @@ static int rz_mtu3_cascade_counts_enable_get(struct counter_device *counter,
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
@@ -573,16 +521,9 @@ static int rz_mtu3_cascade_counts_enable_set(struct counter_device *counter,
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
