Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011011.outbound.protection.outlook.com [52.101.125.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C144A0148;
	Mon, 14 Sep 2026 20:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789418298; cv=fail; b=drzDIXRZQRv5+IPIpmh1Tojn5+4tJFVI8/bWuUVJspYLdnseH5tYYjZRMavpucQwk4lHLq7iwD66C8kA++jkgedDu2HBieu6kSaIWA8A8l+COL0xVDR/n5aOKbQi0JL+5tAPhbYmyENGd6iztCBCtydhCroXol94VSb1aO+zm9s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789418298; c=relaxed/simple;
	bh=TAa68+yZZ0yBtDZW1vjvdGpAsW8JtOwCn7ydzJqpiCg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iHWGhuJSL+zvtSS4EAF8cH1mbH07SiXGFqNBnLeMsoU5iKhePmvlFTsyGjwdJiwdZmCexJmSSwFUWqFdsxWTt7pe8DQBPkwd/ksbqVP0UeX45+M0p9P9bmdoNPhOZ9RW19OEq67eemD4jnopPCf+88XChoupCfi9xFqd/XkcOac=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=Cp9sShxX; arc=fail smtp.client-ip=52.101.125.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="Cp9sShxX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VQ+MTqUy6YJBG6Y/NGYrYOK6cX/ULnPwPCEHFWUt8eZBFFf3GkwlzR4kwQ9IdrO+Ehjlt0bsXSfw0/c3wVk9fmqtP0bs9wPkOi9NBhL9LF+0kw9D7/h7mIBSD7rMve67NlVIyDoEmSfxv8M/fkD9/D9NmNtYoz04bjeh0wqHgSVNpeF3VcBJ3troshSP4q4c81bLf82dgGMDynSsgN/qvuwlrJHgCra4tNO1FLqSYJ039zGIbgPlgwujiFVzYhVrnQs37wk4SAlmfDA2gp2kpe0ygQzjqC21mf9ULfzkzGVQDBDKSUZNk11DPxnGtLSOLZJO06pQO/SQLm6vnUIFqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RKPDZfcDX6Mg1nyNIFBtM18dkeRDl8mTVlQD2BJBTUs=;
 b=X77cl/BGJ2D4kMmPcvh/mVk+ni6TUWB78nbK2MXccTb7lhwPCtDq87TbQiLQWejvC8hhvogmeAlwEkBoUdyf3dXY5dclp5kjuwWRPbTpYXC9/tmfMKV0v3Mk487w4fjVx7oktOk6SQuHJoudBSI0WZEu3EzzHTerIdOXHu0VbF48wH5tllqoLYoXrogTlAwd93AbjlcZchmc/yy3KqAsRjaf2JX/77/5flPMA8yCmtTywFKkZUhzghGbpWDRkiu68sjWJy5ZUJB6Pi/b3VvIqegrAlgqmv368yhx9aQWwNGqiTFNZuca5k9Qsnlj8cyxPAkxLKl992m5WCed7gY10w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bp.renesas.com smtp.mailfrom=renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RKPDZfcDX6Mg1nyNIFBtM18dkeRDl8mTVlQD2BJBTUs=;
 b=Cp9sShxX8iEo9o7UDAI9pTumYKt12Ju3CrraZFHVCXs2ra0Ipy1uFnDLM3XE0NhtnBVUWW2FyiHmmWLlS322MxtWkZ9dStENjDLPRIlEI4OvnzMJR6urGybzL+YjkrQuBca/TV26sT30CXvx+IeOTU6H8YMp+3vbwkpGpRoq3Pc=
Received: from TYWP286CA0007.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:178::15)
 by TYYPR01MB14100.jpnprd01.prod.outlook.com (2603:1096:405:213::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Mon, 14 Sep
 2026 20:38:10 +0000
Received: from TYO1EPF00005025.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:178:cafe::6c) by TYWP286CA0007.outlook.office365.com
 (2603:1096:400:178::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.12 via Frontend Transport; Mon,
 14 Sep 2026 20:38:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.62.32.50)
 smtp.mailfrom=renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of renesas.com designates
 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 TYO1EPF00005025.mail.protection.outlook.com (10.167.240.22) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.7
 via Frontend Transport; Mon, 14 Sep 2026 20:38:10 +0000
Received: from demon-pc.localdomain (unknown [10.226.93.156])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id 3C3453000476;
	Tue, 15 Sep 2026 05:38:07 +0900 (JST)
