Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011019.outbound.protection.outlook.com [40.107.74.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5C5E49EC79;
	Mon, 14 Sep 2026 20:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789418265; cv=fail; b=KsKkVodHJbqHUInqeUJWB7QJFX3rzz0ozP65dh/bq50xkx7L1bFqoI25YsvXhHB92nPyIfDAivjBszEpuP+OMLZJxIWjNOCkAIPUhdO/Pkzj7WpLl2yQOZHVFefPBQVsn9GOzFa4gO+/+724oSvqkQLwjgLHRfWb6sZ10H5fR3o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789418265; c=relaxed/simple;
	bh=OOwOwl6QQF/qFCpvlGXN8G/hxkpA2HZW67uEdphKlNU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Rq0mq3hW2Rg7wf88+OqSqiy3bBLgIVtCcn/J+yDGMb4CO+zf99RPDwcW9mwOFFIBltKwcrj5Q/g8GkD1zEXMKApwQWIptev9Lv2Otavm/HAXHnXCcAliJvoTjqto+tTvn5ABCGFLhcLmX8R2NyleAY1kyPdVG3MHdIj0/1bAVsQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=WoTce4ys; arc=fail smtp.client-ip=40.107.74.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="WoTce4ys"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K4lYk6usb1hv6BQVxrjxGcVVuFa1dk4FUG9lrIJ/WfRWWyEr4uODlJnqhxd0TFp8Ca6e6ibH0s2RXXO8VE+rYxBbKQkGcM/i9Rrbbd+tqxANkY/HqeqcTevDdvMkJur8JMRvc+2Rbx3x8VC28MVD7qmSMpixLVtLlD/lIGlVR30X0Sxl0Ce22kBbjT1NiQHCO3DeDK/R1VWNqvBGEc6dC+Qppp9is4gH8m+xaVjFmebdRoY5RVwJTknBJQG+KTwMQpw+YHCFUZKLvt2DdXmbynJW0tVpfqIul/kAmBrOkXvXrEBQAfbKMJYusonEOZSvMDL73hqGC3xWuieDF/bnsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hnVScNJPNbtGO4dm6G0+S7f31DLrAYpcVtVdXeMbXcE=;
 b=XRNV2J6haFa7rkU0tvNVB8qqFcZ/AB5y2SDSPKdzeyOwayfabL/XA7RDnfy0eie8HSwCMq4eG5nIfkmiYl4r7Cko+qJ2KddtySxFcQqeSqcTnzJD6ermVrfrTSFu51VQKoPF6T4YNma5eRoDJMHsey+KYbO5M5P5EGKRY/lD7S8q/aW/H3dufjVv9j5yIQ228L58Ukfhkjg4fTwz/GPPRgJYb3RFBjxSy7fd+ft+Nv8K2h2VAZ/edaJ5WlTqZqffhi3m2wJzyIp3mGALATH79uYOs6lV8o8XA/GIR/0GuzaxNS2Ocfg0BpUqjI6PA9qKY3ge4BqHn6LPCz6/Vmo9Ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bp.renesas.com smtp.mailfrom=renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hnVScNJPNbtGO4dm6G0+S7f31DLrAYpcVtVdXeMbXcE=;
 b=WoTce4yseN5JdOa62OLmuRTB3Cgeekk0eADTly3KYsV6IFCeEeDHf1DJvhpTt6v+A9nEwk8p/8aGYssy7XL6lVHfwEbV6A75XQWPeJCOY1ZM11IruGSuGD0pHlDNAKTl7DIeZOHiE1iaaCKAEFzulubi3VliRnYWnCQS0n61WFQ=
Received: from TY4P286CA0117.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:37c::17)
 by TYRPR01MB13769.jpnprd01.prod.outlook.com (2603:1096:405:219::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Mon, 14 Sep
 2026 20:37:40 +0000
Received: from TY2PEPF00005623.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:37c:cafe::5f) by TY4P286CA0117.outlook.office365.com
 (2603:1096:405:37c::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.12 via Frontend Transport; Mon,
 14 Sep 2026 20:37:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.62.32.50)
 smtp.mailfrom=renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of renesas.com designates
 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 TY2PEPF00005623.mail.protection.outlook.com (10.167.240.54) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.7
 via Frontend Transport; Mon, 14 Sep 2026 20:37:40 +0000
Received: from demon-pc.localdomain (unknown [10.226.93.156])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id 98EDF3000437;
	Tue, 15 Sep 2026 05:37:37 +0900 (JST)
