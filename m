Return-Path: <gregor.boirie@parrot.com>
From: Gregor Boirie <gregor.boirie@parrot.com>
To: <linux-iio@vger.kernel.org>
CC: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald-Stadler
	<pmeerw@pmeerw.net>, Denis Ciocca <denis.ciocca@st.com>, Linus Walleij
	<linus.walleij@linaro.org>, Giuseppe Barba <giuseppe.barba@st.com>, Gregor
 Boirie <gregor.boirie@parrot.com>
Subject: [RFC PATCH v1 5/9] iio:st_pressure: align storagebits on power of 2
Date: Tue, 19 Apr 2016 11:18:36 +0200
Message-ID: <0f0752ced33e52a488cb79c84c734921a11fcabd.1461056711.git.gregor.boirie@parrot.com>
In-Reply-To: <cover.1461056711.git.gregor.boirie@parrot.com>
References: <cover.1461056711.git.gregor.boirie@parrot.com>
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
index 24754eed..13f1c2d 100644
--- a/drivers/iio/pressure/st_pressure_core.c
+++ b/drivers/iio/pressure/st_pressure_core.c
@@ -167,7 +167,7 @@ static const struct iio_chan_spec st_press_1_channels[] = {
 		.scan_type = {
 			.sign = 'u',
 			.realbits = 24,
-			.storagebits = 24,
+			.storagebits = 32,
 			.endianness = IIO_LE,
 		},
 		.info_mask_separate =
@@ -239,7 +239,7 @@ static const struct iio_chan_spec st_press_lps22hb_channels[] = {
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
