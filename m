Return-Path: <pmeerw@pmeerw.net>
From: Peter Meerwald <pmeerw@pmeerw.net>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Oleksandr Kravchenko <o.v.kravchenko@globallogic.com>
Subject: [PATCH 02/13] iio:bma180: Missing check for frequency fractional part
Date: Wed, 16 Jul 2014 20:32:45 +0200
Message-Id: <1405535576-26482-3-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1405535576-26482-1-git-send-email-pmeerw@pmeerw.net>
References: <1405535576-26482-1-git-send-email-pmeerw@pmeerw.net>
List-ID: <linux-iio@vger.kernel.org>

val2 should be zero

Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
Cc: Oleksandr Kravchenko <o.v.kravchenko@globallogic.com>
---
 drivers/iio/accel/bma180.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iio/accel/bma180.c b/drivers/iio/accel/bma180.c
index 28388bb..a077cc8 100644
--- a/drivers/iio/accel/bma180.c
+++ b/drivers/iio/accel/bma180.c
@@ -376,6 +376,8 @@ static int bma180_write_raw(struct iio_dev *indio_dev,
 		mutex_unlock(&data->mutex);
 		return ret;
 	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
+		if (val2)
+			return -EINVAL;
 		mutex_lock(&data->mutex);
 		ret = bma180_set_bw(data, val);
 		mutex_unlock(&data->mutex);
-- 
1.9.1
