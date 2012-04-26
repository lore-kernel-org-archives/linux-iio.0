Return-Path: <lars@metafoo.de>
From: Lars-Peter Clausen <lars@metafoo.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jonathan Cameron <jic23@cam.ac.uk>,
	devel@driverdev.osuosl.org,
	linux-iio@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH] MAINTAINERS: Add new Industrial I/O subsystem location
Date: Thu, 26 Apr 2012 13:46:42 +0200
Message-Id: <1335440802-25450-1-git-send-email-lars@metafoo.de>
List-ID: <linux-iio@vger.kernel.org>

Add the new out-of-staging IIO directory to the IIO MAINTAINERS file entry.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 MAINTAINERS |    1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2dcfca8..4893026 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3384,6 +3384,7 @@ IIO SUBSYSTEM AND DRIVERS
 M:	Jonathan Cameron <jic23@cam.ac.uk>
 L:	linux-iio@vger.kernel.org
 S:	Maintained
+F:	drivers/iio/
 F:	drivers/staging/iio/
 
 IKANOS/ADI EAGLE ADSL USB DRIVER
-- 
1.7.10
