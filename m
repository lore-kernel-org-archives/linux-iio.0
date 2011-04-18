Return-Path: <jic23@cam.ac.uk>
Message-ID: <4DAC2BD3.3030209@cam.ac.uk>
Date: Mon, 18 Apr 2011 13:17:23 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@cam.ac.uk>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH 53/70] staging:iio: Add core attribute handling for name
 of device.
References: <1303067203-4894-1-git-send-email-jic23@cam.ac.uk> <1303067203-4894-54-git-send-email-jic23@cam.ac.uk> <4DAB4835.4020606@cam.ac.uk>
In-Reply-To: <4DAB4835.4020606@cam.ac.uk>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

On 04/17/11 21:06, Jonathan Cameron wrote:
> On 04/17/11 20:06, Jonathan Cameron wrote:
>> Saves on a fair bit of code replication.
> I clearly didn't think this through properly.  It can be done much
> more neatly with a single static iio_dev_attr and just explicitly
> adding and removing it.  See the trigger equivalent in the
> iio-onwards tree that I have just pushed.
> 
The following is how I 'should' have done it.

Subject: [PATCH] staging:iio: Add core attribute handling for name of device.

Saves on a fair bit of code replication.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/iio.h               |    2 +-
 drivers/staging/iio/industrialio-core.c |   23 ++++++++++++++++++++++-
 2 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/iio/iio.h b/drivers/staging/iio/iio.h
index b818f5f..febf20e 100644
--- a/drivers/staging/iio/iio.h
+++ b/drivers/staging/iio/iio.h
@@ -231,7 +231,7 @@ struct iio_dev {
 	int num_channels;
 	struct list_head channel_attr_list;
 
-	char *name; /*device name - IMPLEMENT */
+	const char *name;
 	int (*read_raw)(struct iio_dev *indio_dev,
 			struct iio_chan_spec const *chan,
 			int *val,
diff --git a/drivers/staging/iio/industrialio-core.c b/drivers/staging/iio/industrialio-core.c
index 2e2e51d..8ee8f40 100644
--- a/drivers/staging/iio/industrialio-core.c
+++ b/drivers/staging/iio/industrialio-core.c
@@ -611,6 +611,16 @@ static void iio_device_remove_and_free_read_attr(struct iio_dev *dev_info,
 	kfree(p);
 }
 
+static ssize_t iio_show_dev_name(struct device *dev,
+				 struct device_attribute *attr,
+				 char *buf)
+{
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	return sprintf(buf, "%s\n", indio_dev->name);
+}
+
+static DEVICE_ATTR(name, S_IRUGO, iio_show_dev_name, NULL);
+
 static int iio_device_register_sysfs(struct iio_dev *dev_info)
 {
 	int i, ret = 0;
@@ -638,8 +648,15 @@ static int iio_device_register_sysfs(struct iio_dev *dev_info)
 			if (ret < 0)
 				goto error_clear_attrs;
 		}
-
+	if (dev_info->name) {
+		ret = sysfs_add_file_to_group(&dev_info->dev.kobj,
+					      &dev_attr_name.attr,
+					      NULL);
+		if (ret)
+			goto error_clear_attrs;
+	}
 	return 0;
+
 error_clear_attrs:
 	list_for_each_entry_safe(p, n,
 				 &dev_info->channel_attr_list, l) {
@@ -657,6 +674,10 @@ static void iio_device_unregister_sysfs(struct iio_dev *dev_info)
 {
 
 	struct iio_dev_attr *p, *n;
+	if (dev_info->name)
+		sysfs_remove_file_from_group(&dev_info->dev.kobj,
+					     &dev_attr_name.attr,
+					     NULL);
 	list_for_each_entry_safe(p, n, &dev_info->channel_attr_list, l) {
 		list_del(&p->l);
 		iio_device_remove_and_free_read_attr(dev_info, p);
-- 
1.7.3.4
