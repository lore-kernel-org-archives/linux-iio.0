Return-Path: <SRS0=6njX=RW=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74962C43381
	for <linux-iio@archiver.kernel.org>; Tue, 19 Mar 2019 09:53:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27AA220828
	for <linux-iio@archiver.kernel.org>; Tue, 19 Mar 2019 09:53:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="qGmAnUf1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725906AbfCSJx2 (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Tue, 19 Mar 2019 05:53:28 -0400
Received: from mail-eopbgr700079.outbound.protection.outlook.com ([40.107.70.79]:19681
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725905AbfCSJx2 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 19 Mar 2019 05:53:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xaN5LvVwEUtOGs+6HDdZQud7Kn6c+Ri+tNWXi/PB8lc=;
 b=qGmAnUf1ZbqrHY2W0VeodBT1IoDPJDjMYXNFVz+9oL4F+rnnq3T2b4vviKGFpXB+zyDDM7tL7tJc0otpTEFJHYoTlMwan3e9WXix7KonPYt17TbKGa+7zkLZe4Oo2G0CTuDJQSf2XRHi6VD816Nzd+ry+It70m9zw+2vqHj4Gt4=
Received: from BN3PR03CA0069.namprd03.prod.outlook.com
 (2a01:111:e400:7a4d::29) by CO2PR03MB2264.namprd03.prod.outlook.com
 (2603:10b6:102:a::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1709.14; Tue, 19 Mar
 2019 09:53:25 +0000
Received: from SN1NAM02FT011.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::205) by BN3PR03CA0069.outlook.office365.com
 (2a01:111:e400:7a4d::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1709.13 via Frontend
 Transport; Tue, 19 Mar 2019 09:53:24 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.55)
 smtp.mailfrom=analog.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 SN1NAM02FT011.mail.protection.outlook.com (10.152.72.82) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1730.9
 via Frontend Transport; Tue, 19 Mar 2019 09:53:24 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id x2J9rNcf021068
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Tue, 19 Mar 2019 02:53:23 -0700
Received: from saturn.analog.com (10.50.1.244) by NWD2HUBCAS7.ad.analog.com
 (10.64.69.107) with Microsoft SMTP Server id 14.3.408.0; Tue, 19 Mar 2019
 05:53:23 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>
CC:     Lars-Peter Clausen <lars@metafoo.de>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH] iio: ad_sigma_delta: Introduce prepare_channel callback
Date:   Tue, 19 Mar 2019 11:53:06 +0200
Message-ID: <20190319095306.16010-1-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(376002)(136003)(396003)(346002)(2980300002)(189003)(199004)(476003)(54906003)(2351001)(47776003)(246002)(106466001)(7636002)(53416004)(6916009)(305945005)(8676002)(2906002)(316002)(16586007)(4326008)(106002)(50226002)(478600001)(50466002)(36756003)(1076003)(48376002)(86362001)(51416003)(107886003)(356004)(6666004)(14444005)(2616005)(486006)(77096007)(26005)(44832011)(426003)(8936002)(186003)(7696005)(126002)(5660300002)(336012);DIR:OUT;SFP:1101;SCL:1;SRVR:CO2PR03MB2264;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 090a837d-6b77-40a4-8b21-08d6ac50ba58
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600127)(711020)(4605104)(4608103)(4709054)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060);SRVR:CO2PR03MB2264;
X-MS-TrafficTypeDiagnostic: CO2PR03MB2264:
X-Microsoft-Antispam-PRVS: <CO2PR03MB226421B37C1CE75304D3F4A4F9400@CO2PR03MB2264.namprd03.prod.outlook.com>
X-Forefront-PRVS: 0981815F2F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: nMIPaHcrUMmHOruJNnJicRASAKyPYXdva4CFgEQYCjzU31q9ggaRHKl7mJl4BvYZzChq3TdhC5MuZjV3R0yEPVu4gwrjgsRTiLX584hPqxwMdtBNx/NO+d83ZNHaRwyDQM67xcjzLJQUDg4lxfpwIA25yoLBGzYB29tygM32cDOsUarRZyh+65verDOT2dK/njIkQ8fnu4IOGqnkZri914eertLSlw0rkKgdqatZk4TeRwZ1G+g7GsGPGlDG5vhhDu+oraxzqEPbyRJvwVxZjD481Wiiq+8o3IdE3yvYSTjdCHQ3URnuoRAXKWkljoYIUlDSK6HTNv9oaQfY/A47nQF8YHO7CFdlweIIgtruvsU8mSSg/YqqyIT8fhDpVZC1zYxXtpG10GhChNgrHPQ52zihwfefCaTqNp7/v8swKWs=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2019 09:53:24.0878
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 090a837d-6b77-40a4-8b21-08d6ac50ba58
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO2PR03MB2264
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Lars-Peter Clausen <lars@metafoo.de>

