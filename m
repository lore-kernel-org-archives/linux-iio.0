Return-Path: <vlad.dogaru@intel.com>
From: Vlad Dogaru <vlad.dogaru@intel.com>
To: linux-iio@vger.kernel.org,
	jic23@kernel.org,
	knaack.h@gmx.de
Cc: Vlad Dogaru <vlad.dogaru@intel.com>
Subject: [PATCH v2] iio: ensure scan index is unique at buffer register
Date: Fri, 12 Dec 2014 16:26:30 +0200
Message-Id: <1418394390-19690-1-git-send-email-vlad.dogaru@intel.com>
List-ID: <linux-iio@vger.kernel.org>

Having two or more channels with the same positive scan_index field
makes no sense.  Prevent this situation by failing to register a buffer
if two scan indexes are identical.

Signed-off-by: Vlad Dogaru <vlad.dogaru@intel.com>
---
Changes since v1:
 - remove redundant check for scan_index < 0 in the inner loop.

 drivers/iio/industrialio-buffer.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
index f971f79..baf09c1 100644
--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -309,6 +309,27 @@ static int iio_buffer_add_channel_sysfs(struct iio_dev *indio_dev,
 	return ret;
 }
 
+static int iio_check_unique_scan_index(struct iio_dev *indio_dev,
+				       const struct iio_chan_spec *channels,
+				       int num_channels)
+{
+	int i, j;
+
+	for (i = 0; i < num_channels - 1; i++) {
+		if (channels[i].scan_index < 0)
+			continue;
+		for (j = i + 1; j < num_channels; j++)
+			if (channels[i].scan_index == channels[j].scan_index) {
+				dev_err(&indio_dev->dev,
+					"duplicate scan index %d\n",
+					channels[i].scan_index);
+				return -EINVAL;
+			}
+	}
+
+	return 0;
+}
+
 static const char * const iio_scan_elements_group_name = "scan_elements";
 
 int iio_buffer_register(struct iio_dev *indio_dev,
@@ -320,6 +341,10 @@ int iio_buffer_register(struct iio_dev *indio_dev,
 	struct iio_buffer *buffer = indio_dev->buffer;
 	int ret, i, attrn, attrcount, attrcount_orig = 0;
 
+	ret = iio_check_unique_scan_index(indio_dev, channels, num_channels);
+	if (ret < 0)
+		return ret;
+
 	if (buffer->attrs)
 		indio_dev->groups[indio_dev->groupcounter++] = buffer->attrs;
 
-- 
1.9.1
