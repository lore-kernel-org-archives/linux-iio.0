Return-Path: <SRS0=Nfwt=NH=usp.br=matheus.bernardino@kernel.org>
From: Matheus Tavares <matheus.bernardino@usp.br>
To: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-iio@vger.kernel.org,
	devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org,
	kernel-usp@googlegroups.com,
	Victor Colombo <victorcolombo@gmail.com>
Subject: [PATCH v2 5/6] staging:iio:ad2s90: Add IIO_CHAN_INFO_SCALE to channel spec and read_raw
Date: Fri, 26 Oct 2018 23:00:04 -0300
Message-Id: <20181027020005.3140-6-matheus.bernardino@usp.br>
In-Reply-To: <20181027020005.3140-1-matheus.bernardino@usp.br>
References: <20181027020005.3140-1-matheus.bernardino@usp.br>
List-ID: <linux-iio@vger.kernel.org>

This patch adds the IIO_CHAN_INFO_SCALE mask to ad2s90_chan and
implements the relative read behavior at ad2s90_read_raw.

Signed-off-by: Victor Colombo <victorcolombo@gmail.com>
Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
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
