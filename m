Return-Path: <jic23@hermes.cam.ac.uk>
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org,
	greg@kroah.com
Cc: lars@metafoo.de,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 1/7] staging:iio:find iio channel from scan index util function
Date: Mon,  5 Dec 2011 21:37:10 +0000
Message-Id: <1323121036-21094-2-git-send-email-jic23@kernel.org>
In-Reply-To: <1323121036-21094-1-git-send-email-jic23@kernel.org>
References: <1323121036-21094-1-git-send-email-jic23@kernel.org>
Sender: "J.I. Cameron" <jic23@hermes.cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

From: Jonathan Cameron <jic23@cam.ac.uk>

Useful for getting to the channel based on scan mask alone.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/iio.h               |    8 ++++++++
 drivers/staging/iio/industrialio-core.c |   11 +++++++++++
 2 files changed, 19 insertions(+), 0 deletions(-)

diff --git a/drivers/staging/iio/iio.h b/drivers/staging/iio/iio.h
index 4aed915..95d6318 100644
--- a/drivers/staging/iio/iio.h
+++ b/drivers/staging/iio/iio.h
@@ -323,6 +323,14 @@ struct iio_dev {
 };
 
 /**
+ * iio_find_channel_from_si() - get channel from its scan index
+ * @indio_dev:		device
+ * @si:			scan index to match
+ */
+const struct iio_chan_spec
+*iio_find_channel_from_si(struct iio_dev *indio_dev, int si);
+
+/**
  * iio_device_register() - register a device with the IIO subsystem
  * @indio_dev:		Device structure filled by the device driver
  **/
diff --git a/drivers/staging/iio/industrialio-core.c b/drivers/staging/iio/industrialio-core.c
index d8cd9e3..dbd1ce1 100644
--- a/drivers/staging/iio/industrialio-core.c
+++ b/drivers/staging/iio/industrialio-core.c
@@ -89,6 +89,17 @@ static const char * const iio_chan_info_postfix[] = {
 	= "filter_low_pass_3db_frequency",
 };
 
+const struct iio_chan_spec
+*iio_find_channel_from_si(struct iio_dev *indio_dev, int si)
+{
+	int i;
+
+	for (i = 0; i < indio_dev->num_channels; i++)
+		if (indio_dev->channels[i].scan_index == si)
+			return &indio_dev->channels[i];
+	return NULL;
+}
+
 /**
  * struct iio_detected_event_list - list element for events that have occurred
  * @list:		linked list header
-- 
1.7.7.4
