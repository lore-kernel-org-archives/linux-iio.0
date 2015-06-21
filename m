Return-Path: <pmeerw@pmeerw.net>
From: Peter Meerwald <pmeerw@pmeerw.net>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org,
	Peter Meerwald <pmeerw@pmeerw.net>
Subject: [PATCH 1/2] iio: tmp006: Check channel info on write
Date: Sun, 21 Jun 2015 23:50:21 +0200
Message-Id: <1434923422-17609-1-git-send-email-pmeerw@pmeerw.net>
List-ID: <linux-iio@vger.kernel.org>

only SAMP_FREQ is writable

Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
---
 drivers/iio/temperature/tmp006.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iio/temperature/tmp006.c b/drivers/iio/temperature/tmp006.c
index 84a0789..7a80509 100644
--- a/drivers/iio/temperature/tmp006.c
+++ b/drivers/iio/temperature/tmp006.c
@@ -132,6 +132,9 @@ static int tmp006_write_raw(struct iio_dev *indio_dev,
 	struct tmp006_data *data = iio_priv(indio_dev);
 	int i;
 
+	if (mask != IIO_CHAN_INFO_SAMP_FREQ)
+		return -EINVAL;
+
 	for (i = 0; i < ARRAY_SIZE(tmp006_freqs); i++)
 		if ((val == tmp006_freqs[i][0]) &&
 		    (val2 == tmp006_freqs[i][1])) {
-- 
1.9.1
