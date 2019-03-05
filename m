Return-Path: <SRS0=yggj=RI=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E813C43381
	for <linux-iio@archiver.kernel.org>; Tue,  5 Mar 2019 07:36:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5C1D20848
	for <linux-iio@archiver.kernel.org>; Tue,  5 Mar 2019 07:36:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="t/hQauZq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726085AbfCEHgt (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Tue, 5 Mar 2019 02:36:49 -0500
Received: from mail.hundeboll.net ([88.198.92.70]:57486 "EHLO
        mail.hundeboll.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726045AbfCEHgt (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 5 Mar 2019 02:36:49 -0500
Received: from localhost.localdomain (unknown [95.138.208.137])
        by mail.hundeboll.net (Postfix) with ESMTPSA id B9D581C3D7D;
        Tue,  5 Mar 2019 08:36:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com;
        s=hundeboll; t=1551771406;
        bh=VNP2BHh7zU9Cor0apuGeh5EUXykDLS2wzi2ptU9+xRc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=t/hQauZq37tOaxonfOoRAMxw8pUwNmA86ZOc1P1H3YmJmTCTv0WRUQzeYBEKsJZmG
         32y1WpN45q36S8vUPxqcknEWHmj1r/iRRA4Y7PVqT8+F3I89gO3wE4YAc0fV2xouMo
         wZYSM/fqXsu410wWV2i7ua7PEzAauMgnPrZWVM4vj8PGst+GM+/DA6k3c/GBsPtKRy
         lj8vRVCAJDNKAbjZFU5vfSn35mQ1I2+O+AbFdxAW3WYlgg/HC46psAG8UfrX+qDcbG
         pDsIbqjE1kU5v/xlAJy0S1QscOfkGcU8qwT9QNJ9w2zPPBKpOq1pZVx818wDoifaTG
         GzweIn553sp0g==
From:   Sean Nyekjaer <sean@geanix.com>
To:     linux-iio@vger.kernel.org
Cc:     Sean Nyekjaer <sean@geanix.com>, jic23@kernel.org
Subject: [PATCH 2/2] iio: dac: ti-dac5571: Update the module author email address
Date:   Tue,  5 Mar 2019 08:36:27 +0100
Message-Id: <20190305073627.6880-2-sean@geanix.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190305073627.6880-1-sean@geanix.com>
References: <20190305073627.6880-1-sean@geanix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Update the module author to the current email address

Signed-off-by: Sean Nyekjaer <sean@geanix.com>
---
 drivers/iio/dac/ti-dac5571.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/dac/ti-dac5571.c b/drivers/iio/dac/ti-dac5571.c
index f6dcd8bce2b0..891e9cac019e 100644
--- a/drivers/iio/dac/ti-dac5571.c
+++ b/drivers/iio/dac/ti-dac5571.c
@@ -429,6 +429,6 @@ static struct i2c_driver dac5571_driver = {
 };
 module_i2c_driver(dac5571_driver);
 
-MODULE_AUTHOR("Sean Nyekjaer <sean.nyekjaer@prevas.dk>");
+MODULE_AUTHOR("Sean Nyekjaer <sean@geanix.dk>");
 MODULE_DESCRIPTION("Texas Instruments 8/10/12-bit 1/4-channel DAC driver");
 MODULE_LICENSE("GPL v2");
-- 
2.21.0

