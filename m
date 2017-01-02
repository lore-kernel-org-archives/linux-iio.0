Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from tarvos.retrosnub.co.uk ([217.168.153.95]:60334 "EHLO
        tarvos.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933924AbdABT25 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 2 Jan 2017 14:28:57 -0500
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: Daniel Baluta <daniel.baluta@gmail.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 05/11] iio:buffers: Push some docs down into the .c file.
Date: Mon,  2 Jan 2017 19:28:28 +0000
Message-Id: <20170102192834.26546-6-jic23@kernel.org>
In-Reply-To: <20170102192834.26546-1-jic23@kernel.org>
References: <20170102192834.26546-1-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Ancient legacy of me doing it wrong which it is nice to clear
up whilst we are here.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/iio/industrialio-buffer.c | 5 +++++
 include/linux/iio/buffer.h        | 5 -----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
index 5eb991b24dff..0067e184c9ae 100644
--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -1384,6 +1384,11 @@ static int iio_push_to_buffer(struct iio_buffer *buffer, const void *data)
 	return 0;
 }
 
+/**
+ * iio_push_to_buffers() - push to a registered buffer.
+ * @indio_dev:		iio_dev structure for device.
+ * @data:		Full scan.
+ */
 int iio_push_to_buffers(struct iio_dev *indio_dev, const void *data)
 {
 	int ret;
diff --git a/include/linux/iio/buffer.h b/include/linux/iio/buffer.h
index 635aa87eb5e9..cd77ed14eb7f 100644
--- a/include/linux/iio/buffer.h
+++ b/include/linux/iio/buffer.h
@@ -161,11 +161,6 @@ int iio_update_buffers(struct iio_dev *indio_dev,
  **/
 void iio_buffer_init(struct iio_buffer *buffer);
 
-/**
- * iio_push_to_buffers() - push to a registered buffer.
- * @indio_dev:		iio_dev structure for device.
- * @data:		Full scan.
- */
 int iio_push_to_buffers(struct iio_dev *indio_dev, const void *data);
 
 /*
-- 
2.11.0

