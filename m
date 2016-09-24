Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:35210 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750838AbcIXMMT (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 24 Sep 2016 08:12:19 -0400
Received: by mail-pf0-f196.google.com with SMTP id 6so6515574pfl.2
        for <linux-iio@vger.kernel.org>; Sat, 24 Sep 2016 05:12:19 -0700 (PDT)
Date: Sat, 24 Sep 2016 17:42:11 +0530
From: Sandhya Bankar <bankarsandhya512@gmail.com>
To: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, linux-iio@vger.kernel.org
Subject: [PATCH] drivers: iio: light: Fix sparse warnings
Message-ID: <20160924121211.GA12546@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Fixing below warnings:

drivers/iio/light/max44000.c:217:18: warning: cast to restricted __be16
drivers/iio/light/max44000.c:217:18: warning: cast to restricted __be16
drivers/iio/light/max44000.c:217:18: warning: cast to restricted __be16
drivers/iio/light/max44000.c:217:18: warning: cast to restricted __be16

Signed-off-by: Sandhya Bankar <bankarsandhya512@gmail.com>
---
 drivers/iio/light/max44000.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/light/max44000.c b/drivers/iio/light/max44000.c
index 6511b20..1ea9af9 100644
--- a/drivers/iio/light/max44000.c
+++ b/drivers/iio/light/max44000.c
@@ -214,7 +214,7 @@ static int max44000_read_alsval(struct max44000_data *data)
 	if (ret < 0)
 		return ret;
 
-	regval = be16_to_cpu(regval);
+	be16_to_cpus(&regval);
 
 	/*
 	 * Overflow is explained on datasheet page 17.
-- 
1.8.3.1

