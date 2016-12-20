Return-Path: <SRS0=uEov=YD=pmeerw.net=pmeerw@kernel.org>
From: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: [PATCH] iio: dummy: No semicolon at end of function definition
Date: Tue, 20 Dec 2016 17:38:10 +0100
Message-Id: <1482251890-9721-1-git-send-email-pmeerw@pmeerw.net>
List-ID: <linux-iio@vger.kernel.org>

Signed-off-by: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
---
 drivers/iio/dummy/iio_simple_dummy.h |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/dummy/iio_simple_dummy.h b/drivers/iio/dummy/iio_simple_dummy.h
index b9069a1..f7005c3 100644
--- a/drivers/iio/dummy/iio_simple_dummy.h
+++ b/drivers/iio/dummy/iio_simple_dummy.h
@@ -88,11 +88,11 @@ int iio_simple_dummy_write_event_value(struct iio_dev *indio_dev,
 iio_simple_dummy_events_register(struct iio_dev *indio_dev)
 {
 	return 0;
-};
+}
 
 static inline void
 iio_simple_dummy_events_unregister(struct iio_dev *indio_dev)
-{ };
+{}
 
 #endif /* CONFIG_IIO_SIMPLE_DUMMY_EVENTS*/
 
@@ -119,11 +119,11 @@ enum iio_simple_dummy_scan_elements {
 static inline int iio_simple_dummy_configure_buffer(struct iio_dev *indio_dev)
 {
 	return 0;
-};
+}
 
 static inline
 void iio_simple_dummy_unconfigure_buffer(struct iio_dev *indio_dev)
-{};
+{}
 
 #endif /* CONFIG_IIO_SIMPLE_DUMMY_BUFFER */
 #endif /* _IIO_SIMPLE_DUMMY_H_ */
-- 
1.7.10.4
