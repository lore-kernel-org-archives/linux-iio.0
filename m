Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wg0-f53.google.com ([74.125.82.53]:33700 "EHLO
	mail-wg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754375AbbGFWvX (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 6 Jul 2015 18:51:23 -0400
Date: Tue, 7 Jul 2015 01:48:44 +0300
From: Cristina Opriceana <cristina.opriceana@gmail.com>
To: jic23@kernel.org
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	daniel.baluta@intel.com, octavian.purdila@intel.com,
	julia.lawall@lip6.fr
Subject: [PATCH 1/4] tools: iio: Move printf failiure messages to stderr
Message-ID: <c7f8fdf2e95be5afd240327a16b084634b24d549.1436220932.git.cristina.opriceana@gmail.com>
References: <cover.1436220932.git.cristina.opriceana@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <cover.1436220932.git.cristina.opriceana@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Replace printf error messages with fprintf(stderr, ...) in order
to ensure consistency and to make faults easier to identify.
This patch uses coccinelle to detect and apply the changes.

Signed-off-by: Cristina Opriceana <cristina.opriceana@gmail.com>
---
 tools/iio/generic_buffer.c    | 17 ++++++++++-------
 tools/iio/iio_event_monitor.c |  6 +++---
 tools/iio/iio_utils.c         | 34 ++++++++++++++++++++--------------
 3 files changed, 33 insertions(+), 24 deletions(-)

diff --git a/tools/iio/generic_buffer.c b/tools/iio/generic_buffer.c
index 0e73723..2f4e12f 100644
--- a/tools/iio/generic_buffer.c
+++ b/tools/iio/generic_buffer.c
@@ -271,7 +271,7 @@ int main(int argc, char **argv)
 	}
 
 	if (device_name == NULL) {
-		printf("Device name not set\n");
+		fprintf(stderr, "Device name not set\n");
 		print_usage();
 		return -1;
 	}
@@ -279,7 +279,7 @@ int main(int argc, char **argv)
 	/* Find the device requested */
 	dev_num = find_type_by_name(device_name, "iio:device");
 	if (dev_num < 0) {
-		printf("Failed to find the %s\n", device_name);
+		fprintf(stderr, "Failed to find the %s\n", device_name);
 		return dev_num;
 	}
 
@@ -307,7 +307,8 @@ int main(int argc, char **argv)
 		/* Verify the trigger exists */
 		trig_num = find_type_by_name(trigger_name, "trigger");
 		if (trig_num < 0) {
-			printf("Failed to find the trigger %s\n", trigger_name);
+			fprintf(stderr, "Failed to find the trigger %s\n",
+				trigger_name);
 			ret = trig_num;
 			goto error_free_triggername;
 		}
@@ -323,7 +324,7 @@ int main(int argc, char **argv)
 	 */
 	ret = build_channel_array(dev_dir_name, &channels, &num_channels);
 	if (ret) {
-		printf("Problem reading scan element information\n");
+		fprintf(stderr, "Problem reading scan element information\n");
 		printf("diag %s\n", dev_dir_name);
 		goto error_free_triggername;
 	}
@@ -350,7 +351,8 @@ int main(int argc, char **argv)
 						    dev_dir_name,
 						    trigger_name);
 		if (ret < 0) {
-			printf("Failed to write current_trigger file\n");
+			fprintf(stderr,
+				"Failed to write current_trigger file\n");
 			goto error_free_buf_dir_name;
 		}
 	}
@@ -382,7 +384,7 @@ int main(int argc, char **argv)
 	fp = open(buffer_access, O_RDONLY | O_NONBLOCK);
 	if (fp == -1) { /* TODO: If it isn't there make the node */
 		ret = -errno;
-		printf("Failed to open %s\n", buffer_access);
+		fprintf(stderr, "Failed to open %s\n", buffer_access);
 		goto error_free_buffer_access;
 	}
 
@@ -431,7 +433,8 @@ int main(int argc, char **argv)
 		ret = write_sysfs_string("trigger/current_trigger",
 					 dev_dir_name, "NULL");
 		if (ret < 0)
-			printf("Failed to write to %s\n", dev_dir_name);
+			fprintf(stderr, "Failed to write to %s\n",
+				dev_dir_name);
 
 error_close_buffer_access:
 	if (close(fp) == -1)
diff --git a/tools/iio/iio_event_monitor.c b/tools/iio/iio_event_monitor.c
index 703f4cb..843bc4c 100644
--- a/tools/iio/iio_event_monitor.c
+++ b/tools/iio/iio_event_monitor.c
@@ -278,14 +278,14 @@ int main(int argc, char **argv)
 	fd = open(chrdev_name, 0);
 	if (fd == -1) {
 		ret = -errno;
-		fprintf(stdout, "Failed to open %s\n", chrdev_name);
+		fprintf(stderr, "Failed to open %s\n", chrdev_name);
 		goto error_free_chrdev_name;
 	}
 
 	ret = ioctl(fd, IIO_GET_EVENT_FD_IOCTL, &event_fd);
 	if (ret == -1 || event_fd == -1) {
 		ret = -errno;
-		fprintf(stdout, "Failed to retrieve event fd\n");
+		fprintf(stderr, "Failed to retrieve event fd\n");
 		if (close(fd) == -1)
 			perror("Failed to close character device file");
 
@@ -311,7 +311,7 @@ int main(int argc, char **argv)
 		}
 
 		if (ret != sizeof(event)) {
-			printf("Reading event failed!\n");
+			fprintf(stderr, "Reading event failed!\n");
 			ret = -EIO;
 			break;
 		}
