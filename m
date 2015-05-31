Return-Path: <knaack.h@gmx.de>
From: Hartmut Knaack <knaack.h@gmx.de>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Roberta Dobrescu <roberta.dobrescu@gmail.com>,
	Daniel Baluta <daniel.baluta@intel.com>,
	Irina Tirdea <irina.tirdea@intel.com>
Subject: [PATCH 08/32] tools:iio: save errno first
Date: Sun, 31 May 2015 14:39:48 +0200
Message-Id: <0d987c62b698f3c187a7d8b528d9e0475e9b97f4.1433072539.git.knaack.h@gmx.de>
In-Reply-To: <cover.1433072539.git.knaack.h@gmx.de>
References: <cover.1433072539.git.knaack.h@gmx.de>
In-Reply-To: <cover.1433072539.git.knaack.h@gmx.de>
References: <cover.1433072539.git.knaack.h@gmx.de>
List-ID: <linux-iio@vger.kernel.org>

The man-page of errno states, that errno should be saved before doing any
library call, as that call may have changed the value of errno. So, when
encountering any error, save errno first.
This patch affects generic_buffer.c, iio_event_monitor.c and iio_utils.c.

Signed-off-by: Hartmut Knaack <knaack.h@gmx.de>
---
 tools/iio/generic_buffer.c    |  2 +-
 tools/iio/iio_event_monitor.c |  6 +++---
 tools/iio/iio_utils.c         | 14 +++++++-------
 3 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/tools/iio/generic_buffer.c b/tools/iio/generic_buffer.c
index 51ae3df..d52a55a 100644
--- a/tools/iio/generic_buffer.c
+++ b/tools/iio/generic_buffer.c
@@ -296,8 +296,8 @@ int main(int argc, char **argv)
 	/* Attempt to open non blocking the access dev */
 	fp = open(buffer_access, O_RDONLY | O_NONBLOCK);
 	if (fp == -1) { /* If it isn't there make the node */
-		printf("Failed to open %s\n", buffer_access);
 		ret = -errno;
+		printf("Failed to open %s\n", buffer_access);
 		goto error_free_buffer_access;
 	}
 
diff --git a/tools/iio/iio_event_monitor.c b/tools/iio/iio_event_monitor.c
index 427c271..f6fdab4 100644
--- a/tools/iio/iio_event_monitor.c
+++ b/tools/iio/iio_event_monitor.c
@@ -269,8 +269,8 @@ int main(int argc, char **argv)
 
 	fd = open(chrdev_name, 0);
 	if (fd == -1) {
-		fprintf(stdout, "Failed to open %s\n", chrdev_name);
 		ret = -errno;
+		fprintf(stdout, "Failed to open %s\n", chrdev_name);
 		goto error_free_chrdev_name;
 	}
 
@@ -279,8 +279,8 @@ int main(int argc, char **argv)
 	close(fd);
 
 	if (ret == -1 || event_fd == -1) {
-		fprintf(stdout, "Failed to retrieve event fd\n");
 		ret = -errno;
+		fprintf(stdout, "Failed to retrieve event fd\n");
 		goto error_free_chrdev_name;
 	}
 
@@ -291,8 +291,8 @@ int main(int argc, char **argv)
 				printf("nothing available\n");
 				continue;
 			} else {
-				perror("Failed to read event from device");
 				ret = -errno;
+				perror("Failed to read event from device");
 				break;
 			}
 		}
diff --git a/tools/iio/iio_utils.c b/tools/iio/iio_utils.c
index 1c0ca2f..f12bc2e 100644
--- a/tools/iio/iio_utils.c
+++ b/tools/iio/iio_utils.c
@@ -129,8 +129,8 @@ int iioutils_get_type(unsigned *is_signed,
 			}
 			sysfsfp = fopen(filename, "r");
 			if (sysfsfp == NULL) {
-				printf("failed to open %s\n", filename);
 				ret = -errno;
+				printf("failed to open %s\n", filename);
 				goto error_free_filename;
 			}
 
@@ -141,8 +141,8 @@ int iioutils_get_type(unsigned *is_signed,
 				     bits_used,
 				     &padint, shift);
 			if (ret < 0) {
-				printf("failed to pass scan type description\n");
 				ret = -errno;
+				printf("failed to pass scan type description\n");
 				goto error_close_sysfsfp;
 			}
 			*be = (endianchar == 'b');
@@ -332,8 +332,8 @@ int build_channel_array(const char *device_dir,
 			}
 			sysfsfp = fopen(filename, "r");
 			if (sysfsfp == NULL) {
-				free(filename);
 				ret = -errno;
+				free(filename);
 				count--;
 				goto error_cleanup_array;
 			}
@@ -505,8 +505,8 @@ int _write_sysfs_int(char *filename, char *basedir, int val, int verify)
 	sprintf(temp, "%s/%s", basedir, filename);
 	sysfsfp = fopen(temp, "w");
 	if (sysfsfp == NULL) {
-		printf("failed to open %s\n", temp);
 		ret = -errno;
+		printf("failed to open %s\n", temp);
 		goto error_free;
 	}
 	fprintf(sysfsfp, "%d", val);
@@ -514,8 +514,8 @@ int _write_sysfs_int(char *filename, char *basedir, int val, int verify)
 	if (verify) {
 		sysfsfp = fopen(temp, "r");
 		if (sysfsfp == NULL) {
-			printf("failed to open %s\n", temp);
 			ret = -errno;
+			printf("failed to open %s\n", temp);
 			goto error_free;
 		}
 		fscanf(sysfsfp, "%d", &test);
@@ -556,8 +556,8 @@ int _write_sysfs_string(char *filename, char *basedir, char *val, int verify)
 	sprintf(temp, "%s/%s", basedir, filename);
 	sysfsfp = fopen(temp, "w");
 	if (sysfsfp == NULL) {
-		printf("Could not open %s\n", temp);
 		ret = -errno;
+		printf("Could not open %s\n", temp);
 		goto error_free;
 	}
 	fprintf(sysfsfp, "%s", val);
@@ -565,8 +565,8 @@ int _write_sysfs_string(char *filename, char *basedir, char *val, int verify)
 	if (verify) {
 		sysfsfp = fopen(temp, "r");
 		if (sysfsfp == NULL) {
-			printf("could not open file to verify\n");
 			ret = -errno;
+			printf("could not open file to verify\n");
 			goto error_free;
 		}
 		fscanf(sysfsfp, "%s", temp);
-- 
2.3.6
