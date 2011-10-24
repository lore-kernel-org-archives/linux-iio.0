Return-Path: <lars@metafoo.de>
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
CC: Michael Hennerich <michael.hennerich@analog.com>,
	<linux-iio@vger.kernel.org>, <device-drivers-devel@blackfin.uclinux.org>,
	<drivers@analog.com>, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH] staging:iio:iio_utils.h: Add missing include
Date: Mon, 24 Oct 2011 13:56:16 +0200
Message-ID: <1319457376-16397-1-git-send-email-lars@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

iio_utils.h uses opendir and friends which need dirent.h

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/staging/iio/Documentation/iio_utils.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/staging/iio/Documentation/iio_utils.h b/drivers/staging/iio/Documentation/iio_utils.h
index 75938b2..dbbad8a 100644
--- a/drivers/staging/iio/Documentation/iio_utils.h
+++ b/drivers/staging/iio/Documentation/iio_utils.h
@@ -13,6 +13,7 @@
 #include <ctype.h>
 #include <stdio.h>
 #include <stdint.h>
+#include <dirent.h>
 
 #define IIO_MAX_NAME_LENGTH 30
 
-- 
1.7.7
