Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.56.33
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794287351;
	b=IhHhgaEkq/5DVehOtUcJxd1tHRCz2FsHeLyi7EAT4ngVz8rYzrYhLrE3FUKec8fFC5IQ
	 Tdm1LlQtnfJAuDnaPndDLs3kcv7TOy+xTRP2cA/MMsxcM+iw3Fc4PMdOhxOehJgtZltsL
	 xZcGW9ib6FcJsPergaXuvUyOnNvoe2AmYlcGr0r468UoUaFpPz2JRkT5WWq32F9Fi4FxF
	 ckwY1//KuqTiLFWBMjlMoGPkGDRZUqC48ZN+jzC2XQE9ecawBn6KdzeucsbfvkCJ8uCQr
	 5XZ5eu/obAIGSzzAVbQuyEna8J6JZWTCDhuaDKTEUCbQYdzsSZi8Z1A3WWbh9nMChVQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794287351;
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
	bh=WxvYXL+Mrspvq0GNbEulw2iy0Ot2VurCNkfL5b1LRDs=;
	b=IT+gBHNTcgMwiCmYKpoi7zubmect/oN/sy11+VN8z/XYAu5Y+bIgbImxuVVHVyfF5FNd
	 JuLiTWym2W92LzY0BXeKoYatcXLvfYUj/fHm1UcLPDDEvlEoXRM3csgR1NEKUZcmhoB2c
	 sYLDL5Vgsksyg74z7tTVeODjooetumwqgy8VQO+hp7eY+XSNftOEAYVEUriNDTvAG7tg/
	 x2x14oVVgcpYvQ1UrQZAQwJYqaqKsV3HC0cfyKm5Oa/vcerzKNJiRIzVYpR4O+4XQ4+Ss
	 NyFl74Y5qqa8Pgs8Dg4mYy8pb5ppLMH5flmrkV4eoxMs/B3KlyW44EQ4Ss56Wu3ePJg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=QXO0G7F8;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.56.33
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010033.outbound.protection.outlook.com [52.101.56.33])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE14A60A2615;
	Tue, 10 Nov 2026 05:09:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AE14A60A2615
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=QXO0G7F8
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ri0c0koBaT4v1Rsnjh4eF64grguUzCSNOv/+IUe/0pop9SC5J9+bm/xWfxBRHp6r2UZXwTRkaDQqlWSCmD7X1HMVJIYoQUdPzE8/v/wSMvI/aPevVuolIu83duM5N/paACF5vTQxjBvv969FiE5RbhsNAJ7iKg74bHJ59Ze4EKyQHNMhNZYVP57jTl453r5VDbpjBxQGiPyZ0nXdVmb2lyfMc9Gvb43iQsprr+pxyS5I/ifZwcdFu7P28f5R4s8AdyXYGaIbCGv7+d1QqiFA6EvQIFNR2SmxAv45gdupZguisu8xw/SzjrZWRlty+AJpUYuDnllVOxrH0hvU3X+kzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WxvYXL+Mrspvq0GNbEulw2iy0Ot2VurCNkfL5b1LRDs=;
 b=SkDNn4Py6hyc/QeEv6Ces2g4v6f0pJ1DlGrLt3fFFM5wGyeDdokCKKS3GtSWvHydKMYj5dE6Evcp4cdore1uZprEopv51aOD5WBI6z7gAg+zQK3PSgRHDzXu9KVGHbxtuycnp04GzzAXHuhTstvfB2DRvM6lC5vGiaYeSUyrWl9riqwYRoO2k6m7SrnMwHkxNw0Z0whF4v4rrOXiSXx8v6LLx8Y+j9Uy8MsAKSim4kx0UrgKHNBdN+GavTNj7OsFOmlkx+GCcfrFavPMAxdbmTrL0IAvtKG0gWj90UYO3+QbTQUx9GFL9Di/bWaCnrdysxriq44ZTktpxV7QIb8PTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WxvYXL+Mrspvq0GNbEulw2iy0Ot2VurCNkfL5b1LRDs=;
 b=QXO0G7F80alILRkqhYQY72C71W+ZHSkvmH4rYbd6kS7qAqTjAu8xDRQgrBW8ik96WBIvm2cBSoven2uhm7y/V+Zr8AX6zC34Etm149NFzPskrNmF+QD3tfTZsXuTh4OGMw4P8kVlJyUlI0+hMXbVIciwZcI2twqIQKjpOnQTnls=
