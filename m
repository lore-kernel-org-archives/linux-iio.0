Return-Path: <SRS0=KJmS=QT=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD63DC282C4
	for <linux-iio@archiver.kernel.org>; Tue, 12 Feb 2019 22:19:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 957B6222C7
	for <linux-iio@archiver.kernel.org>; Tue, 12 Feb 2019 22:19:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731109AbfBLWT5 (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Tue, 12 Feb 2019 17:19:57 -0500
Received: from tr-host.de ([138.201.124.202]:43494 "EHLO kolab.tr-host.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726654AbfBLWT4 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 12 Feb 2019 17:19:56 -0500
X-Greylist: delayed 467 seconds by postgrey-1.27 at vger.kernel.org; Tue, 12 Feb 2019 17:19:56 EST
Received: from localhost (localhost [127.0.0.1])
        by kolab.tr-host.de (Postfix) with ESMTP id 554462B74CD6;
        Tue, 12 Feb 2019 23:12:08 +0100 (CET)
X-Virus-Scanned: amavisd-new at example.com
Received: from kolab.tr-host.de ([127.0.0.1])
        by localhost (kolab.tr-host.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 05dpsKSIr37U; Tue, 12 Feb 2019 23:12:07 +0100 (CET)
Received: from localhost.localdomain (HSI-KBW-046-005-255-234.hsi8.kabel-badenwuerttemberg.de [46.5.255.234])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: leonard.pollak@tr-host.de)
        by kolab.tr-host.de (Postfix) with ESMTPSA id 7767A2B74CD1;
        Tue, 12 Feb 2019 23:12:07 +0100 (CET)
From:   Leonard Pollak <leonardp@tr-host.de>
To:     jic23@kernel.org, lars@metafoo.de, pmeerw@pmeerw.net,
        Michael.hennerich@analog.com
Cc:     linux-iio@vger.kernel.org, Leonard Pollak <leonardp@tr-host.de>
Subject: [PATCH] Staging: iio: meter: fixed iio_attr_ipeak pointing to vpeak register
Date:   Tue, 12 Feb 2019 23:11:57 +0100
Message-Id: <20190212221157.8677-1-leonardp@tr-host.de>
X-Mailer: git-send-email 2.17.1
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

---
 drivers/staging/iio/meter/ade7854.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/iio/meter/ade7854.c b/drivers/staging/iio/meter/ade7854.c
index 029c3bf42d4d..07774c000c5a 100644
--- a/drivers/staging/iio/meter/ade7854.c
+++ b/drivers/staging/iio/meter/ade7854.c
@@ -269,7 +269,7 @@ static IIO_DEV_ATTR_VPEAK(0644,
 static IIO_DEV_ATTR_IPEAK(0644,
 		ade7854_read_32bit,
 		ade7854_write_32bit,
-		ADE7854_VPEAK);
+		ADE7854_IPEAK);
 static IIO_DEV_ATTR_APHCAL(0644,
 		ade7854_read_16bit,
 		ade7854_write_16bit,
-- 
2.17.1

