Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.74.49
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794911264;
	b=PAXeoUH3FzQvzo7nct+GM5VX6qSqqRXTRf/iQMQUox9Hw1+iwGunEcDCWWG5LFQCU9MO
	 NPNYFxf1YRQyQTyv4qhOwmw/2SGSlNrGBD5N6/lEahIvKVqdO+672drZIO/T1Ig2U3S7Z
	 IJ1IblJvfXwO3n+3Rgr8lA5Xy4aSdWVR0PmpGJriBYuIRKFHli6GkqiqUWWrfs8hfYokB
	 B2vrrnItx7xHAE9ec2I9eTPa7cZxTzTjHeZWXJYll32wPqfJLPcd8YSY6Xq7xfljONgBS
	 qH9SCEP2S2/E9S0hAcMmETvU6kqAMToa7RrvmiW4i+Cm+b7W78FPIh11eBQHiTWr2hg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794911264;
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
	bh=jyU+a07KUwn4G2Kk70poGGV7AazNhMT1bo9CwkoTMgA=;
	b=YUZBIUUTZyIykfBNiaRTjx195FfwpD9OIg9RRzc5qxA4l3b/Sd8Yt1rzh/XN4MLpVfl9
	 vLxdsBXXTmAslA1E+SdGJRGWo2ZbTayak5FJl9i4QfUaRImBvIjoyfARPhGC4hXc9n3rU
	 c+eG1FPz7jxGiwU2VZd7fNmYaXVwBo3LOlSDVWXbMRc4Lm4ZfqoY/CBuwhpx4sycNACYp
	 ruvG4OuY5ctaypafHDUV1Fxdp00CKD9tMdyTFCVV8M07nuKu41KVlu06pXUkeJw77FmlQ
	 ORw5EYJAo4wYOIG63yVbl8S3gGna/iURq91gzBQmnzr9b1tGaROn7muSwGSi5DTpa1g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=renesas.com;
	spf=pass smtp.mailfrom=renesas.com;
	dkim=pass header.d=renesas.com header.i=@renesas.com header.a=rsa-sha256 header.s=selector1 header.b=leIbD7Hr;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.74.49
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011049.outbound.protection.outlook.com [40.107.74.49])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F170606A880;
	Tue, 17 Nov 2026 10:27:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3F170606A880
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=renesas.com header.i=@renesas.com header.a=rsa-sha256 header.s=selector1 header.b=leIbD7Hr
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zo9ymejN+TsU4f6gMbsSoadgSHk2TrYoO53Or1ISmH4TVYOWC75dj/Vlag5M2/043SoOLB9MKs7vJA8f+68GZXJbV2NacPA4lEP1gkOStOKqWPpO/pQ3w3HeZCFC0Za8DSmxM9zzLEO9L9FObYap9S41NUlK3+4jQj6QnMMdX3NCdgUuFHMQs9BYDFHvbKSscDRNhcisMymhBtMaGhXVVJxGv6Rb912NcxVfTQUv6D2HpqpODsZ4dn/D4ETZLsaBTxQWwR3otK3Seek+iX/E7kp/tlGGgkY+Y+tYlqTHsJ/0dBw2GslSEvjygLHxmG5j7mqtWHz98gpz+L2qfJn18Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jyU+a07KUwn4G2Kk70poGGV7AazNhMT1bo9CwkoTMgA=;
 b=gVAr7ktGRcadVAzTh3BmcXIQbuwvBQXxo0PEfUeAqPvoOvfpxCwxcJ6//TX1W1hDwPbfLtO5yI31pqumm9PGk6Q5KWCcIgxtNl9DPbpPJPQ0YtSBj9fWZdVu+/J7eQpsqL2rGRkik0sYGbQWUounW3ngsC0jDDQBSza72uTwdlSgjpXEyZfGTVsd+OjbTttSaz2rC6FDT1WsrBDDoIo648UnBpRg7IEUHob6sKypLJSh5q/G4SYNPUGUOH1iCuME/YWSFOjsW90FqRs7iBu9dWylH1OVsQ0rmoA8jCQA2ndBNzXAntz2fHRoC9tOvd2VFI2210QQb12Z87AIKeTkmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bp.renesas.com smtp.mailfrom=renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jyU+a07KUwn4G2Kk70poGGV7AazNhMT1bo9CwkoTMgA=;
 b=leIbD7Hr23T5yc6liZI0+3oLJ7m1eSEPEprG6auRsJ0v/EmUQi3OCJ95q8mecnZdwRuf0bsl3FhlU0tPs6uO9uIp37m8ixYSwEgqZ7I4ihfkX/GxUNVz8WbfECTInOVmpyCUTxkP0dG74I9ZyRaMpDzqdcqIyZxaqRctMAVlxVM=
