Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from db3ehsobe005.messaging.microsoft.com ([213.199.154.143]:27437
	"EHLO DB3EHSOBE006.bigfish.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751334Ab2BVMdT (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 22 Feb 2012 07:33:19 -0500
From: <michael.hennerich@analog.com>
To: <jic23@kernel.org>
CC: <linux-iio@vger.kernel.org>,
	<device-drivers-devel@blackfin.uclinux.org>, <drivers@analog.com>,
	Michael Hennerich <michael.hennerich@analog.com>
Subject: [PATCH 2/3] iio: core: Avoid NULL pointer de-ref in case indio_dev->setup_ops are not in use
Date: Wed, 22 Feb 2012 13:30:14 +0100
Message-ID: <1329913815-5382-2-git-send-email-michael.hennerich@analog.com>
In-Reply-To: <1329913815-5382-1-git-send-email-michael.hennerich@analog.com>
References: <1329913815-5382-1-git-send-email-michael.hennerich@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: Michael Hennerich <michael.hennerich@analog.com>

Drivers may not need setup_ops at all, so let the core supply
some empty ops.

Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
---
 drivers/staging/iio/industrialio-core.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/drivers/staging/iio/industrialio-core.c b/drivers/staging/iio/industrialio-core.c
index 82c9128..6fc1430 100644
--- a/drivers/staging/iio/industrialio-core.c
+++ b/drivers/staging/iio/industrialio-core.c
@@ -800,6 +800,8 @@ static const struct file_operations iio_buffer_fileops = {
 	.compat_ioctl = iio_ioctl,
 };
 
+static const struct iio_buffer_setup_ops noop_ring_setup_ops;
+
 int iio_device_register(struct iio_dev *indio_dev)
 {
 	int ret;
@@ -828,6 +830,10 @@ int iio_device_register(struct iio_dev *indio_dev)
 	if (indio_dev->modes & INDIO_BUFFER_TRIGGERED)
 		iio_device_register_trigger_consumer(indio_dev);
 
+	if ((indio_dev->modes & INDIO_ALL_BUFFER_MODES) &&
+		indio_dev->setup_ops == NULL)
+		indio_dev->setup_ops = &noop_ring_setup_ops;
+
 	ret = device_add(&indio_dev->dev);
 	if (ret < 0)
 		goto error_unreg_eventset;
-- 
1.7.0.4


