Return-Path: <SRS0=o58m=SS=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B863C10F13
	for <linux-iio@archiver.kernel.org>; Tue, 16 Apr 2019 08:20:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FF0120821
	for <linux-iio@archiver.kernel.org>; Tue, 16 Apr 2019 08:20:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="HpRjNcDi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbfDPIUQ (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Tue, 16 Apr 2019 04:20:16 -0400
Received: from mail-eopbgr680055.outbound.protection.outlook.com ([40.107.68.55]:65429
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726346AbfDPIUP (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 16 Apr 2019 04:20:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bBcmsWdYozlHNHAKG6RY+YfubBIiWB4oH73ZdMVsak4=;
 b=HpRjNcDidER/0IOAwmpmS56Q69zg6Ivxfmxh3WfdxXP9bc3Mdgkr1Hpl7KCG4yqsPf3W1LzqJhcd4Goo2AUOMna1r/b9yiuNkP2VJxXDh7YIcmKtIgdsBb50bRcn014jhnffC5MkgiH0KiAKVhB4BnryNeXfvXIQqkEkq1RyaDc=
Received: from CY4PR03CA0017.namprd03.prod.outlook.com (2603:10b6:903:33::27)
 by BL2PR03MB548.namprd03.prod.outlook.com (2a01:111:e400:c26::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1792.19; Tue, 16 Apr
 2019 08:19:33 +0000
Received: from CY1NAM02FT005.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::203) by CY4PR03CA0017.outlook.office365.com
 (2603:10b6:903:33::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1792.15 via Frontend
 Transport; Tue, 16 Apr 2019 08:19:32 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.57)
 smtp.mailfrom=analog.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 CY1NAM02FT005.mail.protection.outlook.com (10.152.74.117) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1771.16
 via Frontend Transport; Tue, 16 Apr 2019 08:19:32 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id x3G8JVJo000998
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Tue, 16 Apr 2019 01:19:31 -0700
Received: from saturn.analog.com (10.50.1.244) by NWD2HUBCAS7.ad.analog.com
 (10.64.69.107) with Microsoft SMTP Server id 14.3.408.0; Tue, 16 Apr 2019
 04:19:30 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>
CC:     Lars-Peter Clausen <lars@metafoo.de>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH V2] iio: ad_sigma_delta: Don't put SPI transfer buffer on the stack
Date:   Tue, 16 Apr 2019 11:19:16 +0300
Message-ID: <20190416081916.26287-1-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190409075821.26104-1-alexandru.ardelean@analog.com>
References: <20190409075821.26104-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(376002)(346002)(396003)(136003)(2980300002)(189003)(199004)(54534003)(2906002)(54906003)(7696005)(478600001)(47776003)(50226002)(8936002)(50466002)(6666004)(8676002)(48376002)(106002)(14444005)(16586007)(336012)(53416004)(51416003)(356004)(246002)(7636002)(305945005)(86362001)(107886003)(44832011)(486006)(316002)(2616005)(11346002)(186003)(126002)(106466001)(2351001)(26005)(76176011)(426003)(1076003)(5660300002)(6916009)(4326008)(446003)(77096007)(36756003)(476003);DIR:OUT;SFP:1101;SCL:1;SRVR:BL2PR03MB548;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5e5ff5cb-85a2-4852-002d-08d6c2444119
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600140)(711020)(4605104)(4709054)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328);SRVR:BL2PR03MB548;
X-MS-TrafficTypeDiagnostic: BL2PR03MB548:
X-Microsoft-Antispam-PRVS: <BL2PR03MB5480A8C220024707E20D7E1F9240@BL2PR03MB548.namprd03.prod.outlook.com>
X-Forefront-PRVS: 000947967F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: knsJRZoz50GaA8a2LmzZD8PwPGOIC0FF+wnGC2WZ3PBG3gEbzwtWKsDKZPMA0jr7H7QQwYk/aOQAjZp2pK/x2eqvw+VT/Jzey/l5rhGgjHdZ9yrlQOYRVSt/OiMQfpiBKMpHc+M8HYhFCQ7Cd8/ynlGbViSkPaa+660z/8vglT4LbMyqWYhoQsda40f2tKxZ7pPUqjUXcPXokcb/1vee0C51fIGr86FzlJw1v0fNLXHkLpI0it0DUI1Pnme3PcuwuQtRE6/MC9VWRc5sCu1I0JNQ2Q5/h3EiqRShwFWRPsOAzOKBDjoEUu0CmoO8jJ2hM6GFiwm7QSgZIuR8448MLRiakwpxeUUF9RWOhqmMAWkcXHl1gAl9sWg5dnMBvzqtyRB/eMVEtEA8WzRAJPc/+o4CCCrC4J0A97y/c97Y2uc=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2019 08:19:32.2383
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e5ff5cb-85a2-4852-002d-08d6c2444119
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL2PR03MB548
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Lars-Peter Clausen <lars@metafoo.de>