diff --git a/tools/iio/iio_utils.c b/tools/iio/iio_utils.c
index 8fb3214..46dfa3f 100644
--- a/tools/iio/iio_utils.c
+++ b/tools/iio/iio_utils.c
@@ -140,7 +140,8 @@ int iioutils_get_type(unsigned *is_signed, unsigned *bytes, unsigned *bits_used,
 			sysfsfp = fopen(filename, "r");
 			if (sysfsfp == NULL) {
 				ret = -errno;
-				printf("failed to open %s\n", filename);
+				fprintf(stderr, "failed to open %s\n",
+					filename);
 				goto error_free_filename;
 			}
 
@@ -152,7 +153,8 @@ int iioutils_get_type(unsigned *is_signed, unsigned *bytes, unsigned *bits_used,
 				     &padint, shift);
 			if (ret < 0) {
 				ret = -errno;
-				printf("failed to pass scan type description\n");
+				fprintf(stderr,
+					"failed to pass scan type description\n");
 				goto error_close_sysfsfp;
 			} else if (ret != 5) {
 				ret = -EIO;
@@ -170,7 +172,8 @@ int iioutils_get_type(unsigned *is_signed, unsigned *bytes, unsigned *bits_used,
 			*is_signed = (signchar == 's');
 			if (fclose(sysfsfp)) {
 				ret = -errno;
-				printf("Failed to close %s\n", filename);
+				fprintf(stderr, "Failed to close %s\n",
+					filename);
 				goto error_free_filename;
 			}
 
@@ -454,7 +457,8 @@ int build_channel_array(const char *device_dir,
 			sysfsfp = fopen(filename, "r");
 			if (sysfsfp == NULL) {
 				ret = -errno;
-				printf("failed to open %s\n", filename);
+				fprintf(stderr, "failed to open %s\n",
+					filename);
 				free(filename);
 				goto error_cleanup_array;
 			}
@@ -581,11 +585,13 @@ int find_type_by_name(const char *name, const char *type)
 			ret = sscanf(ent->d_name + strlen(type), "%d", &number);
 			if (ret < 0) {
 				ret = -errno;
-				printf("failed to read element number\n");
+				fprintf(stderr,
+					"failed to read element number\n");
 				goto error_close_dir;
 			} else if (ret != 1) {
 				ret = -EIO;
-				printf("failed to match element number\n");
+				fprintf(stderr,
+					"failed to match element number\n");
 				goto error_close_dir;
 			}
 
@@ -664,7 +670,7 @@ static int _write_sysfs_int(const char *filename, const char *basedir, int val,
 	sysfsfp = fopen(temp, "w");
 	if (sysfsfp == NULL) {
 		ret = -errno;
-		printf("failed to open %s\n", temp);
+		fprintf(stderr, "failed to open %s\n", temp);
 		goto error_free;
 	}
 
@@ -685,7 +691,7 @@ static int _write_sysfs_int(const char *filename, const char *basedir, int val,
 		sysfsfp = fopen(temp, "r");
 		if (sysfsfp == NULL) {
 			ret = -errno;
-			printf("failed to open %s\n", temp);
+			fprintf(stderr, "failed to open %s\n", temp);
 			goto error_free;
 		}
 
@@ -750,7 +756,7 @@ static int _write_sysfs_string(const char *filename, const char *basedir,
 	char *temp = malloc(strlen(basedir) + strlen(filename) + 2);
 
 	if (temp == NULL) {
-		printf("Memory allocation failed\n");
+		fprintf(stderr, "Memory allocation failed\n");
 		return -ENOMEM;
 	}
 
@@ -761,7 +767,7 @@ static int _write_sysfs_string(const char *filename, const char *basedir,
 	sysfsfp = fopen(temp, "w");
 	if (sysfsfp == NULL) {
 		ret = -errno;
-		printf("Could not open %s\n", temp);
+		fprintf(stderr, "Could not open %s\n", temp);
 		goto error_free;
 	}
 
@@ -782,7 +788,7 @@ static int _write_sysfs_string(const char *filename, const char *basedir,
 		sysfsfp = fopen(temp, "r");
 		if (sysfsfp == NULL) {
 			ret = -errno;
-			printf("Could not open file to verify\n");
+			fprintf(stderr, "Could not open file to verify\n");
 			goto error_free;
 		}
 
@@ -856,7 +862,7 @@ int read_sysfs_posint(const char *filename, const char *basedir)
 	char *temp = malloc(strlen(basedir) + strlen(filename) + 2);
 
 	if (temp == NULL) {
-		printf("Memory allocation failed");
+		fprintf(stderr, "Memory allocation failed");
 		return -ENOMEM;
 	}
 
@@ -903,7 +909,7 @@ int read_sysfs_float(const char *filename, const char *basedir, float *val)
 	char *temp = malloc(strlen(basedir) + strlen(filename) + 2);
 
 	if (temp == NULL) {
-		printf("Memory allocation failed");
+		fprintf(stderr, "Memory allocation failed");
 		return -ENOMEM;
 	}
 
@@ -950,7 +956,7 @@ int read_sysfs_string(const char *filename, const char *basedir, char *str)
 	char *temp = malloc(strlen(basedir) + strlen(filename) + 2);
 
 	if (temp == NULL) {
-		printf("Memory allocation failed");
+		fprintf(stderr, "Memory allocation failed");
 		return -ENOMEM;
 	}
 
-- 
1.9.1

