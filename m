Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010052.outbound.protection.outlook.com [52.101.229.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DD384734F4;
	Fri, 28 Aug 2026 15:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787929264; cv=fail; b=kU3EVqtf17KS5t4JPazFVapIS4VAPcUqp5+MHT8c56cFm4RDM7iJM/ddudbEO5iOxughXPuQI3E9ZwD8W+UrZbw1EH3bJ0DV/iGQNqF9DM3oyX4AhmI1gCbx3M4ugK+GA3LrqTFt8TPgZlNzhg4onx0cowG9X323ZcFuBAmGvxM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787929264; c=relaxed/simple;
	bh=jkN9v3klM6JFfxqlNgPJMRKu08WqfJmVEpymwGib1ks=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VnI3LVIyHlFAHa4W0rEL86tcBfBFt2dE675pxzGPmzZlDifhu8JCmqhHCDh8D5UZ3S7ThwJNsap+K4WcOpN7BBoOFhHFyUzvYwkyGFuQQjShyWuyzKF3/Aemowo2ZY7rskL4NCz5YIFmEB6oD5FybeKSprPh9WOM9a3JY1QIV+w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=XhLRW+Gc; arc=fail smtp.client-ip=52.101.229.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="XhLRW+Gc"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S1snEjPpUityFDZ2ybsqsXhojryGJyztSVq/A3WhWoDB9aE7JJmrTbkLmz7VfErfhbMLESTmzvLnTR141kwXDyO6ud0AsyDWyqgxT/wV+BtzCrI8rEilkPTsa6ZvJQY6CJGdkpSb8iSE3JwF4qJ7yTD8yzCqKbYvZsnmZ6SXcZkFrSHhyWbG2duOCUVYAlLzvHL7uJDVBXbppjDWrm2Xko5vvAdJb+yvQSQk5Oem0zbJBgKur2TjlHGFJ5zFn2Z/FUFp7HcFO5Y3n0g3BOtnFS2DCjgRsOvOwraYM/C20cTi7Z7dCJxXW7XQd/UyqpEqwCEztTDvcoodjQ0fzqEINA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Dm7idpmBVsOS4VM/AiRvNw5s0zxrZcLBTZWq+iJzuw=;
 b=R4hSA0exMiJfheUYcee9JjTr7ZdYx68H860t47mZFtZ6Yra2GGaB+jgPieGRpHZ+HRMDSZVeeIx4x903md476ki+TR3ANXkPpvewVSBQBarlGPHPenEn/OWDr/kSI8sxLoU4nyjLvsvZtkWe8GQSYQMBkoJyRkCTmGLRDKeHdc3hNlA4LA5BFpb893/++bN0n22Dkd+k+ks3ZcC8y8KRixLf3tlRC/BXY1sfsJA+XwCjMUOg+1Z1hRaIxBZRoBHuofUV+L4za0se2jNuzklczCIIXiC64TojU/NZoZW/wVF0HoZdjKVN1Rc6vxlubkPeipHwvIZiNGNg02ULwoFzCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=analog.com smtp.mailfrom=renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Dm7idpmBVsOS4VM/AiRvNw5s0zxrZcLBTZWq+iJzuw=;
 b=XhLRW+GcJ9wXuoRf11ttEEyLD0ds0JwpvMOJ24MQ7JAJ5kQAtkQmoj+Bke89yWXxQty9RFbncQlUxnbieXYBpYau70OCSQnPT7WZssEfb+fHE0kSrpA3x2Aq4wBZ6AF5c+N+sYG47vVHGsgXYNtKRb7GoFKvSlcML2LVo8SWGDk=
Received: from TYCP286CA0328.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:3b7::17)
 by OSCPR01MB12550.jpnprd01.prod.outlook.com (2603:1096:604:326::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.11; Fri, 28 Aug
 2026 15:00:58 +0000
Received: from TYO1EPF00005023.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3b7:cafe::5) by TYCP286CA0328.outlook.office365.com
 (2603:1096:400:3b7::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.11 via Frontend Transport; Fri,
 28 Aug 2026 15:00:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.62.32.50)
 smtp.mailfrom=renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of renesas.com designates
 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 TYO1EPF00005023.mail.protection.outlook.com (10.167.240.20) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.8
 via Frontend Transport; Fri, 28 Aug 2026 15:00:58 +0000
