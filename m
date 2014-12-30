Return-Path: <roberta.dobrescu@gmail.com>
From: Roberta Dobrescu <roberta.dobrescu@gmail.com>
To: jic23@kernel.org,
	linux-iio@vger.kernel.org
Cc: octavian.purdila@intel.com,
	daniel.baluta@intel.com,
	lars@metafoo.de,
	Michael.Hennerich@analog.com,
	knaack.h@gmx.de,
	pmeerw@pmeerw.net,
	Roberta Dobrescu <roberta.dobrescu@gmail.com>
Subject: [PATCH 2/2] iio: amplifiers: ad8366: Use right order for type specification
Date: Tue, 30 Dec 2014 20:45:44 +0200
Message-Id: <1419965144-3988-3-git-send-email-roberta.dobrescu@gmail.com>
In-Reply-To: <1419965144-3988-1-git-send-email-roberta.dobrescu@gmail.com>
References: <1419965144-3988-1-git-send-email-roberta.dobrescu@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

This patch fixes the following checkpatch.pl warning:
WARNING: type 'char unsigned' should be specified in [[un]signed]
[short|int|long|long long] order

Signed-off-by: Roberta Dobrescu <roberta.dobrescu@gmail.com>
---
 drivers/iio/amplifiers/ad8366.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/amplifiers/ad8366.c b/drivers/iio/amplifiers/ad8366.c
index fce25a0..c0d364e 100644
--- a/drivers/iio/amplifiers/ad8366.c
+++ b/drivers/iio/amplifiers/ad8366.c
@@ -31,7 +31,7 @@ struct ad8366_state {
 };
 
 static int ad8366_write(struct iio_dev *indio_dev,
-			unsigned char ch_a, char unsigned ch_b)
+			unsigned char ch_a, unsigned char ch_b)
 {
 	struct ad8366_state *st = iio_priv(indio_dev);
 	int ret;
-- 
1.9.1
