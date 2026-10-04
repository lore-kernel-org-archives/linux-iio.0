Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010051.outbound.protection.outlook.com [52.101.228.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FBA04749C6;
	Sun,  4 Oct 2026 17:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791136164; cv=fail; b=F4rGfauzIj9ua1DECpBogeXrgWftSxrt8SAMP6G5UNstTvk1JdFIbJsdwU5bwZvuQ9V6GbeWWoqU8G3sInrIbVLcVjUjcNh2NIdXMLD1GX+26c/qyCMCyoR/MeUm+Olwg8OmITnmCd4ba/eQk1GitN5InoXDgjGvOm4VJ8TGAaQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791136164; c=relaxed/simple;
	bh=CN7enXeXS2b4Gwsg8NreUzaNQpwADfnD9XjvgR7vHVk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZLeR2FjCvm1BGxuN4N1Zhz5CNHtWn0KbOO5KjNeFh5Wddm7KX9OR2ba87sJFRo0p3IES84oGUOnby7zTYct2jKxIkM6Uy2kQeGMqlvW2+2Xfr/cKSmSpm1Zb2qYYRdoMdZrBWWCzrWPGYkGELj/IjEHxgtxxGW7u7lxN/A3RNbI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=Rs2KbvVS; arc=fail smtp.client-ip=52.101.228.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="Rs2KbvVS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nzwedj/WJSwLROPmxOYSTWSojUYYnCK88JrM1WJntfYdxPixIx258kj8w1dT3XqRQ+mCfIgpYgU8za0t7/qaJ/GQs2hvBvNb5IfpYlVo1T0xCLlhsTqTlB7uDsLHU6XTGqXOuwTBYPpyconeEyab/YBr3XL4qrzdpZSdgU8UDFCcCjNCMJXsvmbbEGW6qYpxT2kPrSiA7L35ba+7jOyPYxqmZvnQRJtw8ziVvEnat8/bRlj4fXfpGfpXEXKDBT3EDH3wZ5GCPvsydBc8x+18XX2rwkeERLPMaFnUeXLmq4u+AcR/Ve5lTdoqfdlveZbA4PhwOPjNtSyMpOFCXsaIkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jHdcJHKaiHBjVZePRA/+oo/knRT5sJ/FxAiyZYOku8U=;
 b=XMowYFDODutr3aR+mC+kA6f4oHeWoRIgvhfSsGBOJZxI9+F4Zv/+Ii6hhSGVHzaOkLSMs3uo2WOz2cC34A5jaC1rkvvlDuByB0Iwmh9QrUQlBXS/gg3PoouNopoNOZl4s9oOfZNKxGnbVcOFLb7YsV9Jsn1pgUo56LZOkW5mI1XV2uYJnzJ9CH6jLCNnw30ZePWTm7B78dNK/3A5osK1B4kd34ZMTO9zhFS3GOVcEEs2YTJUvrlc3Lrto0y/5vrFz2Bq5c/3Wu2/uqbkei78e7dWtYbogKJoncksJRzf6mAcqW/Q0T1ArUowyXT1/Tj1U92RU8BvNCV57Q8jmP6WOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bp.renesas.com smtp.mailfrom=renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jHdcJHKaiHBjVZePRA/+oo/knRT5sJ/FxAiyZYOku8U=;
 b=Rs2KbvVSzoNi5XqJ21OasCZlZ0i1IaXOgZOAOCkLHW+kmU75BhqDSOt5/NDiN3rTShsAzmnV9c0AO/VL8wpudJuAbnjo+p1JXBdZX+lFkADRwoUyaPUtnq+ej9iTrcpUgc2Ya0gpnGPv78450MY9kqdrS0tE1+p4MW5dxYC5GQk=
Received: from TY6PR01CA0032.jpnprd01.prod.outlook.com (2603:1096:405:3bd::8)
 by TYCPR01MB11024.jpnprd01.prod.outlook.com (2603:1096:400:3a5::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Sun, 4 Oct
 2026 17:49:12 +0000
Received: from TYO1EPF00005026.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:3bd:cafe::f) by TY6PR01CA0032.outlook.office365.com
 (2603:1096:405:3bd::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Sun, 4
 Oct 2026 17:49:12 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 8.62.32.50) smtp.mailfrom=renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of renesas.com designates
 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 TYO1EPF00005026.mail.protection.outlook.com (10.167.240.23) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.14
 via Frontend Transport; Sun, 4 Oct 2026 17:49:12 +0000
Received: from demon-pc (unknown [10.226.92.36])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id 6635C3000253;
	Mon,  5 Oct 2026 02:49:10 +0900 (JST)
From: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
To: Biju Das <biju.das.jz@bp.renesas.com>,
	William Breathitt Gray <wbg@kernel.org>
Cc: linux-iio@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Subject: [PATCH v2 07/15] counter: rz-mtu3-cnt: unify ceiling values
Date: Sun,  4 Oct 2026 20:47:44 +0300
Message-ID: <20261004174752.507499-8-cosmin-gabriel.tanislav.xa@renesas.com>
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
X-MS-TrafficTypeDiagnostic: TYO1EPF00005026:EE_|TYCPR01MB11024:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 990534f5-9c3a-422b-b309-08df223fccda
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|23010399003|36860700016|1800799024|10067099003|56012099006|6133799003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	SSAv9rvH5Kf0lfPcWCAZ9jTcB6sxMWoUUsoQja76nU3dQyv7Rthps1zJLOvPB3AE4rQQamyVO1h2RwnpehQMSEeZXFk5S/O9PUI1/G9lozjfkFPlo2mxPDoAdw9v20X1R60Eh0VeJry7xD2e/8DxBVZpCUSS3glZuTi9DhGCPYM+rHS28HzjuPjNKxAVM8Ac7KRgBZ8WK8enKGTkHVwBcrMph1jAiEOLa80fe2qGbA7qx2uAbD9HdzN90FkDKCXx0zSy596cwrH7DUYC+pAosRvGLN6UfTdu2YhiO6H+EbQA17SR61O4IyeVA913myqRUvWJKj1H2jdvRyKwEwmavVdZasWUsoECN55tCeiQbXolycl+0TVrANNIkT7ZU5FovAtZqqGLU5ukxD2ACPxq2ZNXnP/oolFHS7EBs5ypXTnykmfv3gSWPQZ9DpjjfyzSqxHrga1QCh7Gh8MeD5Nsd4TqURfsjms9t5rwcjDdYl/aYKblnAPjYfH8NJn1XJmA5r5+2jrfnQcPMbD6PTYRHhJMkIBFEHTPUDE0wk5MGL+/8e9pUrPwMT1DFIv9gJixtWhp8yH1uSBzIP41J9Y2FCuXegcijhnGZ1TsRu1WTXJ9SPfspeJHwa0bpCg9ZsXA+BrDo/floTcZNs7zObJO2N1wSvrEn5pCSrwXR4EMEfXBsh82OwYLHrh0Uy+4yQtRlSp+oJdfgq4heiq9xv4HDA==
X-Forefront-Antispam-Report:
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(23010399003)(36860700016)(1800799024)(10067099003)(56012099006)(6133799003)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	6g9ytkRpxl5cgPNQ5LThCnmNey5Z1mYP0QH0eaPiz17JNhxF9cquJTB6KqPGZowr73jQ/sDxZueZGnICfTwXEMbL/4opGh40fbS7uBu7mbtlR5huoczUQjaNsEz8kzjhWJd1Pqid64L2DOIDQkQtjPe2AizGi3zcCKBqSmED58vuqWYJQslYMnY0BZdExH6L+tKCxKuNaX1IFLBUf5f/r+KVxdOCzli/qWE6CNxlj1RgB7qqmhljMyo9/xzn3AoqgGWdk16sZ7iujVa58a5XnntExXVKajrafoHITGYUClVJj4AU/m/jfOYaqN74+rMUvw8Mwq+H1b2DA9sv286voJ8s9BKuGsBSNZiMvWsOHtiEhv32If08wsxWeQNTUysbmS+DKGvu6oXFQv5XYPzelzKz+t9CbPl7+10wfRb2GNHwIqePO9xiRDZ/yLBAAbyz
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2026 17:49:12.4571
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 990534f5-9c3a-422b-b309-08df223fccda
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: TYO1EPF00005026.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB11024

Writing to the 32-bit ceiling value clobbers the 16-bit ceiling values
as both are stored in a union. This was probably done to save a few
bytes of memory, but that memory is then wasted on code to handle the
two separate variables.

Move them out of the union and use a single u32 array to hold ceiling
values for all channels to simplify the code.

Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
---

V2:
 * fix struct rz_mtu3_cnt::ceiling documentation
 * remove now-unused RZ_MTU3_MAX_HW_CNTR_CHANNELS macro

 drivers/counter/rz-mtu3-cnt.c | 36 +++++++----------------------------
 1 file changed, 7 insertions(+), 29 deletions(-)

diff --git a/drivers/counter/rz-mtu3-cnt.c b/drivers/counter/rz-mtu3-cnt.c
index f3c4d857674f..dcc16f23f94e 100644
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
 
@@ -800,7 +779,6 @@ static int rz_mtu3_cnt_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct counter_device *counter;
 	struct rz_mtu3_cnt *priv;
-	unsigned int i;
 	int ret;
 
 	counter = devm_counter_alloc(dev, sizeof(*priv));
@@ -808,10 +786,10 @@ static int rz_mtu3_cnt_probe(struct platform_device *pdev)
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
2.55.0
