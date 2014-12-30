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
Subject: [PATCH 1/2] iio: amplifiers: ad8366: Remove space before ','
Date: Tue, 30 Dec 2014 20:45:43 +0200
Message-Id: <1419965144-3988-2-git-send-email-roberta.dobrescu@gmail.com>
In-Reply-To: <1419965144-3988-1-git-send-email-roberta.dobrescu@gmail.com>
References: <1419965144-3988-1-git-send-email-roberta.dobrescu@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

This patch fixes the following checkpatch.pl error:
ERROR: space prohibited before that ',' (ctx:WxW)

Signed-off-by: Roberta Dobrescu <roberta.dobrescu@gmail.com>
---
 drivers/iio/amplifiers/ad8366.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/amplifiers/ad8366.c b/drivers/iio/amplifiers/ad8366.c
index ba6f6a9..fce25a0 100644
--- a/drivers/iio/amplifiers/ad8366.c
+++ b/drivers/iio/amplifiers/ad8366.c
@@ -166,7 +166,7 @@ static int ad8366_probe(struct spi_device *spi)
 	if (ret)
 		goto error_disable_reg;
 
-	ad8366_write(indio_dev, 0 , 0);
+	ad8366_write(indio_dev, 0, 0);
 
 	return 0;
 
-- 
1.9.1
