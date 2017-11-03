Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout.web.de ([212.227.15.14]:50090 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752465AbdKCIea (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 3 Nov 2017 04:34:30 -0400
To: devel@driverdev.osuosl.org, linux-iio@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc: LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH] staging: iio: ad7746: Improve unlocking of a mutex in
 ad7746_start_calib()
Message-ID: <57f5d20b-cc13-07b2-51cf-53704327df27@users.sourceforge.net>
Date: Fri, 3 Nov 2017 09:33:57 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 3 Nov 2017 09:26:28 +0100

* Add a jump target so that a call of the function "mutex_unlock" is stored
  only twice in this function implementation.

* Replace two calls by goto statements.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/staging/iio/cdc/ad7746.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/iio/cdc/ad7746.c b/drivers/staging/iio/cdc/ad7746.c
index a124853a05f0..c4a864725376 100644
--- a/drivers/staging/iio/cdc/ad7746.c
+++ b/drivers/staging/iio/cdc/ad7746.c
@@ -302,23 +302,24 @@ static inline ssize_t ad7746_start_calib(struct device *dev,
 	mutex_lock(&chip->lock);
 	regval |= chip->config;
 	ret = i2c_smbus_write_byte_data(chip->client, AD7746_REG_CFG, regval);
-	if (ret < 0) {
-		mutex_unlock(&chip->lock);
-		return ret;
-	}
+	if (ret < 0)
+		goto unlock;
 
 	do {
 		msleep(20);
 		ret = i2c_smbus_read_byte_data(chip->client, AD7746_REG_CFG);
-		if (ret < 0) {
-			mutex_unlock(&chip->lock);
-			return ret;
-		}
+		if (ret < 0)
+			goto unlock;
+
 	} while ((ret == regval) && timeout--);
 
 	mutex_unlock(&chip->lock);
 
 	return len;
+
+unlock:
+	mutex_unlock(&chip->lock);
+	return ret;
 }
 
 static ssize_t ad7746_start_offset_calib(struct device *dev,
-- 
2.15.0

