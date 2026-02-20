Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013020.outbound.protection.outlook.com [40.107.201.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EE9A31578B;
	Fri, 20 Feb 2026 05:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771566017; cv=fail; b=ZBwDXqHIJP3Hdj1+NCFm+LzZDATPsb2KK+uDBLZdTmD6jE0A1xkLNt4YAZPV/oS3umaU1L9L16S88uAmiy9KaRI08l2srFowX/sAbFZ+e7JqS6S55SUTnhlNlCq2FX2X/YvGc4MIU6CGGSELsdgVgFf/lEfXyGMM/IzgnwIKAyk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771566017; c=relaxed/simple;
	bh=yuWaz2REvFcUiRhrWXbVobJLHSmppRlpdbRDvoZy8bo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h+hkXPyMO8KpweTy9QGRxVhl9gRoTrsp9QmglZqVFls6+VIM6g9FpeELM+HE2Nxtz7t5E7w95xwKQVyO6ekTV0E+JfIl+XXDBThjaKv35A5GdXv7QL+5/rYpAkW/r+ZChi/R3LloECj3+RY998WSg6+HMp58J7V8CC32mRQVTag=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2Ku92QUJ; arc=fail smtp.client-ip=40.107.201.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2Ku92QUJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w2lQrDIxGiMyGpOlJ8uLofZGSJmXe7WovAxq59cUa8/2Am8Jx3aefsMmclNuhskhh7Ar6q4HJpV+2I+R1FAUh4QIoyPeHB60wOmuAzimmVhg/FyqwxPD0A20P8k33W93TTjd07a42qTNlW66DcaEwCbT2cZlq350lCCBAfvCCIRkFlz9/YhvgxgYbrePJ65P1xiVT99XmlIfZ/ccHqqjw4dsmBp+a+S2o8H075b0P2JTwkz5fYPsTZWQ2A+b0eTl39/SgM3FGTcrlP80jE+a6K/c+wWqyaO8zvqqgw+TOjaQgTXSStyiJq/KvdtYiVsjqB/jKLCYoCOgcrrk7PVqtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+wdUt2dSNm2GqVK125mXJSF2vz5CQ7nIl/xPax9bWT4=;
 b=E2PoyirlOzk4iBzd4Yz98ghGTBHBQGfgB7BjyGhXnt5T+iNgS/VbDzvr1xDwQHEZDWIXQuqo4gJmUOZdypF9y3ziw7VV9bKdE1H3i62tdfkV8bUAVh5JsNmUMfGsD5+QFUJEFMObD9u2DAMTN2DPw8S/ijivC7WjugsoVWwejKl7uOto/8/2qdcmkaaJMiO2fflrPq68qN2XuzL5eciDx3Y2pCVYHbA37YwgrbhuU/7Bu+5s2omEQol3irgWeQiGfCE8M2Bw3yY/SXAcxpNXs/ZShTfgPkYc7QDKhjjAM7wgbtMWF+dtJjEW3+CYQDJ5d5SOI7BezBaciI03bNpqvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+wdUt2dSNm2GqVK125mXJSF2vz5CQ7nIl/xPax9bWT4=;
 b=2Ku92QUJSwrLTvGo/JP4Qa2zfhz6yRlEBMn3QiaheEOK3eLTs4udCDlJlgke44aqLnjp275cJvqUsh+U7/Tdqvyz86wQWyMeh+BzQ+Xrl4ncWGQken8FNHcYRtpXRBvnbJjyjhL4CT+1fzXCStzfDt/eBLsyGOAQOGXYqLVObwk=
Received: from SJ0PR13CA0016.namprd13.prod.outlook.com (2603:10b6:a03:2c0::21)
 by MW4PR12MB7465.namprd12.prod.outlook.com (2603:10b6:303:212::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.13; Fri, 20 Feb
 2026 05:40:12 +0000
Received: from SJ1PEPF000023D7.namprd21.prod.outlook.com
 (2603:10b6:a03:2c0:cafe::59) by SJ0PR13CA0016.outlook.office365.com
 (2603:10b6:a03:2c0::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.15 via Frontend Transport; Fri,
 20 Feb 2026 05:39:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000023D7.mail.protection.outlook.com (10.167.244.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.0 via Frontend Transport; Fri, 20 Feb 2026 05:40:11 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Thu, 19 Feb
 2026 23:40:08 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 19 Feb
 2026 23:40:06 -0600
Received: from xhdlakshmis40.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 19 Feb 2026 23:40:03 -0600
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
Subject: [PATCH 2/5] iio: adc: xilinx-xadc: Add setup_channels function pointer to ops structure
Date: Fri, 20 Feb 2026 11:09:38 +0530
Message-ID: <20260220053941.611415-3-sai.krishna.potthuri@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260220053941.611415-1-sai.krishna.potthuri@amd.com>
References: <20260220053941.611415-1-sai.krishna.potthuri@amd.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: sai.krishna.potthuri@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D7:EE_|MW4PR12MB7465:EE_
X-MS-Office365-Filtering-Correlation-Id: e0a3177a-37e4-4707-2052-08de704283f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WOqbPXJsoqPOgLxcoHD0uAwh6TsYf1CyWi9mNz2BU1oKSrtiIoi0Ji1e4P+w?=
 =?us-ascii?Q?8QBjgnVVP7L9UZ8ZTgI/IY6K2jpK9Dwm12MXA9S7nl+shu4wDCrfBjU6klw8?=
 =?us-ascii?Q?yobyzG4p2ZtkVRZpHfZc2F1aTe5lzRdaVsFmOXFELtBM9BnUFsDWud1MDRbE?=
 =?us-ascii?Q?gLPUYQr3gcrNr6QkwulmQ4gXX/rJd4iI0Pkwfy+i+uLzaLCMwd0fNzi909be?=
 =?us-ascii?Q?pvRErYinUlnhqy0Amw/D6rW9/uvAJixnhoXBhPHBFBrTvxl/f01taoQp9tn/?=
 =?us-ascii?Q?JsMg07keF8o9Qww5vGkb4/UF+OHfCW3VA38EiZTKwk17KRbQf9u1ceE4vKH8?=
 =?us-ascii?Q?tn4hQIbOC9B+71DUtbGDbDAFfMS3aX8dJMdi8MYM0WodunzNU8XRX6UkmMa+?=
 =?us-ascii?Q?fUUxvlNHgnsTcx+EVg/Du9Q1K1/gFvEcXzOq5QZtr2utND36p2hrCueWI/FO?=
 =?us-ascii?Q?/FV6U4n90AK47d87btMjN1T6NaPLUB64ZIqi5h1J8tSLg/DyUJpNcPbXroQ+?=
 =?us-ascii?Q?iwIoHx2lPyK7pLFBnB43j7NfC/IbX/FH08okzKYFKsmFoeBmsKVr8V77QC0s?=
 =?us-ascii?Q?M6FzVGJomXtCyvoHu2RbwO6Qa5Rx8rWkatVebbW3XakNU9a95VqLQ2LWn0C6?=
 =?us-ascii?Q?5ygmZJr3MK1oZTrOhXV36a79vSGM0an8YNuxSxVR30rGGcGd+OK6k1YAk402?=
 =?us-ascii?Q?xd4Y82SxIzoDStfxag4JhjZygLqiZDZTfWSZeZol0eQEER4sgrtRh83EfrBS?=
 =?us-ascii?Q?PsA5B5ilolvqWPiwtz8eaQb1vsH7ovDZZVC9gD5J87nOx6yzH0S7165InSx4?=
 =?us-ascii?Q?z0gIgwZTCSVsueUJncHEpw/IszFRJG36fSP5HpBSSCjVyO6FX9We8YFsbMKK?=
 =?us-ascii?Q?rXO8zPNsrVXLpGU9JICmXLD7pD/ASs3KgddZ+XbtItdrQHs43XIO7irhOl2f?=
 =?us-ascii?Q?BJio5rpq+krYyMEPEpAGEvafXS1k9vKy65xNKzuzzQzTBISHpyry+x2Cg5rz?=
 =?us-ascii?Q?tqAodg2t0VKCZr0RuZvz/3I/JZz5/+Wt+IP+pENFeANid1wQKXvBxGjDECny?=
 =?us-ascii?Q?yLxUks6JQtjfXDmkxheNz5DZGrLGHIfTb5UDZ8m2DINjdOLYhUFiB9sUHbbm?=
 =?us-ascii?Q?c+HuAwDbTc+ukyl5HYMhxl4vIOr7843rzt4k398MNt66lXch8zM57jyQImgw?=
 =?us-ascii?Q?5b/dCff1DVjNdqepRkKKbWczvKzG9cuH0ZsgbsWgRNWTVaaBu21k3QEuJL7z?=
 =?us-ascii?Q?/sZkiaEuQuEIk8NxzBvDtlxDahF0ftcKbmnxek+IILUa9EeK/2ZooVz7hyam?=
 =?us-ascii?Q?Q9d3Wd+R8Yl3+tTHQjMzJCG/gpbh+mI+RAgT5Co6gZL3kSYqpchBBPvXItUE?=
 =?us-ascii?Q?1U+vd3ctGCdf8yscya4sgUGDPtsZlWa39A0egeITkBO5FOPZ+SRTsgLsUYS3?=
 =?us-ascii?Q?3QWyD1xbtq6Ibno/3g5aIkgMQQBvdP/C5HDs0yH+us5zzmgXZz4q6fM/IfZK?=
 =?us-ascii?Q?rs2ReovtZR3tQxELOHOfHr/HG3zo0Hi6x/6sjwEzkn6WWMhHXiu4o3yh9yqc?=
 =?us-ascii?Q?0xpnA85DtPz2U0Pj01eO4o8pOjo+sAmV3Ek/B/wStec8dvR7xHxWJKG/ca9y?=
 =?us-ascii?Q?6EkmeC64Iqy+5smNqwrRbJ+w0vzA3gJAKEHi/AhsZamFhGsqBDzJ06YiE0XT?=
 =?us-ascii?Q?Cr9fCQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	/uNl67nR+4sPSOpIc+hEgDb3xByhKk6chDQ5IZACOS+4inl4ZzgS0xx2MubS/8LAQckHFwUvXyGQB9HmE8YhLqijAGVdQAOL0aHByIeSx69Ze9oO1gfYhhHbcEmfDZVZwFfooc3EN8zu5VnAhdsI1zG/1L8DzgX4Z6lM0kp8R03phyfkaRf98+jiD0F7QWlsMIq8mh7pFlGWC7PPkYTFAAcHcoaHKx63aMNSjP5QLYNb4M1Bs4wZyFACWKNF0ZUsLwnn5TBMOudeIRuEW6m/NgN37bkU4KFgJvJUceZ0gvZGTdHEkU5fdXGsHofbOZplbTQkgiPHKKXSGZxbUOq1CW2KSQg+RX9QLrk8f6y8AjtKsMtNuV2KcE/Xs6jXog735yfvcD94d/xDKnwq0Aq3Ws5V63XtlBIn5oxswdSBB/Md1qX5P6rm/ib/YiWGcgXH
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2026 05:40:11.6179
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e0a3177a-37e4-4707-2052-08de704283f0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D7.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7465

Add setup_channels function pointer to xadc_ops structure to enable
different interfaces to have custom channel setup logic.

Signed-off-by: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
---
 drivers/iio/adc/xilinx-xadc-core.c | 8 +++++++-
 drivers/iio/adc/xilinx-xadc.h      | 1 +
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/xilinx-xadc-core.c b/drivers/iio/adc/xilinx-xadc-core.c
index 52b51821007d..ee58b4a80f34 100644
--- a/drivers/iio/adc/xilinx-xadc-core.c
+++ b/drivers/iio/adc/xilinx-xadc-core.c
@@ -35,6 +35,8 @@
 
 #include "xilinx-xadc.h"
 
+static int xadc_parse_dt(struct iio_dev *indio_dev, unsigned int *conf, int irq);
+
 static const unsigned int XADC_ZYNQ_UNMASK_TIMEOUT = 500;
 
 /* ZYNQ register definitions */
@@ -455,6 +457,7 @@ static const struct xadc_ops xadc_zynq_ops = {
 	.get_dclk_rate = xadc_zynq_get_dclk_rate,
 	.interrupt_handler = xadc_zynq_interrupt_handler,
 	.update_alarm = xadc_zynq_update_alarm,
+	.setup_channels = xadc_parse_dt,
 	.type = XADC_TYPE_S7,
 	/* Temp in C = (val * 503.975) / 2**bits - 273.15 */
 	.temp_scale = 503975,
@@ -567,6 +570,7 @@ static const struct xadc_ops xadc_7s_axi_ops = {
 	.get_dclk_rate = xadc_axi_get_dclk,
 	.update_alarm = xadc_axi_update_alarm,
 	.interrupt_handler = xadc_axi_interrupt_handler,
+	.setup_channels = xadc_parse_dt,
 	.flags = XADC_FLAGS_BUFFERED | XADC_FLAGS_IRQ_OPTIONAL,
 	.type = XADC_TYPE_S7,
 	/* Temp in C = (val * 503.975) / 2**bits - 273.15 */
@@ -581,6 +585,7 @@ static const struct xadc_ops xadc_us_axi_ops = {
 	.get_dclk_rate = xadc_axi_get_dclk,
 	.update_alarm = xadc_axi_update_alarm,
 	.interrupt_handler = xadc_axi_interrupt_handler,
+	.setup_channels = xadc_parse_dt,
 	.flags = XADC_FLAGS_BUFFERED | XADC_FLAGS_IRQ_OPTIONAL,
 	.type = XADC_TYPE_US,
 	/**
@@ -1333,9 +1338,10 @@ static struct iio_dev *xadc_device_setup(struct device *dev, int size,
 static int xadc_device_configure(struct device *dev, struct iio_dev *indio_dev,
 				 int irq, unsigned int *conf0, unsigned int *bipolar_mask)
 {
+	struct xadc *xadc = iio_priv(indio_dev);
 	int ret, i;
 
-	ret = xadc_parse_dt(indio_dev, conf0, irq);
+	ret = xadc->ops->setup_channels(indio_dev, conf0, irq);
 	if (ret)
 		return ret;
 
diff --git a/drivers/iio/adc/xilinx-xadc.h b/drivers/iio/adc/xilinx-xadc.h
index b4d9d4683117..26cd65153176 100644
--- a/drivers/iio/adc/xilinx-xadc.h
+++ b/drivers/iio/adc/xilinx-xadc.h
@@ -82,6 +82,7 @@ struct xadc_ops {
 	void (*update_alarm)(struct xadc *xadc, unsigned int alarm);
 	unsigned long (*get_dclk_rate)(struct xadc *xadc);
 	irqreturn_t (*interrupt_handler)(int irq, void *devid);
+	int (*setup_channels)(struct iio_dev *indio_dev, unsigned int *conf, int irq);
 
 	unsigned int flags;
 	enum xadc_type type;
-- 
2.25.1

