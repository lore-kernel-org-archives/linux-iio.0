Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-43.csi.cam.ac.uk ([131.111.8.143]:57918 "EHLO
	ppsw-43.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760004Ab0EDNkV (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 4 May 2010 09:40:21 -0400
From: Jonathan Cameron <jic23@cam.ac.uk>
To: gregkh@suse.de
Cc: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 09/20] staging:iio: Documentation, update iio_utils.h for the move to a bus
Date: Tue,  4 May 2010 14:43:04 +0100
Message-Id: <1272980595-11033-10-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1272980595-11033-9-git-send-email-jic23@cam.ac.uk>
References: <1272980595-11033-1-git-send-email-jic23@cam.ac.uk>
 <1272980595-11033-2-git-send-email-jic23@cam.ac.uk>
 <1272980595-11033-3-git-send-email-jic23@cam.ac.uk>
 <1272980595-11033-4-git-send-email-jic23@cam.ac.uk>
 <1272980595-11033-5-git-send-email-jic23@cam.ac.uk>
 <1272980595-11033-6-git-send-email-jic23@cam.ac.uk>
 <1272980595-11033-7-git-send-email-jic23@cam.ac.uk>
 <1272980595-11033-8-git-send-email-jic23@cam.ac.uk>
 <1272980595-11033-9-git-send-email-jic23@cam.ac.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

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

