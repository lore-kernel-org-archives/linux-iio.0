Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.15.15]:49857 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751814Ab3L2Lyb (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Sun, 29 Dec 2013 06:54:31 -0500
Received: from [192.168.0.80] ([188.102.214.102]) by mail.gmx.com (mrgmx101)
 with ESMTPSA (Nemesis) id 0M35iN-1V8ZVJ2VDr-00sxph for
 <linux-iio@vger.kernel.org>; Sun, 29 Dec 2013 12:54:30 +0100
Message-ID: <52C00D75.70302@gmx.de>
Date: Sun, 29 Dec 2013 12:54:29 +0100
From: Hartmut Knaack <knaack.h@gmx.de>
MIME-Version: 1.0
To: linux-iio@vger.kernel.org
Subject: [RFC]iio:industrialio-event fix error-handling in iio_device_add_event
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

__iio_add_chan_devattr returns -EBUSY, when registering the event-interface of
ad799x, but iio_device_add_event does not catch it. So, handle it like in
iio_device_add_info_mask_type. Not sure, if this is the right solution, but it
makes the ad799x (and possibly others as well) usable.

Signed-off-by: Hartmut Knaack <knaack.h@gmx.de>
---
diff --git a/drivers/iio/industrialio-event.c b/drivers/iio/industrialio-event.c
index c10eab6..d37a907 100644
--- a/drivers/iio/industrialio-event.c
+++ b/drivers/iio/industrialio-event.c
@@ -362,7 +362,9 @@ static int iio_device_add_event(struct iio_dev *indio_dev,
 			&indio_dev->event_interface->dev_attr_list);
 		kfree(postfix);
 
-		if (ret)
+		if ((ret == -EBUSY) && (shared_by != IIO_SEPARATE))
+			continue;
+		else if (ret < 0)
 			return ret;
 
 		attrcount++;
