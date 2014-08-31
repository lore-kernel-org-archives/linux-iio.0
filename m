Return-Path: <soeren.brinkmann@gmail.com>
From: =?UTF-8?q?S=C3=B6ren=20Brinkmann?= <soeren.brinkmann@gmail.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	linux-iio@vger.kernel.org,
	devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?S=C3=B6ren=20Brinkmann?= <soeren.brinkmann@gmail.com>
Subject: [PATCH] staging: ad7606_core: Fix checkpatch warning
Date: Sat, 30 Aug 2014 23:57:34 -0700
Message-Id: <1409468254-5312-1-git-send-email-soeren.brinkmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

Fix the checkpatch complaint regarding unnecessary line continuation.
  WARNING: Avoid unnecessary line continuations
  #143: FILE: ad7606_core.c:143:

Signed-off-by: Sören Brinkmann <soeren.brinkmann@gmail.com>
---
 drivers/staging/iio/adc/ad7606_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/iio/adc/ad7606_core.c b/drivers/staging/iio/adc/ad7606_core.c
index f0f05f195d2c..bf2c8013134c 100644
--- a/drivers/staging/iio/adc/ad7606_core.c
+++ b/drivers/staging/iio/adc/ad7606_core.c
@@ -140,7 +140,7 @@ static ssize_t ad7606_store_range(struct device *dev,
 	return count;
 }
 
-static IIO_DEVICE_ATTR(in_voltage_range, S_IRUGO | S_IWUSR, \
+static IIO_DEVICE_ATTR(in_voltage_range, S_IRUGO | S_IWUSR,
 		       ad7606_show_range, ad7606_store_range, 0);
 static IIO_CONST_ATTR(in_voltage_range_available, "5000 10000");
 
-- 
2.1.0
