Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.228.33
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794911252;
	b=X6rdMHXhAF2fhPuCeKjUaUUqP96CXPUAT06RRGAYApHU3UafBg9qaKCPqoA9daN//0yB
	 SLFCQqpeWLm/ySs1nXXn4kkxetHu+JaN9wg6O0lxkFYoD+ufKh0N5QyGgYru7wmpMf34M
	 SiAzkil+CZ9fh7Z0wkiEBD7mho3urZOsiWKMUlPk0X1dUzwCkMaTDsgJftPtyRDfcdrp3
	 XFpeLuhln2/LeZUHh98O4UbsWP/hCL+vLKXUp+XAGquUQPm751ZnQ5mmPfGnkwAsK64d5
	 WqrTbbJZbcCQh2gFkftvKWgwe0eYQyj79j5K3ZNM6cc9Z/RcCFxVTyFxyBJowF4jJ8A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794911252;
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
	bh=HcIR8Rmlikd4dpwvZTeX6Mnum45ThMW0vZTjycXoLhE=;
	b=hDl0ZOsSNCR+fxJsgo0GpQq33QvvwWlRTgKLH21KBqKFUqPz8GBG5bDgzlwRzIgpYAEG
	 0Mt8NgIW9vfLYHF40Kc+R/OZm0sNoMxIgX94+at3stIr8NDWPF1uOTGR+yPigLnRY4NmR
	 ZTh/ytNnEuWcvoJH7tghQcRotCY4T+O98lslGEVIAFBIgzHJHDzsWDBH/DorG1vMPAupP
	 aUgICe2KxRiw8Vp9hFmfzAtoFAVVDQasELjrF08cwvjUzwZQc8p78T+BAFuTQIFl52dgo
	 B+zpZYdE+Rliw4J6BjUbF1W26sGal6E276LHARVxZEf6n6jedxPtzd8JD21oIRM4LDw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=renesas.com;
	spf=pass smtp.mailfrom=renesas.com;
	dkim=pass header.d=renesas.com header.i=@renesas.com header.a=rsa-sha256 header.s=selector1 header.b=ANcWSHoX;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.228.33
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010033.outbound.protection.outlook.com [52.101.228.33])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2290606A890;
	Tue, 17 Nov 2026 10:27:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B2290606A890
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=renesas.com header.i=@renesas.com header.a=rsa-sha256 header.s=selector1 header.b=ANcWSHoX
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VikN/adQ4BppxzR2C+9KoUajNO75IHNbmMPUbjJuzDwTrUusjIriwGHPEC7aUcJGAHBPiyHT/SEx1oZ5AgjLvcNlERY2owgvYLq5U77EAf1aaMOgwyJV0P6INw0NM1CHESWOYp229Z0B2/p+VsmJDivPU/9cyL6C7a87jLrwp3iqLC0zAHPdnFhSv9SqKhzabVzlt+uGvolzCdznoexFfq0d0mwvvmuEUaVZuY2IbDjMuhtZ3MLBw7TwLrQv/Uo+ASyhzdDjGOZgHKAmZz22LSDYa7sqZXbAOVH83ln5GtRu4EyfW3sixo6LoHd0WdGD+94KcNmvdXDFdFNhcHg5lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HcIR8Rmlikd4dpwvZTeX6Mnum45ThMW0vZTjycXoLhE=;
 b=iB5/F3bB5qp2dht4NagY1N/2of31n7b+Ae3ZKz1oRC++Hm36sI8MHnqz+aFZZ5o7jBncpLl82fjIvUZx257awoGNSjo2PRX8Aad6Fwq0RpM4SEmls1aME5uVSEzNpabCurhrbjBbR9+BI+T0m1JPIbz2Saq7+5Fl6lK6hmKJ5J3byyLIT3FQIyi/R0301GasQ10vPWtCrpUamFRTkoxGB5DKEiN2qjD9L8jonsUovfQuMTusb7Q5+bPpE99KPLfSWYVyTJMnzZPQEBkCzKHqhmtmBvRcfrFySC3iYgNMpUxMHg1I3ZOwsxgJc7lZ/HtTY6BjjGf89QzmWUe0LPP5Jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bp.renesas.com smtp.mailfrom=renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HcIR8Rmlikd4dpwvZTeX6Mnum45ThMW0vZTjycXoLhE=;
 b=ANcWSHoXeQ7e64VKVbaeKDQ2LRbuhUqBL3IHN9hR2JgI22KKc7CIbjJzDDvuCotc62bqlWU+goWHfKEXSmzr0b22DZEcaXeilY5GLNMBW2Ifu31A0XFN6JWQMVEanqzemLQr9/Ex2at5OlQXeJyEhEipwPmHIyafP03GMslL9wk=
Received: from TY4PR01CA0092.jpnprd01.prod.outlook.com (2603:1096:405:37d::17)
 by TYYPR01MB6893.jpnprd01.prod.outlook.com (2603:1096:400:d0::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 10:27:27 +0000
Received: from TYO1EPF0000501F.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:37d:cafe::1b) by TY4PR01CA0092.outlook.office365.com
 (2603:1096:405:37d::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.13 via Frontend Transport; Tue,
 17 Nov 2026 10:27:27 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 8.62.32.50) smtp.mailfrom=renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of renesas.com designates
 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay005p.adwin.renesas.com; pr=E
Received: from ejcrelay005p.adwin.renesas.com (8.62.32.50) by
 TYO1EPF0000501F.mail.protection.outlook.com (10.167.240.4) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.4
 via Frontend Transport; Tue, 17 Nov 2026 10:27:27 +0000
