Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:33287 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757302AbcIXQPB (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 24 Sep 2016 12:15:01 -0400
Received: by mail-pf0-f195.google.com with SMTP id q2so6719642pfj.0
        for <linux-iio@vger.kernel.org>; Sat, 24 Sep 2016 09:15:01 -0700 (PDT)
Date: Sat, 24 Sep 2016 21:44:55 +0530
From: Sandhya Bankar <bankarsandhya512@gmail.com>
To: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, linux-iio@vger.kernel.org
Subject: [PATCH v2] drivers: iio: light: Fix sparse warnings
Message-ID: <20160924161455.GA8895@localhost.localdomain>
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
Changes in v2:
* Introducing local variable to do the initial read,
then put it in regval via be16_to_cpu call

 drivers/iio/light/max44000.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/light/max44000.c b/drivers/iio/light/max44000.c
index 6511b20..a144ca3 100644
--- a/drivers/iio/light/max44000.c
+++ b/drivers/iio/light/max44000.c
@@ -204,17 +204,18 @@ static int max44000_write_alspga(struct max44000_data *data, int val)
 static int max44000_read_alsval(struct max44000_data *data)
 {
 	u16 regval;
+	__be16 val;
 	int alstim, ret;
 
 	ret = regmap_bulk_read(data->regmap, MAX44000_REG_ALS_DATA_HI,
-			       &regval, sizeof(regval));
+			       &val, sizeof(val));
 	if (ret < 0)
 		return ret;
 	alstim = ret = max44000_read_alstim(data);
 	if (ret < 0)
 		return ret;
 
-	regval = be16_to_cpu(regval);
+	regval = be16_to_cpu(val);
 
 	/*
 	 * Overflow is explained on datasheet page 17.
-- 
1.8.3.1

