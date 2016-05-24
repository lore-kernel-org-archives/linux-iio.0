Return-Path: <amsfield22@gmail.com>
Date: Tue, 24 May 2016 12:18:43 -0700
From: Alison Schofield <amsfield22@gmail.com>
To: jic23@kernel.org
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, knaack.h@gmx.de,
	pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 5/7] iio: adc: ad7887: use iio helper function to guarantee
 direct mode
Message-ID: <cce4f683cecf19937334b4f139aa6419e3bda967.1464115008.git.amsfield22@gmail.com>
References: <cover.1464115008.git.amsfield22@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <cover.1464115008.git.amsfield22@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

Replace the code that guarantees the device stays in direct mode
with iio_device_claim_direct_mode() which does same.

Signed-off-by: Alison Schofield <amsfield22@gmail.com>
Cc: Daniel Baluta <daniel.baluta@gmail.com>
---
 drivers/iio/adc/ad7887.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/adc/ad7887.c b/drivers/iio/adc/ad7887.c
index 2d3c397..ee2ccc1 100644
--- a/drivers/iio/adc/ad7887.c
+++ b/drivers/iio/adc/ad7887.c
@@ -156,12 +156,11 @@ static int ad7887_read_raw(struct iio_dev *indio_dev,
 
 	switch (m) {
 	case IIO_CHAN_INFO_RAW:
-		mutex_lock(&indio_dev->mlock);
-		if (iio_buffer_enabled(indio_dev))
-			ret = -EBUSY;
-		else
-			ret = ad7887_scan_direct(st, chan->address);
-		mutex_unlock(&indio_dev->mlock);
+		ret = iio_device_claim_direct_mode(indio_dev);
+		if (ret)
+			return ret;
+		ret = ad7887_scan_direct(st, chan->address);
+		iio_device_release_direct_mode(indio_dev);
 
 		if (ret < 0)
 			return ret;
-- 
2.1.4