The prepare channel callback will be called before starting a conversion and
can be used by the driver to configure the chip according to the selected
channel.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/iio/adc/ad_sigma_delta.c       |  5 +++++
 include/linux/iio/adc/ad_sigma_delta.h | 13 +++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/drivers/iio/adc/ad_sigma_delta.c b/drivers/iio/adc/ad_sigma_delta.c
index ff5f2da2e1b1..00808838edd8 100644
--- a/drivers/iio/adc/ad_sigma_delta.c
+++ b/drivers/iio/adc/ad_sigma_delta.c
@@ -285,6 +285,7 @@ int ad_sigma_delta_single_conversion(struct iio_dev *indio_dev,
 		return -EBUSY;
 
 	mutex_lock(&indio_dev->mlock);
+	ad_sigma_delta_prepare_channel(sigma_delta, chan);
 	ad_sigma_delta_set_channel(sigma_delta, chan->address);
 
 	spi_bus_lock(sigma_delta->spi->master);
@@ -351,6 +352,10 @@ static int ad_sd_buffer_postenable(struct iio_dev *indio_dev)
 
 	channel = find_first_bit(indio_dev->active_scan_mask,
 				 indio_dev->masklength);
+	ret = ad_sigma_delta_prepare_channel(sigma_delta,
+		&indio_dev->channels[channel]);
+	if (ret)
+		goto err_predisable;
 	ret = ad_sigma_delta_set_channel(sigma_delta,
 		indio_dev->channels[channel].address);
 	if (ret)
diff --git a/include/linux/iio/adc/ad_sigma_delta.h b/include/linux/iio/adc/ad_sigma_delta.h
index 7e84351fa2c0..21ee12543bdd 100644
--- a/include/linux/iio/adc/ad_sigma_delta.h
+++ b/include/linux/iio/adc/ad_sigma_delta.h
@@ -31,6 +31,8 @@ struct iio_dev;
 
 /**
  * struct ad_sigma_delta_info - Sigma Delta driver specific callbacks and options
+ * @prepare_channel: Will be called to prepare and configure a channel, may be
+ *                   NULL.
  * @set_channel: Will be called to select the current channel, may be NULL.
  * @set_mode: Will be called to select the current mode, may be NULL.
  * @postprocess_sample: Is called for each sampled data word, can be used to
@@ -43,6 +45,8 @@ struct iio_dev;
  *   be used.
  */
 struct ad_sigma_delta_info {
+	int (*prepare_channel)(struct ad_sigma_delta *,
+		const struct iio_chan_spec *);
 	int (*set_channel)(struct ad_sigma_delta *, unsigned int channel);
 	int (*set_mode)(struct ad_sigma_delta *, enum ad_sigma_delta_mode mode);
 	int (*postprocess_sample)(struct ad_sigma_delta *, unsigned int raw_sample);
@@ -81,6 +85,15 @@ struct ad_sigma_delta {
 	uint8_t				data[4] ____cacheline_aligned;
 };
 
+static inline int ad_sigma_delta_prepare_channel(struct ad_sigma_delta *sd,
+	const struct iio_chan_spec *chan)
+{
+	if (sd->info->prepare_channel)
+		return sd->info->prepare_channel(sd, chan);
+
+	return 0;
+}
+
 static inline int ad_sigma_delta_set_channel(struct ad_sigma_delta *sd,
 	unsigned int channel)
 {
-- 
2.17.1

