Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 09/19] staging:iio: Documentation, update iio_utils.h for the move to a bus
Date: Mon, 26 Apr 2010 21:08:00 +0100
Message-Id: <1272312490-9791-10-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1272312490-9791-9-git-send-email-jic23@cam.ac.uk>
References: <1272312490-9791-1-git-send-email-jic23@cam.ac.uk>
 <1272312490-9791-2-git-send-email-jic23@cam.ac.uk>
 <1272312490-9791-3-git-send-email-jic23@cam.ac.uk>
 <1272312490-9791-4-git-send-email-jic23@cam.ac.uk>
 <1272312490-9791-5-git-send-email-jic23@cam.ac.uk>
 <1272312490-9791-6-git-send-email-jic23@cam.ac.uk>
 <1272312490-9791-7-git-send-email-jic23@cam.ac.uk>
 <1272312490-9791-8-git-send-email-jic23@cam.ac.uk>
 <1272312490-9791-9-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/Documentation/iio_utils.h |   31 ++++++++++++++++++++++++-
 1 files changed, 30 insertions(+), 1 deletions(-)

diff --git a/drivers/staging/iio/Documentation/iio_utils.h b/drivers/staging/iio/Documentation/iio_utils.h
index 74d3124..d24006a 100644
--- a/drivers/staging/iio/Documentation/iio_utils.h
+++ b/drivers/staging/iio/Documentation/iio_utils.h
@@ -47,7 +47,7 @@ inline char *find_ring_subelement(const char *directory, const char *subelement)
 
 char *find_type_by_name(const char *name, const char *type)
 {
-	const char *iio_dir = "/sys/class/iio/";
+	const char *iio_dir = "/sys/bus/iio/devices/";
 	const struct dirent *ent;
 	int cnt, pos, pos2;
 
@@ -112,6 +112,35 @@ int write_sysfs_int(char *filename, char *basedir, int val)
 	return 0;
 }
 
+int write_sysfs_int_and_verify(char *filename, char *basedir, int val)
+{
+	int ret;
+	FILE  *sysfsfp;
+	char temp[100];
+	int test;
+
+	sprintf(temp, "%s%s", basedir, filename);
+	sysfsfp = fopen(temp, "w");
+	if (sysfsfp == NULL)
+		return -1;
+	fprintf(sysfsfp, "%d", val);
+	fclose(sysfsfp);
+
+	sysfsfp = fopen(temp, "r");
+	if (sysfsfp == NULL)
+		return -1;
+	fscanf(sysfsfp, "%d", &test);
+	if (test != val) {
+		printf("Possible failure in int write %d to %s%s\n",
+		       val,
+		       basedir,
+		       filename);
+		return -1;
+	}
+
+	return 0;
+}
+
 /**
  * write_sysfs_string_and_verify() - string write, readback and verify
  * @filename: name of file to write to
-- 
1.6.4.4
