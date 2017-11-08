Return-Path: <SRS0=EUjZ=CG=embeddedor.com=garsilva@kernel.org>
Date: Wed, 8 Nov 2017 11:36:21 -0600
From: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
To: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <garsilva@embeddedor.com>
Subject: [PATCH] io: core: mark expected switch fall-through
Message-ID: <20171108173621.GA20008@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <linux-iio@vger.kernel.org>

In preparation to enabling -Wimplicit-fallthrough, mark switch cases
where we are expecting to fall through.

Addresses-Coverity-ID: 1397962
Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
---
 drivers/iio/industrialio-core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index 9c4cfd1..2e8e36f 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -588,6 +588,7 @@ static ssize_t __iio_format_value(char *buf, size_t len, unsigned int type,
 		return snprintf(buf, len, "%d", vals[0]);
 	case IIO_VAL_INT_PLUS_MICRO_DB:
 		scale_db = true;
+		/* fall through */
 	case IIO_VAL_INT_PLUS_MICRO:
 		if (vals[1] < 0)
 			return snprintf(buf, len, "-%d.%06u%s", abs(vals[0]),
-- 
2.7.4
