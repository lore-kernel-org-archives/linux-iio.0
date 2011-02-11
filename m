Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: greg@kroah.com
Cc: linux-iio@vger.kernel.org,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 4/5] staging:iio: update example to handle case with no ring events
Date: Fri, 11 Feb 2011 13:09:12 +0000
Message-Id: <1297429753-6606-5-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1297429753-6606-1-git-send-email-jic23@cam.ac.uk>
References: <1297429753-6606-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
Tested-by: Michael Hennerich <michael.hennerich@analog.com>
---
 drivers/staging/iio/Documentation/generic_buffer.c |   45 +++++++++++++-------
 1 files changed, 29 insertions(+), 16 deletions(-)

diff --git a/drivers/staging/iio/Documentation/generic_buffer.c b/drivers/staging/iio/Documentation/generic_buffer.c
index df23aeb..0befcb8 100644
--- a/drivers/staging/iio/Documentation/generic_buffer.c
+++ b/drivers/staging/iio/Documentation/generic_buffer.c
@@ -26,6 +26,7 @@
 #include <sys/stat.h>
 #include <sys/dir.h>
 #include <linux/types.h>
+#include <string.h>
 #include "iio_utils.h"
 
 const int buf_len = 128;
@@ -134,10 +135,11 @@ int main(int argc, char **argv)
 	int dev_num, trig_num;
 	char *buffer_access, *buffer_event;
 	int scan_size;
+	int noevents = 0;
 
 	struct iio_channel_info *infoarray;
 
-	while ((c = getopt(argc, argv, "t:n:")) != -1) {
+	while ((c = getopt(argc, argv, "et:n:")) != -1) {
 		switch (c) {
 		case 'n':
 			device_name = optarg;
@@ -146,6 +148,9 @@ int main(int argc, char **argv)
 			trigger_name = optarg;
 			datardytrigger = 0;
 			break;
+		case 'e':
+			noevents = 1;
+			break;
 		case '?':
 			return -1;
 		}
@@ -260,22 +265,30 @@ int main(int argc, char **argv)
 
 	/* Wait for events 10 times */
 	for (j = 0; j < num_loops; j++) {
-		read_size = fread(&dat, 1, sizeof(struct iio_event_data),
-				  fp_ev);
-		switch (dat.id) {
-		case IIO_EVENT_CODE_RING_100_FULL:
-			toread = buf_len;
-			break;
-		case IIO_EVENT_CODE_RING_75_FULL:
-			toread = buf_len*3/4;
-			break;
-		case IIO_EVENT_CODE_RING_50_FULL:
-			toread = buf_len/2;
-			break;
-		default:
-			printf("Unexpecteded event code\n");
-			continue;
+		if (!noevents) {
+			read_size = fread(&dat,
+					1,
+					sizeof(struct iio_event_data),
+					fp_ev);
+			switch (dat.id) {
+			case IIO_EVENT_CODE_RING_100_FULL:
+				toread = buf_len;
+				break;
+			case IIO_EVENT_CODE_RING_75_FULL:
+				toread = buf_len*3/4;
+				break;
+			case IIO_EVENT_CODE_RING_50_FULL:
+				toread = buf_len/2;
+				break;
+			default:
+				printf("Unexpecteded event code\n");
+				continue;
+			}
+		} else {
+			usleep(1000);
+			toread = 64;
 		}
+
 		read_size = read(fp,
 				 data,
 				 toread*scan_size);
-- 
1.7.3.4
