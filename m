Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.125.45
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794911238;
	b=MbMYsW22M/ZgHg18O5dq8cEjDyoKZIJJSWwHqHjxnWUJdxGRmWQiHL89VDKnhc0AO2xu
	 rE9hQFOPMl0OZUcm2UvThe5p8iYSb11Cw/B7UL7traIr9DppyK3uB2ToMINsvbKyYnPt+
	 h+9UZzKZZqCOzNvOU5CPemsWVITg95+SmrbrZypX0CkGMhXCR7VNH5B355C029vejou2v
	 FlQcrXkdRo2ia4PnVRUTxVzy20/z2RlJqsE0q2D6Jjd4we76HywnDv3GTSp0z7JEe+Lw8
	 lnG/2bvL0u5+feivF9aObgxNNRJTjU/tEeIkf+rwMOmM2k0tyGSVx15UDzuK91wvHVQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794911238;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-EOPAttributedMessage:
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
	bh=OCQwWhKssa23quxneFhMO0jXB1L1QX3ygVtQj7Vkg7c=;
	b=z5gpufJf/CgZwwP61FI4z/7mkQcKAyp2NZN2E+HBEYjSTdqRp1XEOG2cyXA1q0s3izuT
	 b2HhZryBH3C5h0ShR067jfvolOk7BoAjFodVjY3HuZ6nxofSKeHny9lGcbvhHbkadPE5O
	 biTU3u7K/F7hvZTIZ65+ryDZY+7usSb9BBrp6hO0Ry5W2t1Hu7tkv2o50vWhJQEjt5imr
	 N5ekkFr902milQPRHIjQcJwgjXl6CMrZF4HV/ZjytpdEVeRUCnqdlrxASJn0WyNlwj8DC
	 XNrZqbepKrpp4oA0s2TZgStDlNFNI5ct+ZKyjhTVfao4Pn2znt9t2PPhE9Cd/2gY0Pg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=renesas.com;
	spf=pass smtp.mailfrom=renesas.com;
	dkim=pass header.d=renesas.com header.i=@renesas.com header.a=rsa-sha256 header.s=selector1 header.b=AyBuFzDz;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.125.45
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011045.outbound.protection.outlook.com [52.101.125.45])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6E8A606A31C;
	Tue, 17 Nov 2026 10:27:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E6E8A606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=renesas.com header.i=@renesas.com header.a=rsa-sha256 header.s=selector1 header.b=AyBuFzDz
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ss8JGcG7M+35TCZX+aDDk9nIyOeeGF4ZOY8bra/eIPanIBeCQhZMheO20b8KzzXrpcEXqs4RZGuIGdpZmU4zYLzlhS9TetYUG/KaHh73SayiPTUd/PiXoMPgSzyHISIlBvh5iO153LVWN3fplPZZEpEMlhGAKTKTStv1KzlqB2ffOH78QOwrSdBj9kZnKmm45kUV64aGfqz82AJWu2ymI+3jkff1ZRUl1AuGQ+VrX4adwhvI/PRvuGHN7lYb2wHQjF39w2mZVAhiGrCJJxJt2zaCZVafa4x5sKiewyGGxRwtzNOAjglCfrtbeOiKdu0GIcA2ORXwkTZmtyKluY0ibg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OCQwWhKssa23quxneFhMO0jXB1L1QX3ygVtQj7Vkg7c=;
 b=YL5N+c5NJVAY7x47yRCJQD/vHePQFt3+bThW6A0K59cJBDjDtwd3n6xPur+vzmbI/lKfV6vsowuLOv2lSA5qtYZiX0YlZSNnUxxo1ks4TyKmti/iBhXItJBEFQ/nLvFWokmOxiUxrv/PGQuJ98ftS8V7xQKMviu9t+WRW/P6kk38q2gpvAKaW34lPzq1bfDbBbJC+Q3tIsbxy5npaEME7JS2cdisJBaTYexhtlnYDcRq6sPNO12H4CJsBMeeG7GmnhaMXyauEJeEkbuPxVKSkvZON1PAE/4ayVtIV9nMK+oSs7ijReqOlQwHQcrUayzutGmq6ry1OXxwN/THPlHqFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bp.renesas.com smtp.mailfrom=renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OCQwWhKssa23quxneFhMO0jXB1L1QX3ygVtQj7Vkg7c=;
 b=AyBuFzDz5FRRHsc0wsuSvuFgmR9adoqn4Dj+itira3qts9k1tO33rqukUtRyENFJ66DncCJfTVu21mbzmuq9WvptjSY08iY+roLqflXziBEfcOGb3wTwEvFQhwNza/WMUafzhmVfsutYt8HfI6jGqrwLMXNgMRucm5z6s9sPcU0=
