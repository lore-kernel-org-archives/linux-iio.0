Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-046.synserver.de ([212.40.185.46]:1063 "EHLO
	smtp-out-044.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1756433Ab2EUITA (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 21 May 2012 04:19:00 -0400
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 2/2] iio:inkern: Use iio_device_{get,put}
Date: Mon, 21 May 2012 10:21:54 +0200
Message-Id: <1337588514-23938-2-git-send-email-lars@metafoo.de>
In-Reply-To: <1337588514-23938-1-git-send-email-lars@metafoo.de>
References: <1337588514-23938-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Use iio_device_get and iio_device_put instead of open-coding it.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/iio/inkern.c |   13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
index 9226458..ff84a57 100644
--- a/drivers/iio/inkern.c
+++ b/drivers/iio/inkern.c
@@ -125,7 +125,7 @@ struct iio_channel *iio_st_channel_get(const char *name,
 		     strcmp(channel_name, c_i->map->consumer_channel) != 0))
 			continue;
 		c = c_i;
-		get_device(&c->indio_dev->dev);
+		iio_device_get(c->indio_dev);
 		break;
 	}
 	mutex_unlock(&iio_map_list_lock);
@@ -149,7 +149,7 @@ EXPORT_SYMBOL_GPL(iio_st_channel_get);
 
 void iio_st_channel_release(struct iio_channel *channel)
 {
-	put_device(&channel->indio_dev->dev);
+	iio_device_put(channel->indio_dev);
 	kfree(channel);
 }
 EXPORT_SYMBOL_GPL(iio_st_channel_release);
@@ -195,10 +195,10 @@ struct iio_channel *iio_st_channel_get_all(const char *name)
 						c->map->adc_channel_label);
 		if (chans[mapind].channel == NULL) {
 			ret = -EINVAL;
-			put_device(&chans[mapind].indio_dev->dev);
+			iio_device_put(chans[mapind].indio_dev);
 			goto error_free_chans;
 		}
-		get_device(&chans[mapind].indio_dev->dev);
+		iio_device_get(chans->indio_dev);
 		mapind++;
 	}
 	mutex_unlock(&iio_map_list_lock);
@@ -210,8 +210,7 @@ struct iio_channel *iio_st_channel_get_all(const char *name)
 
 error_free_chans:
 	for (i = 0; i < nummaps; i++)
-		if (chans[i].indio_dev)
-			put_device(&chans[i].indio_dev->dev);
+		iio_device_put(chans[i].indio_dev);
 	kfree(chans);
 error_ret:
 	mutex_unlock(&iio_map_list_lock);
@@ -225,7 +224,7 @@ void iio_st_channel_release_all(struct iio_channel *channels)
 	struct iio_channel *chan = &channels[0];
 
 	while (chan->indio_dev) {
-		put_device(&chan->indio_dev->dev);
+		iio_device_put(chan->indio_dev);
 		chan++;
 	}
 	kfree(channels);
-- 
1.7.10

