Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.201.51
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793622091;
	b=ik5DyOdQX1DPeoOQrij+51Rz910i3djn5oXoh3kUG6riCZCPrV8DWsQMrzJDtb9YNlfa
	 kKjuSFsCTeb8SLUv1FJBBrhdQsHf4wsHQXsh9XY/W2JsWA5fZj0zEBw4NZ3IRL7evIsYJ
	 jG0lsshlqcYzenjxOcqcjX4lLetQsU5SwMu5JXhcgNavSlyQT/WpUtDs7W5gNs7HmIv03
	 e0xZJdK/+6+5OxiMUii2iNIVmu2S1V1/OGokc+x9yYN4ObjHHZNE+oo4jsepDvb1jXNoO
	 ZkoLGK/P8ZhHaemcVxQcVL82R8lqdCmU2F0yUxKi9V57DOLWCi8m5Vrxz76pZad73zg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793622091;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:Content-Type:
	 X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=Nx2k7pxdxbHfW3z6fYRnQeSZE2Mryn1gxwQy+BH+xc4=;
	b=qvYK0HciAfQoG9pyxwzufN+llG24mL3l9AqmGQAZ+R9HtSFbsOZiRbypCYjEE/NmmAbJ
	 +mP7KonCUFASQR/FnUo2Q30QjGnvsEq+/NyEgUFCOFplrVIZxebHUXixs7s0tZ5DGKjSm
	 jWTn318V4x396LNsSYDwgaFgBHUlUBZ36HxTLESis1AvCMO8GevYNftnG3OfZ7SwDK7B8
	 ebjcZgfDP3P05YzBa38tjHmc8p9asQjSBHKe85BxDK8InWMlZp1F4p2tI+fUjCJK1Zv0a
	 K0Jscber7ntJJhYOy8IgVJmEyiKcNahU3WpzOCwEGJ8bEbGqspQZ1hA6NUmHw95bC6A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=o9AWhKOL;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.201.51
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010051.outbound.protection.outlook.com [52.101.201.51])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9B0A606A326;
	Mon,  2 Nov 2026 12:21:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D9B0A606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=o9AWhKOL
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nx7OWIu5yPZnmp3nn+mUKwy8opMvhQqcv4MHJuaE3Bodm38QylQxesgeRWhevD7zWjCVrBcfpNxdyeDbwdv+ZRIkwnsRAAqD1q2RT6DnDDiXE3HWJhnX5Lt8IRR0EIQQX3LtQlY6kp9Oe3ZlQPpas0i1hHdaPDHnnw+8ugRcMQyYR+dmQU+tcqgk5qsy/ANOM/nvus3BsY2IaW3lbZ1HgT6PdsH0ocxFVi4DGGmejSSML3wGhB0vPfPNqOGKcRFvczqqVYaE9Q1hiwIbSZsyohCd4Xqg/XJ18wxVyFncR49025fnBOfYfXlCvRVKFfPOcgO/rejpRYTZ3OrEwMFK9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nx2k7pxdxbHfW3z6fYRnQeSZE2Mryn1gxwQy+BH+xc4=;
 b=OVt95COKdjkMu0fcTHyXTHXWDJWxdI9YRc0rOwVHYSaYDZCsse6X5cR+JVFAbqDGmGKk59Fv8p5kQUtARE0tgoHPW2nTHxJGjT/J2nhS1fY5sWtHHkON+Jq7fCVMahiS75CAmFhU6OgMGexEfVJKpDYBfqFchpVUSwOf5fjBtVlgIm02+mEMvPpALLDdNvI0se1fcN/LEy6C868GX3xb3YvBgw10vFFc7ubd+pgPzJBeVki1hDnS5KHGFx2xxcQ9laxbN3UQenXyU212YCp+huZZ+jIbkSGx7JkRZG3A+Qjx74SUrhlXkD9c14oNSbuhuM58l3Btix3idmy1OQJWng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nx2k7pxdxbHfW3z6fYRnQeSZE2Mryn1gxwQy+BH+xc4=;
 b=o9AWhKOLF88Zm6qqJAr37h34zdXjdIQi5EbCdoi+pZKv5xLspMEJUljicUXBmjHYnSAXmX8IZAxFp8Z3MHeeVbJz/c8ZG9QLZ7LTrJnr8U1dT0+CYM8v+T6S3++x7/ajvMMwheVUWLQyVf0LDv6ZPk7qaOUqIzzqNvRGDHgpoQA=
