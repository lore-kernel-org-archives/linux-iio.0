Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: greg@kroah.com,
	linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 1/6] staging:iio:triggers reorder module put and device put to ensure that the ops are still there if put results in device deletion.
Date: Wed, 13 Jul 2011 15:05:50 +0100
Message-Id: <1310565955-13469-2-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1310565955-13469-1-git-send-email-jic23@cam.ac.uk>
References: <1310565955-13469-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/trigger.h |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/iio/trigger.h b/drivers/staging/iio/trigger.h
index 325e086..234c774 100644
--- a/drivers/staging/iio/trigger.h
+++ b/drivers/staging/iio/trigger.h
@@ -104,14 +104,14 @@ static inline struct iio_trigger *to_iio_trigger(struct device *d)
 
 static inline void iio_put_trigger(struct iio_trigger *trig)
 {
-	put_device(&trig->dev);
 	module_put(trig->ops->owner);
+	put_device(&trig->dev);
 };
 
 static inline void iio_get_trigger(struct iio_trigger *trig)
 {
-	__module_get(trig->ops->owner);
 	get_device(&trig->dev);
+	__module_get(trig->ops->owner);
 };
 
 /**
-- 
1.7.3.4
