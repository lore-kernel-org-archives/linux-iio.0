Return-Path: <SRS0=ItX8=AO=gmail.com=himshijain.hj@kernel.org>
Date: Wed, 13 Sep 2017 13:26:27 +0530
From: Himanshi Jain <himshijain.hj@gmail.com>
To: outreachy-kernel@googlegroups.com, lars@metafoo.de,
	Michael.Hennerich@analog.com, jic23@kernel.org, knaack.h@gmx.de,
	pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
	linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org, nick.desaulniers@gmail.com,
	daniel.baluta@gmail.com
Subject: [PATCH 2/2] iio: Use __ATTR_NAMED to allow passing name as string to
 IIO_DEVICE_ATTR_NAMED and change usage to pass string
Message-ID: <490606d70335e84a09ef418cb3cc0dbee6f79c84.1505288677.git.himshijain.hj@gmail.com>
References: <cover.1505288677.git.himshijain.hj@gmail.com>
 <2bc7a124ab925dd2c50aa8c778745d179777d50d.1505288677.git.himshijain.hj@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <2bc7a124ab925dd2c50aa8c778745d179777d50d.1505288677.git.himshijain.hj@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

Add IIO_ATTR_NAMED macro to use __ATTR_NAMED to allow passing name as
string to IIO_DEVICE_ATTR_NAMED. Change current usage of
IIO_DEVICE_ATTR_NAMED to pass name as string.

Signed-off-by: Himanshi Jain <himshijain.hj@gmail.com>
---
 drivers/iio/adc/ad7793.c          | 2 +-
 drivers/staging/iio/adc/ad7192.c  | 2 +-
 drivers/staging/iio/adc/ad7280a.c | 4 ++--
 include/linux/iio/sysfs.h         | 6 +++++-
 4 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/adc/ad7793.c b/drivers/iio/adc/ad7793.c
index e6706a0..d74e324 100644
--- a/drivers/iio/adc/ad7793.c
+++ b/drivers/iio/adc/ad7793.c
@@ -420,7 +420,7 @@ static ssize_t ad7793_show_scale_available(struct device *dev,
 }
 
 static IIO_DEVICE_ATTR_NAMED(in_m_in_scale_available,
-		in_voltage-voltage_scale_available, S_IRUGO,
+		"in_voltage-voltage_scale_available", S_IRUGO,
 		ad7793_show_scale_available, NULL, 0);
 
 static struct attribute *ad7793_attributes[] = {
diff --git a/drivers/staging/iio/adc/ad7192.c b/drivers/staging/iio/adc/ad7192.c
index d11c6de..daff38c 100644
--- a/drivers/staging/iio/adc/ad7192.c
+++ b/drivers/staging/iio/adc/ad7192.c
@@ -341,7 +341,7 @@ static int ad7192_setup(struct ad7192_state *st,
 }
 
 static IIO_DEVICE_ATTR_NAMED(in_v_m_v_scale_available,
-			     in_voltage-voltage_scale_available,
+			     "in_voltage-voltage_scale_available",
 			     0444, ad7192_show_scale_available, NULL, 0);
 
 static IIO_DEVICE_ATTR(in_voltage_scale_available, 0444,
diff --git a/drivers/staging/iio/adc/ad7280a.c b/drivers/staging/iio/adc/ad7280a.c
index f85dde9..fd32e9a 100644
--- a/drivers/staging/iio/adc/ad7280a.c
+++ b/drivers/staging/iio/adc/ad7280a.c
@@ -750,14 +750,14 @@ static irqreturn_t ad7280_event_handler(int irq, void *private)
 }
 
 static IIO_DEVICE_ATTR_NAMED(in_thresh_low_value,
-		in_voltage-voltage_thresh_low_value,
+		"in_voltage-voltage_thresh_low_value",
 		0644,
 		ad7280_read_channel_config,
 		ad7280_write_channel_config,
 		AD7280A_CELL_UNDERVOLTAGE);
 
 static IIO_DEVICE_ATTR_NAMED(in_thresh_high_value,
-		in_voltage-voltage_thresh_high_value,
+		"in_voltage-voltage_thresh_high_value",
 		0644,
 		ad7280_read_channel_config,
 		ad7280_write_channel_config,
diff --git a/include/linux/iio/sysfs.h b/include/linux/iio/sysfs.h
index ce9426c..49c81a4 100644
--- a/include/linux/iio/sysfs.h
+++ b/include/linux/iio/sysfs.h
@@ -55,6 +55,10 @@ struct iio_const_attr {
 	{ .dev_attr = __ATTR(_name, _mode, _show, _store),	\
 	  .address = _addr }
 
+#define IIO_ATTR_NAMED(_name, _mode, _show, _store, _addr)		\
+	{ .dev_attr = __ATTR_NAMED(_name, _mode, _show, _store),	\
+	  .address = _addr }
+
 #define IIO_ATTR_RO(_name, _addr)       \
 	{ .dev_attr = __ATTR_RO(_name), \
 	  .address = _addr }
@@ -85,7 +89,7 @@ struct iio_const_attr {
 
 #define IIO_DEVICE_ATTR_NAMED(_vname, _name, _mode, _show, _store, _addr) \
 	struct iio_dev_attr iio_dev_attr_##_vname			\
-	= IIO_ATTR(_name, _mode, _show, _store, _addr)
+	= IIO_ATTR_NAMED(_name, _mode, _show, _store, _addr)
 
 #define IIO_CONST_ATTR(_name, _string)					\
 	struct iio_const_attr iio_const_attr_##_name			\
-- 
1.9.1
