Return-Path: <tiberiu.a.breana@intel.com>
From: Tiberiu Breana <tiberiu.a.breana@intel.com>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH v2] tools: iio: Add single-byte case for generic_buffer
Date: Fri,  3 Jul 2015 12:57:36 +0300
Message-Id: <1435917456-2973-1-git-send-email-tiberiu.a.breana@intel.com>
List-ID: <linux-iio@vger.kernel.org>

Some sensors export data in an 8-bit format.
Add a single-byte case for the generic_buffer tool so that
these sensors' buffer data can be visualized.

Signed-off-by: Tiberiu Breana <tiberiu.a.breana@intel.com>
---
v2: added the print1byte function to apply the channel shift and
address both signed and unsigned cases.
---
 tools/iio/generic_buffer.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/tools/iio/generic_buffer.c b/tools/iio/generic_buffer.c
index fc362d2..0e73723 100644
--- a/tools/iio/generic_buffer.c
+++ b/tools/iio/generic_buffer.c
@@ -61,6 +61,23 @@ int size_from_channelarray(struct iio_channel_info *channels, int num_channels)
 	return bytes;
 }
 
+void print1byte(uint8_t input, struct iio_channel_info *info)
+{
+	/*
+	 * Shift before conversion to avoid sign extension
+	 * of left aligned data
+	 */
+	input >>= info->shift;
+	input &= info->mask;
+	if (info->is_signed) {
+		int8_t val = (int8_t)(input << (8 - info->bits_used)) >>
+			     (8 - info->bits_used);
+		printf("%05f ", ((float)val + info->offset) * info->scale);
+	} else {
+		printf("%05f ", ((float)input + info->offset) * info->scale);
+	}
+}
+
 void print2byte(uint16_t input, struct iio_channel_info *info)
 {
 	/* First swap if incorrect endian */
@@ -152,6 +169,10 @@ void process_scan(char *data,
 	for (k = 0; k < num_channels; k++)
 		switch (channels[k].bytes) {
 			/* only a few cases implemented so far */
+		case 1:
+			print1byte(*(uint8_t *)(data + channels[k].location),
+				   &channels[k]);
+			break;
 		case 2:
 			print2byte(*(uint16_t *)(data + channels[k].location),
 				   &channels[k]);
-- 
1.9.1
