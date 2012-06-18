Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-105.synserver.de ([212.40.185.105]:1089 "EHLO
	smtp-out-099.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751930Ab2FRLl2 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 18 Jun 2012 07:41:28 -0400
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v4 01/10] iio: iio_buffer_register: Skip channels with negative scan index
Date: Mon, 18 Jun 2012 13:44:54 +0200
Message-Id: <1340019903-13305-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

It is not always the case that all channels can be used in buffered mode. This
patch allows channels, which can not be used in buffered mode, to set their scan
index to a negative number, which will cause iio_buffer_register to ignore the
channel.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
This patch is new in v4

Sorry for the extra noise, I should have noticed the problem with the ad7298
driver earlier.
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

