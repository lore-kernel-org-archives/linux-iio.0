Return-Path: <SRS0=B/GZ=D7=gmail.com=aishpant@kernel.org>
Date: Thu, 4 Jan 2018 20:08:24 +0530
From: Aishwarya Pant <aishpant@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Julia Lawall <julia.lawall@lip6.fr>, Joe Perches <joe@perches.com>
Subject: [PATCH 4/5] iio: hrtimer: use permission specific variants of
 DEVICE_ATTR
Message-ID: <47783f7461de4a8f3487f97ced85bc98163c8b20.1515076155.git.aishpant@gmail.com>
References: <cover.1515076155.git.aishpant@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <cover.1515076155.git.aishpant@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

This is a clean-up patch which replaces DEVICE_ATTR macro with the file
permission specific DEVICE_ATTR_{RO/WO/RW} macros for compaction and
readability. Done using coccinelle.

Signed-off-by: Aishwarya Pant <aishpant@gmail.com>
---
 drivers/iio/trigger/iio-trig-hrtimer.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/trigger/iio-trig-hrtimer.c b/drivers/iio/trigger/iio-trig-hrtimer.c
index 7accd0187ba1..57e46669a5fb 100644
--- a/drivers/iio/trigger/iio-trig-hrtimer.c
+++ b/drivers/iio/trigger/iio-trig-hrtimer.c
@@ -35,7 +35,7 @@ static const struct config_item_type iio_hrtimer_type = {
 };
 
 static
-ssize_t iio_hrtimer_show_sampling_frequency(struct device *dev,
+ssize_t sampling_frequency_show(struct device *dev,
 					    struct device_attribute *attr,
 					    char *buf)
 {
@@ -46,7 +46,7 @@ ssize_t iio_hrtimer_show_sampling_frequency(struct device *dev,
 }
 
 static
-ssize_t iio_hrtimer_store_sampling_frequency(struct device *dev,
+ssize_t sampling_frequency_store(struct device *dev,
 					     struct device_attribute *attr,
 					     const char *buf, size_t len)
 {
@@ -68,9 +68,7 @@ ssize_t iio_hrtimer_store_sampling_frequency(struct device *dev,
 	return len;
 }
 
-static DEVICE_ATTR(sampling_frequency, S_IRUGO | S_IWUSR,
-		   iio_hrtimer_show_sampling_frequency,
-		   iio_hrtimer_store_sampling_frequency);
+static DEVICE_ATTR_RW(sampling_frequency);
 
 static struct attribute *iio_hrtimer_attrs[] = {
 	&dev_attr_sampling_frequency.attr,
-- 
2.15.1