Received: from TYCP286CA0028.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:263::15)
 by TY6PR01MB697463.jpnprd01.prod.outlook.com (2603:1096:403:613::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 10:27:12 +0000
Received: from TY1PEPF00046B4F.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:263:cafe::5c) by TYCP286CA0028.outlook.office365.com
 (2603:1096:400:263::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.10 via Frontend Transport; Tue,
 17 Nov 2026 10:27:12 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 8.62.32.50) smtp.mailfrom=renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of renesas.com designates
 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay005p.adwin.renesas.com; pr=E
Received: from ejcrelay005p.adwin.renesas.com (8.62.32.50) by
 TY1PEPF00046B4F.mail.protection.outlook.com (10.167.253.39) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.4
 via Frontend Transport; Tue, 17 Nov 2026 10:27:12 +0000
Received: from demon-pc.tailc3dc73.ts.net (DEU-5CG5050QD0.adwin.renesas.com [10.226.92.253])
	by ejcrelay005p.adwin.renesas.com (Postfix) with ESMTP id ABCB73000255;
	Tue, 17 Nov 2026 19:27:10 +0900 (JST)
From: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
To: Biju Das <biju.das.jz@bp.renesas.com>,
	William Breathitt Gray <wbg@kernel.org>
Cc: linux-iio@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Subject: [PATCH v3 00/14] MTU3 counter fixes and improvements
Date: Tue, 17 Nov 2026 12:25:53 +0200
Message-ID: <20261117102607.2504551-1-cosmin-gabriel.tanislav.xa@renesas.com>
X-Mailer: git-send-email 2.56.0
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
X-MS-TrafficTypeDiagnostic: TY1PEPF00046B4F:EE_|TY6PR01MB697463:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 409b16fe-0119-41d7-97b7-08df44955804
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|23010399003|36860700016|10067099003|11063799006|56012099006|261026140227099003|261021121427099003|261026121527099003|261021123027099003|261022105027099003|261102123227099003|261028144727099003|261009223027099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	zhRZiwXVYt6iGNOUoDg93/SveYjAt7I2inAilQwDtwKoth518dWYe4aoLjc6/AIFNmMDfGnorUJIXmVGK80LdE6QDP60f1v+MQA4cm8eqzH0v1hwpvtQTiC+MK/My5rH6OSEivKfAhY9ykCApXLl4WK60vk8zq2RICl9iYcJZv5q+FyetQe7O8cQ423jOlXmaVkFNN4PE4VyxH88/vdpYvDbR+BvsK/yGsZGquuHmgF1mrHWEwwANRNdajWHcMj0AifuCjZoEPQsSoZvbkgexzl5hPNN+2OlQ7sChYw46pYYMUZjzZhH3X21+/obFAWiYPN5fr6k5Qy3JVdHCGxynkKGFDR74W3s6COyTof7HeCP7gMBO9YOWMA2TdgTuK0bKHOsO9+F3pU+U2z8D56FZH5WOfiSBVxOfQLuQtqMCcVo6vWXRm5K9R/CO1UqX1c49a6nDb5tdCynW2Xc5AXD4qR0GBjXitpN7m8O514K3DGd3TTWDfwbduyzhOWIH4euYc1PwmPDu4NRNdr/YSTEjb0mQL4PvfAssWmuarbncjUiyoXXjegqnzal2rda33lK7eFYNN8HflGiXGAfOY2cJ0hx8q20fbmQ6s8qoZG5XPvh94X4hSJyqaQF7VL58R+VnpM8I+CWpPRaSeoz0q7E+TEOQi046gE9+ocuBBkTizRolzEJNHqcB5movH1OwuHZLJ024CNkADpq9963vD39mg==
X-Forefront-Antispam-Report:
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay005p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(23010399003)(36860700016)(10067099003)(11063799006)(56012099006)(261026140227099003)(261021121427099003)(261026121527099003)(261021123027099003)(261022105027099003)(261102123227099003)(261028144727099003)(261009223027099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	OPVJca5thd7agoC7BbVBfTUzaOwTyyitr5RRM5hxmRUmaJitM4TxCMI5BCnKSm4gd74eTDOgKyfWNgxSt8oHrC5CrL58K75dGn2eoiK4gbh71u2aCP78qQLR6l2Lr9WJhBEiRCuL6SHySGL5naJFtkpuoQeHyORUqDLeeWH0o+0BJKEB59H1MsfWTSMi+eYcCquxrsgGyxIymHlXFse4G6scMylK3HM6KP/bljC3K+tIbLTlPkDxxLT3R/rVARSClZFTmSM8dc+4KR4Npj7oD+jRXjyJQDU4KGF9O3Phc9issE0mN+Zjv04WFBr2Y3Zl3cPMdoA+klKDngE4c4L1n1sST5t9meazaoUYyNAN0beV+wdOatBnqMCXns3sbwXwJJxLWy5ZSwWEPXfc7/9Rh5NidrtrL6b8NjB70bSpArJewv1rvf1m31qSm4KITXEW
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 10:27:12.6908
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 409b16fe-0119-41d7-97b7-08df44955804
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay005p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: TY1PEPF00046B4F.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY6PR01MB697463

This series does some code quality improvements to the MTU3 counter
subdriver, while also fixing bugs and adding caching support so that
registers are not touched when the counter is disabled, as there is no
request API.

V3:
 * drop superseded "put runtime PM on initialization error path" patch
 * adapt "drop conditional locks" patch to the contents of the accepted
   "put runtime PM ref if counter init fails" patch

V2:
 * remove clk.h include
 * remove struct rz_mtu3_cnt::clk documentation
 * fix struct rz_mtu3_cnt::ceiling documentation
 * add struct rz_mtu3_cnt::count documentation
 * add struct rz_mtu3_cnt::timer_mode documentation
 * add struct rz_mtu3_cnt::mtclkc_mtclkd documentation
 * add struct rz_mtu3_cnt::direction documentation
 * add struct rz_mtu3_cnt::cascade_counts_enable documentation
 * remove now-unused RZ_MTU3_MAX_HW_CNTR_CHANNELS macro
 * move rz_mtu3_set_lwa() call after rz_mtu3_disable()
 * mention the removed busy check
 * mask 16-bit counter value to preserve behavior

Cosmin Tanislav (14):
  counter: rz-mtu3-cnt: do not assign struct rz_mtu3_channel::dev
  counter: rz-mtu3-cnt: remove manual runtime PM handling
  counter: rz-mtu3-cnt: use device-managed pm_runtime_enable()
  counter: rz-mtu3-cnt: read enable value from cache
  counter: rz-mtu3-cnt: disable channel before releasing
  counter: rz-mtu3-cnt: unify ceiling values
  counter: rz-mtu3-cnt: cache ceiling values
  counter: rz-mtu3-cnt: cache count values
  counter: rz-mtu3-cnt: cache function values
  counter: rz-mtu3-cnt: cache external input phase clock value
  counter: rz-mtu3-cnt: cache direction values
  counter: rz-mtu3-cnt: keep cascade_counts_enable in sync with usage
  counter: rz-mtu3-cnt: drop conditional locks
  counter: rz-mtu3-cnt: use pm_runtime_resume_and_get()

 drivers/counter/rz-mtu3-cnt.c | 452 +++++++++++-----------------------
 1 file changed, 144 insertions(+), 308 deletions(-)

-- 
2.56.0

