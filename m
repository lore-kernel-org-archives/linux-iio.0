Return-Path: <robert.dolca@intel.com>
From: Robert Dolca <robert.dolca@intel.com>
To: linux-iio@vger.kernel.org,
	Jonathan Cameron <jic23@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Robert Dolca <robert.dolca@intel.com>,
	Denis CIOCCA <denis.ciocca@st.com>
Subject: [PATCH RFC 2/3] iio: Improve iio_trigger_register_with_dev to register trigger after device
Date: Thu, 16 Apr 2015 12:01:07 +0300
Message-Id: <1429174868-11953-3-git-send-email-robert.dolca@intel.com>
In-Reply-To: <1429174868-11953-1-git-send-email-robert.dolca@intel.com>
References: <1429174868-11953-1-git-send-email-robert.dolca@intel.com>
List-ID: <linux-iio@vger.kernel.org>

Until now calling iio_trigger_register_with_dev after registering the IIO device
added the trigger to the device's trigger list and saved a reference to the
device in the trigger's struct but it did not create the symlink.

In order to know if the device was registered or not this patch adds a flag
in the dev_iio struct and checks it when iio_trigger_register_with_dev is
called.

Signed-off-by: Robert Dolca <robert.dolca@intel.com>
---
 drivers/iio/industrialio-core.c    | 4 ++++
 drivers/iio/industrialio-trigger.c | 6 ++++++
 include/linux/iio/iio.h            | 1 +
 3 files changed, 11 insertions(+)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index 94bcd54..04862a4 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -1233,6 +1233,8 @@ int iio_device_register(struct iio_dev *indio_dev)
 			goto error_cdev_del;
 	}
 
+	indio_dev->registered = true;
+
 	return 0;
 error_cdev_del:
 	cdev_del(&indio_dev->chrdev);
@@ -1281,6 +1283,8 @@ void iio_device_unregister(struct iio_dev *indio_dev)
 	mutex_unlock(&indio_dev->info_exist_lock);
 
 	iio_buffer_free_sysfs_and_mask(indio_dev);
+
+	indio_dev->registered = false;
 }
 EXPORT_SYMBOL(iio_device_unregister);
 
diff --git a/drivers/iio/industrialio-trigger.c b/drivers/iio/industrialio-trigger.c
index cebdd10..d4118fe 100644
--- a/drivers/iio/industrialio-trigger.c
+++ b/drivers/iio/industrialio-trigger.c
@@ -69,6 +69,12 @@ int iio_trigger_register_with_dev(struct iio_dev *indio_dev,
 	trig_info->indio_dev = indio_dev;
 	list_add(&trig_info->indio_dev_list, &indio_dev->triggers);
 
+	if (indio_dev->registered) {
+		ret = iio_trigger_link(trig_info);
+		if (ret < 0)
+			goto error;
+	}
+
 	return 0;
 error:
 	return ret;
diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
index 9ff54ef..3f704ae 100644
--- a/include/linux/iio/iio.h
+++ b/include/linux/iio/iio.h
@@ -496,6 +496,7 @@ struct iio_dev {
 	unsigned			cached_reg_addr;
 #endif
 	struct list_head		triggers;
+	bool				registered;
 };
 
 const struct iio_chan_spec
-- 
1.9.1
