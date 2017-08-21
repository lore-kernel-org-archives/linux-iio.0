Return-Path: <SRS0=9oGh=7X=oracle.com=dan.carpenter@kernel.org>
Date: Mon, 21 Aug 2017 13:11:03 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] iio staging: tsl2x7x: clean up limit checks
Message-ID: <20170821101103.sysrgce7qgzn2ltx@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <linux-iio@vger.kernel.org>

The second part of this patch is probably the most interesting.  We
use "TSL2X7X_MAX_LUX_TABLE_SIZE * 3" as the limit instead of just
"TSL2X7X_MAX_LUX_TABLE_SIZE".  It creates a static checker warning that
we are going of of bounds, but in real life we always hit the break
statement on the last element so it's fine.

The situation is that we normally have arrays with 3 elements of struct
tsl2x7x_lux which has 3 unsigned integers.  If we load the table with
sysfs then we're allow to have 9 elements instead.

So the size of the default table in bytes is sizeof(int) times 3 struct
members times 3 elements.  The original code wrote it as sizeof(int)
times the number of elements in the bigger table (9).  It happens that
9 is the same thing as 3 * 3 but expressing it that way is misleading.

For the second part of the patch, the original code just had an extra
"multiply by three" and now that is removed.  The last element in the
array is always zeroed memory whether this uses the default tables or it
gets loaded with sysfs so we always hit the break statement anyway.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/staging/iio/light/tsl2x7x.h b/drivers/staging/iio/light/tsl2x7x.h
index ecae92211216..1beb8d2eb848 100644
--- a/drivers/staging/iio/light/tsl2x7x.h
+++ b/drivers/staging/iio/light/tsl2x7x.h
@@ -23,10 +23,6 @@
 #define __TSL2X7X_H
 #include <linux/pm.h>
 
-/* Max number of segments allowable in LUX table */
-#define TSL2X7X_MAX_LUX_TABLE_SIZE		9
-#define MAX_DEFAULT_TABLE_BYTES (sizeof(int) * TSL2X7X_MAX_LUX_TABLE_SIZE)
-
 struct iio_dev;
 
 struct tsl2x7x_lux {
@@ -35,6 +31,11 @@ struct tsl2x7x_lux {
 	unsigned int ch1;
 };
 
+/* Max number of segments allowable in LUX table */
+#define TSL2X7X_MAX_LUX_TABLE_SIZE		9
+/* The default tables are all 3 elements */
+#define MAX_DEFAULT_TABLE_BYTES (sizeof(struct tsl2x7x_lux) * 3)
+
 /**
  * struct tsl2x7x_default_settings - power on defaults unless
  *                                   overridden by platform data.
diff --git a/drivers/staging/iio/light/tsl2x7x.c b/drivers/staging/iio/light/tsl2x7x.c
index 786e93f16ce9..2db1715ff659 100644
--- a/drivers/staging/iio/light/tsl2x7x.c
+++ b/drivers/staging/iio/light/tsl2x7x.c
@@ -1113,7 +1113,7 @@ static ssize_t in_illuminance0_lux_table_show(struct device *dev,
 	int i = 0;
 	int offset = 0;
 
-	while (i < (TSL2X7X_MAX_LUX_TABLE_SIZE * 3)) {
+	while (i < TSL2X7X_MAX_LUX_TABLE_SIZE) {
 		offset += snprintf(buf + offset, PAGE_SIZE, "%u,%u,%u,",
 			chip->tsl2x7x_device_lux[i].ratio,
 			chip->tsl2x7x_device_lux[i].ch0,
