Return-Path: <SRS0=6njX=RW=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 188CDC43381
	for <linux-iio@archiver.kernel.org>; Tue, 19 Mar 2019 10:49:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1B5A20857
	for <linux-iio@archiver.kernel.org>; Tue, 19 Mar 2019 10:49:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="EcRWg6jR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726464AbfCSKtH (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Tue, 19 Mar 2019 06:49:07 -0400
Received: from mail-eopbgr750049.outbound.protection.outlook.com ([40.107.75.49]:30694
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726244AbfCSKtH (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 19 Mar 2019 06:49:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NA7kLJCxnAom++EIEy4NHNoZ7UiUhvGzd1LpGrFctH4=;
 b=EcRWg6jRY7Lebur6reyK3b8tJevz0t8L0by+17BiriioXclG1HCrD+KFmRTDfneGVYyK87EeCqiPTIGjyF3Sk4RfFQ30UFRP31R+XN8qURKT9mTINWVZPqssUVBrlczXIgUb+2jNf4BcZtOeGvfNMNucL/wOrxXzUXDoKe2Bn9Y=
Received: from CY1PR03CA0004.namprd03.prod.outlook.com (2603:10b6:600::14) by
 BN6PR03MB3122.namprd03.prod.outlook.com (2603:10b6:405:3c::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.13; Tue, 19 Mar 2019 10:48:24 +0000
Received: from CY1NAM02FT038.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::202) by CY1PR03CA0004.outlook.office365.com
 (2603:10b6:600::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1709.13 via Frontend
 Transport; Tue, 19 Mar 2019 10:48:24 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.57)
 smtp.mailfrom=analog.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 CY1NAM02FT038.mail.protection.outlook.com (10.152.74.217) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1730.9
 via Frontend Transport; Tue, 19 Mar 2019 10:48:23 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id x2JAmM6c022323
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Tue, 19 Mar 2019 03:48:23 -0700
Received: from saturn.analog.com (10.50.1.244) by NWD2HUBCAS7.ad.analog.com
 (10.64.69.107) with Microsoft SMTP Server id 14.3.408.0; Tue, 19 Mar 2019
 06:48:22 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>
CC:     Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH] iio: ad_sigma_delta: Properly handle SPI bus locking vs CS assertion
Date:   Tue, 19 Mar 2019 12:48:20 +0200
Message-ID: <20190319104820.29713-1-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(39860400002)(136003)(376002)(396003)(2980300002)(189003)(199004)(16586007)(77096007)(5660300002)(486006)(36756003)(26005)(2906002)(478600001)(7636002)(305945005)(126002)(476003)(2351001)(2616005)(316002)(6916009)(47776003)(7696005)(336012)(426003)(48376002)(106002)(186003)(51416003)(50466002)(53416004)(1076003)(44832011)(50226002)(8676002)(86362001)(246002)(106466001)(8936002)(356004)(14444005)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR03MB3122;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 625977d3-5b77-4d4e-c921-08d6ac586918
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4608103)(4709054)(2017052603328)(7153060);SRVR:BN6PR03MB3122;
X-MS-TrafficTypeDiagnostic: BN6PR03MB3122:
X-Microsoft-Antispam-PRVS: <BN6PR03MB3122E471DFD5DADD131FC915F9400@BN6PR03MB3122.namprd03.prod.outlook.com>
X-Forefront-PRVS: 0981815F2F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: 6ezJq4sxtuCqyUQHExauE4N+Z242joqZXZ0QSHnPx+EzDleaEkbU/M4EvwHSn/JBdrqEn7EaWkhh76eleprUZcltRS86ODE2fFXXeML7zi6v/41D8TIJz8Src5++IU00ZUhq93YWpiNto7KZdZdWH8KcSYzSCmz7fueskDoszu+Z8ZjBzG23lGWwPH9p033wTt9PelERUlce+Eo10BNA9dOL51aKvmwzyp4IwwDYGHqJz5+LTmpvw2iTIDlbIU2kYyNzUaipfY4ci70xgaiBU9toZpl/88rE5BH6JAIInt0N4rszWDJvcS8nFuP4card/6TLrc7S1ZLJh8uV8jJ3Sia715Lm464hRQ7XsmuwtA4QJZyPgJmOCuhZiHxvkjX3ODPKquuAXNB4lvh4FUd1LKwN+btuN6jkPJa1+MJ9J/A=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2019 10:48:23.7023
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 625977d3-5b77-4d4e-c921-08d6ac586918
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR03MB3122
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
---
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

