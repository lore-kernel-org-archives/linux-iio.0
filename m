Return-Path: <SRS0=jBoM=QI=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE00FC282D8
	for <linux-iio@archiver.kernel.org>; Fri,  1 Feb 2019 09:36:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACAA42086C
	for <linux-iio@archiver.kernel.org>; Fri,  1 Feb 2019 09:36:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729208AbfBAJg4 (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Fri, 1 Feb 2019 04:36:56 -0500
Received: from mail-eopbgr680060.outbound.protection.outlook.com ([40.107.68.60]:51648
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727008AbfBAJg4 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 1 Feb 2019 04:36:56 -0500
Received: from DM6PR03CA0060.namprd03.prod.outlook.com (2603:10b6:5:100::37)
 by SN6PR03MB4111.namprd03.prod.outlook.com (2603:10b6:805:be::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1580.20; Fri, 1 Feb
 2019 09:36:50 +0000
Received: from CY1NAM02FT014.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::207) by DM6PR03CA0060.outlook.office365.com
 (2603:10b6:5:100::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1580.20 via Frontend
 Transport; Fri, 1 Feb 2019 09:36:50 +0000
Authentication-Results: spf=softfail (sender IP is 137.71.25.57)
 smtp.mailfrom=gmail.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=fail action=none header.from=gmail.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 gmail.com discourages use of 137.71.25.57 as permitted sender)
Received: from nwd2mta2.analog.com (137.71.25.57) by
 CY1NAM02FT014.mail.protection.outlook.com (10.152.75.142) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1580.10
 via Frontend Transport; Fri, 1 Feb 2019 09:36:50 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id x119anfI014669
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Fri, 1 Feb 2019 01:36:49 -0800
Received: from ben-Latitude-E6540.analog.com (10.50.1.129) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Fri, 1 Feb 2019 04:36:49 -0500
From:   Beniamin Bia <biabeniamin@gmail.com>
To:     <linux-iio@vger.kernel.org>
CC:     Beniamin Bia <biabeniamin@gmail.com>,
        Beniamin Bia <beniamin.bia@analog.com>
Subject: [PATCH 1/2] staging: iio: frequency: ad9833: Get frequency value statically
Date:   Fri, 1 Feb 2019 11:36:37 +0200
Message-ID: <20190201093638.26068-1-biabeniamin@gmail.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-Matching-Connectors: 131934874105745690;(2e7d0d53-e7ea-462f-80a6-08d65488a236);()
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(346002)(376002)(39860400002)(136003)(2980300002)(199004)(189003)(8936002)(6666004)(356004)(55446002)(26005)(77096007)(36756003)(305945005)(2906002)(7636002)(8676002)(51416003)(105596002)(87572001)(106466001)(2351001)(246002)(50466002)(48376002)(53416004)(1076003)(82202003)(47776003)(61266001)(73972006)(86362001)(83322999)(107886003)(126002)(4326008)(6916009)(486006)(73392003)(76482006)(498600001)(50226002)(2616005)(336012)(54906003)(16586007)(476003)(316002);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR03MB4111;H:nwd2mta2.analog.com;FPR:;SPF:SoftFail;LANG:en;PTR:nwd2mail11.analog.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT014;1:4MJlSDwUDeIBx1ulU6fNW6kq/9/ESx5IOvdlnYIgU5u6bXw5wfA6XkAonPsc0zI7Eo44ig3nv6tA5wss1YlzSuWqnHzwfiKVevxthqcDqiBCJNv0/1mPrRPGTumC5DpHbjbLYYeblb1INPMoliZtSULuZ8sRr3n/ZJClfT+Kv2Y=
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a4600dfe-cc40-498d-6e6a-08d68828cafe
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(5600110)(711020)(4605077)(2017052603328);SRVR:SN6PR03MB4111;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR03MB4111;3:6/0hguVRG5fNUSqsEC8ZJQrn8BqRKCp0ryVCr2Qd3nst/w7aPl5P+WpLBl0P1fEMJFxkfde5GVjCPxDZuQZBIT90HrT8x6joxxTCivKpEso+bd2eEvqfewN0eyTxtomjkkxmRvPr3cwcBnTbD1biokcgTPgfU9WUjaCqKbBDF6mLAdc9ATJHKJFPvvnRQqt2gxjxSAId5quu9xryPSzbGwvGjEsBu1ZC+sNlvHqeGfc5oEQPvLbpVTIBU0chw140Qhx3P6dND5dY+G7EAuBuGXkk8OnVh3Xky4qZh64zxeqqma3UmeF/T9rxa/QbeXzPKpw1rQw/Q2DPQx8sNSneXsQ7P58Jz369EisKQsfNSqJDZw5vAMTPkkoM4GqihEi6;25:hCtWLIqyC/d6+fhQW9bIownlZGH8YwYxVXlXSeqTLmQBQ+zurLs8xZXN3hOxHIeDdw81lnJqUhDzWilrn4z2Y5C40coNOH/3JWarojYYSVLPBH/P2jfKNOoSFWArZ7iSgi5mQs3N6qcYyGVJjLsHPgh0LMZxYp75udMPx9PVsAV7vbSJMhGhTgaLTuvAGEPz9O/3JkI3+n1hsMIHjlaPLc0w78A1PQJdajKnDriCPbOfkHp7wS0qLPBavKj6swnvXlhwRbKsqKMeDme71ph2G4qyZf+UPFFiCNN3u1mrqVTSxdtmTtk/vf/l1LCJnXnDxcUSSwhRiGDIRDJ3IjesHQ==
X-MS-TrafficTypeDiagnostic: SN6PR03MB4111:
X-Microsoft-Exchange-Diagnostics: 1;SN6PR03MB4111;31:Yctm6o5FWkE5PB1ivgU1bAkfCdjqLCgyGU8Vvqe9teCcLtIMIM/VNU/wr3VxyU3s5l94291cLH5l9JpudN6hv4P7BAAgkT7/UuSyesvqHhzMVfq+rM96RIjqHHTldHytR34L82/pWl0Im2U0gNgyTLocWNRwhCmZqKgRHheCQq3ZAyVTDyEcRI7KmSrY+a5iKaegpOgHKjTXPVN1zoXgVDosY/LwcOFKtx6vswi2a00=;4:tfNmZmTjXJjKsqzwhwmP0u4yuOIjT3b9zQIOE4KkmG1whh2MhLbkzvliMIfHdQQ5Tggzpj7DIOQfHa5rWN8OLVGkbJxk81WPUM0nrVsIlWuZvm+SY4enBg5I4Nju6QcncPP5KEXrh2TsOaL2J1vsEAxaW/LZM+nmSZkkzFB/jJqUDW6KDKoOMlewb8EhkrdDOe6dfsruFuJmVxPoDQM6HbFT79rxrOOZl+TQdhgzTuWoJhiIxYf+cjhkpmcgDspA9yWeAlQ4o+W9htr//gVL0nYII0SrHl8SQ4mJ4y7N3w3o8+gHANN9Ctye1vK2Jz0l
X-Microsoft-Antispam-PRVS: <SN6PR03MB41119D2B220D66BCBCCBCC7CBA920@SN6PR03MB4111.namprd03.prod.outlook.com>
X-Forefront-PRVS: 09352FD734
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN6PR03MB4111;23:0CCBMgI1iTikTrWxTmCew6p/RdpZSdkymo9NYg1wN?=
 =?us-ascii?Q?5iMlc9UODJALiHRqIlhVAd8wgE5zeLM0bNPOzxGbAfbnQwDd5cdubf7TeMg+?=
 =?us-ascii?Q?MrP9+Vse970ADChTZrxzNtJa0fLVzTUwtmL1WbZREaYU9YGZ6ByDB9u1Nj4G?=
 =?us-ascii?Q?A61mwY7JTtZwaFl74DhuHAJ/bZfrPtvWx66bWjga3inLKU8J7jDgaL8PJ+6p?=
 =?us-ascii?Q?1GTLp3W/aZayyjs1rYJBui3QlslCV8sL2L7mYzcbTUMnmKRsg4HqGu6BsbFK?=
 =?us-ascii?Q?tOb+y/8q5DUhaB5k+QPHIDVlOTk1LWvPznOnInSQYvD/MgVRa6IMBWlYe8+7?=
 =?us-ascii?Q?dvKssSAO7wAYnE7su8MuNozjvZt+Ehp1PlyfFoOPv8GGuaca04E0GxbsGK2d?=
 =?us-ascii?Q?lZPuBnbJ0a2wXfM/1pBOfOcB/RM0/MAY6EmWHaCRS9beGGG4q21Xg8CNkt6y?=
 =?us-ascii?Q?Whj9wcHV4VctftkSVxInnh/WNB6s5TH5g43HlyyNG2E5/wuSZ1Dgo+twdhDK?=
 =?us-ascii?Q?t3YlYz9hxLZ689MBob+EqAOi9ssot5V5nN2U6E4d6sbi5gTiL2q47MQB4y+j?=
 =?us-ascii?Q?uet6Kg0xUzRyVTD04R1iPojSj/3vvGc9yn8nblw99Fx30WNWt6DohbMQ0rV+?=
 =?us-ascii?Q?WBt4dbBvp6xSxr52kWhXZAUrDlaPsEaC74Wkggs6bcC6wOYlLA9+pLpi6R1K?=
 =?us-ascii?Q?nD8g3xCmfGgoTJhp5o0Gx0iWylYRUD5QH5ai75qd11vAxypuNG3IADB1PUaN?=
 =?us-ascii?Q?OfQEq5b/UyHK1nMDLQzwf9XW7azofAypH2zHSrCqxKK90OsSuD5t+aWsQKzy?=
 =?us-ascii?Q?QCiZ+ICq8c+IzKZA2KJ/iflrRxR0waXcsYRj/ykSHlr4SxxI5WKEF/k3hjo7?=
 =?us-ascii?Q?k/E87blVeK0CV7B+upIPyF8OTLYk+9SGY28yei3tGHLf8ORpia3FkSDayC2Q?=
 =?us-ascii?Q?ckgR6DEPnf6wU37ynHFeOSOCk4iXKoozLCoKbC+QiZv7jSOXYjvgLZrjDqom?=
 =?us-ascii?Q?sdUD2/VIpU/ea+YpLPtdN2y+REVkINCofhjpTvCktOsB3I2mmLe0qvy1/WkX?=
 =?us-ascii?Q?hrBaaxCvyBcS02QNrRvAzHZFgP58jLV6OCLH3SiAbAtgWN3/zAhZWQAgSCfA?=
 =?us-ascii?Q?XznicTQxyI=3D?=
X-Microsoft-Antispam-Message-Info: DX8noRxJlUSuNFC7iRqMsYNHWfSLMOMq+nkZ1BtiYsuQMr7n7zDX2rwFUNpQDXe7la8sLvLVs4kaD8V6fCO/T191TrdBqUWqEtQE/nsUNqHlKXPkDdOq1+N7cauxW0RqCizoOAHfMs6guKrojoV8c+eT94sBF3lVagRgB66SWiYpaFZQzKodQGfX8ImaAid6j9N5WX1bNHdMTISg4eHlH7oxCsRi2PeSLz/shJi/CZTzwcFA3ktkQr5AL7BWfHBDeI9mQQDyoaD48iyCksURMHxAnq29mchIfhh+rsUC0UUfy6AurXEK1grnXWIaeT6J+wgPbTs3Sm2gLktGvYwGvMFoB0kNd2J3MEDKlwhs2nMgUK/78OMxS6+M7bA6T8qlHz5tx+ZZz+99c43aQlrgx2olYG3Mbwq6kdCz19aqZCc=
X-Microsoft-Exchange-Diagnostics: 1;SN6PR03MB4111;6:zUw07VJVMhXZsWF4lm162INKLe7PsmlPOzQCecs5zAHxc1+v2MJzt8H/EZ2/P0n9ssgxRxiJe3pQhJsyACg5jgPcVgOchkvK94YHchwvkCBIPvHjhwiKCQPzSe6kw7uKjvrwzccpE2S8PcXlLVhFmVm9d1jBMQYAca6TZScBW5oIeD4VGnRedI7Im1TwSpe7vCKBZinU++uF4dLgEr4DiSEIWqxkYP7Yf4/LUAehEdMJG/PWbJjqgsLFIitO5O8Xu6ZcG4jgMZDG5ZlDZ7cPK/5C52mkekSQcsMOjrDTR7fCM6xdTEOX7WybDTr17wYyQNavrUkg+UPA6AnsjS4JYw9GnTwj0HEYD7gAMRkZQ+P8XQj+p+n9s3GA9HurCSUJ6tqHyyJdm1dJQ3aOQS5rbCDCZarhwM/mGAZNuXBsBGrltswsIYP2pjaJmMKrzWcSW59DTjX+2BHniZrZdRvkDQ==;5:OOSGOgmIPEHd7Tmcz8p+Uvk/KH+f8u9+Cn9Gf2lvl71U2/WnHulkLLFtaf2lEI3sr3yvkMaxnFQxHPUO8pqRSOVT3tofq73IDMFyAR4boeMr1C2h1oxO8ng/aOFHHyBPeV/An7UYNriPZffIW/Zwp2eR36pZCZ+AQAyKnYl49Dlly4o1NegYCHO+5I0EaEULnaQJUMJ5jZTThZ2ar7GI9w==;7:dr5icpPNKqoCD6/GPwUzSoHut89NbIRybwO16gdoOnj9vsR1gYrJ84Z+b0EUIDn/oc3aChOxGXx+zITFtygMmOB5ul6yVJ6SSsyYUDvv3i/qKMuky5kmQWgHg+PfbtZYCGPxEpx4/TLimf5Zkh2D7g==
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2019 09:36:50.2372
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a4600dfe-cc40-498d-6e6a-08d68828cafe
X-MS-Exchange-CrossTenant-Id: 5afe0b00-7697-4969-b663-5eab37d5f47e
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5afe0b00-7697-4969-b663-5eab37d5f47e;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR03MB4111
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The value of frequency is taken from ad9834.c instead of platform data

Signed-off-by: Beniamin Bia <beniamin.bia@analog.com>
---
 drivers/staging/iio/frequency/ad9834.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/iio/frequency/ad9834.c b/drivers/staging/iio/frequency/ad9834.c
index 995acdd7c942..d92d4bf71261 100644
--- a/drivers/staging/iio/frequency/ad9834.c
+++ b/drivers/staging/iio/frequency/ad9834.c
@@ -99,6 +99,16 @@ enum ad9834_supported_device_ids {
 	ID_AD9838,
 };
 
+static struct ad9834_platform_data default_config = {
+	.mclk = 25000000,
+	.freq0 = 1000000,
+	.freq1 = 5000000,
+	.phase0 = 512,
+	.phase1 = 1024,
+	.en_div2 = false,
+	.en_signbit_msb_out = false,
+};
+
 static unsigned int ad9834_calc_freqreg(unsigned long mclk, unsigned long fout)
 {
 	unsigned long long freqreg = (u64)fout * (u64)BIT(AD9834_FREQ_BITS);
@@ -391,16 +401,13 @@ static const struct iio_info ad9833_info = {
 
 static int ad9834_probe(struct spi_device *spi)
 {
-	struct ad9834_platform_data *pdata = dev_get_platdata(&spi->dev);
+	struct ad9834_platform_data *pdata;
 	struct ad9834_state *st;
 	struct iio_dev *indio_dev;
 	struct regulator *reg;
 	int ret;
 
-	if (!pdata) {
-		dev_dbg(&spi->dev, "no platform data?\n");
-		return -ENODEV;
-	}
+	pdata = &default_config;
 
 	reg = devm_regulator_get(&spi->dev, "avdd");
 	if (IS_ERR(reg))
-- 
2.17.1

