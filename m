Return-Path: <SRS0=J8LW=KO=canonical.com=colin.king@kernel.org>
From: Colin King <colin.king@canonical.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	linux-iio@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] iio: light: fix test for val being not zero or not one.
Date: Mon, 30 Jul 2018 13:59:18 +0100
Message-Id: <20180730125918.7100-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-ID: <linux-iio@vger.kernel.org>

From: Colin Ian King <colin.king@canonical.com>

The current check on val always results in true and so the
call to sii1133_update_adcsens never gets called. Fix this check
so it returns with -EINVAL only when val is not zero and not one.

Detected by CoverityScan, CID#1472099 ("Logically dead code")

Fixes: e01e7eaf37d8 ("iio: light: introduce si1133")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/iio/light/si1133.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/light/si1133.c b/drivers/iio/light/si1133.c
index d3fbeb3bc463..5ac22c46da1f 100644
--- a/drivers/iio/light/si1133.c
+++ b/drivers/iio/light/si1133.c
@@ -838,7 +838,7 @@ static int si1133_write_raw(struct iio_dev *iio_dev,
 		switch (chan->type) {
 		case IIO_INTENSITY:
 		case IIO_UVINDEX:
-			if (val != 0 || val != 1)
+			if (val != 0 && val != 1)
 				return -EINVAL;
 
 			return si1133_update_adcsens(data,
-- 
2.17.1
