Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EE99C433ED
	for <linux-iio@archiver.kernel.org>; Tue, 11 May 2021 13:56:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 414C761004
	for <linux-iio@archiver.kernel.org>; Tue, 11 May 2021 13:56:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231472AbhEKN5M (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Tue, 11 May 2021 09:57:12 -0400
Received: from cmccmta2.chinamobile.com ([221.176.66.80]:25454 "EHLO
        cmccmta2.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231401AbhEKN5M (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 11 May 2021 09:57:12 -0400
X-Greylist: delayed 547 seconds by postgrey-1.27 at vger.kernel.org; Tue, 11 May 2021 09:57:11 EDT
Received: from spf.mail.chinamobile.com (unknown[172.16.121.1]) by rmmx-syy-dmz-app08-12008 (RichMail) with SMTP id 2ee8609a8ac6833-09181; Tue, 11 May 2021 21:46:46 +0800 (CST)
X-RM-TRANSID: 2ee8609a8ac6833-09181
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost.localdomain (unknown[112.22.251.112])
        by rmsmtp-syy-appsvr01-12001 (RichMail) with SMTP id 2ee1609a8ac0e2d-e1ea2;
        Tue, 11 May 2021 21:46:46 +0800 (CST)
X-RM-TRANSID: 2ee1609a8ac0e2d-e1ea2
From:   Tang Bin <tangbin@cmss.chinamobile.com>
To:     lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tang Bin <tangbin@cmss.chinamobile.com>,
        Zhang Shengju <zhangshengju@cmss.chinamobile.com>
Subject: [PATCH] iio:adc:ad7766: Fix unnecessary check in ad7766_probe()
Date:   Tue, 11 May 2021 21:47:39 +0800
Message-Id: <20210511134739.948-1-tangbin@cmss.chinamobile.com>
X-Mailer: git-send-email 2.20.1.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

In the function ad7766_probe(), the return value of
devm_iio_device_register() can be zero or ret, Thus it
is unnecessary to repeated check here.

Signed-off-by: Zhang Shengju <zhangshengju@cmss.chinamobile.com>
Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
---
 drivers/iio/adc/ad7766.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/iio/adc/ad7766.c b/drivers/iio/adc/ad7766.c
index b6b6765be..acf56e987 100644
--- a/drivers/iio/adc/ad7766.c
+++ b/drivers/iio/adc/ad7766.c
@@ -291,10 +291,7 @@ static int ad7766_probe(struct spi_device *spi)
 	if (ret)
 		return ret;
 
-	ret = devm_iio_device_register(&spi->dev, indio_dev);
-	if (ret)
-		return ret;
-	return 0;
+	return devm_iio_device_register(&spi->dev, indio_dev);
 }
 
 static const struct spi_device_id ad7766_id[] = {
-- 
2.20.1.windows.1



