Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: greg@kroah.com
Cc: linux-iio@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 09/10] staging:iio:iio_utils.h: Add missing include
Date: Wed, 26 Oct 2011 17:27:44 +0100
Message-Id: <1319646465-2788-10-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1319646465-2788-1-git-send-email-jic23@cam.ac.uk>
References: <1319646465-2788-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

From: Lars-Peter Clausen <lars@metafoo.de>

iio_utils.h uses opendir and friends which need dirent.h

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
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
