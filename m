Return-Path: <SRS0=4408=MU=embeddedor.com=gustavo@kernel.org>
Date: Mon, 8 Oct 2018 19:35:28 +0200
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To: Peter Rosin <peda@axentia.se>, Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] iio: dpot-dac: mark expected switch fall-through
Message-ID: <20181008173528.GA31787@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <linux-iio@vger.kernel.org>

In preparation to enabling -Wimplicit-fallthrough, mark switch cases
where we are expecting to fall through.

Notice that in this particular case, I replaced "...and fall through."
with a proper "fall through", which is what GCC is expecting to find.

Addresses-Coverity-ID: 1462408 ("Missing break in switch")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/iio/dac/dpot-dac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/dac/dpot-dac.c b/drivers/iio/dac/dpot-dac.c
index a791d0a..e353946 100644
--- a/drivers/iio/dac/dpot-dac.c
+++ b/drivers/iio/dac/dpot-dac.c
@@ -78,7 +78,7 @@ static int dpot_dac_read_raw(struct iio_dev *indio_dev,
 			 */
 			*val2 = 1;
 			ret = IIO_VAL_FRACTIONAL;
-			/* ...and fall through. */
+			/* fall through */
 		case IIO_VAL_FRACTIONAL:
 			*val *= regulator_get_voltage(dac->vref) / 1000;
 			*val2 *= dac->max_ohms;
-- 
2.7.4
