Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010055.outbound.protection.outlook.com [52.101.85.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 045C746C4DD;
	Mon,  5 Oct 2026 09:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791193403; cv=fail; b=N4TGpQL6KmYwqxD7PKdtlkytWr2Dgur4xNa+23u0TZoESwWMM2ym0rdiO1EqpbZQvTJltp2Qej95+Aw29uQZeREPv5avSQwHJsmz4/fkjkbEa54FIDFfT0pwycJ3px91diRIeNMO5oXMqCs3/rcY7ZbCf5TRTRlQVog2XLuN5tg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791193403; c=relaxed/simple;
	bh=+2Otw3ZzkmorzH5cuHeGSoJy69LdR+4Kpb+1Ypc8/1g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mAguirNmn+pu3AHjfN8Uv6fDOtKMVYnso21aEoNMQ0af+112pGmMQnCqxoj0PJ72QGt7nurREIigUPfNoaASYCWmCig8PVdP64ve7VylUZyVYfCBYr97nxxvBr+oZ/blj7itPPz14M31synMUmX7RLRmVAY4IPsEzm8Q7P7vcYo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=JRw5bmMN; arc=fail smtp.client-ip=52.101.85.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="JRw5bmMN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IGVs0N0dTEwAXE3/84SMyz3mfnfWb0n+LECMjXLdPECfWXEOfiEl9pQ675mxumJhUy98AVXICCAYiAsBII94XF5X/AOfrufLCioqqltwmlHaTkV6CJa+q/wCPIiChrvOhu5fRdZOWTOxwTqnd2/HLOuhv9D3GlwwfvmQvgfL/scLZ1wbcIeSd+liU1j3NArXJsEf8KnvMlbFlw+zPtJDs/gISjUL1FKg5itAoSeW7ml8tYSk0DGxHS+B29zbmRahx3hI1TmxfCcM6bEUz2lguJBQ3QZnSYrsA3xHtifbDRRlZuo0oDT3ZCAb46DkFJvVukAYQgatcQrr0TvA4QolIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MshFREK2YlbYS7NU8cdvX3kBxZXb7KZtDfZrDPc4G9k=;
 b=BuMIxM67vlNuWbd6jL8nJD5A88es4SQzh+y4RDyEsp6GBAEDdU3jRvpwmKmJEBXFGIUFNUzmWoacc5sPifWo5SVV2rnW9pwcJZKJd0mwdQg04fcFJ2L90SGan/hgwyCTHMH36B4tOTlsMwQ+aK+g6w1URs7/B3RjkjvC1pr4SIMJgrbNR1Az19ysStGmzaXq0MDSS//mTpO6yv0O3SoQ/oSdW0ohN5Nx9FZUYn0jowr1MF84PXsLCeqDQATvG745trGcbpST5D+mmNdPD10X/CgQkcmiyEQVx+Lv/bAXN+Ag3pN74s/u20K6hlwKHqiannTc8DWcGinbPj5sXJuJsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MshFREK2YlbYS7NU8cdvX3kBxZXb7KZtDfZrDPc4G9k=;
 b=JRw5bmMNOE392Q6QvELcEfDXmzZX3fTJZ6Pp8y2o/SH7q1xW45VLCMBSxMl+otXZY7qvpAUmmwEw+im3aU7eXykbZvrBnbujAgF4vTuCxzp40c8a69zL19DJYOOpLFc3UtW/fcEKwNnuYmzI8/0bN3IZsJRBgMcgafSXGI6DtY4=
Received: from BN9P222CA0004.NAMP222.PROD.OUTLOOK.COM (2603:10b6:408:10c::9)
 by DS2PR12MB9776.namprd12.prod.outlook.com (2603:10b6:8:2bd::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Mon, 5 Oct
 2026 09:43:11 +0000
Received: from BN3PEPF0000B074.namprd04.prod.outlook.com
 (2603:10b6:408:10c:cafe::9a) by BN9P222CA0004.outlook.office365.com
 (2603:10b6:408:10c::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Mon, 5
 Oct 2026 09:43:11 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN3PEPF0000B074.mail.protection.outlook.com (10.167.243.119) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Mon, 5 Oct 2026 09:43:11 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 5 Oct
 2026 04:43:10 -0500
Received: from xhdappanad40.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Mon, 5 Oct 2026 04:43:06 -0500
From: Dileep Kumar Nagavarapu <dileepkumar.nagavarapu@amd.com>
To: Jonathan Cameron <jic23@kernel.org>, David Lechner
	<dlechner@baylibre.com>, =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Michal Simek <michal.simek@amd.com>,
	Conall O'Griofa <conall.ogriofa@amd.com>
CC: <linux-iio@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <git@amd.com>, Dileep Kumar Nagavarapu
	<dileepkumar.nagavarapu@amd.com>, Sai Krishna Potthuri
	<sai.krishna.potthuri@amd.com>
Subject: [PATCH v4 14/15] iio: adc: xilinx-xadc: Add .setup_channels() to struct xadc_ops
Date: Mon, 5 Oct 2026 15:12:04 +0530
Message-ID: <20261005094205.1045874-15-dileepkumar.nagavarapu@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B074:EE_|DS2PR12MB9776:EE_
X-MS-Office365-Filtering-Correlation-Id: 887f616b-0bf9-4281-aba9-08df22c511dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|376014|82310400026|36860700016|10067099003|56012099006|11063799006|260925021311599003|260925021911599003|260925022911599003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	1BECCfadbkocxJ3nopIWj+6CGIeyMJ98qp1TJLXwYpyRf8lDofO/TXoPyRCDmgF/tqdxjeZKpjtKMlFqPuq2lcO321SY6HX3ywIG33z90A0cMgMVnFfDkkEoMXvlcpSMYgUaJnJAjbThmdimGXFLklBa9gCjimcHyPgVL30KQO5ov4bECHv8F8XK7rt+ijAwjp0z3cd4R25GU00c1St0v5z9LMgXWhPEN+CM7nycAghazpQW+IX6ZqdJA/uOD4jiN5ilqXxJ9leBk5PudT5DxWJaUQOF3VncAC0itW0UjCd75UvVdR/PlLBzyueKsj9G2+KTbgiJZmEWM29fT5zO+4K8JevEVEQxG/td6u4/ayl4Ufyu6AhioyI1H7pgzK0qabR6QJRWIrPVqE+BdyQq4rWX4aQDce4WCaGm9/yz+6pzz04uWnOIydAgchUaewovNhXpzXj6fTcm3dAfe4FqaOcOtYq8pKX5Ly7zE4lelKX1Z48SgRpgg96eqQczT2/WAh4S3up5Mkxg8bvKlQMJo9jM8kRAExeTNp0xhZZCmRty65wv8hp42CvKY9fFMGS7z+dT3mLrLm6/yXjKvP6+Cv1BnS2ECKQ73llK9h1m0olWybZCvg7a+Gb/Plbw5bhYC6MUlVOUBqabQbZdlnY6AeuvdcYi0L+ju7gP5uhjRMSFWCBh1WOZ9tUvp0YQiXQgjy/Wd9tvRLDdL3KfP83w5w==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(82310400026)(36860700016)(10067099003)(56012099006)(11063799006)(260925021311599003)(260925021911599003)(260925022911599003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	NnOTHq3nJFMWkZQu3r5d3U0kxVE2Xd00/dByPWOL+N3CxhmxbkLK7hCjMsz6/keEZa1VQAjY2Cpj+swUUJHeE6fYA4pNhLd4ralaszLh0OiYQrIF/uBvQD/Rren/zcSjglMPdZKYL+tRE0RZjNhxpnnwXPxciMImCGYxM6K3DNOxvfnTl8wbarq5mU60mkuxF2O9aax0G4KNq6mkFPzn/Kd4nG3hWK/RYXPPjaEiCsAtMQIp4h2l7NroTN3wy9DEXgyBgVAzkIvlyGYa1qS3lsSeucODcygI0jjlL/9Arl+C30UOVaWge8uA2ca4+mL05lzkPWuVrk+eQ11Prbjpz2gAPmqjYEqbo1LPNTq/jaq3/UA5IFI5v0G8s1ocvmAQe4jLkS9M8YDKyHBeKVpdp1Hi55ifh/0kAVp46aasCQ8NRSbJmmrS1OKzT2H3vM+c
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2026 09:43:11.3092
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 887f616b-0bf9-4281-aba9-08df22c511dc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B074.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9776

Add .setup_channels() function pointer to struct xadc_ops to enable
different interfaces to have custom channel setup logic.

Export xadc_parse_dt() as it will be used by the I2C interface
support added later in this series. This avoids duplicating
the devicetree parsing logic across interface files.

Co-developed-by: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
Signed-off-by: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
Signed-off-by: Dileep Kumar Nagavarapu <dileepkumar.nagavarapu@amd.com>
---
 drivers/iio/adc/xilinx-xadc-core.c     | 6 ++++--
 drivers/iio/adc/xilinx-xadc-platform.c | 3 +++
 drivers/iio/adc/xilinx-xadc.h          | 2 ++
 3 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/xilinx-xadc-core.c b/drivers/iio/adc/xilinx-xadc-core.c
index 878b4d9c7d73..2addb61cf5b1 100644
--- a/drivers/iio/adc/xilinx-xadc-core.c
+++ b/drivers/iio/adc/xilinx-xadc-core.c
@@ -658,7 +658,7 @@ static const struct iio_info xadc_info = {
 	.update_scan_mode = &xadc_update_scan_mode,
 };
 
-static int xadc_parse_dt(struct iio_dev *indio_dev, unsigned int *conf, int irq)
+int xadc_parse_dt(struct iio_dev *indio_dev, unsigned int *conf, int irq)
 {
 	struct device *dev = indio_dev->dev.parent;
 	struct xadc *xadc = iio_priv(indio_dev);
@@ -764,6 +764,7 @@ static int xadc_parse_dt(struct iio_dev *indio_dev, unsigned int *conf, int irq)
 
 	return 0;
 }
+EXPORT_SYMBOL_NS_GPL(xadc_parse_dt, "IIO_XADC");
 
 static const char *const xadc_type_names[] = {
 	[XADC_TYPE_S7] = "xadc",
@@ -793,9 +794,10 @@ EXPORT_SYMBOL_NS_GPL(xadc_device_setup, "IIO_XADC");
 int xadc_device_configure(struct iio_dev *indio_dev, int irq,
 			  unsigned int *conf0, unsigned int *bipolar_mask)
 {
+	struct xadc *xadc = iio_priv(indio_dev);
 	int ret;
 
-	ret = xadc_parse_dt(indio_dev, conf0, irq);
+	ret = xadc->ops->setup_channels(indio_dev, conf0, irq);
 	if (ret)
 		return ret;
 
diff --git a/drivers/iio/adc/xilinx-xadc-platform.c b/drivers/iio/adc/xilinx-xadc-platform.c
index b3fd86ead61d..72b127bd644e 100644
--- a/drivers/iio/adc/xilinx-xadc-platform.c
+++ b/drivers/iio/adc/xilinx-xadc-platform.c
@@ -386,6 +386,7 @@ static const struct xadc_ops xadc_zynq_ops = {
 	.get_dclk_rate = xadc_zynq_get_dclk_rate,
 	.interrupt_handler = xadc_zynq_interrupt_handler,
 	.update_alarm = xadc_zynq_update_alarm,
+	.setup_channels = xadc_parse_dt,
 	.type = XADC_TYPE_S7,
 	/* Temp in C = (val * 503.975) / 2**bits - 273.15 */
 	.temp_scale = 503975,
@@ -490,6 +491,7 @@ static const struct xadc_ops xadc_7s_axi_ops = {
 	.get_dclk_rate = xadc_axi_get_dclk,
 	.update_alarm = xadc_axi_update_alarm,
 	.interrupt_handler = xadc_axi_interrupt_handler,
+	.setup_channels = xadc_parse_dt,
 	.flags = XADC_FLAGS_BUFFERED | XADC_FLAGS_IRQ_OPTIONAL,
 	.type = XADC_TYPE_S7,
 	/* Temp in C = (val * 503.975) / 2**bits - 273.15 */
@@ -504,6 +506,7 @@ static const struct xadc_ops xadc_us_axi_ops = {
 	.get_dclk_rate = xadc_axi_get_dclk,
 	.update_alarm = xadc_axi_update_alarm,
 	.interrupt_handler = xadc_axi_interrupt_handler,
+	.setup_channels = xadc_parse_dt,
 	.flags = XADC_FLAGS_BUFFERED | XADC_FLAGS_IRQ_OPTIONAL,
 	.type = XADC_TYPE_US,
 	/**
diff --git a/drivers/iio/adc/xilinx-xadc.h b/drivers/iio/adc/xilinx-xadc.h
index 4793766687b4..66d333ad91ec 100644
--- a/drivers/iio/adc/xilinx-xadc.h
+++ b/drivers/iio/adc/xilinx-xadc.h
@@ -80,6 +80,7 @@ struct xadc_ops {
 	void (*update_alarm)(struct xadc *xadc, unsigned int alarm);
 	unsigned long (*get_dclk_rate)(struct xadc *xadc);
 	irqreturn_t (*interrupt_handler)(int irq, void *devid);
+	int (*setup_channels)(struct iio_dev *indio_dev, unsigned int *conf, int irq);
 
 	unsigned int flags;
 	enum xadc_type type;
@@ -191,6 +192,7 @@ static inline int xadc_write_adc_reg(struct xadc *xadc, unsigned int reg, u16 va
 void xadc_write_reg(struct xadc *xadc, unsigned int reg, u32 val);
 void xadc_read_reg(struct xadc *xadc, unsigned int reg, u32 *val);
 struct iio_dev *xadc_device_setup(struct device *dev, int size, const struct xadc_ops **ops);
+int xadc_parse_dt(struct iio_dev *indio_dev, unsigned int *conf, int irq);
 int xadc_device_configure(struct iio_dev *indio_dev,
 			  int irq, unsigned int *conf0, unsigned int *bipolar_mask);
 int xadc_read_samplerate(struct xadc *xadc);
-- 
2.34.1