Received: from MW4P223CA0006.NAMP223.PROD.OUTLOOK.COM (2603:10b6:303:80::11)
 by DS0PR12MB7512.namprd12.prod.outlook.com (2603:10b6:8:13a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 12:21:25 +0000
Received: from BY1PEPF00026968.namprd05.prod.outlook.com
 (2603:10b6:303:80:cafe::8) by MW4P223CA0006.outlook.office365.com
 (2603:10b6:303:80::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.12 via Frontend Transport; Mon, 2
 Nov 2026 12:21:24 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BY1PEPF00026968.mail.protection.outlook.com (10.167.244.152) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Mon, 2 Nov 2026 12:21:24 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 2 Nov
 2026 06:21:24 -0600
Received: from xhdakumarma40.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Mon, 2 Nov 2026 06:21:20 -0600
From: Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
To: Jonathan Cameron <jic23@kernel.org>, Michal Simek <michal.simek@amd.com>,
	Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>, David Lechner
	<dlechner@baylibre.com>, =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
CC: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<amitrkcian2002@gmail.com>, Amit Kumar Mahapatra
	<amit.kumar-mahapatra@amd.com>
Subject: [PATCH 1/6] iio: adc: versal-sysmon: fix race in interrupt teardown
Date: Mon, 2 Nov 2026 17:51:07 +0530
Message-ID: <20261102122112.1723130-2-amit.kumar-mahapatra@amd.com>
X-Mailer: git-send-email 2.44.4
In-Reply-To: <20261102122112.1723130-1-amit.kumar-mahapatra@amd.com>
References: <20261102122112.1723130-1-amit.kumar-mahapatra@amd.com>
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
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF00026968:EE_|DS0PR12MB7512:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c128a70-fa4a-425b-e0a7-08df38dbcfdd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|23010399003|1800799024|82310400026|376014|7416014|261021121427099003|261021123027099003|261022105027099003|261022075727099003|261009223327099003|261009223027099003|261009220027099003|261009221727099003|261009221227099003|261026140227099003|261028144727099003|11063799006|5023799004|10067099003|56012099006|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	oH2+cHBgVCX6oJCbZ9jVNHUubIGENPsrYw2gNA8lVyyUoanZB1tTcitHFLTqqQ3u1dnvKkrPbWw7y/C4Sk9jYt9HVUBF8pPnDdktruRHMI5L7oa2DU/TVi4KBWscWi44qN0CQkPdBqfgpjKSxyH+pGQqM0fPI/kygKiNTvzAngXPEhOzQhVcWHfzhiiGiAH9hconh/Oz1/WJxwkdLSHTHHP/hHlnaaIhF/ttAIBPLyS2MyMz3Qf009rUdY6LG8E9ErL5M6Z+Gh/aDrqHiogzI0/54wCIW9RdEsoQDjkylczCOrSyiA6SMD+MOM17Ayy9MXvZaVG+VhwFVjoE06RozJlJZsq6+da7LLReS30ZarBHfVsl3Ili7F7GVZiT/XKcHTnIZhXJG5Nh2da1ogYULUEJ50RYGqsFamhzpYMJJxSTxbE1xNd+Le+rooRov3wU5evOHCyaiTDRC0bFIee4ujRRZu9UJ3qJpuuo48QlZUU1f8XY5uPf3PxBeiTp1rnBpq6NbZ4kEO4L9poidx04Drui5b15/udL0o0mUL9LZJgTLQzW1gDBPbh+aDRCX9ffJ3kaWPkkj4Q3ddrsKno0wMnBqR7lWWHpIT/AOuRAfMgpNrAYO57j/brMmis4xQvoM5Y6feEf24KMxAwKXEKtJOUBJxz+Rp6Zl1x5+edobSvhDlP3/Y+x8rEqCEPzk9zltSXmiTfUEpcQiPDDRkd5YA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(1800799024)(82310400026)(376014)(7416014)(261021121427099003)(261021123027099003)(261022105027099003)(261022075727099003)(261009223327099003)(261009223027099003)(261009220027099003)(261009221727099003)(261009221227099003)(261026140227099003)(261028144727099003)(11063799006)(5023799004)(10067099003)(56012099006)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	TBP/kytg+yhfXaapKxAdtFBKIo1j8uQQJGFgLwgXL90TDPO4XC3cfKEgfv7xN7tGgikaNjWcr1E5dVi4T67L3/H6ohERQ9smYZwUznzXDYDo5KODdHcBsT9B7rta1zlqOhENV1CReyRzIQe72ITH5ypf8M5zyWf+fewjdscvTKQfTvfAygEQD2xCsAfplBmY9GHBwvCJW/44TexkSjioDVBVFoXAoe+9DQe1f7qPo+j9mb9Lo2sJxfQpqEFfi1f/NZgkaZY/NaHEheepEBtZq1Ua4qNuNO2PLrQ+8qGPu/Q91wezyLsr0rztpwe6S6LGdMDuvk0RqNwwsXii2MjoGDFSPRYfzSpFumAgAYhDwiCaE1BrUEB9hNJjWQwFfhYyozPtP0aTQYd0aIDCDUt22bXeDl6nVv9vt7oAPXSsclBQeKbJyf6YgiWQtmGn3u9S
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 12:21:24.5574
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c128a70-fa4a-425b-e0a7-08df38dbcfdd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BY1PEPF00026968.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7512

sysmon_disable_interrupts() masks all interrupts, clears masked_temp and
cancels the unmask worker, but leaves the interrupt handler live. A
worker that is already running can re-enable an alarm through IER after
the mask write. If that alarm fires, the handler queues the worker again
after cancel_delayed_work_sync() has returned. On unbind this action runs
before devm releases the IRQ, so the queued work can run after the
devm-allocated iio_dev that embeds it has been freed.

Disable the IRQ first so that no handler is running or can start, then
clear masked_temp and cancel the worker, and mask all interrupts last,
once nothing is left that can unmask them. Record the IRQ number for
this.

Fixes: c7f7eb10638f ("iio: adc: versal-sysmon: add threshold event support")
Signed-off-by: Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
---
 drivers/iio/adc/versal-sysmon-core.c | 5 ++++-
 drivers/iio/adc/versal-sysmon.h      | 2 ++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/versal-sysmon-core.c b/drivers/iio/adc/versal-sysmon-core.c
index 1b55d343982e..6b9a58e19831 100644
--- a/drivers/iio/adc/versal-sysmon-core.c
+++ b/drivers/iio/adc/versal-sysmon-core.c
@@ -781,12 +781,14 @@ static void sysmon_disable_interrupts(void *data)
 {
 	struct sysmon *sysmon = data;
 
-	regmap_write(sysmon->regmap, SYSMON_IDR, SYSMON_INTR_ALL_MASK);
+	disable_irq(sysmon->irq);
 
 	scoped_guard(spinlock_irq, &sysmon->irq_lock)
 		sysmon->masked_temp = 0;
 
 	cancel_delayed_work_sync(&sysmon->sysmon_unmask_work);
+
+	regmap_write(sysmon->regmap, SYSMON_IDR, SYSMON_INTR_ALL_MASK);
 }
 
 static int sysmon_init_interrupt(struct sysmon *sysmon,
@@ -807,6 +809,7 @@ static int sysmon_init_interrupt(struct sysmon *sysmon,
 	if (ret)
 		return ret;
 	sysmon->temp_mask = imr & SYSMON_TEMP_INTR_MASK;
+	sysmon->irq = irq;
 
 	ret = devm_request_irq(dev, irq, sysmon_iio_irq, 0, "sysmon-irq", indio_dev);
 	if (ret)
diff --git a/drivers/iio/adc/versal-sysmon.h b/drivers/iio/adc/versal-sysmon.h
index bb9a75bf71c0..701ef9b56263 100644
--- a/drivers/iio/adc/versal-sysmon.h
+++ b/drivers/iio/adc/versal-sysmon.h
@@ -85,6 +85,7 @@ struct regmap;
  * @regmap: register map for hardware access
  * @lock: protects read-modify-write sequences on threshold registers
  *        and cached state that spans multiple regmap calls
+ * @irq: interrupt number, 0 when events are not supported
  * @irq_lock: protects interrupt mask register updates (MMIO path only)
  * @masked_temp: currently masked temperature alarm bits
  * @temp_mask: temperature interrupt configuration mask
@@ -101,6 +102,7 @@ struct sysmon {
 	 * that spans multiple regmap calls.
 	 */
 	struct mutex lock;
+	int irq;
 	/*
 	 * Protects interrupt mask register updates.  Only used on the
 	 * MMIO path (fast_io regmap); I2C has no IRQ and never reaches
-- 
2.34.1

