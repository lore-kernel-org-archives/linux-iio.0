Return-Path: <SRS0=+gvz=X3=grinn-global.com=m.niestroj@kernel.org>
From: Marcin Niestroj <m.niestroj@grinn-global.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Gregor Boirie <gregor.boirie@parrot.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	linux-iio@vger.kernel.org,
	Marcin Niestroj <m.niestroj@grinn-global.com>
Subject: [PATCH 1/2] iio: st_pressure: Fix data sign
Date: Mon, 12 Dec 2016 17:58:42 +0100
Message-Id: <20161212165843.32322-1-m.niestroj@grinn-global.com>
List-ID: <linux-iio@vger.kernel.org>

Datasheet of each device (lps331ap, lps25h, lps001wp, lps22hb) says that
the pressure and temperature data is a 2's complement.

Fixes: 217494e5b780 ("iio:pressure: Add STMicroelectronics pressures driver")
Fixes: 2f5effcbd097 ("iio: pressure-core: st: Expand and rename LPS331AP's channel descriptor")
Fixes: 7885a8ce6800 ("iio: pressure: st: Add support for new LPS001WP pressure sensor")
Fixes: e039e2f5b4da ("iio:st_pressure:initial lps22hb sensor support")
Signed-off-by: Marcin Niestroj <m.niestroj@grinn-global.com>
---
 drivers/iio/pressure/st_pressure_core.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/pressure/st_pressure_core.c b/drivers/iio/pressure/st_pressure_core.c
index 55df9a7..44e46c1 100644
--- a/drivers/iio/pressure/st_pressure_core.c
+++ b/drivers/iio/pressure/st_pressure_core.c
@@ -227,7 +227,7 @@ static const struct iio_chan_spec st_press_1_channels[] = {
 		.address = ST_PRESS_1_OUT_XL_ADDR,
 		.scan_index = 0,
 		.scan_type = {
-			.sign = 'u',
+			.sign = 's',
 			.realbits = 24,
 			.storagebits = 32,
 			.endianness = IIO_LE,
@@ -240,7 +240,7 @@ static const struct iio_chan_spec st_press_1_channels[] = {
 		.address = ST_TEMP_1_OUT_L_ADDR,
 		.scan_index = 1,
 		.scan_type = {
-			.sign = 'u',
+			.sign = 's',
 			.realbits = 16,
 			.storagebits = 16,
 			.endianness = IIO_LE,
@@ -259,7 +259,7 @@ static const struct iio_chan_spec st_press_lps001wp_channels[] = {
 		.address = ST_PRESS_LPS001WP_OUT_L_ADDR,
 		.scan_index = 0,
 		.scan_type = {
-			.sign = 'u',
+			.sign = 's',
 			.realbits = 16,
 			.storagebits = 16,
 			.endianness = IIO_LE,
@@ -273,7 +273,7 @@ static const struct iio_chan_spec st_press_lps001wp_channels[] = {
 		.address = ST_TEMP_LPS001WP_OUT_L_ADDR,
 		.scan_index = 1,
 		.scan_type = {
-			.sign = 'u',
+			.sign = 's',
 			.realbits = 16,
 			.storagebits = 16,
 			.endianness = IIO_LE,
@@ -291,7 +291,7 @@ static const struct iio_chan_spec st_press_lps22hb_channels[] = {
 		.address = ST_PRESS_1_OUT_XL_ADDR,
 		.scan_index = 0,
 		.scan_type = {
-			.sign = 'u',
+			.sign = 's',
 			.realbits = 24,
 			.storagebits = 32,
 			.endianness = IIO_LE,
-- 
2.10.2
