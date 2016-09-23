Return-Path: <bankarsandhya512@gmail.com>
Date: Fri, 23 Sep 2016 11:43:12 +0530
From: Sandhya Bankar <bankarsandhya512@gmail.com>
To: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
	linux-iio@vger.kernel.org
Subject: [PATCH] drivers: iio: max1027: Fix sparse warning: "dubious: x | !y"
Message-ID: <20160923061312.GA5050@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <linux-iio@vger.kernel.org>

Fixing below warning:
drivers/iio/adc/max1027.c:241:34: warning: dubious: x | !y .

Signed-off-by: Sandhya Bankar <bankarsandhya512@gmail.com>
---
 drivers/iio/adc/max1027.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/max1027.c b/drivers/iio/adc/max1027.c
index 712fbd2..b1fee47 100644
--- a/drivers/iio/adc/max1027.c
+++ b/drivers/iio/adc/max1027.c
@@ -238,7 +238,9 @@ static int max1027_read_single_value(struct iio_dev *indio_dev,
 
 	/* Configure conversion register with the requested chan */
 	st->reg = MAX1027_CONV_REG | MAX1027_CHAN(chan->channel) |
-		  MAX1027_NOSCAN | !!(chan->type == IIO_TEMP);
+		  MAX1027_NOSCAN;
+	if (chan->type == IIO_TEMP)
+		st->reg |= 1;
 	ret = spi_write(st->spi, &st->reg, 1);
 	if (ret < 0) {
 		dev_err(&indio_dev->dev,
-- 
1.8.3.1
