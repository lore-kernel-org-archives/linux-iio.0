Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012068.outbound.protection.outlook.com [52.101.48.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36D2E486BA4;
	Wed, 29 Jul 2026 12:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785329774; cv=fail; b=gudNdEjdM4zn7v2Q2ZlOtmOZAqEUeYqBpJAVBFWr8ZD2kz+twCMqvPg6H18kplQoXmDSKxxhy06JuggLH/uTXli+9gMldGU4CPmuJnBq/qiVsgYcAKd2x378kd6nv0B9dXt3RSFSuwlkbtyZU8qx8efRHTbJUid9013Ueet+lkc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785329774; c=relaxed/simple;
	bh=TYSqNk1DpJJ9phJ1h4Vr6inHnnNOB84vu7v11ePeOwU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LZyB+kHs9EDqIoLd9M/4XuWGsKpzslBRpwkJLWlVRxpVrpNXAHH4E+tTVEw+NneKAGg8FQr7QnJ3tvzyljsPdIKNbJyJsxlKI3xVyL9bmNGD/bX0YSkRyAY3VKAXi0WQtsVgV9P10sfby50ORvF8t+6i9YsaeaFThYelFNKQFEU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=jDv3KzSu; arc=fail smtp.client-ip=52.101.48.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="jDv3KzSu"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ge6qBzIlixo4wze8uCrTu2dyKtz5IOkham5wdejitidQ7VifZt2Mpcl9dG0NwbHf8N9mKHEARq9RF3B1s265aNlO0WKxHUmxP9hYgz5mcAJkPXQW2JlUPH/Na+ZJwm5uO/l0qaQmKJVP0wAZv6qR4HKN6g5bjtRWCb9wxihYnjJKAsZd6UNCO+rVrIgBTA9YmtMbHv4ruo1aqCnsyBhn+L9xQRxCwdzUCovOyUhCyHnzP8dOyH4OjCGxBp3Y1OATjjN64K3H2EwaNupsi2WW/IRwV7fwmMxdkUke8QhKG+ZJsub7uSYSHyOi57o87FgfI0oPh/CuuG7Sk8feq6iKHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JXjK0fSyMoZ6GRtl2h+slEhArvwErSkUYYsKsTSFhGk=;
 b=IRaARzAXXM0YZsdohBW0FHLuw7aaMT3vOXiCiePpkKmsNODK4v8jeFJYrVg+g2ugtA1yIxf0AfAu5hbqMk+eyIXY39R7L+u3M/IlggQIyvBd88z8A7/8Ur9hSJ3iKwZ0gF3ZF14LC0j1UzalLH4UFlaLo9YGYAxe4C+QDyvhVZ2/0f+5kSfuYUoo90WybV5ZmXqyQgfvo5kVkNkpzVaYB0T4c7nyJSLzDaFEY+ogbPffZKMYViM6PH0hWsWAvvfQy3s7xFpNbzd9QaDCRAP+oK1sbGu4x3owG+zdpJRIOcLfgt7CtYjdh8Sm2HPsZZDxfx2qCNg5ycTEHC0iqyP1vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JXjK0fSyMoZ6GRtl2h+slEhArvwErSkUYYsKsTSFhGk=;
 b=jDv3KzSu7R/h6Nq626ZiixNSymIXM4SWMtvUWxEU89qOe3MLWHzVLBdTfj4WI/XGLVxZH6VTdF3B9dUmpVH06zlPxWMcPD7oDi+c065Rny928jQsojGunV2KtJhj55JHFic3/gf6X0i/QZ9yytgbN75/CYeZgulmk/mrTrt8h0Y=
Received: from MN0P221CA0026.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:52a::14)
 by DSWPR12MB999151.namprd12.prod.outlook.com (2603:10b6:8:36b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Wed, 29 Jul
 2026 12:55:30 +0000
Received: from BN2PEPF00004FBC.namprd04.prod.outlook.com
 (2603:10b6:208:52a:cafe::38) by MN0P221CA0026.outlook.office365.com
 (2603:10b6:208:52a::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.13 via Frontend Transport; Wed,
 29 Jul 2026 12:55:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN2PEPF00004FBC.mail.protection.outlook.com (10.167.243.182) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Wed, 29 Jul 2026 12:55:29 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 29 Jul
 2026 07:55:28 -0500
Received: from xhdappanad40.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 29 Jul 2026 07:55:26 -0500
From: Dileep Kumar Nagavarapu <DileepKumar.Nagavarapu@amd.com>
To: Jonathan Cameron <jic23@kernel.org>, David Lechner
	<dlechner@baylibre.com>, =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Michal Simek <michal.simek@amd.com>,
	Conall O'Griofa <conall.ogriofa@amd.com>
CC: <linux-iio@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <git@amd.com>, Dileep Kumar Nagavarapu
	<DileepKumar.Nagavarapu@amd.com>
Subject: [PATCH v3 6/6] iio: adc: xilinx-xadc: Correct Write edge in CFG
Date: Wed, 29 Jul 2026 18:24:55 +0530
Message-ID: <20260729125455.95893-7-DileepKumar.Nagavarapu@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260729125455.95893-1-DileepKumar.Nagavarapu@amd.com>
References: <20260729125455.95893-1-DileepKumar.Nagavarapu@amd.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBC:EE_|DSWPR12MB999151:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ff94193-7365-4ddf-45d5-08deed70ab59
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|36860700016|82310400026|1800799024|6133799003|11063799006|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	nLzVYm+VJ7cngS+eFfK6Pli0nT2U+CK7n/zJkbESv4DQb16rfjHSMzYQNPkqGTHL18YZXluG2EPzEg9bgBrY1Bv9k60gzA4jt4yAXvMetJpytTEEE1pOrRTMM7bt2XD73hukCAbs4VnJ6Wr4Zq8VkXqYVUrP45VyxNg/ZdnmdGUZIqlUwaWxyd6oW4BzyIz16h67ap//NU7DyAYYZS5JWF/fDL0yyeFIYaIYgnJn/5Sr54xQw50R2i42QY0RXBoHygvwPqChW/8lUhzgNjaOTMghVaD5hgt9I3sALh63D8VG1Mhmx0HyuLRZLcr9HtXONImwD6YCHk4JloaDXG/3ceLoqv/ebNa5JCzVbtDF00yFnl9IZA5DTrW+EfVpJ2QB7k5SUmeFqklMRdWashW9L521Gcn8cEoDbZnx8s+3nixZDgISV5/I9UODYod1VzC3kUXuxH5ResW9A7If+NO/97sD4HV3x4p+JPL+RM6HZwvWL9hS8H28iyCplEF5MP3wzbn3a8DwiIjD0YNqhUpSgJV1DH0IxS6KnSx3JL84HZlpI9BkvgMM5X0kIC7scawBmOGT0XR2zm0TK6NK0jM1uo3uX0d7j5KO4vvx7TJRFww1zT/89Z2inPArcbsFkbzhFkV4+e5/mNSRlkq3tw5Kr2J4k0mahb6VU9V0A8laRlzOWCXvTZiwojIwKseHQJj/HimNcixMnpCV8CHVrKhO7A==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(376014)(36860700016)(82310400026)(1800799024)(6133799003)(11063799006)(56012099006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	YLuZaF/CMsrVnBWJcL/JJd6i/V9tz4Qztw8vFwUlYE8M0hWxq8cI6HFKeKSVZ37Ow0jx+ATIMctqQJmHNWk/IQll1L91YGHVlK8656vYnXBFEwuohkqbqNnFoE7LmjoXSa6Z7f/Rp01q2ntQ9C4Pwlj6OD+WafSqFE+GBUDcHTTYG0vqOsS/REhXOp6naeBs4+sNvb45xs1MJiqKimhtmhWgMUCemrv6V2kC8wWV+9npMUl06RZsRm3mCXn3iPMhh2Vejxs8+HvxaqF4yRt1QV5FAYXiSySdAEqB0eTe2RT4N4p+DhY9kv2hUT6NEtwGUJgT61fxpYEpyg0r958qzZeZznqOxfAPttD/50k2KKnZzPbnFE93d/mywFpFRzYophNMVPU1VBtkRvR/N99yZBuUc9MplbVXoNgWMz5jaaDzNUDJgHAx7xfk4NZy6Md6
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2026 12:55:29.9622
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ff94193-7365-4ddf-45d5-08deed70ab59
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF00004FBC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSWPR12MB999151

UG585 states about the PS-XADC interface configuration steps,
REDGE is 1 and WEDGE is 0, this is consistent with the XADCIF_CFG
register default value.

Current driver set WEDGE which is inconsistent with TRM, this patch
fix the WEDGE parameter setting.

Signed-off-by: Conall O'Griofa <conall.ogriofa@amd.com>
Signed-off-by: Dileep Kumar Nagavarapu <DileepKumar.Nagavarapu@amd.com>
---
 drivers/iio/adc/xilinx-xadc-platform.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/xilinx-xadc-platform.c b/drivers/iio/adc/xilinx-xadc-platform.c
index bd033315c72f..b113f904b8fa 100644
--- a/drivers/iio/adc/xilinx-xadc-platform.c
+++ b/drivers/iio/adc/xilinx-xadc-platform.c
@@ -346,7 +346,7 @@ static int xadc_zynq_setup(struct platform_device *pdev, struct iio_dev *indio_d
 	xadc_write_reg(xadc, XADC_ZYNQ_REG_INTSTS, ~0);
 	xadc_write_reg(xadc, XADC_ZYNQ_REG_INTMSK, xadc->zynq_intmask);
 	xadc_write_reg(xadc, XADC_ZYNQ_REG_CFG, XADC_ZYNQ_CFG_ENABLE | XADC_ZYNQ_CFG_REDGE |
-			       XADC_ZYNQ_CFG_WEDGE | tck_div | XADC_ZYNQ_CFG_IGAP(igap));
+			       tck_div | XADC_ZYNQ_CFG_IGAP(igap));
 
 	if (pcap_rate > XADC_ZYNQ_PCAP_RATE_MAX_HZ) {
 		ret = clk_set_rate(xadc->clk, pcap_rate);
-- 
2.34.1