From: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
To: Biju Das <biju.das.jz@bp.renesas.com>,
	William Breathitt Gray <wbg@kernel.org>,
	Lee Jones <lee@kernel.org>
Cc: linux-iio@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Subject: [PATCH 14/15] counter: rz-mtu3-cnt: drop conditional locks
Date: Mon, 14 Sep 2026 23:36:13 +0300
Message-ID: <20260914203614.2035277-15-cosmin-gabriel.tanislav.xa@renesas.com>
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
X-MS-TrafficTypeDiagnostic: TYO1EPF00005025:EE_|TYYPR01MB14100:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 032d031a-264d-4e40-c5b5-08df12a01787
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|23010399003|376014|36860700016|10067099003|6133799003|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	2tqHJOwwG+oIxrU5dKR/snOFiFrnHCCa1VBgtDuxfRnw8bDadO2GMn6HJMW04n5NMG3nZTbhaat0qjvzu+NPai1zkmh/ldkvweyQe1e/EahSrwzlFDTt57oZRPmQSOjAj6V3LIo1m7wtmSbMlBSlLc3mokbNzjDGHTnd/KKnudLDcvuZAqWh07FApwkWLEhTTBH/6JkNz5BbtOLoKh4geebmv5jbNO/8mRZ8Kbj+kaZ5Lt2enG2Dse3gPbZ2Y2ErkVawV5V+MQOvet7G6mTYDL4f3QojKHP3ajZ1JkdAe+8mQ5zZwgjcm0mA0REYN6YryrHInr1+4pM64HSzbLIWJ+RbxuIfjonLfMz8eKwehZZGQ5t5eKg/EyIEweKkqwTWqt2w1yRXGFqKp/W7B2l5HNsC2xlr/Ji0VzFSRJb5TMOtKTDH92bY1ZnU9KqtVR74LZU8hkeULqIRmp3W+EvMj8h4afsfea6SfTm/Eku6eAfjWwcHAyESFRiafgMGlwuz9hdSOMfOVdiR1y4HXdA8SXSJxDgX72amgQrtS5mty+0CwtsLyudB9KuUbj2Swg5EPOBmYS1+R4wdMOOLYHzGD0rKafsq646gkoqW5spbvmt0Kq5SIKivUrDoX/ts0OnjWXYzWTGiM5fCZNp2fO4s5xXWOsoyiz92XntTxIJXdytw0QFJ3QIuKaX/wE08c3kNLuqGZU3OemEUO/2BmVE94w==
X-Forefront-Antispam-Report:
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(23010399003)(376014)(36860700016)(10067099003)(6133799003)(18002099003)(22082099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	oltx1MbNKPhVkhoEAcjnYDJmgOjjfkZuLFweA6Qu4Pa9GPyUKEV6Og6/Ek4c8CKuTwjgf197mYFIk6S4NvYbgi/2nrndvzAhnV7z91WzFt2IFeg6GlEAVrF3K2qjOVbDPwThkqXnpsgpsiZ5SMFySK4erm4M3Hyh/fbElc2sgM2g80p6Fryu6mCqkuM2EcB422jENl85Yk9xwQ9h4m7FjW76bijCC8QNLb1qwMH/E1eOH3K1BeyeHc4QQvDo4uoAbvCWiMT72RJqY/2k3vEMYyxt6j3C5ILtZ0MdJ3w/c3PbXns6m45GoeedMCl37DpM22QIICIj8Ug9fqrMf2O+AHx78+5Rs181veF2ufoHvUJ2TXuRbl4XhLgAB8+bPyhO01XeFpttPwIklEnTlcJTaUk6qQLQJsi8493F0AuWUoMzo3gPbh+Qy1Hge0OhZwp4
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2026 20:38:10.8234
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 032d031a-264d-4e40-c5b5-08df12a01787
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: TYO1EPF00005025.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB14100

All read and write operations now only access the hardware if the
respective count is enabled.

As a count cannot be enabled without the underlying MTU channel(s) being
claimed as busy by the count driver, drop conditional locks and replace
them with simple locks.

Use guard() where possible.

Remove the conditional locking functions as there are no users left.

Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
---
 drivers/counter/rz-mtu3-cnt.c | 120 ++++++++--------------------------
 1 file changed, 26 insertions(+), 94 deletions(-)

diff --git a/drivers/counter/rz-mtu3-cnt.c b/drivers/counter/rz-mtu3-cnt.c
index d519e6ab56ee..f3e8fe5cb818 100644
--- a/drivers/counter/rz-mtu3-cnt.c
+++ b/drivers/counter/rz-mtu3-cnt.c
@@ -103,20 +103,6 @@ static inline struct rz_mtu3_channel *rz_mtu3_get_ch(struct counter_device *coun
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
@@ -170,11 +156,11 @@ static int rz_mtu3_count_read(struct counter_device *counter,
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
@@ -185,11 +171,11 @@ static int rz_mtu3_count_write(struct counter_device *counter,
 	struct rz_mtu3_channel *const ch = rz_mtu3_get_ch(counter, count->id);
 	struct rz_mtu3_cnt *const priv = counter_priv(counter);
 
-	mutex_lock(&priv->lock);
+	guard(mutex)(&priv->lock);
+
 	if (priv->count_is_enabled[count->id])
 		rz_mtu3_set_count(ch, count->id, val);
 	priv->count[count->id] = val;
-	mutex_unlock(&priv->lock);
 
 	return 0;
 }
@@ -222,18 +208,11 @@ static int rz_mtu3_count_function_read(struct counter_device *counter,
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
@@ -243,11 +222,6 @@ static int rz_mtu3_count_function_write(struct counter_device *counter,
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
@@ -265,14 +239,14 @@ static int rz_mtu3_count_function_write(struct counter_device *counter,
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
@@ -283,11 +257,8 @@ static int rz_mtu3_count_direction_read(struct counter_device *counter,
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
@@ -295,8 +266,6 @@ static int rz_mtu3_count_direction_read(struct counter_device *counter,
 	*direction = priv->direction[count->id] ?
 		COUNTER_COUNT_DIRECTION_FORWARD : COUNTER_COUNT_DIRECTION_BACKWARD;
 
-	mutex_unlock(&priv->lock);
-
 	return 0;
 }
 
@@ -306,9 +275,9 @@ static int rz_mtu3_count_ceiling_read(struct counter_device *counter,
 {
 	struct rz_mtu3_cnt *const priv = counter_priv(counter);
 
-	mutex_lock(&priv->lock);
+	guard(mutex)(&priv->lock);
 	*ceiling = priv->ceiling[count->id];
-	mutex_unlock(&priv->lock);
+
 	return 0;
 }
 
@@ -319,32 +288,26 @@ static int rz_mtu3_count_ceiling_write(struct counter_device *counter,
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
@@ -449,9 +412,8 @@ static int rz_mtu3_count_enable_read(struct counter_device *counter,
 {
 	struct rz_mtu3_cnt *const priv = counter_priv(counter);
 
-	mutex_lock(&priv->lock);
+	guard(mutex)(&priv->lock);
 	*enable = priv->count_is_enabled[count->id];
-	mutex_unlock(&priv->lock);
 
 	return 0;
 }
@@ -462,17 +424,17 @@ static int rz_mtu3_count_enable_write(struct counter_device *counter,
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
@@ -482,32 +444,16 @@ static int rz_mtu3_count_enable_write(struct counter_device *counter,
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
@@ -517,9 +463,8 @@ static int rz_mtu3_cascade_counts_enable_set(struct counter_device *counter,
 {
 	struct rz_mtu3_cnt *const priv = counter_priv(counter);
 
-	mutex_lock(&priv->lock);
+	guard(mutex)(&priv->lock);
 	priv->cascade_enable = cascade_enable;
-	mutex_unlock(&priv->lock);
 
 	return 0;
 }
@@ -528,14 +473,9 @@ static int rz_mtu3_ext_input_phase_clock_select_get(struct counter_device *count
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
@@ -544,17 +484,13 @@ static int rz_mtu3_ext_input_phase_clock_select_set(struct counter_device *count
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
@@ -580,14 +516,11 @@ static int rz_mtu3_action_read(struct counter_device *counter,
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
@@ -606,6 +539,8 @@ static int rz_mtu3_action_read(struct counter_device *counter,
 		}
 	}
 
+	mutex_unlock(&priv->lock);
+
 	switch (function) {
 	case COUNTER_FUNCTION_PULSE_DIRECTION:
 		/*
@@ -632,12 +567,9 @@ static int rz_mtu3_action_read(struct counter_device *counter,
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

