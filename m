Return-Path: <SRS0=jBoM=QI=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70667C282D8
	for <linux-iio@archiver.kernel.org>; Fri,  1 Feb 2019 09:37:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 373B22086C
	for <linux-iio@archiver.kernel.org>; Fri,  1 Feb 2019 09:37:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729325AbfBAJg7 (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Fri, 1 Feb 2019 04:36:59 -0500
Received: from mail-eopbgr750042.outbound.protection.outlook.com ([40.107.75.42]:57642
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727008AbfBAJg7 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 1 Feb 2019 04:36:59 -0500
Received: from BN6PR03CA0014.namprd03.prod.outlook.com (2603:10b6:404:23::24)
 by DM6PR03MB4106.namprd03.prod.outlook.com (2603:10b6:5:5a::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1558.21; Fri, 1 Feb
 2019 09:36:56 +0000
Received: from CY1NAM02FT007.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::208) by BN6PR03CA0014.outlook.office365.com
 (2603:10b6:404:23::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1580.17 via Frontend
 Transport; Fri, 1 Feb 2019 09:36:56 +0000
Authentication-Results: spf=softfail (sender IP is 137.71.25.57)
 smtp.mailfrom=gmail.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=fail action=none header.from=gmail.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 gmail.com discourages use of 137.71.25.57 as permitted sender)
Received: from nwd2mta2.analog.com (137.71.25.57) by
 CY1NAM02FT007.mail.protection.outlook.com (10.152.75.5) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1580.10
 via Frontend Transport; Fri, 1 Feb 2019 09:36:55 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id x119asGW014707
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Fri, 1 Feb 2019 01:36:54 -0800
Received: from ben-Latitude-E6540.analog.com (10.50.1.129) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Fri, 1 Feb 2019 04:36:53 -0500
From:   Beniamin Bia <biabeniamin@gmail.com>
To:     <linux-iio@vger.kernel.org>
CC:     Beniamin Bia <biabeniamin@gmail.com>,
        Beniamin Bia <beniamin.bia@analog.com>
Subject: [PATCH 2/2] staging: iio: frequency: ad9833: Load clock using clock framework
Date:   Fri, 1 Feb 2019 11:36:38 +0200
Message-ID: <20190201093638.26068-2-biabeniamin@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190201093638.26068-1-biabeniamin@gmail.com>
References: <20190201093638.26068-1-biabeniamin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-Matching-Connectors: 131934874155052413;(2e7d0d53-e7ea-462f-80a6-08d65488a236);()
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(396003)(376002)(136003)(39860400002)(2980300002)(189003)(199004)(246002)(476003)(107886003)(82202003)(26005)(51416003)(36756003)(73972006)(86362001)(2616005)(83322999)(126002)(54906003)(6916009)(316002)(77096007)(356004)(73392003)(11346002)(14444005)(336012)(6666004)(486006)(16586007)(446003)(76176011)(53416004)(2351001)(305945005)(61266001)(106466001)(87572001)(48376002)(105596002)(1076003)(50466002)(7636002)(8676002)(50226002)(47776003)(55446002)(498600001)(4326008)(76482006)(2906002)(8936002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR03MB4106;H:nwd2mta2.analog.com;FPR:;SPF:SoftFail;LANG:en;PTR:nwd2mail11.analog.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT007;1:UC6ZRbkU2uHg51Y07zNHlmraoamtn0Lis7DFO7kWiduVb3fNZFzn2bwFYLSzFv72UxdaOtj+lAiTG9u2zXtO/7goqn9dfHHXeaZ9VQN9/FKX543Lw9sApJOzaY6CggF03melH1scsWrk3mUF+O4ezJiMXPm2yyGxepL6kLIgqqY=
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 71c4bb42-3c2b-41c2-cad8-08d68828cdee
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(5600110)(711020)(4605077)(2017052603328);SRVR:DM6PR03MB4106;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR03MB4106;3:0xxtDfCxmAbdB5dvMESKd4cNaEsUQl52KEkWMadCN2fzOMYKgOLYGudpKjxMYgXME2NTLgdjBBaPS6IfAoH1zPiBf1dKLlWxXEDWK0aAUU1inftf5uQrbrUl8HI34kGvcduLmk+7M7rd9QiQJXWHQ4YQ/2OQ8kwCt1ZCmLR9I/KJQU08KEdiK6GJHcwgRZR8Ffj+kdVQNa5XAWrldwGS4/Af85TNfm9ZI3yI1JadJMaTIny7lYjhntJNL/0WoB5fjHiUVmtrxwn9Teb4fG0WmyjutEKnWqkCFI4wic3mjv/ddUHok8Uh89/OW5fJkCO1R4MPIanJqM6LKlJllnS4PwODg3clrmDG6RSB0oBXRaari+wzj5MYgtiDlmDu3e8a;25:L0QfWu6QBuPEuDU1YpcRDJvPcIpH6XlKuSkZ2JJYOXY6gcZxTnDw3Vyu/tfsvYwxwRtkYiXEHdWjY2xpecsIv11aR26qK4M0lPhGN9ULqIZBzIxNXotTzImD10uoLQwOvZ+hhCbmdKFw1FCWhHh4cEBjl5DeyE4rWKAFw2mVB07POWEvgr7JJznlwKKlx0vaj/WeNTcztYn6Q1bg6YW/DJf3U+l5lXEnI4CrCr/+FCgVR0+dLh54VYJKOA5DSydAwRtzsmPKmNEY8707ME8FweJ7EdHkBbqf4Nvvl14doW9X2F6upZo3lPF0LUmQt869bRIguGmTrYJyiIiHj/C0kA==
X-MS-TrafficTypeDiagnostic: DM6PR03MB4106:
X-Microsoft-Exchange-Diagnostics: 1;DM6PR03MB4106;31:8qZXGETuLTHcMszGV1We/f6xUpstpnEy/3oUNLhDT4LU35TarFWpkI4lMSfrJ7SUEFYWb7bx093sAVv3HRgAi1U570yTnPgbrNEdGCeVwizDjv4hGmIPA1jOa4elMvHM9z+5JEknjSAVR4GSquj3DUdAGQ5CvEJSgsgSCMhvZcYGkjEgx8a56PcQZYmJKNwHhxYb1byLv52+OJwPjBp9DO9k6Nqcl+hfvHixykTQv1c=;4:oEdx3E4ww+EV/skwVX5LetsZ+epf71Z/Fep3WzL8TtJbGwdUKJIJoIA+Z9BtK37mBhm6BWO9ervweKcixl/l9MWzBf9Zz2IRVP1esdTNMUGywZOBqzuDFEIHL6qU5sIRDhY1Qoy0unonnFoSTADkxQJrknH954yHYv02Y5n7AE4+lFjIlRL0YdfoDLI4XNYINSoA1b0ET+dB0k6vpeCtUInuE78UZjCBV0Kp03jZQGcj0v28/OuZ1UzbSCecDjJN4/TEBJUphlgl79azA/Joc71rXEujiQQxN3IIzXNwFmLOdlcHOxuX6B6Ns81B5Dsu
X-Microsoft-Antispam-PRVS: <DM6PR03MB41067F691727D22A376FE2C8BA920@DM6PR03MB4106.namprd03.prod.outlook.com>
X-Forefront-PRVS: 09352FD734
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM6PR03MB4106;23:GeNiZHMFhNjRe0lJMh609FwmBQIDsZ1HM+gYnhRuc?=
 =?us-ascii?Q?0PIXKwtzFHonuOtYVnXxXnPEim8An1aocY7iajhk9rygRsfFBEP6+oZXRCgf?=
 =?us-ascii?Q?SZwCWRwrN6YrDw5GbS8+XNj1jAGkWYk3tqAKWVHn4ZRJ7vqOZJUtXWlRKAoF?=
 =?us-ascii?Q?Ajz24wKbp+eLBrQIkh8IlY9B4H1lQKml737MAGSwXtmgozd+1mY9ezx9Fl2a?=
 =?us-ascii?Q?Q7sGhgFVfpp4KTxRHfYwYMoqsCt/+l0WfAkXh5bCE/5fQGzX2L/s/C14hM8d?=
 =?us-ascii?Q?o2yO4RQ9qvsh9tfsC4SP2/3QV/ctwrki0y8KEIdj1HcjerYGAzQJDPB4FjXz?=
 =?us-ascii?Q?NwdBO4M2D6SdrzJXdzNXMUepE1IHJNTUnItVxEdHLc0clkktgLb6BK9CPpzf?=
 =?us-ascii?Q?/WtMc6LmRXiz37/47pgbpy05zgCWEV0zWG8KIptNPE1MjxwjPlAzVD2TcwsM?=
 =?us-ascii?Q?EpMtoqF4Olq3L1K8xnjs7YhHDRBPSB4vxk0nw1RVdJp5d4egWNFMsarDobSw?=
 =?us-ascii?Q?mFr7i4HQ4M5OfJp19XA5RkvyAbKfBA35gzKpdfwzgDbEnatOqe2jD9M3T+nw?=
 =?us-ascii?Q?K1swu9ueBTM9p0RE4OODroaruXqYKHKJgfNqL3nr+mwbnQdWFRLoJs6z4X/w?=
 =?us-ascii?Q?FZwDlskaepzlYHExzSpz3B6l4vHWym2z5SuxZuBBHfScqkDDkBUrQ292VQyl?=
 =?us-ascii?Q?01QOhP89vCo6MlegnixWyXYIn4QKmjrX9Yu2KgB9+Clr2AimyYqZMekgiudL?=
 =?us-ascii?Q?utdiKTCqSTvaspZiGmGfyXpca6j9cL/ausi8tzzY7rvvdsbZ8dvR+YN4nCIC?=
 =?us-ascii?Q?o1unfG++IXqr7Oxe01k7a6vFTaSWhkX/8VekaB6g9T1KlkDG+H391W5o9FBS?=
 =?us-ascii?Q?HC/QTg15u0kf6K5avO6CL6KVtHH3naUwoySpZEVKVVfq7egLPhIYcleXs89R?=
 =?us-ascii?Q?2UeOkyx06TrXu+SbX6c7dp90GlkupFveSs8EkF2wQVaiyfJGGLTPc4EvLgYT?=
 =?us-ascii?Q?le1IGpmIs2+vwML7PYwN50M+eMJgM+VJN1f+7LTzEMGTQ36QtzOru37UlmJR?=
 =?us-ascii?Q?o4WAjvMJtzGYcEQbh8hfcau24Nxxri+FLusnLFr7N7u5GaHjwUcesxw5XGey?=
 =?us-ascii?Q?s+yNceOfKyYzerqX1zGpN5QLDxjQjJSFUbt0hUhKwv+YezoPPhnZPZg+HSDT?=
 =?us-ascii?Q?Ix/SbSu4yuhuZg=3D?=
X-Microsoft-Antispam-Message-Info: Sl+M59GWof5SDc+yoeM7j59WI1+4XZ7CnvQnv5MVC2MV7gvY3v4C1jZrsVQHWY1gKUoUjydVvvywhn8DWk60GsgK6SAQT66neZa9tD9DBPYhu/eV5rUPKKRlVI2QlqdsaDWKKin9tW282GjFpIK3vrBJlNg2YMb7jqbPHyuB0prbI3W7vB5cxQfnPc6+e708TBIm35j91rC0VbPKxpwl9NLgGgkFNzqMaWaYZvpFXDerInnsoHts6nuZT5Qjd8Op0rgn5H3E90PPJ31CJeyxr/pxfYplm/62gpTqNIJaTvAOgSBIapowHqbW4bXupnpgMddnXmD4YzuMhNKk6u5b0jp70lz4+SG1hPtGCJyFQSDX30xbI4RD6/Cbo3T7OSqiuop7zYA8KKkJuRnPRX3xEIkQXf9M4lqfU8hC/+LDIHs=
X-Microsoft-Exchange-Diagnostics: 1;DM6PR03MB4106;6:d0yzSg95rnVaBYzOe4ALyIPnoeTIvzIum8u7qoHYtLG4Rs9q3aH6y1rDqJ5/Z/owrZNva0ZGXQYZU4vpp6fUSeozDULKbtyJEuk6Q3444NT2DBy+wivBHFe3RWMQSX6Xj/e5OeEwwn1EkGt0MoLynDjETBVs6J88Wwh48vSSq0veQniTuc6ZEjrVU+QlpwalZ33yYVbybx7+nb0VskKKUpDprDMj7qKK5Ijh7QhsNEVI9JZLBXwxr5LJH8E8tArhZpivnVmdhn2IAmgEijleOYm/WdNGTwFf9UJKL/YyRUN3PFhsSVCYvzSKow/gl4bmVUgAiVLev5N9nk+tttV9hTlhXjHYfdDLxfylUzcOihY20jP59wMWvhzzxYv8TqAtUP4zHtheVuQgeUOkMkanPukTDZ2RqArT+B7rBTj0SvinA3pCm9IE1e2tZeSZR1on8Gup4xPd6+jTGe1lQzYcmw==;5:LTUH+PjQWPIv3OU33RohSM3YRppcxA0+qD4CclYY/IqqlmvLv4zXIn2fd+KdItbGrDRQbn5ouOH24DcKAvrP/7ZsiBMl99R65JYTYFhakuO2wtLHVvCVciKp5z+1cRyG1xHovAr8vRbi/sCj+/JyTzHbqJ5tI+osNKyjI8kx3YPD42FnCT5QeTsh6Fwehxa1GqMHOKx8NknAcL/EmcfSaw==;7:WGVtko1gmlNpSrIk3drKNK1+QMreiMV83400LdZMFQc01f7Rh8w5x7OK42MKVnKjpNIdqvqQ3jtIhyGb4TA9tmcypb/m9WmYbfNOq8CwjrryOxVgpuc9bY0cPB7TAX6O58W0E7XaYXejgPkS8jUiIw==
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2019 09:36:55.1648
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 71c4bb42-3c2b-41c2-cad8-08d68828cdee
X-MS-Exchange-CrossTenant-Id: 5afe0b00-7697-4969-b663-5eab37d5f47e
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5afe0b00-7697-4969-b663-5eab37d5f47e;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB4106
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The clock frequency is loaded from device-tree using clock framework
instead of old platform data structure. The change allow configuration of
the device via device-trees and better initialization sequence.
This is part of broader effort to add device-tree support to this driver
and take it out from staging.

Signed-off-by: Beniamin Bia <beniamin.bia@analog.com>
---
 drivers/staging/iio/frequency/ad9834.c | 24 +++++++++++++++++++-----
 drivers/staging/iio/frequency/ad9834.h |  2 --
 2 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/iio/frequency/ad9834.c b/drivers/staging/iio/frequency/ad9834.c
index d92d4bf71261..3b25065c1a72 100644
--- a/drivers/staging/iio/frequency/ad9834.c
+++ b/drivers/staging/iio/frequency/ad9834.c
@@ -6,6 +6,7 @@
  * Licensed under the GPL-2.
  */
 
+#include <linux/clk.h>
 #include <linux/interrupt.h>
 #include <linux/workqueue.h>
 #include <linux/device.h>
@@ -71,7 +72,7 @@
 struct ad9834_state {
 	struct spi_device		*spi;
 	struct regulator		*reg;
-	unsigned int			mclk;
+	struct clk			*mclk;
 	unsigned short			control;
 	unsigned short			devid;
 	struct spi_transfer		xfer;
@@ -100,7 +101,6 @@ enum ad9834_supported_device_ids {
 };
 
 static struct ad9834_platform_data default_config = {
-	.mclk = 25000000,
 	.freq0 = 1000000,
 	.freq1 = 5000000,
 	.phase0 = 512,
@@ -120,12 +120,15 @@ static unsigned int ad9834_calc_freqreg(unsigned long mclk, unsigned long fout)
 static int ad9834_write_frequency(struct ad9834_state *st,
 				  unsigned long addr, unsigned long fout)
 {
+	unsigned long clk_freq;
 	unsigned long regval;
 
-	if (fout > (st->mclk / 2))
+	clk_freq = clk_get_rate(st->mclk);
+
+	if (fout > (clk_freq / 2))
 		return -EINVAL;
 
-	regval = ad9834_calc_freqreg(st->mclk, fout);
+	regval = ad9834_calc_freqreg(clk_freq, fout);
 
 	st->freq_data[0] = cpu_to_be16(addr | (regval &
 				       RES_MASK(AD9834_FREQ_BITS / 2)));
@@ -405,6 +408,7 @@ static int ad9834_probe(struct spi_device *spi)
 	struct ad9834_state *st;
 	struct iio_dev *indio_dev;
 	struct regulator *reg;
+	struct clk *clk;
 	int ret;
 
 	pdata = &default_config;
@@ -419,6 +423,14 @@ static int ad9834_probe(struct spi_device *spi)
 		return ret;
 	}
 
+	clk = devm_clk_get(&spi->dev, NULL);
+
+	ret = clk_prepare_enable(clk);
+	if (ret) {
+		dev_err(&spi->dev, "Failed to enable master clock\n");
+		return ret;
+	}
+
 	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
 	if (!indio_dev) {
 		ret = -ENOMEM;
@@ -427,7 +439,7 @@ static int ad9834_probe(struct spi_device *spi)
 	spi_set_drvdata(spi, indio_dev);
 	st = iio_priv(indio_dev);
 	mutex_init(&st->lock);
-	st->mclk = pdata->mclk;
+	st->mclk = clk;
 	st->spi = spi;
 	st->devid = spi_get_device_id(spi)->driver_data;
 	st->reg = reg;
@@ -501,6 +513,7 @@ static int ad9834_probe(struct spi_device *spi)
 
 error_disable_reg:
 	regulator_disable(reg);
+	clk_disable_unprepare(st->mclk);
 
 	return ret;
 }
@@ -512,6 +525,7 @@ static int ad9834_remove(struct spi_device *spi)
 
 	iio_device_unregister(indio_dev);
 	regulator_disable(st->reg);
+	clk_disable_unprepare(st->mclk);
 
 	return 0;
 }
diff --git a/drivers/staging/iio/frequency/ad9834.h b/drivers/staging/iio/frequency/ad9834.h
index ae620f38eb49..16562dc10812 100644
--- a/drivers/staging/iio/frequency/ad9834.h
+++ b/drivers/staging/iio/frequency/ad9834.h
@@ -14,7 +14,6 @@
 
 /**
  * struct ad9834_platform_data - platform specific information
- * @mclk:		master clock in Hz
  * @freq0:		power up freq0 tuning word in Hz
  * @freq1:		power up freq1 tuning word in Hz
  * @phase0:		power up phase0 value [0..4095] correlates with 0..2PI
@@ -27,7 +26,6 @@
  */
 
 struct ad9834_platform_data {
-	unsigned int		mclk;
 	unsigned int		freq0;
 	unsigned int		freq1;
 	unsigned short		phase0;
-- 
2.17.1

