Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:58622 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933847AbaFCWmY (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Tue, 3 Jun 2014 18:42:24 -0400
From: Peter Meerwald <pmeerw@pmeerw.net>
To: linux-iio@vger.kernel.org
Cc: lars@metafoo.de, knaack.h@gmx.de,
	Peter Meerwald <pmeerw@pmeerw.net>
Subject: [PATCH 02/15] staging:iio: Fix iio_utils.h function prototypes
Date: Wed,  4 Jun 2014 00:42:02 +0200
Message-Id: <1401835335-29969-3-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1401835335-29969-1-git-send-email-pmeerw@pmeerw.net>
References: <1401835335-29969-1-git-send-email-pmeerw@pmeerw.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
---
 drivers/staging/iio/Documentation/iio_utils.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/iio/Documentation/iio_utils.h b/drivers/staging/iio/Documentation/iio_utils.h
index a9cfc06..0973a09 100644
--- a/drivers/staging/iio/Documentation/iio_utils.h
+++ b/drivers/staging/iio/Documentation/iio_utils.h
@@ -633,7 +633,7 @@ error_free:
 
 int read_sysfs_float(char *filename, char *basedir, float *val)
 {
-	float ret = 0;
+	int ret = 0;
 	FILE  *sysfsfp;
 	char *temp = malloc(strlen(basedir) + strlen(filename) + 2);
 	if (temp == NULL) {
@@ -653,9 +653,9 @@ error_free:
 	return ret;
 }
 
-read_sysfs_string(const char *filename, const char *basedir, char *str)
+int read_sysfs_string(const char *filename, const char *basedir, char *str)
 {
-	float ret = 0;
+	int ret = 0;
 	FILE  *sysfsfp;
 	char *temp = malloc(strlen(basedir) + strlen(filename) + 2);
 	if (temp == NULL) {
-- 
1.9.1

