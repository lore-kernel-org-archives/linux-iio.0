Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011048.outbound.protection.outlook.com [40.107.74.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BB6E3A1CEA;
	Mon, 14 Sep 2026 20:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789418263; cv=fail; b=T+7aJ36fII/VfSCEOGQbq4hz0KnB7WBRgrmE4USYa/YJV2TTS/J0LSU/09uKyFj+rfcU1pkwqMDNkdHhhtcad7eat8IHwiHD5176IDL0XNk6atHVyhQ/J5EewQG1zrZq2Hhvsxnwvge1ZpgFzmkNf6wPt+6owRhKRuHcqH/Mwys=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789418263; c=relaxed/simple;
	bh=dlJ/mExUJj4LM9bvLDELRiwn3YXhkz2Cjrnz6G/Xs+c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=up/9j3r6CjZGJbbXsn7sv+yqluRfNL/5t5Y9/o8ENbJp1cFr8V6zJGRMdAFebujQLC0tdI/qGeWGQzDw8d93Qc3k4K8EebFqGSK+5Z4lVAlaudEDbqaeNUGbDlWMA7sWx6zJEst3nWULGqaF0hFP6ZPDqUjYFQ717K48GVvkuWs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=Qtf0D8W0; arc=fail smtp.client-ip=40.107.74.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="Qtf0D8W0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SLNszU1wA1tp85bJqDbXzHPiOlmSckyWWqm51aHe1WUdGFEMX0vuspnqcnnvoH6JWFhETBgAX39Oh/TyU1EcRU3lRkJZJ4ZM83P1e9hUsTGW6cCU8JzHS9RU4DIlLfVbY1jsg/6dLL3H9jhClaMribghR+g4PDetGR+vua4A/lRftfm0tL4ywXg/1OS0K4H2dIDt3osFZWVn07SKmXlU5neKiVZHN4KPdKBYpPp7aRMGi4qR6Xtw8ZVhCPYICRHbf2PCU1kxSzwtmOtskmlYbLzFkJQknXZMpF6z1SIW+uQQKpuXLWe9h9BKxXDgc8k+IlA/46q8Tv8qmrkJWUYOiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kPrZplhIVevFmiVTHq6dGBV6/XXyPf2//UpBtOElU8E=;
 b=zNtH2bAxStoMHvf3aSWCA81lLYFodCMSn4qmKpOjK6TNvS6yujLnr1OxBNfI0PY0mX9sooJ3Wl3agBfsAw8OY1MiGaNg86qcYzfJoHx0ICjCktWz7u/WDj67BwjeGu8wf8x2XtBIPrrhBf1ydflHcvxWz/9zew5OY7QFqyUBh8JvLZyTMfjPGSuEQsWnMUxdBGg4rlTzo2eV0HmyycrTP5Mdek7T8hlPPH/3GyTpexDYddZ9PfXkHbhIYRDqbLBcx7AINjJs0AuL7SDweiEf0QCLBOv4ZCYDMXtCKivyA827jOUN4sKnram2RMT02obFd+q9ImqBwrnZf+La2v53og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bp.renesas.com smtp.mailfrom=renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kPrZplhIVevFmiVTHq6dGBV6/XXyPf2//UpBtOElU8E=;
 b=Qtf0D8W0LolqLtjB+eNzp2/bKtIK0xyqdSRlP6A2ps4/gqy/jlvsuAQ86hxHs/0AGmTh1dbkuV0E9PioElBP1A6Fxwmonq57o8E6tkPOVu9S7yFdYeJSpAuzW3sIJMPQdw0k4K6hKRYQAFHNg5cj2cofepoH2z62U+bZPDRpoZ0=
Received: from OS7PR01CA0274.jpnprd01.prod.outlook.com (2603:1096:604:259::18)
 by TYWPR01MB10259.jpnprd01.prod.outlook.com (2603:1096:400:1d4::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Mon, 14 Sep
 2026 20:37:36 +0000
Received: from OS3PEPF0000003D.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:259:cafe::a7) by OS7PR01CA0274.outlook.office365.com
 (2603:1096:604:259::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.12 via Frontend Transport; Mon,
 14 Sep 2026 20:37:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.62.32.50)
 smtp.mailfrom=renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of renesas.com designates
 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 OS3PEPF0000003D.mail.protection.outlook.com (10.167.240.6) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.7
 via Frontend Transport; Mon, 14 Sep 2026 20:37:36 +0000
Received: from demon-pc.localdomain (unknown [10.226.93.156])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id 0B70F3000368;
	Tue, 15 Sep 2026 05:37:33 +0900 (JST)
From: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
To: Biju Das <biju.das.jz@bp.renesas.com>,
	William Breathitt Gray <wbg@kernel.org>,
	Lee Jones <lee@kernel.org>
Cc: linux-iio@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Subject: [PATCH 05/15] counter: rz-mtu3-cnt: read enable value from cache
Date: Mon, 14 Sep 2026 23:36:04 +0300
Message-ID: <20260914203614.2035277-6-cosmin-gabriel.tanislav.xa@renesas.com>
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
X-MS-TrafficTypeDiagnostic: OS3PEPF0000003D:EE_|TYWPR01MB10259:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 225a665d-64f7-41c6-4b72-08df12a0031d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|23010399003|376014|36860700016|10067099003|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	rW19W/hqvfnPIJsRaKx+3deTjuPtochGkQZSaA6VQ9Xpifx244d8iS4/Fyti7YHkUCzvzaJkBLbG80f2QfDunaEuY9AkpxvzAfbVEqxMh9rikIkl36pwcUqv4o1BFFmBFJP0U45QQLmrQtgINJBGkKuHoo3W/h6ayhZTB3YI46lhMr5HFEjZxhKmEi+gcoLdB9C41qlA+sUtGGBcDTGEmXUFPtitFIlKW+o/vPyvTxnMSitm5rKytrqyg/ro96nMWdSaIQRsmIT4zx2bJjMdarzs6X7gCoQBoiwUU7V1vFc0A1ZksH+5UPmd6IIL1/1jhArroQhp6KJ7L9Vl8FOwCkLkxuuieWpsR/gqml6xwn1PKhHVmS61z5WEirpZlnIQa4LAHeD3u4nFmAeN3QBz/8JvoWmEIpRxLvqEa0RcerA/75zqDqE3o7TiCrdpmU05Yb8W9jHm74N3b0kO6TL3GS7VEeJEi5w2KmT7rpAk51qktjnFsoG+5j3cL3apUpb4uplEC+v8EnKp158X97BTQsJn6HAfK7Iq11yOIkguijuKo0qVSEUtDOffi/QL7zWLQV2J8dgJYMHlH82lRjvm8dhfhSPlPfQzmocLtv54KT3uVNAFeRUij/FhhYtuMasY1vnsN8uuiBOsqjXp33t8ykD81kksLJMLI1UmsIlF5+0uGRZ+PXyxzv+iO6J+wjnFf77ZcpIwLhzQee40BieM3Q==
X-Forefront-Antispam-Report:
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(23010399003)(376014)(36860700016)(10067099003)(18002099003)(22082099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	9thXiCyw2nTUWY3WV3KIO8FOFFzIeOtGoBLvC/JnOxO0++OJwllfhWBgeTz/4bS3kXeFL14AkP5d5pus9yaVCas7CODuRPHY40huD2JSYq/SmQAbeP/GkTZeuDV/NU/rXzBARcbd3XeOpPIlF3xUkLKLr0gHGJXdVAvH8WUOgZnnzBcmKSmFiZuXHkGS4lVXJWuQ8z4pYM34TH4qijy8+cE95OqCX8U8xxFg6Z+N2PWyx0qyIqegTvXfpHc2EEOdmGK5+Jvph2ORy8sGBdVScKad++vCUvS96BBu/h8OMNx42RKtpr0Xc6IzSmAD1iIv8VEaMiKVIds14zfvelR774FHlfXtUvNhOVJA/ObyN2qmFOQu9W9JPt259N2dpFcTdHsNtQEbkx2cbmuryOFM004UdROXblN6gKT6HK31EvrzHjUARiLRRoNfl5YPy5Qh
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2026 20:37:36.5594
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 225a665d-64f7-41c6-4b72-08df12a0031d
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: OS3PEPF0000003D.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB10259

Reading the enable value when PWM is in use returns -EINVAL because of
the checks inside rz_mtu3_lock_if_count_is_enabled(). Reading the enable
value should not be an issue even if PWM on that specific MTU channel is
enabled.

There is no need to check whether the underlying MTU3 channel is enabled
when determining whether a count is enabled, as we have a local
count_is_enabled array containing exactly that information, which cannot
be wrong.

Use the information in the local count_is_enabled array and allow
reading it even if PWM is in use.

Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
---
 drivers/counter/rz-mtu3-cnt.c | 15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

diff --git a/drivers/counter/rz-mtu3-cnt.c b/drivers/counter/rz-mtu3-cnt.c
index b99dd67703df..d3daf258a3b8 100644
--- a/drivers/counter/rz-mtu3-cnt.c
+++ b/drivers/counter/rz-mtu3-cnt.c
@@ -471,21 +471,10 @@ static void rz_mtu3_terminate_counter(struct counter_device *counter, int id)
 static int rz_mtu3_count_enable_read(struct counter_device *counter,
 				     struct counter_count *count, u8 *enable)
 {
-	struct rz_mtu3_channel *const ch = rz_mtu3_get_ch(counter, count->id);
-	struct rz_mtu3_channel *const ch1 = rz_mtu3_get_ch(counter, 0);
-	struct rz_mtu3_channel *const ch2 = rz_mtu3_get_ch(counter, 1);
 	struct rz_mtu3_cnt *const priv = counter_priv(counter);
-	int ret;
-
-	ret = rz_mtu3_lock_if_count_is_enabled(ch, priv, count->id);
-	if (ret)
-		return ret;
-
-	if (count->id == RZ_MTU3_32_BIT_CH)
-		*enable = rz_mtu3_is_enabled(ch1) && rz_mtu3_is_enabled(ch2);
-	else
-		*enable = rz_mtu3_is_enabled(ch);
 
+	mutex_lock(&priv->lock);
+	*enable = priv->count_is_enabled[count->id];
 	mutex_unlock(&priv->lock);
 
 	return 0;
-- 
2.55.0

