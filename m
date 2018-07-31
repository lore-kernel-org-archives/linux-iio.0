Return-Path: <SRS0=uveW=KP=oracle.com=dan.carpenter@kernel.org>
Date: Tue, 31 Jul 2018 21:11:34 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Jonathan Cameron <jic23@kernel.org>,
        Maxime =?iso-8859-1?Q?Roussin-B=E9langer?= <maxime.roussinbelanger@gmail.com>
Cc: Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jean-Francois Dagenais <jeff.dagenais@gmail.com>,
        linux-iio@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] iio: light: si1133: fix an && vs || typo
Message-ID: <20180731181134.rp57ywlshwqm4onu@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <linux-iio@vger.kernel.org>

The "val" variable can't be both 0 and 1 at the same time so this will
always return -EINVAL.

Fixes: e01e7eaf37d8 ("iio: light: introduce si1133")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

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
