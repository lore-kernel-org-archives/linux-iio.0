Return-Path: <SRS0=THUK=QG=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D793C282D8
	for <linux-iio@archiver.kernel.org>; Wed, 30 Jan 2019 09:12:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E40A52184D
	for <linux-iio@archiver.kernel.org>; Wed, 30 Jan 2019 09:12:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="Y7aKIbwP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728371AbfA3JMt (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Wed, 30 Jan 2019 04:12:49 -0500
Received: from mail-eopbgr710069.outbound.protection.outlook.com ([40.107.71.69]:46841
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730566AbfA3JMn (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 30 Jan 2019 04:12:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v+7SrYM4g7WJ3c2thuVxquyVxkZNc2jAKO1pEKIDS+8=;
 b=Y7aKIbwPK0gs9PVAPybGuu46gDCJ2So2nq4fHipzuymVDwT8LDdaeaTFiRfNCxy84xThYXtehyWkTcidWUAJzVGOBQ475FNk3nzlCNIMAWd3Z0zmaCusXmgSdr7SINmG209wus2kHjOXH/+px6TorHoX0X4Pvc4p8gRYMGCGscI=
Received: from BYAPR03CA0029.namprd03.prod.outlook.com (2603:10b6:a02:a8::42)
 by DM6PR03MB3753.namprd03.prod.outlook.com (2603:10b6:5:50::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1558.18; Wed, 30 Jan
 2019 09:12:40 +0000
Received: from CY1NAM02FT047.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::208) by BYAPR03CA0029.outlook.office365.com
 (2603:10b6:a02:a8::42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1558.17 via Frontend
 Transport; Wed, 30 Jan 2019 09:12:40 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.55)
 smtp.mailfrom=analog.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 CY1NAM02FT047.mail.protection.outlook.com (10.152.74.177) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1580.10
 via Frontend Transport; Wed, 30 Jan 2019 09:12:39 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id x0U9Cd9L029119
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Wed, 30 Jan 2019 01:12:39 -0800
Received: from saturn.analog.com (10.50.1.244) by NWD2HUBCAS7.ad.analog.com
 (10.64.69.107) with Microsoft SMTP Server id 14.3.408.0; Wed, 30 Jan 2019
 04:12:38 -0500
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <jic23@kernel.org>,
        <michael.hennerich@analog.com>
CC:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH] staging: iio: cdc: ad7152: remove driver completely
Date:   Wed, 30 Jan 2019 11:12:36 +0200
Message-ID: <20190130091236.22155-1-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(396003)(39860400002)(136003)(346002)(2980300002)(199004)(189003)(356004)(316002)(126002)(478600001)(16586007)(2616005)(476003)(47776003)(110136005)(426003)(336012)(36756003)(4326008)(1076003)(77096007)(186003)(53416004)(107886003)(26005)(486006)(106002)(86362001)(246002)(6636002)(7636002)(7696005)(51416003)(30864003)(48376002)(8676002)(14444005)(106466001)(2201001)(50466002)(44832011)(50226002)(2906002)(305945005)(8936002)(21314003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR03MB3753;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT047;1:V0ylpWrBAS7M7wV3NVh+uQBBgIMH4rnAjIDruH9bxUbYJ5FOmtpQu+2AE2DzstFYaUYogAqmitSvdgx1Yw4oXg/wvwDZ2uNOPh7jkqMhQnM3aFqBawFgbiD7S7gZtFHXbquxMI9TeJgLIHAAlKeG6Fqo+wcirc/TJcY1IE0nKEU=
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f95f506a-36c7-4697-a81d-08d686931593
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4608076)(4709027)(2017052603328)(7153060);SRVR:DM6PR03MB3753;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR03MB3753;3:pGH8MyZ9DBAf+5o5YQP+GYNm2FdN1iXfv9+Ws/ecJsyh3ABXzekU14EEbb3JVqtzLXBk4cDVDRUyFKBtx7ODja2tGEoaAyHeRkKo4mon13FIfzMy1YTTE57Bwfd8xV+wDggT6YpLq44g8llqskkpF73bbMtCk6PQsrVmJ8ztiijhNqgzPtt+HdyDglFQ9NwZXE9KPZtuq9quCHGKnWXYj59MTWvqijK5ydcIykFjL1uiWln/akUC4w6ggwqFc/D2M/u+O8wLMR4ptivVUvViHvRveK7MEOR1AXHP0bv6mmPEXxpu3oT1FmwjTEO3TgQ98szyyfw8F7CuMgycCpW/6YfmZ5BNNNq0JiDmBFRMX0aZ4/66J36aw2NId4N8yjEB;25:RppH7JMWfMhbHAyRgbr2wOniBWMvBv03+sBYK4xwCl4iF2yLr1dO50tTt/nZ04ntlglKvsnNIqI/Jg/BSIy6ZMCni/v3JFOHaFSh5eJZ7SrIhMVdUJz8n5W+muzB501LHTBSrDWV2ENLHlDsCmsetjWX5Zy2Tf4TOouI3fin/gyj0o3+l4IBvgbogFVqf3csdnU1r4cuyiTuceIIHoKK6aE0ZUd9Y4PkpIYtGzGTgMvuYLUqXAfJhC0iAuQLoDTu06VTKzhcmH46uhAnStCrgB2M3KJx+NS7y6sIFjqOoqObkmzwn//nAVVjeArz3v1IkXtnGzYcSI/303MtTDl0Xg==
X-MS-TrafficTypeDiagnostic: DM6PR03MB3753:
X-Microsoft-Exchange-Diagnostics: 1;DM6PR03MB3753;31:CcoUgOj+pmDRTV3Bs109yv9UZs6LkISyXEAtUWo88y1TSWuYru/IDl9+GoHCac1dBXmnsVrQEJdZ8j7VRzyD5E47DLtpsKOHatmDRNHZCxVskx++b0CMju904ybyALO/oimn+uoUqOe9/gCE4qMGm0/bKzgHWHbZ3Jy3z+NOoJJpejRtdDtYZrR7YSShuPgHZm3LB0SLAi18F3jSdNXRTHlBgYsvro7RpHemhORhJKs=;20:HDxLi9IldoU4Nu5lAmnZ9BCYRHNKHqo6rQWpRVzzJnixAmxIk1MBr00LDqCq/LsfD17qWnGeaDpU22gjiJhHD0bcbwOKWdzTbW2aDMrAUC2T+yLjFZO8cTWInM3J+r1dAOMChLT/g+VNw1geFUlwrAzSLpC57c/UoO8oa++Pv9lVtebuLxUktyvWp0kl085hEf0+UX6tJvNAIxTp+GVec6go3YFWx0xyjZe8rM2dNH3YP8HzxTV+y51xN14OoGxik3sO4gNme8PIHDBD5YdbSif0pYbYriWBzNkc0fFH7zd70zZ0HFpG52J8A/lm8u7+afF9aMEwuU/pNqwTaYZB1Ngrlz/AJXtdlVL70Q5m6IjpjEue/iR0ZmplUQGFzPkRYP2Sz60RzMfYWHg7QJde/5SXYztd0BztNBr7SRDaxpqSKbmvfyN7WpQnQ+4DvOFFbShKtjY99+/FasBnMh3s0VA1pN9DHFbYuSZMszThGD7gdAZv9Ba+ZJUnTzsPfpYQ
X-Microsoft-Antispam-PRVS: <DM6PR03MB3753D85251AC986283AC84FFF9900@DM6PR03MB3753.namprd03.prod.outlook.com>
X-Microsoft-Exchange-Diagnostics: 1;DM6PR03MB3753;4:n55gag3uGAI8LA3Zs2o5YHvcLGmi29h7QFGOx4lmMkTlGvzlpa0ogEMSIp+eLDRRL4KXGTNTwHMSl4sPHmHAmTVYkIRpZCMiTH3BNxSH+7W1Py8z2MtJojb4EKIVAPvwqBIrsBrCwZVTkMv0ywILaIv8wCvLabq88Zi1Mdq12b/tjnxRwhvSClX7UDkVEXf1XHCaXJ2/XHGBiGHWl0jy1MK8QbXgb4puWHg/6NfkIJ2qBpACPu1/9ADbU7/u2xvKrJWIMg7FMGYMW6dHkmCA+Ji2k9QMftNSi5iukUUTC9o=
X-Forefront-PRVS: 0933E9FD8D
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM6PR03MB3753;23:A1aqPObVohBfw1POOsolGQi3NKTEh5HlXEc659OSq?=
 =?us-ascii?Q?NZXq8cS7rPF9KDnAOlYiR9mPC7zacKvAeK4IO8MqLWWgBeA2TCen9OJOEW6F?=
 =?us-ascii?Q?n1KKxleVCBoTaLtKU/oQ5A1QS9zc3r+wZZbQdP0ZdJoAwh0wz9Iaxc48WTWH?=
 =?us-ascii?Q?uw1XStyPopXSM0zHGIcQ3J0jnlD6GtVBU8S2zPVFcFoaLN5OQkiWClPB1JIp?=
 =?us-ascii?Q?gsr7oqSBGaNUQTJOOoCcRED/ioBHH9zdSA1QT9W69HGQRpQDYdCwcS8XXqH6?=
 =?us-ascii?Q?f4Gm1BWXtDNLVECt4OLsAybTvjldQvf9OFBMjop1R0IH7IPUXet+f9KDPq7C?=
 =?us-ascii?Q?ZfZUlz6snBMQU1rTpowrms+OgRXk0OYQtln5vPmq2iZ2PhiZlvdBhZzp/Dm5?=
 =?us-ascii?Q?LOqf7jWXYLz4GvVd6glDEXf1zwe7aOi6EkHgSkCiNw2P/r+ZOxMhXd31ilw7?=
 =?us-ascii?Q?oWuEJJlv1PgPBevAmDw0tTvlQhE6UQIh6m8HUq0R/udOZ53TDQk+uZ1cTN+O?=
 =?us-ascii?Q?u/cAN0hHEji+KMEwvd1FPnOhTvXPUi2zeitp2CgIFprHI0OBlNpRRxAe07OM?=
 =?us-ascii?Q?t+jPFHrBfhFmqpitMUzivdHH4jQOBFlZn1RaFGlHVj1LDbMxgCVD9WMj3qK6?=
 =?us-ascii?Q?B/KrXK7nStiJPbD4RFBLyTcTP2vCXkz9X6XJfWskrKLd6Ox+Y4TrglhUws5Y?=
 =?us-ascii?Q?hZ71cyEQIjDmWhCytZuae7PsT0CIOZ8TcaLZnKE046xGMKrUbdhCa7puDgu4?=
 =?us-ascii?Q?IjZF3T5/yqkuxdHR0uSxNU18yMqw2a5mzYb1J8pOVnYDbPI6F2CEO2HVRZQE?=
 =?us-ascii?Q?qLudq39+fPIuh3KTmxbPnvi8rV7QaOtsxJY/lp+8Lfsc2PkLg1O07us7xmWY?=
 =?us-ascii?Q?UEqqYPQq0ENoyNYcZYWDSrKr+La9GikuIA2Zenw3R9R8/Qypal8ZRhWsPlQa?=
 =?us-ascii?Q?8aKEhgK3IGk1khBUKYgP/hEDSWzcExtFbkY7ZYslXol6OPQZnpI0CFZeidA8?=
 =?us-ascii?Q?md9MDel59xopUztcJYCHs+EFbkHg0mTYvSroWgBwLVdR53YzAtxrm1DJt18I?=
 =?us-ascii?Q?jve+9o=3D?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: xgFXX9OBbTzBUZMHPZh/ypFAPs5u6sfPNODaREwXdD1lz6ER1X99atWoOZRlZBFEW5eU1mVqL6O/OeK6i2Vi3Igt2BqGz6l9aDi53OSVMnQ4iiaK0KIjzrcm6tiMLzSZ7vhZWW3JQ71IY3fIMtov8JQ5U/obobxvQoQbMP4ROhH/JwBnp63CSJCnvll1eRAD1hl4WDFc3U75EX1ro7+a9P4mBt+KfbPSm2qWAAeihOQlMWIf8DvjfjCjcr//NC9eq+ULfPdBWTuXFS81yPHoxMaX1qhW4VXaUQg4/epMj38/Q11BQimKr/PdHp0CcKinNKDdoSbuDDObnbB03aWdh579om1tBFHfKy2OEtQCqs1OsYYdSp/xIDzVmMASQ23nzQkDETswIPDpBU9HG6gnmyBLRJxFdHlDvjxiUydg6fE=
X-Microsoft-Exchange-Diagnostics: 1;DM6PR03MB3753;6:yJM5VzVnvyMvAG2/kJNcfiocaqU86phqWUs/U1pNef+jH4Z0VhtTGs3jRYtMIAw7JL3kSyQr7zoYOcRcoIUB36ipQ4zulwRC0A3zXFvNWHRdUtU6KUV7kRa7VNtPKxGIvBbcoSIEFxUmTRX1+RsGplv2skg0POBBeNOmqQK+z2Qap+lF3dFl8kYHpoJ9ZGb9G6i6kAHyNncd5Mt+VgROxpjF22zuaQBRNJjYlZEKuUY53fojndQ9FxnzcPUrzXAv3dkGuimpdF+cpom0tlHQvwfVFBsnhip1N63WmtPVi6iUEGcfzUy9Spt41QA/sAMYDRLpmstyHFNqVHW5X/Dg1+Ao8W6HGFxBZ33aaQSUIl50kXcgAAzuQ5gq95dZXLNmjDQkWKhlU3/5ub8ncTBO5ik1H3hagXmnrCEivdfUrsUNSFruVRXRplXve+np12x0LZdUx2nGGnjuKimxQJYN/Q==;5:0R0ZrMw+/Uxyrq2BIxBuqrSyAF34TsS81X1PYT4mul+npMm4a3nfLQfftii4HR5vs8e2lMdXIYJYVk7O6hjsaLvEL2szXnHWzfU7BXo1xM/hq2y6s2cCfh87dOG7CLzKRxB9pdNAQyL+TDHmdiuKtDuNMmk2HhUCza0f0e+mlNiXTfH8g2uXPfuxf7kE+fft0Cn2FM+DwnMbxue9MTcU3A==;7:re56UmCsxGGLVksYPA8LGZj0/XV+N/X/agtq1XelYP20cFwcHRbAUvxHAjCro1c5jwBFwXhC0TOcBO+xl0ODnFI+QqWKvioBKAphsgpRMBdAhOx5NXkFNKkVPRL+QE/SUdRDsig05c8oeVXp6/67tA==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2019 09:12:39.6960
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f95f506a-36c7-4697-a81d-08d686931593
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB3753
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The AD7153 part has been obsoleted for some time. The AD7152 part will be
obsolete in the coming future.
Moving it out of staging doesn't make sense anymore. Which makes the driver
enter a limbo state.

This patch removes the driver completely, so that no effort is placed on
it, allowing people to focus on other parts that will still be around.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---

If there are any users around, feel free to speak up and we can leave the
driver in staging, for a while longer. Otherwise I would prefer to remove
it, so we can redirect people to active parts.

 drivers/staging/iio/cdc/Kconfig  |  10 -
 drivers/staging/iio/cdc/Makefile |   1 -
 drivers/staging/iio/cdc/ad7152.c | 552 -------------------------------
 3 files changed, 563 deletions(-)
 delete mode 100644 drivers/staging/iio/cdc/ad7152.c

diff --git a/drivers/staging/iio/cdc/Kconfig b/drivers/staging/iio/cdc/Kconfig
index 80211df8c577..b97478e7cbd0 100644
--- a/drivers/staging/iio/cdc/Kconfig
+++ b/drivers/staging/iio/cdc/Kconfig
@@ -13,16 +13,6 @@ config AD7150
 	  To compile this driver as a module, choose M here: the
 	  module will be called ad7150.
 
-config AD7152
-	tristate "Analog Devices ad7152/3 capacitive sensor driver"
-	depends on I2C
-	help
-	  Say yes here to build support for Analog Devices capacitive sensors.
-	  (ad7152, ad7153) Provides direct access via sysfs.
-
-	  To compile this driver as a module, choose M here: the
-	  module will be called ad7152.
-
 config AD7746
 	tristate "Analog Devices AD7745, AD7746 AD7747 capacitive sensor driver"
 	depends on I2C
diff --git a/drivers/staging/iio/cdc/Makefile b/drivers/staging/iio/cdc/Makefile
index a5fbabf5c8bf..1466bc31f244 100644
--- a/drivers/staging/iio/cdc/Makefile
+++ b/drivers/staging/iio/cdc/Makefile
@@ -3,5 +3,4 @@
 #
 
 obj-$(CONFIG_AD7150) += ad7150.o
-obj-$(CONFIG_AD7152) += ad7152.o
 obj-$(CONFIG_AD7746) += ad7746.o
diff --git a/drivers/staging/iio/cdc/ad7152.c b/drivers/staging/iio/cdc/ad7152.c
deleted file mode 100644
index 25f51db05d2d..000000000000
--- a/drivers/staging/iio/cdc/ad7152.c
+++ /dev/null
@@ -1,552 +0,0 @@
-/*
- * AD7152 capacitive sensor driver supporting AD7152/3
- *
- * Copyright 2010-2011a Analog Devices Inc.
- *
- * Licensed under the GPL-2 or later.
- */
-
-#include <linux/interrupt.h>
-#include <linux/device.h>
-#include <linux/kernel.h>
-#include <linux/slab.h>
-#include <linux/sysfs.h>
-#include <linux/i2c.h>
-#include <linux/module.h>
-#include <linux/delay.h>
-
-#include <linux/iio/iio.h>
-#include <linux/iio/sysfs.h>
-
-/*
- * TODO: Check compliance of calibbias with abi (units)
- */
-/*
- * AD7152 registers definition
- */
-
-#define AD7152_REG_STATUS		0
-#define AD7152_REG_CH1_DATA_HIGH	1
-#define AD7152_REG_CH2_DATA_HIGH	3
-#define AD7152_REG_CH1_OFFS_HIGH	5
-#define AD7152_REG_CH2_OFFS_HIGH	7
-#define AD7152_REG_CH1_GAIN_HIGH	9
-#define AD7152_REG_CH1_SETUP		11
-#define AD7152_REG_CH2_GAIN_HIGH	12
-#define AD7152_REG_CH2_SETUP		14
-#define AD7152_REG_CFG			15
-#define AD7152_REG_RESEVERD		16
-#define AD7152_REG_CAPDAC_POS		17
-#define AD7152_REG_CAPDAC_NEG		18
-#define AD7152_REG_CFG2			26
-
-/* Status Register Bit Designations (AD7152_REG_STATUS) */
-#define AD7152_STATUS_RDY1		BIT(0)
-#define AD7152_STATUS_RDY2		BIT(1)
-#define AD7152_STATUS_C1C2		BIT(2)
-#define AD7152_STATUS_PWDN		BIT(7)
-
-/* Setup Register Bit Designations (AD7152_REG_CHx_SETUP) */
-#define AD7152_SETUP_CAPDIFF		BIT(5)
-#define AD7152_SETUP_RANGE_2pF		(0 << 6)
-#define AD7152_SETUP_RANGE_0_5pF	(1 << 6)
-#define AD7152_SETUP_RANGE_1pF		(2 << 6)
-#define AD7152_SETUP_RANGE_4pF		(3 << 6)
-#define AD7152_SETUP_RANGE(x)		((x) << 6)
-
-/* Config Register Bit Designations (AD7152_REG_CFG) */
-#define AD7152_CONF_CH2EN		BIT(3)
-#define AD7152_CONF_CH1EN		BIT(4)
-#define AD7152_CONF_MODE_IDLE		(0 << 0)
-#define AD7152_CONF_MODE_CONT_CONV	(1 << 0)
-#define AD7152_CONF_MODE_SINGLE_CONV	(2 << 0)
-#define AD7152_CONF_MODE_OFFS_CAL	(5 << 0)
-#define AD7152_CONF_MODE_GAIN_CAL	(6 << 0)
-
-/* Capdac Register Bit Designations (AD7152_REG_CAPDAC_XXX) */
-#define AD7152_CAPDAC_DACEN		BIT(7)
-#define AD7152_CAPDAC_DACP(x)		((x) & 0x1F)
-
-/* CFG2 Register Bit Designations (AD7152_REG_CFG2) */
-#define AD7152_CFG2_OSR(x)		(((x) & 0x3) << 4)
-
-enum {
-	AD7152_DATA,
-	AD7152_OFFS,
-	AD7152_GAIN,
-	AD7152_SETUP
-};
-
-/*
- * struct ad7152_chip_info - chip specific information
- */
-
-struct ad7152_chip_info {
-	struct i2c_client *client;
-	/*
-	 * Capacitive channel digital filter setup;
-	 * conversion time/update rate setup per channel
-	 */
-	u8	filter_rate_setup;
-	u8	setup[2];
-	struct mutex state_lock;	/* protect hardware state */
-};
-
-static inline ssize_t ad7152_start_calib(struct device *dev,
-					 struct device_attribute *attr,
-					 const char *buf,
-					 size_t len,
-					 u8 regval)
-{
-	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
-	struct ad7152_chip_info *chip = iio_priv(indio_dev);
-	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
-	bool doit;
-	int ret, timeout = 10;
-
-	ret = strtobool(buf, &doit);
-	if (ret < 0)
-		return ret;
-
-	if (!doit)
-		return 0;
-
-	if (this_attr->address == 0)
-		regval |= AD7152_CONF_CH1EN;
-	else
-		regval |= AD7152_CONF_CH2EN;
-
-	mutex_lock(&chip->state_lock);
-	ret = i2c_smbus_write_byte_data(chip->client, AD7152_REG_CFG, regval);
-	if (ret < 0)
-		goto unlock;
-
-	do {
-		mdelay(20);
-		ret = i2c_smbus_read_byte_data(chip->client, AD7152_REG_CFG);
-		if (ret < 0)
-			goto unlock;
-
-	} while ((ret == regval) && timeout--);
-
-	mutex_unlock(&chip->state_lock);
-	return len;
-
-unlock:
-	mutex_unlock(&chip->state_lock);
-	return ret;
-}
-
-static ssize_t ad7152_start_offset_calib(struct device *dev,
-					 struct device_attribute *attr,
-					 const char *buf,
-					 size_t len)
-{
-	return ad7152_start_calib(dev, attr, buf, len,
-				  AD7152_CONF_MODE_OFFS_CAL);
-}
-
-static ssize_t ad7152_start_gain_calib(struct device *dev,
-				       struct device_attribute *attr,
-				       const char *buf,
-				       size_t len)
-{
-	return ad7152_start_calib(dev, attr, buf, len,
-				  AD7152_CONF_MODE_GAIN_CAL);
-}
-
-static IIO_DEVICE_ATTR(in_capacitance0_calibbias_calibration,
-		       0200, NULL, ad7152_start_offset_calib, 0);
-static IIO_DEVICE_ATTR(in_capacitance1_calibbias_calibration,
-		       0200, NULL, ad7152_start_offset_calib, 1);
-static IIO_DEVICE_ATTR(in_capacitance0_calibscale_calibration,
-		       0200, NULL, ad7152_start_gain_calib, 0);
-static IIO_DEVICE_ATTR(in_capacitance1_calibscale_calibration,
-		       0200, NULL, ad7152_start_gain_calib, 1);
-
-/* Values are Update Rate (Hz), Conversion Time (ms) + 1*/
-static const unsigned char ad7152_filter_rate_table[][2] = {
-	{200, 5 + 1}, {50, 20 + 1}, {20, 50 + 1}, {17, 60 + 1},
-};
-
-static IIO_CONST_ATTR_SAMP_FREQ_AVAIL("200 50 20 17");
-
-static IIO_CONST_ATTR(in_capacitance_scale_available,
-		      "0.000061050 0.000030525 0.000015263 0.000007631");
-
-static struct attribute *ad7152_attributes[] = {
-	&iio_dev_attr_in_capacitance0_calibbias_calibration.dev_attr.attr,
-	&iio_dev_attr_in_capacitance1_calibbias_calibration.dev_attr.attr,
-	&iio_dev_attr_in_capacitance0_calibscale_calibration.dev_attr.attr,
-	&iio_dev_attr_in_capacitance1_calibscale_calibration.dev_attr.attr,
-	&iio_const_attr_in_capacitance_scale_available.dev_attr.attr,
-	&iio_const_attr_sampling_frequency_available.dev_attr.attr,
-	NULL,
-};
-
-static const struct attribute_group ad7152_attribute_group = {
-	.attrs = ad7152_attributes,
-};
-
-static const u8 ad7152_addresses[][4] = {
-	{ AD7152_REG_CH1_DATA_HIGH, AD7152_REG_CH1_OFFS_HIGH,
-	  AD7152_REG_CH1_GAIN_HIGH, AD7152_REG_CH1_SETUP },
-	{ AD7152_REG_CH2_DATA_HIGH, AD7152_REG_CH2_OFFS_HIGH,
-	  AD7152_REG_CH2_GAIN_HIGH, AD7152_REG_CH2_SETUP },
-};
-
-/* Values are nano relative to pf base. */
-static const int ad7152_scale_table[] = {
-	30525, 7631, 15263, 61050
-};
-
-/**
- * read_raw handler for IIO_CHAN_INFO_SAMP_FREQ
- *
- * lock must be held
- **/
-static int ad7152_read_raw_samp_freq(struct device *dev, int *val)
-{
-	struct ad7152_chip_info *chip = iio_priv(dev_to_iio_dev(dev));
-
-	*val = ad7152_filter_rate_table[chip->filter_rate_setup][0];
-
-	return 0;
-}
-
-/**
- * write_raw handler for IIO_CHAN_INFO_SAMP_FREQ
- *
- * lock must be held
- **/
-static int ad7152_write_raw_samp_freq(struct device *dev, int val)
-{
-	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
-	struct ad7152_chip_info *chip = iio_priv(indio_dev);
-	int ret, i;
-
-	for (i = 0; i < ARRAY_SIZE(ad7152_filter_rate_table); i++)
-		if (val >= ad7152_filter_rate_table[i][0])
-			break;
-
-	if (i >= ARRAY_SIZE(ad7152_filter_rate_table))
-		i = ARRAY_SIZE(ad7152_filter_rate_table) - 1;
-
-	ret = i2c_smbus_write_byte_data(chip->client,
-					AD7152_REG_CFG2, AD7152_CFG2_OSR(i));
-	if (ret < 0)
-		return ret;
-
-	chip->filter_rate_setup = i;
-
-	return ret;
-}
-
-static int ad7152_write_raw(struct iio_dev *indio_dev,
-			    struct iio_chan_spec const *chan,
-			    int val,
-			    int val2,
-			    long mask)
-{
-	struct ad7152_chip_info *chip = iio_priv(indio_dev);
-	int ret, i;
-
-	mutex_lock(&chip->state_lock);
-
-	switch (mask) {
-	case IIO_CHAN_INFO_CALIBSCALE:
-		if (val != 1) {
-			ret = -EINVAL;
-			goto out;
-		}
-
-		val = (val2 * 1024) / 15625;
-
-		ret = i2c_smbus_write_word_data(chip->client,
-				ad7152_addresses[chan->channel][AD7152_GAIN],
-				swab16(val));
-		if (ret < 0)
-			goto out;
-
-		ret = 0;
-		break;
-
-	case IIO_CHAN_INFO_CALIBBIAS:
-		if ((val < 0) | (val > 0xFFFF)) {
-			ret = -EINVAL;
-			goto out;
-		}
-		ret = i2c_smbus_write_word_data(chip->client,
-				ad7152_addresses[chan->channel][AD7152_OFFS],
-				swab16(val));
-		if (ret < 0)
-			goto out;
-
-		ret = 0;
-		break;
-	case IIO_CHAN_INFO_SCALE:
-		if (val) {
-			ret = -EINVAL;
-			goto out;
-		}
-		for (i = 0; i < ARRAY_SIZE(ad7152_scale_table); i++)
-			if (val2 == ad7152_scale_table[i])
-				break;
-
-		chip->setup[chan->channel] &= ~AD7152_SETUP_RANGE_4pF;
-		chip->setup[chan->channel] |= AD7152_SETUP_RANGE(i);
-
-		ret = i2c_smbus_write_byte_data(chip->client,
-				ad7152_addresses[chan->channel][AD7152_SETUP],
-				chip->setup[chan->channel]);
-		if (ret < 0)
-			goto out;
-
-		ret = 0;
-		break;
-	case IIO_CHAN_INFO_SAMP_FREQ:
-		if (val2) {
-			ret = -EINVAL;
-			goto out;
-		}
-		ret = ad7152_write_raw_samp_freq(&indio_dev->dev, val);
-		if (ret < 0)
-			goto out;
-
-		ret = 0;
-		break;
-	default:
-		ret = -EINVAL;
-	}
-
-out:
-	mutex_unlock(&chip->state_lock);
-	return ret;
-}
-
-static int ad7152_read_raw(struct iio_dev *indio_dev,
-			   struct iio_chan_spec const *chan,
-			   int *val, int *val2,
-			   long mask)
-{
-	struct ad7152_chip_info *chip = iio_priv(indio_dev);
-	int ret;
-	u8 regval = 0;
-
-	mutex_lock(&chip->state_lock);
-
-	switch (mask) {
-	case IIO_CHAN_INFO_RAW:
-		/* First set whether in differential mode */
-
-		regval = chip->setup[chan->channel];
-
-		if (chan->differential)
-			chip->setup[chan->channel] |= AD7152_SETUP_CAPDIFF;
-		else
-			chip->setup[chan->channel] &= ~AD7152_SETUP_CAPDIFF;
-
-		if (regval != chip->setup[chan->channel]) {
-			ret = i2c_smbus_write_byte_data(chip->client,
-				ad7152_addresses[chan->channel][AD7152_SETUP],
-				chip->setup[chan->channel]);
-			if (ret < 0)
-				goto out;
-		}
-		/* Make sure the channel is enabled */
-		if (chan->channel == 0)
-			regval = AD7152_CONF_CH1EN;
-		else
-			regval = AD7152_CONF_CH2EN;
-
-		/* Trigger a single read */
-		regval |= AD7152_CONF_MODE_SINGLE_CONV;
-		ret = i2c_smbus_write_byte_data(chip->client, AD7152_REG_CFG,
-				regval);
-		if (ret < 0)
-			goto out;
-
-		msleep(ad7152_filter_rate_table[chip->filter_rate_setup][1]);
-		/* Now read the actual register */
-		ret = i2c_smbus_read_word_data(chip->client,
-				ad7152_addresses[chan->channel][AD7152_DATA]);
-		if (ret < 0)
-			goto out;
-		*val = swab16(ret);
-
-		if (chan->differential)
-			*val -= 0x8000;
-
-		ret = IIO_VAL_INT;
-		break;
-	case IIO_CHAN_INFO_CALIBSCALE:
-
-		ret = i2c_smbus_read_word_data(chip->client,
-				ad7152_addresses[chan->channel][AD7152_GAIN]);
-		if (ret < 0)
-			goto out;
-		/* 1 + gain_val / 2^16 */
-		*val = 1;
-		*val2 = (15625 * swab16(ret)) / 1024;
-
-		ret = IIO_VAL_INT_PLUS_MICRO;
-		break;
-	case IIO_CHAN_INFO_CALIBBIAS:
-		ret = i2c_smbus_read_word_data(chip->client,
-				ad7152_addresses[chan->channel][AD7152_OFFS]);
-		if (ret < 0)
-			goto out;
-		*val = swab16(ret);
-
-		ret = IIO_VAL_INT;
-		break;
-	case IIO_CHAN_INFO_SCALE:
-		ret = i2c_smbus_read_byte_data(chip->client,
-				ad7152_addresses[chan->channel][AD7152_SETUP]);
-		if (ret < 0)
-			goto out;
-		*val = 0;
-		*val2 = ad7152_scale_table[ret >> 6];
-
-		ret = IIO_VAL_INT_PLUS_NANO;
-		break;
-	case IIO_CHAN_INFO_SAMP_FREQ:
-		ret = ad7152_read_raw_samp_freq(&indio_dev->dev, val);
-		if (ret < 0)
-			goto out;
-
-		ret = IIO_VAL_INT;
-		break;
-	default:
-		ret = -EINVAL;
-	}
-out:
-	mutex_unlock(&chip->state_lock);
-	return ret;
-}
-
-static int ad7152_write_raw_get_fmt(struct iio_dev *indio_dev,
-				    struct iio_chan_spec const *chan,
-				    long mask)
-{
-	switch (mask) {
-	case IIO_CHAN_INFO_SCALE:
-		return IIO_VAL_INT_PLUS_NANO;
-	default:
-		return IIO_VAL_INT_PLUS_MICRO;
-	}
-}
-
-static const struct iio_info ad7152_info = {
-	.attrs = &ad7152_attribute_group,
-	.read_raw = ad7152_read_raw,
-	.write_raw = ad7152_write_raw,
-	.write_raw_get_fmt = ad7152_write_raw_get_fmt,
-};
-
-static const struct iio_chan_spec ad7152_channels[] = {
-	{
-		.type = IIO_CAPACITANCE,
-		.indexed = 1,
-		.channel = 0,
-		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
-		BIT(IIO_CHAN_INFO_CALIBSCALE) |
-		BIT(IIO_CHAN_INFO_CALIBBIAS) |
-		BIT(IIO_CHAN_INFO_SCALE),
-		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),
-	}, {
-		.type = IIO_CAPACITANCE,
-		.differential = 1,
-		.indexed = 1,
-		.channel = 0,
-		.channel2 = 2,
-		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
-		BIT(IIO_CHAN_INFO_CALIBSCALE) |
-		BIT(IIO_CHAN_INFO_CALIBBIAS) |
-		BIT(IIO_CHAN_INFO_SCALE),
-		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),
-	}, {
-		.type = IIO_CAPACITANCE,
-		.indexed = 1,
-		.channel = 1,
-		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
-		BIT(IIO_CHAN_INFO_CALIBSCALE) |
-		BIT(IIO_CHAN_INFO_CALIBBIAS) |
-		BIT(IIO_CHAN_INFO_SCALE),
-		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),
-	}, {
-		.type = IIO_CAPACITANCE,
-		.differential = 1,
-		.indexed = 1,
-		.channel = 1,
-		.channel2 = 3,
-		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
-		BIT(IIO_CHAN_INFO_CALIBSCALE) |
-		BIT(IIO_CHAN_INFO_CALIBBIAS) |
-		BIT(IIO_CHAN_INFO_SCALE),
-		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),
-	}
-};
-
-/*
- * device probe and remove
- */
-
-static int ad7152_probe(struct i2c_client *client,
-			const struct i2c_device_id *id)
-{
-	int ret = 0;
-	struct ad7152_chip_info *chip;
-	struct iio_dev *indio_dev;
-
-	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*chip));
-	if (!indio_dev)
-		return -ENOMEM;
-	chip = iio_priv(indio_dev);
-	/* this is only used for device removal purposes */
-	i2c_set_clientdata(client, indio_dev);
-
-	chip->client = client;
-	mutex_init(&chip->state_lock);
-
-	/* Establish that the iio_dev is a child of the i2c device */
-	indio_dev->name = id->name;
-	indio_dev->dev.parent = &client->dev;
-	indio_dev->info = &ad7152_info;
-	indio_dev->channels = ad7152_channels;
-	if (id->driver_data == 0)
-		indio_dev->num_channels = ARRAY_SIZE(ad7152_channels);
-	else
-		indio_dev->num_channels = 2;
-	indio_dev->num_channels = ARRAY_SIZE(ad7152_channels);
-	indio_dev->modes = INDIO_DIRECT_MODE;
-
-	ret = devm_iio_device_register(indio_dev->dev.parent, indio_dev);
-	if (ret)
-		return ret;
-
-	dev_err(&client->dev, "%s capacitive sensor registered\n", id->name);
-
-	return 0;
-}
-
-static const struct i2c_device_id ad7152_id[] = {
-	{ "ad7152", 0 },
-	{ "ad7153", 1 },
-	{}
-};
-
-MODULE_DEVICE_TABLE(i2c, ad7152_id);
-
-static struct i2c_driver ad7152_driver = {
-	.driver = {
-		.name = KBUILD_MODNAME,
-	},
-	.probe = ad7152_probe,
-	.id_table = ad7152_id,
-};
-module_i2c_driver(ad7152_driver);
-
-MODULE_AUTHOR("Barry Song <21cnbao@gmail.com>");
-MODULE_DESCRIPTION("Analog Devices AD7152/3 capacitive sensor driver");
-MODULE_LICENSE("GPL v2");
-- 
2.17.1

