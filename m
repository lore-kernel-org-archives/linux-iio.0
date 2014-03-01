Return-Path: <sre@ring0.de>
From: Sebastian Reichel <sre@debian.org>
To: Sebastian Reichel <sre@ring0.de>,
	Marek Belisko <marek@goldelico.com>,
	Jonathan Cameron <jic23@kernel.org>
Cc: Lee Jones <lee.jones@linaro.org>,
	Samuel Ortiz <sameo@linux.intel.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	Grant Likely <grant.likely@linaro.org>,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org,
	Sebastian Reichel <sre@debian.org>
Subject: [PATCHv1 9/9] iio: inkern: add iio_read_channel_average_raw
Date: Sat,  1 Mar 2014 20:32:45 +0100
Message-Id: <1393702365-26429-10-git-send-email-sre@debian.org>
In-Reply-To: <1393702365-26429-1-git-send-email-sre@debian.org>
References: <1393444990-28140-1-git-send-email-sre@debian.org>
 <1393702365-26429-1-git-send-email-sre@debian.org>
List-ID: <linux-iio@vger.kernel.org>

Add iio_read_channel_average_raw to support reading
averaged raw values in consumer drivers.

Signed-off-by: Sebastian Reichel <sre@debian.org>
---
 drivers/iio/inkern.c         | 18 ++++++++++++++++++
 include/linux/iio/consumer.h | 13 +++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
index 0cf5f8e..adeba5a 100644
--- a/drivers/iio/inkern.c
+++ b/drivers/iio/inkern.c
@@ -443,6 +443,24 @@ err_unlock:
 }
 EXPORT_SYMBOL_GPL(iio_read_channel_raw);
 
+int iio_read_channel_average_raw(struct iio_channel *chan, int *val)
+{
+	int ret;
+
+	mutex_lock(&chan->indio_dev->info_exist_lock);
+	if (chan->indio_dev->info == NULL) {
+		ret = -ENODEV;
+		goto err_unlock;
+	}
+
+	ret = iio_channel_read(chan, val, NULL, IIO_CHAN_INFO_AVERAGE_RAW);
+err_unlock:
+	mutex_unlock(&chan->indio_dev->info_exist_lock);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(iio_read_channel_average_raw);
+
 static int iio_convert_raw_to_processed_unlocked(struct iio_channel *chan,
 	int raw, int *processed, unsigned int scale)
 {
diff --git a/include/linux/iio/consumer.h b/include/linux/iio/consumer.h
index 2752b1f..651f9a0 100644
--- a/include/linux/iio/consumer.h
+++ b/include/linux/iio/consumer.h
@@ -123,6 +123,19 @@ int iio_read_channel_raw(struct iio_channel *chan,
 			 int *val);
 
 /**
+ * iio_read_channel_average_raw() - read from a given channel
+ * @chan:		The channel being queried.
+ * @val:		Value read back.
+ *
+ * Note raw reads from iio channels are in adc counts and hence
+ * scale will need to be applied if standard units required.
+ *
+ * In opposit to the normal iio_read_channel_raw this function
+ * returns the average of multiple reads.
+ */
+int iio_read_channel_average_raw(struct iio_channel *chan, int *val);
+
+/**
  * iio_read_channel_processed() - read processed value from a given channel
  * @chan:		The channel being queried.
  * @val:		Value read back.
-- 
1.9.0