Use a heap allocated memory for the SPI transfer buffer. Using stack memory
will not work on some architectures when using DMA.

This also avoids potential stack corruption, as it makes sure that the
buffer is in it's own cacheline and (obviously) not on the stack.

Fixes: af3008485ea03 ("iio:adc: Add common code for ADI Sigma Delta devices")
Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
Changelog v1 -> v2:
* added ____cacheline_aligned to `buf_data`
* extended comment about cacheline
* added fixes tag

 drivers/iio/adc/ad_sigma_delta.c       | 22 +++++++++++-----------
 include/linux/iio/adc/ad_sigma_delta.h |  3 ++-
 2 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/drivers/iio/adc/ad_sigma_delta.c b/drivers/iio/adc/ad_sigma_delta.c
index af6cbc683214..02d9049b9218 100644
--- a/drivers/iio/adc/ad_sigma_delta.c
+++ b/drivers/iio/adc/ad_sigma_delta.c
@@ -58,7 +58,7 @@ EXPORT_SYMBOL_GPL(ad_sd_set_comm);
 int ad_sd_write_reg(struct ad_sigma_delta *sigma_delta, unsigned int reg,
 	unsigned int size, unsigned int val)
 {
-	uint8_t *data = sigma_delta->data;
+	uint8_t *data = sigma_delta->reg_data;
 	struct spi_transfer t = {
 		.tx_buf		= data,
 		.len		= size + 1,
@@ -102,7 +102,7 @@ EXPORT_SYMBOL_GPL(ad_sd_write_reg);
 static int ad_sd_read_reg_raw(struct ad_sigma_delta *sigma_delta,
 	unsigned int reg, unsigned int size, uint8_t *val)
 {
-	uint8_t *data = sigma_delta->data;
+	uint8_t *data = sigma_delta->reg_data;
 	int ret;
 	struct spi_transfer t[] = {
 		{
@@ -148,24 +148,24 @@ int ad_sd_read_reg(struct ad_sigma_delta *sigma_delta,
 {
 	int ret;
 
-	ret = ad_sd_read_reg_raw(sigma_delta, reg, size, sigma_delta->data);
+	ret = ad_sd_read_reg_raw(sigma_delta, reg, size, sigma_delta->reg_data);
 	if (ret < 0)
 		goto out;
 
 	switch (size) {
 	case 4:
-		*val = get_unaligned_be32(sigma_delta->data);
+		*val = get_unaligned_be32(sigma_delta->reg_data);
 		break;
 	case 3:
-		*val = (sigma_delta->data[0] << 16) |
-			(sigma_delta->data[1] << 8) |
-			sigma_delta->data[2];
+		*val = (sigma_delta->reg_data[0] << 16) |
+			(sigma_delta->reg_data[1] << 8) |
+			sigma_delta->reg_data[2];
 		break;
 	case 2:
-		*val = get_unaligned_be16(sigma_delta->data);
+		*val = get_unaligned_be16(sigma_delta->reg_data);
 		break;
 	case 1:
-		*val = sigma_delta->data[0];
+		*val = sigma_delta->reg_data[0];
 		break;
 	default:
 		ret = -EINVAL;
@@ -403,12 +403,12 @@ static irqreturn_t ad_sd_trigger_handler(int irq, void *p)
 	struct iio_poll_func *pf = p;
 	struct iio_dev *indio_dev = pf->indio_dev;
 	struct ad_sigma_delta *sigma_delta = iio_device_get_drvdata(indio_dev);
+	uint8_t *data = sigma_delta->buf_data;
 	unsigned int reg_size;
 	unsigned int data_reg;
-	uint8_t data[16];
 	int ret;
 
-	memset(data, 0x00, 16);
+	memset(sigma_delta->buf_data, 0x00, sizeof(sigma_delta->buf_data));
 
 	reg_size = indio_dev->channels[0].scan_type.realbits +
 			indio_dev->channels[0].scan_type.shift;
diff --git a/include/linux/iio/adc/ad_sigma_delta.h b/include/linux/iio/adc/ad_sigma_delta.h
index 6e9fb1932dde..d95216ce8a94 100644
--- a/include/linux/iio/adc/ad_sigma_delta.h
+++ b/include/linux/iio/adc/ad_sigma_delta.h
@@ -79,7 +79,8 @@ struct ad_sigma_delta {
 	 * DMA (thus cache coherency maintenance) requires the
 	 * transfer buffers to live in their own cache lines.
 	 */
-	uint8_t				data[4] ____cacheline_aligned;
+	uint8_t				reg_data[4] ____cacheline_aligned;
+	uint8_t				buf_data[16] ____cacheline_aligned;
 };
 
 static inline int ad_sigma_delta_set_channel(struct ad_sigma_delta *sd,
-- 
2.17.1

