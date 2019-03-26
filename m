Return-Path: <SRS0=TPgR=R5=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 197BDC43381
	for <linux-iio@archiver.kernel.org>; Tue, 26 Mar 2019 13:24:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C986E2070D
	for <linux-iio@archiver.kernel.org>; Tue, 26 Mar 2019 13:24:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="tI7LYJhi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726140AbfCZNYR (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Tue, 26 Mar 2019 09:24:17 -0400
Received: from mail-eopbgr700041.outbound.protection.outlook.com ([40.107.70.41]:39712
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726111AbfCZNYQ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 26 Mar 2019 09:24:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n+3D0rcEvq/5VQDuVp1kEI6PyS/23FuBGF4ee3as1OE=;
 b=tI7LYJhiHVMg62WyKWTEF26wnxnNINBKxiaaL5PjMdTdt3fSJD4bYk0YXyJelxypzLj/e3ZWmFom7IubR9F740tLMEhvE48D+x+WwpFl/UYLBhuOHdq1SBh5456lZdzXzfh/MNLN0KX8aF8pFCG9oEMLtBITmcaZhcvW/68sdME=
Received: from BYAPR03CA0009.namprd03.prod.outlook.com (2603:10b6:a02:a8::22)
 by BY2PR03MB553.namprd03.prod.outlook.com (2a01:111:e400:2c38::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1730.16; Tue, 26 Mar
 2019 13:24:13 +0000
Received: from BL2NAM02FT064.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::206) by BYAPR03CA0009.outlook.office365.com
 (2603:10b6:a02:a8::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1730.16 via Frontend
 Transport; Tue, 26 Mar 2019 13:24:13 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.55)
 smtp.mailfrom=analog.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 BL2NAM02FT064.mail.protection.outlook.com (10.152.77.119) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1730.9
 via Frontend Transport; Tue, 26 Mar 2019 13:24:13 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id x2QDOCss011541
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Tue, 26 Mar 2019 06:24:12 -0700
Received: from saturn.analog.com (10.50.1.244) by NWD2HUBCAS7.ad.analog.com
 (10.64.69.107) with Microsoft SMTP Server id 14.3.408.0; Tue, 26 Mar 2019
 09:24:12 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>
CC:     Lars-Peter Clausen <lars@metafoo.de>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH] iio: ad9523: Fix typo in struct ad9523_platform_data
Date:   Tue, 26 Mar 2019 15:24:08 +0200
Message-ID: <20190326132408.13463-1-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(376002)(346002)(39860400002)(136003)(2980300002)(189003)(199004)(6916009)(305945005)(7636002)(51416003)(7696005)(36756003)(47776003)(6666004)(356004)(5660300002)(107886003)(478600001)(1076003)(8676002)(246002)(4326008)(2906002)(106002)(53416004)(50466002)(48376002)(316002)(16586007)(2351001)(8936002)(54906003)(86362001)(106466001)(2616005)(126002)(476003)(426003)(486006)(44832011)(186003)(26005)(77096007)(336012)(50226002);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR03MB553;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3a28e0fa-8955-4bbf-5828-08d6b1ee5686
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4709054)(2017052603328)(7153060);SRVR:BY2PR03MB553;
X-MS-TrafficTypeDiagnostic: BY2PR03MB553:
X-Microsoft-Antispam-PRVS: <BY2PR03MB55340EAA97FECE5685B65EFF95F0@BY2PR03MB553.namprd03.prod.outlook.com>
X-Forefront-PRVS: 09888BC01D
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: cvjefVnASS8max/YRmg6BUcdZwr+I51OXA3U1yxAp/ysXQmeveO3ESyEXVADWmnyniSTs3fz+BkzUnS0za784iqu6B1xy8WDJ3ZGG621Z6aegtv17W1nNcXyRtOmS6giUi7uRer5rNSuECYb/pGBYN/CZ7c1pfDw/DAteeFvpMNj1zxujnTEthBg6LhZG41UEambOTvD5GIexPJz3kXc6YtM/bBFmBoD3dmY++G6XF+nvO1GIrVua23p8PogjJ4L/KZpuPn0iFpNbbqwQK9fi7Jx2d9Ce6UrVy1U2YvlMHGvpdBIFIeDBIxUTxSU9UyT4u7CCoDVUMyQwLyPSRaXcrBEvBQW9H9G/dgxctdg20YOU/RkuZtokiP40EXeaMUuZ2dd6iVp/SnHZR4YvgGr6HGDv2UA9RBIaz16K51ULY4=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2019 13:24:13.0410
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a28e0fa-8955-4bbf-5828-08d6b1ee5686
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR03MB553
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Lars-Peter Clausen <lars@metafoo.de>

