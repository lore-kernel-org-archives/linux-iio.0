Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:43404 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753030AbaFGPnD (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Sat, 7 Jun 2014 11:43:03 -0400
From: Peter Meerwald <pmeerw@pmeerw.net>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org, Peter Meerwald <pmeerw@pmeerw.net>
Subject: [PATCH 08/12] staging:iio: Fix iio_utils.h function prototypes
Date: Sat,  7 Jun 2014 17:42:48 +0200
Message-Id: <1402155772-1373-9-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1402155772-1373-1-git-send-email-pmeerw@pmeerw.net>
References: <1402155772-1373-1-git-send-email-pmeerw@pmeerw.net>
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

