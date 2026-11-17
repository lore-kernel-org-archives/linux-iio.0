Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.229.7
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794911249;
	b=q6zvgJHNSY/csZBeJopkjVDarsU5khdXflu0KDbm+H9ISjmU8HglPy0jnwtVq4xIPFl6
	 MkMi4mEz6z0xI4LYh6nhXbZo8WR5w5gYZlsdaR4a2Cyzlk90C/ceRRDToGymSYv0+dV0+
	 c831ym/Rql+t5KHMfxFMOWHWBnsIm5eVwYiAgPMiNMI3tjg5GeQsJqLpd5toagMOijrSk
	 hboYu2rmmKo9hlT/tiCY/YichQrvCshSdFFNtQYdDEnqfyM7LUb60eRbzMriFWjUDBa+z
	 uRVqRQKXCov5Ut+6d/KHlnjaSLiL75ReYP3ncecReqCusACqSvTRUELcHjXEcHFkRNA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794911249;
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
	bh=NhxiIF/Ds1Nl/Ji5UBLaKi8NYEeBja+hMwsUVYaempE=;
	b=gGMEOKrl1A5PNY8JaRbNzcvLCGZf4BqhU0vodEp9mOYWs62C1s+3AdV5Lz8GBdTBTmwH
	 RtH9jCPDAL15El48XnRkXdcOMoaY5Erk9EEb+qMi63emyqmElXv/ixzvaB9zVvyzySFcA
	 ZHf4xLqq8Afj33wPW+taH4JaqBPqeY3lZEfiofY72djoUfkbggfSGumkiAxNwaUDMC4Iq
	 5qiS4+NFdCwteP2IO/NaTdWm5kDDv47PJk6FOkBoapcqIjecMrkjq1q5eUxv0ykpMiNDO
	 U69PJtJlanASyH9dbGUO8Y/v+G9A+mxVAZpxhHgdM8dMAqNXXT/HjhmwWfCNEr/eY6Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=renesas.com;
	spf=pass smtp.mailfrom=renesas.com;
	dkim=pass header.d=renesas.com header.i=@renesas.com header.a=rsa-sha256 header.s=selector1 header.b=GNjniZMI;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.229.7
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010007.outbound.protection.outlook.com [52.101.229.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 252E6606A33B;
	Tue, 17 Nov 2026 10:27:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 252E6606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=renesas.com header.i=@renesas.com header.a=rsa-sha256 header.s=selector1 header.b=GNjniZMI
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P3irI3H79ZNljqdSBMz9MxvhIFWWOdCdXXZm67+GunBFOeep6epQC3fV5Yg367rt8RQc4UBh2Kt/rEy8FkNhnodco0F0gZXOW0oFnCdg0Kt3vQHRrzHdhdEoHw6mxjXM8UNNuVMkNumjllCkbbJjn2IBXa2lbU2jsGh81joEq+WwO4wnXnoTPydyW/GAvhWpL5qh+7VrDBwy7FfAA1VULt4n+RzUaoUmlw/SwjImbCGRFoIrTnzkPi4THYbJ5Fot3z1afa5OWnFoKjaxj0UnopiKUnzVkSPtqCXV2sRXrTEAaDIIzeTl5oH8V6XjeikkYhmIqVcAVY7BgMOUfnj5mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NhxiIF/Ds1Nl/Ji5UBLaKi8NYEeBja+hMwsUVYaempE=;
 b=vpPl9RYI32iIaRRp8JYXoSJb2U9Ai3PCJS+8Oxt4Ot2h0EPiULlVmpRUPUaCtl3VBs+C5N7gftWc17EjdqV3r3P/ZRzheD1BkhfnV+sprFG0mInarttY3mOHsB9bzwSL19Wib1o29NdCERRsQHVuSGIA8k5oByKkzX+IkCCujoD+zTztHUn6Jbe6EqlH1V1J52VfTiyhx6RFxhfKwYNxLRCMEYnIr/aolCdB6r8b62ZIMZOvGYu8KX9R3ahS/qnOL07dt5Tz7NO6G7DRT0/3lQEAwZ9k2qZ0/4NR9h6Zo19cpSco4Jl6Vdn6xzioRHBDNLeJ8iurUC02TmtILu5Wag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bp.renesas.com smtp.mailfrom=renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NhxiIF/Ds1Nl/Ji5UBLaKi8NYEeBja+hMwsUVYaempE=;
 b=GNjniZMIQrZOeznDUZMbUhj0AD0oYUc4B+bKk+QosNV5wmc9JP22Zm6AsxVBFL4LGsYl/dtFNWv91Tk73yNB0WYGQf7bK84SSlaaqUlyHLTvooqEzEZaGTVEbXTFUAZBYKBRuF1rFcT0XrDW4z6WkJTvauFu+SRuEkOhquRbkI0=
Received: from TYWPR01CA0029.jpnprd01.prod.outlook.com (2603:1096:400:aa::16)
 by TY3PR01MB10417.jpnprd01.prod.outlook.com (2603:1096:400:255::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 10:27:24 +0000
Received: from TY1PEPF00046B4E.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:aa:cafe::1e) by TYWPR01CA0029.outlook.office365.com
 (2603:1096:400:aa::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.10 via Frontend Transport; Tue,
 17 Nov 2026 10:27:24 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 8.62.32.50) smtp.mailfrom=renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of renesas.com designates
 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay005p.adwin.renesas.com; pr=E
Received: from ejcrelay005p.adwin.renesas.com (8.62.32.50) by
 TY1PEPF00046B4E.mail.protection.outlook.com (10.167.253.38) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.4
 via Frontend Transport; Tue, 17 Nov 2026 10:27:24 +0000
Received: from demon-pc.tailc3dc73.ts.net (DEU-5CG5050QD0.adwin.renesas.com [10.226.92.253])
	by ejcrelay005p.adwin.renesas.com (Postfix) with ESMTP id 66F913000255;
	Tue, 17 Nov 2026 19:27:22 +0900 (JST)
From: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
To: Biju Das <biju.das.jz@bp.renesas.com>,
	William Breathitt Gray <wbg@kernel.org>
Cc: linux-iio@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Subject: [PATCH v3 04/14] counter: rz-mtu3-cnt: read enable value from cache
Date: Tue, 17 Nov 2026 12:25:57 +0200
Message-ID: <20261117102607.2504551-5-cosmin-gabriel.tanislav.xa@renesas.com>
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
X-MS-TrafficTypeDiagnostic: TY1PEPF00046B4E:EE_|TY3PR01MB10417:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 8c777d1a-0a87-4ea5-446b-08df44955f02
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|1800799024|36860700016|82310400026|11063799006|56012099006|261026140227099003|261028144727099003|10067099003|261021123027099003|261021121427099003|261022105027099003|261102123227099003|261009223027099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	bPnPHvymRMrhv/TOEjP8v0oyeHSl39F60OlvVR4YAi79QEw57yWwjGxAnoXUVdFFeiQ6cZty4AjK+UdzhoTRm9ulF/bSk4juaiFKCrR6xzGAEJsMyD7tej+WtEbiaNGXMXmjVqfkZkTrrIQyb1UM+EW1ot1tQx19p/iUd1+pgpm+OkYBPOAhYdJQq4h2T0UjZ5XByrT2liCAYCyITS0C3wCpkQelY9DD9+BQr+ABsIFkwkj5XIHQwIph5Fb6g3X1enXPyMmtymqoH4oPOrtzMaGnV+jJBngtii8Yo8/ZZb4EMQN+kKAfyNSXGVVaM7Sy1HbkORDMZAS9c0GFhEX4OLEKhESWfFO9yv3EbVJrdxmC98ceg429DgLF8M6Iwbhc4BFStOFUHKJmeVnUT6HnXpMW6p9O9K2YM6LdM7YxiMk0aiU5KwdAwAm9luBnJTuYbY3JAsf118UI0jY8dTaf085wNqtyMLk1E3nhAIsbJFFIVWedoyrhK1bkCDHSbjCqs7fRYu5YfZ4TlZ3Rdn0o5M17Xtoq+7t0AVlJ8dXa0rCcTC8ksSdywTCgVjQsgjdTqgU8+p4zYyx/yotyPq84lV+U1hDK018/MEfUmdPtu04H+ITgwE6T0J7RUR2eGez/aYO0h+tD5lGV5pCrFY+Lp5od1V3hK23vkYtkFi/P9ayx1hG+hYG+xDYKeZialQUUkfjXkvFCtiX+0pDmUZ7fIw==
X-Forefront-Antispam-Report:
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay005p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(36860700016)(82310400026)(11063799006)(56012099006)(261026140227099003)(261028144727099003)(10067099003)(261021123027099003)(261021121427099003)(261022105027099003)(261102123227099003)(261009223027099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	GE4/8aniOrbfvdYknsLrBwFDPrgN28RkQaD7hh3FycC6E/wqkJ2FZ3GAyS8jqtyvUSmk/I/lfynX0LalZq3pUW6obg6EQqm7mE61n1g3CcS0VmLNwtZYC7z9zTAw4aspcYlavZxw+6Ike56courknW3o5sFwCjMTHj5FdNKWx90TczA1C+2z4qL3+UMnCHbVHDD0t16P1tGc2yZnJSXZMKVbR1OQbal84vsYLyhGiJ9jsC9uEsXePkmVPi0V7FEyTLERIeJpvDZHOUTzzM4uXqh21R2/4VgMPCYlbg/SXjKEulzgUy5Ci8+kZn9HKwi3WTmwZ1eRhMpdGWJIAdYakXiqrPfC98zGhq1uVlumGPl2gfdLE68Ic6SUyyPc+vZ79+AZH9QnB+Gsq2EaDt9MaDwgtZWwCODwhjLIorSGmBeIbg8ZHXeu/oCM1SNM8aX0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 10:27:24.4177
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c777d1a-0a87-4ea5-446b-08df44955f02
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay005p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: TY1PEPF00046B4E.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB10417

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

V3:
 * no changes

V2:
 * no changes

 drivers/counter/rz-mtu3-cnt.c | 15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

diff --git a/drivers/counter/rz-mtu3-cnt.c b/drivers/counter/rz-mtu3-cnt.c
index b1848a0b17e5..db30470215c2 100644
--- a/drivers/counter/rz-mtu3-cnt.c
+++ b/drivers/counter/rz-mtu3-cnt.c
@@ -469,21 +469,10 @@ static void rz_mtu3_terminate_counter(struct counter_device *counter, int id)
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
2.56.0
