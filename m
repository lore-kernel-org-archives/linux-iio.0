Return-Path: <jic23@hermes.cam.ac.uk>
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: greg@kroah.com,
	guenter.roeck@ericsson.com,
	khali@linux-fr.org,
	dmitry.torokhov@gmail.com,
	broonie@opensource.wolfsonmicro.com,
	alan@lxorguk.ukuu.org.uk,
	arnd@arndb.de,
	linus.walleij@linaro.org,
	maxime.ripard@free-electrons.com,
	thomas.petazzoni@free-electrons.com,
	zdevai@gmail.com,
	w.sang@pengutronix.de,
	marek.vasut@gmail.com,
	Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 1/6] staging:iio:core set the iio_dev.info pointer to null on unregister under lock.
Date: Wed, 15 Feb 2012 19:48:00 +0000
Message-Id: <1329335285-31006-2-git-send-email-jic23@kernel.org>
In-Reply-To: <1329335285-31006-1-git-send-email-jic23@kernel.org>
References: <1329335285-31006-1-git-send-email-jic23@kernel.org>
Sender: "J.I. Cameron" <jic23@hermes.cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

This prevents use of provider callbacks after it has been unregistered.
Note that all code using this that can be called from a consumer *must*
check the pointer before using and hold the info_exist_lock throughout
the usage of the callbacks in info.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/staging/iio/iio.h               |    2 ++
 drivers/staging/iio/industrialio-core.c |    4 ++++
 2 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/drivers/staging/iio/iio.h b/drivers/staging/iio/iio.h
index be6ced3..478dbe5 100644
--- a/drivers/staging/iio/iio.h
+++ b/drivers/staging/iio/iio.h
@@ -310,6 +310,7 @@ struct iio_buffer_setup_ops {
  * @chan_attr_group:	[INTERN] group for all attrs in base directory
  * @name:		[DRIVER] name of the device.
  * @info:		[DRIVER] callbacks and constant info from driver
+ * @info_exist_lock:	[INTERN] lock to prevent use during removal
  * @chrdev:		[INTERN] associated character device
  * @groups:		[INTERN] attribute groups
  * @groupcounter:	[INTERN] index of next attribute group
@@ -340,6 +341,7 @@ struct iio_dev {
 	struct attribute_group		chan_attr_group;
 	const char			*name;
 	const struct iio_info		*info;
+	struct mutex			info_exist_lock;
 	const struct iio_buffer_setup_ops	*setup_ops;
 	struct cdev			chrdev;
 #define IIO_MAX_GROUPS 6
diff --git a/drivers/staging/iio/industrialio-core.c b/drivers/staging/iio/industrialio-core.c
index e4824fe..3a2d080 100644
--- a/drivers/staging/iio/industrialio-core.c
+++ b/drivers/staging/iio/industrialio-core.c
@@ -594,6 +594,7 @@ struct iio_dev *iio_allocate_device(int sizeof_priv)
 		device_initialize(&dev->dev);
 		dev_set_drvdata(&dev->dev, (void *)dev);
 		mutex_init(&dev->mlock);
+		mutex_init(&dev->info_exist_lock);
 
 		dev->id = ida_simple_get(&iio_ida, 0, 0, GFP_KERNEL);
 		if (dev->id < 0) {
@@ -718,6 +719,9 @@ EXPORT_SYMBOL(iio_device_register);
 
 void iio_device_unregister(struct iio_dev *indio_dev)
 {
+	mutex_lock(&indio_dev->info_exist_lock);
+	indio_dev->info = NULL;
+	mutex_unlock(&indio_dev->info_exist_lock);
 	device_unregister(&indio_dev->dev);
 }
 EXPORT_SYMBOL(iio_device_unregister);
-- 
1.7.8.4
