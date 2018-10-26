Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-qk1-f193.google.com ([209.85.222.193]:44088 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726949AbeJZJU3 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 26 Oct 2018 05:20:29 -0400
Received: by mail-qk1-f193.google.com with SMTP id n12so5738801qkh.11
        for <linux-iio@vger.kernel.org>; Thu, 25 Oct 2018 17:45:39 -0700 (PDT)
From: Matheus Tavares <matheus.bernardino@usp.br>
To: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com,
        Victor Colombo <victorcolombo@gmail.com>
Subject: [PATCH 5/6] staging:iio:ad2s90: Add IIO_CHAN_INFO_SCALE to channel spec and read_raw
Date: Thu, 25 Oct 2018 21:45:11 -0300
Message-Id: <20181026004512.31012-6-matheus.bernardino@usp.br>
In-Reply-To: <20181026004512.31012-1-matheus.bernardino@usp.br>
References: <20181026004512.31012-1-matheus.bernardino@usp.br>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: Victor Colombo <victorcolombo@gmail.com>

This patch adds the IIO_CHAN_INFO_SCALE mask to ad2s90_chan and
implements the relative read behavior at ad2s90_read_raw.

Signed-off-by: Victor Colombo <victorcolombo@gmail.com>
---
 drivers/staging/iio/resolver/ad2s90.c | 32 ++++++++++++++++++---------
 1 file changed, 22 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/iio/resolver/ad2s90.c b/drivers/staging/iio/resolver/ad2s90.c
index b4a6a89c11b0..52b656875ed1 100644
--- a/drivers/staging/iio/resolver/ad2s90.c
+++ b/drivers/staging/iio/resolver/ad2s90.c
@@ -34,19 +34,31 @@ static int ad2s90_read_raw(struct iio_dev *indio_dev,
 	int ret;
 	struct ad2s90_state *st = iio_priv(indio_dev);
 
-	mutex_lock(&st->lock);
+	switch (m) {
+	case IIO_CHAN_INFO_SCALE:
+		/* 2 * Pi / (2^12 - 1) ~= 0.001534355 */
+		*val = 0;
+		*val2 = 1534355;
+		return IIO_VAL_INT_PLUS_NANO;
+	case IIO_CHAN_INFO_RAW:
+		mutex_lock(&st->lock);
+
+		ret = spi_read(st->sdev, st->rx, 2);
+		if (ret < 0) {
+			mutex_unlock(&st->lock);
+			return ret;
+		}
+
+		*val = (((u16)(st->rx[0])) << 4) | ((st->rx[1] & 0xF0) >> 4);
 
-	ret = spi_read(st->sdev, st->rx, 2);
-	if (ret < 0) {
 		mutex_unlock(&st->lock);
-		return ret;
-	}
 
-	*val = (((u16)(st->rx[0])) << 4) | ((st->rx[1] & 0xF0) >> 4);
-
-	mutex_unlock(&st->lock);
+		return IIO_VAL_INT;
+	default:
+		break;
+	}
 
-	return IIO_VAL_INT;
+	return -EINVAL;
 }
 
 static const struct iio_info ad2s90_info = {
@@ -57,7 +69,7 @@ static const struct iio_chan_spec ad2s90_chan = {
 	.type = IIO_ANGL,
 	.indexed = 1,
 	.channel = 0,
-	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
 };
 
 static int ad2s90_probe(struct spi_device *spi)
-- 
2.18.0
