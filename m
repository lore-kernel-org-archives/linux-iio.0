Return-Path: <SRS0=6njX=RW=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13B00C43381
	for <linux-iio@archiver.kernel.org>; Tue, 19 Mar 2019 11:38:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C63472085A
	for <linux-iio@archiver.kernel.org>; Tue, 19 Mar 2019 11:38:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="dcWdjAr8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726053AbfCSLis (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Tue, 19 Mar 2019 07:38:48 -0400
Received: from mail-eopbgr790072.outbound.protection.outlook.com ([40.107.79.72]:47200
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726002AbfCSLis (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 19 Mar 2019 07:38:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8ACON4j1tyPYIifoIz66M/+SCebAv25dxifkeMSG1cU=;
 b=dcWdjAr8ob6bAscTFcWH2CSrng9Bt/d1Sm0AUEBJdbfmp3mtfELV9ON620cKYyElTAr+P1KK9MFW1kiGvUEVM8cWITvkZqjL4ZS+pnAoly8keztHQN6/8NDsxH7HH1IAK6A0xaiQUzFSxZ5glm7W4LDNfZBb8PdWO7M5bA3ZM+s=
Received: from CY4PR03CA0019.namprd03.prod.outlook.com (2603:10b6:903:33::29)
 by BN6PR03MB3123.namprd03.prod.outlook.com (2603:10b6:405:44::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1709.13; Tue, 19 Mar
 2019 11:38:05 +0000
Received: from BL2NAM02FT047.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::207) by CY4PR03CA0019.outlook.office365.com
 (2603:10b6:903:33::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1709.13 via Frontend
 Transport; Tue, 19 Mar 2019 11:38:04 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.57)
 smtp.mailfrom=analog.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 BL2NAM02FT047.mail.protection.outlook.com (10.152.77.9) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1730.9
 via Frontend Transport; Tue, 19 Mar 2019 11:38:04 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id x2JBc3Ub005310
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Tue, 19 Mar 2019 04:38:03 -0700
Received: from saturn.analog.com (10.50.1.244) by NWD2HUBCAS7.ad.analog.com
 (10.64.69.107) with Microsoft SMTP Server id 14.3.408.0; Tue, 19 Mar 2019
 07:38:03 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>
CC:     Lars-Peter Clausen <lars@metafoo.de>,
        Alexandru Ardelean <Alexandru.Ardelean@analog.com>
Subject: [PATCH V2] iio: ad_sigma_delta: Properly handle SPI bus locking vs CS assertion
Date:   Tue, 19 Mar 2019 13:37:55 +0200
Message-ID: <20190319113755.8982-1-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(396003)(39860400002)(376002)(346002)(2980300002)(54534003)(189003)(199004)(5660300002)(14444005)(478600001)(53416004)(106002)(44832011)(7696005)(486006)(6666004)(356004)(8676002)(107886003)(51416003)(47776003)(6916009)(2906002)(36756003)(4326008)(2616005)(8936002)(16586007)(316002)(476003)(106466001)(50466002)(48376002)(86362001)(426003)(50226002)(336012)(246002)(126002)(7636002)(305945005)(2351001)(54906003)(186003)(26005)(77096007)(1076003);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR03MB3123;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0d0edd0b-6fd5-4c1d-2862-08d6ac5f5977
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4608103)(4709054)(2017052603328)(7153060);SRVR:BN6PR03MB3123;
X-MS-TrafficTypeDiagnostic: BN6PR03MB3123:
X-Microsoft-Antispam-PRVS: <BN6PR03MB3123BA25EC850C077A8AF43BF9400@BN6PR03MB3123.namprd03.prod.outlook.com>
X-Forefront-PRVS: 0981815F2F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: NFEZ4N7RPKaC8nVv5UFJ79L3Qy4ZLhQptIItuepicRdX6DSzsrie9720lh6lKixNdbXayv0kU7JP3lkMN5UnrVxcrBx/vrdRU8IQNYaGTItaXSLoT6q9KAMfVBHoQzqLldbgmgnpRktyQBd+mQEUlLQAGpY8SbySMMtLlzEsQUjMtoiLzgXQHhJu+RUH3X12wQ7Nyhpr0YtpN5JA46fyk78yoXYVFw9COF3TYiZjVpbyB5HKbQHjJ+1kRM3eT6VWc18y57f7lKbO0D35Urp7RymoCbc/lZNsnFC5+MqcEPL3d813REJmUvrdRIK4UbpmSN3fwXzk1RXReK8owu2YhXTqxzedpT35GJge5BC7pWHwp7RzvuF5CqTCadQOQGZKnB+HaYtZUEVFXcxxlh8dc6ZCrMkA+Yl4mFz4w2GBApk=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2019 11:38:04.1314
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d0edd0b-6fd5-4c1d-2862-08d6ac5f5977
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR03MB3123
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Lars-Peter Clausen <lars@metafoo.de>

For devices from the SigmaDelta family we need to keep CS low when doing a
conversion, since the device will use the MISO line as a interrupt to
indicate that the conversion is complete.

This is why the driver locks the SPI bus and when the SPI bus is locked
keeps as long as a conversion is going on. The current implementation gets
one small detail wrong though. CS is only de-asserted after the SPI bus is
unlocked. This means it is possible for a different SPI device on the same
bus to send a message which would be wrongfully be addressed to the
SigmaDelta device as well. Make sure that the last SPI transfer that is
done while holding the SPI bus lock de-asserts the CS signal.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: Alexandru Ardelean <Alexandru.Ardelean@analog.com>
---

Changelog v1 -> v2:
* added my S-o-B line

 drivers/iio/adc/ad_sigma_delta.c       | 16 +++++++++++-----
 include/linux/iio/adc/ad_sigma_delta.h |  1 +
 2 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/adc/ad_sigma_delta.c b/drivers/iio/adc/ad_sigma_delta.c
index ff5f2da2e1b1..af6cbc683214 100644
--- a/drivers/iio/adc/ad_sigma_delta.c
+++ b/drivers/iio/adc/ad_sigma_delta.c
@@ -62,7 +62,7 @@ int ad_sd_write_reg(struct ad_sigma_delta *sigma_delta, unsigned int reg,
 	struct spi_transfer t = {
 		.tx_buf		= data,
 		.len		= size + 1,
-		.cs_change	= sigma_delta->bus_locked,
+		.cs_change	= sigma_delta->keep_cs_asserted,
 	};
 	struct spi_message m;
 	int ret;
@@ -217,6 +217,7 @@ static int ad_sd_calibrate(struct ad_sigma_delta *sigma_delta,
 
 	spi_bus_lock(sigma_delta->spi->master);
 	sigma_delta->bus_locked = true;
+	sigma_delta->keep_cs_asserted = true;
 	reinit_completion(&sigma_delta->completion);
 
 	ret = ad_sigma_delta_set_mode(sigma_delta, mode);
@@ -234,9 +235,10 @@ static int ad_sd_calibrate(struct ad_sigma_delta *sigma_delta,
 		ret = 0;
 	}
 out:
+	sigma_delta->keep_cs_asserted = false;
+	ad_sigma_delta_set_mode(sigma_delta, AD_SD_MODE_IDLE);
 	sigma_delta->bus_locked = false;
 	spi_bus_unlock(sigma_delta->spi->master);
-	ad_sigma_delta_set_mode(sigma_delta, AD_SD_MODE_IDLE);
 
 	return ret;
 }
@@ -289,6 +291,7 @@ int ad_sigma_delta_single_conversion(struct iio_dev *indio_dev,
 
 	spi_bus_lock(sigma_delta->spi->master);
 	sigma_delta->bus_locked = true;
+	sigma_delta->keep_cs_asserted = true;
 	reinit_completion(&sigma_delta->completion);
 
 	ad_sigma_delta_set_mode(sigma_delta, AD_SD_MODE_SINGLE);
@@ -298,9 +301,6 @@ int ad_sigma_delta_single_conversion(struct iio_dev *indio_dev,
 	ret = wait_for_completion_interruptible_timeout(
 			&sigma_delta->completion, HZ);
 
-	sigma_delta->bus_locked = false;
-	spi_bus_unlock(sigma_delta->spi->master);
-
 	if (ret == 0)
 		ret = -EIO;
 	if (ret < 0)
@@ -321,7 +321,10 @@ int ad_sigma_delta_single_conversion(struct iio_dev *indio_dev,
 		sigma_delta->irq_dis = true;
 	}
 
+	sigma_delta->keep_cs_asserted = false;
 	ad_sigma_delta_set_mode(sigma_delta, AD_SD_MODE_IDLE);
+	sigma_delta->bus_locked = false;
+	spi_bus_unlock(sigma_delta->spi->master);
 	mutex_unlock(&indio_dev->mlock);
 
 	if (ret)
@@ -358,6 +361,8 @@ static int ad_sd_buffer_postenable(struct iio_dev *indio_dev)
 
 	spi_bus_lock(sigma_delta->spi->master);
 	sigma_delta->bus_locked = true;
+	sigma_delta->keep_cs_asserted = true;
+
 	ret = ad_sigma_delta_set_mode(sigma_delta, AD_SD_MODE_CONTINUOUS);
 	if (ret)
 		goto err_unlock;
@@ -386,6 +391,7 @@ static int ad_sd_buffer_postdisable(struct iio_dev *indio_dev)
 		sigma_delta->irq_dis = true;
 	}
 
+	sigma_delta->keep_cs_asserted = false;
 	ad_sigma_delta_set_mode(sigma_delta, AD_SD_MODE_IDLE);
 
 	sigma_delta->bus_locked = false;
diff --git a/include/linux/iio/adc/ad_sigma_delta.h b/include/linux/iio/adc/ad_sigma_delta.h
index 7e84351fa2c0..6e9fb1932dde 100644
--- a/include/linux/iio/adc/ad_sigma_delta.h
+++ b/include/linux/iio/adc/ad_sigma_delta.h
@@ -69,6 +69,7 @@ struct ad_sigma_delta {
 	bool			irq_dis;
 
 	bool			bus_locked;
+	bool			keep_cs_asserted;
 
 	uint8_t			comm;
 
-- 
2.17.1

