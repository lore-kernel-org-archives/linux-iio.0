Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: arnd@arndb.de,
	Michael.Hennerich@analog.com,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 29/99] staging:iio:Documentation generic_buffer.c update to new abi for buffers + misc fixes
Date: Wed,  4 May 2011 12:58:01 +0100
Message-Id: <1304510351-10922-30-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1304510351-10922-1-git-send-email-jic23@cam.ac.uk>
References: <1304510351-10922-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Trivial space before newline fix incorporated.

Additional fixes related to handling of sign extension and shifted
data.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>

squash into buffer handling update.
---
 drivers/staging/iio/Documentation/generic_buffer.c |   93 +++++++------------
 drivers/staging/iio/Documentation/iio_utils.h      |   20 +---
 2 files changed, 39 insertions(+), 74 deletions(-)

diff --git a/drivers/staging/iio/Documentation/generic_buffer.c b/drivers/staging/iio/Documentation/generic_buffer.c
index eb72e95..f82894f 100644
--- a/drivers/staging/iio/Documentation/generic_buffer.c
+++ b/drivers/staging/iio/Documentation/generic_buffer.c
@@ -27,6 +27,7 @@
 #include <sys/dir.h>
 #include <linux/types.h>
 #include <string.h>
+#include <poll.h>
 #include "iio_utils.h"
 
 /**
@@ -53,6 +54,24 @@ int size_from_channelarray(struct iio_channel_info *channels, int num_channels)
 	return bytes;
 }
 
+void print2byte(int input, struct iio_channel_info *info)
+{
+	/* shift before conversion to avoid sign extension
+	   of left aligned data */
+	input = input >> info->shift;
+	if (info->is_signed) {
+		int16_t val = input;
+		val &= (1 << info->bits_used) - 1;
+		val = (int16_t)(val << (16 - info->bits_used)) >>
+			(16 - info->bits_used);
+		printf("%05f  ", val,
+		       (float)(val + info->offset)*info->scale);
+	} else {
+		uint16_t val = input;
+		val &= (1 << info->bits_used) - 1;
+		printf("%05f ", ((float)val + info->offset)*info->scale);
+	}
+}
 /**
  * process_scan() - print out the values in SI units
  * @data:		pointer to the start of the scan
@@ -70,25 +89,8 @@ void process_scan(char *data,
 		switch (infoarray[k].bytes) {
 			/* only a few cases implemented so far */
 		case 2:
-			if (infoarray[k].is_signed) {
-				int16_t val = *(int16_t *)
-					(data
-					 + infoarray[k].location);
-				if ((val >> infoarray[k].bits_used) & 1)
-					val = (val & infoarray[k].mask) |
-						~infoarray[k].mask;
-				printf("%05f ", ((float)val +
-						 infoarray[k].offset)*
-				       infoarray[k].scale);
-			} else {
-				uint16_t val = *(uint16_t *)
-					(data +
-					 infoarray[k].location);
-				val = (val & infoarray[k].mask);
-				printf("%05f ", ((float)val +
-						 infoarray[k].offset)*
-				       infoarray[k].scale);
-			}
+			print2byte(*(uint16_t *)(data + infoarray[k].location),
+				   &infoarray[k]);
 			break;
 		case 8:
 			if (infoarray[k].is_signed) {
@@ -133,9 +135,8 @@ int main(int argc, char **argv)
 	int datardytrigger = 1;
 	char *data;
 	ssize_t read_size;
-	struct iio_event_data dat;
 	int dev_num, trig_num;
-	char *buffer_access, *buffer_event;
+	char *buffer_access;
 	int scan_size;
 	int noevents = 0;
 	char *dummy;
@@ -210,7 +211,7 @@ int main(int argc, char **argv)
 	 */
 	ret = build_channel_array(dev_dir_name, &infoarray, &num_channels);
 	if (ret) {
-		printf("Problem reading scan element information \n");
+		printf("Problem reading scan element information\n");
 		goto error_free_triggername;
 	}
 
@@ -251,54 +252,32 @@ int main(int argc, char **argv)
 	}
 
 	ret = asprintf(&buffer_access,
-		       "/dev/device%d:buffer0:access0",
+		       "/dev/device%d:buffer0",
 		       dev_num);
 	if (ret < 0) {
 		ret = -ENOMEM;
 		goto error_free_data;
 	}
 
