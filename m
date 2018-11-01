Return-Path: <SRS0=tw9e=NM=gmail.com=renatogeh@kernel.org>
Date: Thu, 1 Nov 2018 11:43:02 -0300
From: Renato Lui Geh <renatogeh@gmail.com>
To: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
	knaack.h@gmx.de, pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
	giuliano.belinassi@usp.br
Cc: linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com
Subject: [PATCH v3 1/3] staging: iio: ad7780: fix offset read value
Message-ID: <2191be4d531651db39682178ec0660eeb5697439.1541082656.git.renatogeh@gmail.com>
References: <cover.1541082656.git.renatogeh@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
In-Reply-To: <cover.1541082656.git.renatogeh@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

Variable val subtracted an uninitialized value on IIO_CHAN_INFO_OFFSET.
This was fixed by assigning the correct value instead.

Signed-off-by: Renato Lui Geh <renatogeh@gmail.com>
---
 drivers/staging/iio/adc/ad7780.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/iio/adc/ad7780.c b/drivers/staging/iio/adc/ad7780.c
index b67412db0318..91e016d534ed 100644
--- a/drivers/staging/iio/adc/ad7780.c
+++ b/drivers/staging/iio/adc/ad7780.c
@@ -96,7 +96,7 @@ static int ad7780_read_raw(struct iio_dev *indio_dev,
 		*val2 = chan->scan_type.realbits - 1;
 		return IIO_VAL_FRACTIONAL_LOG2;
 	case IIO_CHAN_INFO_OFFSET:
-		*val -= (1 << (chan->scan_type.realbits - 1));
+		*val = -(1 << (chan->scan_type.realbits - 1));
 		return IIO_VAL_INT;
 	}
 
-- 
2.19.1
