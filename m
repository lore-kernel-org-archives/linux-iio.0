Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-243.synserver.de ([212.40.185.243]:1035 "EHLO
	smtp-out-240.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S932694Ab3CGTv2 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 7 Mar 2013 14:51:28 -0500
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH] iio: events: Make iio_push_event() IRQ context save
Date: Thu,  7 Mar 2013 20:53:06 +0100
Message-Id: <1362685986-18966-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Currently it is not save to call iio_push_event() from hard IRQ context since
the IIO event code uses spin_lock()/spin_unlock() and it is not save to mix
calls to spin_lock()/spin_unlock() from different contexts on the same lock.
E.g. if the lock is being held in iio_event_chrdev_read() and an interrupts
kicks in and the interrupt handler calls iio_push_event() we end uo with a
deadlock.

This patch updates iio_push_event() to use spin_lock_irqsave()/
spin_unlock_irqstrestore(), since it can be called from both IRQ and non-IRQ
context. All other other users of the lock, which are always run in non-IRQ
context, are updated to spin_lock_irq()/spin_unlock_irq().

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>

---
As far as I can see all current callers of iio_push_event() run in non-IRQ
context, so this doesn't need to applied to the fixes branch.
---
 drivers/iio/industrialio-event.c | 29 +++++++++++++++--------------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/drivers/iio/industrialio-event.c b/drivers/iio/industrialio-event.c
index 261cae0..10aa9ef8 100644
--- a/drivers/iio/industrialio-event.c
+++ b/drivers/iio/industrialio-event.c
@@ -46,10 +46,11 @@ int iio_push_event(struct iio_dev *indio_dev, u64 ev_code, s64 timestamp)
 {
 	struct iio_event_interface *ev_int = indio_dev->event_interface;
 	struct iio_event_data ev;
+	unsigned long flags;
 	int copied;
 
 	/* Does anyone care? */
-	spin_lock(&ev_int->wait.lock);
+	spin_lock_irqsave(&ev_int->wait.lock, flags);
 	if (test_bit(IIO_BUSY_BIT_POS, &ev_int->flags)) {
 
 		ev.id = ev_code;
@@ -59,7 +60,7 @@ int iio_push_event(struct iio_dev *indio_dev, u64 ev_code, s64 timestamp)
 		if (copied != 0)
 			wake_up_locked_poll(&ev_int->wait, POLLIN);
 	}
-	spin_unlock(&ev_int->wait.lock);
+	spin_unlock_irqrestore(&ev_int->wait.lock, flags);
 
 	return 0;
 }
@@ -76,10 +77,10 @@ static unsigned int iio_event_poll(struct file *filep,
 
 	poll_wait(filep, &ev_int->wait, wait);
 
-	spin_lock(&ev_int->wait.lock);
+	spin_lock_irq(&ev_int->wait.lock);
 	if (!kfifo_is_empty(&ev_int->det_events))
 		events = POLLIN | POLLRDNORM;
-	spin_unlock(&ev_int->wait.lock);
+	spin_unlock_irq(&ev_int->wait.lock);
 
 	return events;
 }
@@ -96,14 +97,14 @@ static ssize_t iio_event_chrdev_read(struct file *filep,
 	if (count < sizeof(struct iio_event_data))
 		return -EINVAL;
 
-	spin_lock(&ev_int->wait.lock);
+	spin_lock_irq(&ev_int->wait.lock);
 	if (kfifo_is_empty(&ev_int->det_events)) {
 		if (filep->f_flags & O_NONBLOCK) {
 			ret = -EAGAIN;
 			goto error_unlock;
 		}
 		/* Blocking on device; waiting for something to be there */
-		ret = wait_event_interruptible_locked(ev_int->wait,
+		ret = wait_event_interruptible_locked_irq(ev_int->wait,
 					!kfifo_is_empty(&ev_int->det_events));
 		if (ret)
 			goto error_unlock;
@@ -113,7 +114,7 @@ static ssize_t iio_event_chrdev_read(struct file *filep,
 	ret = kfifo_to_user(&ev_int->det_events, buf, count, &copied);
 
 error_unlock:
-	spin_unlock(&ev_int->wait.lock);
+	spin_unlock_irq(&ev_int->wait.lock);
 
 	return ret ? ret : copied;
 }
@@ -122,7 +123,7 @@ static int iio_event_chrdev_release(struct inode *inode, struct file *filep)
 {
 	struct iio_event_interface *ev_int = filep->private_data;
 
-	spin_lock(&ev_int->wait.lock);
+	spin_lock_irq(&ev_int->wait.lock);
 	__clear_bit(IIO_BUSY_BIT_POS, &ev_int->flags);
 	/*
 	 * In order to maintain a clean state for reopening,
@@ -130,7 +131,7 @@ static int iio_event_chrdev_release(struct inode *inode, struct file *filep)
 	 * any new __iio_push_event calls running.
 	 */
 	kfifo_reset_out(&ev_int->det_events);
-	spin_unlock(&ev_int->wait.lock);
+	spin_unlock_irq(&ev_int->wait.lock);
 
 	return 0;
 }
@@ -151,18 +152,18 @@ int iio_event_getfd(struct iio_dev *indio_dev)
 	if (ev_int == NULL)
 		return -ENODEV;
 
-	spin_lock(&ev_int->wait.lock);
+	spin_lock_irq(&ev_int->wait.lock);
 	if (__test_and_set_bit(IIO_BUSY_BIT_POS, &ev_int->flags)) {
-		spin_unlock(&ev_int->wait.lock);
+		spin_unlock_irq(&ev_int->wait.lock);
 		return -EBUSY;
 	}
-	spin_unlock(&ev_int->wait.lock);
+	spin_unlock_irq(&ev_int->wait.lock);
 	fd = anon_inode_getfd("iio:event",
 				&iio_event_chrdev_fileops, ev_int, O_RDONLY);
 	if (fd < 0) {
-		spin_lock(&ev_int->wait.lock);
+		spin_lock_irq(&ev_int->wait.lock);
 		__clear_bit(IIO_BUSY_BIT_POS, &ev_int->flags);
-		spin_unlock(&ev_int->wait.lock);
+		spin_unlock_irq(&ev_int->wait.lock);
 	}
 	return fd;
 }
-- 
1.8.0

