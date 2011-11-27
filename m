Return-Path: <jic23@hermes.cam.ac.uk>
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 2/2] staging:iio:generic_buffer example - handle endian differences
Date: Sun, 27 Nov 2011 11:46:05 +0000
Message-Id: <1322394365-3214-3-git-send-email-jic23@kernel.org>
In-Reply-To: <1322394365-3214-1-git-send-email-jic23@kernel.org>
References: <1322394365-3214-1-git-send-email-jic23@kernel.org>
Sender: "J.I. Cameron" <jic23@hermes.cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

From: Jonathan Cameron <jic23@cam.ac.uk>

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/Documentation/generic_buffer.c |    8 ++++++++
 drivers/staging/iio/Documentation/iio_utils.h      |    7 ++++++-
 2 files changed, 14 insertions(+), 1 deletions(-)

diff --git a/drivers/staging/iio/Documentation/generic_buffer.c b/drivers/staging/iio/Documentation/generic_buffer.c
index d580953..69a05b9 100644
--- a/drivers/staging/iio/Documentation/generic_buffer.c
+++ b/drivers/staging/iio/Documentation/generic_buffer.c
@@ -28,6 +28,7 @@
 #include <linux/types.h>
 #include <string.h>
 #include <poll.h>
+#include <endian.h>
 #include "iio_utils.h"
 
 /**
@@ -56,6 +57,13 @@ int size_from_channelarray(struct iio_channel_info *channels, int num_channels)
 
 void print2byte(int input, struct iio_channel_info *info)
 {
+	/* First swap if incorrect endian */
+
+	if (info->be)
+		input = be16toh((uint_16t)input);
+	else
+		input = le16toh((uint_16t)input);
+
 	/* shift before conversion to avoid sign extension
 	   of left aligned data */
 	input = input >> info->shift;
diff --git a/drivers/staging/iio/Documentation/iio_utils.h b/drivers/staging/iio/Documentation/iio_utils.h
index 986889b..6f3a392 100644
--- a/drivers/staging/iio/Documentation/iio_utils.h
+++ b/drivers/staging/iio/Documentation/iio_utils.h
@@ -74,6 +74,7 @@ struct iio_channel_info {
 	unsigned bits_used;
 	unsigned shift;
 	uint64_t mask;
+	unsigned be;
 	unsigned is_signed;
 	unsigned enabled;
 	unsigned location;
@@ -84,6 +85,7 @@ struct iio_channel_info {
  * @is_signed: output whether channel is signed
  * @bytes: output how many bytes the channel storage occupies
  * @mask: output a bit mask for the raw data
+ * @be: big endian
  * @device_dir: the iio device directory
  * @name: the channel name
  * @generic_name: the channel type name
@@ -93,6 +95,7 @@ inline int iioutils_get_type(unsigned *is_signed,
 			     unsigned *bits_used,
 			     unsigned *shift,
 			     uint64_t *mask,
+			     unsigned *be,
 			     const char *device_dir,
 			     const char *name,
 			     const char *generic_name)
@@ -101,7 +104,7 @@ inline int iioutils_get_type(unsigned *is_signed,
 	int ret;
 	DIR *dp;
 	char *scan_el_dir, *builtname, *builtname_generic, *filename = 0;
-	char signchar;
+	char signchar, endianchar;
 	unsigned padint;
 	const struct dirent *ent;
 
@@ -156,6 +159,7 @@ inline int iioutils_get_type(unsigned *is_signed,
 				printf("failed to pass scan type description\n");
 				return ret;
 			}
+			*be = (endianchar == 'b');
 			*bytes = padint / 8;
 			if (*bits_used == 64)
 				*mask = ~0;
@@ -399,6 +403,7 @@ inline int build_channel_array(const char *device_dir,
 						&current->bits_used,
 						&current->shift,
 						&current->mask,
+						&current->be,
 						device_dir,
 						current->name,
 						current->generic_name);
-- 
1.7.7.3
