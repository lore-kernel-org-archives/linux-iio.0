Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011060.outbound.protection.outlook.com [40.107.74.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A211647252F;
	Fri, 28 Aug 2026 15:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787929271; cv=fail; b=i76tpbW7gdB/8EkwiHB8eYGsrgPLEI/+UZaFZ955WJeSIcx+sQ42jOhSuUvspmGfLPbVsqZpsFwoWwMxq4/RJnr+9WLbNHIavtWZOzgSjLvQc8g80CpNi4KkDRcYQtz98ravbqKptMTWUyz7YPdha0FRbkvj1RhSqeIFwBVySsE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787929271; c=relaxed/simple;
	bh=CRtrCH8/KzHZqlOh8/Wi1MOrO+eu4I4mWjQgTN0Upgw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YgQnbcunuxXGrq/AuuvaFElNOI/ST1dmL2qNo1Ytl2+b51ms2I3//KCh1x7CyE8v6MmKogsBiKYTi2WCAkUydt4kf04RSerFVBUYALdrRu/FU/DDnxdp/4RKKGBYQlKxf0lw6D6cPN6jcDMgvyH10ShbQ0/Ff016CanVKR3Wz5s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=UBP62Qv3; arc=fail smtp.client-ip=40.107.74.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="UBP62Qv3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dNwdJnZV+lnlDftCDsxo/T9zTvEmY/u4owY+/h3XBPzVgCbUyOTaLEN884xZ0tN9U0ED8Kc8B6534r+QS8DSnTn9orgpOqe1PCoDRpHp6olqEE/vbAyu4VysgSm3B1S+HPtD8aDRMwWnge+GQ8b5hZfVM+v7KmL5P17d1fUIRNrOGG8RBm3MmCbRx8VCmK8Wda5iYWnY2vSlwvRHniHLipmxgOLZ2UdMTfra6hYlV2AC65YmIwJrUHLr9DysEZSaFiSDuf6CtiW2h4a8Q6CYnzQE6QIZ/pON9x7Rdioxwl2SbdFUHJeVaRC07JfezifAc09gxAlJKNkBu61XAaISrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qo5+TSPCX5J9uylX5afTSriyfUVASIF8TaHshMLnM6M=;
 b=xaD28j8mp9VrDrNgPYPnzpDGADEfX9MmEpGgTveOd4+T0KLwDLQNEU1MCVP99yuOKrLI5d6S5E73IStEeAsfIGEuxTaF23azTSasS+SavEqUW70mqpwGzbcX8SRpTMiejnC4+OVWna4MvjMRQqL5CCPqjHFRyajtqM/ceVMdHZSsY5/NoElI8UKXSL+9LGzDdhVi0aEsOCEzotRQaiSDjcQG+/GSUFXMsVKfakg+fahJ9zDjDIAQ7YNiMMnHOliucku8BwgcmTScvhXKxe25/r3UTmmKRVqIe3S8g2plPXVsc7Nf4QfdgdbccdlHWmXzvyGkfiCJPHVsu7g0dOAOwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=analog.com smtp.mailfrom=renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qo5+TSPCX5J9uylX5afTSriyfUVASIF8TaHshMLnM6M=;
 b=UBP62Qv3NXXoAApw+IACyc/jso7CMqKSTZKtru72Z4I4E0YNwjUOLHRvPgaZPSgqnaADmOg3VQF99BSXyohwilTywbNUcAdi28bPOIx0i44QdRKGZyCKWgyBI8KqRJkoLn1lA8fqvHS7CHE4jeMmuT0UJN2ZTCzTJ0sBM+47Mlk=
Received: from OS7PR01CA0060.jpnprd01.prod.outlook.com (2603:1096:604:254::19)
 by TYYPR01MB7145.jpnprd01.prod.outlook.com (2603:1096:400:cd::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.11; Fri, 28 Aug
 2026 15:01:05 +0000
Received: from OS1PEPF0000D20D.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:254:cafe::14) by OS7PR01CA0060.outlook.office365.com
 (2603:1096:604:254::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.11 via Frontend Transport; Fri,
 28 Aug 2026 15:01:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.62.32.50)
 smtp.mailfrom=renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of renesas.com designates
 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 OS1PEPF0000D20D.mail.protection.outlook.com (10.167.240.36) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.8
 via Frontend Transport; Fri, 28 Aug 2026 15:01:04 +0000
Received: from demon-pc (REE-0055761.adwin.renesas.com [10.226.92.7])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id D40C430001E6;
	Sat, 29 Aug 2026 00:00:59 +0900 (JST)
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
Subject: [PATCH 3/9] iio: adc: rzt2h: store the physical address in private state
Date: Fri, 28 Aug 2026 17:59:36 +0300
Message-ID: <20260828145943.2077589-4-cosmin-gabriel.tanislav.xa@renesas.com>
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
X-MS-TrafficTypeDiagnostic: OS1PEPF0000D20D:EE_|TYYPR01MB7145:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 6b58d22a-6523-408c-5966-08df05152ea1
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|23010399003|376014|7416014|36860700016|18002099003|22082099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info:
	gRvXgZIjc55o2dqnsCqc8xcuSRKksEFymw+uM42csHFXLejbU8d9w0QX+wxLnQ0Qqu2UVN32aR7vbCS/ONpDiiinHKNbIYTJa40MDVt9x5os18DM7KO4hLRt5js0uI3i1rN1McXLAMI9EpaYlKXfs/nptZZ39i7hqyW0xdvPg+sHi3PJx5WfU5C++oLlFaQDOg0673G30SKl749x47B6GYku9rmavfBKgp1pd76gBBVdHXneTGflLW7lGWgjRaXs+m3JCXyR3Kl97xFBaeYHDIkM2IeqfTn/VgMsJtOmtaIxFV3z/bIlbt/BsI2WKaosG5mdogGQVNavt56n7trit8a9zg1c1I2hssM7JAdl0kxYrD9k27GjxtafbmInkd/TzfftX2mHov+Ry3PCIS10JFyacojJbW6izkOkbGshTKSzC6LeQa0s8CFxsOBtfdRWJda8h6zXbty1lCSja7tmflIq0+juOIni51tkhrihvxGwXEERvOUIhUmHeYnZ0iGkONufd0JPAKOEI0PQsdFFRysdH/Q56TmIOZPMoHPJIfsO34dyKungSlvGdGylROtZcOzJhiNhpaVr5hZpL8Mk09EteFFKL8W/Odzi1fQPaSkxvOfKL4MQ+qk0Dfe9TNloobMlUAJgmM7lWGle6tnsGgmDm20Id7/BJe5xHi4VcanhNAIylEeEHNvonWh4ZYvA+QRgHPKVXjoxatTfF/+Uuw==
X-Forefront-Antispam-Report:
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(23010399003)(376014)(7416014)(36860700016)(18002099003)(22082099003)(56012099006)(11063799006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	uGDChDDj1Taesk8AzEehbngO/uSeQGM+kR3kwaaWv+6nqg7s7yJ8Ys7OhCrAKI50tkmoLjyze/p/pLZyiqdDdo0EUJHDHAw132iPdtm+dl8bdafSoSqckZAIIeDTRgqgb+y2QGFQKljiZzoHl+5SWL6cMlfjeFclrMbXYPVta2gyN66aqw3fRO6/cmjAPI6BwmX4nRBiTshgd5MGMKIJUbEFVNMiLbF1BOQ6ehaYN33WfiJCimEDDSpSupDiyjbkc0F/GCYdJiGfcuewsS05RXpuljIr6iEFeAz4wlI4n/Ks8a1smEgDkKyg+TmK5fe2memfxWfEyt9pIZeo5MNCCIpClSx0UeDoWc4dCXXYJZ2wa6cilbEznljYCECVEDJ6xXx7y4aVhBRPmIRD+LGQIzDXPKa45krnSjzrdppwNWL2iMFX60/xsf+7RHpJqPA1
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2026 15:01:04.4051
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b58d22a-6523-408c-5966-08df05152ea1
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: OS1PEPF0000D20D.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB7145

To prepare for adding support for DMA-based transfers, store the
physical address of the device in struct rzt2h_adc::phys_base.

Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
---
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

