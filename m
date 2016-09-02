Return-Path: <gregor.boirie@parrot.com>
From: Gregor Boirie <gregor.boirie@parrot.com>
To: <linux-iio@vger.kernel.org>
CC: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald-Stadler
	<pmeerw@pmeerw.net>, Gregor Boirie <gregor.boirie@parrot.com>
Subject: [PATCH v1 1/1] iio:core: fix IIO_VAL_FRACTIONAL sign handling
Date: Fri, 2 Sep 2016 20:27:46 +0200
Message-ID: <e66c33d8d00c51878039a967f2650f7bc1866e90.1472840709.git.gregor.boirie@parrot.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

7985e7c100 ("iio: Introduce a new fractional value type") introduced a
new IIO_VAL_FRACTIONAL value type meant to represent rational type numbers
expressed by a numerator and denominator combination.

Formating of IIO_VAL_FRACTIONAL values relies upon do_div() usage. This
fails handling negative values properly since parameters are reevaluated
as unsigned values.
Fix this by using div_s64_rem() instead. Computed integer part will carry
properly signed value. Formatted fractional part will always be positive.

Fixes: 7985e7c100 ("iio: Introduce a new fractional value type")
Signed-off-by: Gregor Boirie <gregor.boirie@parrot.com>
---
 drivers/iio/industrialio-core.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index f914d5d..d2b8899 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -613,9 +613,8 @@ ssize_t iio_format_value(char *buf, unsigned int type, int size, int *vals)
 			return sprintf(buf, "%d.%09u\n", vals[0], vals[1]);
 	case IIO_VAL_FRACTIONAL:
 		tmp = div_s64((s64)vals[0] * 1000000000LL, vals[1]);
-		vals[1] = do_div(tmp, 1000000000LL);
-		vals[0] = tmp;
-		return sprintf(buf, "%d.%09u\n", vals[0], vals[1]);
+		vals[0] = (int)div_s64_rem(tmp, 1000000000, &vals[1]);
+		return sprintf(buf, "%d.%09u\n", vals[0], abs(vals[1]));
 	case IIO_VAL_FRACTIONAL_LOG2:
 		tmp = (s64)vals[0] * 1000000000LL >> vals[1];
 		vals[1] = do_div(tmp, 1000000000LL);
-- 
2.1.4
