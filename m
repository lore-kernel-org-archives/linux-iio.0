Return-Path: <SRS0=wyiX=KP=gmail.com=maxime.roussinbelanger@kernel.org>
From: =?UTF-8?q?Maxime=20Roussin-B=C3=A9langer?= <maxime.roussinbelanger@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc: linux-iio@vger.kernel.org,
	=?UTF-8?q?Maxime=20Roussin-B=C3=A9langer?= <maxime.roussinbelanger@gmail.com>
Subject: [PATCH] iio: light: si1133: fix uninitialized resp variable
Date: Tue, 31 Jul 2018 15:26:51 -0400
Message-Id: <20180731192651.29128-1-maxime.roussinbelanger@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

Read response register to detect any error.

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/iio/light/si1133.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iio/light/si1133.c b/drivers/iio/light/si1133.c
index d3fbeb3bc463..9b8862af0127 100644
--- a/drivers/iio/light/si1133.c
+++ b/drivers/iio/light/si1133.c
@@ -409,6 +409,9 @@ static int si1133_command(struct si1133_data *data, u8 cmd)
 			err = -ETIMEDOUT;
 			goto out;
 		}
+		err = regmap_read(data->regmap, SI1133_REG_RESPONSE0, &resp);
+		if (err)
+			goto out;
 	} else {
 		err = regmap_read_poll_timeout(data->regmap,
 					       SI1133_REG_RESPONSE0, resp,
-- 
2.18.0
