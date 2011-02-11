Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-52.csi.cam.ac.uk ([131.111.8.152]:35841 "EHLO
	ppsw-52.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755478Ab1BKNJ5 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 11 Feb 2011 08:09:57 -0500
From: Jonathan Cameron <jic23@cam.ac.uk>
To: greg@kroah.com
Cc: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 5/5] staging:iio: buffer example - add lots more runtime parameters
Date: Fri, 11 Feb 2011 13:09:13 +0000
Message-Id: <1297429753-6606-6-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1297429753-6606-1-git-send-email-jic23@cam.ac.uk>
References: <1297429753-6606-1-git-send-email-jic23@cam.ac.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Add ability to control delay for event free buffers
Add ability to control length of buffer
Add ability to control how many read cycles occur

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
Tested-by: Michael Hennerich <michael.hennerich@analog.com>
---
 drivers/staging/iio/Documentation/generic_buffer.c |   22 +++++++++++++++----
 1 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/iio/Documentation/generic_buffer.c b/drivers/staging/iio/Documentation/generic_buffer.c
index 0befcb8..771b236 100644
--- a/drivers/staging/iio/Documentation/generic_buffer.c
+++ b/drivers/staging/iio/Documentation/generic_buffer.c
@@ -29,9 +29,6 @@
 #include <string.h>
 #include "iio_utils.h"
 
-const int buf_len = 128;
-const int num_loops = 2;
-
 /**
  * size_from_channelarray() - calculate the storage size of a scan
  * @channels: the channel info array
@@ -119,6 +116,11 @@ void process_scan(char *data,
 
 int main(int argc, char **argv)
 {
+	unsigned long num_loops = 2;
+	unsigned long timedelay = 1000000;
+	unsigned long buf_len = 128;
+
+
 	int ret, c, i, j, toread;
 
 	FILE *fp_ev;
@@ -136,10 +138,11 @@ int main(int argc, char **argv)
 	char *buffer_access, *buffer_event;
 	int scan_size;
 	int noevents = 0;
+	char *dummy;
 
 	struct iio_channel_info *infoarray;
 
-	while ((c = getopt(argc, argv, "et:n:")) != -1) {
+	while ((c = getopt(argc, argv, "l:w:c:et:n:")) != -1) {
 		switch (c) {
 		case 'n':
 			device_name = optarg;
@@ -151,6 +154,15 @@ int main(int argc, char **argv)
 		case 'e':
 			noevents = 1;
 			break;
+		case 'c':
+			num_loops = strtoul(optarg, &dummy, 10);
+			break;
+		case 'w':
+			timedelay = strtoul(optarg, &dummy, 10);
+			break;
+		case 'l':
+			buf_len = strtoul(optarg, &dummy, 10);
+			break;
 		case '?':
 			return -1;
 		}
@@ -285,7 +297,7 @@ int main(int argc, char **argv)
 				continue;
 			}
 		} else {
-			usleep(1000);
+			usleep(timedelay);
 			toread = 64;
 		}
 
-- 
1.7.3.4

