Return-Path: <SRS0=rqf4=IR=canonical.com=colin.king@kernel.org>
From: Colin King <colin.king@canonical.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Brian Masney <masneyb@onstation.org>,
	linux-iio@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] iio: tsl2x7x/tsl2772: avoid potential division by zero
Date: Wed, 30 May 2018 19:19:36 +0100
Message-Id: <20180530181936.17902-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-ID: <linux-iio@vger.kernel.org>

From: Colin Ian King <colin.king@canonical.com>

It may be possible for tsl2772_get_lux to return a zero lux value
and hence a division by zero can occur when lux_val is zero. Check
for this case and return -ERANGE to avoid the division by zero.

Detected by CoverityScan, CID#1469484 ("Division or modulo by zero")

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/iio/light/tsl2772.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iio/light/tsl2772.c b/drivers/iio/light/tsl2772.c
index 34d42a2504c9..df5b2a0da96c 100644
--- a/drivers/iio/light/tsl2772.c
+++ b/drivers/iio/light/tsl2772.c
@@ -582,6 +582,8 @@ static int tsl2772_als_calibrate(struct iio_dev *indio_dev)
 			"%s: failed to get lux\n", __func__);
 		return lux_val;
 	}
+	if (lux_val == 0)
+		return -ERANGE;
 
 	ret = (chip->settings.als_cal_target * chip->settings.als_gain_trim) /
 			lux_val;
-- 
2.17.0