Received: from demon-pc.tailc3dc73.ts.net (DEU-5CG5050QD0.adwin.renesas.com [10.226.92.253])
	by ejcrelay005p.adwin.renesas.com (Postfix) with ESMTP id 361DA3000255;
	Tue, 17 Nov 2026 19:27:24 +0900 (JST)
From: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
To: Biju Das <biju.das.jz@bp.renesas.com>,
	William Breathitt Gray <wbg@kernel.org>
Cc: linux-iio@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Subject: [PATCH v3 05/14] counter: rz-mtu3-cnt: disable channel before releasing
Date: Tue, 17 Nov 2026 12:25:58 +0200
Message-ID: <20261117102607.2504551-6-cosmin-gabriel.tanislav.xa@renesas.com>
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
X-MS-TrafficTypeDiagnostic: TYO1EPF0000501F:EE_|TYYPR01MB6893:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: d9fc1f75-b9a7-49a5-0f10-08df449560a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|376014|82310400026|36860700016|10067099003|11063799006|56012099006|261026140227099003|261028144727099003|261021123027099003|261021121427099003|261022105027099003|261102123227099003|261009223027099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	uiSdwn+sgaHQxKjKHHB/a9/vhc/HmM7vd8iwxBSmV5LlxWEZXdgEHQDivPopWq1aljK++FBRD22uu5r67AOYtUaeK54nPQQkIEeBzNVne5iniOAsTPmrca/B/bkmrdEpvF85nScmFnlujz6yUZ/HdGgkCHLOXX4bkgN4wl7LYbt1lICkiuDqL5povduf207Y087+T7z9zQSLID4Dkmg8bY52alx6aHTLDRORg6U7/cQPCl1NEzTLA1SEJ5dfogmK0I+8mO0XmPf4VPnMra+wlR3vfmByPw/RuDwdHx6qa/QIqKue9Lk0uT/igsHkOtaf2KwCnfxh9CvocOe9EJ27LpeGgrWIq8HQOtcUJSBKkTOJp1EoCv4iko5NVur25UvyIbw6ipMgpcTOEpfr7foQ09krbzbyjY5O0FuXQ8KY6RHiIAHM55/v8kljyesS9cRwQtHFQUvZ6i/J1nm3EzI3sVa5vl9N4pZU7gc08iiJtOvFvaxKGs+xi6QIAqTfZSw2cLrVEDY9byZpHfYXZ65okYQ7AwneCubk74QUiQz2WHlPczm4iAdlz8rBdtn9OoQgpykO5pegJXQnzj+Q4IVCW5Trt3vk8/8BG8BiWux/uFdrbX3+mtXpMHQdtcKitrKwmLU3UBb9T432Y2u6mAvVBqiy1QyQe86JrI+0j+oPfMsJEdiRzhsAQHipe7PkAD/iV6tVR/FZPrqBmUbUHkB1oQ==
X-Forefront-Antispam-Report:
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay005p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(82310400026)(36860700016)(10067099003)(11063799006)(56012099006)(261026140227099003)(261028144727099003)(261021123027099003)(261021121427099003)(261022105027099003)(261102123227099003)(261009223027099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	5YeelhgSFYH/b1jKYBG9V6c0FV3ggcOruVidWU5ZJ06kcr+WmN+4O7v1Orv7lgSjuZE+yqEFBdYzpUc4OcJd9iAztB8L9Kizy6K99xJm2WLNFEkmOMd+fOIYGO5S8pmFPKsmQfaagI0eCSwE/D1GtTxoWoNJflhDMLvsEsAUpbx5hKz4x5Q6QnMctQzIcVhTJqfYL51TGmGupxm5HkOi1Y+Nf2cQuQdSKRMkoFroLB0hqXdoM5Sk68n2ipT6D0URSVI/3DMqfly9YZmMCo7LL1DOZZ4oirW03+2dz5GYwBH/FdbBEg8DCwUNai7du6CD1u/uG2jHAnls+YRvBQgNfbHWoS3xpnmwBY+X58RQIswnM1QSusLcaUYqQVUz+PB9VDU5WmjCnHdFbPkbzf+P0TsuwtZr/7BiroVePEHbyhGTSBAn+D19pGnfaYsraugi
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 10:27:27.1712
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d9fc1f75-b9a7-49a5-0f10-08df449560a6
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay005p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: TYO1EPF0000501F.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB6893

Releasing a channel marks it as not busy, allowing other threads to
claim it. With the current logic, it is possible for another thread to
claim the channel before disable is called, since we release the channel
before we disable it, causing the channel to possibly remain disabled
while it should have been enabled.

Disable the channel before releasing it.

Fixes: 0be8907359df ("counter: Add Renesas RZ/G2L MTU3a counter driver")
Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
---

V3:
 * no changes

V2:
 * no changes

 drivers/counter/rz-mtu3-cnt.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/counter/rz-mtu3-cnt.c b/drivers/counter/rz-mtu3-cnt.c
index db30470215c2..23dbca3b5cfb 100644
--- a/drivers/counter/rz-mtu3-cnt.c
+++ b/drivers/counter/rz-mtu3-cnt.c
@@ -456,13 +456,13 @@ static void rz_mtu3_terminate_counter(struct counter_device *counter, int id)
 	struct rz_mtu3_channel *const ch2 = rz_mtu3_get_ch(counter, 1);
 
 	if (id == RZ_MTU3_32_BIT_CH) {
-		rz_mtu3_release_channel(ch2);
-		rz_mtu3_release_channel(ch1);
 		rz_mtu3_disable(ch2);
 		rz_mtu3_disable(ch1);
+		rz_mtu3_release_channel(ch2);
+		rz_mtu3_release_channel(ch1);
 	} else {
-		rz_mtu3_release_channel(ch);
 		rz_mtu3_disable(ch);
+		rz_mtu3_release_channel(ch);
 	}
 }
 
-- 
2.56.0
