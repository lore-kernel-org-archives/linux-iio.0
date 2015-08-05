Return-Path: <23055997@se.extranet.sonyericsson.com>
From: Lars Svensson <lars1.svensson@sonymobile.com>
To: <jic23@kernel.org>
CC: <knaack.h@gmx.de>, <lars@metafoo.de>, <pmeerw@pmeerw.net>,
	<gregkh@linuxfoundation.org>, <linux-iio@vger.kernel.org>,
	<devel@driverdev.osuosl.org>, <linux-kernel@vger.kernel.org>, Lars Svensson
	<lars1.svensson@sonymobile.com>
Subject: [PATCH] staging: iio_simple_dummy: Fix indentation errors
Date: Wed, 5 Aug 2015 14:15:12 +0200
Message-ID: <1438776912-25798-1-git-send-email-lars1.svensson@sonymobile.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

Fixing indentation errors in
drivers/staging/iio/iio_simple_dummy_events.c.

Signed-off-by: Lars Svensson <lars1.svensson@sonymobile.com>
---
 drivers/staging/iio/iio_simple_dummy_events.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/iio/iio_simple_dummy_events.c b/drivers/staging/iio/iio_simple_dummy_events.c
index ecc563c..73108ba 100644
--- a/drivers/staging/iio/iio_simple_dummy_events.c
+++ b/drivers/staging/iio/iio_simple_dummy_events.c
@@ -120,7 +120,7 @@ int iio_simple_dummy_read_event_value(struct iio_dev *indio_dev,
 				      const struct iio_chan_spec *chan,
 				      enum iio_event_type type,
 				      enum iio_event_direction dir,
-					  enum iio_event_info info,
+				      enum iio_event_info info,
 				      int *val, int *val2)
 {
 	struct iio_dummy_state *st = iio_priv(indio_dev);
@@ -143,7 +143,7 @@ int iio_simple_dummy_write_event_value(struct iio_dev *indio_dev,
 				       const struct iio_chan_spec *chan,
 				       enum iio_event_type type,
 				       enum iio_event_direction dir,
-					   enum iio_event_info info,
+				       enum iio_event_info info,
 				       int val, int val2)
 {
 	struct iio_dummy_state *st = iio_priv(indio_dev);
-- 
1.8.2.2
