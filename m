Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.125.63
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794911273;
	b=Iuu9hHmeqcVtmA8F3XHJ/fDQRTjkVvwZxokAa8TmeINBlYcoMlF8iQLq1emwcuG1qYfm
	 x29XfIycHjrGoV/sQ5/6XtdOiyc2jYpWgt3nt+9SfFAjuWTAeP8OhYnWAKezW/GqY/+kI
	 Vj/h2Auo5ASw5YBlR+wwIcISCS4iIz5yVZ13mOLZ5bcVETMtHe8KrO4JeQafI/ScsjwQI
	 ZBR3pl9vBT75wDDzuasqdS//WYiriACEMPm9fTjOr/PjBRpNKNVGQNZ9o3YW9w+hUGQaa
	 Yw5OGuLHlIrsl6HGGGZz1BNv1h1hbtVCyQ2OPH40Hv4X3ff9s5wolLw1HSvXsSCv/8A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794911273;
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
	bh=D4FoUVV9xGEXP+7xl2NaMlUA+fSh1Wy/73hRXLkmeV4=;
	b=qv2FjYH/K2ZWm0HSa6K5BPCVcChwOFWL9pTrpqgWJingGobgo6MgK8xcJ1bp8xkXtT0P
	 3HBbE8YTQqyFj4U+g4U9CCYo0RrPoXbrMFwNCofC+R2O8AKTJpgu1KrVzaSHAtT5CJLHb
	 R7kNQZu/Rh/FRTskXRIdW42+qV6eg1fjX14vdmS78Li7w7RudmLU2oe9FUzCUihYLjyiR
	 bUT5LkHzRwRmX4hiqqa497NBRZY7Rd3DUBjoFSTnUtu7DGdBrbXqum3IwgiRuv+QoSWzr
	 BUprH9Bu8SrzAunqM4S4iyUCsiFmoFiwZQT/KxsAXKSA0KmIEhMwHWaHLxr96Es+BFw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=renesas.com;
	spf=pass smtp.mailfrom=renesas.com;
	dkim=pass header.d=renesas.com header.i=@renesas.com header.a=rsa-sha256 header.s=selector1 header.b=DPBuPkBD;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.125.63
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011063.outbound.protection.outlook.com [52.101.125.63])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5076C60A2605;
	Tue, 17 Nov 2026 10:27:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5076C60A2605
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=renesas.com header.i=@renesas.com header.a=rsa-sha256 header.s=selector1 header.b=DPBuPkBD
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vBUJEiXGhnJGY3fSJWW/bTDWi/PiqakBWdAz0bCU2uEMEmvJ206OEJA/bg0F/RJ5oBGCTffJsqiFXVELWszBswyQ7/2kjetBbX1nFOfVuvcObChMCATGmdHfUfeUtesf6soACoL+tAM4BNaQdRVMWr3gSOkd5BE0rNBY6kOMI4TY3hGh0JW4eZfz7SBqpqlt/zRhYLiM6UPMoDMYVmZTxS9a0L2Fl8XwawmJLYd93UxfABh5Z7P0e3Imn9rl30z7ba9CX1m/6hgQgxn4AB4oKCFu+Aur6DSmysTgdf7CcdxBql6n8DrxCE6PR2DgxTzEQSgM4+xt24nAo2L6trSgtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D4FoUVV9xGEXP+7xl2NaMlUA+fSh1Wy/73hRXLkmeV4=;
 b=SjZq3Ix1gKjsEA6ecRgVCxtYdTYzW4FkRjxU0BLswNTcsrkpQgigYHtUl7wqIAGDiifRy5KEvM/od7uxGsfFxkn6rF9Bl2P5VxDiDZ0ruKE5d4C8QVCtxn7xsQ5edQHyq6SsF5sXtgmWGk9cTN/mxMsm67qf6iAhHj9YqbBF3++QmCrBAk+kpRXOtq4P5vWrOHrtU7Ezmkm8WcHRyPtlPKQWqHqqlOIRAwLpkQZc6rrcZyIGRYWus4NmhOlgfNKgRdjCxEReJfCsZIWIkCBoRZxnwnwpbxz8o8w2D6f2NPZqKIsApH/jQ+gG8MeyXeeCJ5klfJa+pbSXqr5HTYVdNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bp.renesas.com smtp.mailfrom=renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D4FoUVV9xGEXP+7xl2NaMlUA+fSh1Wy/73hRXLkmeV4=;
 b=DPBuPkBDYF0lPqhRHc41bB3gDXnPxcWkzst5WgUthhikh2774BUZhWolcFuKgMsq2PJAys00d4iAAeC4OERYTjItT/revCmsoGjaz3tKpCj/42lJ8J+pAHJmgimaR+vrk5IxnRkUIZRNK2vOaopSbbjeHXi3IF42r8X571FuG0Y=
