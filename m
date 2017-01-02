Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from tarvos.retrosnub.co.uk ([217.168.153.95]:60386 "EHLO
        tarvos.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933927AbdABT3A (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 2 Jan 2017 14:29:00 -0500
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: Daniel Baluta <daniel.baluta@gmail.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 08/11] iio:buffer.h include pushdown into buffer implementations
Date: Mon,  2 Jan 2017 19:28:31 +0000
Message-Id: <20170102192834.26546-9-jic23@kernel.org>
In-Reply-To: <20170102192834.26546-1-jic23@kernel.org>
References: <20170102192834.26546-1-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

These were only getting access to the internals of struct iio_dev via
the include of iio.h within buffer.h.  This should always have been
explicitly included by the buffer implementations themselves.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/iio/buffer/industrialio-buffer-cb.c | 1 +
 drivers/iio/buffer/kfifo_buf.c              | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/iio/buffer/industrialio-buffer-cb.c b/drivers/iio/buffer/industrialio-buffer-cb.c
index b8f550e47d3d..79fb2f9de759 100644
--- a/drivers/iio/buffer/industrialio-buffer-cb.c
+++ b/drivers/iio/buffer/industrialio-buffer-cb.c
@@ -10,6 +10,7 @@
 #include <linux/slab.h>
 #include <linux/err.h>
 #include <linux/export.h>
+#include <linux/iio/iio.h>
 #include <linux/iio/buffer.h>
 #include <linux/iio/consumer.h>
 
diff --git a/drivers/iio/buffer/kfifo_buf.c b/drivers/iio/buffer/kfifo_buf.c
index c5b999f0c519..2267ce190335 100644
--- a/drivers/iio/buffer/kfifo_buf.c
+++ b/drivers/iio/buffer/kfifo_buf.c
@@ -5,6 +5,7 @@
 #include <linux/workqueue.h>
 #include <linux/kfifo.h>
 #include <linux/mutex.h>
+#include <linux/iio/iio.h>
 #include <linux/iio/kfifo_buf.h>
 #include <linux/sched.h>
 #include <linux/poll.h>
-- 
2.11.0

