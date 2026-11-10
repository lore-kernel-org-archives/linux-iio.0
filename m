Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.43.1
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794287364;
	b=X3LzhKRaZGaSHTB1CyT8hof+9I5hmdC9U5jI95iPIDQORj5qzUBN3WUxRCmJNkAoAt6i
	 3xXQpr6+sceXlf6i/05W24mf1KioB8MXXM32OAwvrFnubkAgEQTejwUCnudgCpsePWcVV
	 KAeK1wGvf43++BS5Je0lQ73ZboJpl2j/xXQcQqC/8o3Hv5WxNtIB/rJ9tPNFJHgdXEhuK
	 GsYni2GgAVFLYQoCtExHzHej1C5iZ7QXV08a3bFYWIY2cmkMpuuHDwPIBe8MHAVJQU+Hf
	 O5XjRLTDDIP5XZLiBTleeo7YIrmE+s8Z3JgdlfggfLiigv3ZK2ljJjsdMcIKoNsudrw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794287364;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:Content-Type:
	 X-EOPAttributedMessage:X-MS-PublicTrafficType:
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
	bh=VdsENXLYnygIYRzPelMYuLq6p3R5VvMCxldq2mrX42c=;
	b=Fih1bx82fPDE8ICTORwGSKM0zYMWvfR4MaCylMVsOwt1tfRY5XLG+0N3ke7i1lnKxxP1
	 gdcYrLrLlqvZjcfwMvbwzc+kd0sN1d3W/oz7XQPOiDyHaLo5eISMUnt/RWXyvJejbJtm/
	 TlfINOr80tghVNZg2V6cCeQOT2W/NFvjG4pv4F+kox0QmRmQjrxzTO0XG4P4bOypTu9jU
	 K/NT0wQchVNpp/Z44BeWS2LZ9onrIrqOpBbacyE80HjThGoTWIDSTqwoD4wN099TGBVMx
	 eF5EPEBHhCWo0YwxgYr5+OV+54oCvjGaDeHZTHgKNfjYwRhjV5Z8rl9PFRtZEenEWjg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=p7fAj7U8;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.43.1
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012001.outbound.protection.outlook.com [52.101.43.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F976606A330;
	Tue, 10 Nov 2026 05:09:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4F976606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=p7fAj7U8
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OjHMLsY3LR+5+2Xw4pRVGXJE0aq4BUfRBwfCo/GBb395n/SvO8zQNKmqIn+mI4ddcNffvyMhNZf61ibgbThBQP9oFE/ResuJMQDi0WVQjAc7b7t4obFrC/UhS7Y4d8KgIOaeAI/9uGefAQmssX0zLoBXBlJiVOrenw+zOHtGp/GOXWhfVsCl4NIp4FoZKknQ7SfBIwyNWDKDEMarJfh67hTgNItt+dy3sUonI/NpM8vRlgdzioRKCkPTE2zyUk4JAjGNrC1NCb7WeTzN2Wf12ekUgyL9vjbD5Nredyj0NvNBnJTCTdOdlwJY2NcTFbFMt530i52PC+mNqPxYrQYyTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VdsENXLYnygIYRzPelMYuLq6p3R5VvMCxldq2mrX42c=;
 b=ehYfOtVhABFKXwYm9mz6bKlEWgfhb2VcIbhBB2zPGcpFdNubx6Aagx6ZQ6fWHTPZfzkxrU+EL1uR6X+CiwaotIyfOQaY5mHH0hw+iXCRJEn0YlycQ4SBuFlUnz5AtxJW8m0obv+o6bU3mDUgeh+sILSgdd8TJPlhTUG1sfXEyuIL7v4Ji943G0PwSarxH3qfcidOjZ40nb3E89ljdLDf4fMLPNxl4hp0TLqCoxV0NLBX56glSoF4eDkQHyMnFL29kqsnckItfK0AelMYpYcc8ya+A5lQOA3CWooQwgR+xenKVNG032lb2IfmldEvoo3jKDwOuLYpu17+IhCy3nAfng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VdsENXLYnygIYRzPelMYuLq6p3R5VvMCxldq2mrX42c=;
 b=p7fAj7U8Zu9yYsA5jyFrTDvh+FlrL9YfXRjmRB+ojj+H7i5R+9/Qvv/1Xh7soKFflA9MfY9DWzrhHyTwzDIHwNf0kZWt0mDh2+955heOFidbj0K8b5aAYg8rpEShb0BUdD7WAsAMSwx1gSF9LZJsMJwanHCJPIRjtIrZzqmtE3U=
Received: from MN0P223CA0003.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:52b::30)
 by SA3PR12MB7878.namprd12.prod.outlook.com (2603:10b6:806:31e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Tue, 10 Nov
 2026 05:09:19 +0000
Received: from IA0PEPF0000003A.namprd03.prod.outlook.com
 (2603:10b6:208:52b:cafe::82) by MN0P223CA0003.outlook.office365.com
 (2603:10b6:208:52b::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.8 via Frontend Transport; Tue, 10
 Nov 2026 05:09:19 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 IA0PEPF0000003A.mail.protection.outlook.com (10.167.249.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Tue, 10 Nov 2026 05:09:19 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 9 Nov
 2026 23:09:17 -0600
Received: from xhdappanad40.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Mon, 9 Nov 2026 23:09:14 -0600
From: Dileep Kumar Nagavarapu <dileepkumar.nagavarapu@amd.com>
To: Jonathan Cameron <jic23@kernel.org>, David Lechner
	<dlechner@baylibre.com>, =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Michal Simek <michal.simek@amd.com>,
	Conall O'Griofa <conall.ogriofa@amd.com>
CC: <linux-iio@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <git@amd.com>, Dileep Kumar Nagavarapu
	<dileepkumar.nagavarapu@amd.com>, Sai Krishna Potthuri
	<sai.krishna.potthuri@amd.com>
Subject: [PATCH v5 13/16] iio: adc: xilinx-xadc: Add helper functions for the device setup
Date: Tue, 10 Nov 2026 10:31:58 +0530
Message-ID: <20261110050201.1850399-14-dileepkumar.nagavarapu@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261110050201.1850399-1-dileepkumar.nagavarapu@amd.com>
References: <20261110050201.1850399-1-dileepkumar.nagavarapu@amd.com>
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
X-MS-TrafficTypeDiagnostic: IA0PEPF0000003A:EE_|SA3PR12MB7878:EE_
X-MS-Office365-Filtering-Correlation-Id: 89016ef0-843f-4839-f5e2-08df3ee8c6a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700016|376014|23010399003|22082099003|18002099003|6133799003|10067099003|11063799006|261009223027099003|56012099006|261028144727099003|261102123227099003|261022105027099003|261021123027099003|261021121427099003|261022075727099003|261026140227099003;
X-Microsoft-Antispam-Message-Info:
	kwe4fz2fP6pHS+z07dK/h3oNToSl8lL0kGnOra5I9rnIxgshhqcGj3rdpVvBDpexOjyJeyzV1MM0Zy4fKIaQPDTPvU/ZrkJu4pGSCA3MGs5fIYOt8swbT/5RIU6xpb0bd9dr8O1l5sL2h99eCV1qUgSZ34AmKe+KuDymIUt/TkWZtSwgyX2hMP8lUNpAoM8fn3TqaBK9O8I2vaW4wwR2mntMQSG8PHTck4TusTqzm3QkBO0OQkNF4CV8rbtXH3zZBfzo41kUNerixkyV8mWA4OvIcqqFbYyf+0NAi0mj4b4xI3KH6McQL/5fmCiHCfmDkgU3puMFnI4KGB5PWCxsv2mKkLdQ3Q35HA5t2B6VgQnc+k0hdt+nDId8oisyZtKDCeWBXZ+5hkUAikeE5EjsOs9UuYje9uhQHS6Cq8rTRue2wWIlBQkEvus7bN+ABdJDcJh0+9jnTQ+sAfaJ7OMY2+A/wsoEdJJktc+WYGn+uUe338JDh2AmbvaLTH2wrlD2cGxFX2aiV3+3uwnSos0a5s5fGQa9sJuvzSkJpwC23rCw38MVIE0/tridyH9SICSATex5p+1EjoV1Du7XhFTj1AjbJRKVrjUhnUGM6Mvae0C6rFskxBSIySH/b9uXBhUJIy9NxRaCXTriMywdvt4GWYbTa5RoS1NbJ1d9MoLSMV8gur/97pTcqUGKZH+BDPEqHyV3NGud9mv4zBwu8w+i/A==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(23010399003)(22082099003)(18002099003)(6133799003)(10067099003)(11063799006)(261009223027099003)(56012099006)(261028144727099003)(261102123227099003)(261022105027099003)(261021123027099003)(261021121427099003)(261022075727099003)(261026140227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	sKhMHebDgDaFX6WBTzw7NYlyNdN/ZxhMiApjviZx1qrB3IiKVKA0ZXVvtSJ15q4WLcI3LTMlhWfY0zoekSY5lQ2Y2meYRyv/X2ct4hdPjduZAvkrl2njY8kQgiCs+5srLb5d4p79zkwrsLYNsCfn2PqIBJm3u9tqIRG24a2MQoRZ0DdIGO+6ck9GEtTLJ8mbsrysEaHO8iNue28GGcbrYLmngh62OyURworxm04qsZKUuEUUwgytU4eJjRmbFVtmBOVxIp6j/rUqud+FMItK/m5nHaFRTyvzQNUAjiJKFpadgJ+DHWUPnZ5hYktw0zCLe1tnG5OmtjVenxL55wu3aCpgsIDSIPA19LMSLibWTGGvm7mspfVxGrydqgAR7dED2lrcpETzD5CvzhcpLM3pDvEY0YnaZrmldV+eZtnt1KHtXzeKFfIk6TpV5ehm/5h9
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 05:09:19.5728
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 89016ef0-843f-4839-f5e2-08df3ee8c6a6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	IA0PEPF0000003A.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7878

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
 drivers/iio/adc/xilinx-xadc-core.c | 102 ++++++++++++++++++++---------
 1 file changed, 70 insertions(+), 32 deletions(-)

diff --git a/drivers/iio/adc/xilinx-xadc-core.c b/drivers/iio/adc/xilinx-xadc-core.c
index f700b9f232d9..9d5cc6c86c98 100644
--- a/drivers/iio/adc/xilinx-xadc-core.c
+++ b/drivers/iio/adc/xilinx-xadc-core.c
@@ -956,6 +956,34 @@ static int xadc_read_raw(struct iio_dev *indio_dev,
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
+	if (irq <= 0)
+		return 0;
+
+	xadc->convst_trigger = xadc_alloc_trigger(indio_dev, "convst");
+	if (IS_ERR(xadc->convst_trigger))
+		return PTR_ERR(xadc->convst_trigger);
+
+	xadc->samplerate_trigger = xadc_alloc_trigger(indio_dev, "samplerate");
+	if (IS_ERR(xadc->samplerate_trigger))
+		return PTR_ERR(xadc->samplerate_trigger);
+
+	return 0;
+}
+
 static int xadc_write_samplerate(struct xadc *xadc, int val)
 {
 	unsigned long clk_rate = xadc_get_dclk_rate(xadc);
@@ -1279,6 +1307,39 @@ static const char *const xadc_type_names[] = {
 	[XADC_TYPE_US] = "xilinx-system-monitor",
 };
 
+static struct iio_dev *xadc_device_setup(struct device *dev, int size, enum xadc_type type)
+{
+	struct iio_dev *indio_dev;
+
+	indio_dev = devm_iio_device_alloc(dev, size);
+	if (!indio_dev)
+		return ERR_PTR(-ENOMEM);
+
+	indio_dev->name = xadc_type_names[type];
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
@@ -1300,16 +1361,16 @@ static int xadc_probe(struct platform_device *pdev)
 
 	ops = device_get_match_data(dev);
 	if (!ops)
-		return -EINVAL;
+		return -ENODEV;
+
+	indio_dev = xadc_device_setup(dev, sizeof(*xadc), ops->type);
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
@@ -1321,30 +1382,13 @@ static int xadc_probe(struct platform_device *pdev)
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
@@ -1390,12 +1434,6 @@ static int xadc_probe(struct platform_device *pdev)
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

