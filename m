Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.52.23
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795626721;
	b=Qbg2JViu6qk9eA1T5p+dMk4zSf2P0iYTrTcVq2O/SemPFkgnLALixhjieVpom/FEMhQr
	 bYr9cQqNNI52HYakOs75CfauFvGwnrXEhPVFgzeGm1zDBbnAdXOOUz8Fnb3YEEazGdZZ2
	 mdt31ADvcJqGlpnRdKlH13zO0JlaOuDhYn8tTYfAIvOyuvbrQn3f9bcNtZLEgWyn9JlyN
	 4sope8BhGz2NcJXMwCvaKijO1hcV85z5BKK0e0jxJhK6Z4wjFKM0drHIV2JYT0ky1QGo4
	 3y4ZR+CDCY1nV9MOzpYjgZeZXjoN41WxrGgXZqq2YSl36NCDeBRH4xHy1RbmRF7a9ig==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795626721;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 Content-Type:X-EOPAttributedMessage:X-MS-PublicTrafficType:
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
	bh=cDnKHMoaTxdejvC6/XeRSaAG1P4hAPAw73KXQi87780=;
	b=wSTyRmUjazvEtUDBBNt+i2LZex2/Yfi6gd7dhx3WMK8KsjbjsGMq6vF2gOevPjbIWVJX
	 a09jBr4hgFVpanT2CLmazhebjuHjwn2TRNxGMf0gzL9d5DeTEAjkW7DcGNI//T/zUIo41
	 c4PE/KJKylvfZyRAYUUeKk0HRSwG80U1XPBH5NPUeesn35w9NfpNNwJRLxC8FcvGgdJ0a
	 G5H1vjWAMvdZyWICKDmKiCFjmuFXNL5y1NqUKl07KT784JxzoawBCkdIkYVXHfyou7NNb
	 76+4LvYP/ODxqllSdoN3Vr/F7bhprHJKtrfb/z0VZiFTq12w9rhy6avKnvmlo3tOpiQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=AI40671L;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.52.23
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011023.outbound.protection.outlook.com [52.101.52.23])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C78C8606A6B7;
	Wed, 25 Nov 2026 17:12:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C78C8606A6B7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=AI40671L
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MnYxN+hGwT+rSbwPtx2xwck5kwn4FtVFJGytsZ8kRh90bY6BiGkJmoCiw99ekJtR7n9f8BmPtgKQM+YCNAbp9H80+zf0I2IOFYAtPEuVCnLWS0MaJKnFRRf7vJR06R3gHkcPCTDTKgAfa4HnDD+cyfm+WO4SEHq/9cTAYUCUW8hJg+oAqbgWjIwU62kBfwNx+xf4D3Wmw3m3FbeLF/mkEfcuAmmEm7KrvyrvtbH6YTT/mLjgtzihqRI5QFF1q77z8d7Hky2TtiWtdasgfeHfORO73d3jYOS2zAJPPn2l47khqUxjke1DsX1c7iogs2p+MdG/BNW/wt8+z7Ox10uSkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cDnKHMoaTxdejvC6/XeRSaAG1P4hAPAw73KXQi87780=;
 b=Ws/vEn2rIhsRjpKjI/hXqQeVH6PkJN+vNvnSPRQ5OYraPhDytlcQQWKmf5hjbf4QXQ3W1HB98LLK825s/2l/dIanUuXRPa0hRjO2iSX8iqajwcMBG1UGjn+A64exqUTP77UiQZgj8FSDkfprgJYyin24w+dWYG2LL84okbADdfKo1IfOvKNx8jKSYSRVrgUopIj41k8BTosQcjlTeBgywsblnaDktanMLyEszA6YTkJnbi3iHVS5bsl/1ifnTrtMHrf8E+a1VP4K4tG5RFK92LvgEsTlfhxRnCi6LwWP1sKU9qh8Z8gAKUazj6oQ0VHfMhZmApzWGJRKxCENHpn5sQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cDnKHMoaTxdejvC6/XeRSaAG1P4hAPAw73KXQi87780=;
 b=AI40671LuJXrNISY7fThGsXY/BN1ImuUDIJkhCDZY7/afYf4k6ufKhM1gcWqPbb3PfbmRqoH+0lrECuMTEqXR+7sNMgn3d6kXeYDjxIHO3bys7waJMUL5nxF2O04Q8woBsjpq1sqckPtcm082Ec2DeuW+oy4kvV++itxnAD5+jY=
