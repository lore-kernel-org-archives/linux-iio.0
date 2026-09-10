Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010040.outbound.protection.outlook.com [52.101.228.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA82B2FD69E;
	Thu, 10 Sep 2026 08:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789030558; cv=fail; b=D16sW3S0W4xUyj0dujtiiNeR8QvGZoLeZwDVabllPy9UwQXBcUjWvSBgKf6BcMO2oA6Dd5ul9tznslAMBCbzZ6UGN7VBoEX4oKjDHtPn03KAdxhdeQl3SttTpuwnL3RtiTQ7/z6O2LSdkW3VmUm1R1qjlB8bIZ7fjhy5kW6x5z4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789030558; c=relaxed/simple;
	bh=5oz6qBtnBFGfsFATIwoYF+NC6ezZ0MCmST+o5oVKqjU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sUoMoAnWYBS7gwmjzVHbUf1pCtiSIqfaElDZCdmTjzIYK8tAZd9NkP/VHRpETUWnSpGXAJX17/UGixHOtkH2MnoZ1c64SAnP8vXHtSHhebXHM3BKBkkg57t1I2sK2eMtVNQ2zywS8PhwNKnWlZsYU1jcbuXE+i4YVUUPIS5c6Ng=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=AClQbPFA; arc=fail smtp.client-ip=52.101.228.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="AClQbPFA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mcz0edEjviFgac0XwZ3ZKY4+Fk1uy5zxhwbCchwJQdceeUH3Mqlgmi4Jx05OQMnUxjnMhBamXz1qfs6eDRQE1aCJ+TVT+tuNZbyDNqY5mT4wxIm6AkEAUa6zOaGLwCY0aoJnWJEvD3ycOZytjQDyUWclFXHishKIPgQCRMcUkK+w40JArrlWHTS/2ewjkDFi4GjUgPxwG2OASlBGRvRibREnpkNnxbfeyCTzHNG1mERysrP1mFwTu3njDJIV0HOG+YOmMVE55UAZ41CHVhM5mkNuG7tbdT/xDaH2aVH207PPPiyyJyRqi6DRtKufzrAxlXwGr8/bRXkhJzCrsUtV3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gazDAtl73wlMIFyxCmVMp02gnrUH1MH4ZiZSgxrSlTo=;
 b=xOy/5TkGVY8ZZGS+PxSPBoIIhIURaFU5tKNHJA1hwgaOzLwm59dNOmkWwr9fCfDkMM//WhMTa/OZr11YQ90R1UkKMNmjUQ27N1bpx3mTM/plCUHflGbEWuptuziwpyz2c6k/gDWBshHMvUzEaAhMR/CBte9HPByteGu9cZjFBbrhr2SbtMJ4OkSjbh23BMq7rRPI8WDKQVU7yvB/egRvqJRdvLmLZfM1Zq9YhixD6PjvNB1+Cnbjve+KRFi9O3AFVRYlMPk9uzN68/nNH6I48dpumUBpCuzdPCxG8d2M5LfYionGw7lj+QseCYsbI2ORZinZKSXm1Ye9QR/CkB1R/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=analog.com smtp.mailfrom=renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gazDAtl73wlMIFyxCmVMp02gnrUH1MH4ZiZSgxrSlTo=;
 b=AClQbPFAxFg5DaqQonXgZiAAY5Xhr0re2t2VLPtfF4+J3xbGPYD/Spdu0MTiEngSCPPFEl4qNCsiMkzCOvrhR3/U95dvYNQiUZ49XCqN4Evo9IM4eSdtyT2fSooXPnZzxeQBuL1rzBgPNXM799pvKo+y901k4hIC/DVMYK6jxvw=
Received: from TYCP286CA0367.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:79::14)
 by TYCPR01MB18250.jpnprd01.prod.outlook.com (2603:1096:405:3ed::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Thu, 10 Sep
 2026 08:55:50 +0000
Received: from TYO1EPF00005022.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:79:cafe::77) by TYCP286CA0367.outlook.office365.com
 (2603:1096:405:79::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.9 via Frontend Transport; Thu, 10
 Sep 2026 08:55:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.62.32.50)
 smtp.mailfrom=renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of renesas.com designates
 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 TYO1EPF00005022.mail.protection.outlook.com (10.167.240.7) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.5
 via Frontend Transport; Thu, 10 Sep 2026 08:55:49 +0000
