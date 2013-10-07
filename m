Return-Path: <bigeasy@linutronix.de>
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	devel@driverdev.osuosl.org,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH] staging: iio: generic_buffer: initialize ret
Date: Mon,  7 Oct 2013 14:42:28 +0200
Message-Id: <1381149748-9341-1-git-send-email-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

The `ret´ variable is only initialized in the error case. For some reason
it was always != 0 while I played with generic_buffer so here is a patch.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/staging/iio/Documentation/iio_utils.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/iio/Documentation/iio_utils.h b/drivers/staging/iio/Documentation/iio_utils.h
index cf32ae0..35154d6 100644
--- a/drivers/staging/iio/Documentation/iio_utils.h
+++ b/drivers/staging/iio/Documentation/iio_utils.h
@@ -502,7 +502,7 @@ inline int find_type_by_name(const char *name, const char *type)
 
 inline int _write_sysfs_int(char *filename, char *basedir, int val, int verify)
 {
-	int ret;
+	int ret = 0;
 	FILE *sysfsfp;
 	int test;
 	char *temp = malloc(strlen(basedir) + strlen(filename) + 2);
-- 
1.8.4.rc3
