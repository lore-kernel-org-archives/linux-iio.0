Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wi0-f195.google.com ([209.85.212.195]:36489 "EHLO
	mail-wi0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752753AbbFKMIu (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 11 Jun 2015 08:08:50 -0400
Date: Thu, 11 Jun 2015 15:06:35 +0300
From: Cristina Opriceana <cristina.opriceana@gmail.com>
To: jic23@kernel.org
Cc: lars@metafoo.de, pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, daniel.baluta@intel.com,
	octavian.purdila@intel.com
Subject: [PATCH] iio: Fix parameters in iio_triggered_buffer_setup
Message-ID: <20150611120635.GA15709@Inspiron>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This patch renames the top half handler and the bottom half handler
of iio_triggered_buffer_setup() in accordance with their usage.
The names of the parameters were swapped, thus creating confusion.

Signed-off-by: Cristina Opriceana <cristina.opriceana@gmail.com>
---
 drivers/iio/industrialio-triggered-buffer.c | 8 ++++----
 include/linux/iio/triggered_buffer.h        | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/industrialio-triggered-buffer.c b/drivers/iio/industrialio-triggered-buffer.c
index 15a5341..fd057e4 100644
--- a/drivers/iio/industrialio-triggered-buffer.c
+++ b/drivers/iio/industrialio-triggered-buffer.c
@@ -24,8 +24,8 @@ static const struct iio_buffer_setup_ops iio_triggered_buffer_setup_ops = {
 /**
  * iio_triggered_buffer_setup() - Setup triggered buffer and pollfunc
  * @indio_dev:		IIO device structure
- * @pollfunc_bh:	Function which will be used as pollfunc bottom half
  * @pollfunc_th:	Function which will be used as pollfunc top half
+ * @pollfunc_bh:	Function which will be used as pollfunc bottom half
  * @setup_ops:		Buffer setup functions to use for this device.
  *			If NULL the default setup functions for triggered
  *			buffers will be used.
@@ -42,8 +42,8 @@ static const struct iio_buffer_setup_ops iio_triggered_buffer_setup_ops = {
  * iio_triggered_buffer_cleanup().
  */
 int iio_triggered_buffer_setup(struct iio_dev *indio_dev,
-	irqreturn_t (*pollfunc_bh)(int irq, void *p),
 	irqreturn_t (*pollfunc_th)(int irq, void *p),
+	irqreturn_t (*pollfunc_bh)(int irq, void *p),
 	const struct iio_buffer_setup_ops *setup_ops)
 {
 	struct iio_buffer *buffer;
@@ -57,8 +57,8 @@ int iio_triggered_buffer_setup(struct iio_dev *indio_dev,
 
 	iio_device_attach_buffer(indio_dev, buffer);
 
-	indio_dev->pollfunc = iio_alloc_pollfunc(pollfunc_bh,
-						 pollfunc_th,
+	indio_dev->pollfunc = iio_alloc_pollfunc(pollfunc_th,
+						 pollfunc_bh,
 						 IRQF_ONESHOT,
 						 indio_dev,
 						 "%s_consumer%d",
diff --git a/include/linux/iio/triggered_buffer.h b/include/linux/iio/triggered_buffer.h
index c378ebe..f6f70d9 100644
--- a/include/linux/iio/triggered_buffer.h
+++ b/include/linux/iio/triggered_buffer.h
@@ -7,8 +7,8 @@ struct iio_dev;
 struct iio_buffer_setup_ops;
 
 int iio_triggered_buffer_setup(struct iio_dev *indio_dev,
-	irqreturn_t (*pollfunc_bh)(int irq, void *p),
 	irqreturn_t (*pollfunc_th)(int irq, void *p),
+	irqreturn_t (*pollfunc_bh)(int irq, void *p),
 	const struct iio_buffer_setup_ops *setup_ops);
 void iio_triggered_buffer_cleanup(struct iio_dev *indio_dev);
 
-- 
1.9.1

