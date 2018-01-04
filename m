Return-Path: <SRS0=B/GZ=D7=gmail.com=aishpant@kernel.org>
Date: Thu, 4 Jan 2018 16:28:51 +0530
From: Aishwarya Pant <aishpant@gmail.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org
Cc: Julia Lawall <julia.lawall@lip6.fr>
Subject: [PATCH] staging: iio: trigger: replace device_attr with
 device_attr_rw
Message-ID: <20180104105851.GA10434@mordor.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <linux-iio@vger.kernel.org>

This is a clean-up patch which replaces DEVICE_ATTR() macro with the
file permission specific DEVICE_ATTR_RW() macro for compaction and
readability. Done using coccinelle.

Signed-off-by: Aishwarya Pant <aishpant@gmail.com>
---
 drivers/staging/iio/trigger/iio-trig-bfin-timer.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/iio/trigger/iio-trig-bfin-timer.c b/drivers/staging/iio/trigger/iio-trig-bfin-timer.c
index f389f5cca99d..71f11d7472c0 100644
--- a/drivers/staging/iio/trigger/iio-trig-bfin-timer.c
+++ b/drivers/staging/iio/trigger/iio-trig-bfin-timer.c
@@ -78,9 +78,9 @@ static int iio_bfin_tmr_set_state(struct iio_trigger *trig, bool state)
 	return 0;
 }
 
-static ssize_t iio_bfin_tmr_frequency_store(struct device *dev,
-					    struct device_attribute *attr,
-					    const char *buf, size_t count)
+static ssize_t frequency_store(struct device *dev,
+			       struct device_attribute *attr,
+			       const char *buf, size_t count)
 {
 	struct iio_trigger *trig = to_iio_trigger(dev);
 	struct bfin_tmr_state *st = iio_trigger_get_drvdata(trig);
@@ -116,9 +116,9 @@ static ssize_t iio_bfin_tmr_frequency_store(struct device *dev,
 	return count;
 }
 
-static ssize_t iio_bfin_tmr_frequency_show(struct device *dev,
-					   struct device_attribute *attr,
-					   char *buf)
+static ssize_t frequency_show(struct device *dev,
+			      struct device_attribute *attr,
+			      char *buf)
 {
 	struct iio_trigger *trig = to_iio_trigger(dev);
 	struct bfin_tmr_state *st = iio_trigger_get_drvdata(trig);
@@ -133,8 +133,7 @@ static ssize_t iio_bfin_tmr_frequency_show(struct device *dev,
 	return sprintf(buf, "%lu\n", val);
 }
 
-static DEVICE_ATTR(frequency, 0644, iio_bfin_tmr_frequency_show,
-		   iio_bfin_tmr_frequency_store);
+static DEVICE_ATTR_RW(frequency);
 
 static struct attribute *iio_bfin_tmr_trigger_attrs[] = {
 	&dev_attr_frequency.attr,
-- 
2.15.1
