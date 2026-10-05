Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012039.outbound.protection.outlook.com [40.107.200.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36B49468C07;
	Mon,  5 Oct 2026 09:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791193378; cv=fail; b=O9v5bGlxshqq0JiZxyCTRYvhQ4tEKke8h1p5QfsGEs/AEKzhJrOLmq47dxR8mhDTcuLRd7BrKqKzpfbEx5eGVeVvdgXnZQfuoKtWMAU9uMGA+1zKg9INnhKJyC4lh/EYw4ZS6aqplELi7ATZW88qHfhYz+t0T99SU0KKZ03PA7o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791193378; c=relaxed/simple;
	bh=79ojde34b6PML6S+zqL7vPky8JFyiQ3Oo5xYaehkemE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WbpkCDF8RcMG9rOg3MM2WX0mVWwDORRTYq2cPtW1FV71z7cO4jsqRMFks+U/jCkkrMZeJ2zRZotu5MP+bcqGEndL57zWF1R+PmODw2BVlG6RrihQfFR+pwY4yAq1nu05YPDgT6Uszw6ORERRnmvii/5vun/D7FwbLd94om0GDX8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=HMoXoWLg; arc=fail smtp.client-ip=40.107.200.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="HMoXoWLg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qWiw5DtTQFyNp1v+NPOwo0TO1U/9p53f2UT7bB57+M3RidCBmJNLetwNf8dfBli46fFSi7V7gLxqHZxm/I83TBPZUk8EO6cIx5sLSiykuBMoMfLVaypDB/GpHPMvvmcZNHTF2+P/OGNNHmd9NdpoNz45nWRx6ZbsQ4Ngz7e8SDGxt0ewm1C6PObKn5T4r+BZRgQpxHip4wm/s/WOiMwsXDIM3mBSccl/1QPFPd+hQSiQNxj/ue2sF/s9QaGJ367DUhepUWg+4I/5NtL1yzuTXJkYEjhCBATWA4Ue+YMi1aM8qE5I3IbgtF1Hc4/AF9T8eo3YvXMi/K9N65DJ+2Tq3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E/pvWMokn1fbJZ37xijxxQTNA2PCE+dR5XdYXXFnx+8=;
 b=f3OgydLZmUC5F9eIKshr8nIuSAjYHf0yyO74HNwVm9trPqyKjgt19PdM6hnVEQD+6O9GiC26MsMKUx0zZsAzMd7OAUZZ4u7zoOO6sUYmkyNzUUDuotMUmBedqxEryoh1pKToytM6zu5H5k5U6pQn1toxeLN/7gszdx5gpZB7oYBv71I8FI8bmzdchgn0D3ph/D5LKotDDl25xi1o9Ju4k1uGGYm0KXVyf19AeO6JreWuZA80v9Q2DcDU6tZWABlIu+/CHUk/nFs3bc/+0LkcDUEw234hPiMutmE9IuzqkqBEo0jnY2/WBSBhdQ65OkRJIzxQr8y6rkUvNg7Xi9I6tQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E/pvWMokn1fbJZ37xijxxQTNA2PCE+dR5XdYXXFnx+8=;
 b=HMoXoWLgqJXUqM0BxL4WdaCRODd3ia9bt9dT8WMWs+3Kf7oQF78qV7MoJQkymSErHpMPHtQUZ3IBZmvzlT0sqqgEF7CyV5eIAF45HYhzfReapw782uOGrVlgIO+JFXP7a4s1GX8dl6eNF7tVrEjborONKuxiKJhFV8LGD32xgjA=
Received: from CH0PR13CA0010.namprd13.prod.outlook.com (2603:10b6:610:b1::15)
 by LV8PR12MB9450.namprd12.prod.outlook.com (2603:10b6:408:202::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Mon, 5 Oct
 2026 09:42:46 +0000
Received: from BL02EPF00029929.namprd02.prod.outlook.com
 (2603:10b6:610:b1:cafe::48) by CH0PR13CA0010.outlook.office365.com
 (2603:10b6:610:b1::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Mon, 5
 Oct 2026 09:42:46 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF00029929.mail.protection.outlook.com (10.167.249.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Mon, 5 Oct 2026 09:42:46 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 5 Oct
 2026 04:42:44 -0500
Received: from xhdappanad40.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Mon, 5 Oct 2026 04:42:41 -0500
From: Dileep Kumar Nagavarapu <dileepkumar.nagavarapu@amd.com>
To: Jonathan Cameron <jic23@kernel.org>, David Lechner
	<dlechner@baylibre.com>, =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Michal Simek <michal.simek@amd.com>,
	Conall O'Griofa <conall.ogriofa@amd.com>
CC: <linux-iio@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <git@amd.com>, Dileep Kumar Nagavarapu
	<dileepkumar.nagavarapu@amd.com>, Sai Krishna Potthuri
	<sai.krishna.potthuri@amd.com>
Subject: [PATCH v4 07/15] iio: adc: xilinx-xadc: Simplify common coding patterns
Date: Mon, 5 Oct 2026 15:11:57 +0530
Message-ID: <20261005094205.1045874-8-dileepkumar.nagavarapu@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00029929:EE_|LV8PR12MB9450:EE_
X-MS-Office365-Filtering-Correlation-Id: 62894007-b37f-4a81-3188-08df22c502e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|82310400026|36860700016|10067099003|18002099003|11063799006|56012099006|6133799003|22082099003;
X-Microsoft-Antispam-Message-Info:
	DIYUN/LFSkI/2NPh6Q0E16p7gRdDryP+ojXux+rtV4wTraABle/mi0EFi2IdTZbUfkrU4brHgNm1elLbVsQ3sJrSJH26jHIylGDYU8hrhuhty2ftUFSkPVtxbiU4Q8zjMuyC4ARQ22TRX7J3HuNjRgh3loEU9jn8+773BDBU3o3lnuClSU1CF/atoBW4kr8Ul6sW9uAQbbYcsbgopHG9KNRPlwBPRTd3fu2q+hEHUABN5+Hs/Y5vXVsSy73QrlmbUJwYuEawoPC5k0xOhxHZe0xdDkiZWx7nUE853GWl+lLdPjcnRJ/ARVSIfeL84J9DybhzgEE2l1hRiCp3EAfW6N5nJE9wKn4VHb7nPM8lCzRCq6SdpIYwoW0OVJTOsZ5Cp6NCJLTtZxgLy2DYz1/VSnwDZiLo0QEW/6M4E2KuzkYXizX+raazMTRE3Sh4fX0sVoDMdl2DNPAQIiRXp266La2qoVnxf3vMALDLtaZWtMwtAHVP0TN4ZEjHUIYEcDNd7lTNIqnXCScbAz6fzrz4FPdcnK7RkAxkYb4f57+fs9hHy4fW4uRKqiTGB4eJvNz2j9grNU+kCuTLx95prsPBJudkINjAtdbCJ0e1i5ey4nmefXiWFu/3BLImnzMAM4eM0Z2wyYqE6XyIR7REqd/gGcoghcajC60/DngqLwfC/CJy2RQob4zahx5XvISUoIcAw6wOc4rnWXnnUm4tkUC0jg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(82310400026)(36860700016)(10067099003)(18002099003)(11063799006)(56012099006)(6133799003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	4N31+TSKfHj71ENpICL5sQ3l87WTCrQIny1GMT9WvpFTl2yseeQXx7z5lqxe2SV7X373Ma9hqMoMCPKQVZBlAEbmsN1IweA1+EMZrEY4Iy4jh14Y7fwZdcUg6j+Es9Q9btAYtF2cP6KmLPJZGi1fhoIT0qblvOIj344ZxpNemahq0yNi19Oxf3KAFhWDLs6v3XDgxZIZAdry+mdtmij19IE4Li17m1+mqTQGKtilnjm+VozxNewzw5AhYQHsx10nkcmbAFipLy22zy8z0fAGhq9FuNXMdPMX9WFRfVqJzBHXc7Ej0zW9m1q9faYtIZvJss3pO3q2cTC6eYlqNf6eD7NTPs+aqqxwS1qBJFnixCuCUmJmGoph3hk4D1Dw3/GLy8iBUw89Ws3LFYy3ebw2f8w2mEEuhX/g/Svd4eTxml+B/w/BwZ4XwUwesEg9uIYM
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2026 09:42:46.1937
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 62894007-b37f-4a81-3188-08df22c502e5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00029929.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9450

- Use pointers directly instead of comparing them against NULL.
- Use logical negation instead of comparing bit masks against zero.
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
 drivers/iio/adc/xilinx-xadc-core.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/adc/xilinx-xadc-core.c b/drivers/iio/adc/xilinx-xadc-core.c
index 0234c8301c2e..43d3fc46c05f 100644
--- a/drivers/iio/adc/xilinx-xadc-core.c
+++ b/drivers/iio/adc/xilinx-xadc-core.c
@@ -124,9 +124,7 @@ static void xadc_read_reg(struct xadc *xadc, unsigned int reg, u32 *val)
  */
 static void xadc_zynq_write_fifo(struct xadc *xadc, u32 *cmd, unsigned int n)
 {
-	unsigned int i;
-
-	for (i = 0; i < n; i++)
+	for (unsigned int i = 0; i < n; i++)
 		xadc_write_reg(xadc, XADC_ZYNQ_REG_CFIFO, cmd[i]);
 }
 
@@ -144,8 +142,7 @@ static void xadc_zynq_drain_fifo(struct xadc *xadc)
 
 static void xadc_zynq_update_intmsk(struct xadc *xadc, unsigned int mask, unsigned int val)
 {
-	xadc->zynq_intmask &= ~mask;
-	xadc->zynq_intmask |= val;
+	xadc->zynq_intmask = (xadc->zynq_intmask & ~mask) | (val & mask);
 
 	xadc_write_reg(xadc, XADC_ZYNQ_REG_INTMSK, xadc->zynq_intmask | xadc->zynq_masked_alarm);
 }
@@ -653,7 +650,7 @@ static int xadc_trigger_set_state(struct iio_trigger *trigger, bool state)
 
 	if (state) {
 		/* Only one of the two triggers can be active at a time. */
-		if (xadc->trigger != NULL) {
+		if (xadc->trigger) {
 			ret = -EBUSY;
 			goto err_out;
 		} else {
@@ -698,7 +695,7 @@ static struct iio_trigger *xadc_alloc_trigger(struct iio_dev *indio_dev, const c
 
 	trig = devm_iio_trigger_alloc(dev, "%s%d-%s", indio_dev->name,
 				      iio_device_id(indio_dev), name);
-	if (trig == NULL)
+	if (!trig)
 		return ERR_PTR(-ENOMEM);
 
 	trig->ops = &xadc_trigger_ops;
@@ -749,7 +746,7 @@ static int xadc_get_seq_mode(struct xadc *xadc, unsigned long scan_mode)
 	if (xadc->external_mux_mode == XADC_EXTERNAL_MUX_DUAL)
 		return XADC_CONF1_SEQ_SIMULTANEOUS;
 
-	if ((aux_scan_mode & 0xff00) == 0 || (aux_scan_mode & 0x00ff) == 0)
+	if (!(aux_scan_mode & 0xff00) || !(aux_scan_mode & 0x00ff))
 		return XADC_CONF1_SEQ_CONTINUOUS;
 
 	return XADC_CONF1_SEQ_SIMULTANEOUS;
-- 
2.34.1

