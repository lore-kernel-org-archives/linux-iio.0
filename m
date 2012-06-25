Return-Path: <pmeerw@pmeerw.net>
From: Peter Meerwald <pmeerw@pmeerw.net>
To: linux-iio@vger.kernel.org
Cc: jic23@cam.ac.uk,
	Peter Meerwald <pmeerw@pmeerw.net>
Subject: [PATCH 3/3] iio staging: fix resource leak in _write_sysfs_int()
Date: Mon, 25 Jun 2012 23:13:26 +0200
Message-Id: <1340658806-5609-3-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1340658806-5609-1-git-send-email-pmeerw@pmeerw.net>
References: <1340658806-5609-1-git-send-email-pmeerw@pmeerw.net>
List-ID: <linux-iio@vger.kernel.org>

Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
---
 drivers/staging/iio/Documentation/iio_utils.h |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/staging/iio/Documentation/iio_utils.h b/drivers/staging/iio/Documentation/iio_utils.h
index 8869c55..5244fa0 100644
--- a/drivers/staging/iio/Documentation/iio_utils.h
+++ b/drivers/staging/iio/Documentation/iio_utils.h
@@ -525,6 +525,7 @@ inline int _write_sysfs_int(char *filename, char *basedir, int val, int verify)
 			goto error_free;
 		}
 		fscanf(sysfsfp, "%d", &test);
+		fclose(sysfsfp);
 		if (test != val) {
 			printf("Possible failure in int write %d to %s%s\n",
 				val,
@@ -574,6 +575,7 @@ int _write_sysfs_string(char *filename, char *basedir, char *val, int verify)
 			goto error_free;
 		}
 		fscanf(sysfsfp, "%s", temp);
+		fclose(sysfsfp);
 		if (strcmp(temp, val) != 0) {
 			printf("Possible failure in string write of %s "
 				"Should be %s "
-- 
1.7.9.5