Received: from PH8PR22CA0010.namprd22.prod.outlook.com (2603:10b6:510:2d1::14)
 by PH7PR12MB7818.namprd12.prod.outlook.com (2603:10b6:510:269::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Tue, 10 Nov
 2026 05:09:03 +0000
Received: from BY1PEPF0002695B.namprd05.prod.outlook.com
 (2603:10b6:510:2d1:cafe::17) by PH8PR22CA0010.outlook.office365.com
 (2603:10b6:510:2d1::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.8 via Frontend Transport; Tue, 10
 Nov 2026 05:09:03 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BY1PEPF0002695B.mail.protection.outlook.com (10.167.244.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Tue, 10 Nov 2026 05:09:03 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 9 Nov
 2026 23:09:00 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 9 Nov
 2026 23:08:59 -0600
Received: from xhdappanad40.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Mon, 9 Nov 2026 23:08:56 -0600
From: Dileep Kumar Nagavarapu <dileepkumar.nagavarapu@amd.com>
To: Jonathan Cameron <jic23@kernel.org>, David Lechner
	<dlechner@baylibre.com>, =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Michal Simek <michal.simek@amd.com>,
	Conall O'Griofa <conall.ogriofa@amd.com>
CC: <linux-iio@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <git@amd.com>, Dileep Kumar Nagavarapu
	<dileepkumar.nagavarapu@amd.com>, Sai Krishna Potthuri
	<sai.krishna.potthuri@amd.com>
Subject: [PATCH v5 08/16] iio: adc: xilinx-xadc: Simplify common coding patterns
Date: Tue, 10 Nov 2026 10:31:53 +0530
Message-ID: <20261110050201.1850399-9-dileepkumar.nagavarapu@amd.com>
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
X-MS-TrafficTypeDiagnostic: BY1PEPF0002695B:EE_|PH7PR12MB7818:EE_
X-MS-Office365-Filtering-Correlation-Id: 22462210-bb31-4b39-f9e4-08df3ee8bd07
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|376014|23010399003|82310400026|56012099006|11063799006|261021123027099003|261021121427099003|261022075727099003|261022105027099003|261009223027099003|261026140227099003|261028144727099003|261102123227099003|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	I8knyj+uHvh24sAfngrvp/nolv7Z/lnbziP11eC7l6gA35e15ADC7viCw3PC1QBUgJvNp/niBJBY6WPuWp0AVj+5gzvMDnkZRNq2fc8HVAFbY+zixStcq8c71SUxnIQGmK7XYC3V0Qpfmx3Se28LGSySrxgL0cXW87OZzcXYinFawmuLnqj+VeH371vd1keiXJGFshrMZhGmUGQB+c2EFIaTt1xncY85Dy/Itc9mkdvzJPfg6alh0dNf8ZWYmc4XtNRjN8wGyv1iBfKvz2tNA4273Q78m82d6urYYtXj038TCskXYPOBaXNLkUdqbdJipN+y8xajRAn4BuxuWn4bHf4oW5zcbBgKxVenWxfBX8b1mlww0ZATtkY0TJDqLuCusynUJawpdMk+vY29HZAh7KR/uo0PERzTO7JFISINwYxw4VqsJdxZQ60ylUjHy7Zuil0z/+uprbHwI5WrZpRiCBJjQiIGpILKSdxl7U9QJy6eD3Szejp6wS1AdEbHKuA/xSQt46PEGdYaVPlS4j3+JOZO306lpfQO/ODCu6TaIYnAZKEzOaJlNojxMiEOaz5cr/3525w9kXhDAbuWwfHYfyxrXGMR3wjf3Jo9jqf6cUK3GJBaK4lg1SPcS14bRAljxvo/ILKtFV1y1sn3xdZvYBWEppTtSEvCBuXuc1SR49b+IOsjvC1iSrXFXHBCGdKgl1+6G3l5wvgQB6YfAh557w==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(376014)(23010399003)(82310400026)(56012099006)(11063799006)(261021123027099003)(261021121427099003)(261022075727099003)(261022105027099003)(261009223027099003)(261026140227099003)(261028144727099003)(261102123227099003)(10067099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	j6KWzOSsqNTyoVBtF/PVpZirswHhCfod6pyc0qAd36Wele8JlS+zy+pkIj9VZ0CjnQhojzthnK0705JTA0G53Ahjbi5Y7IcPJp8gRAas7xbeWxGewhmyL8IgHyGWyGzGBSLYCygCS1HAxuwJJGyHrcHebSlnMgK4QtKeFoYnCcQ6AEdo89kog5u2yAyButDGFRHCzyBrzHvWL9/OzuegeOfzJo1fnfIfbHBOXSM1eHSbpBgDLucV7KOrDNI6B0taJyZj65226GbG8ONSSUJ0zasyvKgis8j+jkkgjD3433BmBpN5zwXZ4L6Sot+e+UXKwUbKrjatFNx/+t0zWnFa94HS1qfshWiC8ENZSbUG8a4sMtM42uMEXjqrKM5iT7JYo+73O+IXZl1AYlB8Ea+asHiuASl7RmXxYCEgM0gcO8qXzwGo4npf34QKyoox+xIo
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 05:09:03.3603
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 22462210-bb31-4b39-f9e4-08df3ee8bd07
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BY1PEPF0002695B.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7818

- Use pointers directly instead of comparing them against NULL.
- Declare loop counters within the scope of the for() loops.
- Replace the interrupt mask update expression with a
  simpler form that updates only the bits selected by the mask.

The last two items were bundled per Andy Shevchenko's suggestion
during upstream review.

No functional change intended.

Co-developed-by: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
Signed-off-by: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
Signed-off-by: Dileep Kumar Nagavarapu <dileepkumar.nagavarapu@amd.com>
---
 drivers/iio/adc/xilinx-xadc-core.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/adc/xilinx-xadc-core.c b/drivers/iio/adc/xilinx-xadc-core.c
index 093a7172cc06..7dc43a3bf3c3 100644
--- a/drivers/iio/adc/xilinx-xadc-core.c
+++ b/drivers/iio/adc/xilinx-xadc-core.c
@@ -149,9 +149,7 @@ static void xadc_read_reg(struct xadc *xadc, unsigned int reg, u32 *val)
  */
 static void xadc_zynq_write_fifo(struct xadc *xadc, u32 *cmd, unsigned int n)
 {
-	unsigned int i;
-
-	for (i = 0; i < n; i++)
+	for (unsigned int i = 0; i < n; i++)
 		xadc_write_reg(xadc, XADC_ZYNQ_REG_CFIFO, cmd[i]);
 }
 
@@ -169,8 +167,7 @@ static void xadc_zynq_drain_fifo(struct xadc *xadc)
 
 static void xadc_zynq_update_intmsk(struct xadc *xadc, unsigned int mask, unsigned int val)
 {
-	xadc->zynq_intmask &= ~mask;
-	xadc->zynq_intmask |= val;
+	xadc->zynq_intmask = (xadc->zynq_intmask & ~mask) | (val & mask);
 
 	xadc_write_reg(xadc, XADC_ZYNQ_REG_INTMSK, xadc->zynq_intmask | xadc->zynq_masked_alarm);
 }
@@ -678,7 +675,7 @@ static int xadc_trigger_set_state(struct iio_trigger *trigger, bool state)
 
 	if (state) {
 		/* Only one of the two triggers can be active at a time. */
-		if (xadc->trigger != NULL) {
+		if (xadc->trigger) {
 			return -EBUSY;
 		} else {
 			xadc->trigger = trigger;
@@ -719,7 +716,7 @@ static struct iio_trigger *xadc_alloc_trigger(struct iio_dev *indio_dev, const c
 
 	trig = devm_iio_trigger_alloc(dev, "%s%d-%s", indio_dev->name,
 				      iio_device_id(indio_dev), name);
-	if (trig == NULL)
+	if (!trig)
 		return ERR_PTR(-ENOMEM);
 
 	trig->ops = &xadc_trigger_ops;
-- 
2.34.1

