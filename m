Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-50.csi.cam.ac.uk ([131.111.8.150]:45454 "EHLO
	ppsw-50.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935359Ab2JaKai (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 31 Oct 2012 06:30:38 -0400
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 2/4] staging:iio:in kernel users: Add a data field for channel specific info.
Date: Wed, 31 Oct 2012 10:30:29 +0000
Message-Id: <1351679431-7963-3-git-send-email-jic23@kernel.org>
In-Reply-To: <1351679431-7963-1-git-send-email-jic23@kernel.org>
References: <1351679431-7963-1-git-send-email-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Used to allow information about a given channel mapping to be passed
through from board files to the consumer drivers.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/iio/inkern.c         | 1 +
 include/linux/iio/consumer.h | 2 ++
 include/linux/iio/machine.h  | 2 ++
 3 files changed, 5 insertions(+)

diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
index b394621..d55e98f 100644
--- a/drivers/iio/inkern.c
+++ b/drivers/iio/inkern.c
@@ -203,6 +203,7 @@ struct iio_channel *iio_channel_get_all(const char *name)
 		if (name && strcmp(name, c->map->consumer_dev_name) != 0)
 			continue;
 		chans[mapind].indio_dev = c->indio_dev;
+		chans[mapind].data = c->map->consumer_data;
 		chans[mapind].channel =
 			iio_chan_spec_from_name(chans[mapind].indio_dev,
 						c->map->adc_channel_label);
diff --git a/include/linux/iio/consumer.h b/include/linux/iio/consumer.h
index e875bcf..57efee6 100644
--- a/include/linux/iio/consumer.h
+++ b/include/linux/iio/consumer.h
@@ -18,10 +18,12 @@ struct iio_chan_spec;
  * struct iio_channel - everything needed for a consumer to use a channel
  * @indio_dev:		Device on which the channel exists.
  * @channel:		Full description of the channel.
+ * @data:		Data about the channel used by consumer.
  */
 struct iio_channel {
 	struct iio_dev *indio_dev;
 	const struct iio_chan_spec *channel;
+	void *data;
 };
 
 /**
diff --git a/include/linux/iio/machine.h b/include/linux/iio/machine.h
index 809a3f0..1601a2a 100644
--- a/include/linux/iio/machine.h
+++ b/include/linux/iio/machine.h
@@ -19,11 +19,13 @@
  * @consumer_dev_name:	Name to uniquely identify the consumer device.
  * @consumer_channel:	Unique name used to identify the channel on the
  *			consumer side.
+ * @consumer_data:	Data about the channel for use by the consumer driver.
  */
 struct iio_map {
 	const char *adc_channel_label;
 	const char *consumer_dev_name;
 	const char *consumer_channel;
+	void *consumer_data;
 };
 
 #endif
-- 
1.7.12.4

