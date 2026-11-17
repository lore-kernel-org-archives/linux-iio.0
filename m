Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.125.63
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794911267;
	b=h7+jkPMX63Wz2XV4kG2b2Mcpai9ay+5ZONO50bAGnnk8SSeS8mxDc2b9mXqrGnLuQj58
	 Pw2s9vyRApy12GPYlqkfa8dZrrwtryChZARZqGjWEeUZ9tPUSsFqwbS6BX+Q4e0SdIZLc
	 KBSO8TdCe0lfsqj4iAEoavMzmerHR3WX4Se7yHUH3f6Y6KkKDr5dysLIv2siMNnX8XFKz
	 uGvRYBCFqon7CjgT4ofe3t6xtoqvE0s1lZueucUotZdE81Fm+4Mpm4V8C2jIW/4Eqwh/4
	 Tje9qiVOpIs99vfv3UhX0kKd0rIdMQoS0Aav1uOgGvv6I4J8D15xJyayiJUm4/aw4Mg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794911267;
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
	bh=yeYIOTFKmeE8M1aNxBtrN6utQuALGqetZloS2cAchSk=;
	b=uqs7v0xAvanIOJy218iQ44iZ9pFzzUmUZKjJ/v2bFD4xotmdbCX9mYq6PBZ2fkvRvIxW
	 x2zwvxgowYBDalc/4/TqUXmruEOK/3/LekaUSqg5PLKz+VuWCDq26bXgRtBc/oemRhBcg
	 l6ND6arcvV7xwJr/6EToO/q+NAakx5Wjn/H/sk5czI211ffhdpG6gyXDjQ8xoWDa7eFpU
	 7BxKytr9brNplGXsudWKorxqZFmqDETcBLxJpaZ+V04APgRnBj2leO9d3kTXCHjOnKOGR
	 apBtuW1xPcNW+KMx9u5PxOdevleccgJBxdmhXIQi8ntw/1Q4E6eJQbtgUn+EJXX1B6A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=renesas.com;
	spf=pass smtp.mailfrom=renesas.com;
	dkim=pass header.d=renesas.com header.i=@renesas.com header.a=rsa-sha256 header.s=selector1 header.b=AlbF2GXa;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.125.63
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011063.outbound.protection.outlook.com [52.101.125.63])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35DCF606A8A2;
	Tue, 17 Nov 2026 10:27:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 35DCF606A8A2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=renesas.com header.i=@renesas.com header.a=rsa-sha256 header.s=selector1 header.b=AlbF2GXa
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GSkTELB438lphYJof8jVZJDRLTAmcjvlS0bzJooWuWR0PHIBnpJF/s4d1BjUxHwutzLD8G3VYlcKG8/Do2j9wisRm9xPha3gVE5zWoydwPAKoqwZsGUeOfLN/rGOc4UKaQIDEwFjEK0DKx0tCszoHQVpz3pdOn40SQVnM2RK8+she0ysEkjSCl7gazzfqa5fEoMeA5nX/IWZpY8c54EzBRBUdzWHBRvjcIYMbVYaSMPG+zSirPvVoSHR9O1fouPWcXArfFjOR5N430Etr3mO+fpnIkBenKb39un6BG0Adyh/Dg7QPZvlcwXtslEyZ6heDJHwyU/0MO5mMTx0JRTFJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yeYIOTFKmeE8M1aNxBtrN6utQuALGqetZloS2cAchSk=;
 b=zRxGkzO1HS4y5VCucCUBVNavl7BVP/IGPCTdaOlmsmVTTDN4kAqdxN5O6HEZoW0SE03rhB/TwAwU7rSabVxqe9xJf3Oi3CH6kL04JSB0wdZ8gxdhzrlOQihL5/rNowNu0mdDTErsuRp9/ZOaJyq3KVird1FHLCo5y33i1psMoe8VYAie7IVSux8PAHtOx+Wmv8A8SEOib0QOsELAdh4Y2m4eGVJ4tda6ak/mmTcsogR6ffbuKygKIQXVF115UcPQUdAjdp7wsOj0BXv8nhaidkAf95UJO/7ZzIiJFWP/UNNRhU6eg6RTIWLSC+2yp2zeYStoWzsebBtVRH73m8WasQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bp.renesas.com smtp.mailfrom=renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yeYIOTFKmeE8M1aNxBtrN6utQuALGqetZloS2cAchSk=;
 b=AlbF2GXa1aio/dyKsOdhwD8+LQZdl2X88uY5QhJWCp26G59fOQVZ0TLw4IBhhl/9+9N4VD3tmRJZpaxL9CE+DNglIiOwyQbN9s/EwToZ9jNfqIxasd1i8c869uaF0oqC+zfxxhOLAtjlqqyBLQ4pmcSw182tshguKHNNJfoL/vM=