-	ret = asprintf(&buffer_event, "/dev/device%d:buffer0:event0", dev_num);
-	if (ret < 0) {
-		ret = -ENOMEM;
-		goto error_free_buffer_access;
-	}
 	/* Attempt to open non blocking the access dev */
 	fp = open(buffer_access, O_RDONLY | O_NONBLOCK);
 	if (fp == -1) { /*If it isn't there make the node */
 		printf("Failed to open %s\n", buffer_access);
 		ret = -errno;
-		goto error_free_buffer_event;
-	}
-	/* Attempt to open the event access dev (blocking this time) */
-	fp_ev = fopen(buffer_event, "rb");
-	if (fp_ev == NULL) {
-		printf("Failed to open %s\n", buffer_event);
-		ret = -errno;
-		goto error_close_buffer_access;
+		goto error_free_buffer_access;
 	}
 
 	/* Wait for events 10 times */
 	for (j = 0; j < num_loops; j++) {
 		if (!noevents) {
-			read_size = fread(&dat,
-					1,
-					sizeof(struct iio_event_data),
-					fp_ev);
-			switch (dat.id) {
-			case IIO_EVENT_CODE_RING_100_FULL:
-				toread = buf_len;
-				break;
-			case IIO_EVENT_CODE_RING_75_FULL:
-				toread = buf_len*3/4;
-				break;
-			case IIO_EVENT_CODE_RING_50_FULL:
-				toread = buf_len/2;
-				break;
-			default:
-				printf("Unexpecteded event code\n");
-				continue;
-			}
+			struct pollfd pfd = {
+				.fd = fp,
+				.events = POLLIN,
+			};
+
+			poll(&pfd, 1, -1);
+			toread = buf_len;
+
 		} else {
 			usleep(timedelay);
 			toread = 64;
@@ -320,22 +299,18 @@ int main(int argc, char **argv)
 	/* Stop the ring buffer */
 	ret = write_sysfs_int("enable", buf_dir_name, 0);
 	if (ret < 0)
-		goto error_close_buffer_event;
+		goto error_close_buffer_access;
 
 	/* Disconnect from the trigger - just write a dummy name.*/
 	write_sysfs_string("trigger/current_trigger",
 			dev_dir_name, "NULL");
 
-error_close_buffer_event:
-	fclose(fp_ev);
 error_close_buffer_access:
 	close(fp);
 error_free_data:
 	free(data);
 error_free_buffer_access:
 	free(buffer_access);
-error_free_buffer_event:
-	free(buffer_event);
 error_free_buf_dir_name:
 	free(buf_dir_name);
 error_free_triggername:
diff --git a/drivers/staging/iio/Documentation/iio_utils.h b/drivers/staging/iio/Documentation/iio_utils.h
index fd78e4f..150f440 100644
--- a/drivers/staging/iio/Documentation/iio_utils.h
+++ b/drivers/staging/iio/Documentation/iio_utils.h
@@ -16,25 +16,11 @@
 
 #define IIO_MAX_NAME_LENGTH 30
 
-#define IIO_EV_CLASS_BUFFER		0
-#define IIO_BUFFER_EVENT_CODE(code)		\
-	(IIO_EV_CLASS_BUFFER | (code << 8))
-
-#define IIO_EVENT_CODE_RING_50_FULL	IIO_BUFFER_EVENT_CODE(0)
-#define IIO_EVENT_CODE_RING_75_FULL	IIO_BUFFER_EVENT_CODE(1)
-#define IIO_EVENT_CODE_RING_100_FULL	IIO_BUFFER_EVENT_CODE(2)
-
-
 #define FORMAT_SCAN_ELEMENTS_DIR "%s:buffer0/scan_elements"
 #define FORMAT_TYPE_FILE "%s_type"
 
 const char *iio_dir = "/sys/bus/iio/devices/";
 
-struct iio_event_data {
-	int id;
-	__s64 timestamp;
-};
-
 /**
  * iioutils_break_up_name() - extract generic name from full channel name
  * @full_name: the full channel name
@@ -85,6 +71,7 @@ struct iio_channel_info {
 	unsigned index;
 	unsigned bytes;
 	unsigned bits_used;
+	unsigned shift;
 	uint64_t mask;
 	unsigned is_signed;
 	unsigned enabled;
@@ -103,6 +90,7 @@ struct iio_channel_info {
 inline int iioutils_get_type(unsigned *is_signed,
 			     unsigned *bytes,
 			     unsigned *bits_used,
+			     unsigned *shift,
 			     uint64_t *mask,
 			     const char *device_dir,
 			     const char *name,
@@ -157,7 +145,8 @@ inline int iioutils_get_type(unsigned *is_signed,
 				goto error_free_filename;
 			}
 			fscanf(sysfsfp,
-			       "%c%u/%u", &signchar, bits_used, &padint);
+			       "%c%u/%u>>%u", &signchar, bits_used,
+			       &padint, shift);
 			*bytes = padint / 8;
 			if (*bits_used == 64)
 				*mask = ~0;
@@ -395,6 +384,7 @@ inline int build_channel_array(const char *device_dir,
 			ret = iioutils_get_type(&current->is_signed,
 						&current->bytes,
 						&current->bits_used,
+						&current->shift,
 						&current->mask,
 						device_dir,
 						current->name,
-- 
1.7.3.4
