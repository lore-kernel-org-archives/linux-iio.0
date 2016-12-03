Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from m50-134.163.com ([123.125.50.134]:55884 "EHLO m50-134.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750787AbcLCJZs (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 3 Dec 2016 04:25:48 -0500
From: Pan Bian <bianpan2016@163.com>
To: Kevin Tsai <ktsai@capellamicro.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Pan Bian <bianpan2016@163.com>
Subject: [PATCH 1/1] iio: light: fix improper return value
Date: Sat,  3 Dec 2016 17:24:17 +0800
Message-Id: <1480757057-3828-1-git-send-email-bianpan2016@163.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

In function cm3232_reg_init(), it returns 0 even if the last call to
i2c_smbus_write_byte_data() returns a negative value (indicates error).
As a result, the return value may be inconsistent with the execution
status, and the caller of cm3232_reg_init() will not be able to detect
the error. This patch fixes the bug.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=188641

Signed-off-by: Pan Bian <bianpan2016@163.com>
---
 drivers/iio/light/cm3232.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/light/cm3232.c b/drivers/iio/light/cm3232.c
index fe89b68..263e972 100644
--- a/drivers/iio/light/cm3232.c
+++ b/drivers/iio/light/cm3232.c
@@ -119,7 +119,7 @@ static int cm3232_reg_init(struct cm3232_chip *chip)
 	if (ret < 0)
 		dev_err(&chip->client->dev, "Error writing reg_cmd\n");
 
-	return 0;
+	return ret;
 }
 
 /**
-- 
1.9.1


