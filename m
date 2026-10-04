Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010052.outbound.protection.outlook.com [52.101.229.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 578423C1404;
	Sun,  4 Oct 2026 17:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791136178; cv=fail; b=DJZybcOeAEHu18XImYajga9oErQcwH+YcK0ahYWU642TGR4PHuW7y077cDichmiP7Dn5MAonX8DIS8O6wN0HhzaL2B/yiNqec329IXMYODc6s1PH+SQpcTf1WxTfd1sMQulXp/w9CA8b0QH292ZwszpaaZlP11ytXr03Jc2t/cs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791136178; c=relaxed/simple;
	bh=9E7NQgzOKteV98WVBeingDygHWy5Y0NzcBJ6MKalnrU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OkPLnmaTWLaiiHsIC4zT4yuywgrNqvZeMYsh7jVBD7Map7ycRhqM73epxmwkfxGEDJxENw4Kk6EPiH4Ei6PHhTdP8AkwUnHta4GWAxf3doWA/BLN3wG0KsaUNUH+kPY1qUbWd5ZURd+SaAplW13LDaKTEVkZTtf75CDkqSgojFA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=Y8vGq8yP; arc=fail smtp.client-ip=52.101.229.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="Y8vGq8yP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c7f/mW8vf5jkGEaWv8gO0Ett2IPhRgALUgli66qcV3AOS9bPFhHrINssTfwq0s6jkWrMD2mUb47cea37R3u5EJrQgE7GwGo4h3vR8h/c1666GSKQSOrfQSFBOWeXv+bbfXuOGMa7BhE9u/nO1QTYetGpuKHB4RCFWFa6TXLSBQx1NgLErJYKZE6N+KZW+ujzw14ioW5/D8IZnq6sqke18i29sXgsjKOEkzpBmuayRmPAXSx0rk9C2Bk+GTQilLYBYW9LD3VfF9IEkjhKP5/IrEepVFNSzN+8thwPq/DjsWi9GKRxplSK+gKW5049PN4+fouUNauWsUTX1Ji9zIFWOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ATK4kvBd4A2yBY1slqqVZJSI6cHMcNimhXSN5BXAvyU=;
 b=UAXlWmNksbrPcwacazv5lwez14ZBq9Gcd4w00WvnndvjgghpQiCVutlWy9eCLTnzyHyNy3ACmIrVnJkF6FIeMWnL1F8KRuuo+PgLXfCYaC8FJ77yS9BS2LEjMSsAs1jaQIgwzbDo+YmPEr3iX7YDsXXXnIEPI0F3KY10AS8cRgo/eM2Tf3qO1Aqj7Qqs/VcEuqhzpNsHlbJf4FBUzm31eDzbMkF7zalcLHXIzqz6YxxsxvYhq60R9VkKL+lfIXE3f8TqMZe2WbGla064GwC1ErX+7vdbD84/XQGiQk5YF3JB56KQyaEA331BZv5l7nlA5kwIJgfGAXqW7otbiloZdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bp.renesas.com smtp.mailfrom=renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ATK4kvBd4A2yBY1slqqVZJSI6cHMcNimhXSN5BXAvyU=;
 b=Y8vGq8yPZwdAPYVeQynMmNuX0Br91u4GDUtmio0gkBv3D+2/Y3MXWw04et9fBhHSJu9783O1kRL9FfBElmIWcyoUD+UIIAu54WUNndW+qD9mCrWuVSRWbBkVpg2G552IpY5eYwoo5yf9HEBef3PJkaNtbsXnsdLUS7d5TZmOJjA=
Received: from TYCP286CA0153.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:383::15)
 by OS9PR01MB13190.jpnprd01.prod.outlook.com (2603:1096:604:30c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Sun, 4 Oct
 2026 17:49:25 +0000
Received: from TYO1EPF00005021.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:383:cafe::4d) by TYCP286CA0153.outlook.office365.com
 (2603:1096:400:383::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Sun, 4
 Oct 2026 17:49:25 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 8.62.32.50) smtp.mailfrom=renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of renesas.com designates
 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 TYO1EPF00005021.mail.protection.outlook.com (10.167.240.6) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.14
 via Frontend Transport; Sun, 4 Oct 2026 17:49:25 +0000
