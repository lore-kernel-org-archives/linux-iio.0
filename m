Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.228.37
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794911245;
	b=ynHE4wNZ0vKPHu7DmKQGrJjgAcpOEcvoq0aKTnwBDYRJbDzGcPOBHLxxnqQ8146rOGMv
	 2g/wxrBypMuzChxX1l62eq0ZFr6AkYP7JQ8zKdGiwXp1CiGBG+hB+1odA1CO8RZbSHP7Y
	 TNGZbifvY8WTgm/spMnvUVAXjWfCLCotySkNjkWdKZltZGC0Ea4lTphpnHF0NTzOJWgRk
	 pJPsbKEG8WpLag8lkyTUXmc9mmAfbqHsH1gLCX3Rpa7zkdK0WO/YLY8mj0vCcYqI/qGsd
	 TwbpBGQBA+hPaMDvOYsnPsxM3eBWgl/1T6qtwj7iBOSI+budHkXVl1+6mioEJFaBBfg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794911245;
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
	bh=24+/xVCcBuEJlsxsIDX8ofrBM1HBtvhvQYsSCbq9gCY=;
	b=RvCHwAvKSJLToTGVWwbiGibVVJxpSJf+Njv1U92KCdddeJghcY4bKn8o6kKd6vVpL3UL
	 Aux95OiVHURmKAzm+7REsTxM6E5WdA4tQZ2JPGRwzaXBwAmJBw2Z4sEz9QLQs3HbsNxVY
	 3DO6etbyOJOwufUTxh5okgpG5AUPvGw+VGxaFbqKnJ+Ncdtwrsc0jBbzKOpe2iBc/gyNG
	 ksu3plqbYU5LgXluq/wlcEyme2HLWHDKQMuGTDUv/sH0E3WFKeVT61YFaVc9nn2kmLwx8
	 mA7NHz4kWL8AJK8eg1k+Fr7WDM306otiz/OmB9ZWSG3VUg+My+z0RpXPVQqjxKMgNhA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=renesas.com;
	spf=pass smtp.mailfrom=renesas.com;
	dkim=pass header.d=renesas.com header.i=@renesas.com header.a=rsa-sha256 header.s=selector1 header.b=eg+uoDYS;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.228.37
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010037.outbound.protection.outlook.com [52.101.228.37])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C739606A32A;
	Tue, 17 Nov 2026 10:27:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3C739606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=renesas.com header.i=@renesas.com header.a=rsa-sha256 header.s=selector1 header.b=eg+uoDYS
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z3+q+Z9PYT0lvcNCDY82TFRrOQc3+9IYTXn5qyZ38a7SyVV6LoeeqG503J33z3+T8nqm4YjckZokafjKr2xiG5nek/x05aYztX4G8qB7G4HDGEehplDqA5dtYECRtKn8UJpwGPpyuXyn/9eg1Ml4pweTsv+PHx20GV7QZNc/BS/zxZMheb90G+QTdD58OY5fz3E2K1BRBbz9eyyAEVfwwH3Xpw/2BrZl4qWwC/37/Hya3ceQ5/Uf2/cJZLmKGirpPEm48ybpT02ni9a/knf/E+93/YGltq+jW4B1xfDAiBe4Zd+eTWTscEGESA5OkqD3XC70MJGee4FtmyTHhy7L6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=24+/xVCcBuEJlsxsIDX8ofrBM1HBtvhvQYsSCbq9gCY=;
 b=dHikahYKNV+HDTKKR2UG3g/UUJOCko9KoVM+btw4GujV5xJ4kQ1gDpSh1g/1Nf9/rIZAF1OD08l/PjmE0zaYkfTHELspqBYk4hel20NhpytHl37YQQ6S0bpCQLvac4hXyH2rsPpFrit8JUhJhXzn1BE6oZiDHspTWT+lNALU3e1HJ72dXdCxiPMUVcIaywKHDlDMacD3TryN+FFFsR6c8KJhxqQYlNaC37/MhYGRblkus6/9FiUA0fphEAw0hX5cLRUuFLkjBtIRzh0mQmVGwctTnmYJKRMWeBZOFUB+thcTFhb8bSbMFrHRuP3AhcHFSC+bZYw4nIQXlNn3broUYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bp.renesas.com smtp.mailfrom=renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=24+/xVCcBuEJlsxsIDX8ofrBM1HBtvhvQYsSCbq9gCY=;
 b=eg+uoDYSdLz2CAOqc23MBmbM1saR+jIknpxMnxpkGJA5d3Lt/zFja895rkW93YZ3mQ8OXzSTLmX1On0qkBAyEfAXJLa03lbopm/i+t6SCS/EwEvfrO//WpnLcRypZpqghXVAcVnvQe9Vfl+Crc+3Bh7Ygx7iaLtki43h/DJsnTk=
Received: from TYCP286CA0373.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:79::15)
 by TYWPR01MB11399.jpnprd01.prod.outlook.com (2603:1096:400:400::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 10:27:21 +0000
Received: from TY2PEPF00005623.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:79:cafe::7) by TYCP286CA0373.outlook.office365.com
 (2603:1096:405:79::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.13 via Frontend Transport; Tue,
 17 Nov 2026 10:27:21 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 8.62.32.50) smtp.mailfrom=renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of renesas.com designates
 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay005p.adwin.renesas.com; pr=E
Received: from ejcrelay005p.adwin.renesas.com (8.62.32.50) by
 TY2PEPF00005623.mail.protection.outlook.com (10.167.240.54) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.4
 via Frontend Transport; Tue, 17 Nov 2026 10:27:21 +0000
