Return-Path: <SRS0=DYZA=SL=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ED8AC282DA
	for <linux-iio@archiver.kernel.org>; Tue,  9 Apr 2019 07:59:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16C4C20663
	for <linux-iio@archiver.kernel.org>; Tue,  9 Apr 2019 07:59:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="ISqDx2Ez"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726396AbfDIH7H (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Tue, 9 Apr 2019 03:59:07 -0400
Received: from mail-eopbgr780051.outbound.protection.outlook.com ([40.107.78.51]:53682
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726461AbfDIH7H (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 9 Apr 2019 03:59:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hr50iTtcxCeD1YdkzubNF6EDU4r/O/Pt959+5Ai0Khk=;
 b=ISqDx2Ez7urTI1d/6TBeQJWDvPS2LrNbTEiu8Hh22zIz5K97xVF5Oj/g4c83j/7jh1T0eHJdYSZz3UI3JOvFG7Z65spgVoIjpQUIWBkAesSDohuBd4mpRa28BnSASJFeJH83jxzOMrQArgOW8R8tZnaA/oOviVZVB1icFmFVRyo=
Received: from BN6PR03CA0063.namprd03.prod.outlook.com (2603:10b6:404:4c::25)
 by BY2PR03MB556.namprd03.prod.outlook.com (2a01:111:e400:2c3a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1771.21; Tue, 9 Apr
 2019 07:58:25 +0000
Received: from BL2NAM02FT053.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::200) by BN6PR03CA0063.outlook.office365.com
 (2603:10b6:404:4c::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1771.16 via Frontend
 Transport; Tue, 9 Apr 2019 07:58:24 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.55)
 smtp.mailfrom=analog.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 BL2NAM02FT053.mail.protection.outlook.com (10.152.76.225) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1771.16
 via Frontend Transport; Tue, 9 Apr 2019 07:58:24 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id x397wOQV012755
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Tue, 9 Apr 2019 00:58:24 -0700
Received: from saturn.analog.com (10.50.1.244) by NWD2HUBCAS7.ad.analog.com
 (10.64.69.107) with Microsoft SMTP Server id 14.3.408.0; Tue, 9 Apr 2019
 03:58:24 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>
CC:     Lars-Peter Clausen <lars@metafoo.de>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH] iio: ad_sigma_delta: Don't put SPI transfer buffer on the stack
Date:   Tue, 9 Apr 2019 10:58:21 +0300
Message-ID: <20190409075821.26104-1-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(376002)(396003)(346002)(136003)(2980300002)(199004)(189003)(1076003)(50226002)(7636002)(54906003)(16586007)(6916009)(316002)(2351001)(77096007)(426003)(53416004)(7696005)(106466001)(26005)(36756003)(305945005)(8676002)(336012)(106002)(8936002)(356004)(6666004)(51416003)(478600001)(246002)(50466002)(2616005)(2906002)(86362001)(126002)(14444005)(107886003)(5660300002)(47776003)(4326008)(476003)(44832011)(48376002)(186003)(486006);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR03MB556;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 88777307-cfe9-4aa8-b3f5-08d6bcc124a2
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(4709054)(2017052603328);SRVR:BY2PR03MB556;
X-MS-TrafficTypeDiagnostic: BY2PR03MB556:
X-Microsoft-Antispam-PRVS: <BY2PR03MB5568C6B7F3161D1F841551DF92D0@BY2PR03MB556.namprd03.prod.outlook.com>
X-Forefront-PRVS: 000227DA0C
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: 0IJxmlCMFQsvda5upOfKQl+/LhXMTv5wC0r5ikax3TOM2/HS5l/Of2f//MLNiBYhrdwe/7psSh2ecscTMrU6OApuBLglzQfepefgYxrBjY/7djGdHop4FF4NtSZmlxSJXCVzmLPVFhiAGxzW8DwI8GrS5R3aj+2U54RDmdgvXU/O8j8HxranniMS0a2rci6m2NuqqiaSyquP1bcpHpByd2duAuz8ogbvVFJ9VJQSBbNHb833agprs7FaBFpzxlXHcT2VM8bVbU8QWM/3jfGjwgyMwnT97nUJ4gL+PEuqjDz0DbaFcCLIGvi62B+Qd91XLPCz+rBqz10XUeuA0PuyZE0uccesc1FmAQtSgTwqCMoXlhmh0084mfmPwzjXwaK0IMld55rurvpOokWyfLraRpD4RwsixGY8QGEXvXwA7ZI=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2019 07:58:24.7915
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 88777307-cfe9-4aa8-b3f5-08d6bcc124a2
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR03MB556
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Lars-Peter Clausen <lars@metafoo.de>

Use a heap allocated memory for the SPI transfer buffer. Using stack memory
will not work on some architectures when using DMA.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---

Note: this doesn't need a stable/fixes tag. It's more of an enhancement.

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
index 6e9fb1932dde..fb77b2ebe498 100644
--- a/include/linux/iio/adc/ad_sigma_delta.h
+++ b/include/linux/iio/adc/ad_sigma_delta.h
@@ -79,7 +79,8 @@ struct ad_sigma_delta {
 	 * DMA (thus cache coherency maintenance) requires the
 	 * transfer buffers to live in their own cache lines.
 	 */
-	uint8_t				data[4] ____cacheline_aligned;
+	uint8_t				reg_data[4] ____cacheline_aligned;
+	uint8_t				buf_data[16];
 };
 
 static inline int ad_sigma_delta_set_channel(struct ad_sigma_delta *sd,
-- 
2.17.1

