Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:36362 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751100AbbGQPo3 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 17 Jul 2015 11:44:29 -0400
Date: Fri, 17 Jul 2015 18:43:42 +0300
From: Cristina Opriceana <cristina.opriceana@gmail.com>
To: jic23@kernel.org, knaack.h@gmx.de
Cc: lars@metafoo.de, pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, daniel.baluta@intel.com,
	octavian.purdila@intel.com
Subject: [PATCH v4] tools: iio: Send error messages to stderr
Message-ID: <f8368011bf5085c6a5134ce73c38c94e666586e4.1437145812.git.cristina.opriceana@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This patch indends to make some cleanup and send printf
error messages to stderr. The changes were performed with coccinelle
for failure messages and manual for other cases, such as wrong usage
messages.

Signed-off-by: Cristina Opriceana <cristina.opriceana@gmail.com>
Reviewed-by: Hartmut Knaack <knaack.h@gmx.de>
---
Changes since v4:
 - fix indentation issues

 tools/iio/generic_buffer.c    | 39 ++++++++++++++++++---------------
 tools/iio/iio_event_monitor.c | 14 ++++++------
 tools/iio/iio_utils.c         | 51 +++++++++++++++++++++++++------------------
 tools/iio/lsiio.c             |  2 +-
 4 files changed, 59 insertions(+), 47 deletions(-)

