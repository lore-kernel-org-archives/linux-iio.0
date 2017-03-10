Return-Path: <SRS0=AVyx=2T=gmail.com=tsu.yubo@kernel.org>
Date: Thu, 9 Mar 2017 22:57:38 -0500
From: Bo Yu <tsu.yubo@gmail.com>
To: Clausen <lars@metafoo.de>, Kroah-Hartman <gregkh@linuxfoundation.org>,
	Hennerich <Michael.Hennerich@analog.com>,
	Cameron <jic23@kernel.org>, Knaack <knaack.h@gmx.de>,
	Meerwald-Stadler <pmeerw@pmeerw.net>, tsu.yubo@gmail.com
Cc: devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org
Subject: [PATCH] Staging: iio: return expression instead of return ret
Message-ID: <20170310035738.GA1143@yubo-2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-iio@vger.kernel.org>

The following Coccinelle script was used to detect this:

@@
local idexpression ret;
expression e;
@@

-ret =
+return
       e;
-return ret;

Signed-off-by: Bo YU <tsu.yubo@gmail.com>
---
   drivers/staging/iio/meter/ade7754.c |    3 +--
   1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/iio/meter/ade7754.c b/drivers/staging/iio/meter/ade7754.c
index 024463a11c47..19f8cb144768 100644
--- a/drivers/staging/iio/meter/ade7754.c
+++ b/drivers/staging/iio/meter/ade7754.c
@@ -349,9 +349,8 @@ static int ade7754_set_irq(struct device *dev, bool enable)
   	else
   		irqen &= ~BIT(14);

-	ret = ade7754_spi_write_reg_16(dev, ADE7754_IRQEN, irqen);
+	return ade7754_spi_write_reg_16(dev, ADE7754_IRQEN, irqen);

-	return ret;
   }

   /* Power down the device */
--
1.7.10.4
