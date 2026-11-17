Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.125.71
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794911241;
	b=ulmhzA5yW0uDekwF9057Fm3S0NhL58Vur32RS2oPhCyo9GxbIlWR9GlolEOMK1jB0Ndf
	 1W8xa9IQX54aF8AYEQN9lIxYVfVolJPvEQPnUgmYBO5zO9YiN+W8PStGvGX2E5lh2mfpi
	 yXkmG1FA9WmX8CFyBOM1QL2pwcGD0zQUtXexXe2ngGmuys0iIj6CpMHQF+//Q/PpyxXcl
	 vO/xm7qYtMjdKXcxgWu4ySa5a1Y1oBjuXv8YQXvx9Zfg/Q5OUf0ylYYcT1qcwO2WqA2Bl
	 52+epdiKMPCABBk8iH2o6sVl+rcL7xGvxsWW7WUU8cOiSXKPG7Kw9s2u7r7Zc1DkHbA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794911241;
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
	bh=fwBgTb9Skzdjj9HHR3s7+GWkcOFYWGpZVMfH9/wCEo8=;
	b=Qly95d+CFBCXPNeMkPYv5yXoWbyFco+yXHIXypCIo350yfdSnJVT+s5i7kfUY3jFeVf5
	 ujDIa71Qht+vbJwV+pHEZRjFsjye3/kOWFTGrK7OqjKNInxRpA5aB1tUwGa1Ojx0U5jKe
	 H8KEX6aYSKfdifW+NNpsTaD+mT9TPv310gN/6pVzTcRj6Xv4boX9y66tuv1vOWlG4b5hd
	 +zCW3oNVAR0VonA8X60boon/JmPc/wQ7L+WhEtvWAXO7ylTaaZS39F/QQijrndUk3IdB/
	 p17RT5suPi/w7un3l4jZX2Gls2lNxK5k1oBovQq+vieOLAsFOYqGmNGYNAT6tK/iMEQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=renesas.com;
	spf=pass smtp.mailfrom=renesas.com;
	dkim=pass header.d=renesas.com header.i=@renesas.com header.a=rsa-sha256 header.s=selector1 header.b="D3E/89Qr";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.125.71
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011071.outbound.protection.outlook.com [52.101.125.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26599606A331;
	Tue, 17 Nov 2026 10:27:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 26599606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=renesas.com header.i=@renesas.com header.a=rsa-sha256 header.s=selector1 header.b=D3E/89Qr
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UOs3ayfnxgH9yhNDzsU7WRkxxNSZtZJM+6Kp0KWYlisYJO6P9P9MJWZ2UR5lWHiuaeL6w8cy1x4QXbTPWqqqqNFUuiT2srmBvQ2UZhpQ4jUMoKMQHvhQta992XvdfjADScvrNCJndxmODWvDtTTtpQ6EprLs6z88U5F7rGxNQO8tHkqNPZm2rIeXYJuD4F5NYoasy/lkjdahAm6bEI4yWE9UqAiUdwLzhLB5IKUVPpnGlYPMU73KJIpgZTgRthhzhOWYK3aT9yL7/RGw3oGX3rI3n6VkgYCtvDU0SnwJ92+JkOwBZ5JmoM1FH7tY6UPRFVWyaVCaTWy+aDCfwRWOsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fwBgTb9Skzdjj9HHR3s7+GWkcOFYWGpZVMfH9/wCEo8=;
 b=UF6Gjy2MvNnuGxPO7qrXWR2W2AK1tvkxD+jOzRlPtJrhabttCdOz1tPG+a7zphm89QTjlb/1ji07FqDw7UNSfjBIRN36fhtUb/FzRd9cHmsMeEwVRKVu2evcEyQ4VXP4mgcLWhT+KkUUIdW7erglBYX6oOBLY34DLwZC63hFnrCGdK4paXnJkcnBBlS3kmVwlB4zuy3aTOx5H10T5MLGurIeIUwQjkKjtwgFT0bo/SRRe8UlD4FGUE8AYwj13trzFsfJHF8H4k7tZKBjqBOKkEZ7JCxV9HHl32yWpktFLZ2boa3Dzs7ON0b1HvsWdPqKyLeGC2dnm9s09W7l0TESqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bp.renesas.com smtp.mailfrom=renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fwBgTb9Skzdjj9HHR3s7+GWkcOFYWGpZVMfH9/wCEo8=;
 b=D3E/89QrVA2K5hDIPkRRuBCqzxR/M48irzXSWFyiN9iU+XPswt+56jZYKzTxGmSWVlIZ9dPLY5R27Mq1HfoRu6qU+JLqIhQqb5ZzgXgeyC6cZEQmoHinTGsNm3tkYPYXUs1rFHbE3H6HFoG/vCEhU/aLG3xR7sEGMhN4HzFGUeE=
Received: from TYCP301CA0042.JPNP301.PROD.OUTLOOK.COM (2603:1096:400:380::10)
 by TY3PR01MB10485.jpnprd01.prod.outlook.com (2603:1096:400:311::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 10:27:15 +0000
Received: from TYO1EPF00005022.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:380:cafe::3c) by TYCP301CA0042.outlook.office365.com
 (2603:1096:400:380::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.13 via Frontend Transport; Tue,
 17 Nov 2026 10:27:15 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 8.62.32.50) smtp.mailfrom=renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of renesas.com designates
 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay005p.adwin.renesas.com; pr=E
Received: from ejcrelay005p.adwin.renesas.com (8.62.32.50) by
 TYO1EPF00005022.mail.protection.outlook.com (10.167.240.7) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.4
 via Frontend Transport; Tue, 17 Nov 2026 10:27:15 +0000
Received: from demon-pc.tailc3dc73.ts.net (DEU-5CG5050QD0.adwin.renesas.com [10.226.92.253])
	by ejcrelay005p.adwin.renesas.com (Postfix) with ESMTP id A063B3000255;
	Tue, 17 Nov 2026 19:27:13 +0900 (JST)
From: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
To: Biju Das <biju.das.jz@bp.renesas.com>,
	William Breathitt Gray <wbg@kernel.org>
Cc: linux-iio@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Subject: [PATCH v3 01/14] counter: rz-mtu3-cnt: do not assign struct rz_mtu3_channel::dev
Date: Tue, 17 Nov 2026 12:25:54 +0200
Message-ID: <20261117102607.2504551-2-cosmin-gabriel.tanislav.xa@renesas.com>
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
X-MS-TrafficTypeDiagnostic: TYO1EPF00005022:EE_|TY3PR01MB10485:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 17701114-f45f-40dc-1fb7-08df449559c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|36860700016|376014|82310400026|10067099003|11063799006|56012099006|261021123027099003|261021121427099003|261102123227099003|261009223027099003|7136999003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	jh3uOJfreZIGMXRf+6uadVN7R1nsHZxv5G60UxEF90XFZHjpSY+WP5DOnnc/b1RNCcuUHDrpvg6nDH65aYUTQSw+lgGjQWk2R9iMMdcIwREtaVmndgXgx1jy0JJMCzmYS8edPp3wWLqpv0ecTW6Qz+hk1wvmEaiFYSJdWYPzRmebZbnni+iqi7mpGKGJ0IEfPFTXJzjtIjPdFKxUhO7EntS2JNH0J0wj3p19U9apamw7Be/jLzBA35USkEP0J+YuLrPcALbbEJburfu/SDZKNE0ZZgScJlQ7nC6RuA3HQmVRA3TfD+Dmqw6PH7CdG2D9cA4Q5DkNbmjR/JpUO8hSxKyGAtRmLRt+6HFBJk5UX7tEAFS6msIgJHUjpRCt/znebo0OEP0CWOcvsGOG1CFMatn1VQbVjx6Ie5nou+N/tdLSKnjSYFZq3BWZYhWWD9QXyR1hTO7hYTM4YEqAjYS/0biqMYUkRnp1KAF4sIBfghYtw3qNfEqz5Rsl0GN97Rg62H/XzRHV74FWlGIjDpbOT/XfyPR5nDP0pqXh0hl8OtyXymFx//Vo9YWwr9VN0i06meFMbjgmig34HQlG8JTYGZgLcfFjGhMLK6aLrpGWJvIje0SSvetcDD5r1s3JRK4uwJ73gwqso/IfqvT/WHNKcfj8hmrwHTaDI0B8m6+W/SlVm7lQ4duD3wgwqwLlYPsyCsbMCOSQGPnfC7XNcvDGZQ==
X-Forefront-Antispam-Report:
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay005p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(36860700016)(376014)(82310400026)(10067099003)(11063799006)(56012099006)(261021123027099003)(261021121427099003)(261102123227099003)(261009223027099003)(7136999003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	oJpsWS7TmwFUcEKLp9Dcl3kMlavVQJtxWidHRhzOMbkppKe9DDOqmEm1UB4FLU472QBpw8OvUeTo3mga9Jnmj0pRjMAat2a7BWdLS/5GyHHPrvouN7885Cwr3tLTS7to3NhKDaQ8TuG+40yZN+R0pObMH3RFuahws+8IZwnhfp2mOjSVweJ85oC8YoODMGhXWBXW0rDk88vfesXSkF/Pr1/4eS7LnEkWrLvA/MSTeE9K62BZ+J0fyCbh1iFfxkav98GY9WNmbLElP30yFiaCrtciSdCtusKytHpT9j+PbkJHuVVqZvkpfjF8eIlHvOnqn9rTY+432CmdPllvkpCXx9exXkhY3hZIHdJELvcHN92HUjdFta0rSkSDbxnrx87XgmSRYH1RF6VuFKJ0MLq3DBoj/sRvUH4YtM55fxYC/cj9/kQ+iFeoeUTN/TTtbZMg
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 10:27:15.6219
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 17701114-f45f-40dc-1fb7-08df449559c4
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay005p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: TYO1EPF00005022.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB10485

struct rz_mtu3_channel::dev is now unused. Remove the assignment to
prepare for removing it entirely.

Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
---

V3:
 * no changes

V2:
 * no changes

 drivers/counter/rz-mtu3-cnt.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/counter/rz-mtu3-cnt.c b/drivers/counter/rz-mtu3-cnt.c
index e7fe8bf45164..bafb8ef82afb 100644
--- a/drivers/counter/rz-mtu3-cnt.c
+++ b/drivers/counter/rz-mtu3-cnt.c
@@ -842,7 +842,6 @@ static int rz_mtu3_cnt_probe(struct platform_device *pdev)
 	struct rz_mtu3 *ddata = dev_get_drvdata(pdev->dev.parent);
 	struct device *dev = &pdev->dev;
 	struct counter_device *counter;
-	struct rz_mtu3_channel *ch;
 	struct rz_mtu3_cnt *priv;
 	unsigned int i;
 	int ret;
@@ -855,12 +854,8 @@ static int rz_mtu3_cnt_probe(struct platform_device *pdev)
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
2.56.0
