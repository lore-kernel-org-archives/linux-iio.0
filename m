Return-Path: <SRS0=Wa0e=NG=usp.br=matheus.bernardino@kernel.org>
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
	kernel-usp@googlegroups.com
Subject: [PATCH 6/6] staging:iio:ad2s90: Check channel type at read_raw
Date: Thu, 25 Oct 2018 21:45:12 -0300
Message-Id: <20181026004512.31012-7-matheus.bernardino@usp.br>
In-Reply-To: <20181026004512.31012-1-matheus.bernardino@usp.br>
References: <20181026004512.31012-1-matheus.bernardino@usp.br>
List-ID: <linux-iio@vger.kernel.org>

This patch adds a channel type check at the beginning of the
ad2s90_read_raw function. Since ad2s90 has only one channel, it just
checks if the given channel is the expected one and if not, return
-EINVAL.

Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---
 drivers/staging/iio/resolver/ad2s90.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/staging/iio/resolver/ad2s90.c b/drivers/staging/iio/resolver/ad2s90.c
index 52b656875ed1..24002042a5c5 100644
--- a/drivers/staging/iio/resolver/ad2s90.c
+++ b/drivers/staging/iio/resolver/ad2s90.c
@@ -34,6 +34,9 @@ static int ad2s90_read_raw(struct iio_dev *indio_dev,
 	int ret;
 	struct ad2s90_state *st = iio_priv(indio_dev);
 
+	if (chan->type != IIO_ANGL)
+		return -EINVAL;
+
 	switch (m) {
 	case IIO_CHAN_INFO_SCALE:
 		/* 2 * Pi / (2^12 - 1) ~= 0.001534355 */
-- 
2.18.0