Received: from OS7PR01CA0183.jpnprd01.prod.outlook.com (2603:1096:604:250::15)
 by TYRPR01MB13865.jpnprd01.prod.outlook.com (2603:1096:405:215::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 10:27:42 +0000
Received: from OS3PEPF0000003C.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:250:cafe::a3) by OS7PR01CA0183.outlook.office365.com
 (2603:1096:604:250::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.14 via Frontend Transport; Tue,
 17 Nov 2026 10:27:42 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 8.62.32.50) smtp.mailfrom=renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of renesas.com designates
 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay005p.adwin.renesas.com; pr=E
Received: from ejcrelay005p.adwin.renesas.com (8.62.32.50) by
 OS3PEPF0000003C.mail.protection.outlook.com (10.167.240.5) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.4
 via Frontend Transport; Tue, 17 Nov 2026 10:27:42 +0000
Received: from demon-pc.tailc3dc73.ts.net (DEU-5CG5050QD0.adwin.renesas.com [10.226.92.253])
	by ejcrelay005p.adwin.renesas.com (Postfix) with ESMTP id 0920A3000255;
	Tue, 17 Nov 2026 19:27:39 +0900 (JST)
From: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
To: Biju Das <biju.das.jz@bp.renesas.com>,
	William Breathitt Gray <wbg@kernel.org>
