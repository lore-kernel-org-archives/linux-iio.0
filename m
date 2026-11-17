Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.229.66
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794911256;
	b=TQPBTXgSfD4MGK9NM1z8bticyNP3xYJiSG4/mtdoYZtNgEiFnZ5Z+IS4h8kGMxWBbdbq
	 mmKOqh1gmLWyUUmQipeJkXGcGqxpwWzij/c5ju20Q2dAM+18epEhq5QAKUf1M4i8NRJ55
	 RdbNJfjb0fdLCRq+AbrCxbIYBxhDFSsVRjAz7Vv59xIvOGIK8Sbn91cDucwAM6ANTC+z3
	 qoHYotQvmo0iSlcXwiLuGwg7+sO8INCusaFc/LNIwPPEKSU44dX7udcU+H9fr0oqHGmXQ
	 4P2C5iJV+dvJWEGQwvorQm03jE/ztHdFeVjSy2nTW49w4oLfFpirlSHIT72TFLRi8RA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794911256;
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
	bh=pgFYn1BKg/2m2vfF3ZB2s4SvyP7IrnlkaMRqqEzZGtA=;
	b=LQy9hWueQpDT/jBTylJZ4H0FQuxj7oY829oAcQJi9XRBozXldIXZSe4lalLA4nval/lD
	 gJIb6ickn4dJoehvddAic/GgMdTmBajjeVZcss18JC5rl64jscHhvOZ1TE6lM6eE6Yv0g
	 Cj6B4W/y/2IUM1s2AIfSjxPFSoOSJK1Dwp0Zo643IJxQiuyLpXFgTQxQVWnxIWfxcX6gj
	 6jjfEtm4kYmADUFJ6gHx+w2YDIJUk2Nj72SDAD1nUsqGVgYLTi8gM95JLyZXQxwiRNG/a
	 s9XzaCAT1bOWxpYz7weyhOwIfdwhgaHsiwmkfy0OYiq1+RTLXZnefhV5Pk4NlvXSIKQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=renesas.com;
	spf=pass smtp.mailfrom=renesas.com;
	dkim=pass header.d=renesas.com header.i=@renesas.com header.a=rsa-sha256 header.s=selector1 header.b=L01dRkbS;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.229.66
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010066.outbound.protection.outlook.com [52.101.229.66])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8305606A31C;
	Tue, 17 Nov 2026 10:27:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B8305606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=renesas.com header.i=@renesas.com header.a=rsa-sha256 header.s=selector1 header.b=L01dRkbS
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fO61nVsVTOmdzNusfPILi6nOtr6/oxT2fHTgNykbFoAE5Vp9zycP6ZNVcFQo2ClwJIfE6YCxznzxDga7ztoMXmVzIsuYXYoaOLdnpOuIC3tUknNn8MutSHpCsUdDnXgseJ+owVhUu/HbI/Bs4lxV4A+Leu8w8dV2mAIj1pf3oyo7EMWZqXgdl4MhVUrAzE2mLqDWqibfSH4rzUU+1McKMhYorak/E6DxWifCtJV7gdAY0PXpf2Y3+FDsS8Xs8beqPUiJsIKR4jGK7e/TePx9vLT06fImmIP8dB0e2vsLJBBr6Mys0k6MfPf7v7qmomll8Lb9Mqp41YXbZ/a3lgLfQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pgFYn1BKg/2m2vfF3ZB2s4SvyP7IrnlkaMRqqEzZGtA=;
 b=YOXeKXh2sYZuRp3E5ot/MvR+rIym6kiEbkvPdIM+FYsowV4yO7cE6Zja+QanRvsTccoJfVu6p9fCmSpf442EzCG34m0j+/nfRu/jtkvbMzPPklFPc48+VXNMAXf/OS16jY1gUUS02ykVwaBBlIoRHNJ+f+mJhgIH++uAlckFByYSGCzuzzHg2lKtq2UCbiVrWf2i22fnujl/23T8ClZfchQsZnm9lTjZ6W1k09+vNZeWhiwja/u04lo4vwRWCWXWExaSDfE2mTLvhmjLfE4oNZyJDrNs2/FNooRPPnRn3fJ2nVnL4Skoq/XXXyY/rYZ1jiYZOc2nXPY3K+gQ4ILoJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bp.renesas.com smtp.mailfrom=renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pgFYn1BKg/2m2vfF3ZB2s4SvyP7IrnlkaMRqqEzZGtA=;
 b=L01dRkbSUDJyLts0O22hWNr/KTTjcoWMnlajUy5l93AXsFTZyo24CHPSbfH6WjPK0VGfNvpWotDIt2pJUBmfG75nXB0DRgA7Gj6G7J2DoICXxN7PXSFENV1hVwfPrUoXnQQXUDG9b0PPa7g2ajNGgPDlK+lGN8OX8mXvfFK1oUA=
