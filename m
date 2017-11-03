Return-Path: <SRS0=KZD1=CB=users.sourceforge.net=elfring@kernel.org>
To: devel@driverdev.osuosl.org, linux-iio@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Hartmut Knaack <knaack.h@gmx.de>, Jonathan Cameron <jic23@kernel.org>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH] staging: iio: ad7152: Improve unlocking of a mutex in
 ad7152_start_calib()
Message-ID: <eef53bde-ab45-6e5c-8e0d-bd9cf7ebc431@users.sourceforge.net>
Date: Fri, 3 Nov 2017 09:09:21 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-ID: <linux-iio@vger.kernel.org>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 3 Nov 2017 09:00:25 +0100

* Add a jump target so that a call of the function "mutex_unlock" is stored
  only twice in this function implementation.

* Replace two calls by goto statements.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/staging/iio/cdc/ad7152.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/iio/cdc/ad7152.c b/drivers/staging/iio/cdc/ad7152.c
index 61377ca444de..59d1b35f6a4e 100644
--- a/drivers/staging/iio/cdc/ad7152.c
+++ b/drivers/staging/iio/cdc/ad7152.c
@@ -118,22 +118,23 @@ static inline ssize_t ad7152_start_calib(struct device *dev,
 
 	mutex_lock(&chip->state_lock);
 	ret = i2c_smbus_write_byte_data(chip->client, AD7152_REG_CFG, regval);
-	if (ret < 0) {
-		mutex_unlock(&chip->state_lock);
-		return ret;
-	}
+	if (ret < 0)
+		goto unlock;
 
 	do {
 		mdelay(20);
 		ret = i2c_smbus_read_byte_data(chip->client, AD7152_REG_CFG);
-		if (ret < 0) {
-			mutex_unlock(&chip->state_lock);
-			return ret;
-		}
+		if (ret < 0)
+			goto unlock;
+
 	} while ((ret == regval) && timeout--);
 
 	mutex_unlock(&chip->state_lock);
 	return len;
+
+unlock:
+	mutex_unlock(&chip->state_lock);
+	return ret;
 }
 
 static ssize_t ad7152_start_offset_calib(struct device *dev,
-- 
2.15.0
