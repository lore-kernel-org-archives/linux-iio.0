Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-qk1-f195.google.com ([209.85.222.195]:44981 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728832AbeKAXqp (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 1 Nov 2018 19:46:45 -0400
Date: Thu, 1 Nov 2018 11:43:23 -0300
From: Renato Lui Geh <renatogeh@gmail.com>
To: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        giuliano.belinassi@usp.br
Cc: linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com
Subject: [PATCH v3 2/3] staging: iio: ad7780: update voltage on read
Message-ID: <1bc4bdf6342d4bc0c2fea17fb3bcd79fabf0e1d1.1541082656.git.renatogeh@gmail.com>
References: <cover.1541082656.git.renatogeh@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
In-Reply-To: <cover.1541082656.git.renatogeh@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The ad7780 driver previously did not read the correct device output, as
it read an outdated value set at initialization. It now updates its
voltage on read.

Signed-off-by: Renato Lui Geh <renatogeh@gmail.com>
---
Changes in v3:
	- removed initialization (int voltage_uv = 0)
	- returns error when voltage_uv is null

 drivers/staging/iio/adc/ad7780.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/iio/adc/ad7780.c b/drivers/staging/iio/adc/ad7780.c
index 91e016d534ed..f2a11e9424cd 100644
--- a/drivers/staging/iio/adc/ad7780.c
+++ b/drivers/staging/iio/adc/ad7780.c
@@ -87,12 +87,16 @@ static int ad7780_read_raw(struct iio_dev *indio_dev,
 			   long m)
 {
 	struct ad7780_state *st = iio_priv(indio_dev);
+	int voltage_uv;
 
 	switch (m) {
 	case IIO_CHAN_INFO_RAW:
 		return ad_sigma_delta_single_conversion(indio_dev, chan, val);
 	case IIO_CHAN_INFO_SCALE:
-		*val = st->int_vref_mv * st->gain;
+		voltage_uv = regulator_get_voltage(st->reg);
+		if (!voltage_uv)
+			return -EINVAL;
+		*val = (voltage_uv / 1000) * st->gain;
 		*val2 = chan->scan_type.realbits - 1;
 		return IIO_VAL_FRACTIONAL_LOG2;
 	case IIO_CHAN_INFO_OFFSET:
-- 
2.19.1
