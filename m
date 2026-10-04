Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011019.outbound.protection.outlook.com [40.107.74.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9B734749C6;
	Sun,  4 Oct 2026 17:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791136201; cv=fail; b=BKKyKyENqR3esQge7VCTORM+v5pgz9npFRnfvklq2y+IMdXEdDrx+u+N/IfYcDf1VK9GTCnL85h0ZZNNlo1eq/fqpHrPs6bsNNUYdb1MHzEi22QFs8oBKdMUOjcrfT7JOKSGQdwD965ocwcymSbexqiEuu3rxwH+iAW+KOzHzNE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791136201; c=relaxed/simple;
	bh=UW3fCJgPGgFWOsC3hgjL/kK1M/B0Sl2zMIEkU20NtOE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nu4P+wGlsEafoZJgdj6Xcq49Fq0YcBih1pc0YjpW/7BJkW/qyCi5yvY1vQg5XpULa2Xdjy6/xKXTrfqNrG6pzMqE6w1hd0D1GgAsKIO17OZQZTF26Yt1eA++b6Tuc70+LYgRRRJJvh8OEXI8PsEJozA6CzQB7wGvBsfQ46E+PVA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=ARwB/GbJ; arc=fail smtp.client-ip=40.107.74.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="ARwB/GbJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wWk29bU5eD8USOgWlT9FYPz3bTUeWFd4GsPXwSk9d5pWa0ByZuTfcmUvNYk4gRt8+RKPE1KUXfg5p2K+EFoGn9RNKjMBqt0i4uTE9d6kL6OpdTsD2ECvuKLSSE5tCBDIXH3pJTkCKUTrI2KoerL+zuzyQVMgvC5hjabSuac4Kwv4s1rc56K4OQXvRdFJI9+33RihOb0INwRLp+AEalrLfJlAI32dCZd2r2fRC35ZKXDEszZ4SbHiNmzdVL9B04icDPZMix/g9m8jWraKvK88aQnUvHkLnDBPfrr+h8/woD27W8QPe8TvJipmCr3t8btyv9OboMhkHpJ1bFRJnEkMWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/mcU+RWWBi10Q9fsJc/woPcstFSnVQ9qYSNzjLUjzGU=;
 b=Y9Io2ndf1cIKiozBLO3gs8EBsEo0w6Y16hvNSf50tg50CFz2BJXppHq3plI43+SuSSqoPsTmqeUBfeI0elTZJy1ZxguJo/KXjgNnA916JjeDOnl5o+5sJ2UftB4qoAgx3RQePPyBCPlOdueoD0tI3qZ0NTHqMto2KYo7coDwOWG23gbp2WQnzgl5rMcE9NWESdOGCOlzoAUZUnCVP8jCSeScRnnklCiT8AMQ0H8VvNbtop1cSWSPcqyCrURT2K+n+cIkzRur/9tNdbxogETlVhKmz+Ux4cV4JdKHZG6HHx+EfEezx01dx/90KLzdVqgUyUi5BfDOXBPmL55EclMIUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bp.renesas.com smtp.mailfrom=renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/mcU+RWWBi10Q9fsJc/woPcstFSnVQ9qYSNzjLUjzGU=;
 b=ARwB/GbJuuysigX68C/xVTQT6B/U8krRRuCBp8Ly3gaAcARgmP5ME0jhJnyZBZ87MO7sHwFiL5tr5AWi9Zl/TYwFLiivrT7UEPxqCYCB1sHH+GHfQSRmuUi92R5vekwJShY6UL/XNiQ7gogzEgjO78tyV9xm2N6z5YZ41s8dmgc=
Received: from TYCPR01CA0180.jpnprd01.prod.outlook.com (2603:1096:400:2b2::20)
 by TYVPR01MB11183.jpnprd01.prod.outlook.com (2603:1096:400:366::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Sun, 4 Oct
 2026 17:49:45 +0000
Received: from TY2PEPF00005622.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b2:cafe::91) by TYCPR01CA0180.outlook.office365.com
 (2603:1096:400:2b2::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Sun, 4
 Oct 2026 17:49:45 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 8.62.32.50) smtp.mailfrom=renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of renesas.com designates
 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 TY2PEPF00005622.mail.protection.outlook.com (10.167.240.53) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.14
 via Frontend Transport; Sun, 4 Oct 2026 17:49:45 +0000
Received: from demon-pc (unknown [10.226.92.36])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id ED1233000253;
	Mon,  5 Oct 2026 02:49:42 +0900 (JST)
From: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
To: Biju Das <biju.das.jz@bp.renesas.com>,
	William Breathitt Gray <wbg@kernel.org>
Cc: linux-iio@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Subject: [PATCH v2 15/15] counter: rz-mtu3-cnt: use pm_runtime_resume_and_get()
Date: Sun,  4 Oct 2026 20:47:52 +0300
Message-ID: <20261004174752.507499-16-cosmin-gabriel.tanislav.xa@renesas.com>
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
X-MS-TrafficTypeDiagnostic: TY2PEPF00005622:EE_|TYVPR01MB11183:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 69604b34-b88a-4486-6fab-08df223fe041
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|23010399003|1800799024|376014|82310400026|18002099003|22082099003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	KCfBVFaT0acJ0VU2V1lqWeteUzF/TnCJwDiEAtFfdvWPsl6vXWZb75JDh32p7YIddc1t85HYmLFuT+YVSqEdCeQ4Yq2wCIcoEiZqLVMqPza5krF89QBAulYjdb/s2szYmhqZFNeEu/opxc549EPoY+8NrqzQzKC/zixWir65yle4ZmfwbOp1TPeNkmD0H2UY/BLhbCKtOch1cOm8JHKZsVaaATZ8rpEwV2fAzM0hKQq1qm/ms5zTJM4t/MiRZ+Ar7EGa5UuRsMHeKoJ2yJr4GnBZNrao8UmbGlq6IJQpG2TIhuRY4z5E6sEYIRR28MxQUPzgQMr6hAztoC9isNSCMJ5dMIhMggZ+zZ6q6zcSXAdDR00ON8eqvBo100Iq5QDNcLDBud9Y/2nb27uPz9Of2VdSc8HYENFLMsg7aRzUSADMJ6tAJ03n3Jhk+EMFzuNaAA8ISuOuE0rWLIYEp5XL4Eqk4vIm6MJrrwLDwY0Uj/d3xC40XPX5dFQCq/G1/otE1eDMYDhnPyHRj22jOYbUZ4RJF+qNStLQb6n/oJ+MDWbVANdECvywmc6mevFVIgSspTomvLF4zT9ub9MCPLzY6Hg3V9vRRaOJt7zSqtOyNPudYHx3f6uh8hY8+efEOJic8y6hRVINqLxiQ568vWJgVG3C51XvAX5PZvWC2ERUK6wVNASx334o3G/sYAAkP7+KU5elzmdRwsH717b8rysEdA==
X-Forefront-Antispam-Report:
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(1800799024)(376014)(82310400026)(18002099003)(22082099003)(10067099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	OcWoyiP1CyFwQiF2L6xv2utB705tqLZGMN4l37yU5p7iLW9pjoFnQc1tSMoc74ESHu/dMYxNo1WZczVY5AjQQaWDUwAKwQ0DRlg7ucfh5IcbgJn/Cr6YoYBN9JOZOzYY8s7yKEu0r/sFUykIFh+NzSrjk8oNRIP7jkmDiN+BoYDB7XUBbhmAIJMs7EEKQTrDwDc2mF2alasMvdTppJjt60au4NcFptPe2had4hc82XFMs1U+erlJ7nZJzQXTHRRuIZLwr2LZxy2uC+LPIl4Bg9u4wK8TH8drIysz2sxWcDFc38qx/q+8kOt7AtCvsFKVnSd1XvXFnD1eCvKEE1h9aNjGBoj38jpY4sk0Ja1cR+NTaFv1u1jQTUgMFIz3ZOEOLywXgxq20FjilZTtqlJv5tkhNGe8Bn526Y6+yZItDhg1YjElqgO3AQn8GfAoiS2u
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2026 17:49:45.0060
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 69604b34-b88a-4486-6fab-08df223fe041
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: TY2PEPF00005622.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYVPR01MB11183

pm_runtime_get_sync() may increment the runtime PM usage count even if
the resume fails, which requires an explicit pm_runtime_put_noidle() to
balance it.

This driver ignores the return value of pm_runtime_get_sync(), risking
accessing device registers even if resume failed.

Replace it with pm_runtime_resume_and_get() and handle errors properly.

Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
---

V2:
 * no changes

 drivers/counter/rz-mtu3-cnt.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/counter/rz-mtu3-cnt.c b/drivers/counter/rz-mtu3-cnt.c
index d1d955ee67f1..83bdda57bf35 100644
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
 		if (ret) {
 			pm_runtime_put(counter->parent);
-- 
2.55.0
