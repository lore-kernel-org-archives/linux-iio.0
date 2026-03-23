Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012054.outbound.protection.outlook.com [52.101.48.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D8BB36309D;
	Mon, 23 Mar 2026 07:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774251984; cv=fail; b=XUvSvr++AzTkMMNx29KTJuKF+FL7KmnifokXQlbeGVR36kYmRjySUhBuytiyLaBNp1CArK/BbY3TzM7bhTg8A7qT8sct2nK2vWKZ69tyeN6iua7ikhnxypY3gI7Xxlzs6bemCAB9R5+PpSuWUqje6E77GP6o8OW/dVM5TLjDv+w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774251984; c=relaxed/simple;
	bh=jMvTqjbddnJQwwhZPFod6NEowaZzBH2dTs9Pchd46WE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZBYw2PVjMGmxijLe84uQsXIIqYPL7p5nYDtGzTBeu4UOdNlgNmw3gk9/OafRlQnsmMXy2+0Snt6JAi0frVpumTCpJSs8d8B7MxBBzYww4o0yIEOfHO3nNwafnI+aOwFFHiEAGsL04nuYJxomFIxFZQYKGlzliDue+C1C24QLusQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=g5iUVu0s; arc=fail smtp.client-ip=52.101.48.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="g5iUVu0s"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zgw7m1WKRwDl1Rl0eX3CCVA7moiHLlvEJ09AhmgOq0QmD/fuUCpwTw/8LS/3e8slxELkRDPOCQ0ZTk/SdbbRlgv2wwMGiM9vf4XJRou1s1lT+R/VbYhXnAzdwYV7M8nu77ejWFxTBTsboO9SzS0KPU0OuOUHmd5j2WmTZxXg+Xu7idUb4KIvQHeWrx1XZJdE1+Qhy0ymweXLPTreriRBR2jdCfgl0vfSbZ7rtN/K4gVSwMaB92KOen3bhkltYG0/L6RJU+adwpgybgkN+8azogXrvqy2gPA2f3WIiAHAyCB4dObqCeXALCv2uvut0R/cjiH1HJjqWf4gIc0sN3iDyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S3AyIx475olH2C2g+uM9vRsRlHsLGPzSrQGUbFMikhk=;
 b=js2wjnmnJtSyDdZpcGu2uEGBAqYe5wdZUxxUL4GEfuQZF8EAO63xsGVOaDU6LMA5YS8fZYCcQJdcFcIHkdC/o1Tj8fwPZKdj/UxLbXksAvvwIzKmn0yJjcYzAir0XV2lFb3C5zzjLkzFWnQPqJFae02Lv1YsmmYUZXggq86JHBwFRVFDumFZVzL61soaVP6Z+eyXSqhJz/uKICYRq7V4jUJ8CVPswa+mbB0HFPNr97NzwLhZV18tigO12H1KhE8ieNyj1pJhtxXpBZ5KxxZKvWvD1dkPoUwDAKVYtuCl+Erg4oGoJHaWuUAv+stOJuDYoR6KoHF2aIqAGgOakCAU+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S3AyIx475olH2C2g+uM9vRsRlHsLGPzSrQGUbFMikhk=;
 b=g5iUVu0sxSRnxcNdSfCmw4DKEAUF7uwBrS+9I0xMo4oMtuBvSlZOF/myOj1VQR3uHGrDmtv9RAi0zhjv6BIFFsdQ8ysQkY8HMi+HvUzLFJ6DzbOUzum0BO6ycimpq5dXGI06rUOjkJX+nuQX7ABgmXh6hDtaqgd9NQ0XKTmTMDc=
Received: from MN0P221CA0003.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:52a::6)
 by CH3PR12MB8851.namprd12.prod.outlook.com (2603:10b6:610:180::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.15; Mon, 23 Mar
 2026 07:46:14 +0000
Received: from BL6PEPF0001AB51.namprd04.prod.outlook.com
 (2603:10b6:208:52a:cafe::2e) by MN0P221CA0003.outlook.office365.com
 (2603:10b6:208:52a::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Mon,
 23 Mar 2026 07:46:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB51.mail.protection.outlook.com (10.167.242.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Mon, 23 Mar 2026 07:46:13 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 23 Mar
 2026 02:46:11 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 23 Mar
 2026 02:46:10 -0500
Received: from xhdlakshmis40.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Mon, 23 Mar 2026 02:46:07 -0500
From: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
To: Jonathan Cameron <jic23@kernel.org>, David Lechner
	<dlechner@baylibre.com>, Nuno Sa <nuno.sa@analog.com>, Andy Shevchenko
	<andy@kernel.org>, Michal Simek <michal.simek@amd.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>
CC: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<saikrishna12468@gmail.com>, <git@amd.com>, Sai Krishna Potthuri
	<sai.krishna.potthuri@amd.com>
Subject: [PATCH v2 2/4] iio: adc: xilinx-xadc: Add .setup_channels() to struct xadc_ops
Date: Mon, 23 Mar 2026 13:15:03 +0530
Message-ID: <20260323074505.3853353-3-sai.krishna.potthuri@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260323074505.3853353-1-sai.krishna.potthuri@amd.com>
References: <20260323074505.3853353-1-sai.krishna.potthuri@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB51:EE_|CH3PR12MB8851:EE_
X-MS-Office365-Filtering-Correlation-Id: eed23862-262e-4b6b-ea6a-08de88b041ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|1800799024|7416014|376014|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	x6v04Ad8yb7tHF301MgJvqqWtEZHSXgzNUFCqJxmn4DHgcaHMAUE6HGRHRuE5F5f6sNz91vcrTYR8h23wl8UfNEefiU3M93JkCUneBd4oquAEmB2Wa7JIMDcxtfloXatnbSHTB4UeXoD0H77po7p4oTALxD4fVd3bkqTizIcSzS59ipxTcZPe1JopFaZO78Z8O/p8BHqd6YtHkt8LV53ZdQDK/RfKhRbimBSdXehEsoZm79rDKCirItewvkGAvHV+7vJwquMfcZ1yYp4TuBfTWPmhi5Mze0ZXf6ttLsjfVNMMkkmk/UeA6A1viOODqtLMG1mmF56e8Hpq2hPkXVoxCSgFEsOD+y2dexcayYWUroxLx6RVGlmcZquR9Jm/hzoQim/zTFM8IxwZP2NfV8f3t3HJJ2OqPB49vWnMF3LHjybUPZychdFIsajQsN621SBzLlIx/T0t39Zm10LRLjkIQFTf+QPBr2NlWoLs92qEDfhiJDnZhMfDi/XthWcmbiQ/sbqOLuUkdGRssC79Hg3KHdLO8eMpowE8sFJJh3zYn32lAI+Xvm3VggMFrtzj3hLKriX9J79JTpo5SlMAlvC3hmDADdi6/B/7QV8cLJxGQm1MjWagDROWq92YY+ZV+7C86x8dLLnAb2RI7FjySh84ISSuNSDXXTLrziY57CH1L2iy/AZNN3UqADabt/yILdO7s3eLjFav42vliEdAXSSFfrIlaBcO8vUIuyYHpqTvFkW6Slu8AbGrCTn0JKvMpUt+bc6WLFwoMvf9ip2Tgs6rQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(1800799024)(7416014)(376014)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	H7+BY9k2ebRekqMAW9yPgGKF1RhKBEtzkbcwwu0j6/ZagB2Dnt843xh57ILzOIJrZypC8UvWZNBiS5JGXFakfdz2XaCMUeVm1nQeVE0gLkrOhlD0jZKynY9ZLNrpgyCtM2cIjz0JC0zNL5SWOKmMdeeSdYgEdwQSwoyDWVa0XHWBpaaZDG9Tr65upNkWzfzA7ij4++WU9xTw9tBuD1JjD0ZmaNW+WXzwYya9U8bfYvWVZPrafTkztEFGYbfityioi55LfeE4HTMFb6FJZ6tbgld92vZTvsPGsx9Y84wOQtQQjwOyA9rK4SsL620XK3rPaEzKA5ZuC685qTOKq1sptCvDvaio2Bs4Wur1LBxyyFoXt/wQcCzHVTDZwo+0QjtPXHXcCkbZcu/svzOzPGXY9md2qCV/NfYC1Kuj/B0z6uhGM2XOcG0tHFibjH+sCDja
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 07:46:13.4454
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eed23862-262e-4b6b-ea6a-08de88b041ee
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB51.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8851

Add .setup_channels() function pointer to struct xadc_ops to enable
different interfaces to have custom channel setup logic.

Signed-off-by: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
---
 drivers/iio/adc/xilinx-xadc-core.c     | 6 ++++--
 drivers/iio/adc/xilinx-xadc-platform.c | 3 +++
 drivers/iio/adc/xilinx-xadc.h          | 2 ++
 3 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/xilinx-xadc-core.c b/drivers/iio/adc/xilinx-xadc-core.c
index 268e46e5349c..7fbf55f8e0bb 100644
--- a/drivers/iio/adc/xilinx-xadc-core.c
+++ b/drivers/iio/adc/xilinx-xadc-core.c
@@ -653,7 +653,7 @@ static const struct iio_info xadc_info = {
 	.update_scan_mode = &xadc_update_scan_mode,
 };
 
-static int xadc_parse_dt(struct iio_dev *indio_dev, unsigned int *conf, int irq)
+int xadc_parse_dt(struct iio_dev *indio_dev, unsigned int *conf, int irq)
 {
 	struct device *dev = indio_dev->dev.parent;
 	struct xadc *xadc = iio_priv(indio_dev);
@@ -760,6 +760,7 @@ static int xadc_parse_dt(struct iio_dev *indio_dev, unsigned int *conf, int irq)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(xadc_parse_dt);
 
 const char * const xadc_type_names[] = {
 	[XADC_TYPE_S7] = "xadc",
@@ -791,10 +792,11 @@ int xadc_device_configure(struct device *dev, struct iio_dev *indio_dev,
 			  int irq, unsigned int *conf0,
 			  unsigned int *bipolar_mask)
 {
+	struct xadc *xadc = iio_priv(indio_dev);
 	int ret;
 	u32 i;
 
-	ret = xadc_parse_dt(indio_dev, conf0, irq);
+	ret = xadc->ops->setup_channels(indio_dev, conf0, irq);
 	if (ret)
 		return ret;
 
diff --git a/drivers/iio/adc/xilinx-xadc-platform.c b/drivers/iio/adc/xilinx-xadc-platform.c
index f1ffbf5cff42..9015b131daa3 100644
--- a/drivers/iio/adc/xilinx-xadc-platform.c
+++ b/drivers/iio/adc/xilinx-xadc-platform.c
@@ -401,6 +401,7 @@ static const struct xadc_ops xadc_zynq_ops = {
 	.get_dclk_rate = xadc_zynq_get_dclk_rate,
 	.interrupt_handler = xadc_zynq_interrupt_handler,
 	.update_alarm = xadc_zynq_update_alarm,
+	.setup_channels = xadc_parse_dt,
 	.type = XADC_TYPE_S7,
 	/* Temp in C = (val * 503.975) / 2**bits - 273.15 */
 	.temp_scale = 503975,
@@ -508,6 +509,7 @@ static const struct xadc_ops xadc_7s_axi_ops = {
 	.get_dclk_rate = xadc_axi_get_dclk,
 	.update_alarm = xadc_axi_update_alarm,
 	.interrupt_handler = xadc_axi_interrupt_handler,
+	.setup_channels = xadc_parse_dt,
 	.flags = XADC_FLAGS_BUFFERED | XADC_FLAGS_IRQ_OPTIONAL,
 	.type = XADC_TYPE_S7,
 	/* Temp in C = (val * 503.975) / 2**bits - 273.15 */
@@ -522,6 +524,7 @@ static const struct xadc_ops xadc_us_axi_ops = {
 	.get_dclk_rate = xadc_axi_get_dclk,
 	.update_alarm = xadc_axi_update_alarm,
 	.interrupt_handler = xadc_axi_interrupt_handler,
+	.setup_channels = xadc_parse_dt,
 	.flags = XADC_FLAGS_BUFFERED | XADC_FLAGS_IRQ_OPTIONAL,
 	.type = XADC_TYPE_US,
 	/**
diff --git a/drivers/iio/adc/xilinx-xadc.h b/drivers/iio/adc/xilinx-xadc.h
index a2d208fbd13b..feec8ef76e4f 100644
--- a/drivers/iio/adc/xilinx-xadc.h
+++ b/drivers/iio/adc/xilinx-xadc.h
@@ -82,6 +82,7 @@ struct xadc_ops {
 	void (*update_alarm)(struct xadc *xadc, unsigned int alarm);
 	unsigned long (*get_dclk_rate)(struct xadc *xadc);
 	irqreturn_t (*interrupt_handler)(int irq, void *devid);
+	int (*setup_channels)(struct iio_dev *indio_dev, unsigned int *conf, int irq);
 
 	unsigned int flags;
 	enum xadc_type type;
@@ -233,6 +234,7 @@ void xadc_write_reg(struct xadc *xadc, unsigned int reg, uint32_t val);
 void xadc_read_reg(struct xadc *xadc, unsigned int reg, uint32_t *val);
 struct iio_dev *xadc_device_setup(struct device *dev, int size,
 				  const struct xadc_ops **ops);
+int xadc_parse_dt(struct iio_dev *indio_dev, unsigned int *conf, int irq);
 int xadc_device_configure(struct device *dev, struct iio_dev *indio_dev,
 			  int irq, unsigned int *conf0, unsigned int *bipolar_mask);
 int xadc_read_samplerate(struct xadc *xadc);
-- 
2.25.1

