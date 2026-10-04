Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011022.outbound.protection.outlook.com [52.101.125.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 579C34746AD;
	Sun,  4 Oct 2026 17:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791136175; cv=fail; b=ifDWstyfN+NIAuoLFuRwSfW5okWlgsFQwCkpJU2UCSpmKjVW83RqBTWXgYT9oIB594dDUF5QlMICKAlmJz7ZWwKKGOvAEh5eGLRTMPeI2fgvLOyXqac6hlPlmVBNlUcumkM3KGr7LjfliYGc27tU+8w9qy5QAvLVad/u7DN/dwc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791136175; c=relaxed/simple;
	bh=7UpPruxgOdRK0yLWU6r6lRzkjzVTadRmJkqe4gtwfyA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AoYivbug4xNXpa9FsN97K6ySoDQbKt85rDXWqDx6wJThSkjWfxOCh6HmyaVG5vlZBON6VCafSxArWId5Q5WJJoF3Q3tdnnZrG0g3GZ01/KoqF3q1vnOggkmvIusPQVB5v/OFCPKBsTUXmH4ZJcf7x/n3w/vw1OzYktxsprmeeUA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=Lb6odGZY; arc=fail smtp.client-ip=52.101.125.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="Lb6odGZY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j4042FaHEjYbWL956Z3IyDZjsD3iPpcDPjbHCTPETDgicr7gSc2hYAMvKVStsS4CnT+QA3yYhDn7ZdGpC61Gi3N2iw0YwgWbLJi/QgMST/W11IYyJgkakv8fH5hdrO47RtniY7h3oHCcBREuJxJjo0sTTdkNv0KoUz0j2VsUkCnWc8znxzb34/D2QcJLqH63Z8feYehbghD/OjUeZbyN84kOSKUpY/7NOtVv6Qu98n9p61q9THMG6Ar/6+7wuCxUh8FprVcf8vcuiC3ZWojzrltJQi5CExdJb1bK2lqvdnu2LzIBr/6tJ97yiRMaNxK8ZyP9vUjlcXgWvFAtgE+RDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EfE4bf0i2F3bvfzCzNQvpnQxGS2RYCkpXoQz/Uck8Fc=;
 b=iyKRhy+nl9HCTo2I5l29q5E7U+cp0FtHuEM/rxoA0j90JevZaG/z9J62R+3wjcyxcQBGN88WYDCIRmFLE4YpStxsIqEAmlcvanFQyb1G2R3RVxycCXfH5tmGZ5V46xYDPV/egV5/cpO5q0DBAp+Nl642E9sjMf6OVBo21BtB+vcNe6Hy5g66sWOZFMYQqLLsZwgGef8/8a66EqCZ4LNGCzeVvypXgeYImnQYAgkGOUQ2E49xVaJkSs8nqdgccxOVo2E9JMDg9ieuE+zmQ6iU5T9/h6QI4Z6mDByw0/0Ic7aHQTv8jqZl9S6+2HyqyHogiB+oYwVLPobKCWQjhuTbVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bp.renesas.com smtp.mailfrom=renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EfE4bf0i2F3bvfzCzNQvpnQxGS2RYCkpXoQz/Uck8Fc=;
 b=Lb6odGZYpi6A2iVNKN2QjyNbeA+kmHLSDQRreVD3iuHSJG4ghvD9LhReNmn4u9qhCMSV+SMQonLqnm9JaSKWrVjMwbBs3XwQwFDQAxTKgXofQc5PNihTSzYSNE475BNA/CwPCglCXkhokU8yr7ykiBX8ozuk9ITiX5j3Eg6josE=
Received: from OS7PR01CA0075.jpnprd01.prod.outlook.com (2603:1096:604:253::7)
 by TYCPR01MB8373.jpnprd01.prod.outlook.com (2603:1096:400:15f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Sun, 4 Oct
 2026 17:49:22 +0000
Received: from OS1PEPF0000D216.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:253:cafe::24) by OS7PR01CA0075.outlook.office365.com
 (2603:1096:604:253::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Sun, 4
 Oct 2026 17:49:22 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 8.62.32.50) smtp.mailfrom=renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of renesas.com designates
 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 OS1PEPF0000D216.mail.protection.outlook.com (10.167.240.23) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.14
 via Frontend Transport; Sun, 4 Oct 2026 17:49:22 +0000
Received: from demon-pc (unknown [10.226.92.36])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id 20F9A3000246;
	Mon,  5 Oct 2026 02:49:19 +0900 (JST)
From: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
To: Biju Das <biju.das.jz@bp.renesas.com>,
	William Breathitt Gray <wbg@kernel.org>
Cc: linux-iio@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Subject: [PATCH v2 08/15] counter: rz-mtu3-cnt: cache ceiling values
Date: Sun,  4 Oct 2026 20:47:45 +0300
Message-ID: <20261004174752.507499-9-cosmin-gabriel.tanislav.xa@renesas.com>
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
X-MS-TrafficTypeDiagnostic: OS1PEPF0000D216:EE_|TYCPR01MB8373:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 183d0789-485c-4659-bf83-08df223fd2b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|23010399003|376014|1800799024|36860700016|6133799003|22082099003|18002099003|10067099003|3023799007|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	Ro9QL9dNmNkGTXEFtR9wZMyZQ8qRuXw9r3yFvOjhKP9AxC9eJqRjm2tqdOnugAJExl5PNyVQqLQ3i3b7SaPxJVEuYTL+xi50Ua3tN3myN1HmShyrWBI+Wnjrq8T+0kbuY9c1OfiIXaCJG2jNHplL9wdB6c/VWDrnUNJJWjcvJEdJlMlfUeZO8U7FzIb3HY9E2gSg3YOdcfwMZFChDPUJDtYpXxo/3dAmvLaR0OxcYaBGQokiZnJVy3diQD8KSrLxbjsZPzpI5LKOl7nDMEH0LcO+U5MI+jT2QjQ28b0Pcd+YkNsYobcRaAXMVgqsA4IgIUdiCSuxGrQQVtqMNo4jpRaIWckrE2bg5IXSclwJS2JK9+AobNvGYEx9AM1Hv2mhOGID1kdwHZaUDHRf7ApJxIMhZ8ikomSbCKjmtl9wZeCb6rzBDmbvTLZXisj4iOA7pDYTCf5O5HB5O+IM64GN5a8Z0gJbNHx7uSf0gSRHmZjb5Yd1N0Lmje4N9M1x36TPzXZ7wOIegr+HVKt3ATAj78Alv+kfgJb3fDWinfMNbl9OvBVeCH1LbBpT3TLx3NwerL+93VdygVryHA04IcwDwRwQvTw9aXHYVLguy+X3XIsuEpRyKMDdr0O66ep1ZAs/9ka1H+9lK1rahfW2Bofgi6wcXTaS8BRAYhdzpkJB9+G5qleBAHvvU/gisofjYSlLXIrVt0A4nzUUbLIiTJmosA==
X-Forefront-Antispam-Report:
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(23010399003)(376014)(1800799024)(36860700016)(6133799003)(22082099003)(18002099003)(10067099003)(3023799007)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	o5Fxjfw8W3J4ZYRn8R2QKrb4gwweaCghk5hRMec7RaNVOfDBNCTS13Jk1MvJWNf9rJnJby+976BRsS8+F1CPUaIUQ46K+mufIeOKiGKi5o8VgQOmDAx3opkwWisM1Aq5PViL7mnEreb4bsmfl9RTkSN62uS2sDObgUnOu1voj5wl5WbvSp5YbKu3iT2WvNlVdFLgFEToixrguwE5Vh53e4SOUBqwb3J/P+yA9CAGCEp0u7VOfnK0GmU0Yn5VwzknX9KXj6m8YhfcADGIcgX+mvfR3IdiQbhp8RHdmbJ1E79nntMU92gvws7LD8BUKn2uZGnvrvuSPEnY0DfvHTyRaZsm+1HTRWMIIR8r2WMBZIqyM5cJIBGY+OLL2lyFNZDu4yWZu0R4zAEthJcd8n2cPO6MIQiAU2rSMazNJBhBS6u47kjgnZzbm97UsZ4c8Efm
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2026 17:49:22.2495
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 183d0789-485c-4659-bf83-08df223fd2b2
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: OS1PEPF0000D216.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB8373

If an MTU3 channel is used in phase counting mode, and then in PWM mode,
when returning to counting mode the ceiling value is lost because PWM
mode clobbers the TGRA registers used to store the ceiling values.

Restore the ceiling value in the count initialization functions for both
16-bit and 32-bit channels.

To avoid writing the ceiling register when the count is disabled, and to
prepare for the removal of the rz_mtu3_lock_if_counter_is_valid()
function which is susceptible to TOCTOU races because of the ch->is_busy
check, only write ceiling if the count is enabled.

Since runtime PM is ensured to be resumed if the count is enabled, drop
the pm_runtime_get_sync() and pm_runtime_put() when writing the ceiling.

Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
---

V2:
 * no changes

 drivers/counter/rz-mtu3-cnt.c | 30 ++++++++++++++++++++----------
 1 file changed, 20 insertions(+), 10 deletions(-)

diff --git a/drivers/counter/rz-mtu3-cnt.c b/drivers/counter/rz-mtu3-cnt.c
index dcc16f23f94e..485fde79a76a 100644
--- a/drivers/counter/rz-mtu3-cnt.c
+++ b/drivers/counter/rz-mtu3-cnt.c
@@ -146,6 +146,17 @@ static int rz_mtu3_lock_if_count_is_enabled(struct rz_mtu3_channel *const ch,
 	return 0;
 }
 
+static void rz_mtu3_set_ceiling(struct rz_mtu3_channel *const ch, int id,
+				u64 ceiling)
+{
+	if (id == RZ_MTU3_32_BIT_CH)
+		rz_mtu3_32bit_ch_write(ch, RZ_MTU3_TGRALW, ceiling);
+	else
+		rz_mtu3_16bit_ch_write(ch, RZ_MTU3_TGRA, ceiling);
+
+	rz_mtu3_8bit_ch_write(ch, RZ_MTU3_TCR, RZ_MTU3_TCR_CCLR_TGRA);
+}
+
 static int rz_mtu3_count_read(struct counter_device *counter,
 			      struct counter_count *count, u64 *val)
 {
@@ -352,15 +363,9 @@ static int rz_mtu3_count_ceiling_write(struct counter_device *counter,
 		return -EINVAL;
 	}
 
-	pm_runtime_get_sync(counter->parent);
-	if (count->id == RZ_MTU3_32_BIT_CH)
-		rz_mtu3_32bit_ch_write(ch, RZ_MTU3_TGRALW, ceiling);
-	else
-		rz_mtu3_16bit_ch_write(ch, RZ_MTU3_TGRA, ceiling);
-
-	rz_mtu3_8bit_ch_write(ch, RZ_MTU3_TCR, RZ_MTU3_TCR_CCLR_TGRA);
+	if (priv->count_is_enabled[count->id])
+		rz_mtu3_set_ceiling(ch, count->id, ceiling);
 	priv->ceiling[count->id] = ceiling;
-	pm_runtime_put(counter->parent);
 	mutex_unlock(&priv->lock);
 
 	return 0;
@@ -370,11 +375,14 @@ static void rz_mtu3_32bit_cnt_setting(struct counter_device *counter)
 {
 	struct rz_mtu3_channel *const ch1 = rz_mtu3_get_ch(counter, 0);
 	struct rz_mtu3_channel *const ch2 = rz_mtu3_get_ch(counter, 1);
+	struct rz_mtu3_cnt *const priv = counter_priv(counter);
 
 	/* Phase counting mode 1 is used as default in initialization. */
 	rz_mtu3_8bit_ch_write(ch1, RZ_MTU3_TMDR1, RZ_MTU3_TMDR1_PH_CNT_MODE_1);
 
-	rz_mtu3_8bit_ch_write(ch1, RZ_MTU3_TCR, RZ_MTU3_TCR_CCLR_TGRA);
+	rz_mtu3_set_ceiling(ch1, RZ_MTU3_32_BIT_CH,
+			    priv->ceiling[RZ_MTU3_32_BIT_CH]);
+
 	rz_mtu3_8bit_ch_write(ch1, RZ_MTU3_TIOR, RZ_MTU3_TIOR_IC_BOTH);
 
 	rz_mtu3_enable(ch1);
@@ -384,11 +392,13 @@ static void rz_mtu3_32bit_cnt_setting(struct counter_device *counter)
 static void rz_mtu3_16bit_cnt_setting(struct counter_device *counter, int id)
 {
 	struct rz_mtu3_channel *const ch = rz_mtu3_get_ch(counter, id);
+	struct rz_mtu3_cnt *const priv = counter_priv(counter);
 
 	/* Phase counting mode 1 is used as default in initialization. */
 	rz_mtu3_8bit_ch_write(ch, RZ_MTU3_TMDR1, RZ_MTU3_TMDR1_PH_CNT_MODE_1);
 
-	rz_mtu3_8bit_ch_write(ch, RZ_MTU3_TCR, RZ_MTU3_TCR_CCLR_TGRA);
+	rz_mtu3_set_ceiling(ch, id, priv->ceiling[id]);
+
 	rz_mtu3_8bit_ch_write(ch, RZ_MTU3_TIOR, RZ_MTU3_TIOR_NO_OUTPUT);
 	rz_mtu3_enable(ch);
 }
-- 
2.55.0
