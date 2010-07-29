Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: Greg KH <greg@kroah.com>
Cc: Randy Dunlap <randy.dunlap@oracle.com>,
	akpm@linux-foundation.org,
	linux-iio@vger.kernel.org,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 4/6] staging:iio:ring_sw  Add select of triggers to avoid build issue.
Date: Thu, 29 Jul 2010 17:50:49 +0100
Message-Id: <1280422251-13572-5-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1280422251-13572-1-git-send-email-jic23@cam.ac.uk>
References: <1280422251-13572-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Currently all drivers that use ring_sw use triggers and I am yet
to see a good reason for any driver not doing so.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/Kconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/staging/iio/Kconfig b/drivers/staging/iio/Kconfig
index 569b938..ed48815 100644
--- a/drivers/staging/iio/Kconfig
+++ b/drivers/staging/iio/Kconfig
@@ -21,6 +21,7 @@ config IIO_RING_BUFFER
 if IIO_RING_BUFFER
 
 config IIO_SW_RING
+       select IIO_TRIGGER
 	tristate "Industrial I/O lock free software ring"
 	help
 	  Example software ring buffer implementation.  The design aim
-- 
1.7.1
