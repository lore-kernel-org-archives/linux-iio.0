Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mailout3.w1.samsung.com ([210.118.77.13]:35947 "EHLO
	mailout3.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751499Ab3IRJVp (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 18 Sep 2013 05:21:45 -0400
Received: from eucpsbgm2.samsung.com (unknown [203.254.199.245])
 by mailout3.w1.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0MTB002Y5DZTQE90@mailout3.w1.samsung.com> for
 linux-iio@vger.kernel.org; Wed, 18 Sep 2013 10:21:43 +0100 (BST)
From: Lukasz Czerwinski <l.czerwinski@samsung.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org
Subject: [PATCH] iio: iio_device_add_event_sysfs() bugfix
Date: Wed, 18 Sep 2013 11:21:40 +0200
Message-id: <1379496100-27649-1-git-send-email-l.czerwinski@samsung.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Fix mask generation for modified channels.

Signed-off-by: Lukasz Czerwinski <l.czerwinski@samsung.com>
---
 drivers/iio/industrialio-event.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/industrialio-event.c b/drivers/iio/industrialio-event.c
index 10aa9ef..f146acd 100644
--- a/drivers/iio/industrialio-event.c
+++ b/drivers/iio/industrialio-event.c
@@ -276,7 +276,7 @@ static int iio_device_add_event_sysfs(struct iio_dev *indio_dev,
 			goto error_ret;
 		}
 		if (chan->modified)
-			mask = IIO_MOD_EVENT_CODE(chan->type, 0, chan->channel,
+			mask = IIO_MOD_EVENT_CODE(chan->type, 0, chan->channel2,
 						  i/IIO_EV_DIR_MAX,
 						  i%IIO_EV_DIR_MAX);
 		else if (chan->differential)
-- 
1.7.9.5

