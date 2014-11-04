Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mailout3.w1.samsung.com ([210.118.77.13]:52070 "EHLO
	mailout3.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753293AbaKDO3w (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 4 Nov 2014 09:29:52 -0500
Received: from eucpsbgm1.samsung.com (unknown [203.254.199.244])
 by mailout3.w1.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0NEI00C8OR2HBX10@mailout3.w1.samsung.com> for
 linux-iio@vger.kernel.org; Tue, 04 Nov 2014 14:32:41 +0000 (GMT)
From: Karol Wrona <k.wrona@samsung.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>, linux-iio@vger.kernel.org
Cc: Kyungmin Park <kyungmin.park@samsung.com>,
	Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
	Karol Wrona <k.wrona@samsung.com>
Subject: [PATCH 1/1] staging: iio: Add notrigger mode for generic_buffer
Date: Tue, 04 Nov 2014 15:29:39 +0100
Message-id: <1415111379-23951-2-git-send-email-k.wrona@samsung.com>
In-reply-to: <1415111379-23951-1-git-send-email-k.wrona@samsung.com>
References: <1415111379-23951-1-git-send-email-k.wrona@samsung.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Some IIO devices do not use the triggers. This patch makes trigger setting
conditional so generic_buffer can be used when triggers are disabled.

Signed-off-by: Karol Wrona <k.wrona@samsung.com>
---
 drivers/staging/iio/Documentation/generic_buffer.c |   77 ++++++++++++--------
 1 file changed, 45 insertions(+), 32 deletions(-)

diff --git a/drivers/staging/iio/Documentation/generic_buffer.c b/drivers/staging/iio/Documentation/generic_buffer.c
index 31dfb21..de4647e 100644
--- a/drivers/staging/iio/Documentation/generic_buffer.c
+++ b/drivers/staging/iio/Documentation/generic_buffer.c
@@ -162,11 +162,12 @@ int main(int argc, char **argv)
 	char *buffer_access;
 	int scan_size;
 	int noevents = 0;
+	int notrigger = 0;
 	char *dummy;
 
 	struct iio_channel_info *channels;
 
-	while ((c = getopt(argc, argv, "l:w:c:et:n:")) != -1) {
+	while ((c = getopt(argc, argv, "l:w:c:et:n:g")) != -1) {
 		switch (c) {
 		case 'n':
 			device_name = optarg;
@@ -187,6 +188,9 @@ int main(int argc, char **argv)
 		case 'l':
 			buf_len = strtoul(optarg, &dummy, 10);
 			break;
+		case 'g':
+			notrigger = 1;
+			break;
 		case '?':
 			return -1;
 		}
@@ -205,28 +209,32 @@ int main(int argc, char **argv)
 	printf("iio device number being used is %d\n", dev_num);
 
 	asprintf(&dev_dir_name, "%siio:device%d", iio_dir, dev_num);
-	if (trigger_name == NULL) {
-		/*
-		 * Build the trigger name. If it is device associated its
-		 * name is <device_name>_dev[n] where n matches the device
-		 * number found above
-		 */
-		ret = asprintf(&trigger_name,
-			       "%s-dev%d", device_name, dev_num);
-		if (ret < 0) {
-			ret = -ENOMEM;
-			goto error_ret;
+
+	if (!notrigger) {
+		if (trigger_name == NULL) {
+			/*
+			 * Build the trigger name. If it is device associated
+			 * its name is <device_name>_dev[n] where n matches
+			 * the device number found above.
+			 */
+			ret = asprintf(&trigger_name,
+				       "%s-dev%d", device_name, dev_num);
+			if (ret < 0) {
+				ret = -ENOMEM;
+				goto error_ret;
+			}
 		}
-	}
 
-	/* Verify the trigger exists */
-	trig_num = find_type_by_name(trigger_name, "trigger");
-	if (trig_num < 0) {
-		printf("Failed to find the trigger %s\n", trigger_name);
-		ret = -ENODEV;
-		goto error_free_triggername;
-	}
-	printf("iio trigger number being used is %d\n", trig_num);
+		/* Verify the trigger exists */
+		trig_num = find_type_by_name(trigger_name, "trigger");
+		if (trig_num < 0) {
+			printf("Failed to find the trigger %s\n", trigger_name);
+			ret = -ENODEV;
+			goto error_free_triggername;
+		}
+		printf("iio trigger number being used is %d\n", trig_num);
+	} else
+		printf("trigger-less mode selected\n");
 
 	/*
 	 * Parse the files in scan_elements to identify what channels are
@@ -250,14 +258,18 @@ int main(int argc, char **argv)
 		ret = -ENOMEM;
 		goto error_free_triggername;
 	}
-	printf("%s %s\n", dev_dir_name, trigger_name);
-	/* Set the device trigger to be the data ready trigger found above */
-	ret = write_sysfs_string_and_verify("trigger/current_trigger",
-					dev_dir_name,
-					trigger_name);
-	if (ret < 0) {
-		printf("Failed to write current_trigger file\n");
-		goto error_free_buf_dir_name;
+
+	if (!notrigger) {
+		printf("%s %s\n", dev_dir_name, trigger_name);
+		/* Set the device trigger to be the data ready trigger found
+		 * above */
+		ret = write_sysfs_string_and_verify("trigger/current_trigger",
+						    dev_dir_name,
+						    trigger_name);
+		if (ret < 0) {
+			printf("Failed to write current_trigger file\n");
+			goto error_free_buf_dir_name;
+		}
 	}
 
 	/* Setup ring buffer parameters */
@@ -327,9 +339,10 @@ int main(int argc, char **argv)
 	if (ret < 0)
 		goto error_close_buffer_access;
 
-	/* Disconnect the trigger - just write a dummy name. */
-	write_sysfs_string("trigger/current_trigger",
-			dev_dir_name, "NULL");
+	if (!notrigger)
+		/* Disconnect the trigger - just write a dummy name. */
+		write_sysfs_string("trigger/current_trigger",
+				   dev_dir_name, "NULL");
 
 error_close_buffer_access:
 	close(fp);
-- 
1.7.9.5

