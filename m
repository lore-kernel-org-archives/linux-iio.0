Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011043.outbound.protection.outlook.com [52.101.125.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C25504570E4;
	Fri, 28 Aug 2026 15:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787929279; cv=fail; b=LfsIRkSNDOeLl9F5k6FG3KAzRsDQmrz3sOprTJj22KB5DVC8RQV2PcMZRCG2u2IgFz4sxJGBeZ0qmE7xtspyzhiR37oEC95PgdjsOf0kTPN4zIYWsKanIc39sbvTskZFaR09REMhdMkrpdLzbzcy3KHctrPqrZgQnloD2fTmicA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787929279; c=relaxed/simple;
	bh=pbqJiRHltT1oEl3dL0JMnbmr4Y++3AxAmjiUlJsQhws=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CNkaqvjm/lqAGnZmO9UxIqwYpkblNK7JeldsZgCrlHSztw7MdytW1obfTCTIO4c/uqFAd0UwMGwGiaIaegFJyo4Yxc3spzhg66PRas/qsVPiScYRWSeRr5cFNZAnmY9NrCz3NoOrAoAiPBs34bRarRgqhxKZwNalJItx+iqcZJ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=iVPI+hSC; arc=fail smtp.client-ip=52.101.125.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="iVPI+hSC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pJ4Qf61Fg0nSpHlJgc8XyRKzoTWOSiGRf/VoR0lYGd+qi72jFj+YyKpLNtHA1J1lRLIVKIAOQH313RyOIO068IRQGbYaUCoodNZNMtvZLGh+J942hdM3/P1VPndX8z2d2U/OzzcacibnhZ1NC7FJa9xjlpNRnAL/sdOMU8LLMjliOZYvoU2KaJl6JWqEcOO94TI3BMD6ekf5Peml99EqNVn12YtaWuVmzN/OJ7mnINYNXJ7+z3bHF8aKh2p9TqzdNBv9YeIowCUDkyVT2z5uF4KDVGmExhP5RQtGNr2joE89z6FCgN71ZDdwHYfMX9nTUcukwy1p71vFBt6wdVWxUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dJAYDORM2ee+5qrwEzOgor+VhfZLVKvS+zg9kUfopQM=;
 b=esA3swFhLYNGibZpkTGG342xduw941Qo3bEuiEoVnpJ8jnk+WMIkUhmQXUibC2Hr6p8eA2q6QI6DidZkwVF1QgAhvXlUdO1WSO5MljEYh3qYXYT1kcv7oT30R9P8vsY6ByM7pk/C4yAc2pzW3b2k//4WWujBktG5R51YY6LCCFFDgC4pmU0+KVlNTo4k4MJp7ZVkYa4aE25LaoVI3YV6cx6JP3LScmSfLF6O+KETdPWQ4SQcwn8GcWkKPcK/fvI3cBIR3hCt2m8KTAcbgdY4iaUcV2wznXID6MF3MaApKWRtV61pDbew/qlqFFlRqe8rsAj1znRfqzsFTswwb3KBHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=analog.com smtp.mailfrom=renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dJAYDORM2ee+5qrwEzOgor+VhfZLVKvS+zg9kUfopQM=;
 b=iVPI+hSC4nb92M3IE+bKA73RBup1vHuWmeY92CUB4PS6Rrb5eTjEqJzTYNyoveGmFnyudERb0SauLZtJsyQbzD+POBZZPwn6C6GZZQuumDqaRT4IlSeGBQZO7oh+XLcwC5iXnZri6wWf4QdeIug+wDXemLb0U+HpwLUcHUwr0Ck=
Received: from TY6P286CA0012.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:3b8::19)
 by OSZPR01MB8848.jpnprd01.prod.outlook.com (2603:1096:604:15d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.11; Fri, 28 Aug
 2026 15:01:12 +0000
Received: from TYO1EPF00005021.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:3b8:cafe::7e) by TY6P286CA0012.outlook.office365.com
 (2603:1096:405:3b8::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.11 via Frontend Transport; Fri,
 28 Aug 2026 15:01:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.62.32.50)
 smtp.mailfrom=renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of renesas.com designates
 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 TYO1EPF00005021.mail.protection.outlook.com (10.167.240.6) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.8
 via Frontend Transport; Fri, 28 Aug 2026 15:01:11 +0000
Received: from demon-pc (REE-0055761.adwin.renesas.com [10.226.92.7])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id A7C09300036C;
	Sat, 29 Aug 2026 00:01:05 +0900 (JST)
