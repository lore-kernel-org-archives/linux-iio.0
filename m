Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.229.33
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794911279;
	b=nUQVvjL66qM5KJgEnA/8ec1I0ddyGMx4IcwSQpSwz4vO9UmTrvXFFGx1DynG9xiZDsAH
	 ZF73WynxpKiIMwIkgHWIr2JUNwFN4sDT9xbUsxn8j2PIy2ruCwc5AHINf+HZEGea1H7s/
	 WbLu8Z42Bv+CNTOqfiuxwNUSUY3jWNrxYRysIlM7JxPZlgz958XQlquP1xv4C9JF53ioz
	 bamVK0fRnxE46b2H2wABVGQGyOjYj66oybqeny3Hji9HTuos/frpsbv68vqXEPRH/TB2b
	 Sdx8U/4BYGeISmrxoUJQ+iMZzCeDX7xKS2wfoVY7D7giOkiAgt4QkWKWHsq6FWKHD1w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794911279;
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
	bh=pkwC25e3sUGoe6qpWaCnwukB73xTnmNOoSG2C4usVCs=;
	b=b4k07v+zmOIaGaXp81/cgslXyjrTK7Ygw1ng2He2g0JrsqC1FcSkdW2u9fVyN2rXu26y
	 muDkIoDa4dO+otFfQvZYrW1i697vHWSUFGToZKJrxUVt7AcD1tENx+5ifiyp/Po7c2Ahw
	 pCFY+RrHLI6hkQAcG4RqWMTpEPsni1K0W/76UAdhL1WA87u5l3stY2P7iTw6XrFBYfFu1
	 HhVabYIrrruUUUTetHKmSVvHdro8YWidGMhegkWnOPYrCsYN9cNWupFlxiAWQwzR2mVxn
	 SWkUUI8UKzVJJDJkdXM1oWLd+8dkhZAhgn1pka7lU98Nq66+IvkfqZu4Awpz5L2EZag==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=renesas.com;
	spf=pass smtp.mailfrom=renesas.com;
	dkim=pass header.d=renesas.com header.i=@renesas.com header.a=rsa-sha256 header.s=selector1 header.b=iya5uMFB;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.229.33
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010033.outbound.protection.outlook.com [52.101.229.33])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E30A606A33D;
	Tue, 17 Nov 2026 10:27:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9E30A606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=renesas.com header.i=@renesas.com header.a=rsa-sha256 header.s=selector1 header.b=iya5uMFB
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nk3KNFfC5YHdraJJkmX2fq2BlTXGOyls5cZJpvAHzeFBpJJbn310NH5zv5YwMepTZJUd5Bfv3TX//haM5yd2CMOZArN8T++fA0VPzCnqYVeGjZuw6aGDXGoIXqsc9GIfltriq2fgc2CeBCHr1rIa3vjitUq/A6DZOZjYlJLviW2J/9IGjHGiNIsxJIHVlWK68gtTcOA5CU+yjXbsm6yfmFcfVqoXMfNNrtP9WAA5Cr2agiw6dGWvAW9fR04coKWwNCWBGs7bceHJpBEsB/eLoIIrL0zvdpy3Fz82qg6Yu4Po9wxyKzk7jccEKV69FaHrvRNwvvYKRwrX3XjEpArw/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pkwC25e3sUGoe6qpWaCnwukB73xTnmNOoSG2C4usVCs=;
 b=p5NI+bJttyoqPx+gfPFgBgupz+tQ6m+bFzeUbDe1IFDaMD1JUr3NRsYelT7kGXooVnEoa2ziSzc0orTNZyd2QYOUOtUXcDtbphenxL3U1GcGlr9C+lTkUE4OSTME4n+jPastgO0iDP1TAX+/EOfdZVhr9bwbVqvdq6FNWM2i0A5f7oXekpmLOAqzRmruSYRfJbZvQu3gSlpuEWXEyPlgxiF4l3DBqMZS5DH4lu3GKRmxkFUHstCyoRBxwL5Xi8Z904yS3kTHENrKjDPnD8s6MAaO43YycJTC5MtGiIPESzK2HNIeGP4dPduUK8hKkH3EDNJ/EVpHj1bvw8H9/q+ahA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bp.renesas.com smtp.mailfrom=renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pkwC25e3sUGoe6qpWaCnwukB73xTnmNOoSG2C4usVCs=;
 b=iya5uMFBsEHzOjrTufs5ml3eOy7vAkYu80yCRrTw4iWRXGuOz4kzNtTOm6cxP/iWpz5xSr57qmVJ37u0e1O8BkVyPjlGGX1nZeJxuiMg1hW9IWIHh9jLp7gTHD/ciWxzFWvpMSqRvLkMqcy99H2ROTZyGJ/4QsuB3wWtFhdr5vk=
Received: from OS7PR01CA0277.jpnprd01.prod.outlook.com (2603:1096:604:259::16)
 by TYCPR01MB8223.jpnprd01.prod.outlook.com (2603:1096:400:104::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 10:27:54 +0000
Received: from OS1PEPF0000D20F.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:259:cafe::20) by OS7PR01CA0277.outlook.office365.com
 (2603:1096:604:259::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.14 via Frontend Transport; Tue,
 17 Nov 2026 10:27:54 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 8.62.32.50) smtp.mailfrom=renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of renesas.com designates
 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay005p.adwin.renesas.com; pr=E
Received: from ejcrelay005p.adwin.renesas.com (8.62.32.50) by
 OS1PEPF0000D20F.mail.protection.outlook.com (10.167.240.38) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.4
 via Frontend Transport; Tue, 17 Nov 2026 10:27:53 +0000
