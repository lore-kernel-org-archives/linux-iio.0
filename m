Return-Path: <SRS0=TPgR=R5=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04AB0C43381
	for <linux-iio@archiver.kernel.org>; Tue, 26 Mar 2019 13:40:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C04BB2075C
	for <linux-iio@archiver.kernel.org>; Tue, 26 Mar 2019 13:40:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="nzi8Uuq7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731643AbfCZNkK (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Tue, 26 Mar 2019 09:40:10 -0400
Received: from mail-eopbgr690078.outbound.protection.outlook.com ([40.107.69.78]:17630
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726241AbfCZNkJ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 26 Mar 2019 09:40:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M+Rm8OHG3XmTy4WrrggSiDufkpLGK2TtgUpwvp4rMPA=;
 b=nzi8Uuq7FIKSzjHJCtNsvYhTExSITfwqqSI0fRyzG7hkTzFiA16fyjZayzCGPcFmusRmmS+/k05ojQs5kzEQw7YXbKnx5LyvAjqLunpZKf4SDXVOddYJg/Y9kH3oRc7EaveesktO1gDzqh9HyZSV4/8jDtKbIZ005vzKkK7EIh4=
Received: from DM6PR03CA0024.namprd03.prod.outlook.com (2603:10b6:5:40::37) by
 CO2PR03MB2262.namprd03.prod.outlook.com (2603:10b6:102:a::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.14; Tue, 26 Mar 2019 13:40:07 +0000
Received: from BL2NAM02FT049.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::207) by DM6PR03CA0024.outlook.office365.com
 (2603:10b6:5:40::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1730.16 via Frontend
 Transport; Tue, 26 Mar 2019 13:40:06 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.55)
 smtp.mailfrom=analog.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 BL2NAM02FT049.mail.protection.outlook.com (10.152.77.118) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1730.9
 via Frontend Transport; Tue, 26 Mar 2019 13:40:06 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id x2QDe60J017969
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Tue, 26 Mar 2019 06:40:06 -0700
Received: from saturn.analog.com (10.50.1.244) by NWD2HUBCAS7.ad.analog.com
 (10.64.69.107) with Microsoft SMTP Server id 14.3.408.0; Tue, 26 Mar 2019
 09:40:05 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>
CC:     Lars-Peter Clausen <lars@metafoo.de>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH V2] iio: frequency: ad9523: Fix typo in ad9523_platform_data
Date:   Tue, 26 Mar 2019 15:40:03 +0200
Message-ID: <20190326134003.18371-1-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(346002)(376002)(39860400002)(396003)(2980300002)(54534003)(199004)(189003)(48376002)(6916009)(305945005)(7636002)(8936002)(50226002)(44832011)(2351001)(8676002)(246002)(50466002)(53416004)(106466001)(107886003)(36756003)(51416003)(356004)(4326008)(7696005)(77096007)(426003)(47776003)(476003)(2906002)(26005)(1076003)(186003)(316002)(16586007)(106002)(478600001)(54906003)(336012)(86362001)(5660300002)(486006)(2616005)(126002);DIR:OUT;SFP:1101;SCL:1;SRVR:CO2PR03MB2262;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8266988c-151f-4052-b0e0-08d6b1f08edc
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600127)(711020)(4605104)(4709054)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060);SRVR:CO2PR03MB2262;
X-MS-TrafficTypeDiagnostic: CO2PR03MB2262:
X-Microsoft-Antispam-PRVS: <CO2PR03MB2262B89865CED0269341412DF95F0@CO2PR03MB2262.namprd03.prod.outlook.com>
X-Forefront-PRVS: 09888BC01D
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: KfcQ7ZjHQwanLQU8XFWPBWD/i1DuBV/NpSHKhVmkCW4obLP1AuaK7/mvWmk8UvA9PZaobqGQopq3+xQihBVgHSyIoyskRuvE1vesIvoLDesvfbIazqjlb9qmmk2h4sBxSrVao1fSkJe/k4KzZrEFcqOT/SZ0SgOR6iphmBlMnvBfkCbeLwNID1eDuJ+EX877uQhh5RsUzHPnUvJdM/QHzi4HuTgzsDTsSa5Ql8tvWhdp1lDrj6hHq9FfkoPt9pSFpCg9u9VzOQItFj8cMnBtOf1w0Ug76sQWNKBmXkBgDuwzT2UMPzhzzEJzJhkRFDg8EHKG2OH6XyU8qkwrluo+1phZmCPAnqxWV/rta9+MzCVEBrZi83u6zri0PiMPAZ7fsq/CGV0nmt0MD2rlBRqp3rBxVn8IW4UJaInpR6EKxjA=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2019 13:40:06.5558
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8266988c-151f-4052-b0e0-08d6b1f08edc
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO2PR03MB2262
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

Changelog v1->v2:
* added `frequency:` to prefix for consistency

 drivers/iio/frequency/ad9523.c       | 16 ++++++++--------
 include/linux/iio/frequency/ad9523.h |  8 ++++----
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/iio/frequency/ad9523.c b/drivers/iio/frequency/ad9523.c
index 3f9be69499ec..9b9eee27176c 100644
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

