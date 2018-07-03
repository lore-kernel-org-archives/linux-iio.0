Return-Path: <SRS0=to0h=JT=embeddedor.com=gustavo@kernel.org>
Date: Tue, 3 Jul 2018 14:39:34 -0500
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] iio: sca3000: Mark expected switch fall-through
Message-ID: <20180703193934.GA13572@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <linux-iio@vger.kernel.org>

In preparation to enabling -Wimplicit-fallthrough, mark switch cases
where we are expecting to fall through.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/iio/accel/sca3000.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/accel/sca3000.c b/drivers/iio/accel/sca3000.c
index 4dceb75..209b52a 100644
--- a/drivers/iio/accel/sca3000.c
+++ b/drivers/iio/accel/sca3000.c
@@ -797,6 +797,7 @@ static int sca3000_write_raw(struct iio_dev *indio_dev,
 		mutex_lock(&st->lock);
 		ret = sca3000_write_3db_freq(st, val);
 		mutex_unlock(&st->lock);
+		/* fall through */
 	default:
 		return -EINVAL;
 	}
-- 
2.7.4