From: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
To: Biju Das <biju.das.jz@bp.renesas.com>,
	William Breathitt Gray <wbg@kernel.org>,
	Lee Jones <lee@kernel.org>
Cc: linux-iio@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Subject: [PATCH 06/15] counter: rz-mtu3-cnt: disable channel before releasing
Date: Mon, 14 Sep 2026 23:36:05 +0300
Message-ID: <20260914203614.2035277-7-cosmin-gabriel.tanislav.xa@renesas.com>
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
X-MS-TrafficTypeDiagnostic: TY2PEPF00005623:EE_|TYRPR01MB13769:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 612ec0e0-dd2f-4582-3722-08df12a00540
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|376014|23010399003|1800799024|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	vz9/KLegaA1Ke3WqO953PPx70wUJFD+CsSAldLuVsmput2UgUvN6zWKVXs6t9ozA0Kk7cvXeBWuhE0ZYzkrChbIzvuU/hD+5jPvdhbqFPfJnLuMyK9APKLA/GxZY+d7c5RpcfnZ4ATMvNBRHS674u9EzmzWRqGPv4nQVk4e3Z/Q7XByAOMNI3gMQTkfY9SbDcXInO67CJT3ERup/Mh14UQuna8uiSqwOA9qgjfggP8/fv7UwVMyeF8PrF3EcYAqcZOLTBdwkYQPPzBC77Xnanpo/P4BKnrCvxPRrekwx0WM2iINUlgTtyTxVAhmq1ix5GWJ6GLgpFJRilAoU1YMzm2v7O5+djGe/QU8bDO8Iqc8SHEDW4ZN6vPzYInVfzb7o4o7PUL08TaBDY/5ZsZ6oA7pNlC5MjbMFMpVLhlSpF/ZxnXq9eSRy8RCJrZRpdAvq9po+53/HZYEx3am9Glu4+dwIg3yphLOtp3WlWCYSI0PVwjL0RKiwPQ1vmmiOxKSD1cuhQq0ue5ZbLdyHaZ8iZJAZ4IBofWnI6XT66F57S4VOhQ/KPfHRjqGFIlEzM2/Z2iRKvaIbS+dP45bBufMr8lCIRFLuuhQkQ6P/TNZgcurkxONcnDhleURpjm16MiWE+8Tp6hkKJVfjzilAWhDUpZmP7i1bHwvJ2dz9kPWuGXiL1vLujKbzVw6ZU2eLdkr4+hex9uYQHzuwUtFQ6P4G6A==
X-Forefront-Antispam-Report:
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(376014)(23010399003)(1800799024)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	2l9GBfTVkyTZeTZZ5jbRcKw60lPVRYGbi2B7FwtmQ88hWMzvrEpEowOjXOFbdp7OG+mmAlsIzBjSnPiWL11OnO9xQBDQm//2Yf4JjOHdezV+oKWZlgVsv521rN8WKn7Y3zezSr75h7pOhPZRe/RhKayM7zIj8vhL5Mc0Ku7ph2eCOdc2KuX5WnEUazP85kSu2KPqF4caXWnQx/ayqDmKB4l3oS9wlsMwNo5MyyR51ehwejURcAcku8tk2l3j6Xz0B0c9elb7Ggl09MR4e52pCwx16jchevTooOk2IXVYcw1MQRYM9g5xcZZpimDtFN9AzMF2+v0QX0uWbI9yUZtN4wMAI7+leXp3864hQjckl7mT4YsesbKSGP4f9tLFE5HaxMo1Aj8zlEFP5OTKBXg7or3ORzEZ6GyqqmCo4oJ/6C7Mm2kiewVQ9S7lUW4v46af
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2026 20:37:40.1570
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 612ec0e0-dd2f-4582-3722-08df12a00540
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: TY2PEPF00005623.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB13769

Releasing a channel marks it as not busy, allowing other threads to
claim it. With the current logic, it is possible for another thread to
claim the channel before disable is called, since we release the channel
before we disable it, causing the channel to possibly remain disabled
while it should have been enabled.

Disable the channel before releasing it.

Fixes: 0be8907359df ("counter: Add Renesas RZ/G2L MTU3a counter driver")
Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
---
 drivers/counter/rz-mtu3-cnt.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/counter/rz-mtu3-cnt.c b/drivers/counter/rz-mtu3-cnt.c
index d3daf258a3b8..e200a6548dfe 100644
--- a/drivers/counter/rz-mtu3-cnt.c
+++ b/drivers/counter/rz-mtu3-cnt.c
@@ -458,13 +458,13 @@ static void rz_mtu3_terminate_counter(struct counter_device *counter, int id)
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
2.55.0