Received: from TY4P286CA0126.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:37c::19)
 by TYXPR01MB15740.jpnprd01.prod.outlook.com (2603:1096:405:29e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 10:27:39 +0000
Received: from TY1PEPF0000BAD7.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:37c:cafe::55) by TY4P286CA0126.outlook.office365.com
 (2603:1096:405:37c::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.14 via Frontend Transport; Tue,
 17 Nov 2026 10:27:39 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 8.62.32.50) smtp.mailfrom=renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of renesas.com designates
 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay005p.adwin.renesas.com; pr=E
Received: from ejcrelay005p.adwin.renesas.com (8.62.32.50) by
 TY1PEPF0000BAD7.mail.protection.outlook.com (10.167.240.36) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.4
 via Frontend Transport; Tue, 17 Nov 2026 10:27:39 +0000
Received: from demon-pc.tailc3dc73.ts.net (DEU-5CG5050QD0.adwin.renesas.com [10.226.92.253])
	by ejcrelay005p.adwin.renesas.com (Postfix) with ESMTP id 116453000255;
	Tue, 17 Nov 2026 19:27:36 +0900 (JST)
From: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
To: Biju Das <biju.das.jz@bp.renesas.com>,
	William Breathitt Gray <wbg@kernel.org>
Cc: linux-iio@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Subject: [PATCH v3 09/14] counter: rz-mtu3-cnt: cache function values
Date: Tue, 17 Nov 2026 12:26:02 +0200
Message-ID: <20261117102607.2504551-10-cosmin-gabriel.tanislav.xa@renesas.com>
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
X-MS-TrafficTypeDiagnostic: TY1PEPF0000BAD7:EE_|TYXPR01MB15740:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: e5c6b91b-8470-4bc1-4eb8-08df449567bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700016|23010399003|82310400026|261022105027099003|261021121427099003|11063799006|10067099003|56012099006|261026121527099003|261026140227099003|261028144727099003|261102123227099003|261021123027099003|261009223027099003|18002099003|18092099006|6133799003|22082099003;
X-Microsoft-Antispam-Message-Info:
	r7mWGeCnsFutywLDH5zCac8Z5VWxzDs3LNIgD6zc55PaURmageA1WBnhsu51/w4toHmlwCjjQZDSjLZdRoVtAEv1IXKLNgiS7L7EpeWQbju6CGei50KlH5hwZx8ASU+qV0GD6B7heHcn5j9WKtvOhRXvwqGsmNJqylBkCSkM5dhjyB+bXcjPqv3/vV4E1ptz0oVPM540XRRxZrQE2gBGjXqxJ3PPgxQcUqGBz3yUwpZ/Y/82OGwMK6LCn21iFVQwCtSZrPV/jzX8DNDXUIDPPb2KhM9K7Hq2ioYKd82/RaQoyyaPiHhdAhMvp705euUKljFut/MleQa7t70HW49aLn9m5xIMKd14tlEXEvYAd59lBNjFeNhcOJUc+ugiBWFs71azhdn7nUsUqs1UELnRqrXecd5hvUue/jFpo5gykdCq+gyeqlYGjOqvopGevZaQ88Hh+41Zp+HWEHNovG7mTEIwf8JW5aKXGr/NFB2FYCWRjez30ADyy7xrRCBJ5eajbnNGiqO0Ppkfc5Q5z0vSKghWm2R2hzXw7tvNuhmlRRLGWdolg3P9D6J5PwFhm6M8s3XRsqtvH6wTqLPJmg59DskZT8LQy7hqOG4uDHUHCnetW+0EGJD5iJREueUUyDk6JEOFJnSa3MrKLzvO8mwitGCfTz42kmG3ODE+qw83UoE5A0ujHO4W/VbZJ9tkgyosGk+//Mrieaj3pGFqP82+rQ==
