Return-Path: <Michael.Hennerich@analog.com>
From: <michael.hennerich@analog.com>
To: <jic23@cam.ac.uk>
CC: <linux-iio@vger.kernel.org>, <device-drivers-devel@blackfin.uclinux.org>,
	<drivers@analog.com>, Michael Hennerich <michael.hennerich@analog.com>
Subject: [PATCH] iio: accel: ADIS16209: Fix double registration of in_incli0_index
Date: Fri, 26 Aug 2011 13:36:34 +0200
Message-ID: <1314358594-2565-1-git-send-email-michael.hennerich@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

From: Michael Hennerich <michael.hennerich@analog.com>

iio (null): tried to double register : in_incli0_index

Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
---
 drivers/staging/iio/accel/adis16209_core.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/iio/accel/adis16209_core.c b/drivers/staging/iio/accel/adis16209_core.c
index 183b5c2..8d5f1d5 100644
--- a/drivers/staging/iio/accel/adis16209_core.c
+++ b/drivers/staging/iio/accel/adis16209_core.c
@@ -431,11 +431,11 @@ static struct iio_chan_spec adis16209_channels[] = {
 		 (1 << IIO_CHAN_INFO_SCALE_SEPARATE),
 		 in_aux, ADIS16209_SCAN_AUX_ADC,
 		 IIO_ST('u', 12, 16, 0), 0),
-	IIO_CHAN(IIO_INCLI, 0, 1, 0, NULL, 0, IIO_MOD_X,
+	IIO_CHAN(IIO_INCLI, 1, 0, 0, NULL, 0, IIO_MOD_X,
 		 (1 << IIO_CHAN_INFO_SCALE_SHARED),
 		 incli_x, ADIS16209_SCAN_INCLI_X,
 		 IIO_ST('s', 14, 16, 0), 0),
-	IIO_CHAN(IIO_INCLI, 0, 1, 0, NULL, 0, IIO_MOD_Y,
+	IIO_CHAN(IIO_INCLI, 1, 0, 0, NULL, 0, IIO_MOD_Y,
 		 (1 << IIO_CHAN_INFO_SCALE_SHARED),
 		 incli_y, ADIS16209_SCAN_INCLI_Y,
 		 IIO_ST('s', 14, 16, 0), 0),
-- 
1.7.0.4
