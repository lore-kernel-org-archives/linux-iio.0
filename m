Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011038.outbound.protection.outlook.com [52.101.125.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7F823D413C;
	Thu, 10 Sep 2026 08:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789030560; cv=fail; b=Bhp1IRyQKET9csBBuLaE355WJ7rZO1rbeEgNsGMvlpdiowMT07zFdB20ayZpM77dJWrhH2joEfs4ia5gxBWqTUj78CzGXnjH8XkQio6pBQTdsMcnYEeXe4zIxEpX+iyTzMtnBCZri5d1/2Y3qE6lH3n3c3vZ0oj+8MAIF1C9isQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789030560; c=relaxed/simple;
	bh=eueDfcwV2zu8sg8drYYC499AFgyDDR53s4Xa/N6nNYw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cU+pmbImSncEcOdbFhpp049cJexKSKH4irOKHa1IfjY/G0ZovNcMJLfIgxPsFh/QWQktvXoJO97mTwzrE+rUr/XU5j/fWRm7Fj5Bsx0ek/bzND1HMAmzakWq8z+Cxd7aAnbnsY+i4T791q1g9VdUkDLoUfR1ggZsMZbvex7+VSs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=nxTNWnnk; arc=fail smtp.client-ip=52.101.125.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="nxTNWnnk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CCxP4mNR+yjLEPEdDFeR7ULcG6h8zck89Ht+SVTG5A+jAHP7S9EIrnmmjxvcZP7Y/M1NghRVwj6Bxd4frukeAnh0yE4U2DLXgRuQVzZRbLiO14HEgqbnEjzolhHLQLF/C+rL1P3WVg4RHRPHyyMU6CYdinyG0rkfB6sORD5v75vfqxbn7w1aBZeKvrGHcd6wWCubzU1olaVFXY5/T/O2sZjfQcn7k7jjAyxCRXDL3sDrK9RpiDe3tfECIjO16guq+0o/oMdHdRuEtA1BBJJG7N8JICjVIXYY7uykIquZ/hHUWyuUyFzjlqEcuhZmJPeUSB9TuVt5O8d/Y4HZpXmyJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MTDYEOKUmqY+BChOLtiRfOy7hClC2Ikj17Z3TNAUmfg=;
 b=UPuv38x2Ueb5AYZHqsA71tfM/KO6G1CHs3pXjdPx/kXVMaZZUZtppfGPcw5ksOQtoYcmQsxDIJnM32ZWM1hddy5GFH2Tip4C18Nxl7ibwZhAlUxyDQ5bR2CFiVjgGSJPGhMKVIk52QoHHTX0KyB360JnKOKP0jKFoIExWNIIBgxu2lOlmm1PUTwYnKOU9kVKtFSMD6amRny+p0qC8YOsWD1ZjWFatwPJ8Lz29LrxXYxnDdmiii8v+Ap0wC944ZmMQgayiJJOzPUq+8lNyB5UfnqLowouWTdPL2zPOOq0SOwkrfSBSrc2yA25QTtNL4N/MrAcrjMHAN52VVASDT/w9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=analog.com smtp.mailfrom=renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MTDYEOKUmqY+BChOLtiRfOy7hClC2Ikj17Z3TNAUmfg=;
 b=nxTNWnnkdCRVe3qqY1qb3Hczie33xZnJS9RJrVvwiPxIBMw2HpyuEkr8y9mo1TsKWVpAUxGHScuRN+NXfaPiuzKUK/fz1twGjgZVLNburCZBhZPJ0bUQu89dTA4VU5lav7x6PBmAYVyqjYJY5fwQ1OjiMqfqRZosvRnOFDLTu68=
Received: from TY4PR01CA0053.jpnprd01.prod.outlook.com (2603:1096:405:372::6)
 by TYYPR01MB12355.jpnprd01.prod.outlook.com (2603:1096:405:f3::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Thu, 10 Sep
 2026 08:55:55 +0000
Received: from TYO1EPF00005024.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:372:cafe::6e) by TY4PR01CA0053.outlook.office365.com
 (2603:1096:405:372::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.9 via Frontend Transport; Thu, 10
 Sep 2026 08:55:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.62.32.50)
 smtp.mailfrom=renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of renesas.com designates
 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 TYO1EPF00005024.mail.protection.outlook.com (10.167.240.21) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.5
 via Frontend Transport; Thu, 10 Sep 2026 08:55:54 +0000
Received: from demon-pc (REE-0064895.adwin.renesas.com [10.226.92.160])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id 110F73000228;
	Thu, 10 Sep 2026 17:55:49 +0900 (JST)
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
Subject: [PATCH v2 3/9] iio: adc: rzt2h: store the physical address in private state
Date: Thu, 10 Sep 2026 11:54:24 +0300
Message-ID: <20260910085430.3173166-4-cosmin-gabriel.tanislav.xa@renesas.com>
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
X-MS-TrafficTypeDiagnostic: TYO1EPF00005024:EE_|TYYPR01MB12355:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 0e559282-547f-446a-7c10-08df0f1952ad
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|23010399003|1800799024|36860700016|376014|7416014|18002099003|22082099003|56012099006|10067099003|921020|11063799006;
X-Microsoft-Antispam-Message-Info:
	4xjmJLw1ISEyNmqn+SKCV4+NQ5zguaAyp6g7vxGAiWNKnT/s5a7mlOGse+ORvLMJwXhrXZmRok4a3Q0QKqClNXExtNAZBSGid5RDJlY0Lypv2/ffkubSwkC/QzhkCCAR5xWBoh9HQIKY6qbrdlUx2BFsNzDNadcPwbOfBKaAOgTpLquKElwjvby6ScRINcO2e3h4MsuwwC3j5dTcv4XHQwQ4AB0p50kMMSE2mRb311JxdffsuBsKUqE5BY7iV1UC4loHAk7wzOlKpEH9orX6p6nD/JJzCXkxJt1D9omUptlPgWZQrb/Yp9TCfIihGS+yqU0IPmj/d3vgcRojsv6BH33hjRucFSF3WbTSWETbE5mWBuytGg6ZKvzwiDIHz/HPgKTL38zTvp+IhHjYBM/4clSyem7yprrmcoT5P/FJsozREFD5C1mX49+pwk5t8GYTROPGGPMv0uqCjASdsouvfy/FTydi9VfeUJw0gGMdcIF0ElOB/cUYTixI0Ig7hHWkn+0EzrVt4Kd4wLBlDVUHHknmvUvARLPInA690qh4tSAwtkLQ5WxQzpngwOZz+pNfsdgQ9HWTWrYDayvTjB/U1mVPfqZ7kig00Xnki2Pk2vSnwJtThG1RQsOfOmW7X+D8QLfjc6C1Qo5U2Iug6U/01TTIaWBFmKq0qPeQaZRER+IyA4nWFNwWgySjO9R3/tuW5PvLYI5i8n4O3dUCI8EtfD4OLhrgKnTQqC6Vda14uvOprLk3R6pOlKuZ93tIcD4K
X-Forefront-Antispam-Report:
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(23010399003)(1800799024)(36860700016)(376014)(7416014)(18002099003)(22082099003)(56012099006)(10067099003)(921020)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	gZqUaaJuSeD6hKEe+Xanlw0x9w7isFOLYdYBVu5Kb9pWo8feALOq+smMvcSWkwU8QL9CwDC94qX2V8iW56pVG7H+WsY8sHnZqj8jFypLcikfiY8/YVGVFixZv4NRpKedQgH/rgDxZgMlOit6fXtQvjwdUq4GufjvyCzYkDS2xwPdfKpnilZG1MJoBbsDD2vn4lxTo9iFw+crQMIm81P1GsRbV+cyTgokqolx9uAhE38t4dRCrgSCBd12+ewD2P/kk9fqMzcYBzjx4G0M7Hni8/FF4Vpl545KMfI+c27xRDdvbDElFXxUAsXf4Nbh6uTEr2Lp87236oK9XicCwfQ4QGXb07Ip4vhfQ8A2qnBEpbjwBkr/ifPYgk9G5pgFw3bavG7Frar1M3EyLsFUlMj0lF4fPMPJswAbzVySExoYOCONXsN+N771nkdw/bImmdNT
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2026 08:55:54.5112
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e559282-547f-446a-7c10-08df0f1952ad
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: TYO1EPF00005024.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB12355

To prepare for adding support for DMA-based transfers, store the
physical address of the device in struct rzt2h_adc::phys_base.

Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
---

V2:
 * no changes

 drivers/iio/adc/rzt2h_adc.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/rzt2h_adc.c b/drivers/iio/adc/rzt2h_adc.c
index 470b16b5b9c8..995308a419f1 100644
--- a/drivers/iio/adc/rzt2h_adc.c
+++ b/drivers/iio/adc/rzt2h_adc.c
@@ -36,6 +36,7 @@ struct rzt2h_adc {
 	void __iomem *base;
 	struct device *dev;
 
+	phys_addr_t phys_base;
 	struct completion completion;
 	/* lock to protect against multiple access to the device */
 	struct mutex lock;
@@ -211,6 +212,7 @@ static int rzt2h_adc_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct iio_dev *indio_dev;
 	struct rzt2h_adc *adc;
+	struct resource *res;
 	int ret;
 
 	indio_dev = devm_iio_device_alloc(dev, sizeof(*adc));
@@ -231,10 +233,12 @@ static int rzt2h_adc_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	adc->base = devm_platform_ioremap_resource(pdev, 0);
+	adc->base = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
 	if (IS_ERR(adc->base))
 		return PTR_ERR(adc->base);
 
+	adc->phys_base = res->start;
+
 	pm_runtime_set_autosuspend_delay(dev, 300);
 	pm_runtime_use_autosuspend(dev);
 	ret = devm_pm_runtime_enable(dev);
-- 
2.55.0
