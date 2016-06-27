Return-Path: <gregor.boirie@parrot.com>
From: Gregor Boirie <gregor.boirie@parrot.com>
To: <linux-iio@vger.kernel.org>
CC: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald-Stadler
	<pmeerw@pmeerw.net>, Linus Walleij <linus.walleij@linaro.org>, Denis Ciocca
	<denis.ciocca@st.com>, Giuseppe Barba <giuseppe.barba@st.com>, Crestez Dan
 Leonard <leonard.crestez@intel.com>, Gregor Boirie <gregor.boirie@parrot.com>
Subject: [PATCH v2 7/7] iio:st_pressure: clean useless static channel initializers
Date: Mon, 27 Jun 2016 12:38:58 +0200
Message-ID: <e00825cd4d3ebfcfe97efa4f66822dc0e276e193.1467023672.git.gregor.boirie@parrot.com>
In-Reply-To: <cover.1467023672.git.gregor.boirie@parrot.com>
References: <cover.1467023672.git.gregor.boirie@parrot.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

Some static channels are explicitly initialized with default values.
Remove them to enhance readability.

Signed-off-by: Gregor Boirie <gregor.boirie@parrot.com>
---
 drivers/iio/pressure/st_pressure_core.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/iio/pressure/st_pressure_core.c b/drivers/iio/pressure/st_pressure_core.c
index 274cdec..55df9a7 100644
--- a/drivers/iio/pressure/st_pressure_core.c
+++ b/drivers/iio/pressure/st_pressure_core.c
@@ -224,7 +224,6 @@
 static const struct iio_chan_spec st_press_1_channels[] = {
 	{
 		.type = IIO_PRESSURE,
-		.channel2 = IIO_NO_MOD,
 		.address = ST_PRESS_1_OUT_XL_ADDR,
 		.scan_index = 0,
 		.scan_type = {
@@ -235,11 +234,9 @@ static const struct iio_chan_spec st_press_1_channels[] = {
 		},
 		.info_mask_separate =
 			BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
-		.modified = 0,
 	},
 	{
 		.type = IIO_TEMP,
-		.channel2 = IIO_NO_MOD,
 		.address = ST_TEMP_1_OUT_L_ADDR,
 		.scan_index = 1,
 		.scan_type = {
@@ -252,7 +249,6 @@ static const struct iio_chan_spec st_press_1_channels[] = {
 			BIT(IIO_CHAN_INFO_RAW) |
 			BIT(IIO_CHAN_INFO_SCALE) |
 			BIT(IIO_CHAN_INFO_OFFSET),
-		.modified = 0,
 	},
 	IIO_CHAN_SOFT_TIMESTAMP(2)
 };
@@ -260,7 +256,6 @@ static const struct iio_chan_spec st_press_1_channels[] = {
 static const struct iio_chan_spec st_press_lps001wp_channels[] = {
 	{
 		.type = IIO_PRESSURE,
-		.channel2 = IIO_NO_MOD,
 		.address = ST_PRESS_LPS001WP_OUT_L_ADDR,
 		.scan_index = 0,
 		.scan_type = {
@@ -272,11 +267,9 @@ static const struct iio_chan_spec st_press_lps001wp_channels[] = {
 		.info_mask_separate =
 			BIT(IIO_CHAN_INFO_RAW) |
 			BIT(IIO_CHAN_INFO_SCALE),
-		.modified = 0,
 	},
 	{
 		.type = IIO_TEMP,
-		.channel2 = IIO_NO_MOD,
 		.address = ST_TEMP_LPS001WP_OUT_L_ADDR,
 		.scan_index = 1,
 		.scan_type = {
@@ -288,7 +281,6 @@ static const struct iio_chan_spec st_press_lps001wp_channels[] = {
 		.info_mask_separate =
 			BIT(IIO_CHAN_INFO_RAW) |
 			BIT(IIO_CHAN_INFO_SCALE),
-		.modified = 0,
 	},
 	IIO_CHAN_SOFT_TIMESTAMP(2)
 };
@@ -296,7 +288,6 @@ static const struct iio_chan_spec st_press_lps001wp_channels[] = {
 static const struct iio_chan_spec st_press_lps22hb_channels[] = {
 	{
 		.type = IIO_PRESSURE,
-		.channel2 = IIO_NO_MOD,
 		.address = ST_PRESS_1_OUT_XL_ADDR,
 		.scan_index = 0,
 		.scan_type = {
@@ -309,7 +300,6 @@ static const struct iio_chan_spec st_press_lps22hb_channels[] = {
 			BIT(IIO_CHAN_INFO_RAW) |
 			BIT(IIO_CHAN_INFO_SCALE),
 		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),
-		.modified = 0,
 	},
 	{
 		.type = IIO_TEMP,
-- 
2.1.4
