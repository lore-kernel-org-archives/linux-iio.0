Return-Path: <SRS0=108d=UA=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5C5DC28CC1
	for <linux-iio@archiver.kernel.org>; Sat,  1 Jun 2019 21:55:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E177277B4
	for <linux-iio@archiver.kernel.org>; Sat,  1 Jun 2019 21:55:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726211AbfFAVzb (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 1 Jun 2019 17:55:31 -0400
Received: from www17.your-server.de ([213.133.104.17]:54640 "EHLO
        www17.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726149AbfFAVzb (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 1 Jun 2019 17:55:31 -0400
X-Greylist: delayed 1039 seconds by postgrey-1.27 at vger.kernel.org; Sat, 01 Jun 2019 17:55:30 EDT
Received: from [78.46.172.2] (helo=sslproxy05.your-server.de)
        by www17.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <thomas@m3y3r.de>)
        id 1hXBha-0007jK-AF; Sat, 01 Jun 2019 23:38:10 +0200
Received: from [2a02:908:4c22:ec00:915f:2518:d2f6:b586] (helo=localhost.localdomain)
        by sslproxy05.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <thomas@m3y3r.de>)
        id 1hXBha-000HtO-3s; Sat, 01 Jun 2019 23:38:10 +0200
From:   Thomas Meyer <thomas@m3y3r.de>
To:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Thomas Meyer <thomas@m3y3r.de>
Subject: [PATCH] counter: ftm-quaddec: needs HAS_IOMEM
Date:   Sat,  1 Jun 2019 23:38:05 +0200
Message-Id: <20190601213805.32733-1-thomas@m3y3r.de>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: thomas@m3y3r.de
X-Virus-Scanned: Clear (ClamAV 0.100.3/25467/Sat Jun  1 10:00:07 2019)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

the driver fails for UML with:
drivers/counter/ftm-quaddec.c:301: undefined reference to `devm_ioremap'

Fix it by depending on HAS_IOMEM
---
 drivers/counter/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/counter/Kconfig b/drivers/counter/Kconfig
index 138ecd8a8fbd..6298344b536b 100644
--- a/drivers/counter/Kconfig
+++ b/drivers/counter/Kconfig
@@ -50,6 +50,7 @@ config STM32_LPTIMER_CNT
 	  module will be called stm32-lptimer-cnt.
 
 config FTM_QUADDEC
+	depends on HAS_IOMEM
 	tristate "Flex Timer Module Quadrature decoder driver"
 	help
 	  Select this option to enable the Flex Timer Quadrature decoder
-- 
2.21.0