diff --git a/tools/iio/generic_buffer.c b/tools/iio/generic_buffer.c
index 9535c2d..32f389eb 100644
--- a/tools/iio/generic_buffer.c
+++ b/tools/iio/generic_buffer.c
@@ -193,15 +193,15 @@ void process_scan(char *data,
 
 void print_usage(void)
 {
-	printf("Usage: generic_buffer [options]...\n"
-	       "Capture, convert and output data from IIO device buffer\n"
-	       "  -c <n>     Do n conversions\n"
-	       "  -e         Disable wait for event (new data)\n"
-	       "  -g         Use trigger-less mode\n"
-	       "  -l <n>     Set buffer length to n samples\n"
-	       "  -n <name>  Set device name (mandatory)\n"
-	       "  -t <name>  Set trigger name\n"
-	       "  -w <n>     Set delay between reads in us (event-less mode)\n");
+	fprintf(stderr, "Usage: generic_buffer [options]...\n"
+		"Capture, convert and output data from IIO device buffer\n"
+		"  -c <n>     Do n conversions\n"
+		"  -e         Disable wait for event (new data)\n"
+		"  -g         Use trigger-less mode\n"
+		"  -l <n>     Set buffer length to n samples\n"
+		"  -n <name>  Set device name (mandatory)\n"
+		"  -t <name>  Set trigger name\n"
+		"  -w <n>     Set delay between reads in us (event-less mode)\n");
 }
 
 int main(int argc, char **argv)
@@ -271,7 +271,7 @@ int main(int argc, char **argv)
 	}
 
 	if (!device_name) {
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
@@ -323,8 +324,8 @@ int main(int argc, char **argv)
 	 */
 	ret = build_channel_array(dev_dir_name, &channels, &num_channels);
 	if (ret) {
-		printf("Problem reading scan element information\n");
-		printf("diag %s\n", dev_dir_name);
+		fprintf(stderr, "Problem reading scan element information\n"
+			"diag %s\n", dev_dir_name);
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
 
@@ -410,7 +412,7 @@ int main(int argc, char **argv)
 		read_size = read(fp, data, toread * scan_size);
 		if (read_size < 0) {
 			if (errno == EAGAIN) {
-				printf("nothing available\n");
+				fprintf(stderr, "nothing available\n");
 				continue;
 			} else {
 				break;
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
index 9ee1959..cd3fd41 100644
--- a/tools/iio/iio_event_monitor.c
+++ b/tools/iio/iio_event_monitor.c
@@ -215,8 +215,8 @@ static void print_event(struct iio_event_data *event)
 	bool diff = IIO_EVENT_CODE_EXTRACT_DIFF(event->id);
 
 	if (!event_is_known(event)) {
-		printf("Unknown event: time: %lld, id: %llx\n",
-		       event->timestamp, event->id);
+		fprintf(stderr, "Unknown event: time: %lld, id: %llx\n",
+			event->timestamp, event->id);
 
 		return;
 	}
@@ -251,7 +251,7 @@ int main(int argc, char **argv)
 	int fd, event_fd;
 
 	if (argc <= 1) {
-		printf("Usage: %s <device_name>\n", argv[0]);
+		fprintf(stderr, "Usage: %s <device_name>\n", argv[0]);
 		return -1;
 	}
 
@@ -277,14 +277,14 @@ int main(int argc, char **argv)
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
 
@@ -300,7 +300,7 @@ int main(int argc, char **argv)
 		ret = read(event_fd, &event, sizeof(event));
 		if (ret == -1) {
 			if (errno == EAGAIN) {
-				printf("nothing available\n");
+				fprintf(stderr, "nothing available\n");
 				continue;
 			} else {
 				ret = -errno;
@@ -310,7 +310,7 @@ int main(int argc, char **argv)
 		}
 
 		if (ret != sizeof(event)) {
-			printf("Reading event failed!\n");
+			fprintf(stderr, "Reading event failed!\n");
 			ret = -EIO;
 			break;
 		}
diff --git a/tools/iio/iio_utils.c b/tools/iio/iio_utils.c
index e177f40..c3f9e37 100644
--- a/tools/iio/iio_utils.c
+++ b/tools/iio/iio_utils.c
@@ -140,7 +140,8 @@ int iioutils_get_type(unsigned *is_signed, unsigned *bytes, unsigned *bits_used,
 			sysfsfp = fopen(filename, "r");
 			if (!sysfsfp) {
 				ret = -errno;
-				printf("failed to open %s\n", filename);
+				fprintf(stderr, "failed to open %s\n",
+					filename);
 				goto error_free_filename;
 			}
 
@@ -152,11 +153,13 @@ int iioutils_get_type(unsigned *is_signed, unsigned *bytes, unsigned *bits_used,
 				     &padint, shift);
 			if (ret < 0) {
 				ret = -errno;
-				printf("failed to pass scan type description\n");
+				fprintf(stderr,
+					"failed to pass scan type description\n");
 				goto error_close_sysfsfp;
 			} else if (ret != 5) {
 				ret = -EIO;
-				printf("scan type description didn't match\n");
+				fprintf(stderr,
+					"scan type description didn't match\n");
 				goto error_close_sysfsfp;
 			}
 
@@ -170,7 +173,8 @@ int iioutils_get_type(unsigned *is_signed, unsigned *bytes, unsigned *bits_used,
 			*is_signed = (signchar == 's');
 			if (fclose(sysfsfp)) {
 				ret = -errno;
-				printf("Failed to close %s\n", filename);
+				fprintf(stderr, "Failed to close %s\n",
+					filename);
 				goto error_free_filename;
 			}
 
@@ -454,7 +458,8 @@ int build_channel_array(const char *device_dir,
 			sysfsfp = fopen(filename, "r");
 			if (!sysfsfp) {
 				ret = -errno;
-				printf("failed to open %s\n", filename);
+				fprintf(stderr, "failed to open %s\n",
+					filename);
 				free(filename);
 				goto error_cleanup_array;
 			}
@@ -568,7 +573,7 @@ int find_type_by_name(const char *name, const char *type)
 
 	dp = opendir(iio_dir);
 	if (!dp) {
-		printf("No industrialio devices available\n");
+		fprintf(stderr, "No industrialio devices available\n");
 		return -ENODEV;
 	}
 
@@ -581,11 +586,13 @@ int find_type_by_name(const char *name, const char *type)
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
 
@@ -664,7 +671,7 @@ static int _write_sysfs_int(const char *filename, const char *basedir, int val,
 	sysfsfp = fopen(temp, "w");
 	if (!sysfsfp) {
 		ret = -errno;
-		printf("failed to open %s\n", temp);
+		fprintf(stderr, "failed to open %s\n", temp);
 		goto error_free;
 	}
 
@@ -685,7 +692,7 @@ static int _write_sysfs_int(const char *filename, const char *basedir, int val,
 		sysfsfp = fopen(temp, "r");
 		if (!sysfsfp) {
 			ret = -errno;
-			printf("failed to open %s\n", temp);
+			fprintf(stderr, "failed to open %s\n", temp);
 			goto error_free;
 		}
 
@@ -703,8 +710,9 @@ static int _write_sysfs_int(const char *filename, const char *basedir, int val,
 		}
 
 		if (test != val) {
-			printf("Possible failure in int write %d to %s/%s\n",
-			       val, basedir, filename);
+			fprintf(stderr,
+				"Possible failure in int write %d to %s/%s\n",
+				val, basedir, filename);
 			ret = -1;
 		}
 	}
@@ -750,7 +758,7 @@ static int _write_sysfs_string(const char *filename, const char *basedir,
 	char *temp = malloc(strlen(basedir) + strlen(filename) + 2);
 
 	if (!temp) {
-		printf("Memory allocation failed\n");
+		fprintf(stderr, "Memory allocation failed\n");
 		return -ENOMEM;
 	}
 
@@ -761,7 +769,7 @@ static int _write_sysfs_string(const char *filename, const char *basedir,
 	sysfsfp = fopen(temp, "w");
 	if (!sysfsfp) {
 		ret = -errno;
-		printf("Could not open %s\n", temp);
+		fprintf(stderr, "Could not open %s\n", temp);
 		goto error_free;
 	}
 
@@ -782,7 +790,7 @@ static int _write_sysfs_string(const char *filename, const char *basedir,
 		sysfsfp = fopen(temp, "r");
 		if (!sysfsfp) {
 			ret = -errno;
-			printf("Could not open file to verify\n");
+			fprintf(stderr, "Could not open file to verify\n");
 			goto error_free;
 		}
 
@@ -800,9 +808,10 @@ static int _write_sysfs_string(const char *filename, const char *basedir,
 		}
 
 		if (strcmp(temp, val) != 0) {
-			printf("Possible failure in string write of %s "
-			       "Should be %s written to %s/%s\n", temp, val,
-			       basedir, filename);
+			fprintf(stderr,
+				"Possible failure in string write of %s "
+				"Should be %s written to %s/%s\n", temp, val,
+				basedir, filename);
 			ret = -1;
 		}
 	}
@@ -856,7 +865,7 @@ int read_sysfs_posint(const char *filename, const char *basedir)
 	char *temp = malloc(strlen(basedir) + strlen(filename) + 2);
 
 	if (!temp) {
-		printf("Memory allocation failed");
+		fprintf(stderr, "Memory allocation failed");
 		return -ENOMEM;
 	}
 
@@ -903,7 +912,7 @@ int read_sysfs_float(const char *filename, const char *basedir, float *val)
 	char *temp = malloc(strlen(basedir) + strlen(filename) + 2);
 
 	if (!temp) {
-		printf("Memory allocation failed");
+		fprintf(stderr, "Memory allocation failed");
 		return -ENOMEM;
 	}
 
@@ -950,7 +959,7 @@ int read_sysfs_string(const char *filename, const char *basedir, char *str)
 	char *temp = malloc(strlen(basedir) + strlen(filename) + 2);
 
 	if (!temp) {
-		printf("Memory allocation failed");
+		fprintf(stderr, "Memory allocation failed");
 		return -ENOMEM;
 	}
 
diff --git a/tools/iio/lsiio.c b/tools/iio/lsiio.c
index 4f8172f..b271a9a 100644
--- a/tools/iio/lsiio.c
+++ b/tools/iio/lsiio.c
@@ -108,7 +108,7 @@ static int dump_devices(void)
 
 	dp = opendir(iio_dir);
 	if (!dp) {
-		printf("No industrial I/O devices available\n");
+		fprintf(stderr, "No industrial I/O devices available\n");
 		return -ENODEV;
 	}
 
-- 
1.9.1

