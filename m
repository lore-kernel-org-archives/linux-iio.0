Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.125.29
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794911257;
	b=CDLtysi7Xn12YHiDnZZ8Mk63VeSW4GCN+ZlLteXSc2e5n+xUhQRTxRhbC0QNMM6b13RK
	 dD7SJm63Cf0+bl4BKp4RIeuEJbeiPCJ+pjRtkHesF3ZvffwgiOUudRaOvre2+Ewb0e/Q/
	 lfigsZcH+DHXxQSG1f84z70IeRtmrOENidPIaFBhWw3tT01KEwazr1x+PpSmxFcsgI9np
	 /9LJ4tFz6s6UG1pF2vhCIRecdC5MKoYxLunkXRiukt6n7NW2kyeqvAL/KI5Md+99qIN66
	 vka5Krpt+uzTAIzheRY2MqJSC6RpYRtYlalWz63iL0Cd/1Nu09gfaOWVjpPcf7MC0tg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794911257;
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
	bh=Yix0bmyOVQ9bf9Gedh+zqkJfnXGfJgiu7VTpQKumUgI=;
	b=BlYvWSPRiaNMVfjygbSgUMUNhFZuZtBufvUcfTYJkd7q6ryINNMYEpI08/IkAquKm9XA
	 ddzyD40Q6c44zUETCkyQAFPRlpJ4o5B5qRMJPCRe9SOX/ZjDDjVs90iHCzIgUY6X53AMx
	 9XKdes6m0sdGIfX67kLrnWHaK0ztbXo9t7DcA44szJK5K619kplsX1d6EGKm/zpE/nKQc
	 aKGqf5qhMm6NYn+n0k/7aWyBO7zPvaszoAmZkFkDuSy8J4lyKj5UgIh7iBH/Cg9V1X+kW
	 gVoP0z0pod0x4WiDCdtc9nSLRT34D0gqhr88s+z0e4XIgEuB/GwsKN8sx9tH3ZrH3BQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=renesas.com;
	spf=pass smtp.mailfrom=renesas.com;
	dkim=pass header.d=renesas.com header.i=@renesas.com header.a=rsa-sha256 header.s=selector1 header.b=cafgwN0a;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.125.29
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011029.outbound.protection.outlook.com [52.101.125.29])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD5A606A329;
	Tue, 17 Nov 2026 10:27:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2FD5A606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=renesas.com header.i=@renesas.com header.a=rsa-sha256 header.s=selector1 header.b=cafgwN0a
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UCJb1PWhM8MSZLHohUGRjhAE2LFf28KTlXRRsN/8u78qItyqEODgKaUTXoIaVcIVf2+qGiowf+76JIANgsSlDtZbNtcJQo13VO4L4er27SzXF/hMQ2kHGwXE7kTRe5i/K7JcOUYJDlGCUv/EWGE4qEq99e9KMeECa1fV74ColoMMNCFMFLXuVHs+WRJr0CeoO5mhXJHuSigWqpOzC732heNjw1DSU6Htq8UNxwbfl6KGWnP0yVQYTSWeTCIf8lKD/8eu0Ev3xhmnRgfwHCYvvIRfY9im3PN/uG6T8nboKYTINrwg1nxRxETN0BVENtwtvtIJFiUAFosWAPDTV4AIvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yix0bmyOVQ9bf9Gedh+zqkJfnXGfJgiu7VTpQKumUgI=;
 b=P9m8w+iQIYb4GpkEMppX50NWDOstteFCsmMxMo+a/HuuIv/brROk/76sIulQtsrtEKI8NdEIkc3UaLvPuiN/yPLAAUDgnjkmow2TX8sbcZYO6oIuACEAkoAwlYVBWcH7kr7e9S3B/CZWIDaxrHVIa3xGmrUdSpW2suyL2dTmDZunxnjK+Do0+/z7+eJqAaU7XW2hM+QaRwHs0XBsQv9ZYWOjo6dO4rl6YupeIxtZNqDJeO22nKtHMtSERtz1yAlUUU0eoVZ/Z5T3bVN8t1RNtJ3ACUyxNK8GJQtcfExQexJQuxmbyiOimmk58V/hYtY1vkYsy3/Rcdu+zVszB3e6Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bp.renesas.com smtp.mailfrom=renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yix0bmyOVQ9bf9Gedh+zqkJfnXGfJgiu7VTpQKumUgI=;
 b=cafgwN0a6ZRcdgUnoulW6F9gJjI20PSGIS08JGRP2L285tJVJdNZqFs89tSYHFulBnzrHI3I4+g2yPP2eKohzjza41nr/2yCYMQzACrxHurEMllnFq/6NEL9fTuRe66pjHACGS7tqBwn3T1LI5IPBlTLkSZrGFYvcnbSu3yoX7s=
Received: from TY4PR01CA0053.jpnprd01.prod.outlook.com (2603:1096:405:372::6)
 by TY7PR01MB14641.jpnprd01.prod.outlook.com (2603:1096:405:243::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 10:27:33 +0000
Received: from TYO1EPF00005024.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:372:cafe::94) by TY4PR01CA0053.outlook.office365.com
 (2603:1096:405:372::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.14 via Frontend Transport; Tue,
 17 Nov 2026 10:27:33 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 8.62.32.50) smtp.mailfrom=renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of renesas.com designates
 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay005p.adwin.renesas.com; pr=E