Received: from demon-pc (unknown [10.226.92.36])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id 3FAA93000253;
	Mon,  5 Oct 2026 02:49:22 +0900 (JST)
From: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
To: Biju Das <biju.das.jz@bp.renesas.com>,
	William Breathitt Gray <wbg@kernel.org>
Cc: linux-iio@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Subject: [PATCH v2 09/15] counter: rz-mtu3-cnt: cache count values
Date: Sun,  4 Oct 2026 20:47:46 +0300
Message-ID: <20261004174752.507499-10-cosmin-gabriel.tanislav.xa@renesas.com>
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
X-MS-TrafficTypeDiagnostic: TYO1EPF00005021:EE_|OS9PR01MB13190:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: ec28d892-cd83-454a-b4ca-08df223fd4ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|23010399003|1800799024|82310400026|376014|18002099003|22082099003|56012099006|11063799006|10067099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	m3XfvST6fOlJcj3BwM05AINp8U2qiKGDTKbEaI9/f7/t6KW1TY+3IRch2Yh9ovuVY54SwpGyT9sPPtNJiiURcTzjHAdj4JSTDxEKjxcrD2ewEA8fEQOUjM/oxGAsZPem1ZKixqvY4c9LjIzXDJN8qG8Z6MhwXL0RwUCDQ0fmHt5qlXhkkbMkBCNxN1p4zXR7YDm+342FWPRik81E5wmIKaEgOeNkNRA6xEJsGVO3KaVbSgP3a9p4SggXzIraKoIqFxKozuC7wl4/qlFIGhYY+dy6m0gt5hCuM4bH6vxGNdet9EtFE707OrCq423UeMhIYXaAy1y4xPY6SbO9kI5mE6wWBU1PRY+McwMyKR7VUdoPjvN9wpai+kfRYEAhUKW2AOQsUZv049VazqTvhDUOb5V/aq9VPwcgGmzeLCE/zGw17V13Iqr/Y+H2qs25BOPXptrYobFpnC8u3vkJiHO6SRI7wwVIDhfp8gbQhhFHYXshITdIqAR7X/ChL+iz6ypc+5DszVHOS8l66ILasmGvYw9CxxzdNKV9fk9eX0ezeUeiAcGrpMhQVJ/Fq4ZrG08sg6mk0KKSN9QJBTLiZgZcQBHHM90eknd1wQ78AJISxh8PpiqPcn1PSF4LZ3PqSJxsH1pmRgeiye5OMQ6y8ltTHQvhva0n61VpyU/VxLrC9tTqXUA9mfv+pHdZaayfXgROTEqZuGt55dkNclJ5vkKAFQ==
X-Forefront-Antispam-Report:
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(1800799024)(82310400026)(376014)(18002099003)(22082099003)(56012099006)(11063799006)(10067099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	/RK35sQOLw8HA8pkUCYkoHWc/UJd5FU2nR2I8a5WnlnTIXRxeszkoPIyvq7/h+fYoHkxuIqrPlhHsdNR9wO13KRLRG3lQ1Nrb90W+RrfkfKok4tzyR1JrTU6zQicwlijvGz4sY/CgDR0ehIoVFTAsZp4n0I4Io8YG3WVqHfIaXQE/VI5tANHmZsGa/Rcn0Z3dAB5vdC7QkrXlBFKou+m9NURAavueTCzi45mUdrKfEMj3e1fYgzpunpNEBlATNeTBpfCJI6Ta8pvFCYrAdRyx2Dch1i7qnJ1bVNYIRymmMEkGGHWAFuAy4A8hmgFjSPEX477h0cHRcxGvC2UFP8uDqhd+s6fFPkHNthXTdUEEGwg42orQT6xB4t2+a6auQ8UNzmA22Ky/K247a7ogOv8EUeaJCLzRjbUHY2NW5WPfLBndgXPrI8j95ACxeyuVRKZ
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2026 17:49:25.5701
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ec28d892-cd83-454a-b4ca-08df223fd4ab
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: TYO1EPF00005021.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9PR01MB13190

If an MTU3 channel is used in counting mode, and then in PWM mode, when
returning to counting mode the count value is lost because the TCNT
register is overwritten by PWM mode.

To handle this issue, save the count value on disable and restore it on
enable, and also save it inside rz_mtu3_count_write().

To avoid writing the count value register when the count is disabled,
and to prepare for the removal of the rz_mtu3_lock_if_counter_is_valid()
function which is susceptible to TOCTOU races because of the ch->is_busy
check, only read or write the count value if the count is enabled.

Mask the count value to the channel's width before caching it, so an
out-of-range write to a 16-bit channel is truncated the same way
a direct register write would have been.

Since runtime PM is ensured to be resumed if the count is enabled, drop
the pm_runtime_get_sync() and pm_runtime_put() calls.

Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
---

V2:
 * add struct rz_mtu3_cnt::count documentation
 * mask 16-bit counter value to preserve behavior

 drivers/counter/rz-mtu3-cnt.c | 47 ++++++++++++++++++++++++++---------
 1 file changed, 35 insertions(+), 12 deletions(-)

diff --git a/drivers/counter/rz-mtu3-cnt.c b/drivers/counter/rz-mtu3-cnt.c
index 485fde79a76a..61cf26e20471 100644
--- a/drivers/counter/rz-mtu3-cnt.c
+++ b/drivers/counter/rz-mtu3-cnt.c
@@ -67,11 +67,13 @@
  * @ch: HW channels for the counters
  * @count_is_enabled: Enabled state of Counter value channel
  * @ceiling: Cache for ceiling values
+ * @count: Cache for count values
  */
 struct rz_mtu3_cnt {
 	struct mutex lock;
 	struct rz_mtu3_channel *ch;
 	u32 ceiling[RZ_MTU3_MAX_LOGICAL_CNTR_CHANNELS];
+	u32 count[RZ_MTU3_MAX_LOGICAL_CNTR_CHANNELS];
 	bool count_is_enabled[RZ_MTU3_MAX_LOGICAL_CNTR_CHANNELS];
 };
 
@@ -157,6 +159,23 @@ static void rz_mtu3_set_ceiling(struct rz_mtu3_channel *const ch, int id,
 	rz_mtu3_8bit_ch_write(ch, RZ_MTU3_TCR, RZ_MTU3_TCR_CCLR_TGRA);
 }
 
+static u32 rz_mtu3_get_count(struct rz_mtu3_channel *const ch, int id)
+{
+	if (id == RZ_MTU3_32_BIT_CH)
+		return rz_mtu3_32bit_ch_read(ch, RZ_MTU3_TCNTLW);
+	else
+		return rz_mtu3_16bit_ch_read(ch, RZ_MTU3_TCNT);
+}
+
+static void rz_mtu3_set_count(struct rz_mtu3_channel *const ch, int id,
+			      u32 count)
+{
+	if (id == RZ_MTU3_32_BIT_CH)
+		rz_mtu3_32bit_ch_write(ch, RZ_MTU3_TCNTLW, count);
+	else
+		rz_mtu3_16bit_ch_write(ch, RZ_MTU3_TCNT, count);
+}
+
 static int rz_mtu3_count_read(struct counter_device *counter,
 			      struct counter_count *count, u64 *val)
 {
@@ -168,12 +187,9 @@ static int rz_mtu3_count_read(struct counter_device *counter,
 	if (ret)
 		return ret;
 
-	pm_runtime_get_sync(counter->parent);
-	if (count->id == RZ_MTU3_32_BIT_CH)
-		*val = rz_mtu3_32bit_ch_read(ch, RZ_MTU3_TCNTLW);
-	else
-		*val = rz_mtu3_16bit_ch_read(ch, RZ_MTU3_TCNT);
-	pm_runtime_put(counter->parent);
+	if (priv->count_is_enabled[count->id])
+		priv->count[count->id] = rz_mtu3_get_count(ch, count->id);
+	*val = priv->count[count->id];
 	mutex_unlock(&priv->lock);
 
 	return 0;
@@ -184,18 +200,19 @@ static int rz_mtu3_count_write(struct counter_device *counter,
 {
 	struct rz_mtu3_channel *const ch = rz_mtu3_get_ch(counter, count->id);
 	struct rz_mtu3_cnt *const priv = counter_priv(counter);
+	u32 count_val = val;
 	int ret;
 
+	if (count->id != RZ_MTU3_32_BIT_CH)
+		count_val &= U16_MAX;
+
 	ret = rz_mtu3_lock_if_counter_is_valid(counter, ch, priv, count->id);
 	if (ret)
 		return ret;
 
-	pm_runtime_get_sync(counter->parent);
-	if (count->id == RZ_MTU3_32_BIT_CH)
-		rz_mtu3_32bit_ch_write(ch, RZ_MTU3_TCNTLW, val);
-	else
-		rz_mtu3_16bit_ch_write(ch, RZ_MTU3_TCNT, val);
-	pm_runtime_put(counter->parent);
+	if (priv->count_is_enabled[count->id])
+		rz_mtu3_set_count(ch, count->id, count_val);
+	priv->count[count->id] = count_val;
 	mutex_unlock(&priv->lock);
 
 	return 0;
@@ -382,6 +399,8 @@ static void rz_mtu3_32bit_cnt_setting(struct counter_device *counter)
 
 	rz_mtu3_set_ceiling(ch1, RZ_MTU3_32_BIT_CH,
 			    priv->ceiling[RZ_MTU3_32_BIT_CH]);
+	rz_mtu3_set_count(ch1, RZ_MTU3_32_BIT_CH,
+			  priv->count[RZ_MTU3_32_BIT_CH]);
 
 	rz_mtu3_8bit_ch_write(ch1, RZ_MTU3_TIOR, RZ_MTU3_TIOR_IC_BOTH);
 
@@ -398,6 +417,7 @@ static void rz_mtu3_16bit_cnt_setting(struct counter_device *counter, int id)
 	rz_mtu3_8bit_ch_write(ch, RZ_MTU3_TMDR1, RZ_MTU3_TMDR1_PH_CNT_MODE_1);
 
 	rz_mtu3_set_ceiling(ch, id, priv->ceiling[id]);
+	rz_mtu3_set_count(ch, id, priv->count[id]);
 
 	rz_mtu3_8bit_ch_write(ch, RZ_MTU3_TIOR, RZ_MTU3_TIOR_NO_OUTPUT);
 	rz_mtu3_enable(ch);
@@ -443,6 +463,9 @@ static void rz_mtu3_terminate_counter(struct counter_device *counter, int id)
 	struct rz_mtu3_channel *const ch = rz_mtu3_get_ch(counter, id);
 	struct rz_mtu3_channel *const ch1 = rz_mtu3_get_ch(counter, 0);
 	struct rz_mtu3_channel *const ch2 = rz_mtu3_get_ch(counter, 1);
+	struct rz_mtu3_cnt *const priv = counter_priv(counter);
+
+	priv->count[id] = rz_mtu3_get_count(ch, id);
 
 	if (id == RZ_MTU3_32_BIT_CH) {
 		rz_mtu3_disable(ch2);
-- 
2.55.0
