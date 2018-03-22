Return-Path: <SRS0=+IOg=GM=gmail.com=himanshujha199640@kernel.org>
From: Himanshu Jha <himanshujha199640@gmail.com>
To: jic23@kernel.org
Cc: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	knaack.h@gmx.de,
	pmeerw@pmeerw.net,
	gregkh@linuxfoundation.org,
	linux-iio@vger.kernel.org,
	devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org,
	21cnbao@gmail.com,
	Himanshu Jha <himanshujha199640@gmail.com>
Subject: [PATCH 3/4] Staging: iio: accel: adis16201: Fix 80 character line limit
Date: Fri, 23 Mar 2018 00:42:44 +0530
Message-Id: <1521745965-26972-3-git-send-email-himanshujha199640@gmail.com>
In-Reply-To: <1521745965-26972-1-git-send-email-himanshujha199640@gmail.com>
References: <1521230786-18155-10-git-send-email-himanshujha199640@gmail.com>
 <1521745965-26972-1-git-send-email-himanshujha199640@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

Split the line over 80 characters limit to fix checkpatch
warning.

Signed-off-by: Himanshu Jha <himanshujha199640@gmail.com>
---
 drivers/staging/iio/accel/adis16201.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/iio/accel/adis16201.c b/drivers/staging/iio/accel/adis16201.c
index e7593fa..51e1afb 100644
--- a/drivers/staging/iio/accel/adis16201.c
+++ b/drivers/staging/iio/accel/adis16201.c
@@ -206,7 +206,8 @@ static int adis16201_write_raw(struct iio_dev *indio_dev,
 }
 
 static const struct iio_chan_spec adis16201_channels[] = {
-	ADIS_SUPPLY_CHAN(ADIS16201_SUPPLY_OUT_REG, ADIS16201_SCAN_SUPPLY, 0, 12),
+	ADIS_SUPPLY_CHAN(ADIS16201_SUPPLY_OUT_REG, ADIS16201_SCAN_SUPPLY, 0,
+			 12),
 	ADIS_TEMP_CHAN(ADIS16201_TEMP_OUT_REG, ADIS16201_SCAN_TEMP, 0, 12),
 	ADIS_ACCEL_CHAN(X, ADIS16201_XACCL_OUT_REG, ADIS16201_SCAN_ACC_X,
 			BIT(IIO_CHAN_INFO_CALIBBIAS), 0, 14),
-- 
2.7.4
