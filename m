Return-Path: <cristina.opriceana@gmail.com>
Date: Fri, 10 Jul 2015 14:03:06 +0300
From: Cristina Opriceana <cristina.opriceana@gmail.com>
To: jic23@kernel.org
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	daniel.baluta@intel.com, octavian.purdila@intel.com,
	julia.lawall@lip6.fr
Subject: [PATCH v2 4/4] iio: tools: iio_utils: Move general error messages to
 stderr
Message-ID: <f6c10dbb56b34af8c80951e27e880d697781a457.1436524490.git.cristina.opriceana@gmail.com>
References: <cover.1436524490.git.cristina.opriceana@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <cover.1436524490.git.cristina.opriceana@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

This patch replaces stdout general error messages to a more appropriate
standard stream to ensure consistency.

Signed-off-by: Cristina Opriceana <cristina.opriceana@gmail.com>
---
 tools/iio/iio_utils.c | 17 ++++++++++-------
 tools/iio/lsiio.c     |  2 +-
 2 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/tools/iio/iio_utils.c b/tools/iio/iio_utils.c
index 46dfa3f..8b218bd 100644
--- a/tools/iio/iio_utils.c
+++ b/tools/iio/iio_utils.c
@@ -158,7 +158,8 @@ int iioutils_get_type(unsigned *is_signed, unsigned *bytes, unsigned *bits_used,
 				goto error_close_sysfsfp;
 			} else if (ret != 5) {
 				ret = -EIO;
-				printf("scan type description didn't match\n");
+				fprintf(stderr,
+					"scan type description didn't match\n");
 				goto error_close_sysfsfp;
 			}
 
@@ -572,7 +573,7 @@ int find_type_by_name(const char *name, const char *type)
 
 	dp = opendir(iio_dir);
 	if (dp == NULL) {
-		printf("No industrialio devices available\n");
+		fprintf(stderr, "No industrialio devices available\n");
 		return -ENODEV;
 	}
 
@@ -709,8 +710,9 @@ static int _write_sysfs_int(const char *filename, const char *basedir, int val,
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
@@ -806,9 +808,10 @@ static int _write_sysfs_string(const char *filename, const char *basedir,
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
diff --git a/tools/iio/lsiio.c b/tools/iio/lsiio.c
index 7f432a5..31996de 100644
--- a/tools/iio/lsiio.c
+++ b/tools/iio/lsiio.c
@@ -108,7 +108,7 @@ static int dump_devices(void)
 
 	dp = opendir(iio_dir);
 	if (dp == NULL) {
-		printf("No industrial I/O devices available\n");
+		fprintf(stderr, "No industrial I/O devices available\n");
 		return -ENODEV;
 	}
 
-- 
1.9.1
