Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.aswsp.com ([193.34.35.150]:32672 "EHLO mail.aswsp.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752085AbcFWNsP (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Thu, 23 Jun 2016 09:48:15 -0400
From: Gregor Boirie <gregor.boirie@parrot.com>
To: <linux-iio@vger.kernel.org>
CC: Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Linus Walleij <linus.walleij@linaro.org>,
	Denis Ciocca <denis.ciocca@st.com>,
	Giuseppe Barba <giuseppe.barba@st.com>,
	Crestez Dan Leonard <leonard.crestez@intel.com>,
	Gregor Boirie <gregor.boirie@parrot.com>
Subject: [PATCH v1 6/7] iio:st_pressure:lps22hb: open drain support
Date: Thu, 23 Jun 2016 15:49:48 +0200
Message-ID: <720bc9ec6149f5001680c0096a7079380dfa6e5f.1466687364.git.gregor.boirie@parrot.com>
In-Reply-To: <cover.1466687364.git.gregor.boirie@parrot.com>
References: <cover.1466687364.git.gregor.boirie@parrot.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Add support for open drain interrupt line.

Signed-off-by: Gregor Boirie <gregor.boirie@parrot.com>
---
 drivers/iio/pressure/st_pressure_core.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/iio/pressure/st_pressure_core.c b/drivers/iio/pressure/st_pressure_core.c
index 122d190..fad54c3 100644
--- a/drivers/iio/pressure/st_pressure_core.c
+++ b/drivers/iio/pressure/st_pressure_core.c
@@ -213,6 +213,8 @@
 #define ST_PRESS_LPS22HB_DRDY_IRQ_INT2_MASK	0x08
 #define ST_PRESS_LPS22HB_IHL_IRQ_ADDR		0x12
 #define ST_PRESS_LPS22HB_IHL_IRQ_MASK		0x80
+#define ST_PRESS_LPS22HB_OD_IRQ_ADDR		0x12
+#define ST_PRESS_LPS22HB_OD_IRQ_MASK		0x40
 #define ST_PRESS_LPS22HB_MULTIREAD_BIT		true
 
 static const struct iio_chan_spec st_press_1_channels[] = {
@@ -511,6 +513,9 @@ static const struct st_sensor_settings st_press_sensors_settings[] = {
 			.mask_int2 = ST_PRESS_LPS22HB_DRDY_IRQ_INT2_MASK,
 			.addr_ihl = ST_PRESS_LPS22HB_IHL_IRQ_ADDR,
 			.mask_ihl = ST_PRESS_LPS22HB_IHL_IRQ_MASK,
+			.addr_od = ST_PRESS_LPS22HB_OD_IRQ_ADDR,
+			.mask_od = ST_PRESS_LPS22HB_OD_IRQ_MASK,
+			.addr_stat_drdy = ST_SENSORS_DEFAULT_STAT_ADDR,
 		},
 		.multi_read_bit = ST_PRESS_LPS22HB_MULTIREAD_BIT,
 	},
-- 
2.1.4

