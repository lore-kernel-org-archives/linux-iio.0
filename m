Return-Path: <mfuzzey@parkeon.com>
Subject: [PATCH] iio: core: Fix double free.
To: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>
From: Martin Fuzzey <mfuzzey@parkeon.com>
Date: Mon, 21 Jul 2014 15:22:15 +0200
Message-ID: <20140721132215.11583.81979.stgit@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-ID: <linux-iio@vger.kernel.org>

When an error occured during event registration memory was freed twice
resulting in kernel memory corruption and a crash in unrelated code.

The problem was caused by
	iio_device_unregister_eventset()
	iio_device_unregister_sysfs()

being called twice, once on the error path and then
again via iio_dev_release().

Fix this by making these two functions idempotent so they
may be called multiple times.

The problem was observed before applying
	78b33216 iio:core: Handle error when mask type is not separate

Signed-off-by: Martin Fuzzey <mfuzzey@parkeon.com>
---
 drivers/iio/industrialio-core.c  |    5 +++--
 drivers/iio/industrialio-event.c |    1 +
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index 4b1f375..fa06197 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -828,8 +828,7 @@ static int iio_device_add_channel_sysfs(struct iio_dev *indio_dev,
  * @attr_list: List of IIO device attributes
  *
  * This function frees the memory allocated for each of the IIO device
- * attributes in the list. Note: if you want to reuse the list after calling
- * this function you have to reinitialize it using INIT_LIST_HEAD().
+ * attributes in the list.
  */
 void iio_free_chan_devattr_list(struct list_head *attr_list)
 {
@@ -837,6 +836,7 @@ void iio_free_chan_devattr_list(struct list_head *attr_list)
 
 	list_for_each_entry_safe(p, n, attr_list, l) {
 		kfree(p->dev_attr.attr.name);
+		list_del(&p->l);
 		kfree(p);
 	}
 }
@@ -917,6 +917,7 @@ static void iio_device_unregister_sysfs(struct iio_dev *indio_dev)
 
 	iio_free_chan_devattr_list(&indio_dev->channel_attr_list);
 	kfree(indio_dev->chan_attr_group.attrs);
+	indio_dev->chan_attr_group.attrs = NULL;
 }
 
 static void iio_dev_release(struct device *device)
diff --git a/drivers/iio/industrialio-event.c b/drivers/iio/industrialio-event.c
index bfbf4d4..ad7a35f 100644
--- a/drivers/iio/industrialio-event.c
+++ b/drivers/iio/industrialio-event.c
@@ -492,6 +492,7 @@ int iio_device_register_eventset(struct iio_dev *indio_dev)
 error_free_setup_event_lines:
 	iio_free_chan_devattr_list(&indio_dev->event_interface->dev_attr_list);
 	kfree(indio_dev->event_interface);
+	indio_dev->event_interface = NULL;
 	return ret;
 }
 
