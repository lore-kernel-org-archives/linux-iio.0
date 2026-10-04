Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011062.outbound.protection.outlook.com [52.101.125.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B2244756C3;
	Sun,  4 Oct 2026 17:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791136191; cv=fail; b=jse93cfFKeVPxGflvrhGiFGLQFvshniN3FzGLCI532HwBimJQDzqwjDlcwxXulFpRKkA/ZKepE5+2sUg3TT5wRW+q5aDuOwKhTMfA7FMBsFB1KqTrmqiL+QkysEOWesi3LR927lf4A50p+Xre+ccA0TS0w2cTTvOMptE/FzMUdg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791136191; c=relaxed/simple;
	bh=dsVgloS81qZFU7ALn3kT1K2AD86aVuiNxiEYUbuOi1g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Gf8F/kYbXHFkhUD4kauRl8XKnvruUJ4dkQQmxvz2aNayE+UtQydziqMPAG9yv9LIyEHqLtZVUYx6aPGmxebTnidhyj+mt2ZuD65CS8IWoIFwqMvYnpAssoqwvT8URgbrlWq8xDuQCLVggBxzoBzrFMC3AG1Hnj/3q6WjqHXlL8U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=Y4OBYLFT; arc=fail smtp.client-ip=52.101.125.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="Y4OBYLFT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rtCd8FLE3rx00HsiYuJES9X3WFkMsOKu1cZgIl+7RMo3zKQw1rml5O364qyvqrIp3toj4YcR92Z8YHHze7mj5/iXeEgNESzJhES4VGes+7L2eBHOZ0o7Vj52HLhDOC5HTIcyiWifwyuIxxFD1e+vYD5p7oLpaenF0sJ3i9I5qOdP6Diu+098vmV8zyuILoMzPnKQPWKgl8XaMhcIR0wulIZdyDyIuXLowjf5/eRsU3eaRBhZWR3nUfNunHqvT0HlmHEKp2S0bCaKUoM0szbcdVRM21UEINsWVsNc9CSVxqCjq8cdMql/KpH0SYwZdbTV2BmS+P1q3FJTOX3S5vcdXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yierhv0QnDVW4Fx8bPXwHp2wcgYRMvZ3haiIAfEFJvg=;
 b=ssAYWrDvMxwrducVi0kU21v+t+boGpbQH9oLOSxXy5/LITuOeEy1Nx5UWPq4+WEHXyVY8MiLkfP1EkT0b/12zHTo6FR5wvOvWzleIk12t7e5Pf6CZmqRXvKbgVvv4L56lGwAwlYOd6X3I2VkxdJoMM5xHBI+y14h6VVHPf6RAn4NT60wlP1NjclRksrF9zhZqiMfuOfSGCE7Z6boIjwn3AQIc3JdgrD9dOYL9MJufKCebc7qBlST/P/tzIX+3HUk/QJIntKlDTBYSIXNh6bH69ASYqxaQshJTLhGby7JH59rc5Y1HJAuv9pv9iS4mpmwzJzBYhhAhzPVh9xLoRRubg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bp.renesas.com smtp.mailfrom=renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yierhv0QnDVW4Fx8bPXwHp2wcgYRMvZ3haiIAfEFJvg=;
 b=Y4OBYLFTD5kYp3MVvHtBfbmk+c14awExzdvsSIiOFasf+nhW+UgJaviAhtoxRwm+7DU9FvWEF0MEzLrogy/2JYPwyX/QT/LOvcSMPXy6vgFCQznHiOjUxJA92A1TvU2vi2sUt6nPyrql46LjM69ciiIoxGCRKWVOPDy536Ws/Q4=
Received: from OS3P286CA0089.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:1f6::18)
 by OS9PR01MB16197.jpnprd01.prod.outlook.com (2603:1096:604:3de::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Sun, 4 Oct
 2026 17:49:35 +0000
Received: from OS3PEPF0000003E.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:1f6:cafe::61) by OS3P286CA0089.outlook.office365.com
 (2603:1096:604:1f6::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Sun, 4
 Oct 2026 17:49:35 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 8.62.32.50) smtp.mailfrom=renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of renesas.com designates
 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 OS3PEPF0000003E.mail.protection.outlook.com (10.167.240.7) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.14
 via Frontend Transport; Sun, 4 Oct 2026 17:49:35 +0000
Received: from demon-pc (unknown [10.226.92.36])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id 44FC03000253;
	Mon,  5 Oct 2026 02:49:32 +0900 (JST)