Received: from demon-pc (REE-0064895.adwin.renesas.com [10.226.92.160])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id E488C300037A;
	Thu, 10 Sep 2026 17:55:44 +0900 (JST)
From: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
To: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>,
	Jonathan Cameron <jic23@kernel.org>,
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
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/9] iio: adc: rzt2h: store IRQ in private state
Date: Thu, 10 Sep 2026 11:54:23 +0300
Message-ID: <20260910085430.3173166-3-cosmin-gabriel.tanislav.xa@renesas.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260910085430.3173166-1-cosmin-gabriel.tanislav.xa@renesas.com>
References: <20260910085430.3173166-1-cosmin-gabriel.tanislav.xa@renesas.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYO1EPF00005022:EE_|TYCPR01MB18250:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 1a69b4a7-e0f8-4973-500b-08df0f194f7a
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|82310400026|1800799024|36860700016|376014|7416014|10067099003|56012099006|18002099003|22082099003|11063799006|921020;
X-Microsoft-Antispam-Message-Info:
	ykvJ1DjH00WfJd2IZsoRX5G2/kK8L3GqwcD78inUqbnUU/Q0fulE7jsjxZsTGQzRPl1MsBdr+vqJdZLkr/F26vdqSpga+nQ2dJy6kmXV+PysQSZ39uu2vpYQJKHu1iBWdEHN5ZQFsu+uQlkoRw6vjs9andFvROvPPnmyz8o80VNTtA+1e4WwQE2h3yPCrOZkJhp/S1SEQgOxj3488Lr6FUZuOta7MzQuiytL+Ci711dpbMKsTdWTWeyzFFcsEcBSTwRRjxGUl5fAz/IQkYQ09tMcwYaZJ9lkPW9fsEW8uREkVrnpOQ/7SmMBc/7u08Z1pqJxALT06MRLliXkl/dD5k/MDCDrQY0XJ5iiG8I2Cdr0HCwKPfDXvOz6nDDy0w8mQ5KMURRh14wKU9pvu0GPSbVSm9QBMNbGqUMZ9WF4cXlstkqQXI4cO/dWwcyPuBy3Sl+izC/c6+DaL7gaeof4mkkV+ADPLsjbIBBT8m69r0NmBxHwNe/X5wfcsVfqLCaLoGWkdGyzYO0lwXsP6PoeR1l2BNSYRtS+2aIFpA1rZx1/Yw1IMfz+/OTl0e3Pvc7Kkpp0qES7aeFFpAyTTUJKFY0oNO8jevZ5LtfrRjDGR2bD7jmXCe0zJC3cfktF7umdd4Ax8ynD+I4aafJHNMtPpW5n1CDKZU2HhD4hGzMnbK+MNbjiQXIaaPQ3Xy2ZERGc9ER7dBx7+ooCIfozgc59IewQx8UC+B6fhELZvd0YZDpsarXlTtQ6pQpxGNGsTLBK
X-Forefront-Antispam-Report:
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(82310400026)(1800799024)(36860700016)(376014)(7416014)(10067099003)(56012099006)(18002099003)(22082099003)(11063799006)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	eWg7mbj5BrTvRCgUf2yDuhtPT+xoB+txzXkbYvLWIspy7E03cZhlFATGkODYMAHCQHi4H5Cuku1Q2QN/zWZinVF4yxuUb/ijpB960m4+qWaq/cFJ5GnJQfyz1IuHnuUbf7TWY9al7vXF0FpzYQCnzmmW9g7Rr3soPhMNCpeDyaiYXswNlnAiNLilco734uTH5H5XWQF6X1LU/C3A5mk5yhJsMXyb6dAdGcmVFMsU7eaOALWzF1WzQiLM42XcNbnI/Pk1cuvZLe00XVd7X4v8mIggKoujGmlAEmNfLL/tcuyH/RqlFvDVtSImm4JRr+xhn5dwPYXX+HtPwChFRR8qj2JUZXlVNcG0KGCng02PxeG6P4gqj+G3un8swW1cRSGFWsaTPdPnB7NVDXk6yH14wKBfJxp1vk8WxVKFtkrm2/TmR6EHXB8LgAXZ98pxg6jR
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2026 08:55:49.1416
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a69b4a7-e0f8-4973-500b-08df0f194f7a
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: TYO1EPF00005022.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB18250

To prepare for adding support for DMA transfers, store the IRQ in
private state to disable it while DMA is in progress. The RZ/T2H ICU
does not mask the interrupts itself when they are being used for DMA
transfers.

Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
---

V2:
 * no changes

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
