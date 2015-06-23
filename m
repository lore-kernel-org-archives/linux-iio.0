Return-Path: <cristina.opriceana@gmail.com>
Date: Tue, 23 Jun 2015 16:34:19 +0300
From: Cristina Opriceana <cristina.opriceana@gmail.com>
To: jic23@kernel.org
Cc: daniel.baluta@intel.com, octavian.purdila@intel.com, lars@metafoo.de,
	pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, cristina.opriceana@gmail.com
Subject: [PATCH v2] iio: Fix parameters in iio_triggered_buffer_setup
Message-ID: <ad6b8f39a9861d58cbf4c753d1499675e1500bef.1435065212.git.cristina.opriceana@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <linux-iio@vger.kernel.org>

This patch renames the top half handler and the bottom half handler
of iio_triggered_buffer_setup() in accordance with their usage.
The bottom half has been renamed to reflect the fact that it is a
thread based call, compliant with iio_alloc_pollfunc().
The names of the parameters were swapped, thus creating confusion.

Signed-off-by: Cristina Opriceana <cristina.opriceana@gmail.com>
---
Changes in v2:
	- rename params in iio_triggered_buffer_setup() to h and thread
	- make the commit message reflect the changes
 drivers/iio/industrialio-triggered-buffer.c | 12 ++++++------
 include/linux/iio/triggered_buffer.h        |  4 ++--
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/industrialio-triggered-buffer.c b/drivers/iio/industrialio-triggered-buffer.c
index 15a5341..4b2858b 100644
--- a/drivers/iio/industrialio-triggered-buffer.c
+++ b/drivers/iio/industrialio-triggered-buffer.c
@@ -24,8 +24,8 @@ static const struct iio_buffer_setup_ops iio_triggered_buffer_setup_ops = {
 /**
  * iio_triggered_buffer_setup() - Setup triggered buffer and pollfunc
  * @indio_dev:		IIO device structure
- * @pollfunc_bh:	Function which will be used as pollfunc bottom half
- * @pollfunc_th:	Function which will be used as pollfunc top half
+ * @h:			Function which will be used as pollfunc top half
+ * @thread:		Function which will be used as pollfunc bottom half
  * @setup_ops:		Buffer setup functions to use for this device.
  *			If NULL the default setup functions for triggered
  *			buffers will be used.
@@ -42,8 +42,8 @@ static const struct iio_buffer_setup_ops iio_triggered_buffer_setup_ops = {
  * iio_triggered_buffer_cleanup().
  */
 int iio_triggered_buffer_setup(struct iio_dev *indio_dev,
-	irqreturn_t (*pollfunc_bh)(int irq, void *p),
-	irqreturn_t (*pollfunc_th)(int irq, void *p),
+	irqreturn_t (*h)(int irq, void *p),
+	irqreturn_t (*thread)(int irq, void *p),
 	const struct iio_buffer_setup_ops *setup_ops)
 {
 	struct iio_buffer *buffer;
@@ -57,8 +57,8 @@ int iio_triggered_buffer_setup(struct iio_dev *indio_dev,
 
 	iio_device_attach_buffer(indio_dev, buffer);
 
-	indio_dev->pollfunc = iio_alloc_pollfunc(pollfunc_bh,
-						 pollfunc_th,
+	indio_dev->pollfunc = iio_alloc_pollfunc(h,
+						 thread,
 						 IRQF_ONESHOT,
 						 indio_dev,
 						 "%s_consumer%d",
diff --git a/include/linux/iio/triggered_buffer.h b/include/linux/iio/triggered_buffer.h
index c378ebe..f72f70d 100644
--- a/include/linux/iio/triggered_buffer.h
+++ b/include/linux/iio/triggered_buffer.h
@@ -7,8 +7,8 @@ struct iio_dev;
 struct iio_buffer_setup_ops;
 
 int iio_triggered_buffer_setup(struct iio_dev *indio_dev,
-	irqreturn_t (*pollfunc_bh)(int irq, void *p),
-	irqreturn_t (*pollfunc_th)(int irq, void *p),
+	irqreturn_t (*h)(int irq, void *p),
+	irqreturn_t (*thread)(int irq, void *p),
 	const struct iio_buffer_setup_ops *setup_ops);
 void iio_triggered_buffer_cleanup(struct iio_dev *indio_dev);
 
-- 
1.9.1
