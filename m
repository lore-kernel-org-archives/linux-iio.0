Return-Path: <SRS0=GN8S=K2=gmail.com=himanshujha199640@kernel.org>
From: Himanshu Jha <himanshujha199640@gmail.com>
To: jic23@kernel.org
Cc: dpfrey@gmail.com,
	daniel.baluta@gmail.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Himanshu Jha <himanshujha199640@gmail.com>
Subject: [PATCH] iio: chemical: bme680: Add check for val2 in the write_raw function
Date: Sat, 11 Aug 2018 15:56:36 +0530
Message-Id: <20180811102636.6171-1-himanshujha199640@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

val2 is responsible for the floating part of the number to be
written to the device. We don't need the floating part
while writing the oversampling ratio for BME680 since the
available oversampling ratios are pure natural numbers.

So, add a sanity check to make sure val2 is 0.

Signed-off-by: Himanshu Jha <himanshujha199640@gmail.com>
---
 drivers/iio/chemical/bme680_core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iio/chemical/bme680_core.c b/drivers/iio/chemical/bme680_core.c
index 7d9bb62baa3f..9d5a05e054d1 100644
--- a/drivers/iio/chemical/bme680_core.c
+++ b/drivers/iio/chemical/bme680_core.c
@@ -852,6 +852,9 @@ static int bme680_write_raw(struct iio_dev *indio_dev,
 {
 	struct bme680_data *data = iio_priv(indio_dev);
 
+	if (val2 != 0)
+		return -EINVAL;
+
 	switch (mask) {
 	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
 		switch (chan->type) {
-- 
2.17.1
