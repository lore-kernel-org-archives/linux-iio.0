Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011013.outbound.protection.outlook.com [40.107.74.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26AF73CF680;
	Sun,  4 Oct 2026 17:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791136142; cv=fail; b=Et9xkpX7/v5a/CCpNwgVv0hJLBq7cIlbH5xaRntgYyxUXeazN//BCaV4Dr5nw7KH0G33LfYxwzYmNypz6WDJlICL7j3xYyBaFeewPpjhSL0zkeryPnS+dmYtUkUbBrS/2c2XNoico1YcbrlLXzkj7D9BYaU1UHEGbJszIzhK6J0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791136142; c=relaxed/simple;
	bh=LCks9zkB84brEEFDlcVUmwB8UVd5mCuvtfntWDWCjYY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N3hY2/uI5rPXeSWpO6WgBnY+E784fwJ1AHGLEKBV8NQ8QmlXfC33YuWV3RZQzqf1G+av0q8DZA5ukq/L+jC5U+UDozwkhD8Ha6mq/DVsiggxuKJCKTbLle1pcFYgzWchFJp1sT8SzF6k7O8RW7nyttQAcYfgJ0Ing1rvVBK6U14=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=aWIE9DhG; arc=fail smtp.client-ip=40.107.74.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="aWIE9DhG"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IfOHrxyNDyZVxHPXdWW2exbFDV/ktfDmmHlDX2c2wA1kVAZdzpM8Slqh6ArTCtuYxIqGW+OozZZsPuzia180GQyO6lomK2nWyHatizKeTu8C9La1wOOMTyHPQh4WXe6Mv/Fd3lcCVXlvqhbUwzMJktnqIpNMhWSPH4kiU3E+oXfu/DizzZR4kz0b09uxc8rPJXvgvof/HZGrO1U5Su730ubiAF7R/5gd8wOpWE0paYQvbjVgzoAO/s/QWItagagiEfeTKivdeaQwooJSzHIzmjfySfXt561ZXAxzzSIar9ChP4F2ts3FviTIjikc/73BWPfnmfXTKUIuhHibrfpo7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RjwnkKJeNncRrULNTwdPlEdXk3CYvUsfg4Ii+C4j2z8=;
 b=nurbg/HJXrg9TL8lLnC8RrTyqvtDOn47PSVbMteXmx762/wpFqMgKNB/93Dwm3PlFhz1kgLQenCWj8reSkoF6b9Ojkh5ziQ7aQXUMxN6B27DoBLkcD68z9xNxzJ/PRF2oq2YOBF+4qvD31NsKvIOhsHF9pjGkVuTZCfdWMOGJ8E1wtUDCTkUGuj2TplxQiiTjCZt2UCw4MDiH7+CmpWSbKH83il/2k3ErJFjI3VVgGo9YU+Y7EKOV0NxzZU1ab3njp1vg/3rrL6W7+hLptN7g13Dkr2xpc4ol6UMTNpT1diqmA+MWDa2c47z/AJnlE+Ak7+vAIqIjEfMF9XlCSaHMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bp.renesas.com smtp.mailfrom=renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RjwnkKJeNncRrULNTwdPlEdXk3CYvUsfg4Ii+C4j2z8=;
 b=aWIE9DhGSMuW18Cx2p6+r4KtKPR0OzVLub/xnQP3lkX+ep+h+BHprniC5WMxGS3QSwrAm/rAcwyDByW/w1jkOnp+yMVsiPegl/tMdliYKOmvLZGkqcZwPJyDO6RWuQH5q4NLlOy+XaFmM+2Az6QnpCZIEO8pao+9yZWNGSt2+8A=
Received: from OS7PR01CA0160.jpnprd01.prod.outlook.com (2603:1096:604:24d::10)
 by TY4PR01MB15195.jpnprd01.prod.outlook.com (2603:1096:405:26a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Sun, 4 Oct
 2026 17:48:57 +0000
Received: from OS3PEPF0000003B.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:24d:cafe::18) by OS7PR01CA0160.outlook.office365.com
 (2603:1096:604:24d::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Sun, 4
 Oct 2026 17:48:57 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 8.62.32.50) smtp.mailfrom=renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of renesas.com designates
 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 OS3PEPF0000003B.mail.protection.outlook.com (10.167.240.4) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.14
 via Frontend Transport; Sun, 4 Oct 2026 17:48:56 +0000
Received: from demon-pc (unknown [10.226.92.36])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id D3F7B3000246;
	Mon,  5 Oct 2026 02:48:54 +0900 (JST)
From: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
To: Biju Das <biju.das.jz@bp.renesas.com>,
	William Breathitt Gray <wbg@kernel.org>
Cc: linux-iio@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Subject: [PATCH v2 02/15] counter: rz-mtu3-cnt: do not assign struct rz_mtu3_channel::dev
Date: Sun,  4 Oct 2026 20:47:39 +0300
Message-ID: <20261004174752.507499-3-cosmin-gabriel.tanislav.xa@renesas.com>
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
X-MS-TrafficTypeDiagnostic: OS3PEPF0000003B:EE_|TY4PR01MB15195:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: dcea2303-898a-41cd-0c87-08df223fc3a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|23010399003|1800799024|376014|82310400026|18002099003|22082099003|10067099003|56012099006|11063799006|7136999003;
X-Microsoft-Antispam-Message-Info:
	+83/jggcMirI+etJb89vHvnW/4YlLnWKOd+BOKuajBYiYnR0BQc2GM3SvSgcfhvH/5Mc0p8pKERDIo+4rzC5XPzOMkmwk6dCCBhssKMYkvc+vz37Qj8ZaAop+AgX3NsMmQYqaC0RM5ryYxxC6TLgT5/uG0D/ucky2Ylc3xNH4zTSJSwVKF6dt78wywAvbImHbcjKzqkQ2paBlWbQPkUYiABzdFi9zM48ioIyYNtz7ZQZZnAOOd/K0zjD1G+74t18UYaL3YKrOahftIEygibDYU1z7DKB7lSdDcuRZBX8B10Wf7rJi+igmOuI5Hcz2P8AZf9n9M7RluPjdfyXryBZGghvf8zjuMxnTiXIs5GSOplpwPNwDL/ddFlMRAdegB1fhiD9MxPOAmLF8o4PTN6xjegVB1rexdg8gZVQzKiIqbhLVy0lj0QG0l6JwVxIw2AsblMqlzmHU+3SHIQlx1Wy/2+vFo5cM+OuhtJ7F8OustMAIOhDWqf9p17MjxUS8TzVg9gO/rXMlrixaihTnUWkAcW3GuubDbeE5qsPqXFlNOdYBb9MkF+I5XTe1X1qqWsekhOhHFCgNKT1dA7eqN78PgjJf9qk02sBBzjLpQOyGONjyWHQRIbO0yRmWgQlJX/WoSrnf/lApbnQc2sqzT5tvjB9HhNDgFOPgtqX1DIRVe33nPHPecQ7aAUEYgYsnuzOvIBh6nImm0ge52yqx4CyGA==
X-Forefront-Antispam-Report:
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(1800799024)(376014)(82310400026)(18002099003)(22082099003)(10067099003)(56012099006)(11063799006)(7136999003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	oVWa4XRfaVhQ3/zPPAf6M9gB2Co/46E5MxKLUK5I+NScRCsYwzxguq6PbQyb5Ay3/1GtMglqgBWZNgl4V/+m8W5BI5DRYEXsZqUNGI4VC/FRJCK+9DAat8kB+k5YNHKpkBPJUMhrfA5omuLM4ca0xocRNyK6x3QfT+xJQJVUaVGTxLyGaqcnX4mfAAcz6A2j12z+VqjoUwDcZvI0ZyYMuGbtR99qnslz54zdNoZ3b0ktCswzNbT4vihoz/Dg5oHoxI+FvzYqzq3e7KaFnCql9ICRFFXEI1UxoV2SlSCKJXZvvl8tSJohhuYrRnvOK5weThCMEUgHqI9PxSaoXC8URgmdK5Eo9LQIjav9cle177wMCJPMy7YtCIh5EtkwgN2uU4w9oxiqEwPhOdYQlUyqnDoEBhPMUJDy/1ex6OTMTL5rQhaZmk0waB6ib4zxWQbp
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2026 17:48:56.9721
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dcea2303-898a-41cd-0c87-08df223fc3a2
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: OS3PEPF0000003B.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB15195

struct rz_mtu3_channel::dev is now unused. Remove the assignment to
prepare for removing it entirely.

Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
---

V2:
 * no changes

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