Received: from PH7P220CA0117.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32d::34)
 by SJ2PR12MB8111.namprd12.prod.outlook.com (2603:10b6:a03:4fe::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.6; Wed, 25 Nov
 2026 17:11:55 +0000
Received: from BY1PEPF00026968.namprd05.prod.outlook.com
 (2603:10b6:510:32d:cafe::9) by PH7P220CA0117.outlook.office365.com
 (2603:10b6:510:32d::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.7 via Frontend Transport; Wed, 25
 Nov 2026 17:11:54 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BY1PEPF00026968.mail.protection.outlook.com (10.167.244.152) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.3 via Frontend Transport; Wed, 25 Nov 2026 17:11:54 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Wed, 25 Nov
 2026 11:11:54 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Wed, 25 Nov
 2026 11:11:53 -0600
Received: from xhdappanad40.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.57 via Frontend
 Transport; Wed, 25 Nov 2026 11:11:50 -0600
From: Dileep Kumar Nagavarapu <dileepkumar.nagavarapu@amd.com>
To: Jonathan Cameron <jic23@kernel.org>, David Lechner
	<dlechner@baylibre.com>, =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Michal Simek <michal.simek@amd.com>,
	Conall O'Griofa <conall.ogriofa@amd.com>
CC: <linux-iio@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <git@amd.com>, Dileep Kumar Nagavarapu
	<dileepkumar.nagavarapu@amd.com>, Sai Krishna Potthuri
	<sai.krishna.potthuri@amd.com>
Subject: [PATCH v6 15/16] iio: adc: xilinx-xadc: Add .setup_channels() to struct xadc_ops
Date: Wed, 25 Nov 2026 22:40:29 +0530
Message-ID: <20261125171045.1246381-16-dileepkumar.nagavarapu@amd.com>
X-Mailer: git-send-email 2.44.4
In-Reply-To: <20261125171045.1246381-1-dileepkumar.nagavarapu@amd.com>
References: <20261125171045.1246381-1-dileepkumar.nagavarapu@amd.com>
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
X-MS-TrafficTypeDiagnostic: BY1PEPF00026968:EE_|SJ2PR12MB8111:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d13eced-abff-4e5d-9cbf-08df4b173497
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700016|376014|23010399003|261009223027099003|18002099003|22082099003|11063799006|56012099006|10067099003|261102123227099003|261102130727099003|261021121427099003|261026121527099003|261022075727099003|261022105027099003|261028144727099003|261026140227099003|261021123027099003;
X-Microsoft-Antispam-Message-Info:
	T2j7kbN4A505491OWsNBLtQ+WWNoh/DQB30oKgkYr7MO42S5X4HlKBaD+l5JOaVeSgRc9MU4obY12dLTJ5ik+OB7Rhrdjyh17ROe5V9jValED6dtFIYdi1VW21dOg8aoenK1fVA7T4oNBhq7ZIoAdyAQcMerxW59b3aKEF/qtoS9UDmz+UYCiQAVpUlL+m9vF5eyrM5wdCB6zeLcKs7jk1Z/hMZ83ygz5GJsHnK7qzUmtJz2FC6hxVP3kYG89OLWsf9vZPD9Aq0QEQV/k2zsLQThAEF5Mo9fTebWjQwLQC2Uu3w1LHCutDEjP/sPcA1rrch6Cix4vUs/iUxWPgAuMgmwJI8Tkuf3YmKaocI0Sa0QRdRmcVjXrOMY8E8cTOINUgh3pjTLI9GKDjodDIwt3k6A6Kcjtahr2oCb19DVCzs0MW5OR1ph6FVjlzgt46HRBkqeKhbOrGiB/Moer7hHhW8v5UFMZhFlwCb/iFV5cDx2ALhXDmB8VX58M2KNE+0Gjmheo96DY5fP2bWif6WNmZ7YbMURBUBxX38uHDBjEfbrD28Gnj0NHaPGW5mBotsfUsrtvTgzaC6OfpgpNFGXzwcSbAGlv6hJ2QhYG12TE18fnrvTC3njazo05Ga8NSz+6xDoXaTbER2/x7AX+olPCpE6eGopt866NOoBuY4HGChf9FPSOD77X6GW5Vc+aymOxuci7Q8cL+4HSpNskwW6yw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(23010399003)(261009223027099003)(18002099003)(22082099003)(11063799006)(56012099006)(10067099003)(261102123227099003)(261102130727099003)(261021121427099003)(261026121527099003)(261022075727099003)(261022105027099003)(261028144727099003)(261026140227099003)(261021123027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	JP0aIuj81w6Sa1ny8E6P0O8RmmNg2xJmjMT2ZmE53Zh4HC2yGw4+Tt96vIQc8mELR57xJovYjF1U1ijfIQUgICJuvOnnQuiZXC8o761PYUaJH5TwIH+UZyGmyeDATJmkHAphluXeVBkT+1guwv91VujAuwjIyrHt0uAB4YLnhRM6ut9bsJA2dlRP5oRA2lkvk5THzgiUbWDPRN7RDBBIuD1uI7DHWgPL4JC277Z/vkeyBFbxuCsCz5EozJhqwRJMwt90zQIE1Z3Cas44wf13May810PxoDImXq/JV+qqN16hNGYxfc8Ldvz6IQn05k0xSkQs3g3r2rv6eq74u5I1pMj47wQ2DsNdnjfbsySPC25IY4bRsg/0Cu8UrHrG1tRoFRi3CgIhEsPjtIoRCMglxoolK435NnGoNRkVCMDj4KoEdEkljNuqTiJmWm9sGxgI
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2026 17:11:54.7827
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d13eced-abff-4e5d-9cbf-08df4b173497
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BY1PEPF00026968.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8111

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
index 8c23c54820e1..8989c752e57b 100644
--- a/drivers/iio/adc/xilinx-xadc-core.c
+++ b/drivers/iio/adc/xilinx-xadc-core.c
@@ -656,7 +656,7 @@ static const struct iio_info xadc_info = {
 	.update_scan_mode = &xadc_update_scan_mode,
 };
 
-static int xadc_parse_dt(struct iio_dev *indio_dev, unsigned int *conf, int irq)
+int xadc_parse_dt(struct iio_dev *indio_dev, unsigned int *conf, int irq)
 {
 	struct device *dev = indio_dev->dev.parent;
 	struct xadc *xadc = iio_priv(indio_dev);
@@ -762,6 +762,7 @@ static int xadc_parse_dt(struct iio_dev *indio_dev, unsigned int *conf, int irq)
 
 	return 0;
 }
+EXPORT_SYMBOL_NS_GPL(xadc_parse_dt, "IIO_XADC");
 
 static const char *const xadc_type_names[] = {
 	[XADC_TYPE_S7] = "xadc",
@@ -787,9 +788,10 @@ EXPORT_SYMBOL_NS_GPL(xadc_device_setup, "IIO_XADC");
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
index 9d9959ce7aaf..8d3b5cdbd969 100644
--- a/drivers/iio/adc/xilinx-xadc-platform.c
+++ b/drivers/iio/adc/xilinx-xadc-platform.c
@@ -407,6 +407,7 @@ static const struct xadc_ops xadc_zynq_ops = {
 	.get_dclk_rate = xadc_zynq_get_dclk_rate,
 	.interrupt_handler = xadc_zynq_interrupt_handler,
 	.update_alarm = xadc_zynq_update_alarm,
+	.setup_channels = xadc_parse_dt,
 	.type = XADC_TYPE_S7,
 	/* Temp in C = (val * 503.975) / 2**bits - 273.15 */
 	.temp_scale = 503975,
@@ -511,6 +512,7 @@ static const struct xadc_ops xadc_7s_axi_ops = {
 	.get_dclk_rate = xadc_axi_get_dclk,
 	.update_alarm = xadc_axi_update_alarm,
 	.interrupt_handler = xadc_axi_interrupt_handler,
+	.setup_channels = xadc_parse_dt,
 	.flags = XADC_FLAGS_BUFFERED | XADC_FLAGS_IRQ_OPTIONAL,
 	.type = XADC_TYPE_S7,
 	/* Temp in C = (val * 503.975) / 2**bits - 273.15 */
@@ -525,6 +527,7 @@ static const struct xadc_ops xadc_us_axi_ops = {
 	.get_dclk_rate = xadc_axi_get_dclk,
 	.update_alarm = xadc_axi_update_alarm,
 	.interrupt_handler = xadc_axi_interrupt_handler,
+	.setup_channels = xadc_parse_dt,
 	.flags = XADC_FLAGS_BUFFERED | XADC_FLAGS_IRQ_OPTIONAL,
 	.type = XADC_TYPE_US,
 	/**
diff --git a/drivers/iio/adc/xilinx-xadc.h b/drivers/iio/adc/xilinx-xadc.h
index f6549828f05a..fa214b2f2328 100644
--- a/drivers/iio/adc/xilinx-xadc.h
+++ b/drivers/iio/adc/xilinx-xadc.h
@@ -81,6 +81,7 @@ struct xadc_ops {
 	void (*update_alarm)(struct xadc *xadc, unsigned int alarm);
 	unsigned long (*get_dclk_rate)(struct xadc *xadc);
 	irqreturn_t (*interrupt_handler)(int irq, void *devid);
+	int (*setup_channels)(struct iio_dev *indio_dev, unsigned int *conf, int irq);
 
 	unsigned int flags;
 	enum xadc_type type;
@@ -221,6 +222,7 @@ static inline int xadc_write_adc_reg(struct xadc *xadc, unsigned int reg, u16 va
 void xadc_write_reg(struct xadc *xadc, unsigned int reg, u32 val);
 void xadc_read_reg(struct xadc *xadc, unsigned int reg, u32 *val);
 struct iio_dev *xadc_device_setup(struct device *dev, int size, enum xadc_type type);
+int xadc_parse_dt(struct iio_dev *indio_dev, unsigned int *conf, int irq);
 int xadc_device_configure(struct iio_dev *indio_dev,
 			  int irq, unsigned int *conf0, unsigned int *bipolar_mask);
 int xadc_read_samplerate(struct xadc *xadc);
-- 
2.34.1