Replace diff_{m1,m2} with div_{m1,m2} since they are dividers and not a
differential settings.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/iio/frequency/ad9523.c       | 16 ++++++++--------
 include/linux/iio/frequency/ad9523.h |  8 ++++----
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/iio/frequency/ad9523.c b/drivers/iio/frequency/ad9523.c
index f4a508107f0d..1d132f1715ae 100644
--- a/drivers/iio/frequency/ad9523.c
+++ b/drivers/iio/frequency/ad9523.c
@@ -872,22 +872,22 @@ static int ad9523_setup(struct iio_dev *indio_dev)
 		return ret;
 
 	ret = ad9523_write(indio_dev, AD9523_PLL2_VCO_DIVIDER,
-		AD9523_PLL2_VCO_DIV_M1(pdata->pll2_vco_diff_m1) |
-		AD9523_PLL2_VCO_DIV_M2(pdata->pll2_vco_diff_m2) |
-		AD_IFE(pll2_vco_diff_m1, 0,
+		AD9523_PLL2_VCO_DIV_M1(pdata->pll2_vco_div_m1) |
+		AD9523_PLL2_VCO_DIV_M2(pdata->pll2_vco_div_m2) |
+		AD_IFE(pll2_vco_div_m1, 0,
 		       AD9523_PLL2_VCO_DIV_M1_PWR_DOWN_EN) |
-		AD_IFE(pll2_vco_diff_m2, 0,
+		AD_IFE(pll2_vco_div_m2, 0,
 		       AD9523_PLL2_VCO_DIV_M2_PWR_DOWN_EN));
 	if (ret < 0)
 		return ret;
 
-	if (pdata->pll2_vco_diff_m1)
+	if (pdata->pll2_vco_div_m1)
 		st->vco_out_freq[AD9523_VCO1] =
-			st->vco_freq / pdata->pll2_vco_diff_m1;
+			st->vco_freq / pdata->pll2_vco_div_m1;
 
-	if (pdata->pll2_vco_diff_m2)
+	if (pdata->pll2_vco_div_m2)
 		st->vco_out_freq[AD9523_VCO2] =
-			st->vco_freq / pdata->pll2_vco_diff_m2;
+			st->vco_freq / pdata->pll2_vco_div_m2;
 
 	st->vco_out_freq[AD9523_VCXO] = pdata->vcxo_freq;
 
diff --git a/include/linux/iio/frequency/ad9523.h b/include/linux/iio/frequency/ad9523.h
index 12ce3ee427fd..621b93c0bcf9 100644
--- a/include/linux/iio/frequency/ad9523.h
+++ b/include/linux/iio/frequency/ad9523.h
@@ -129,8 +129,8 @@ enum cpole1_capacitor {
  * @pll2_ndiv_b_cnt: PLL2 Feedback N-divider, B Counter, range 0..63.
  * @pll2_freq_doubler_en: PLL2 frequency doubler enable.
  * @pll2_r2_div: PLL2 R2 divider, range 0..31.
- * @pll2_vco_diff_m1: VCO1 divider, range 3..5.
- * @pll2_vco_diff_m2: VCO2 divider, range 3..5.
+ * @pll2_vco_div_m1: VCO1 divider, range 3..5.
+ * @pll2_vco_div_m2: VCO2 divider, range 3..5.
  * @rpole2: PLL2 loop filter Rpole resistor value.
  * @rzero: PLL2 loop filter Rzero resistor value.
  * @cpole1: PLL2 loop filter Cpole capacitor value.
@@ -176,8 +176,8 @@ struct ad9523_platform_data {
 	unsigned char			pll2_ndiv_b_cnt;
 	bool				pll2_freq_doubler_en;
 	unsigned char			pll2_r2_div;
-	unsigned char			pll2_vco_diff_m1; /* 3..5 */
-	unsigned char			pll2_vco_diff_m2; /* 3..5 */
+	unsigned char			pll2_vco_div_m1; /* 3..5 */
+	unsigned char			pll2_vco_div_m2; /* 3..5 */
 
 	/* Loop Filter PLL2 */
 	enum rpole2_resistor		rpole2;
-- 
2.17.1