From: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
To: Biju Das <biju.das.jz@bp.renesas.com>,
	William Breathitt Gray <wbg@kernel.org>
Cc: linux-iio@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Subject: [PATCH v2 12/15] counter: rz-mtu3-cnt: cache direction values
Date: Sun,  4 Oct 2026 20:47:49 +0300
Message-ID: <20261004174752.507499-13-cosmin-gabriel.tanislav.xa@renesas.com>
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
X-MS-TrafficTypeDiagnostic: OS3PEPF0000003E:EE_|OS9PR01MB16197:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 36c750f8-0f8f-4527-a7a0-08df223fda83
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|23010399003|36860700016|1800799024|18002099003|22082099003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	DFxxjviyDbgq1SaDCsNcM38NSpSqMhBIM9ZuXb6yOjskCPDX/kdNKl97YksXiIcj/4Am7UxUjUfob2RWYZWZHWwuJlJjbGM1ZHnYHKVh1+V30KizjFQMCnFqLxeh9gesqJ/35i1vxofG5pN62lvdoLUNjH25vv/7g+cCY0g7h+zt/+vFHe4jUvpbyDP5qADjF3sUes1fae1wG2HMwnvhrsjtSLlpvmQ5s78nMurZWcC3rldsDOu4ZePsiN4nVyhnj7crR4Q6lql2lOXq2FMlLFKtF4GIdi4kU0JRvKpPNEozgr5j9NfHUV5VbCu71+QSJr2adTozzxWdEFSI192oMKhl/F3ur6ZzqzckGZoiK5rM7Q89QVn/4hwCMPhFfrhh6SbrdH0ObcZdzVH+L9G19wSVkwm/2h8O6Y5U0HrN2S8/YIVZ7DLoayW/MxOUsr2jrLAG2p2RBz/HSKwbM8p9WeBKRjmaXvehmBbGIDkXNm2oOueH+cTZ77EzYKXebBlVArAOq9dNQOKHbfHGMdXWlUQ1U4zak9urJBhywMvH6WPzrJIyvF7lMhEkQv4NfwfWUVQ54KY3w8uqdXMUu7W0FhzvO/kc1RJN+dvy3hwLPxWDwHVF7lSuQAD7oHHb7AILYx6ju06113BBOZqQFrHT0jQQduZJulDZBYHS1aALzwURXh8Bc7czP6EBenkFMkxpU8cpTDN1Fa4xb5LEAn6NcA==
X-Forefront-Antispam-Report:
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(23010399003)(36860700016)(1800799024)(18002099003)(22082099003)(10067099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	9WvBPSzhtQNBkjA/w203yuHtHwW+vWoTo1zSKamxk3bJmG6lDrpe8w2xUbXfXt2cSrBwgr9Y0BgSJELuXCYu4Qu4YmuowVP5uo25Y8n76t8jR44VLlnQwJWAqlWd91wptASwOJU3UeDcUEQ/82+eAEqFwsa5H0suPbr5vRWCu3YwYJcx4w7n3PsYBR3OKBwl7soSl4pBLXTbSCyVT9oSWIUDAJXs1szuNy9kuqpcufoOGjXKyq58f6Z31EhZCpACsXBCdPeFp7vzElgZF4Qs44hz75wD6IFuYngCQEZLHJ6lkjSmjKuiC7dzDmeKZRecCk1KFvPl8pc5xRpZP+uV7eHOuon51el6CUYdTfXC4H9Oyr+N3B25r+ZePIEhsOJAUDs+6Ps4AoGMZcKuGS/4D567j5TOApk1GScDQE9CDKGrbUjFWxqnV38evZCoOyzR
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2026 17:49:35.3603
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 36c750f8-0f8f-4527-a7a0-08df223fda83
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: OS3PEPF0000003E.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9PR01MB16197

Reading registers without the count being enabled is an issue as the
ch->is_busy check inside rz_mtu3_lock_if_count_is_enabled() can race
with PWM operations.

Cache the direction value on every read and on disable, and return the
cached value if the count is disabled.

Since runtime PM is ensured to be resumed if the count is enabled, drop
the pm_runtime_get_sync() and pm_runtime_put() calls.

Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
---

V2:
 * add struct rz_mtu3_cnt::direction documentation

 drivers/counter/rz-mtu3-cnt.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/counter/rz-mtu3-cnt.c b/drivers/counter/rz-mtu3-cnt.c
index b1714ab1f7db..e36c61ae35d1 100644
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
2.55.0
