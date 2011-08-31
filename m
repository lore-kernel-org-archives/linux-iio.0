Return-Path: <Michael.Hennerich@analog.com>
From: <michael.hennerich@analog.com>
To: <jic23@cam.ac.uk>
CC: <linux-iio@vger.kernel.org>, <device-drivers-devel@blackfin.uclinux.org>,
	<drivers@analog.com>, Michael Hennerich <michael.hennerich@analog.com>
Subject: [PATCH 07/12] iio: ad7291: introduce IIO_EVENT_CODE_EXTRACT_CHAN_TYPE and use accordingly
Date: Wed, 31 Aug 2011 12:57:35 +0200
Message-ID: <1314788260-5791-7-git-send-email-michael.hennerich@analog.com>
In-Reply-To: <1314788260-5791-1-git-send-email-michael.hennerich@analog.com>
References: <1314788260-5791-1-git-send-email-michael.hennerich@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

From: Michael Hennerich <michael.hennerich@analog.com>

Fix channel type handling

Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
---
 drivers/staging/iio/adc/ad7291.c |    6 +++---
 drivers/staging/iio/sysfs.h      |    1 +
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7291.c b/drivers/staging/iio/adc/ad7291.c
index 7dfdc27..b365a74 100644
--- a/drivers/staging/iio/adc/ad7291.c
+++ b/drivers/staging/iio/adc/ad7291.c
@@ -313,7 +313,7 @@ static int ad7291_read_event_value(struct iio_dev *indio_dev,
 	u16 uval;
 	s16 signval;
 
-	switch (IIO_EVENT_CODE_EXTRACT_TYPE(event_code)) {
+	switch (IIO_EVENT_CODE_EXTRACT_CHAN_TYPE(event_code)) {
 	case IIO_VOLTAGE:
 		reg = ad7291_limit_regs[IIO_EVENT_CODE_EXTRACT_NUM(event_code)]
 			[!(IIO_EVENT_CODE_EXTRACT_DIR(event_code) ==
@@ -349,7 +349,7 @@ static int ad7291_write_event_value(struct iio_dev *indio_dev,
 	u8 reg;
 	s16 signval;
 
-	switch (IIO_EVENT_CODE_EXTRACT_TYPE(event_code)) {
+	switch (IIO_EVENT_CODE_EXTRACT_CHAN_TYPE(event_code)) {
 	case IIO_VOLTAGE:
 		if (val > 0xFFF || val < 0)
 			return -EINVAL;
@@ -377,7 +377,7 @@ static int ad7291_read_event_config(struct iio_dev *indio_dev,
 	/* To be enabled the channel must simply be on. If any are enabled
 	   we are in continuous sampling mode */
 
-	switch (IIO_EVENT_CODE_EXTRACT_TYPE(event_code)) {
+	switch (IIO_EVENT_CODE_EXTRACT_CHAN_TYPE(event_code)) {
 	case IIO_VOLTAGE:
 		if (chip->c_mask &
 		    (1 << IIO_EVENT_CODE_EXTRACT_NUM(event_code)))
diff --git a/drivers/staging/iio/sysfs.h b/drivers/staging/iio/sysfs.h
index aad1f4b..d98d12d 100644
--- a/drivers/staging/iio/sysfs.h
+++ b/drivers/staging/iio/sysfs.h
@@ -147,6 +147,7 @@ enum iio_event_direction {
 
 #define IIO_EVENT_CODE_EXTRACT_TYPE(mask) ((mask >> 56) & 0xFF)
 #define IIO_EVENT_CODE_EXTRACT_DIR(mask) ((mask >> 48) & 0xFF)
+#define IIO_EVENT_CODE_EXTRACT_CHAN_TYPE(mask) ((mask >> 32) & 0xFF)
 
 /* Event code number extraction depends on which type of event we have.
  * Perhaps review this function in the future*/
-- 
1.7.0.4
