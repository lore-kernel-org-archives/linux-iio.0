Return-Path: <Michael.Hennerich@analog.com>
From: <michael.hennerich@analog.com>
To: <jic23@cam.ac.uk>
CC: <linux-iio@vger.kernel.org>, <device-drivers-devel@blackfin.uclinux.org>,
	<drivers@analog.com>, Michael Hennerich <michael.hennerich@analog.com>
Subject: [PATCH 08/12] iio: ad7291: fix channel mapping for event enables
Date: Wed, 31 Aug 2011 12:57:36 +0200
Message-ID: <1314788260-5791-8-git-send-email-michael.hennerich@analog.com>
In-Reply-To: <1314788260-5791-1-git-send-email-michael.hennerich@analog.com>
References: <1314788260-5791-1-git-send-email-michael.hennerich@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

From: Michael Hennerich <michael.hennerich@analog.com>


Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
---
 drivers/staging/iio/adc/ad7291.c |   24 ++++++++++++------------
 1 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7291.c b/drivers/staging/iio/adc/ad7291.c
index b365a74..1a2fa66 100644
--- a/drivers/staging/iio/adc/ad7291.c
+++ b/drivers/staging/iio/adc/ad7291.c
@@ -100,7 +100,7 @@ struct ad7291_chip_info {
 	struct regulator	*reg;
 	u16			int_vref_mv;
 	u16			command;
-	u8			c_mask;	/* Active voltage channels for events */
+	u16			c_mask;	/* Active voltage channels for events */
 	struct mutex 		state_lock;
 };
 
@@ -380,7 +380,7 @@ static int ad7291_read_event_config(struct iio_dev *indio_dev,
 	switch (IIO_EVENT_CODE_EXTRACT_CHAN_TYPE(event_code)) {
 	case IIO_VOLTAGE:
 		if (chip->c_mask &
-		    (1 << IIO_EVENT_CODE_EXTRACT_NUM(event_code)))
+		    (1 << (15 - IIO_EVENT_CODE_EXTRACT_NUM(event_code))))
 			return 1;
 		else
 			return 0;
@@ -411,19 +411,19 @@ static int ad7291_write_event_config(struct iio_dev *indio_dev,
 
 	switch (IIO_EVENT_CODE_EXTRACT_TYPE(event_code)) {
 	case IIO_VOLTAGE:
-		if ((!state) && (chip->c_mask &
-			       (1 << IIO_EVENT_CODE_EXTRACT_NUM(event_code))))
-			chip->c_mask &=
-				~(1 << IIO_EVENT_CODE_EXTRACT_NUM(event_code));
-		else if (state && (!(chip->c_mask &
-				(1 << IIO_EVENT_CODE_EXTRACT_NUM(event_code)))))
-			chip->c_mask |=
-				(1 << IIO_EVENT_CODE_EXTRACT_NUM(event_code));
+		if ((!state) && (chip->c_mask & (1 << (15 -
+				IIO_EVENT_CODE_EXTRACT_NUM(event_code)))))
+			chip->c_mask &= ~(1 << (15 - IIO_EVENT_CODE_EXTRACT_NUM
+							(event_code)));
+		else if (state && (!(chip->c_mask & (1 << (15 -
+				IIO_EVENT_CODE_EXTRACT_NUM(event_code))))))
+			chip->c_mask |= (1 << (15 - IIO_EVENT_CODE_EXTRACT_NUM
+							(event_code)));
 		else
 			break;
 
 		regval &= ~AD7291_AUTOCYCLE;
-		regval |= ((u16)chip->c_mask << 8);
+		regval |= chip->c_mask;
 		if (chip->c_mask) /* Enable autocycle? */
 			regval |= AD7291_AUTOCYCLE;
 
@@ -460,7 +460,7 @@ static int ad7291_read_raw(struct iio_dev *indio_dev,
 		case IIO_VOLTAGE:
 			mutex_lock(&chip->state_lock);
 			/* If in autocycle mode drop through */
-			if (chip->command & 0x1) {
+			if (chip->command & AD7291_AUTOCYCLE) {
 				mutex_unlock(&chip->state_lock);
 				return -EBUSY;
 			}
-- 
1.7.0.4
