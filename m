Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:48258 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753121Ab3GGUYU (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Sun, 7 Jul 2013 16:24:20 -0400
From: Peter Meerwald <pmeerw@pmeerw.net>
To: linux-iio@vger.kernel.org
Cc: Peter Meerwald <pmeerw@pmeerw.net>
Subject: [PATCH 1/5] iio: staging: fix device.txt documentation
Date: Sun,  7 Jul 2013 22:24:02 +0200
Message-Id: <1373228646-5356-1-git-send-email-pmeerw@pmeerw.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
---
 drivers/staging/iio/Documentation/device.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/iio/Documentation/device.txt b/drivers/staging/iio/Documentation/device.txt
index ea08d62..8be32e5 100644
--- a/drivers/staging/iio/Documentation/device.txt
+++ b/drivers/staging/iio/Documentation/device.txt
@@ -56,7 +56,7 @@ Then fill in the following:
 
 - indio_dev->modes:
 	Specify whether direct access and / or ring buffer access is supported.
-- indio_dev->ring:
+- indio_dev->buffer:
 	An optional associated buffer.
 - indio_dev->pollfunc:
 	Poll function related elements. This controls what occurs when a trigger
@@ -67,7 +67,7 @@ Then fill in the following:
 - indio_dev->num_channels:
 	How many channels are there?
 
-Once these are set up, a call to iio_device_register(indio_dev),
+Once these are set up, a call to iio_device_register(indio_dev)
 will register the device with the iio core.
 
 Worth noting here is that, if a ring buffer is to be used, it can be
-- 
1.8.3.2

