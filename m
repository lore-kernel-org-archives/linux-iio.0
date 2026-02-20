Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010031.outbound.protection.outlook.com [40.93.198.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2501A32AAD6;
	Fri, 20 Feb 2026 05:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771566011; cv=fail; b=Ys0ff9YxcQX3NRk/EyvndbZ2Kyjt48KLhTVKjV16axHtTLLh48o1qYWnGsZ+jARfDHZ4okhC6+RbOdkQLzBeAe/cUh9CwGH54iZV72PqCOVkg7Z1Y8zevBi7qCz26BZBbKtEkXL8J3yzOOZBGwzzyfd2R9r55Lvg92il0ikF6vU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771566011; c=relaxed/simple;
	bh=yKqfO3pfrF84Rs+fjFWw1JYF4J0ZIfcNhZsM1atUYi8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bFvXYNC6KrkWw1mNWZeJXDyfUI/8cDvwZ07BUb/I1l+wEzNWxCT4kiHZ51D4SHlJ2eoE1xSlhx10zuGY40Wmg0k7bkRCvJ088+M8Ter3Owf0WqZi4OtVgHf2+gSb5Zohx+FtY64JC82UW5/ugwsFIqHpemMoBIW3weffLO/l3RY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Xxc8rmCD; arc=fail smtp.client-ip=40.93.198.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Xxc8rmCD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wgSzJIYi49WlW5PGjqM92YrDxuA7bdnGZm+jr2U3QU8wJhpjkUqZvJeQEyr/ggT4UD0rkYoZE34k14db6CtqqwVdoqs+hNKmJEaiILhhIJwY5Wwvn8K6S88acZqjR5MvLHCEqQnDcEBSC3he5DSV7gcWyl7UmCDdQiqdqbW/ELsNCnMzDgtkrsKgia6P7HxhvAmQkR85mP8mZCzuSONHGI7dUA4W4nC5ciVQeUOq+JRIsZLlNAA/lL2M9nDtqd6vf6K0MnpszgosAJ3hmFAWelzlFTbdJRSPyJYwBoecktXlfW9x4tEujfCgAuUQK7LeF4EOjRdDUp5g1KHOVVPtKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t8ni5G+UmRnZqooiAImDOpqxvZjK60XqK40cUlybZlE=;
 b=KGKMAd8n/jpfUaXa/TS/KpTqB51Rp4w+dwQRhBHcHIVT2O8TOVR0Aq49EL0JEFI0eBexlqYPKLr25weolx8pM0cxF76IQ3xAxTqyki+m+CqbgpR0mUXVseiZpbd2ozFxH49aRNiuZ2TenGiNhpjvRgslmuLLDEB1Blxsui5rUPPkvPfgNYBCxEr4ul/OxYEQsJLfB24TZTxTJt8V7W4VH9UbDCNzuViK9QUioXr8o4WTcBhXVYorrgaSjKp4JXcD5HEFwDdbtHRjU59/PLHEDKm5fp1BP/iL1YaeklnZPS/cXBVIv+7lvAa4yeAw5b+T18qxhvzjUtnc0Fa+nlDuWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t8ni5G+UmRnZqooiAImDOpqxvZjK60XqK40cUlybZlE=;
 b=Xxc8rmCDvdcDpITiJWk+avrY3Q0mr39UpyWv0OyFNiGJbgUtShTo45iCOyx5mwlN2v/Kn5dmYia4VIm/2yj0NWD5vPjxzlzhxMOc6xucRtQU5xNMZA0GXgX9gVlE0TM8GHq8JvHXNE/RXQDKLDG1M5oEHdS0Y/GIi9/CKvLJGKU=
Received: from PH0P220CA0017.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:d3::24)
 by CY8PR12MB7562.namprd12.prod.outlook.com (2603:10b6:930:95::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.16; Fri, 20 Feb
 2026 05:40:06 +0000
Received: from SJ1PEPF000023D8.namprd21.prod.outlook.com
 (2603:10b6:510:d3:cafe::ed) by PH0P220CA0017.outlook.office365.com
 (2603:10b6:510:d3::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.16 via Frontend Transport; Fri,
 20 Feb 2026 05:40:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000023D8.mail.protection.outlook.com (10.167.244.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.0 via Frontend Transport; Fri, 20 Feb 2026 05:40:05 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 19 Feb
 2026 23:40:03 -0600
Received: from xhdlakshmis40.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 19 Feb 2026 23:39:59 -0600
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
Subject: [PATCH 1/5] iio: adc: xilinx-xadc: Add helper functions for the device setup
Date: Fri, 20 Feb 2026 11:09:37 +0530
Message-ID: <20260220053941.611415-2-sai.krishna.potthuri@amd.com>
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
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D8:EE_|CY8PR12MB7562:EE_
X-MS-Office365-Filtering-Correlation-Id: 29fd17ef-2ca8-4fd4-3725-08de70428056
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iyIjr0iqLqsh0nFzeiV+opDVqbBF+zDt02SHGGJ2QkSQkCKrmQ0U1+Af36/8?=
 =?us-ascii?Q?RaeN1/nEniTLRm2rDVwD9Sr/+8R040Z1iVzFP5EnvygzT0PK/ZrVoZrD5A7/?=
 =?us-ascii?Q?e8M+lQ2CICH1UTDJF6TkCagstb6IhWrZXQZ52RdJIRyi+r2QqNtdgxsA8b5I?=
 =?us-ascii?Q?BGnj9AovSDTXjxpe9HPiRiNxlYfVEogsRkEFwXOmXVDUuAVRBnHfYTqQ8ZLu?=
 =?us-ascii?Q?l2lQl40CRP5VduEJqGG+k99X0lYCL3mrxG5jw77h4bA6j+DSYuBJIvnAs2jI?=
 =?us-ascii?Q?qZJYYI5+4s3W2pdyahbQr/ycEjBUNWJxitx2f8Yz/fEheIabL85E/DW4rAWx?=
 =?us-ascii?Q?aISa7Lcg1eVtDnVanZ7JG4EcmFS2fMKSWFmu1+0O1cFR2aT0/q/h4vFbMLyF?=
 =?us-ascii?Q?PY1ANUWdGG7uzJQ/9RgJaJ6m9/pTECKXraKDbUpXsF5l5yk4QpL0/8v1RXXU?=
 =?us-ascii?Q?K4MkStT2kn1yNFbGviKt7HjCh6BuCFwaW37F6GmhoC/+jMs6j8+BpfsdSC8t?=
 =?us-ascii?Q?6RxYwA1qjGbC4cFthXfGpAuRsg5ftCPJ5FlhT3/avCMmVr9bWG1St58FeQVn?=
 =?us-ascii?Q?0nKHzoPZ1ynm6hNYW3Y9BhPWTV47ppSwqcFrP02AGdg+XTa4g/gLdGR/3FHA?=
 =?us-ascii?Q?lBM08SPKHVMnoKVvg+5Z3vKwv7cakDy4OiWe2yD8s220zySMJ+UKW4h6pCEq?=
 =?us-ascii?Q?sfk9Uw7+4UCJy7vE8QRkz44FPmJU8AXcdaOHeDB+vVKgzJhPhoVQrKFugCfL?=
 =?us-ascii?Q?z2H8tnqVZWzBKbO++19Hod+hYasy60PDX4cSc/twkJ1MEXALItFeAmMqkk2M?=
 =?us-ascii?Q?RY3KbSoVd/TONyPw9wheDIo4tx7zlZUV6bU7JhRcOjbJ0+mjOq6DKvq5S3S5?=
 =?us-ascii?Q?QkS16Qj1LKB4d2jFUaV31ojoqxrRZFWJybezwUM0rTmoNQJ+eaEvs931WGVv?=
 =?us-ascii?Q?H1ykwDHO4n85CxCBww2qwsh4DB1i0VupeTz1ExX1Uxfy9IDnuaAPG8DckgjD?=
 =?us-ascii?Q?GKNilWI6dXJFhYwzTMxYq1LY+OPAZj5FoaQ8hrw2EI7flDQ4ycyLYhsFgKQ0?=
 =?us-ascii?Q?5fqKJV1JCkYQ951KPJATRJ7agH7SKKsImLk/YbheyCC4gjNexO3vx5kuzISW?=
 =?us-ascii?Q?1WDlCx1DkDIdcP4m1eTesgvcubadoST5UyGOFnbHyuHV1lEjSqKP087cvs1S?=
 =?us-ascii?Q?M1fE7PS0U/AXwBdKkQRlPYf3N62oU5fW9vvCNRBrLXANsnhG3RPXGfU+yp8E?=
 =?us-ascii?Q?qiLpg7haYaxxIriVewrXtCbzOqBriWuVyoHXYDjXExhd6lvcAfXm7yyycgDx?=
 =?us-ascii?Q?1c3MKjUfYFSJIOyPitDleZFHEAWnPRci8hs2KJpJGTfazpnecz/otozRN8To?=
 =?us-ascii?Q?VKi3fIjm8aIBbz9EhUhjLSl7HhiZ03eU7uSed9qkp7BH/ph96S0HuuGCChlv?=
 =?us-ascii?Q?1fOH0jZPTcMBm63Les8AjQLW7HkecErTENKIPGbY79KUhpvZDNjhz3pJ2s4K?=
 =?us-ascii?Q?UFS7yQaVXeV7u6ylbv14k/Gy3lSov+0s9OmIT/5giDMtajvFb1hOtznQ3v9v?=
 =?us-ascii?Q?IoqpUJA76H1hgW4TTeFYN7wwkY95ebnyO5vn7BHwj7E5/2Lz2/pL1mjKuJb3?=
 =?us-ascii?Q?R0iITGY+zpitEKzZrxMQXMMyJnuLx8kkDcu06H8MuZZFx4zxzm+YlhRBiumy?=
 =?us-ascii?Q?igDTkg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	hezWzYwBFxb/x4W6OAR6IwxalI6Vy3GIC9NkWtwj8xaJWjz/fvcKItIujb7WTGTPOt1I570vLgGIGWw4q1joSGZ0DKY/0KdlPftkPGaPX+/Pi4JqoWWQGPN9UOkTVD4ef9L8uDA4oPQxajUt1W4x1QbyO6y9itFLDoD+Vmg+3G/n2KMu1gHjw0tgxX5LDOb/EGMFThBDr0UxmPjOqDFC/yFPE6lCJNwwfSTrPvcWC8E3VnTiYD5BVLODnK+S0tzdOpizo4NusxIV98yUh1MlURYR0p9+RdwPD4LT9T2kWtVBOIG95CTwQ3UGcyiRwzWRWZLWp0Zy/CCm+gBxufnueeXAVPC7jlZPBnvBSwVtvFt0nj3+n+Vakrc7zvFqpP2qOeM06pbDz04E8UjPv7I+p+bik3xpqvDfQRSdes3+5E+ffgFasJ8LmVnuITsjybLd
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2026 05:40:05.5698
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 29fd17ef-2ca8-4fd4-3725-08de70428056
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D8.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7562

Refactor the platform driver probe function by extracting device
setup and configuration logic into reusable helper functions:
xadc_device_setup(): handles IIO device allocation and basic setup
xadc_device_configure(): handles device tree parsing and bipolar mask
configuration

This refactoring reduces code duplication and prepares for sharing the
common setup logic between platform and I2C drivers.

Signed-off-by: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
---
 drivers/iio/adc/xilinx-xadc-core.c | 60 +++++++++++++++++++++---------
 1 file changed, 42 insertions(+), 18 deletions(-)

diff --git a/drivers/iio/adc/xilinx-xadc-core.c b/drivers/iio/adc/xilinx-xadc-core.c
index e257c1b94a5f..52b51821007d 100644
--- a/drivers/iio/adc/xilinx-xadc-core.c
+++ b/drivers/iio/adc/xilinx-xadc-core.c
@@ -1310,6 +1310,44 @@ static void xadc_cancel_delayed_work(void *data)
 	cancel_delayed_work_sync(work);
 }
 
+static struct iio_dev *xadc_device_setup(struct device *dev, int size,
+					 const struct xadc_ops **ops)
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
+static int xadc_device_configure(struct device *dev, struct iio_dev *indio_dev,
+				 int irq, unsigned int *conf0, unsigned int *bipolar_mask)
+{
+	int ret, i;
+
+	ret = xadc_parse_dt(indio_dev, conf0, irq);
+	if (ret)
+		return ret;
+
+	*bipolar_mask = 0;
+	for (i = 0; i < indio_dev->num_channels; i++) {
+		if (indio_dev->channels[i].scan_type.sign == 's')
+			*bipolar_mask |= BIT(indio_dev->channels[i].scan_index);
+	}
+
+	return 0;
+}
+
 static int xadc_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -1322,19 +1360,15 @@ static int xadc_probe(struct platform_device *pdev)
 	int irq;
 	int i;
 
-	ops = device_get_match_data(dev);
-	if (!ops)
-		return -EINVAL;
+	indio_dev = xadc_device_setup(dev, sizeof(*xadc), &ops);
+	if (IS_ERR(indio_dev))
+		return PTR_ERR(indio_dev);
 
 	irq = platform_get_irq_optional(pdev, 0);
 	if (irq < 0 &&
 	    (irq != -ENXIO || !(ops->flags & XADC_FLAGS_IRQ_OPTIONAL)))
 		return irq;
 
-	indio_dev = devm_iio_device_alloc(dev, sizeof(*xadc));
-	if (!indio_dev)
-		return -ENOMEM;
-
 	xadc = iio_priv(indio_dev);
 	xadc->ops = ops;
 	init_completion(&xadc->completion);
@@ -1346,11 +1380,7 @@ static int xadc_probe(struct platform_device *pdev)
 	if (IS_ERR(xadc->base))
 		return PTR_ERR(xadc->base);
 
-	indio_dev->name = xadc_type_names[xadc->ops->type];
-	indio_dev->modes = INDIO_DIRECT_MODE;
-	indio_dev->info = &xadc_info;
-
-	ret = xadc_parse_dt(indio_dev, &conf0, irq);
+	ret = xadc_device_configure(dev, indio_dev, irq, &conf0, &bipolar_mask);
 	if (ret)
 		return ret;
 
@@ -1418,12 +1448,6 @@ static int xadc_probe(struct platform_device *pdev)
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
2.25.1

