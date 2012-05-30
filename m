Return-Path: <jic23@kernel.org>
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 2/4] staging:iio:in kernel users: Add a data field for channel specific info.
Date: Wed, 30 May 2012 20:36:32 +0100
Message-Id: <1338406594-14550-3-git-send-email-jic23@kernel.org>
In-Reply-To: <1338406594-14550-1-git-send-email-jic23@kernel.org>
References: <1338406594-14550-1-git-send-email-jic23@kernel.org>
List-ID: <linux-iio@vger.kernel.org>

Used to allow information about a given channel mapping to be passed
through from board files to the consumer drivers.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/iio/inkern.c         |    1 +
 include/linux/iio/consumer.h |    2 ++
 include/linux/iio/machine.h  |    2 ++
 3 files changed, 5 insertions(+)

diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
index 6c03cf5..c1ea198 100644
--- a/drivers/iio/inkern.c
+++ b/drivers/iio/inkern.c
@@ -188,6 +188,7 @@ struct iio_channel *iio_channel_get_all(const char *name)
 		if (name && strcmp(name, c->map->consumer_dev_name) != 0)
 			continue;
 		chans[mapind].indio_dev = c->indio_dev;
+		chans[mapind].data = c->map->consumer_data;
 		chans[mapind].channel =
 			iio_chan_spec_from_name(chans[mapind].indio_dev,
 						c->map->adc_channel_label);
diff --git a/include/linux/iio/consumer.h b/include/linux/iio/consumer.h
index e2657e6..26040c2 100644
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
index 0b1f19b..7409100 100644
--- a/include/linux/iio/machine.h
+++ b/include/linux/iio/machine.h
@@ -16,9 +16,11 @@
  * @consumer_dev_name:	Name to uniquely identify the consumer device.
  * @consumer_channel:	Unique name used to idenitify the channel on the
  *			consumer side.
+ * @consumer_data:	Data about the channel for use by the consumer driver.
  */
 struct iio_map {
 	const char *adc_channel_label;
 	const char *consumer_dev_name;
 	const char *consumer_channel;
+	void *consumer_data;
 };
-- 
1.7.10.2
