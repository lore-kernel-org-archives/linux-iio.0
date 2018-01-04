Return-Path: <SRS0=B/GZ=D7=gmail.com=aishpant@kernel.org>
Date: Thu, 4 Jan 2018 20:08:06 +0530
From: Aishwarya Pant <aishpant@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Julia Lawall <julia.lawall@lip6.fr>, Joe Perches <joe@perches.com>
Subject: [PATCH 3/5] iio: trigger: use permission specific variants of
 DEVICE_ATTR
Message-ID: <db4729e909cb8bdcb7328cc822fc79787116f189.1515076155.git.aishpant@gmail.com>
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
 drivers/iio/industrialio-trigger.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/industrialio-trigger.c b/drivers/iio/industrialio-trigger.c
index ce66699c7fcc..d24e49a4bdcc 100644
--- a/drivers/iio/industrialio-trigger.c
+++ b/drivers/iio/industrialio-trigger.c
@@ -39,7 +39,7 @@ static LIST_HEAD(iio_trigger_list);
 static DEFINE_MUTEX(iio_trigger_list_lock);
 
 /**
- * iio_trigger_read_name() - retrieve useful identifying name
+ * name_show() - retrieve useful identifying name
  * @dev:	device associated with the iio_trigger
  * @attr:	pointer to the device_attribute structure that is
  *		being processed
@@ -48,7 +48,7 @@ static DEFINE_MUTEX(iio_trigger_list_lock);
  * Return: a negative number on failure or the number of written
  *	   characters on success.
  */
-static ssize_t iio_trigger_read_name(struct device *dev,
+static ssize_t name_show(struct device *dev,
 				     struct device_attribute *attr,
 				     char *buf)
 {
@@ -56,7 +56,7 @@ static ssize_t iio_trigger_read_name(struct device *dev,
 	return sprintf(buf, "%s\n", trig->name);
 }
 
-static DEVICE_ATTR(name, S_IRUGO, iio_trigger_read_name, NULL);
+static DEVICE_ATTR_RO(name);
 
 static struct attribute *iio_trig_dev_attrs[] = {
 	&dev_attr_name.attr,
@@ -358,7 +358,7 @@ void iio_dealloc_pollfunc(struct iio_poll_func *pf)
 EXPORT_SYMBOL_GPL(iio_dealloc_pollfunc);
 
 /**
- * iio_trigger_read_current() - trigger consumer sysfs query current trigger
+ * current_trigger_show() - trigger consumer sysfs query current trigger
  * @dev:	device associated with an industrial I/O device
  * @attr:	pointer to the device_attribute structure that
  *		is being processed
@@ -370,7 +370,7 @@ EXPORT_SYMBOL_GPL(iio_dealloc_pollfunc);
  * Return: a negative number on failure, the number of characters written
  *	   on success or 0 if no trigger is available
  */
-static ssize_t iio_trigger_read_current(struct device *dev,
+static ssize_t current_trigger_show(struct device *dev,
 					struct device_attribute *attr,
 					char *buf)
 {
@@ -382,7 +382,7 @@ static ssize_t iio_trigger_read_current(struct device *dev,
 }
 
 /**
- * iio_trigger_write_current() - trigger consumer sysfs set current trigger
+ * current_trigger_store() - trigger consumer sysfs set current trigger
  * @dev:	device associated with an industrial I/O device
  * @attr:	device attribute that is being processed
  * @buf:	string buffer that holds the name of the trigger
@@ -395,7 +395,7 @@ static ssize_t iio_trigger_read_current(struct device *dev,
  * Return: negative error code on failure or length of the buffer
  *	   on success
  */
-static ssize_t iio_trigger_write_current(struct device *dev,
+static ssize_t current_trigger_store(struct device *dev,
 					 struct device_attribute *attr,
 					 const char *buf,
 					 size_t len)
@@ -456,9 +456,7 @@ static ssize_t iio_trigger_write_current(struct device *dev,
 	return ret;
 }
 
-static DEVICE_ATTR(current_trigger, S_IRUGO | S_IWUSR,
-		   iio_trigger_read_current,
-		   iio_trigger_write_current);
+static DEVICE_ATTR_RW(current_trigger);
 
 static struct attribute *iio_trigger_consumer_attrs[] = {
 	&dev_attr_current_trigger.attr,
-- 
2.15.1
