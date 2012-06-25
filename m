Return-Path: <pmeerw@pmeerw.net>
From: Peter Meerwald <pmeerw@pmeerw.net>
To: linux-iio@vger.kernel.org
Cc: jic23@cam.ac.uk
Subject: [PATCH 7/7] iio staging: quell asprintf() warning, missing #includes
Date: Mon, 25 Jun 2012 21:11:45 +0200
Message-Id: <1340651505-31081-7-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1340651505-31081-1-git-send-email-pmeerw@pmeerw.net>
References: <1340651505-31081-1-git-send-email-pmeerw@pmeerw.net>
List-ID: <linux-iio@vger.kernel.org>

Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net
---
 drivers/staging/iio/Documentation/generic_buffer.c |    3 +++
 drivers/staging/iio/Documentation/iio_utils.h      |    1 +
 2 files changed, 4 insertions(+)

diff --git a/drivers/staging/iio/Documentation/generic_buffer.c b/drivers/staging/iio/Documentation/generic_buffer.c
index 1dd0681..aaf6146 100644
--- a/drivers/staging/iio/Documentation/generic_buffer.c
+++ b/drivers/staging/iio/Documentation/generic_buffer.c
@@ -18,6 +18,8 @@
  *
  */
 
+#define _GNU_SOURCE
+
 #include <unistd.h>
 #include <dirent.h>
 #include <fcntl.h>
@@ -29,6 +31,7 @@
 #include <string.h>
 #include <poll.h>
 #include <endian.h>
+#include <getopt.h>
 #include <inttypes.h>
 #include "iio_utils.h"
 
diff --git a/drivers/staging/iio/Documentation/iio_utils.h b/drivers/staging/iio/Documentation/iio_utils.h
index 9c7a5aa..c0448b3 100644
--- a/drivers/staging/iio/Documentation/iio_utils.h
+++ b/drivers/staging/iio/Documentation/iio_utils.h
@@ -13,6 +13,7 @@
 #include <stdio.h>
 #include <stdint.h>
 #include <dirent.h>
+#include <errno.h>
 
 /* Made up value to limit allocation sizes */
 #define IIO_MAX_NAME_LENGTH 30
-- 
1.7.9.5