Received: from demon-pc.tailc3dc73.ts.net (DEU-5CG5050QD0.adwin.renesas.com [10.226.92.253])
	by ejcrelay005p.adwin.renesas.com (Postfix) with ESMTP id 843A43000255;
	Tue, 17 Nov 2026 19:27:19 +0900 (JST)
From: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
To: Biju Das <biju.das.jz@bp.renesas.com>,
	William Breathitt Gray <wbg@kernel.org>
Cc: linux-iio@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Subject: [PATCH v3 03/14] counter: rz-mtu3-cnt: use device-managed pm_runtime_enable()
Date: Tue, 17 Nov 2026 12:25:56 +0200
Message-ID: <20261117102607.2504551-4-cosmin-gabriel.tanislav.xa@renesas.com>
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
X-MS-TrafficTypeDiagnostic: TY2PEPF00005623:EE_|TYWPR01MB11399:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 044effda-594b-4469-5e03-08df44955d48
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|376014|82310400026|36860700016|10067099003|11063799006|56012099006|261021123027099003|261021121427099003|261102123227099003|261009223027099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	O7e6s1BT0Gdp4sxXelJ0yYth0cTVTTy6z5ftBNX6UZGGs//+j1e3UAoccBI+vLcTlf/JemjiSXy81z4E32O1dcxDlrWCh2bF6RAPuoSOgLncmGTQrGb5j5kKIVYGgPKzUKZvWVYFdo/x1iHt9+mriO4Q70wybrNBhbId3vuZ2HQuweVgECv41Cg6Z3wZlipGWzxGCCrDqWZyrlWIQJ+Mb2i2mags59IZdVneP6iitjkaD+TOqfgPUMRxiapMlSsNw8E+mpRONxNKcQ5vSxrjXkomEw+8HTCseA/aQRisDkVro7TXJZGdkvZzN7yvVCCvZ5JpCGtSH9pPA6yVM8KPR4YMQlnSXlMHjbsnuWixFV+vbeFsG2qrmOemFeWuEBziGRYZJGWjgB8PQsi1hUyr8ymqXXVJpi1sFckoA7jnEbJsXHVEtETs7nzZ36F8QWssUuCGD3Z6o2GGB+CgTt+S9zF5gNkQTOYC+h+xeigRghLb21FPfFJw1ZlV+0SyHbf6ZHdANAdh3mzO+f86kulxTHK/Prc/t1C9rHlu56Fa1A9iOC1PE1lVSSJdlzvTxESRgX5Xgu9CabFMz8b83nu5IIgqPzsssraJs4zNx6Y5MCjsr2lTSqjyZZ2P6YX3aD5SmVmTL8Qlx8ImNkCLfpqhhwlXEal5ac+tkO1IIjhJRnQ+Qv+p3sva1thC9kfEz3n8J8P5e6eUOYeIqp8dNfBBEg==
X-Forefront-Antispam-Report:
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay005p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(82310400026)(36860700016)(10067099003)(11063799006)(56012099006)(261021123027099003)(261021121427099003)(261102123227099003)(261009223027099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	91qVR3wT2Nab2S0GGUWKWnmmlx+sKX1TfGlBQ1f7tNtDpB9ykPzmRuSJv/2Rc7vn+y637BNilWSM9//s0yb45dbRaUNcJobUV1QAmETkzrCFMLe76yVppoUw5l364JojD/8oAU1mVDoVfoP91ePlhyq8u2UGkGGyCUX758c1UJBzelycRoiDIwYr4JHPb7DWUJtujL98/ZrJdtLy9nc+jq3iWUJDz1gPSEEQLn1/3YGufBv1UIgNgM9JnDyF3ZRcrRXbFl/8bXDQJh4nCbFkWopnLjL0l3fH/PdiEPSwJzIj+s6TgYG6Rgy4NM3XBI3s/nOiIm1qGq1lz3rZRyhE7+wTvXHnMxO+CM7bDPfUEafmmVIvobykmJUivWJZMEHfOisE2MAROeMlzAKFWh0qNd2U5qXZ3KD8QJj3yxsH0WWPl1Rq3n724ykvL0AJQgv8
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 10:27:21.5241
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 044effda-594b-4469-5e03-08df44955d48
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay005p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: TY2PEPF00005623.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB11399

devm_pm_runtime_enable() has the same semantics as the current logic,
use it.

Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
---

V3:
 * no changes

V2:
 * no changes

 drivers/counter/rz-mtu3-cnt.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/drivers/counter/rz-mtu3-cnt.c b/drivers/counter/rz-mtu3-cnt.c
index d8f13c5ac525..b1848a0b17e5 100644
--- a/drivers/counter/rz-mtu3-cnt.c
+++ b/drivers/counter/rz-mtu3-cnt.c
@@ -804,13 +804,6 @@ static struct counter_comp rz_mtu3_device_ext[] = {
 				 rz_mtu3_ext_input_phase_clock_select_enum),
 };
 
-static void rz_mtu3_cnt_pm_disable(void *data)
-{
-	struct device *dev = data;
-
-	pm_runtime_disable(dev);
-}
-
 static int rz_mtu3_cnt_probe(struct platform_device *pdev)
 {
 	struct rz_mtu3 *ddata = dev_get_drvdata(pdev->dev.parent);
@@ -831,9 +824,9 @@ static int rz_mtu3_cnt_probe(struct platform_device *pdev)
 		priv->mtu_16bit_max[i] = U16_MAX;
 
 	mutex_init(&priv->lock);
-	pm_runtime_enable(&pdev->dev);
-	ret = devm_add_action_or_reset(&pdev->dev, rz_mtu3_cnt_pm_disable, dev);
-	if (ret < 0)
+
+	ret = devm_pm_runtime_enable(dev);
+	if (ret)
 		return ret;
 
 	counter->name = dev_name(dev);
-- 
2.56.0