Received: from demon-pc (REE-0055761.adwin.renesas.com [10.226.92.7])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id 593BF30001E6;
	Sat, 29 Aug 2026 00:00:54 +0900 (JST)
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
Subject: [PATCH 2/9] iio: adc: rzt2h: store IRQ in private state
Date: Fri, 28 Aug 2026 17:59:35 +0300
Message-ID: <20260828145943.2077589-3-cosmin-gabriel.tanislav.xa@renesas.com>
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
X-MS-TrafficTypeDiagnostic: TYO1EPF00005023:EE_|OSCPR01MB12550:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 10a69cb6-bbda-4f5c-d2a3-08df05152b4a
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|36860700016|82310400026|1800799024|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	jzQ+SnOjKlGavplMvNMNTyjJhb7+Lg/hgQsyTdY3lXRu0PLd6zRyTYW90Fj3qmmANHplJlNJQtHvmz90PMnFminvvCkduyou3moIj7mNuJI98XgiPR9gQpoDi9zGDHMERYphoYD8ZiHawO1ibnFrGZ5pBq77d/9Oiw2zHQizQZhN4N4nAGajnjf1xpU7Eyu+yoYptGODsqd2pYGh7QNiGgNckVxawjrQAKp8F35D+uRYzcjskEWYNIjdVRbMbNYxV+pUa3AK4L9oE1F9poe/4vHnDst+/tGovagXxWzFlhwkdJUl/yreXsqloVEs/5NhzcrYYdNZgrdGqDjr4xBYH6ZkRt1sqe2WtqaKuC1UarC5P7YqJaamwnw8IXYGZoPkbW1QUlmWuNvziYowtX/RMTi0hHu0cO8P2nXP3z8WLzjQSvK6fuCjn2u6Kfd1FfvXaCHYPCq3ucQ2or5j2ZOVOPdltG+wovDuh9p3OnPNu2eaKfrDZ/SY2+JpX98BijL9pI3Qt8Agmzi+unOsEtZbKnXJOUlcl4D5ot0qMUIGZ5dGrFyqvJyll1BR+EpdDWvsSTFTz1ZneSIcQUO2v9S08JVjiPZh3nrepRvyjciVkLk27pN1hCGRb3i7KdSRYS8WmlUhjJngk3iw4QLTgHY9aUFgNz2VqJMS9QnDPhcB5Tu9CsU00aoKZBIN69m2kGZ1V/7Bq27H7DCg9MSHxtpLdw==
X-Forefront-Antispam-Report:
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(36860700016)(82310400026)(1800799024)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Cv3h73gDukslAT5IshKJK2/o0z1c40BEhmLDGGu7S750zA0bcd1vbrszLKSRTJmRByemCXaFNVaGonvJVWOv9lL0S+kbByK8vuRZxHOaYC2IicTPS+QcQ7HbczR2jLRZ61ZOCZhZTN7u+LpxKn/mOKoLYmv/1E2yAWNF1mTw7fdzoF/pRn79sGBHqC8VLD2FvliucZJOYvEASqXN61dpYiBdOa/P1FEDLOESeVu8cfxRq/OliKRMZfKS+CgdCko5aHw05iZE5zB9/1XF94dfVppOEG+ogo+AKLLlIPww+MC5ht9g6qUPHx4t78ftvjLwW0PqTXOcqkr0Skirpnidu7RNth/Zvm0/rhMIwGe823ULritvMfo3W4IsCiuXVyBdMT+aUnv4h4L6yZuKXjHfNw37iWSxy8Zf3z5XBLtNGMWiv+cPYuMGvpdnruCJ4Ij+
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2026 15:00:58.8170
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 10a69cb6-bbda-4f5c-d2a3-08df05152b4a
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: TYO1EPF00005023.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB12550

To prepare for adding support for DMA transfers, store the IRQ in
private state to disable it while DMA is in progress. The RZ/T2H ICU
does not mask the interrupts itself when they are being used for DMA
transfers.

Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
---
 drivers/iio/adc/rzt2h_adc.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/adc/rzt2h_adc.c b/drivers/iio/adc/rzt2h_adc.c
index 42ff6bf2ab08..470b16b5b9c8 100644
--- a/drivers/iio/adc/rzt2h_adc.c
+++ b/drivers/iio/adc/rzt2h_adc.c
@@ -42,6 +42,8 @@ struct rzt2h_adc {
 
 	const struct iio_chan_spec *channels;
 	unsigned int num_channels;
+
+	int irq;
 };
 
 static void rzt2h_adc_start(struct rzt2h_adc *adc, unsigned int conversion_type)
@@ -209,7 +211,7 @@ static int rzt2h_adc_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct iio_dev *indio_dev;
 	struct rzt2h_adc *adc;
-	int ret, irq;
+	int ret;
 
 	indio_dev = devm_iio_device_alloc(dev, sizeof(*adc));
 	if (!indio_dev)
@@ -239,11 +241,11 @@ static int rzt2h_adc_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	irq = platform_get_irq_byname(pdev, "adi");
-	if (irq < 0)
-		return irq;
+	adc->irq = platform_get_irq_byname(pdev, "adi");
+	if (adc->irq < 0)
+		return adc->irq;
 
-	ret = devm_request_irq(dev, irq, rzt2h_adc_isr, 0, dev_name(dev), adc);
+	ret = devm_request_irq(dev, adc->irq, rzt2h_adc_isr, 0, dev_name(dev), adc);
 	if (ret)
 		return ret;
 
-- 
2.55.0

