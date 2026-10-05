Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013024.outbound.protection.outlook.com [40.93.201.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69EF74570C7;
	Mon,  5 Oct 2026 09:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791193399; cv=fail; b=IPJEmyBxYp+dU7cSneroa1S9P+dyG8rppJsAZz4YzDxyrGCV/vd58KvLmc5jpMuow6TkBdv3hdyUf2gucnHMGZYLtcAv1KUhlQ+Ps+D2002LFp8HZMjRFvUcp7wQMQbRNorbo5bFVYGjygPhcrHT600mqFpODMcL/14LUEBuWSI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791193399; c=relaxed/simple;
	bh=9y1Ee0NpGk9my9awv3hUrRtJebQ+MpWq4r1pamW1u6k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OKzyJr/s1deyXcYYqAcAM66DuTF6t1RcliPKjkeXyenFNecKG+gRdpuF7MUysS74+TqeBPJ3NjyJOsq0NXU2gMTU5+CJxPVI3wYdm7ztuM3N3bZ4CnEGxHmoCfKcp1OWqHwKbyBiRCgZa8HpNO58ttIQR5hNtUcLHFSkJTEsvoY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ycc8vDcH; arc=fail smtp.client-ip=40.93.201.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ycc8vDcH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tMC5Ll2EGF2xKWp8gVJOd1XZlJAs3maKnsimuS4XDIhIOV75w/+xoAxpHFNFRm70AbGhkd/mBEe0wFQFryVly4UM/pOG452k95mzpZA2xokETsK9X3IjpsZtUjNQ3ecp7MLo8OTCcHMH6Is41yGmBiLaqz5cif+EuHtcSF+6fw0r4i/oU1m+EUPOf238Yr790TGjE3QNTDfXGYhKCLvA1LgBQwBHaSGBh+dPny8GW8/Y8zo31o8pagrFPtG3HdFH9f+2tAgJynix0gSjQCIiSs2IpbDkt4UI/SOizy/NBYmW/StPb+KhTe5pFgqzkxBUATa3mL55/CyaOd35ngbtbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RXrzamUiAJ0mpV1t9zMukfDRmQqDgv+2i1UGZZgSEvk=;
 b=CKyAieHBiRA4uAwPTDyQJBQRoEPJ80s2G2RrRBttXwAVKBckGpUxNrZ3Z7ZfyqryW2ZV9sK9wTmx1aFvzclZMyM54TrkZ2ITLL/sonCDHm3AWg0exVtcBsqQlkLDc0uQVh07JcQagtGGN8YdMoplOiRo8B3ZhKrEAkP55MH/1DOev1Vn2bfEpnXZy0GH3dkS4Eb738UVva8GJwK/tUHNQRgMzThpe1rj4c3WxCq6YLwrrr0uoaPmrT7nJaYCdmuRZRnEw70Jx4TF3YUGTzIUM5oud+4d43f4QD5dK9O7+EtsDYWcdyMBMwtiXt/lagxf29OkdSxGqnq9ER6pq3KkWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RXrzamUiAJ0mpV1t9zMukfDRmQqDgv+2i1UGZZgSEvk=;
 b=ycc8vDcH2Cu0a5lNrDmylx7Vk3pNhJq9YuMJukFTnMwqDjDg3nZvhKDMeSe++uALpN9OBYETJI1FYH17Ib9xbDbQmhoOa5Nmt/z+Gk0k035i9lh01wXhz7BVcbcPNvD2OYjAKcv2RS1n8PadZVPmnkCYmq0sKrnyRaSYTsLmqeE=
Received: from BN0PR02CA0020.namprd02.prod.outlook.com (2603:10b6:408:e4::25)
 by BY5PR12MB4066.namprd12.prod.outlook.com (2603:10b6:a03:207::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Mon, 5 Oct
 2026 09:43:06 +0000
Received: from BN3PEPF0000B071.namprd04.prod.outlook.com
 (2603:10b6:408:e4:cafe::1f) by BN0PR02CA0020.outlook.office365.com
 (2603:10b6:408:e4::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Mon, 5
 Oct 2026 09:43:05 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN3PEPF0000B071.mail.protection.outlook.com (10.167.243.116) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Mon, 5 Oct 2026 09:43:05 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 5 Oct
 2026 04:43:02 -0500
Received: from xhdappanad40.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Mon, 5 Oct 2026 04:42:59 -0500
From: Dileep Kumar Nagavarapu <dileepkumar.nagavarapu@amd.com>
To: Jonathan Cameron <jic23@kernel.org>, David Lechner
	<dlechner@baylibre.com>, =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Michal Simek <michal.simek@amd.com>,
	Conall O'Griofa <conall.ogriofa@amd.com>
CC: <linux-iio@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <git@amd.com>, Dileep Kumar Nagavarapu
	<dileepkumar.nagavarapu@amd.com>, Sai Krishna Potthuri
	<sai.krishna.potthuri@amd.com>
Subject: [PATCH v4 12/15] iio: adc: xilinx-xadc: Add helper functions for the device setup
Date: Mon, 5 Oct 2026 15:12:02 +0530
Message-ID: <20261005094205.1045874-13-dileepkumar.nagavarapu@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261005094205.1045874-1-dileepkumar.nagavarapu@amd.com>
References: <20261005094205.1045874-1-dileepkumar.nagavarapu@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B071:EE_|BY5PR12MB4066:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a5f923f-3854-453f-ec7d-08df22c50e83
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|23010399003|36860700016|18002099003|22082099003|11063799006|6133799003|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	BLBpZJvrCSq+FIRlsthRJxei2xbVoFgrGmGkLYzWzKeVmhGJpb5ERHwLAmo64IbOXkuFGkq8X/17kcW6+59bATHWohqjzqsbhYms1tZrTMhCpqn90crJbHN8oNNMe1ndbd89c/t0TU6Pl7Sj9Q0cmTA+0PoqkngCr6SmdyY2fGv7Gq3Q2Stz4lsCst8+XmkS7ddHlfiFHN8z1MQjmaX9zC1aJdlJXSl9bGEAnPgODJdKL6IVVZci2TC14UMHn861V6KW+TvQdc9yM8nPv0gDrhVhvB6RnY+zEkv1+yqQf1q4zaetH+kYP3ymEnXe4IpuxKllC6j7SijCdpsY7z8xFdmsJbwmftZ9TuuQ8xI3KJ0ki4Qwd/HC90FuEHAzLF3VMRITujwnlQDTl9m4qayfVpJSGPhThg/80udpVQ5Y3qXZTQddFyt5RLY0AwsAfFrlFEld+FGOixnXkHhbMO5vDamFF2KWU/GtdSENLMDWPoTULAfeuS2fjty/YdPa5vc/rMWZNjY2ajNvQLysHxOYrMiLgQBhgxcudfE39xGHi/zQevT+w/HeFZ+hAjB9GtMTpaa9GYWsKDMRSQZN2ZXmApPuu6d9BFcSWj4CCgXm4zPVbSBfRzGBMTkP3Qn2Idkk8FwmN/dPU4ez522wYhnHV3uMHCRteVXd7ixgqJelQJjABk0AextQYwYemmWjzaXLTLTeekK4pQll+S2ZhjUcRA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(23010399003)(36860700016)(18002099003)(22082099003)(11063799006)(6133799003)(10067099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	G5XnG+zJYWIcnMsSwqRKpQIzcQ88ggPZeIPQ5w+49shr38MVL7LJmhSUzFXJM5FqSpgT1YyXvakRt503qshMAHnBfbQxOD/0WGxZjVRutHw276+5v6mfKxW21NRT/c3717q6Uzv+Opmj4RE9+CUxtiF7caIi1iUWhd1SJHkxSHbHvIlHThNL9X2BrKCjEPJgj/X0uC+3OJNCV+3RQR5zVy9Hai8/7L2iYHSOMRnAJl9ew5v7SXPCket3INcn19Xg4m2LsZVlkquG3HucwkYHx9Ibv9R77Ut/dZGL7JI//zOxqf4HiknxVMvmFRUoZoeAztuWR1yu8/zlxsG44ARiucai0Gl0KLjCHYrJn9lnSZT4uNB2kYkn+Hjls9vZlTa2sEN6We2PCrB2mzsm3PhEo5bdyPxakqc1mpHPy6f7OxUmPbPKJIuy/fUjpt+dx4Ep
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2026 09:43:05.6903
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a5f923f-3854-453f-ec7d-08df22c50e83
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B071.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4066

Refactor the platform driver probe function by extracting device
setup and configuration logic into reusable helper functions:
xadc_device_setup(): handles IIO device allocation and basic setup
xadc_device_configure(): handles device tree parsing and bipolar mask
configuration

Move the bipolar channel mask calculation immediately after
xadc_parse_dt(), as the channel information used to build
the mask is populated there and remains unchanged before it is consumed.

This refactoring reduces code duplication and prepares for sharing the
common setup logic between platform and I2C drivers.

Co-developed-by: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
Signed-off-by: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
Signed-off-by: Dileep Kumar Nagavarapu <dileepkumar.nagavarapu@amd.com>
---
 drivers/iio/adc/xilinx-xadc-core.c | 105 +++++++++++++++++++----------
 1 file changed, 71 insertions(+), 34 deletions(-)

diff --git a/drivers/iio/adc/xilinx-xadc-core.c b/drivers/iio/adc/xilinx-xadc-core.c
index 92cd38cd1834..d95a84e7e561 100644
--- a/drivers/iio/adc/xilinx-xadc-core.c
+++ b/drivers/iio/adc/xilinx-xadc-core.c
@@ -933,6 +933,33 @@ static int xadc_read_raw(struct iio_dev *indio_dev,
 	}
 }
 
+static int xadc_setup_buffer_and_triggers(struct iio_dev *indio_dev, int irq)
+{
+	struct device *dev = indio_dev->dev.parent;
+	struct xadc *xadc = iio_priv(indio_dev);
+	int ret;
+
+	if (!(xadc->ops->flags & XADC_FLAGS_BUFFERED))
+		return 0;
+
+	ret = devm_iio_triggered_buffer_setup(dev, indio_dev, &iio_pollfunc_store_time,
+					      &xadc_trigger_handler, &xadc_buffer_ops);
+	if (ret)
+		return ret;
+
+	if (irq > 0) {
+		xadc->convst_trigger = xadc_alloc_trigger(indio_dev, "convst");
+		if (IS_ERR(xadc->convst_trigger))
+			return PTR_ERR(xadc->convst_trigger);
+
+		xadc->samplerate_trigger = xadc_alloc_trigger(indio_dev, "samplerate");
+		if (IS_ERR(xadc->samplerate_trigger))
+			return PTR_ERR(xadc->samplerate_trigger);
+	}
+
+	return 0;
+}
+
 static int xadc_write_samplerate(struct xadc *xadc, int val)
 {
 	unsigned long clk_rate = xadc_get_dclk_rate(xadc);
@@ -1256,6 +1283,43 @@ static const char *const xadc_type_names[] = {
 	[XADC_TYPE_US] = "xilinx-system-monitor",
 };
 
+static struct iio_dev *xadc_device_setup(struct device *dev, int size, const struct xadc_ops **ops)
+{
+	struct iio_dev *indio_dev;
+
+	*ops = device_get_match_data(dev);
+	if (!*ops)
+		return ERR_PTR(-ENODEV);
+
+	indio_dev = devm_iio_device_alloc(dev, size);
+	if (!indio_dev)
+		return ERR_PTR(-ENOMEM);
+
+	indio_dev->name = xadc_type_names[(*ops)->type];
+	indio_dev->info = &xadc_info;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+
+	return indio_dev;
+}
+
+static int xadc_device_configure(struct iio_dev *indio_dev, int irq,
+				 unsigned int *conf0, unsigned int *bipolar_mask)
+{
+	int ret;
+
+	ret = xadc_parse_dt(indio_dev, conf0, irq);
+	if (ret)
+		return ret;
+
+	*bipolar_mask = 0;
+	for (unsigned int i = 0; i < indio_dev->num_channels; i++) {
+		if (indio_dev->channels[i].scan_type.sign == 's')
+			*bipolar_mask |= BIT(indio_dev->channels[i].scan_index);
+	}
+
+	return 0;
+}
+
 static void xadc_cancel_delayed_work(void *data)
 {
 	struct delayed_work *work = data;
@@ -1275,18 +1339,14 @@ static int xadc_probe(struct platform_device *pdev)
 	int irq;
 	int i;
 
-	ops = device_get_match_data(dev);
-	if (!ops)
-		return -EINVAL;
+	indio_dev = xadc_device_setup(dev, sizeof(*xadc), &ops);
+	if (IS_ERR(indio_dev))
+		return PTR_ERR(indio_dev);
 
 	irq = platform_get_irq_optional(pdev, 0);
 	if (irq < 0 && (irq != -ENXIO || !(ops->flags & XADC_FLAGS_IRQ_OPTIONAL)))
 		return irq;
 
-	indio_dev = devm_iio_device_alloc(dev, sizeof(*xadc));
-	if (!indio_dev)
-		return -ENOMEM;
-
 	xadc = iio_priv(indio_dev);
 	xadc->ops = ops;
 	init_completion(&xadc->completion);
@@ -1298,30 +1358,13 @@ static int xadc_probe(struct platform_device *pdev)
 	if (IS_ERR(xadc->base))
 		return PTR_ERR(xadc->base);
 
-	indio_dev->name = xadc_type_names[xadc->ops->type];
-	indio_dev->modes = INDIO_DIRECT_MODE;
-	indio_dev->info = &xadc_info;
-
-	ret = xadc_parse_dt(indio_dev, &conf0, irq);
+	ret = xadc_device_configure(indio_dev, irq, &conf0, &bipolar_mask);
 	if (ret)
 		return ret;
 
-	if (xadc->ops->flags & XADC_FLAGS_BUFFERED) {
-		ret = devm_iio_triggered_buffer_setup(dev, indio_dev, &iio_pollfunc_store_time,
-						      &xadc_trigger_handler, &xadc_buffer_ops);
-		if (ret)
-			return ret;
-
-		if (irq > 0) {
-			xadc->convst_trigger = xadc_alloc_trigger(indio_dev, "convst");
-			if (IS_ERR(xadc->convst_trigger))
-				return PTR_ERR(xadc->convst_trigger);
-
-			xadc->samplerate_trigger = xadc_alloc_trigger(indio_dev, "samplerate");
-			if (IS_ERR(xadc->samplerate_trigger))
-				return PTR_ERR(xadc->samplerate_trigger);
-		}
-	}
+	ret = xadc_setup_buffer_and_triggers(indio_dev, irq);
+	if (ret)
+		return ret;
 
 	xadc->clk = devm_clk_get_enabled(dev, NULL);
 	if (IS_ERR(xadc->clk))
@@ -1366,12 +1409,6 @@ static int xadc_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	bipolar_mask = 0;
-	for (i = 0; i < indio_dev->num_channels; i++) {
-		if (indio_dev->channels[i].scan_type.sign == 's')
-			bipolar_mask |= BIT(indio_dev->channels[i].scan_index);
-	}
-
 	ret = xadc_write_adc_reg(xadc, XADC_REG_INPUT_MODE(0), bipolar_mask);
 	if (ret)
 		return ret;
-- 
2.34.1

