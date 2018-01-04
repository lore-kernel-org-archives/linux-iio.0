Return-Path: <SRS0=B/GZ=D7=gmail.com=aishpant@kernel.org>
Date: Thu, 4 Jan 2018 20:07:35 +0530
From: Aishwarya Pant <aishpant@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Julia Lawall <julia.lawall@lip6.fr>, Joe Perches <joe@perches.com>
Subject: [PATCH 2/5] iio: core: use permission specific variants of
 DEVICE_ATTR
Message-ID: <d77ed162ab90106a146cf45dcceb77f10b055f9a.1515076155.git.aishpant@gmail.com>
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
 drivers/iio/industrialio-core.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index 19bdf3d2962a..d2ac544f192d 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -1253,7 +1253,7 @@ void iio_free_chan_devattr_list(struct list_head *attr_list)
 	}
 }
 
-static ssize_t iio_show_dev_name(struct device *dev,
+static ssize_t name_show(struct device *dev,
 				 struct device_attribute *attr,
 				 char *buf)
 {
@@ -1261,9 +1261,9 @@ static ssize_t iio_show_dev_name(struct device *dev,
 	return snprintf(buf, PAGE_SIZE, "%s\n", indio_dev->name);
 }
 
-static DEVICE_ATTR(name, S_IRUGO, iio_show_dev_name, NULL);
+static DEVICE_ATTR_RO(name);
 
-static ssize_t iio_show_timestamp_clock(struct device *dev,
+static ssize_t current_timestamp_clock_show(struct device *dev,
 					struct device_attribute *attr,
 					char *buf)
 {
@@ -1309,7 +1309,7 @@ static ssize_t iio_show_timestamp_clock(struct device *dev,
 	return sz;
 }
 
-static ssize_t iio_store_timestamp_clock(struct device *dev,
+static ssize_t current_timestamp_clock_store(struct device *dev,
 					 struct device_attribute *attr,
 					 const char *buf, size_t len)
 {
@@ -1340,8 +1340,7 @@ static ssize_t iio_store_timestamp_clock(struct device *dev,
 	return len;
 }
 
-static DEVICE_ATTR(current_timestamp_clock, S_IRUGO | S_IWUSR,
-		   iio_show_timestamp_clock, iio_store_timestamp_clock);
+static DEVICE_ATTR_RW(current_timestamp_clock);
 
 static int iio_device_register_sysfs(struct iio_dev *indio_dev)
 {
-- 
2.15.1