Cc: linux-iio@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Subject: [PATCH v3 10/14] counter: rz-mtu3-cnt: cache external input phase clock value
Date: Tue, 17 Nov 2026 12:26:03 +0200
Message-ID: <20261117102607.2504551-11-cosmin-gabriel.tanislav.xa@renesas.com>
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
X-MS-TrafficTypeDiagnostic: OS3PEPF0000003C:EE_|TYRPR01MB13865:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: a98e0240-79c3-4a39-5516-08df4495698b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|82310400026|1800799024|36860700016|376014|261026121527099003|261021121427099003|261021123027099003|261102123227099003|56012099006|11063799006|10067099003|22082099003|18002099003|261009223027099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	mC24qO0H67MVcOoYgHhZPFrK5W5PfHKK0cQB0G6V1umsM7hgbXWmp6QDdpUT7kt0XGqio/R61H4iLE+tPlqat6hwne0TSgKttowo1PCAxLEXMNE63smtTUrJeSDHWJm3MKowPdht7YujWNL7btYbu6XyAapwfgBP5m+t6AgQ96Qkt/gbGy6oOobd6UmBNum64FSlvAxTdqUHk/Zekn47fB3CJVIpgAbz6MbptS9BcLE4jnST6ISgGfi5uWpDtGszQCq97kv5Vst4Qm3krVYyxCCdnLzQAHdCqjvVeyYdV3XmYhwghaxe8dgMJCGCEwR0jMo7l2Jy7TNQA4NZbgfvUnOZhslidf05P4afL7wIm1aNrf6CmROdC6xnqLbuLzvKtBIysdtxrS79fISMKSIrO5PsXB2OZvgsy2KpcLMa3C0Ul3xe8cF/+mj/1/NaJYbH4jaCU7Wl0kVxI6zBQzMz3pp1IQdAYv87mbGxELKu1dl+Uatp9qyfoBXyacFRK8f7npoY2bNpYPzDE2E6+/aW1WY5+EXGqqqCeDtIeaFQeELp2v5jY1kl2GfqUyjtjNmByT/AqKU59Ojl1QG11hnwRWPU5nQlEE2X2ZS+gQcpcFxL1HDuHXDKyIOnkbiI43j3UlONYwmPNvi97RjZjU1RGuv1YykujatP2rOKVoqxbeacs+d6BP7wckAlnmv3IBQEcAcagEFEWg+4XuNKf+TlTA==
X-Forefront-Antispam-Report:
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay005p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(82310400026)(1800799024)(36860700016)(376014)(261026121527099003)(261021121427099003)(261021123027099003)(261102123227099003)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003)(261009223027099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	7K6CdyQPeCBPyHl6NqgsFdMgRXl8MU2T6QSx0sbLJ8dR4C2iXEEHA9mmY02QFn0aEQRAdWV4PgGxu9BDAKUz5yKphzPOtpIr31C0an41SOQ/bnY2QTQyp6Y0o51ZrAs0wzNLFxr2jKEiwZcvcU29cIkKU67PkSGsqS3kGmU13Hab2whsT3qr+4uZL74MvURAI0U2VAjWbK7dKhiZZxXLdHDAJZZhsdoyABRtx6QlCsOZ8pxG4pm9YZ37s+GgCuA5Wb25QGCZoAAWIGQwyhLxWJlQGascYh3H0vuvOXKYHZVt0m43ddFH2sZ4YPAM24kpSo/suF5I2rjNA3bC9XLY5qyrMmNzomAQtL7ASWTijNyDrkFmVyZZjo4HJpqoY7XGvz9gA7S6QVX0gNWTbK1bsDr2p0XgMUcN8DXjrd9Kay7GKDVlNqrInNrym1NDfuZ3
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 10:27:42.0817
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a98e0240-79c3-4a39-5516-08df4495698b
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay005p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: OS3PEPF0000003C.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB13865

PHCKSEL selects between MTCLKA-MTCLKB and MTCLKC-MTCLKD pins for the
external input phase clock.

PHCKSEL only affects the 16-bit count backed by MTU2 and the 32-bit
count.

Cache the value written to external_input_phase_clock_select and restore
it on enable to bring the external_input_phase_clock_select sysfs entry
in line with the other entries.

Initialize the cached value to true, matching PHCKSEL's reset value so
behavior is unchanged for a count that gets enabled without
external_input_phase_clock_select being written explicitly.

Always use the cached PHCKSEL value to remove the need to access
registers while counts might not be enabled.

Only restore it for the count backed by MTU2 as changing PHCKSEL for
MTU1 does not affect the pins used for the external input phase clock.

Check if any of these counts are enabled before writing the new PHCKSEL
value.

This prevents writing registers without actually owning the channel,
as the busy check inside ch->is_busy can race with PWM operations.

Since runtime PM is ensured to be resumed if the count is enabled, drop
the pm_runtime_get_sync() and pm_runtime_put() calls.

Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
---

V3:
 * no changes

V2:
 * add struct rz_mtu3_cnt::mtclkc_mtclkd documentation

 drivers/counter/rz-mtu3-cnt.c | 36 +++++++++++++++++++----------------
 1 file changed, 20 insertions(+), 16 deletions(-)

diff --git a/drivers/counter/rz-mtu3-cnt.c b/drivers/counter/rz-mtu3-cnt.c
index dc9b27461043..4b13716d6cb7 100644
--- a/drivers/counter/rz-mtu3-cnt.c
+++ b/drivers/counter/rz-mtu3-cnt.c
@@ -69,6 +69,7 @@
  * @ceiling: Cache for ceiling values
  * @count: Cache for count values
  * @timer_mode: Cache for timer mode values
+ * @mtclkc_mtclkd: Cache for external input phase clock select value
  */
 struct rz_mtu3_cnt {
 	struct mutex lock;
@@ -77,6 +78,7 @@ struct rz_mtu3_cnt {
 	u32 count[RZ_MTU3_MAX_LOGICAL_CNTR_CHANNELS];
 	u8 timer_mode[RZ_MTU3_MAX_LOGICAL_CNTR_CHANNELS];
 	bool count_is_enabled[RZ_MTU3_MAX_LOGICAL_CNTR_CHANNELS];
+	bool mtclkc_mtclkd;
 };
 
 static const enum counter_function rz_mtu3_count_functions[] = {
@@ -178,6 +180,12 @@ static void rz_mtu3_set_count(struct rz_mtu3_channel *const ch, int id,
 		rz_mtu3_16bit_ch_write(ch, RZ_MTU3_TCNT, count);
 }
 
+static void rz_mtu3_set_phcksel(struct rz_mtu3_channel *const ch, bool enable)
+{
+	rz_mtu3_shared_reg_update_bit(ch, RZ_MTU3_TMDR3, RZ_MTU3_TMDR3_PHCKSEL,
+				      enable);
+}
+
 static int rz_mtu3_count_read(struct counter_device *counter,
 			      struct counter_count *count, u64 *val)
 {
@@ -390,6 +398,8 @@ static void rz_mtu3_32bit_cnt_setting(struct counter_device *counter)
 	struct rz_mtu3_channel *const ch2 = rz_mtu3_get_ch(counter, 1);
 	struct rz_mtu3_cnt *const priv = counter_priv(counter);
 
+	rz_mtu3_set_phcksel(priv->ch, priv->mtclkc_mtclkd);
+
 	rz_mtu3_8bit_ch_write(ch1, RZ_MTU3_TMDR1,
 			      priv->timer_mode[RZ_MTU3_32_BIT_CH]);
 
@@ -409,6 +419,8 @@ static void rz_mtu3_16bit_cnt_setting(struct counter_device *counter, int id)
 	struct rz_mtu3_channel *const ch = rz_mtu3_get_ch(counter, id);
 	struct rz_mtu3_cnt *const priv = counter_priv(counter);
 
+	if (id == RZ_MTU3_16_BIT_MTU2_CH)
+		rz_mtu3_set_phcksel(priv->ch, priv->mtclkc_mtclkd);
 	rz_mtu3_8bit_ch_write(ch, RZ_MTU3_TMDR1, priv->timer_mode[id]);
 	rz_mtu3_set_ceiling(ch, id, priv->ceiling[id]);
 	rz_mtu3_set_count(ch, id, priv->count[id]);
@@ -570,17 +582,13 @@ static int rz_mtu3_ext_input_phase_clock_select_get(struct counter_device *count
 						    u32 *ext_input_phase_clock_select)
 {
 	struct rz_mtu3_cnt *const priv = counter_priv(counter);
-	unsigned long tmdr;
 	int ret;
 
 	ret = rz_mtu3_lock_if_ch0_is_enabled(priv);
 	if (ret)
 		return ret;
 
-	pm_runtime_get_sync(counter->parent);
-	tmdr = rz_mtu3_shared_reg_read(priv->ch, RZ_MTU3_TMDR3);
-	pm_runtime_put(counter->parent);
-	*ext_input_phase_clock_select = test_bit(RZ_MTU3_TMDR3_PHCKSEL, &tmdr);
+	*ext_input_phase_clock_select = priv->mtclkc_mtclkd;
 	mutex_unlock(&priv->lock);
 
 	return 0;
@@ -596,11 +604,10 @@ static int rz_mtu3_ext_input_phase_clock_select_set(struct counter_device *count
 	if (ret)
 		return ret;
 
-	pm_runtime_get_sync(counter->parent);
-	rz_mtu3_shared_reg_update_bit(priv->ch, RZ_MTU3_TMDR3,
-				      RZ_MTU3_TMDR3_PHCKSEL,
-				      ext_input_phase_clock_select);
-	pm_runtime_put(counter->parent);
+	if (priv->count_is_enabled[RZ_MTU3_16_BIT_MTU2_CH] ||
+	    priv->count_is_enabled[RZ_MTU3_32_BIT_CH])
+		rz_mtu3_set_phcksel(priv->ch, ext_input_phase_clock_select);
+	priv->mtclkc_mtclkd = ext_input_phase_clock_select;
 	mutex_unlock(&priv->lock);
 
 	return 0;
@@ -630,8 +637,6 @@ static int rz_mtu3_action_read(struct counter_device *counter,
 	struct rz_mtu3_channel *const ch = rz_mtu3_get_ch(counter, count->id);
 	struct rz_mtu3_cnt *const priv = counter_priv(counter);
 	enum counter_function function;
-	bool mtclkc_mtclkd;
-	unsigned long tmdr;
 	int ret;
 
 	ret = rz_mtu3_lock_if_count_is_enabled(ch, priv, count->id);
@@ -648,10 +653,8 @@ static int rz_mtu3_action_read(struct counter_device *counter,
 	*action = COUNTER_SYNAPSE_ACTION_NONE;
 
 	if (count->id != RZ_MTU3_16_BIT_MTU1_CH) {
-		tmdr = rz_mtu3_shared_reg_read(priv->ch, RZ_MTU3_TMDR3);
-		mtclkc_mtclkd = test_bit(RZ_MTU3_TMDR3_PHCKSEL, &tmdr);
-		if ((mtclkc_mtclkd && is_signal_ab) ||
-		    (!mtclkc_mtclkd && !is_signal_ab)) {
+		if ((priv->mtclkc_mtclkd && is_signal_ab) ||
+		    (!priv->mtclkc_mtclkd && !is_signal_ab)) {
 			mutex_unlock(&priv->lock);
 			return 0;
 		}
@@ -813,6 +816,7 @@ static int rz_mtu3_cnt_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	priv = counter_priv(counter);
+	priv->mtclkc_mtclkd = true;
 	priv->ceiling[RZ_MTU3_16_BIT_MTU1_CH] = U16_MAX;
 	priv->ceiling[RZ_MTU3_16_BIT_MTU2_CH] = U16_MAX;
 	priv->ceiling[RZ_MTU3_32_BIT_CH] = U32_MAX;
-- 
2.56.0
