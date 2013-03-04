Return-Path: <lars@metafoo.de>
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>,
	Patrick Vasseur <patrick.vasseur@c-s.fr>,
	Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH 1/3] iio:ad7923: Return error if we didn't get the expected result
Date: Mon,  4 Mar 2013 20:30:29 +0100
Message-Id: <1362425431-24725-1-git-send-email-lars@metafoo.de>
List-ID: <linux-iio@vger.kernel.org>

Instead of leaving 'val' uninitialized return an error if the result's address
did not match that of the channel we were trying to read.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Cc: Patrick Vasseur <patrick.vasseur@c-s.fr>
Cc: Christophe Leroy <christophe.leroy@c-s.fr>
---
 drivers/iio/adc/ad7923.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iio/adc/ad7923.c b/drivers/iio/adc/ad7923.c
index 766c740..36eee24 100644
--- a/drivers/iio/adc/ad7923.c
+++ b/drivers/iio/adc/ad7923.c
@@ -199,6 +199,8 @@ static int ad7923_read_raw(struct iio_dev *indio_dev,
 
 		if (chan->address == EXTRACT(ret, 12, 4))
 			*val = EXTRACT(ret, 0, 12);
+		else
+			return -EIO;
 
 		return IIO_VAL_INT;
 	}
-- 
1.8.0
