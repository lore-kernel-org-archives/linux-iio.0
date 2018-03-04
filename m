Return-Path: <SRS0=vAg0=F2=gmail.com=shreeya.patel23498@kernel.org>
From: Shreeya Patel <shreeya.patel23498@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org,
	knaack.h@gmx.de,
	pmeerw@pmeerw.net,
	gregkh@linuxfoundation.org,
	linux-iio@vger.kernel.org,
	devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org,
	daniel.baluta@gmail.com
Cc: Shreeya Patel <shreeya.patel23498@gmail.com>
Subject: [PATCH v3 3/4] Staging: iio: adis16209: Adjust a switch statement
Date: Sun,  4 Mar 2018 18:13:12 +0530
Message-Id: <5c523865f71eb68181bd2b207685bdf5e9b8da83.1520164945.git.shreeya.patel23498@gmail.com>
In-Reply-To: <cover.1520164945.git.shreeya.patel23498@gmail.com>
References: <cover.1520164945.git.shreeya.patel23498@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

Adjust a switch block to explicitly match channels and
return -EINVAL as default case which makes the code
semantically more clear.

Signed-off-by: Shreeya Patel <shreeya.patel23498@gmail.com>
---

Changes in v3
  -After split patch.

 drivers/staging/iio/accel/adis16209.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/iio/accel/adis16209.c b/drivers/staging/iio/accel/adis16209.c
index eb5c878..9cb1ce0 100644
--- a/drivers/staging/iio/accel/adis16209.c
+++ b/drivers/staging/iio/accel/adis16209.c
@@ -155,10 +155,16 @@ static int adis16209_read_raw(struct iio_dev *indio_dev,
 		switch (chan->type) {
 		case IIO_VOLTAGE:
 			*val = 0;
-			if (chan->channel == 0)
+			switch (chan->channel) {
+			case 0:
 				*val2 = 305180; /* 0.30518 mV */
-			else
+				break;
+			case 1:
 				*val2 = 610500; /* 0.6105 mV */
+				break;
+			default:
+				return -EINVAL;
+			}
 			return IIO_VAL_INT_PLUS_MICRO;
 		case IIO_TEMP:
 			*val = -470;
-- 
2.7.4
