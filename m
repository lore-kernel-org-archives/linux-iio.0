Return-Path: <LW@KARO-electronics.de>
From: =?UTF-8?q?Lothar=20Wa=C3=9Fmann?= <LW@KARO-electronics.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-iio@vger.kernel.org,
	=?UTF-8?q?Lothar=20Wa=C3=9Fmann?= <LW@KARO-electronics.de>
Subject: [PATCH] BUGFIX: staging:iio:core add missing increment of loop index in iio_map_array_unregister()
Date: Sat, 24 Mar 2012 07:19:25 +0100
Message-Id: <1332569965-18350-1-git-send-email-LW@KARO-electronics.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

staging:iio:core add missing increment of loop index in iio_map_array_unregister()

Signed-off-by: Lothar Waßmann <LW@KARO-electronics.de>
---
 drivers/staging/iio/inkern.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/staging/iio/inkern.c b/drivers/staging/iio/inkern.c
index de2c8ea..ef07a02b 100644
--- a/drivers/staging/iio/inkern.c
+++ b/drivers/staging/iio/inkern.c
@@ -82,6 +82,7 @@ int iio_map_array_unregister(struct iio_dev *indio_dev,
 			ret = -ENODEV;
 			goto error_ret;
 		}
+		i++;
 	}
 error_ret:
 	mutex_unlock(&iio_map_list_lock);
-- 
1.7.2.5
