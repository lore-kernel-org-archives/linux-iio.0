Return-Path: <SRS0=EUjZ=CG=embeddedor.com=garsilva@kernel.org>
Date: Wed, 8 Nov 2017 12:08:26 -0600
From: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
To: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <garsilva@embeddedor.com>
Subject: [PATCH v2] iio: core: Mark expected switch fall-through
Message-ID: <20171108180826.GA22852@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171108120245.Horde.X3xvu9MyIH2qhMzfKf1uUB2@gator4166.hostgator.com>
List-ID: <linux-iio@vger.kernel.org>

In preparation to enabling -Wimplicit-fallthrough, mark switch cases
where we are expecting to fall through.

Addresses-Coverity-ID: 1397962
Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
---
Changes in v2:
 Fix subject line.

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
