Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010054.outbound.protection.outlook.com [52.101.228.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DD164A0138;
	Mon, 14 Sep 2026 20:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789418281; cv=fail; b=sHzYnn9b+G+sVoir/1gyAWuXeA3D6A7tD4IiFEWe8ZGAQKE0yllgnpN52c/4HfmBlpQknlz2CLGHvyGv5ez/6B8BQSffP5umzZaAPmKwONcdROX3DBINAcV/IKppaT/vQZnYVUyuG/xbVgvVOJTGnCEgm7kPTafMU7p5veoZNSU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789418281; c=relaxed/simple;
	bh=5hi8CkfOJr/VGqk7a0Ynj+lqJH5d5+j3Do+JwYXpmSU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QzctZpBDM+NC0g+zlFM1d8cZjrmDa1xqcJPPUeVN1NbDSaWR0Tqe/QLlHZO7RthnaZin0cRpWpnDOnIMQjeDOQdeWsgsq0cUKTUjHQsi5649TsQMBidzNCHrboxN9FpftEibdAxakkq6cmDIl+9elrUNjtRgxbBmZsFKF9DpRmw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=jCxft2oL; arc=fail smtp.client-ip=52.101.228.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="jCxft2oL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fXFwlANCAr3Pw4DLVQQNIcIWkc9pQLLDSIpiej0vrdPFBQUf/+amQmeGUwcA96cTKs9g6wFM8+MkKUKaWK2wJ4NP+XEM5TsJuDHH/NppK28ehZr2JGRdCSXZT3k7D++79n7pIQPa8j7ISzFMnGtZAA/ViiIVckIiwLFE0eVDC7YG5q6VrWSD9YCMG0YN2Fq0P0npRgy/HHrrbMWwuINSme619vrcsvgDz65nJ5PCfhpu9+dVYuzXxuFm8nndq9Ui0qrNRg2oTU9sod93E4FWFann+XklQOYFVygCRlkGwJg0/CLh723PHtrnx1p6FOQrMylOmEIHD4RxFykAzD/jPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XoUOCwiJcToWV6RKqAwDia+2vrctF/v+XnHK0UXLf0U=;
 b=s3tcSdXapUXJfx6K/2kCiMc2B6wU+GkGyq1C5vgBaH6A5uLOZWFWOfTHMu8pAH7h8YQV/9BOeqAm1IRNM6Rk7sX2pqT1YO4U2a7HlOlyeGvRFLOGDw8q6YEoDvw3ECgweeFRvYVyrMKkVtYpX60rcdIXYnjCaC5mwS5WvMhOzACejX9O4xR8i8YFotKGqDG1f7zfhLrVbomYKsIxTp0SynoWufMNBCtdCpOr0RDTZoVgJFateWbf1p81mv07n8LQd/da/Zpq3Vss6yKEntrvVmh3iYW4yy4PJJLTXDKgqJb644vk2Jq3HlKEN+80roTo72fAURWJ4cOGRg0TLVDrMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bp.renesas.com smtp.mailfrom=renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XoUOCwiJcToWV6RKqAwDia+2vrctF/v+XnHK0UXLf0U=;
 b=jCxft2oLqDo+upNHoS1XtSPxDhdjLjF3P2wcx/iUw46mUAquu6P+W7JEtJTVNF+BnmW8SYOLyKAyewG946EpX8/U1umpkfuXLK0zoS/W2SPg1EmUD5trzsYD5qOXgitg1zw+9h801cjZZEQtYhktDhIhc4zNHwcwIZ5t+sjZxl8=
Received: from OS7PR01CA0289.jpnprd01.prod.outlook.com (2603:1096:604:25a::12)
 by OSZPR01MB8105.jpnprd01.prod.outlook.com (2603:1096:604:1b0::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Mon, 14 Sep
 2026 20:37:48 +0000
Received: from OS1PEPF0000D216.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:25a:cafe::83) by OS7PR01CA0289.outlook.office365.com
 (2603:1096:604:25a::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.12 via Frontend Transport; Mon,
 14 Sep 2026 20:37:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.62.32.50)
 smtp.mailfrom=renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of renesas.com designates
 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 OS1PEPF0000D216.mail.protection.outlook.com (10.167.240.23) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.7
 via Frontend Transport; Mon, 14 Sep 2026 20:37:48 +0000
Received: from demon-pc.localdomain (unknown [10.226.93.156])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id C24673000257;
	Tue, 15 Sep 2026 05:37:45 +0900 (JST)
From: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
To: Biju Das <biju.das.jz@bp.renesas.com>,
	William Breathitt Gray <wbg@kernel.org>,
	Lee Jones <lee@kernel.org>
Cc: linux-iio@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Subject: [PATCH 08/15] counter: rz-mtu3-cnt: cache ceiling values
Date: Mon, 14 Sep 2026 23:36:07 +0300
Message-ID: <20260914203614.2035277-9-cosmin-gabriel.tanislav.xa@renesas.com>
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
X-MS-TrafficTypeDiagnostic: OS1PEPF0000D216:EE_|OSZPR01MB8105:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 63523c45-1b9a-4c15-1d23-08df12a00a39
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|1800799024|82310400026|36860700016|6133799003|18002099003|22082099003|3023799007|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	DdaBqanBV6JW+aUF3k0+/OhcQemY/PyXIasiwdCXTA4dB/BPpdYRTWXlmn/mxm/6MrWSuwYRHQwkLEf0h2/gwblXy6RgyxykboOAsj52bu59cSJTMJNw7b1xVhymjYWEDWsph8xMbhe6U/bqEObbZyJTpwmPj1MXb0sOnqYk0/+KV19/WqjnlXxuigU6Exjdpas3qlOp+GUOEqXVkaWume3Y53kD2a9LnE7AS+bPDCKt6oclY7ULmz20aoBYXW6RO3No4YsDqwv8r/Pup26L7SrXpX18f6QvS7vnXkg2NPI3wgt9BebqDTqChe2m3PjTGkTQw7X6G6Oh0ZnkktPowXK7EzYeeuiYcLB9H4yl9AFE+pAN6wpUtFhZlcDfmzMJm0u7ALQ9mPfHE4s4MBrahcwcX+U695BvXu9eNjz//zaaz7hzXXpOHIjoN69gC4cwa1sVY3cE45O76LYm0QdaovkmFpfWkEw+NjU3/ezyOEuqroXDlOXhp4bIIeSu77uo7r9w8kutvFpj2v2vSTSpQ+ZBJBZWVSu3pJQhdrX2dA3M8bmkK4gWq4Dy8fd+c82peu0CRcN7HG8Ef4IDYlVdIz+KEihs9XHwcY7BJRZSq/x8m1fFQE4BXQA8GnQjFDKdBOzU/3kSATZw0TlrzOE06ZAZ4kNTkcGSZ6PdfDS8ko0QsqCh3DsnkpJ9OOWcaW+SFPRBlWRWnO5rBzznFou10w==
X-Forefront-Antispam-Report:
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(82310400026)(36860700016)(6133799003)(18002099003)(22082099003)(3023799007)(10067099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Ji0NBv2hN/aGcjo7+hDWcmFjovF5N5KnPVXkUUTdSt3RDtlb1O+hIx/QOCkF2CzogBV9ZJhjvio7TqPlrcior2J0jTB5fOHb8crboN8LXjU2niHUg04ufJe4jaGWbOLwm31GMb9csAfsDrAzYjNYReuVg5ujOIbRQL0ao9Sx0CPJwBtlFseqiIOXNAHjbsPJ9RWhaYDja+EawnEPFyWIJyN7CnD0Vo4zUJyS0dyb7Gkqcw9qaRWUXsc9E+YmlDyozP/vDNS3hUDSWTnQMVvpV2dGaPLLriYWbmIno86ywuxuspGvG6T2SpipzJrUwF7jRgvqJeOnnh3OVKvx0p6q4D3BELW322OnSvpQUCmMkd/Vgt0/zjv4mm9NoLut5uaTa+ALLwVnF/JuTKDH+gibGXFiFyVAI9U/cV9NCtpR9GwtUZrAvsNJQV/OMWG/9sP7
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2026 20:37:48.4803
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 63523c45-1b9a-4c15-1d23-08df12a00a39
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: OS1PEPF0000D216.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB8105

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
 drivers/counter/rz-mtu3-cnt.c | 30 ++++++++++++++++++++----------
 1 file changed, 20 insertions(+), 10 deletions(-)

diff --git a/drivers/counter/rz-mtu3-cnt.c b/drivers/counter/rz-mtu3-cnt.c
index f9bdfaf7bd42..b76ad6cb8b6d 100644
--- a/drivers/counter/rz-mtu3-cnt.c
+++ b/drivers/counter/rz-mtu3-cnt.c
@@ -150,6 +150,17 @@ static int rz_mtu3_lock_if_count_is_enabled(struct rz_mtu3_channel *const ch,
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
@@ -356,15 +367,9 @@ static int rz_mtu3_count_ceiling_write(struct counter_device *counter,
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
@@ -374,11 +379,14 @@ static void rz_mtu3_32bit_cnt_setting(struct counter_device *counter)
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
@@ -388,11 +396,13 @@ static void rz_mtu3_32bit_cnt_setting(struct counter_device *counter)
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