From: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: linux-iio@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Subject: [PATCH 4/9] iio: adc: rzt2h: claim direct mode on single reads
Date: Fri, 28 Aug 2026 17:59:37 +0300
Message-ID: <20260828145943.2077589-5-cosmin-gabriel.tanislav.xa@renesas.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260828145943.2077589-1-cosmin-gabriel.tanislav.xa@renesas.com>
References: <20260828145943.2077589-1-cosmin-gabriel.tanislav.xa@renesas.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYO1EPF00005021:EE_|OSZPR01MB8848:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 70ae3ebc-b0bf-4be8-31b7-08df051532b1
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|23010399003|376014|7416014|36860700016|18002099003|22082099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info:
	SPEQ9BPnLbbMkVqxvSxWnNWiBDT+Y2tMzx+eXCYR1TNwW3JyaTEZOD7+gkbe6qkYWziUkuOyMWc8PTBzgo2Dlb4ybTePZITPek9jdAcgYB0skOJpCvJeZZSOzWbnYKawJpZxKZoNJNLP4kzeTGPhxXjv59+bIL1BhDJFruhorzOlnFC/S5ZPMxVhX2pMaQ8GN80bPW82yX+Wh2i1i+5mqQUXlAtIsd+1iu+BUkRhhwNyO3iaa/OZdBNmdAYIoQA68B+cPgZu3P5rWWucaKcTnIzj40w/iFboOL4qfSv/nsiSL36BQXJz/+qenZOVtlTg7LmsMLc9cG8ZrrhqHjCbEoC2CalJJsm5a/FJfuMVym4sB9WDubuaawWAOLD361uBx/fbLDdtGj0GDo0vIDCNyQeyPQ388yjpADHDomxq0BWBpnqcBYPBcrjACBERX6+OkD6BmXTnVQeKWLJe6ulcanwoJEF/E+UHrxz9RkombBTEt3XoHGoMbEwEFzKtc07NTBLLutlZEA8sXEIR5vHPse5E+KIwYdI2X46qXJMZQQ6T9GKu1QSz6aH2vzygnHKDEE1Um77BB8DxC0bjqxPsaegHUL7CZEAHuFxV6KsOuBv12qW2Bv553PHfPzVDz+cPle+kYnXDL7M17dEwCmvo2kDwn6JqMBb7y5qqgoORSNB5XfmMQBDj3dXAVyS8r9I8pI4V6XCJUzpk5mV5Lfdf8A==
X-Forefront-Antispam-Report:
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(23010399003)(376014)(7416014)(36860700016)(18002099003)(22082099003)(56012099006)(11063799006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Myb/ZY5n2GYNe6ZwIcm/baUtp76oKJ+5VUvJccWAMFJIebw6KbFSjjYkXZBxbmcBngExhfZbfJ8P7gt1I0by1XOAjsSV1XF/algobz755OfMobOYl3Ta3RCtA8im4ChrIZQC4tEcX/5gFwcCgazApR9GL9qaaj9dKfPN2w5phr9hXuE+7DjTtB2VbvfiPH4N3JNyTHkYXGosugnNK+3F8mcyNHjRsey3VN9+h1CrZYWSmJ+KY1xKHYHVJRtoSnddbCV96hUA3iGvAs8ANg/rXJKYpYGqNWfojk1H/m3Z1yTyM7ELXReUmuGvsWWIXhTcEjea/dVGL9Ir4rAQeyCbMP/un6AamUb+Kef8i1ib0Bb+DK7KINlrJUyj2NEGjJ2uSd0YubCrOFZyTpYrjbxAgZoFeBTSg8+wuNMmYfgtLj6NoXf0rw+ScDsK1Zcc1+Bw
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2026 15:01:11.2325
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 70ae3ebc-b0bf-4be8-31b7-08df051532b1
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: TYO1EPF00005021.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB8848

Claim direct mode around the single read to prevent it from conflicting
with an ongoing buffered read.

Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
---
 drivers/iio/adc/rzt2h_adc.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/rzt2h_adc.c b/drivers/iio/adc/rzt2h_adc.c
index 995308a419f1..95bcebdc02cb 100644
--- a/drivers/iio/adc/rzt2h_adc.c
+++ b/drivers/iio/adc/rzt2h_adc.c
@@ -158,8 +158,13 @@ static int rzt2h_adc_read_raw(struct iio_dev *indio_dev,
 	struct rzt2h_adc *adc = iio_priv(indio_dev);
 
 	switch (mask) {
-	case IIO_CHAN_INFO_RAW:
+	case IIO_CHAN_INFO_RAW: {
+		IIO_DEV_ACQUIRE_DIRECT_MODE(indio_dev, claim);
+		if (IIO_DEV_ACQUIRE_FAILED(claim))
+			return -EBUSY;
+
 		return rzt2h_adc_read_single(adc, chan->channel, val);
+	}
 	case IIO_CHAN_INFO_SCALE:
 		*val = 1800;
 		*val2 = 12;
-- 
2.55.0

