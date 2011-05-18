Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-52.csi.cam.ac.uk ([131.111.8.152]:54111 "EHLO
	ppsw-52.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933246Ab1ERNkH (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 18 May 2011 09:40:07 -0400
From: Jonathan Cameron <jic23@cam.ac.uk>
To: greg@kroah.com
Cc: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 084/111] staging:iio:adc:ad7816 and adt75 change to meaningful event code.
Date: Wed, 18 May 2011 14:42:14 +0100
Message-Id: <1305726161-5606-85-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1305726161-5606-1-git-send-email-jic23@cam.ac.uk>
References: <1305726161-5606-1-git-send-email-jic23@cam.ac.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

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

