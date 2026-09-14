Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011064.outbound.protection.outlook.com [52.101.125.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98ACA496D56;
	Mon, 14 Sep 2026 20:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789418244; cv=fail; b=W9j9b5ND+ZA7yEiI8io9JKt9OaeBqnpuHVG0ePMst9V9jys6bqRDAVtVPYLYYcRdSWVf0MTdzMRs1S3disLoejcPkky9NPAqRFeq4UDouQ2CTl3+SRC84XGbwvvvBZmWxWhTCsPP8T5uVdCnW9RF+/AgiyoavjtAw6L7zRxvvQY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789418244; c=relaxed/simple;
	bh=szhwdIqwdhjxK1i93afHCTzNimI4pvXleIOqYNVVjkg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ecEGwGhp66aizVDB0DDlvjjB+58844WXH4nFlNrq6qev7J/pmU/yXH+Vc0FcRlmYtg7a3gALASND+s00OzxLP8Ek2SBhYWUAFhkL9hgDMRvOcdgjZD+NnwbYRbh56WZJklXO607wqvyW+eOYHXLH+pnUcz4HGIZkkUhTzqiKky4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=lodGP4a+; arc=fail smtp.client-ip=52.101.125.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="lodGP4a+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PYxIw961j+PW8LeBTilX5OCY+508ZCstpl8+spQMgpvLP0zpWlKEMpXOsJz9vDi5f69EWgYM/iW0b+HHDi8DOVqO7tPeNRd7NleybtiQx6KfFHc+dyf32ZkZXeDu9791MKUrlXeqSTASST5ZOh3em0oKa+a6lcrOLYO7AG2OsUg9HyhaxW/wy86ABNFxv71L5ZiMiQF1r7E6P1ig9hZ7TIrpDdIODHzkt/NpwTTpPRe4PjdzYvtjIZ5MD1ChROEFKUQ3mX5wDqViTsC0dyQlsWxtzy7EJO1RmZuFgWT89tJ6Egv7POdh1ByG56k1vUdKfSXWfWC5W+ClKLnCZNC3dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z9pmOfM89QuSpb8Q2w6OV8BkczUt1oXm4J3mTjhANnU=;
 b=I0kL9cLwMmQxed0vhlPkccLfwLrYrm8zXLXuHnfO6dvjbX/YFWIGoPhz+kQN3DA3QvJHEHa0icd5ywAkEylpWNNAH2JnWzf8+J8AWdC3721yv+8WU4Lhy1WYnuY0ZxiQh+MUMwxB+RNxRW0EXJfzKupW1cGcKxlzCpdcay4AF54sDhhpcHbvWZckzrgiQwDbI7l+FeVDUMAxxLuOIaC2PM9XT7O66hDefDDYRFzS4Biv63eVIZCE9O6JBffdqggIMO01VPuO6yQZ0IVMbdQoSHe3jXvwX0nTh+ohpBQjtNRl6OthJ0Z1M5ncf5lUKi7lslElQVDEsgUs/rBm0PaFqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bp.renesas.com smtp.mailfrom=renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z9pmOfM89QuSpb8Q2w6OV8BkczUt1oXm4J3mTjhANnU=;
 b=lodGP4a+YEnPoFwrcL4GP13/gVjhoRavGLtTshfTwwC7EobWa8kLPNZ8F8KnC77V3tDun+Irpj75KjJMFlSEnIasJ0bkafGjaUYN6tratqfA0Ovh3V77vFFr2NGlTk1yusTOViulSnnWgONSM2pILsnTBzhE5hS/vgJurbZOpCQ=
Received: from TY4P301CA0060.JPNP301.PROD.OUTLOOK.COM (2603:1096:405:36a::10)
 by TYCPR01MB11752.jpnprd01.prod.outlook.com (2603:1096:400:38c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Mon, 14 Sep
 2026 20:37:18 +0000
Received: from TYO1EPF00005024.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:36a:cafe::66) by TY4P301CA0060.outlook.office365.com
 (2603:1096:405:36a::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.13 via Frontend Transport; Mon,
 14 Sep 2026 20:37:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.62.32.50)
 smtp.mailfrom=renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of renesas.com designates
 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 TYO1EPF00005024.mail.protection.outlook.com (10.167.240.21) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.7
 via Frontend Transport; Mon, 14 Sep 2026 20:37:18 +0000
Received: from demon-pc.localdomain (unknown [10.226.93.156])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id C35493000368;
	Tue, 15 Sep 2026 05:37:15 +0900 (JST)
From: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
To: Biju Das <biju.das.jz@bp.renesas.com>,
	William Breathitt Gray <wbg@kernel.org>,
	Lee Jones <lee@kernel.org>
Cc: linux-iio@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Subject: [PATCH 02/15] counter: rz-mtu3-cnt: do not assign struct rz_mtu3_channel::dev
Date: Mon, 14 Sep 2026 23:36:01 +0300
Message-ID: <20260914203614.2035277-3-cosmin-gabriel.tanislav.xa@renesas.com>
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
X-MS-TrafficTypeDiagnostic: TYO1EPF00005024:EE_|TYCPR01MB11752:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 1231dfac-9d2b-483a-0ef3-08df129ff840
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|23010399003|376014|36860700016|10067099003|7136999003|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	o5tqGRPsAX4ukLDt7qQWFoEBKoBEEfUVYEzLlAcQqu5C/T6MfFSXK5MVULWKuXvIPDAd6256DvMLDmfg/q3gNdXm8u8uHm0ltUSX8fL+aQfyKoYoDANhxH02m5THkqSBaU8bTbSy+fFLh61Akn+3dfk1us4hZOrolAKmgseRW5mmKyla8WQioiPJZ2qVokf1SWqPUH2sdQGQuZFbv7Y+9pIARgEwfXpDbbpNChcp/Zl5uNsYdjjnCYhjdZyKVEikxkyWbgUMLcZyearqY33tnQHRrrgbGUxdF9w1Ouxo/lL8Ssh4wXZoC5QkwwHJjvXOOC0/pUJ+aGv1LSOoMLqMg0CLDroKuWe718nV3WWwTc+p14ZERWO8Jk2GqbSBPSlqOBunKpo2pchbFjPG4w18ucGtloyB7S9+f25IexK1+3zDckGaQvtOXyvJIh4tCX73+k5YNup9/rFqZeOu4+gbzn/G74lKdLkNiuDs9BWubpFYVeoqHvYEr5TN5fd5uDrzsN1FGeU23OzP9C3fmYL91ERcniIngThI9fPAt/qPbCo9GsvjuDUHLtZujPD9c84eIp0AnzLZQzLxcELg4A+ZSVkMrpmPlMh9h47ES79IPpvG9ahqo7XBS65TwIKY677e9tJtV0RgiTF9fqushEBBoP8JuwppmhhcmUOr6CpmVSZ26LB67ZuIUlhUAca3vzV0SJbigi7DkqDh511rFRLaMg==
X-Forefront-Antispam-Report:
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(23010399003)(376014)(36860700016)(10067099003)(7136999003)(18002099003)(22082099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	OAnNXZUfOzMJqKNUOue2F42eJOTJQ4/A7KBfsRg2J8f1xAtyyarTvJgA1vYAbAT5jvLcpeHDIS07YmmjJrN3jQ5VcN5gF/AMrmxrbCgTYnu+f0/V4djaZbCoIHmakX6P+85hk3cXGMxAM7HZ5cZl2I2vMwU3CcdKlnYhgmaZ+oMfKOmITLutwjQLF23m3rGm6SrY33aMNvi9bDe34XHT/B5RnR5Rn/VWP4l56yjN/NIQwq5pK8ffnXDCIZF1NiLepvxGNWzCEI2gICSF2uRbixGjPsjm3PPPP8VUNCgXpDUNUlspVPxfKpROIe6J8DeNwZjhk6MIyAnB1P5tYH0bzLRSQTgY0mWdBSw37JqbL6b3LS8WD3WQTHiZ186wgbi893kbYd2JiOrTR8gpDKOLJlohDxlvlpIIqsrgBQtveWh68zqRGnmLlTF10l4TwLoU
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2026 20:37:18.3445
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1231dfac-9d2b-483a-0ef3-08df129ff840
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: TYO1EPF00005024.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB11752

struct rz_mtu3_channel::dev is now unused. Remove the assignment to
prepare for removing it entirely.

Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
---
 drivers/counter/rz-mtu3-cnt.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/counter/rz-mtu3-cnt.c b/drivers/counter/rz-mtu3-cnt.c
index 48f183f0b54f..4ad71ed3d1e1 100644
--- a/drivers/counter/rz-mtu3-cnt.c
+++ b/drivers/counter/rz-mtu3-cnt.c
@@ -843,7 +843,6 @@ static int rz_mtu3_cnt_probe(struct platform_device *pdev)
 	struct rz_mtu3 *ddata = dev_get_drvdata(pdev->dev.parent);
 	struct device *dev = &pdev->dev;
 	struct counter_device *counter;
-	struct rz_mtu3_channel *ch;
 	struct rz_mtu3_cnt *priv;
 	unsigned int i;
 	int ret;
@@ -856,12 +855,8 @@ static int rz_mtu3_cnt_probe(struct platform_device *pdev)
 	priv->clk = ddata->clk;
 	priv->mtu_32bit_max = U32_MAX;
 	priv->ch = &ddata->channels[RZ_MTU3_CHAN_1];
-	ch = &priv->ch[0];
-	for (i = 0; i < RZ_MTU3_MAX_HW_CNTR_CHANNELS; i++) {
-		ch->dev = dev;
+	for (i = 0; i < RZ_MTU3_MAX_HW_CNTR_CHANNELS; i++)
 		priv->mtu_16bit_max[i] = U16_MAX;
-		ch++;
-	}
 
 	mutex_init(&priv->lock);
 	platform_set_drvdata(pdev, priv->clk);
-- 
2.55.0

