Return-Path: <Michael.Hennerich@analog.com>
From: <michael.hennerich@analog.com>
To: <jic23@cam.ac.uk>
CC: <linux-iio@vger.kernel.org>, <device-drivers-devel@blackfin.uclinux.org>,
	<drivers@analog.com>, Michael Hennerich <michael.hennerich@analog.com>
Subject: [PATCH] iio: cdc: Fix pushed event code - Typo, should be IIO_CAPACITANCE.
Date: Wed, 19 Oct 2011 13:39:49 +0200
Message-ID: <1319024389-14243-1-git-send-email-michael.hennerich@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

From: Michael Hennerich <michael.hennerich@analog.com>


Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
---
 drivers/staging/iio/cdc/ad7150.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/iio/cdc/ad7150.c b/drivers/staging/iio/cdc/ad7150.c
index e185f0e..a761ca9 100644
--- a/drivers/staging/iio/cdc/ad7150.c
+++ b/drivers/staging/iio/cdc/ad7150.c
@@ -473,7 +473,7 @@ static irqreturn_t ad7150_event_handler(int irq, void *private)
 	if ((int_status & AD7150_STATUS_OUT1) &&
 	    !(chip->old_state & AD7150_STATUS_OUT1))
 		iio_push_event(indio_dev,
-			       IIO_UNMOD_EVENT_CODE(IIO_VOLTAGE,
+			       IIO_UNMOD_EVENT_CODE(IIO_CAPACITANCE,
 						    0,
 						    IIO_EV_TYPE_THRESH,
 						    IIO_EV_DIR_RISING),
@@ -481,7 +481,7 @@ static irqreturn_t ad7150_event_handler(int irq, void *private)
 	else if ((!(int_status & AD7150_STATUS_OUT1)) &&
 		 (chip->old_state & AD7150_STATUS_OUT1))
 		iio_push_event(indio_dev,
-			       IIO_UNMOD_EVENT_CODE(IIO_VOLTAGE,
+			       IIO_UNMOD_EVENT_CODE(IIO_CAPACITANCE,
 						    0,
 						    IIO_EV_TYPE_THRESH,
 						    IIO_EV_DIR_FALLING),
@@ -490,7 +490,7 @@ static irqreturn_t ad7150_event_handler(int irq, void *private)
 	if ((int_status & AD7150_STATUS_OUT2) &&
 	    !(chip->old_state & AD7150_STATUS_OUT2))
 		iio_push_event(indio_dev,
-			       IIO_UNMOD_EVENT_CODE(IIO_VOLTAGE,
+			       IIO_UNMOD_EVENT_CODE(IIO_CAPACITANCE,
 						    1,
 						    IIO_EV_TYPE_THRESH,
 						    IIO_EV_DIR_RISING),
@@ -498,7 +498,7 @@ static irqreturn_t ad7150_event_handler(int irq, void *private)
 	else if ((!(int_status & AD7150_STATUS_OUT2)) &&
 		 (chip->old_state & AD7150_STATUS_OUT2))
 		iio_push_event(indio_dev,
-			       IIO_UNMOD_EVENT_CODE(IIO_VOLTAGE,
+			       IIO_UNMOD_EVENT_CODE(IIO_CAPACITANCE,
 						    1,
 						    IIO_EV_TYPE_THRESH,
 						    IIO_EV_DIR_FALLING),
-- 
1.7.0.4
