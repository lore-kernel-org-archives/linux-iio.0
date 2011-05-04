Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: arnd@arndb.de,
	Michael.Hennerich@analog.com,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 78/99] staging:iio:adc:ad7816 and adt75 change to meaningful event code.
Date: Wed,  4 May 2011 12:58:50 +0100
Message-Id: <1304510351-10922-79-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1304510351-10922-1-git-send-email-jic23@cam.ac.uk>
References: <1304510351-10922-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

This was another abuse of the buffer event codes.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/adc/ad7816.c |    5 ++++-
 drivers/staging/iio/adc/adt75.c  |    5 ++++-
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7816.c b/drivers/staging/iio/adc/ad7816.c
index bee4209..873fe2b 100644
--- a/drivers/staging/iio/adc/ad7816.c
+++ b/drivers/staging/iio/adc/ad7816.c
@@ -247,7 +247,10 @@ static const struct attribute_group ad7816_attribute_group = {
  * temperature bound events
  */
 
-#define IIO_EVENT_CODE_AD7816_OTI    IIO_BUFFER_EVENT_CODE(0)
+#define IIO_EVENT_CODE_AD7816_OTI IIO_UNMOD_EVENT_CODE(IIO_EV_CLASS_TEMP, \
+						       0,		\
+						       IIO_EV_TYPE_THRESH, \
+						       IIO_EV_DIR_FALLING)
 
 static irqreturn_t ad7816_event_handler(int irq, void *private)
 {
diff --git a/drivers/staging/iio/adc/adt75.c b/drivers/staging/iio/adc/adt75.c
index 4b1c0fa..2a44428 100644
--- a/drivers/staging/iio/adc/adt75.c
+++ b/drivers/staging/iio/adc/adt75.c
@@ -258,7 +258,10 @@ static const struct attribute_group adt75_attribute_group = {
  * temperature bound events
  */
 
-#define IIO_EVENT_CODE_ADT75_OTI    IIO_BUFFER_EVENT_CODE(0)
+#define IIO_EVENT_CODE_ADT75_OTI IIO_UNMOD_EVENT_CODE(IIO_EV_CLASS_TEMP, \
+						      0,		\
+						      IIO_EV_TYPE_THRESH, \
+						      IIO_EV_DIR_FALLING)
 
 static irqreturn_t adt75_event_handler(int irq, void *private)
 {
-- 
1.7.3.4
