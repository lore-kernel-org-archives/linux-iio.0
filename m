Return-Path: <elfring@users.sourceforge.net>
To: linux-iio@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 Peter Meerwald <pmeerw@pmeerw.net>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org,
 Julia Lawall <julia.lawall@lip6.fr>
From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH] iio-light: Use a signed return type for
 ltr501_match_samp_freq()
Message-ID: <56755A4D.7000406@users.sourceforge.net>
Date: Sat, 19 Dec 2015 14:23:25 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-ID: <linux-iio@vger.kernel.org>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 19 Dec 2015 14:14:54 +0100

The return type "unsigned int" was used by the ltr501_match_samp_freq()
function despite of the aspect that it will eventually return a negative
error code.
Improve this implementation detail by deletion of the type modifier then.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/iio/light/ltr501.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/light/ltr501.c b/drivers/iio/light/ltr501.c
index 809a961..6bf89d8 100644
--- a/drivers/iio/light/ltr501.c
+++ b/drivers/iio/light/ltr501.c
@@ -180,7 +180,7 @@ static const struct ltr501_samp_table ltr501_ps_samp_table[] = {
 			{500000, 2000000}
 };
 
-static unsigned int ltr501_match_samp_freq(const struct ltr501_samp_table *tab,
+static int ltr501_match_samp_freq(const struct ltr501_samp_table *tab,
 					   int len, int val, int val2)
 {
 	int i, freq;
-- 
2.6.3
