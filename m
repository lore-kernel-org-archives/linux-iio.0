Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:8076 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752317AbaKYMrQ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Tue, 25 Nov 2014 07:47:16 -0500
From: Vlad Dogaru <vlad.dogaru@intel.com>
To: linux-iio@vger.kernel.org
Cc: Vlad Dogaru <vlad.dogaru@intel.com>
Subject: [PATCH 2/4] iio: ensure scan index is unique at buffer register
Date: Tue, 25 Nov 2014 14:48:05 +0200
Message-Id: <1416919687-14271-3-git-send-email-vlad.dogaru@intel.com>
In-Reply-To: <1416919687-14271-1-git-send-email-vlad.dogaru@intel.com>
References: <1416919687-14271-1-git-send-email-vlad.dogaru@intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Having two or more channels with the same positive scan_index field
makes no sense.  Prevent this situation by failing to register a buffer
if two scan indexes are identical.

Signed-off-by: Vlad Dogaru <vlad.dogaru@intel.com>
---
 drivers/iio/industrialio-buffer.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
index f971f79..422b29e 100644
--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -309,6 +309,30 @@ static int iio_buffer_add_channel_sysfs(struct iio_dev *indio_dev,
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
+		for (j = i + 1; j < num_channels; j++) {
+			if (channels[j].scan_index < 0)
+				continue;
+			if (channels[i].scan_index == channels[j].scan_index) {
+				dev_err(&indio_dev->dev,
+					"duplicate scan index %d\n",
+					channels[i].scan_index);
+				return -EINVAL;
+			}
+		}
+	}
+
+	return 0;
+}
+
 static const char * const iio_scan_elements_group_name = "scan_elements";
 
 int iio_buffer_register(struct iio_dev *indio_dev,
@@ -320,6 +344,10 @@ int iio_buffer_register(struct iio_dev *indio_dev,
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

