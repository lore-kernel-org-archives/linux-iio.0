Return-Path: <SRS0=TPgR=R5=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C08ACC43381
	for <linux-iio@archiver.kernel.org>; Tue, 26 Mar 2019 13:27:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F6052075D
	for <linux-iio@archiver.kernel.org>; Tue, 26 Mar 2019 13:27:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="PeoaLSSZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726278AbfCZN1F (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Tue, 26 Mar 2019 09:27:05 -0400
Received: from mail-eopbgr750072.outbound.protection.outlook.com ([40.107.75.72]:50061
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726111AbfCZN1F (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 26 Mar 2019 09:27:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/h5CjAkSrvZsatMP4LLtaFxRNXMmP9OhhXSxz78wlXE=;
 b=PeoaLSSZxHZ7RyqcWCbqMPfpcCxwJZlcy/R/yj7Jlj3xHj+kMMff3GPyfH8atqjo7hKIv6tbmx58Y0LZWYsxKCc5nYaD+RXBSbmlPMKi2e7n/I+SAwfkGynzMEkU5re0pAIhzU97Mxth7Yus/XPKIOFExwaJOsPZDTvHlAP+z2U=
Received: from CY1PR03CA0035.namprd03.prod.outlook.com (10.174.128.45) by
 DM2PR03MB557.namprd03.prod.outlook.com (10.141.82.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1730.18; Tue, 26 Mar 2019 13:27:03 +0000
Received: from CY1NAM02FT056.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::208) by CY1PR03CA0035.outlook.office365.com
 (2603:10b6:600::45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1750.15 via Frontend
 Transport; Tue, 26 Mar 2019 13:27:02 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.55)
 smtp.mailfrom=analog.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 CY1NAM02FT056.mail.protection.outlook.com (10.152.74.160) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1750.11
 via Frontend Transport; Tue, 26 Mar 2019 13:27:02 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id x2QDR1Cj013012
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Tue, 26 Mar 2019 06:27:01 -0700
Received: from saturn.analog.com (10.50.1.244) by NWD2HUBCAS7.ad.analog.com
 (10.64.69.107) with Microsoft SMTP Server id 14.3.408.0; Tue, 26 Mar 2019
 09:27:01 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>
CC:     Lars-Peter Clausen <lars@metafoo.de>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH] iio: frequency: ad9523: Improve reported VCO frequency accuracy
Date:   Tue, 26 Mar 2019 15:26:58 +0200
Message-ID: <20190326132658.16724-1-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(39860400002)(376002)(136003)(396003)(2980300002)(189003)(199004)(106002)(2351001)(6916009)(2906002)(356004)(36756003)(486006)(6666004)(476003)(7636002)(126002)(426003)(2616005)(305945005)(44832011)(86362001)(53416004)(47776003)(478600001)(106466001)(4326008)(1076003)(5660300002)(77096007)(50226002)(8936002)(16586007)(336012)(26005)(186003)(8676002)(51416003)(54906003)(316002)(246002)(107886003)(7696005)(50466002)(48376002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM2PR03MB557;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cd67cd21-c834-4077-ea99-08d6b1eebb95
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4709054)(2017052603328)(7153060);SRVR:DM2PR03MB557;
X-MS-TrafficTypeDiagnostic: DM2PR03MB557:
X-Microsoft-Antispam-PRVS: <DM2PR03MB557A67A3DF9C71B3BF345C6F95F0@DM2PR03MB557.namprd03.prod.outlook.com>
X-Forefront-PRVS: 09888BC01D
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: 3qXByU4UiU1XzSPytoXt+gOQQqHtJ64txRGl6ebjTT28c7uHCeQp+hWgFJ/0/cRdYbgsi5uHrdGRO2yQ1jX+JVi7PS36Jrf4mJPZF9I3lkiVql+suuDOfD3JYltwG9gk7puj6wrFQm7eNxfijPGvO6TiOwPqR7gFAiDEPXQ+KsTgmvW2LF8LF8C11VGIQPuZ9eEZdG+4n/fIso9/Tl7Ts0Xc25uyR9n4PIu1eBHK9wgiB+gaejFmUsjf/OPuIvOsqFgnniQVk4/D59QaESzxyeJcFBByOl2PJXlJ7NypfsiCFqk0OMLgmAinlYEffKHEcIj8Fijbqj7lerTCPF0/k1Su/oTChIhJgREgqwFtMGizSDqYBgYP5XRWwLsFnlSb4ce3ofhJmkoveVWOighT+U/C9ggQeBRsZypBt8AiWdw=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2019 13:27:02.3978
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cd67cd21-c834-4077-ea99-08d6b1eebb95
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM2PR03MB557
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Lars-Peter Clausen <lars@metafoo.de>

To improve the accuracy of the reported VCO frequency perform all
multiplications before divisions. This reduces rounding errors and makes
sure the reported rates are accurate down to the last digit.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/iio/frequency/ad9523.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/frequency/ad9523.c b/drivers/iio/frequency/ad9523.c
index 3f9be69499ec..d2aef511189a 100644
--- a/drivers/iio/frequency/ad9523.c
+++ b/drivers/iio/frequency/ad9523.c
@@ -862,9 +862,11 @@ static int ad9523_setup(struct iio_dev *indio_dev)
 	if (ret < 0)
 		return ret;
 
-	st->vco_freq = (pdata->vcxo_freq * (pdata->pll2_freq_doubler_en ? 2 : 1)
-			/ pdata->pll2_r2_div) * AD9523_PLL2_FB_NDIV(pdata->
-			pll2_ndiv_a_cnt, pdata->pll2_ndiv_b_cnt);
+	st->vco_freq = div_u64((unsigned long long)pdata->vcxo_freq *
+			       (pdata->pll2_freq_doubler_en ? 2 : 1) *
+			       AD9523_PLL2_FB_NDIV(pdata->pll2_ndiv_a_cnt,
+						   pdata->pll2_ndiv_b_cnt),
+			       pdata->pll2_r2_div);
 
 	ret = ad9523_write(indio_dev, AD9523_PLL2_VCO_CTRL,
 		AD9523_PLL2_VCO_CALIBRATE);
-- 
2.17.1

