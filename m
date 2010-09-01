Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 7/9] staging:iio: remove odd structure definition.
Date: Wed,  1 Sep 2010 15:58:01 +0100
Message-Id: <1283353083-31313-8-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1283353083-31313-1-git-send-email-jic23@cam.ac.uk>
References: <1283353083-31313-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

I've no idea where this came from!
Also fixed form -> from in comment

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/trigger.h |    4 ----
 1 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/iio/trigger.h b/drivers/staging/iio/trigger.h
index 4699586..200d02e 100644
--- a/drivers/staging/iio/trigger.h
+++ b/drivers/staging/iio/trigger.h
@@ -161,8 +161,4 @@ struct iio_trigger *iio_allocate_trigger(void);
 
 void iio_free_trigger(struct iio_trigger *trig);
 
-
-struct iio_simple_trigger {
-	struct iio_trigger trig;
-};
 #endif /* _IIO_TRIGGER_H_ */
-- 
1.7.1