Received: from demon-pc.tailc3dc73.ts.net (DEU-5CG5050QD0.adwin.renesas.com [10.226.92.253])
	by ejcrelay005p.adwin.renesas.com (Postfix) with ESMTP id C4FD23000255;
	Tue, 17 Nov 2026 19:27:51 +0900 (JST)
From: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
To: Biju Das <biju.das.jz@bp.renesas.com>,
	William Breathitt Gray <wbg@kernel.org>
Cc: linux-iio@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Subject: [PATCH v3 14/14] counter: rz-mtu3-cnt: use pm_runtime_resume_and_get()
Date: Tue, 17 Nov 2026 12:26:07 +0200
Message-ID: <20261117102607.2504551-15-cosmin-gabriel.tanislav.xa@renesas.com>
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
X-MS-TrafficTypeDiagnostic: OS1PEPF0000D20F:EE_|TYCPR01MB8223:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 822b9656-54e0-482e-1337-08df44957095
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|1800799024|36860700016|82310400026|11063799006|56012099006|261026140227099003|261028144727099003|10067099003|261021123027099003|261021121427099003|261022105027099003|261102123227099003|261009223027099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	Ny8gGiZYX7EijPSo4S9PzUJ3tVSuaAjliSgDOUdqAgzi/A4yrTffHIKX91NdgSyjV7cstDb6bFBL7qi1PONuOq17oeYJ8f/fBR+b34iDnGUJ6zZsW6om1mDxACga9pkSAL0Y/ZML0vKXeANJws6+7P8kqXZDuIrTgOeHApYPKgeCNK5QBxgOurXsRJafsith0sWXtUoezdx4IhEBoibZqTBQV4j4rCVvpLTnd8qXDvsyHcHOhjW2fxBdyCPt/jQQXIvoFjnve+7MO3tAD72FAJiEH2WgLHrSbYOsCBm3LRb0iHCSpl77jOS7ACGwqHe025MP6wkeJhFAlaqIvLm2e7KTXXTPgHjaPd/H2acdCv9GtsLTqLXUwiQ5l7BPq9oeia3MEBfkuZL0UmH7nDn4miz65yh9ZoY0R3gwgc9hOFQcjQrg6En4Xegqy1eHY12nPZnBWYR/pQ+1tZHFAR1WHmtt5TJPMFpEHu/MY/vxe5o5Ue1IplOpOZxL1l32eUtdX8wiytfTOTC8YzJOYf9jStiUkzXQPbPjvNH9GAzrSJGplJZ6ArSl6jq974c/h4acQZLsdZxR66yB2fHCaKUGM9PIQVrWOgIxB8x0MrgbA4s7GB1MnDIRNBtigUhjU6hEGY6CnHZF3IvIiJtVC3p5eGVYN79eLlaEW2nYGhvrVl7LYY5iAfFTyWMU8PAWhpZRkkXsTR8x1eIdSsm8jS+UvQ==
X-Forefront-Antispam-Report:
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay005p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(36860700016)(82310400026)(11063799006)(56012099006)(261026140227099003)(261028144727099003)(10067099003)(261021123027099003)(261021121427099003)(261022105027099003)(261102123227099003)(261009223027099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ZBzpwVdqbKTq1Ry2Ce1TlyFHGmjcip8JMs5pW1MCyFLRse/3Mx0OSErA8dzMZNO/3awTtMjUTTavpsjqaQHppVgnptRk9vu12QyzsxjjRDoFjYjPYhi0UfBexRFjRd2+dIxpxl/4hak1qEILNf6IhoRKmvYFNyUElZruVkfYnE/OqISwsCkerr+Dyk8SiKLnbJCD6F55zKHRinGCz+FVvOSXo50lHYot8rn/efJMd/d0xMQt6TWkN9s/pcbBa6XwSdno5enu8rOVapNtv4Y3Z+sOMmu5uo4K6Bqek4jG6gmpEIbttl8b2iCaPOGGfCtwnz9mxfJ07aJ08W5fOnyZcB6tMBftUKmo+sG3L/MQR4Lyc4FXcWPiCZfzKvyol+A4qP3AYQZTB3tIWSw3VdYerDZZ8xATbGiM7nZtVRGHK2gHBKA5DON/fdVkRewTNk4c
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 10:27:53.8895
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 822b9656-54e0-482e-1337-08df44957095
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay005p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: OS1PEPF0000D20F.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB8223

pm_runtime_get_sync() may increment the runtime PM usage count even if
the resume fails, which requires an explicit pm_runtime_put_noidle() to
balance it.

This driver ignores the return value of pm_runtime_get_sync(), risking
accessing device registers even if resume failed.

Replace it with pm_runtime_resume_and_get() and handle errors properly.

Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
---

V3:
 * no changes

V2:
 * no changes

 drivers/counter/rz-mtu3-cnt.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/counter/rz-mtu3-cnt.c b/drivers/counter/rz-mtu3-cnt.c
index 8252dee6d04d..1426d15f0ccc 100644
--- a/drivers/counter/rz-mtu3-cnt.c
+++ b/drivers/counter/rz-mtu3-cnt.c
@@ -435,7 +435,10 @@ static int rz_mtu3_count_enable_write(struct counter_device *counter,
 		return 0;
 
 	if (enable) {
-		pm_runtime_get_sync(counter->parent);
+		ret = pm_runtime_resume_and_get(counter->parent);
+		if (ret)
+			return ret;
+
 		ret = rz_mtu3_initialize_counter(counter, count->id);
 		if (ret < 0) {
 			pm_runtime_put(counter->parent);
-- 
2.56.0
