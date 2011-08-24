Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-52.csi.cam.ac.uk ([131.111.8.152]:49243 "EHLO
	ppsw-52.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752226Ab1HXQUc (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 24 Aug 2011 12:20:32 -0400
From: Jonathan Cameron <jic23@cam.ac.uk>
To: greg@kroah.com
Cc: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 2/9] staging:iio:triggers reorder module put and device put to ensure that the ops are still there if put results in device deletion.
Date: Wed, 24 Aug 2011 17:28:34 +0100
Message-Id: <1314203321-21926-3-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1314203321-21926-1-git-send-email-jic23@cam.ac.uk>
References: <1314203321-21926-1-git-send-email-jic23@cam.ac.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

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