Received: from ejcrelay005p.adwin.renesas.com (8.62.32.50) by
 TYO1EPF00005024.mail.protection.outlook.com (10.167.240.21) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.4
 via Frontend Transport; Tue, 17 Nov 2026 10:27:32 +0000
Received: from demon-pc.tailc3dc73.ts.net (DEU-5CG5050QD0.adwin.renesas.com [10.226.92.253])
	by ejcrelay005p.adwin.renesas.com (Postfix) with ESMTP id 003723000255;
	Tue, 17 Nov 2026 19:27:30 +0900 (JST)
From: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
To: Biju Das <biju.das.jz@bp.renesas.com>,
	William Breathitt Gray <wbg@kernel.org>
Cc: linux-iio@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Subject: [PATCH v3 07/14] counter: rz-mtu3-cnt: cache ceiling values
Date: Tue, 17 Nov 2026 12:26:00 +0200
Message-ID: <20261117102607.2504551-8-cosmin-gabriel.tanislav.xa@renesas.com>
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
X-MS-TrafficTypeDiagnostic: TYO1EPF00005024:EE_|TY7PR01MB14641:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 2c5d4c8c-3c86-4246-9d23-08df4495641b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|23010399003|36860700016|261102123227099003|10067099003|11063799006|56012099006|261021123027099003|261021121427099003|261009223027099003|22082099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	wjcHr8awWokS0KlignmIEDsANmI0se+9niwBWufV+7Qc84rhPlgv55ZOzj6c6lD7RaL9ORSxQgdr5imOouy7FSqoMUx1BIiL3dzdlOKTs8ncroc0Jqp6euQYuSGXJNXdTl1MHl363+jXT78RTECdDqXc9dVnn8mqqqXWC1XMa17ZnSV0zGaKauPU69u3699UCfrqrX53XKA18jptFB6Dw2GFXozBPiG9pXdj6whgFH9az9y8uD7iidTM8LoVUexOvh6mIlYg/EYv7xlSARwkHFJnZw/WTnq2XGZoSNyQlniHRtYfVvnyKlDW9Ivfvrqgd9wCfvENuK2HGFAN6H3jLBURw7/8dJP2P+v4YbI2dsIoxuX5V6ymc52qJlX8s99x39Q/L42qdbVGvgDx1B55xIpXWEX9dL/3nMcZ1QwDNg3r9FXF6sExp3sB/MkBT1B4tROhPt1nh4dID1UXTQixj86QM1XjqAAkrcfa9SDPiGt2LNGlOr6xUvyJWoGCSzYa8Wjh5ZNW2NIpnngXFEe/bVQY1guThwXzxPU+EDGWj0kAZixz3DfHyqwXZ/sJrl1BzoJQL5WkeVRLY6RV4FiQMMdtVeZ4DPQraJcbzns9NSBSd+CmJLLu1pKI9Jedag2rZShjb8ibREXyzdmxJxEGmg7RhkdQtTqQwM/HozaGgv4V6enY5QPbtZ0QPVWZIlxEkTGgNHCSdjwuhj8nh2NHJA==
X-Forefront-Antispam-Report:
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay005p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(23010399003)(36860700016)(261102123227099003)(10067099003)(11063799006)(56012099006)(261021123027099003)(261021121427099003)(261009223027099003)(22082099003)(18002099003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	AiF9Y5Udk5gyEi98PIYukgBp4ANPdQiSoN4xOVDTAJjrHsykyCyN2bDxIfIbw14e4rJv+5HRJZy6j4mPqF9rr89SHGfhLN/HbtIOYZjCk8NKYSDiLk4fpkikxR46A9ZuEDkSoqfwZ979t5fkkcLcIdoowAeDpS85NVgYTNiZiSaBQ87Tro9E4yUnf9jgeAlfAjLwq3XBafgUQZD7yj5835lGs9HZy/D6rqa2mXO5T6lH5ICmCqOR3di9Kg5arB9g+EJd5Q1qu/AsrLwHKur1bG0VMU7/Ma2mvqjozzeHzmEqGFUqbMhEyTEquH6Eh14m3uh5AcqqmpV0SpfgZKPyYF+O1P4Els3aWkUIzTXpbe/8memUvwrF6R9u+WPh4M4jv2rumcr2X7VasPkxRQRJTauw1E65Q6YLQigzhYpyMj2aa2Zw6W/Nc3WSDzj4PHt7
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 10:27:32.9732
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c5d4c8c-3c86-4246-9d23-08df4495641b
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay005p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: TYO1EPF00005024.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7PR01MB14641

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

V3:
 * no changes

V2:
 * no changes

 drivers/counter/rz-mtu3-cnt.c | 30 ++++++++++++++++++++----------
 1 file changed, 20 insertions(+), 10 deletions(-)

diff --git a/drivers/counter/rz-mtu3-cnt.c b/drivers/counter/rz-mtu3-cnt.c
index 97bdf2d3d760..ff89ad409270 100644
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
2.56.0
