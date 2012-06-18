Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-134.synserver.de ([212.40.185.134]:1490 "EHLO
	smtp-out-126.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752633Ab2FRQaX (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 18 Jun 2012 12:30:23 -0400
From: Lars-Peter Clausen <lars@metafoo.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jonathan Cameron <jic23@cam.ac.uk>, devel@driverdev.osuosl.org,
	linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 01/10] iio: iio_buffer_register: Skip channels with negative scan index
Date: Mon, 18 Jun 2012 18:33:47 +0200
Message-Id: <1340037236-15685-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

It is not always the case that all channels can be used in buffered mode. This
patch allows channels, which can not be used in buffered mode, to set their scan
index to a negative number, which will cause iio_buffer_register to ignore the
channel.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Acked-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/iio/industrialio-buffer.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
index 2f35db9..3d8d187 100644
--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -285,6 +285,9 @@ int iio_buffer_register(struct iio_dev *indio_dev,
 	if (channels) {
 		/* new magic */
 		for (i = 0; i < num_channels; i++) {
+			if (channels[i].scan_index < 0)
+				continue;
+
 			/* Establish necessary mask length */
 			if (channels[i].scan_index >
 			    (int)indio_dev->masklength - 1)
-- 
1.7.10

