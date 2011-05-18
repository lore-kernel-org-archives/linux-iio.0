Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-52.csi.cam.ac.uk ([131.111.8.152]:53876 "EHLO
	ppsw-52.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933161Ab1ERNkD (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 18 May 2011 09:40:03 -0400
From: Jonathan Cameron <jic23@cam.ac.uk>
To: greg@kroah.com
Cc: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 009/111] staging:iio: Push interrupt setup down into the drivers for event lines.
Date: Wed, 18 May 2011 14:40:59 +0100
Message-Id: <1305726161-5606-10-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1305726161-5606-1-git-send-email-jic23@cam.ac.uk>
References: <1305726161-5606-1-git-send-email-jic23@cam.ac.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

It is much easier to do in driver, and the core does not add much.
Note all drivers will have to be updated with this patch.
None currently are.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/iio.h               |    3 +++
 drivers/staging/iio/industrialio-core.c |   17 +++--------------
 2 files changed, 6 insertions(+), 14 deletions(-)

diff --git a/drivers/staging/iio/iio.h b/drivers/staging/iio/iio.h
index 7e44639..cd5ac59 100644
--- a/drivers/staging/iio/iio.h
+++ b/drivers/staging/iio/iio.h
@@ -12,6 +12,7 @@
 
 #include <linux/device.h>
 #include <linux/cdev.h>
+#include <linux/irq.h>
 #include "sysfs.h"
 #include "chrdev.h"
 
@@ -376,6 +377,8 @@ void iio_unregister_interrupt_line(struct iio_dev *dev_info,
 				   int line_number);
 
 
+/* temporarily exported to allow moving of interrupt requesting into drivers */
+irqreturn_t iio_interrupt_handler(int irq, void *_int_info);
 
 /**
  * iio_push_event() - try to add event to the list for userspace reading
diff --git a/drivers/staging/iio/industrialio-core.c b/drivers/staging/iio/industrialio-core.c
index 9ddd6a6..136ff04 100644
--- a/drivers/staging/iio/industrialio-core.c
+++ b/drivers/staging/iio/industrialio-core.c
@@ -134,7 +134,7 @@ int iio_push_event(struct iio_dev *dev_info,
 EXPORT_SYMBOL(iio_push_event);
 
 /* Generic interrupt line interrupt handler */
-static irqreturn_t iio_interrupt_handler(int irq, void *_int_info)
+irqreturn_t iio_interrupt_handler(int irq, void *_int_info)
 {
 	struct iio_interrupt *int_info = _int_info;
 	struct iio_dev *dev_info = int_info->dev_info;
@@ -157,6 +157,7 @@ static irqreturn_t iio_interrupt_handler(int irq, void *_int_info)
 
 	return IRQ_HANDLED;
 }
+EXPORT_SYMBOL(iio_interrupt_handler);
 
 static struct iio_interrupt *iio_allocate_interrupt(void)
 {
@@ -175,7 +176,7 @@ int iio_register_interrupt_line(unsigned int irq,
 				unsigned long type,
 				const char *name)
 {
-	int ret;
+	int ret = 0;
 
 	dev_info->interrupts[line_number] = iio_allocate_interrupt();
 	if (dev_info->interrupts[line_number] == NULL) {
@@ -186,16 +187,6 @@ int iio_register_interrupt_line(unsigned int irq,
 	dev_info->interrupts[line_number]->irq = irq;
 	dev_info->interrupts[line_number]->dev_info = dev_info;
 
-	/* Possibly only request on demand?
-	 * Can see this may complicate the handling of interrupts.
-	 * However, with this approach we might end up handling lots of
-	 * events no-one cares about.*/
-	ret = request_irq(irq,
-			  &iio_interrupt_handler,
-			  type,
-			  name,
-			  dev_info->interrupts[line_number]);
-
 error_ret:
 	return ret;
 }
@@ -215,8 +206,6 @@ void iio_unregister_interrupt_line(struct iio_dev *dev_info, int line_number)
 {
 	/* make sure the interrupt handlers are all done */
 	flush_scheduled_work();
-	free_irq(dev_info->interrupts[line_number]->irq,
-		 dev_info->interrupts[line_number]);
 	kfree(dev_info->interrupts[line_number]);
 }
 EXPORT_SYMBOL(iio_unregister_interrupt_line);
-- 
1.7.3.4

