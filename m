Return-Path: <Michael.Hennerich@analog.com>
From: <michael.hennerich@analog.com>
To: greg@kroah.com
CC: linux-iio@vger.kernel.org, drivers@analog.com, jic23@cam.ac.uk,
        Michael Hennerich <michael.hennerich@analog.com>
Subject: [PATCH 2/2] staging: iio: adc: Address mailing list feedback by Jonathan Cameron
Date: Fri, 1 Oct 2010 16:41:52 +0200
Message-ID: <1285944112-25769-2-git-send-email-michael.hennerich@analog.com>
In-Reply-To: <1285944112-25769-1-git-send-email-michael.hennerich@analog.com>
References: <1285944112-25769-1-git-send-email-michael.hennerich@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

From: Michael Hennerich <michael.hennerich@analog.com>

Add missing new line
Fix typo

Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
Acked-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/adc/Makefile |    2 +-
 drivers/staging/iio/adc/ad799x.h |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/iio/adc/Makefile b/drivers/staging/iio/adc/Makefile
index f4aa63a..2094dbd 100644
--- a/drivers/staging/iio/adc/Makefile
+++ b/drivers/staging/iio/adc/Makefile
@@ -9,4 +9,4 @@ obj-$(CONFIG_MAX1363) += max1363.o
 
 ad799x-y := ad799x_core.o
 ad799x-$(CONFIG_AD799X_RING_BUFFER) += ad799x_ring.o
-obj-$(CONFIG_AD799X) += ad799x.o
\ No newline at end of file
+obj-$(CONFIG_AD799X) += ad799x.o
diff --git a/drivers/staging/iio/adc/ad799x.h b/drivers/staging/iio/adc/ad799x.h
index 73f3ec5..2325929 100644
--- a/drivers/staging/iio/adc/ad799x.h
+++ b/drivers/staging/iio/adc/ad799x.h
@@ -124,7 +124,7 @@ struct ad799x_state {
 };
 
 /*
- * TODO: struct ad799x_platform_data needs to go into inlude/linux/iio
+ * TODO: struct ad799x_platform_data needs to go into include/linux/iio
  */
 
 struct ad799x_platform_data {
-- 
1.6.0.2