Received: from OS3PR01CA0016.jpnprd01.prod.outlook.com (2603:1096:604:dc::21)
 by TY3PR01MB11987.jpnprd01.prod.outlook.com (2603:1096:400:40b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 10:27:45 +0000
Received: from OS3PEPF0000003B.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:dc:cafe::16) by OS3PR01CA0016.outlook.office365.com
 (2603:1096:604:dc::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.14 via Frontend Transport; Tue,
 17 Nov 2026 10:27:45 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 8.62.32.50) smtp.mailfrom=renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of renesas.com designates
 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay005p.adwin.renesas.com; pr=E
Received: from ejcrelay005p.adwin.renesas.com (8.62.32.50) by
 OS3PEPF0000003B.mail.protection.outlook.com (10.167.240.4) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.5
 via Frontend Transport; Tue, 17 Nov 2026 10:27:45 +0000
Received: from demon-pc.tailc3dc73.ts.net (DEU-5CG5050QD0.adwin.renesas.com [10.226.92.253])
	by ejcrelay005p.adwin.renesas.com (Postfix) with ESMTP id 031AF3000255;
	Tue, 17 Nov 2026 19:27:42 +0900 (JST)
From: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
To: Biju Das <biju.das.jz@bp.renesas.com>,
	William Breathitt Gray <wbg@kernel.org>
Cc: linux-iio@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Subject: [PATCH v3 11/14] counter: rz-mtu3-cnt: cache direction values
Date: Tue, 17 Nov 2026 12:26:04 +0200
Message-ID: <20261117102607.2504551-12-cosmin-gabriel.tanislav.xa@renesas.com>
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
X-MS-TrafficTypeDiagnostic: OS3PEPF0000003B:EE_|TY3PR01MB11987:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 636bccd3-1566-4cd2-d6aa-08df44956b51
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|1800799024|36860700016|82310400026|11063799006|56012099006|261026121527099003|10067099003|261021123027099003|261021121427099003|261102123227099003|261009223027099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	L0WJyBZvP9sU8EFa7Xz+9KsGiYZyZVe0Z6F1pigFgysg18BImj9VW8qgANlHMd4wRiqVe6h+xcyJAYJ7DXA9yDEDMbYSTO4uUu/wp4S8xRqM+Kstoobdh8kNNYYDODjmnfO1026Dq3wgOxuMjfLVM6UzaTJLY0CoKYqS+k+jAiOCg4U/Rmj/pD6ye3mVgJrZVJAYKKgVXp6Q1481+gam3ORaZTwhLp5r46svpgq7zI+cet6YnjDQBpVb3tVVuRWudRN7jMre6sZtwcrhCruO2NagNG4MSLGR05FVaKBfWyuWygGcrAl1rX5OUBUE8i3NCDtsO41bpOY4tuAqVpvbvVKbYvTbo0F+xduvz3duEQxqjvYsW4AcjHBb77ddnicQwKEAh4KR/Mvcy2Kspmdl/A1cij69tfouJF9/irn39uWhnducCPy+rKjQ7r6RTUdsj0NEtsm7SwD968NjYjIGKAdiibKDMhz7e/di9wD2Ni6xoMwESUZv92/tC6SGRpQjEsen5ORO1IwZg0+wS2GS+ofoM1wi4jLgSYjJNgIrVi05IwD4Ub0B3DTCb82ri9JtB2MgdDHWzkmJzC/+6/sVNhvIFAGNkhFTobjBqtRrKGPhzyDkTXMQlDIBys5GooAjBsBSQ1urz4XjpkSJUVWbqhLDwcjziH0gf1LR1TW0ujx3cFWNcpJVz0GrNhZ7bz4qhXERm6uUEqZbBw+658rZag==
X-Forefront-Antispam-Report:
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay005p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(36860700016)(82310400026)(11063799006)(56012099006)(261026121527099003)(10067099003)(261021123027099003)(261021121427099003)(261102123227099003)(261009223027099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	qWTJuZjxF++T1ZJ7lNkFUBMbngFBXXZLaU7VAu4TzU14BAXqOhnFKFQaPIWbV1jnFSjO5rBAQojED2KHkAVzdT/ZB1oKl3sccI5hRA6osh6OW0Oy6VwpSRDQ+pLQp9Od5Z4+UaSLtSyDnMoR15bHHyqCx3HeRd9+rc4FiZgLCIXc50lABid4tPDEVvYhxWifaDc9q0d+Bvt0aWdZHWQjBSF5gQks22jBxKT67sQGWugPhRpmJIXas1ULucGv4ymty0sTp8dqOhTf7SjOlGwDdJneKrIDXK5FhcrJhY0vrzV3bLzPkvBbvBT3SqlhdsAtermBopdQ2Ti6NpppO2gdHaHs6amLj7zrVTmsTBYyT6SylKOuLIQOZWDIcx4MgBJmkKdxqZ1W92OBKcnA2xmrpRjLafislwwzVLAkQ/Jxqr3NtX0z7HBmnMA61cfvppoV
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 10:27:45.0602
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 636bccd3-1566-4cd2-d6aa-08df44956b51
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay005p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: OS3PEPF0000003B.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB11987

Reading registers without the count being enabled is an issue as the
ch->is_busy check inside rz_mtu3_lock_if_count_is_enabled() can race
with PWM operations.

Cache the direction value on every read and on disable, and return the
cached value if the count is disabled.

Since runtime PM is ensured to be resumed if the count is enabled, drop
the pm_runtime_get_sync() and pm_runtime_put() calls.

Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
---

V3:
 * no changes

V2:
 * add struct rz_mtu3_cnt::direction documentation

 drivers/counter/rz-mtu3-cnt.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/counter/rz-mtu3-cnt.c b/drivers/counter/rz-mtu3-cnt.c
index 4b13716d6cb7..e3578850f024 100644
--- a/drivers/counter/rz-mtu3-cnt.c
+++ b/drivers/counter/rz-mtu3-cnt.c
@@ -70,6 +70,7 @@
  * @count: Cache for count values
  * @timer_mode: Cache for timer mode values
  * @mtclkc_mtclkd: Cache for external input phase clock select value
+ * @direction: Cache for direction values
  */
 struct rz_mtu3_cnt {
 	struct mutex lock;
@@ -78,6 +79,7 @@ struct rz_mtu3_cnt {
 	u32 count[RZ_MTU3_MAX_LOGICAL_CNTR_CHANNELS];
 	u8 timer_mode[RZ_MTU3_MAX_LOGICAL_CNTR_CHANNELS];
 	bool count_is_enabled[RZ_MTU3_MAX_LOGICAL_CNTR_CHANNELS];
+	bool direction[RZ_MTU3_MAX_LOGICAL_CNTR_CHANNELS];
 	bool mtclkc_mtclkd;
 };
 
@@ -186,6 +188,13 @@ static void rz_mtu3_set_phcksel(struct rz_mtu3_channel *const ch, bool enable)
 				      enable);
 }
 
