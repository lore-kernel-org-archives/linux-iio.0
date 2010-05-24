Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 10/11] staging:iio: Add ability to have event attributes with awkward names
Date: Mon, 24 May 2010 22:02:55 +0100
Message-Id: <1274734976-7941-11-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1274734976-7941-1-git-send-email-jic23@cam.ac.uk>
References: <1274734976-7941-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/sysfs.h |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/drivers/staging/iio/sysfs.h b/drivers/staging/iio/sysfs.h
index 79926ef..6083416 100644
--- a/drivers/staging/iio/sysfs.h
+++ b/drivers/staging/iio/sysfs.h
@@ -284,6 +284,14 @@ struct iio_const_attr {
 	    .mask = _mask,						\
 	    .listel = &_ev_list };
 
+#define IIO_EVENT_ATTR_NAMED_SH(_vname, _name, _ev_list, _show, _store, _mask) \
+	static struct iio_event_attr					\
+	iio_event_attr_##_vname						\
+	= { .dev_attr = __ATTR(_name, S_IRUGO | S_IWUSR,		\
+			       _show, _store),				\
+	    .mask = _mask,						\
+	    .listel = &_ev_list };
+
 /**
  * IIO_EVENT_ATTR - non-shared event attribute
  * @_name: event name
-- 
1.7.0.4
