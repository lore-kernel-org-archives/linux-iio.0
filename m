Return-Path: <gregor.boirie@parrot.com>
From: Gregor Boirie <gregor.boirie@parrot.com>
To: <linux-iio@vger.kernel.org>
CC: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald-Stadler
	<pmeerw@pmeerw.net>, Linus Walleij <linus.walleij@linaro.org>, Denis Ciocca
	<denis.ciocca@st.com>, Giuseppe Barba <giuseppe.barba@st.com>, Crestez Dan
 Leonard <leonard.crestez@intel.com>, Gregor Boirie <gregor.boirie@parrot.com>
Subject: [PATCH v2 2/7] iio:st_pressure: align storagebits on power of 2
Date: Mon, 27 Jun 2016 12:38:53 +0200
Message-ID: <b1ccebea1a6b2f18dcd122cc1792880de14a53c7.1467023672.git.gregor.boirie@parrot.com>
In-Reply-To: <cover.1467023672.git.gregor.boirie@parrot.com>
References: <cover.1467023672.git.gregor.boirie@parrot.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

Sampled pressure data are 24 bits long and should be stored in a 32 bits
word.

Signed-off-by: Gregor Boirie <gregor.boirie@parrot.com>
---
 drivers/iio/pressure/st_pressure_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/pressure/st_pressure_core.c b/drivers/iio/pressure/st_pressure_core.c
index 56d8f5e..8fa3d81 100644
--- a/drivers/iio/pressure/st_pressure_core.c
+++ b/drivers/iio/pressure/st_pressure_core.c
@@ -146,7 +146,7 @@ static const struct iio_chan_spec st_press_1_channels[] = {
 		.scan_type = {
 			.sign = 'u',
 			.realbits = 24,
-			.storagebits = 24,
+			.storagebits = 32,
 			.endianness = IIO_LE,
 		},
 		.info_mask_separate =
@@ -218,7 +218,7 @@ static const struct iio_chan_spec st_press_lps22hb_channels[] = {
 		.scan_type = {
 			.sign = 'u',
 			.realbits = 24,
-			.storagebits = 24,
+			.storagebits = 32,
 			.endianness = IIO_LE,
 		},
 		.info_mask_separate =
-- 
2.1.4