+static bool rz_mtu3_get_direction(struct rz_mtu3_channel *const ch)
+{
+	u8 tsr = rz_mtu3_8bit_ch_read(ch, RZ_MTU3_TSR);
+
+	return !!(tsr & RZ_MTU3_TSR_TCFD);
+}
+
 static int rz_mtu3_count_read(struct counter_device *counter,
 			      struct counter_count *count, u64 *val)
 {
@@ -318,18 +327,17 @@ static int rz_mtu3_count_direction_read(struct counter_device *counter,
 	struct rz_mtu3_channel *const ch = rz_mtu3_get_ch(counter, count->id);
 	struct rz_mtu3_cnt *const priv = counter_priv(counter);
 	int ret;
-	u8 tsr;
 
 	ret = rz_mtu3_lock_if_count_is_enabled(ch, priv, count->id);
 	if (ret)
 		return ret;
 
-	pm_runtime_get_sync(counter->parent);
-	tsr = rz_mtu3_8bit_ch_read(ch, RZ_MTU3_TSR);
-	pm_runtime_put(counter->parent);
+	if (priv->count_is_enabled[count->id])
+		priv->direction[count->id] = rz_mtu3_get_direction(ch);
 
-	*direction = (tsr & RZ_MTU3_TSR_TCFD) ?
+	*direction = priv->direction[count->id] ?
 		COUNTER_COUNT_DIRECTION_FORWARD : COUNTER_COUNT_DIRECTION_BACKWARD;
+
 	mutex_unlock(&priv->lock);
 
 	return 0;
@@ -472,6 +480,7 @@ static void rz_mtu3_terminate_counter(struct counter_device *counter, int id)
 	struct rz_mtu3_cnt *const priv = counter_priv(counter);
 
 	priv->count[id] = rz_mtu3_get_count(ch, id);
+	priv->direction[id] = rz_mtu3_get_direction(ch);
 
 	if (id == RZ_MTU3_32_BIT_CH) {
 		rz_mtu3_disable(ch2);
-- 
2.56.0
