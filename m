Return-Path: <SRS0=yggj=RI=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51742C00319
	for <linux-iio@archiver.kernel.org>; Tue,  5 Mar 2019 07:36:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FDEC20657
	for <linux-iio@archiver.kernel.org>; Tue,  5 Mar 2019 07:36:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="UePiaVkB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726045AbfCEHgt (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Tue, 5 Mar 2019 02:36:49 -0500
Received: from mail.hundeboll.net ([88.198.92.70]:57480 "EHLO
        mail.hundeboll.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726080AbfCEHgt (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 5 Mar 2019 02:36:49 -0500
Received: from localhost.localdomain (unknown [95.138.208.137])
        by mail.hundeboll.net (Postfix) with ESMTPSA id 820AF1C3D7C;
        Tue,  5 Mar 2019 08:36:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com;
        s=hundeboll; t=1551771406;
        bh=k4pDEgRqdNAp7Ttqt6k3g/ZwWOOGkwqrvjRwJYZHHO4=;
        h=From:To:Cc:Subject:Date;
        b=UePiaVkBNLjNGKHhVtD3/OHFQzlz8HrSEbY6+yk1P3PFfOSoASHS6ylaJf44A6+Gp
         JGXnf5cuzLBl6pQGARyAExc8WD7vY11A/lEYwubWaA0U8BlfP82ISZAnGV8+S8iLzH
         wR8SxPtsmNFHsuvOyY7Kb56Sog5ViFOd0oE69Wuqz32UufSfDjpfRMFhErG5Fjq1xp
         uXDYyffNEzXrXEY0NNPN/rf9uNIPavTocwErKrzyrhyAJTtQd+WHRyiMgEOx4K4xoY
         Iv0HJsbqZB3pusihBXZB+Md24YryzuheMUFbXQo41/gQIdfUbLmdIkAjWtMNi8cfjR
         oJEv3KrlrtNXQ==
From:   Sean Nyekjaer <sean@geanix.com>
To:     linux-iio@vger.kernel.org
Cc:     Sean Nyekjaer <sean@geanix.com>, jic23@kernel.org
Subject: [PATCH 1/2] iio: adc: ti-ads8688: Update the module author email address
Date:   Tue,  5 Mar 2019 08:36:26 +0100
Message-Id: <20190305073627.6880-1-sean@geanix.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Update the module author to the current email address.

Signed-off-by: Sean Nyekjaer <sean@geanix.com>
---
 drivers/iio/adc/ti-ads8688.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ti-ads8688.c b/drivers/iio/adc/ti-ads8688.c
index 8b4568edd5cb..f9461070a74a 100644
--- a/drivers/iio/adc/ti-ads8688.c
+++ b/drivers/iio/adc/ti-ads8688.c
@@ -523,6 +523,6 @@ static struct spi_driver ads8688_driver = {
 };
 module_spi_driver(ads8688_driver);
 
-MODULE_AUTHOR("Sean Nyekjaer <sean.nyekjaer@prevas.dk>");
+MODULE_AUTHOR("Sean Nyekjaer <sean@geanix.dk>");
 MODULE_DESCRIPTION("Texas Instruments ADS8688 driver");
 MODULE_LICENSE("GPL v2");
-- 
2.21.0