X-Forefront-Antispam-Report:
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay005p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700016)(23010399003)(82310400026)(261022105027099003)(261021121427099003)(11063799006)(10067099003)(56012099006)(261026121527099003)(261026140227099003)(261028144727099003)(261102123227099003)(261021123027099003)(261009223027099003)(18002099003)(18092099006)(6133799003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	UGD3u08eZivatn4CHXSQNzPM0IjI08Gh3RFPGssEFiFTpPI8azuabIuFU9q45q4tfHj6ZBGQe7mVubX5SNDeD/z0Vbkzj5zQIZqGL7nNS2Vd9pSmpdOjpenbUarz6QCKphdbY6seqFA6CgeFHvo/fDHW9pfI2KsBp8Qud6HHczx8emp3rZUwkFqkXh2xDPnbl6wP9ZLHKkqk1wabpZAtfC6UWInUyGo9jIv7KyziMSO/DKwy6wDORJRrxuFsegF8dTym+VozYVJXjPgXfwgfTRarVf/W9qyIqNEpkvPqvMdheElORYXt+B1lbLoTGt2p6PWCqFQg+WMVgGijGgnU/jmPpARI/BfyRv3QztscYnQ8/qrppoLsIH2VXfrOg/1GIrqnWKAhaverZViYFlJISFGEY84HCvgKKQJUhX/NFRMVPfUgShD2LjMQol/hDYkU
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 10:27:39.0802
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e5c6b91b-8470-4bc1-4eb8-08df449567bf
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay005p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: TY1PEPF0000BAD7.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYXPR01MB15740

If an MTU3 channel is used in a specific phase counting mode, when
disabling it and enabling it again, the user set mode is lost because
the timer mode register (TMDR1) is initialized to the default value.

Save the timer mode after setting it and restore it on enable.
Use the cached value to determine the function in
rz_mtu3_count_function_read_helper().

Avoid writing the TMDR1 register when the count is disabled to prevent
writing registers without actually owning the channel, as the busy check
inside ch->is_busy can race with PWM operations.

Since runtime PM is ensured to be resumed if the count is enabled, drop
the pm_runtime_get_sync() and pm_runtime_put() calls.

Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
---

V3:
 * no changes

V2:
 * add struct rz_mtu3_cnt::timer_mode documentation

 drivers/counter/rz-mtu3-cnt.c | 35 ++++++++++++++++-------------------
 1 file changed, 16 insertions(+), 19 deletions(-)

diff --git a/drivers/counter/rz-mtu3-cnt.c b/drivers/counter/rz-mtu3-cnt.c
index 98e09e052aec..dc9b27461043 100644
--- a/drivers/counter/rz-mtu3-cnt.c
+++ b/drivers/counter/rz-mtu3-cnt.c
@@ -68,12 +68,14 @@
  * @count_is_enabled: Enabled state of Counter value channel
  * @ceiling: Cache for ceiling values
  * @count: Cache for count values
+ * @timer_mode: Cache for timer mode values
  */
 struct rz_mtu3_cnt {
 	struct mutex lock;
 	struct rz_mtu3_channel *ch;
 	u32 ceiling[RZ_MTU3_MAX_LOGICAL_CNTR_CHANNELS];
 	u32 count[RZ_MTU3_MAX_LOGICAL_CNTR_CHANNELS];
+	u8 timer_mode[RZ_MTU3_MAX_LOGICAL_CNTR_CHANNELS];
 	bool count_is_enabled[RZ_MTU3_MAX_LOGICAL_CNTR_CHANNELS];
 };
 
@@ -218,17 +220,11 @@ static int rz_mtu3_count_write(struct counter_device *counter,
 	return 0;
 }
 
-static int rz_mtu3_count_function_read_helper(struct rz_mtu3_channel *const ch,
-					      struct counter_device *const counter,
+static int rz_mtu3_count_function_read_helper(struct rz_mtu3_cnt *const priv,
+					      int id,
 					      enum counter_function *function)
 {
-	u8 timer_mode;
-
-	pm_runtime_get_sync(counter->parent);
-	timer_mode = rz_mtu3_8bit_ch_read(ch, RZ_MTU3_TMDR1);
-	pm_runtime_put(counter->parent);
-
-	switch (timer_mode & RZ_MTU3_TMDR1_PH_CNT_MODE_MASK) {
+	switch (priv->timer_mode[id]) {
 	case RZ_MTU3_TMDR1_PH_CNT_MODE_1:
 		*function = COUNTER_FUNCTION_QUADRATURE_X4;
 		return 0;
@@ -260,7 +256,7 @@ static int rz_mtu3_count_function_read(struct counter_device *counter,
 	if (ret)
 		return ret;
 
-	ret = rz_mtu3_count_function_read_helper(ch, counter, function);
+	ret = rz_mtu3_count_function_read_helper(priv, count->id, function);
 	mutex_unlock(&priv->lock);
 
 	return ret;
@@ -299,9 +295,9 @@ static int rz_mtu3_count_function_write(struct counter_device *counter,
 		return -EINVAL;
 	}
 
-	pm_runtime_get_sync(counter->parent);
-	rz_mtu3_8bit_ch_write(ch, RZ_MTU3_TMDR1, timer_mode);
-	pm_runtime_put(counter->parent);
+	if (priv->count_is_enabled[count->id])
+		rz_mtu3_8bit_ch_write(ch, RZ_MTU3_TMDR1, timer_mode);
+	priv->timer_mode[count->id] = timer_mode;
 	mutex_unlock(&priv->lock);
 
 	return 0;
@@ -394,8 +390,8 @@ static void rz_mtu3_32bit_cnt_setting(struct counter_device *counter)
 	struct rz_mtu3_channel *const ch2 = rz_mtu3_get_ch(counter, 1);
 	struct rz_mtu3_cnt *const priv = counter_priv(counter);
 
-	/* Phase counting mode 1 is used as default in initialization. */
-	rz_mtu3_8bit_ch_write(ch1, RZ_MTU3_TMDR1, RZ_MTU3_TMDR1_PH_CNT_MODE_1);
+	rz_mtu3_8bit_ch_write(ch1, RZ_MTU3_TMDR1,
+			      priv->timer_mode[RZ_MTU3_32_BIT_CH]);
 
 	rz_mtu3_set_ceiling(ch1, RZ_MTU3_32_BIT_CH,
 			    priv->ceiling[RZ_MTU3_32_BIT_CH]);
@@ -413,9 +409,7 @@ static void rz_mtu3_16bit_cnt_setting(struct counter_device *counter, int id)
 	struct rz_mtu3_channel *const ch = rz_mtu3_get_ch(counter, id);
 	struct rz_mtu3_cnt *const priv = counter_priv(counter);
 
-	/* Phase counting mode 1 is used as default in initialization. */
-	rz_mtu3_8bit_ch_write(ch, RZ_MTU3_TMDR1, RZ_MTU3_TMDR1_PH_CNT_MODE_1);
-
+	rz_mtu3_8bit_ch_write(ch, RZ_MTU3_TMDR1, priv->timer_mode[id]);
 	rz_mtu3_set_ceiling(ch, id, priv->ceiling[id]);
 	rz_mtu3_set_count(ch, id, priv->count[id]);
 
@@ -644,7 +638,7 @@ static int rz_mtu3_action_read(struct counter_device *counter,
 	if (ret)
 		return ret;
 
-	ret = rz_mtu3_count_function_read_helper(ch, counter, &function);
+	ret = rz_mtu3_count_function_read_helper(priv, count->id, &function);
 	if (ret) {
 		mutex_unlock(&priv->lock);
 		return ret;
@@ -811,6 +805,7 @@ static int rz_mtu3_cnt_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct counter_device *counter;
 	struct rz_mtu3_cnt *priv;
+	unsigned int i;
 	int ret;
 
 	counter = devm_counter_alloc(dev, sizeof(*priv));
@@ -822,6 +817,8 @@ static int rz_mtu3_cnt_probe(struct platform_device *pdev)
 	priv->ceiling[RZ_MTU3_16_BIT_MTU2_CH] = U16_MAX;
 	priv->ceiling[RZ_MTU3_32_BIT_CH] = U32_MAX;
 	priv->ch = &ddata->channels[RZ_MTU3_CHAN_1];
+	for (i = 0; i < RZ_MTU3_MAX_LOGICAL_CNTR_CHANNELS; i++)
+		priv->timer_mode[i] = RZ_MTU3_TMDR1_PH_CNT_MODE_1;
 
 	mutex_init(&priv->lock);
 
-- 
2.56.0
