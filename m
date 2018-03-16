Return-Path: <SRS0=O4k9=GG=gmail.com=rodrigosiqueiramelo@kernel.org>
Date: Fri, 16 Mar 2018 19:48:51 -0300
From: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
To: John Syne <john3909@gmail.com>, Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org, Barry Song <21cnbao@gmail.com>
Cc: daniel.baluta@nxp.com, linux-iio@vger.kernel.org,
	devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/8] staging:iio:ade7854: Fix the wrong number of bits to
 read
Message-ID: <b5f76bfcf37667a473ec962bfafadc7f9455bec6.1521239766.git.rodrigosiqueiramelo@gmail.com>
References: <cover.1521239766.git.rodrigosiqueiramelo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <cover.1521239766.git.rodrigosiqueiramelo@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

The function ade7854_i2c_read_reg_32() have to invoke the
i2c_master_recv() for read 32 bits values, however, the counter is set
to 3 which means 24 bits. This patch fixes the wrong size of 24 bits, to
32 bits. Finally, this patch is based on John Syne patches.

Signed-off-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
Signed-off-by: John Syne <john3909@gmail.com>
---
 drivers/staging/iio/meter/ade7854-i2c.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/iio/meter/ade7854-i2c.c b/drivers/staging/iio/meter/ade7854-i2c.c
index 4437f1e33261..37c957482493 100644
--- a/drivers/staging/iio/meter/ade7854-i2c.c
+++ b/drivers/staging/iio/meter/ade7854-i2c.c
@@ -191,7 +191,7 @@ static int ade7854_i2c_read_reg_32(struct device *dev,
 	if (ret < 0)
 		goto out;
 
-	ret = i2c_master_recv(st->i2c, st->rx, 3);
+	ret = i2c_master_recv(st->i2c, st->rx, 4);
 	if (ret < 0)
 		goto out;
 
-- 
2.16.2
