Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-qt1-f196.google.com ([209.85.160.196]:39160 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726448AbeJZHFM (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 26 Oct 2018 03:05:12 -0400
Date: Thu, 25 Oct 2018 19:30:37 -0300
From: Renato Lui Geh <renatogeh@gmail.com>
To: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        alexandru.Ardelean@analog.com, stefan.popa@analog.com,
        giuliano.belinassi@usp.br
Cc: linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com
Subject: [PATCH v2 2/2] staging: iio: ad7780: fix offset read value
Message-ID: <ff71d89625c048601d3e3770ca3b4bcceb2068ac.1540506298.git.renatogeh@gmail.com>
References: <cover.1540506298.git.renatogeh@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
In-Reply-To: <cover.1540506298.git.renatogeh@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Variable val subtracted an uninitialized value on IIO_CHAN_INFO_OFFSET.
This was fixed by assigning the correct value instead.

Signed-off-by: Renato Lui Geh <renatogeh@gmail.com>
---
 drivers/staging/iio/adc/ad7780.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/iio/adc/ad7780.c b/drivers/staging/iio/adc/ad7780.c
index 27972563bb6a..06700fe554a2 100644
--- a/drivers/staging/iio/adc/ad7780.c
+++ b/drivers/staging/iio/adc/ad7780.c
@@ -100,7 +100,7 @@ static int ad7780_read_raw(struct iio_dev *indio_dev,
 		*val2 = chan->scan_type.realbits - 1;
 		return IIO_VAL_FRACTIONAL_LOG2;
 	case IIO_CHAN_INFO_OFFSET:
-		*val -= (1 << (chan->scan_type.realbits - 1));
+		*val = -(1 << (chan->scan_type.realbits - 1));
 		return IIO_VAL_INT;
 	}
 
-- 
2.19.1
