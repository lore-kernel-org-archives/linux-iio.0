Return-Path: <SRS0=UX0i=AJ=oracle.com=dan.carpenter@kernel.org>
Date: Fri, 8 Sep 2017 13:53:43 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Jonathan Cameron <jic23@kernel.org>, Brian Masney <masneyb@onstation.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        simran singhal <singhalsimran0@gmail.com>,
        Eva Rachel Retuya <eraretuya@gmail.com>,
        Enric Balletbo i Serra <eballetbo@gmail.com>,
        Paolo Cretaro <melko@frugalware.org>, linux-iio@vger.kernel.org,
        devel@driverdev.osuosl.org, kernel-janitors@vger.kernel.org
Subject: [PATCH v2] staging: iio: tsl2x7x: clean up limit checks
Message-ID: <20170908105343.tk3j36sgxd7xm222@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170905233123.vfrb4j4bnhtgcrrt@fd32499230b2>
List-ID: <linux-iio@vger.kernel.org>

The background of this code is that we can either use the default
tables or load our own table with sysfs.  The default tables are three
element arrays of struct tsl2x7x_lux.  If we load the table with sysfs
then we can have as many as nine elements.  Which ever way we do it, the
last element is always zeroed out.

The most interesting part of this patch is in the
in_illuminance0_lux_table_show() function.  We were using the wrong
limit, "TSL2X7X_MAX_LUX_TABLE_SIZE * 3", when it should have been just
"TSL2X7X_MAX_LUX_TABLE_SIZE".  This creates a static checker warning
that we are going of of bounds.  However, since the last element is
always zeroed out, that means we hit the break statement and the code
works correctly despite the wrong limit check.

I made several related readability changes.  The most notable that I
changed the MAX_DEFAULT_TABLE_BYTES define which was:

#define MAX_DEFAULT_TABLE_BYTES (sizeof(int) * TSL2X7X_MAX_LUX_TABLE_SIZE)

I renamed the define to TSL2X7X_DEFAULT_TABLE_BYTES because it's not the
max size, it's the only size.  Also the size should really be expressed
as sizeof(struct tsl2x7x_lux) * 3.  In other words, 12 * 3 instead of
4 * 9.  It's 36 bytes either way, so this doesn't change the behavior.

Finally, I created the TSL2X7X_DEF_LUX_TABLE_SZ define instead of using
the magic number 3.  I declared the default tables using that define
to hopefully signal to future programmers that if they want to use a
different size they have to update all the related code.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/staging/iio/light/tsl2x7x.h b/drivers/staging/iio/light/tsl2x7x.h
index ecae92211216..a216c6943a84 100644
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
@@ -35,6 +31,13 @@ struct tsl2x7x_lux {
 	unsigned int ch1;
 };
 
+/* Max number of segments allowable in LUX table */
+#define TSL2X7X_MAX_LUX_TABLE_SIZE		9
+/* The default LUX tables all have 3 elements.  */
+#define TSL2X7X_DEF_LUX_TABLE_SZ		3
+#define TSL2X7X_DEFAULT_TABLE_BYTES (sizeof(struct tsl2x7x_lux) * \
+				     TSL2X7X_DEF_LUX_TABLE_SZ)
+
 /**
  * struct tsl2x7x_default_settings - power on defaults unless
  *                                   overridden by platform data.
diff --git a/drivers/staging/iio/light/tsl2x7x.c b/drivers/staging/iio/light/tsl2x7x.c
index 786e93f16ce9..b3a9efecf536 100644
--- a/drivers/staging/iio/light/tsl2x7x.c
+++ b/drivers/staging/iio/light/tsl2x7x.c
@@ -192,25 +192,25 @@ struct tsl2X7X_chip {
 };
 
 /* Different devices require different coefficents */
-static const struct tsl2x7x_lux tsl2x71_lux_table[] = {
+static const struct tsl2x7x_lux tsl2x71_lux_table[TSL2X7X_DEF_LUX_TABLE_SZ] = {
 	{ 14461,   611,   1211 },
 	{ 18540,   352,    623 },
 	{     0,     0,      0 },
 };
 
-static const struct tsl2x7x_lux tmd2x71_lux_table[] = {
+static const struct tsl2x7x_lux tmd2x71_lux_table[TSL2X7X_DEF_LUX_TABLE_SZ] = {
 	{ 11635,   115,    256 },
 	{ 15536,    87,    179 },
 	{     0,     0,      0 },
 };
 
-static const struct tsl2x7x_lux tsl2x72_lux_table[] = {
+static const struct tsl2x7x_lux tsl2x72_lux_table[TSL2X7X_DEF_LUX_TABLE_SZ] = {
 	{ 14013,   466,   917 },
 	{ 18222,   310,   552 },
 	{     0,     0,     0 },
 };
 
-static const struct tsl2x7x_lux tmd2x72_lux_table[] = {
+static const struct tsl2x7x_lux tmd2x72_lux_table[TSL2X7X_DEF_LUX_TABLE_SZ] = {
 	{ 13218,   130,   262 },
 	{ 17592,   92,    169 },
 	{     0,     0,     0 },
@@ -530,7 +530,7 @@ static void tsl2x7x_defaults(struct tsl2X7X_chip *chip)
 	else
 		memcpy(chip->tsl2x7x_device_lux,
 		(struct tsl2x7x_lux *)tsl2x7x_default_lux_table_group[chip->id],
-				MAX_DEFAULT_TABLE_BYTES);
+				TSL2X7X_DEFAULT_TABLE_BYTES);
 }
 
 /**
@@ -1113,7 +1113,7 @@ static ssize_t in_illuminance0_lux_table_show(struct device *dev,
 	int i = 0;
 	int offset = 0;
 
-	while (i < (TSL2X7X_MAX_LUX_TABLE_SIZE * 3)) {
+	while (i < TSL2X7X_MAX_LUX_TABLE_SIZE) {
 		offset += snprintf(buf + offset, PAGE_SIZE, "%u,%u,%u,",
 			chip->tsl2x7x_device_lux[i].ratio,
 			chip->tsl2x7x_device_lux[i].ch0,
