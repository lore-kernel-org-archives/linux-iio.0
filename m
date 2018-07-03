Return-Path: <SRS0=to0h=JT=embeddedor.com=gustavo@kernel.org>
Date: Tue, 3 Jul 2018 14:35:50 -0500
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] iio:imu:adis: Mark expected switch fall-throughs
Message-ID: <20180703193550.GA12565@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <linux-iio@vger.kernel.org>

In preparation to enabling -Wimplicit-fallthrough, mark switch cases
where we are expecting to fall through.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/iio/imu/adis.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iio/imu/adis.c b/drivers/iio/imu/adis.c
index ad6f91d..c771ae6 100644
--- a/drivers/iio/imu/adis.c
+++ b/drivers/iio/imu/adis.c
@@ -81,9 +81,11 @@ int adis_write_reg(struct adis *adis, unsigned int reg,
 		adis->tx[9] = (value >> 24) & 0xff;
 		adis->tx[6] = ADIS_WRITE_REG(reg + 2);
 		adis->tx[7] = (value >> 16) & 0xff;
+		/* fall through */
 	case 2:
 		adis->tx[4] = ADIS_WRITE_REG(reg + 1);
 		adis->tx[5] = (value >> 8) & 0xff;
+		/* fall through */
 	case 1:
 		adis->tx[2] = ADIS_WRITE_REG(reg);
 		adis->tx[3] = value & 0xff;
@@ -167,6 +169,7 @@ int adis_read_reg(struct adis *adis, unsigned int reg,
 		adis->tx[2] = ADIS_READ_REG(reg + 2);
 		adis->tx[3] = 0;
 		spi_message_add_tail(&xfers[1], &msg);
+		/* fall through */
 	case 2:
 		adis->tx[4] = ADIS_READ_REG(reg);
 		adis->tx[5] = 0;
-- 
2.7.4