Received: from OS0P286CA0120.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:169::14)
 by OS3PR01MB9300.jpnprd01.prod.outlook.com (2603:1096:604:1cd::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 10:27:30 +0000
Received: from OS1PEPF0000D215.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:169:cafe::53) by OS0P286CA0120.outlook.office365.com
 (2603:1096:604:169::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.14 via Frontend Transport; Tue,
 17 Nov 2026 10:27:30 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 8.62.32.50) smtp.mailfrom=renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of renesas.com designates
 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay005p.adwin.renesas.com; pr=E
Received: from ejcrelay005p.adwin.renesas.com (8.62.32.50) by
 OS1PEPF0000D215.mail.protection.outlook.com (10.167.240.22) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.4
 via Frontend Transport; Tue, 17 Nov 2026 10:27:30 +0000
Received: from demon-pc.tailc3dc73.ts.net (DEU-5CG5050QD0.adwin.renesas.com [10.226.92.253])
	by ejcrelay005p.adwin.renesas.com (Postfix) with ESMTP id 24DE93000255;
	Tue, 17 Nov 2026 19:27:27 +0900 (JST)
From: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
To: Biju Das <biju.das.jz@bp.renesas.com>,
	William Breathitt Gray <wbg@kernel.org>
Cc: linux-iio@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Subject: [PATCH v3 06/14] counter: rz-mtu3-cnt: unify ceiling values
Date: Tue, 17 Nov 2026 12:25:59 +0200
Message-ID: <20261117102607.2504551-7-cosmin-gabriel.tanislav.xa@renesas.com>
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
X-MS-TrafficTypeDiagnostic: OS1PEPF0000D215:EE_|OS3PR01MB9300:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: af702dc2-e0d5-446b-6053-08df44956270
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|23010399003|36860700016|261102123227099003|10067099003|11063799006|56012099006|261026121527099003|261021123027099003|261021121427099003|261009223027099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	cTIGQNlwyvma+48TW+YknHfdtEcSCh2kL/wVGiIVRwZ+WFD4LASdzjxJXxrezxIXsOHEkDV4Vs9SY6DKZ8GS61t74BYwTYEKu20OpxHsHfrAgNDVVGUmqv3pJ+8SphXcRZUHSvsVN+kn0RDUfi1llygW8V+SC/nffUkI+7lVLnKBqyuKOEuwcr7a9jtnm1DLL82DJznQ1E4lAZN/AcQ0kUdkTPVL/+F68fz9eI40gHSY/OC/yqwLnAZquOIq+Mai9AWz39C3unY11EleBGBwgOdgY23N7q23U/bXGku1XkVAx1xGA4geRzAuGHQ3gjtanLJFCQAlyHxvTJfaaY+/v1O/S4rGnA9HgofdogEsEBO3n8flbT77DjFv9gHrfPsd0qIJBElhDqsHfuZNjOosAuTXOtU3lPTCKDwVKXNiWEW9kNLBuOtDUTZ7/ePydCUPWB6XXiZ/3gV8RmPYO3X1O3NcYA7DGBNTaIf3Od35LAPAIUtCiiU6hHildhBfG7y9DlHgjmusMR/xQWaEyw1by8qU+aok88i/2RX6hqUoM1+kCBXAg+552CqSj7aXSknZix8N+XrGIgfH+hpvImaGZuH+cK+PP2CWMwqAWi29ggoh92+nXG2HhZ64d3q8Spn4ckNDXyS1KYWu0ohooNE5wtLoh21xYYbqUHO5DerAVVLqnb504KGnF9TH/WvoGDbw2m/G2eRoGkdJfr55N8C9hg==
X-Forefront-Antispam-Report:
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay005p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(23010399003)(36860700016)(261102123227099003)(10067099003)(11063799006)(56012099006)(261026121527099003)(261021123027099003)(261021121427099003)(261009223027099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	pUfp5VjxhNoncjY1qVAe7fMd8ijxjwG1WkvlE3jFdEhjDJRJdegs3fOX97CUdND1Td5sAddb0SG8fr1lwk4L4d81iw8eklm4f5OeoXR9W93lw02mYyzHjTczraRfIHVDCzmPORftw24RFn34KYa4W/wTAeYLnhSWGoSZ52wTwO7K6HzRcx1ixjEtR63UwqZePFTOF3CKSy2s4QGfPbr+xeT7iUMsu/JMpx0KQl1kIuj3wPE3JHPp0Ait0GTFc9JzWP4y9IYlfNbAqFe9J/6ZInFdEPv4Txix//zPEoO4HmYW7mu5s7/PHsu0uvk+sAi273qu3vZY71MNLD6QCfAIrPa2luoYQm+jwABgXgAVcAiK3ofeR+fDN5Bc/bd0oREI25jaOrqOQSzJ14A414l5Rljvng9tIJhCAUNXbVS9PN8ArJ6Les7TUqFoDeHuGPHy
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 10:27:30.1589
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: af702dc2-e0d5-446b-6053-08df44956270
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay005p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: OS1PEPF0000D215.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB9300

Writing to the 32-bit ceiling value clobbers the 16-bit ceiling values
as both are stored in a union. This was probably done to save a few
bytes of memory, but that memory is then wasted on code to handle the
two separate variables.

Move them out of the union and use a single u32 array to hold ceiling
values for all channels to simplify the code.

Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
---

V3:
 * no changes

V2:
 * fix struct rz_mtu3_cnt::ceiling documentation
 * remove now-unused RZ_MTU3_MAX_HW_CNTR_CHANNELS macro

 drivers/counter/rz-mtu3-cnt.c | 36 +++++++----------------------------
 1 file changed, 7 insertions(+), 29 deletions(-)

diff --git a/drivers/counter/rz-mtu3-cnt.c b/drivers/counter/rz-mtu3-cnt.c
index 23dbca3b5cfb..97bdf2d3d760 100644
--- a/drivers/counter/rz-mtu3-cnt.c
+++ b/drivers/counter/rz-mtu3-cnt.c
@@ -58,7 +58,6 @@
 #define SIGNAL_C_ID	(2)
 #define SIGNAL_D_ID	(3)
 
-#define RZ_MTU3_MAX_HW_CNTR_CHANNELS	(2)
 #define RZ_MTU3_MAX_LOGICAL_CNTR_CHANNELS	(3)
 
 /**
@@ -67,17 +66,13 @@
  * @lock: Lock to prevent concurrent access for ceiling and count
  * @ch: HW channels for the counters
  * @count_is_enabled: Enabled state of Counter value channel
- * @mtu_16bit_max: Cache for 16-bit counters
- * @mtu_32bit_max: Cache for 32-bit counters
+ * @ceiling: Cache for ceiling values
  */
 struct rz_mtu3_cnt {
 	struct mutex lock;
 	struct rz_mtu3_channel *ch;
+	u32 ceiling[RZ_MTU3_MAX_LOGICAL_CNTR_CHANNELS];
 	bool count_is_enabled[RZ_MTU3_MAX_LOGICAL_CNTR_CHANNELS];
-	union {
-		u16 mtu_16bit_max[RZ_MTU3_MAX_HW_CNTR_CHANNELS];
-		u32 mtu_32bit_max;
-	};
 };
 
 static const enum counter_function rz_mtu3_count_functions[] = {
@@ -314,27 +309,13 @@ static int rz_mtu3_count_ceiling_read(struct counter_device *counter,
 {
 	struct rz_mtu3_channel *const ch = rz_mtu3_get_ch(counter, count->id);
 	struct rz_mtu3_cnt *const priv = counter_priv(counter);
-	const size_t ch_id = rz_mtu3_get_hw_ch(count->id);
 	int ret;
 
 	ret = rz_mtu3_lock_if_counter_is_valid(counter, ch, priv, count->id);
 	if (ret)
 		return ret;
 
-	switch (count->id) {
-	case RZ_MTU3_16_BIT_MTU1_CH:
-	case RZ_MTU3_16_BIT_MTU2_CH:
-		*ceiling = priv->mtu_16bit_max[ch_id];
-		break;
-	case RZ_MTU3_32_BIT_CH:
-		*ceiling = priv->mtu_32bit_max;
-		break;
-	default:
-		/* should never reach this path */
-		mutex_unlock(&priv->lock);
-		return -EINVAL;
-	}
-
+	*ceiling = priv->ceiling[count->id];
 	mutex_unlock(&priv->lock);
 	return 0;
 }
@@ -345,7 +326,6 @@ static int rz_mtu3_count_ceiling_write(struct counter_device *counter,
 {
 	struct rz_mtu3_channel *const ch = rz_mtu3_get_ch(counter, count->id);
 	struct rz_mtu3_cnt *const priv = counter_priv(counter);
-	const size_t ch_id = rz_mtu3_get_hw_ch(count->id);
 	int ret;
 
 	ret = rz_mtu3_lock_if_counter_is_valid(counter, ch, priv, count->id);
@@ -359,14 +339,12 @@ static int rz_mtu3_count_ceiling_write(struct counter_device *counter,
 			mutex_unlock(&priv->lock);
 			return -ERANGE;
 		}
-		priv->mtu_16bit_max[ch_id] = ceiling;
 		break;
 	case RZ_MTU3_32_BIT_CH:
 		if (ceiling > U32_MAX) {
 			mutex_unlock(&priv->lock);
 			return -ERANGE;
 		}
-		priv->mtu_32bit_max = ceiling;
 		break;
 	default:
 		/* should never reach this path */
@@ -381,6 +359,7 @@ static int rz_mtu3_count_ceiling_write(struct counter_device *counter,
 		rz_mtu3_16bit_ch_write(ch, RZ_MTU3_TGRA, ceiling);
 
 	rz_mtu3_8bit_ch_write(ch, RZ_MTU3_TCR, RZ_MTU3_TCR_CCLR_TGRA);
+	priv->ceiling[count->id] = ceiling;
 	pm_runtime_put(counter->parent);
 	mutex_unlock(&priv->lock);
 
@@ -799,7 +778,6 @@ static int rz_mtu3_cnt_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct counter_device *counter;
 	struct rz_mtu3_cnt *priv;
-	unsigned int i;
 	int ret;
 
 	counter = devm_counter_alloc(dev, sizeof(*priv));
@@ -807,10 +785,10 @@ static int rz_mtu3_cnt_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	priv = counter_priv(counter);
-	priv->mtu_32bit_max = U32_MAX;
+	priv->ceiling[RZ_MTU3_16_BIT_MTU1_CH] = U16_MAX;
+	priv->ceiling[RZ_MTU3_16_BIT_MTU2_CH] = U16_MAX;
+	priv->ceiling[RZ_MTU3_32_BIT_CH] = U32_MAX;
 	priv->ch = &ddata->channels[RZ_MTU3_CHAN_1];
-	for (i = 0; i < RZ_MTU3_MAX_HW_CNTR_CHANNELS; i++)
-		priv->mtu_16bit_max[i] = U16_MAX;
 
 	mutex_init(&priv->lock);
 
-- 
2.56.0
