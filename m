Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ch1ehsobe004.messaging.microsoft.com ([216.32.181.184]:49246
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754933Ab2CAJwf (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 1 Mar 2012 04:52:35 -0500
From: <michael.hennerich@analog.com>
To: <greg@kroah.com>
CC: <jic23@kernel.org>, <linux-iio@vger.kernel.org>,
	<device-drivers-devel@blackfin.uclinux.org>, <drivers@analog.com>,
	Michael Hennerich <michael.hennerich@analog.com>
Subject: [PATCH 2/3] iio: core: Avoid NULL pointer de-ref in case indio_dev->setup_ops are not in use
Date: Thu, 1 Mar 2012 10:51:04 +0100
Message-ID: <1330595465-18193-2-git-send-email-michael.hennerich@analog.com>
In-Reply-To: <1330595465-18193-1-git-send-email-michael.hennerich@analog.com>
References: <1330595465-18193-1-git-send-email-michael.hennerich@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: Michael Hennerich <michael.hennerich@analog.com>

Drivers may not need setup_ops at all, so let the core supply
some empty ops.

Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
Acked-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/staging/iio/industrialio-core.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/drivers/staging/iio/industrialio-core.c b/drivers/staging/iio/industrialio-core.c
index 7256dd6..cc3c6dc 100644
--- a/drivers/staging/iio/industrialio-core.c
+++ b/drivers/staging/iio/industrialio-core.c
@@ -854,6 +854,8 @@ static const struct file_operations iio_buffer_fileops = {
 	.compat_ioctl = iio_ioctl,
 };

+static const struct iio_buffer_setup_ops noop_ring_setup_ops;
+
 int iio_device_register(struct iio_dev *indio_dev)
 {
 	int ret;
@@ -882,6 +884,10 @@ int iio_device_register(struct iio_dev *indio_dev)
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


