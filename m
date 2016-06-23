Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.aswsp.com ([193.34.35.150]:32619 "EHLO mail.aswsp.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752311AbcFWNri (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Thu, 23 Jun 2016 09:47:38 -0400
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
Subject: [PATCH v1 3/7] iio:st_pressure: align storagebits on power of 2
Date: Thu, 23 Jun 2016 15:49:45 +0200
Message-ID: <cbdd28c13f645d33d4f34a26fc031ae9c86e38e6.1466687364.git.gregor.boirie@parrot.com>
In-Reply-To: <cover.1466687364.git.gregor.boirie@parrot.com>
References: <cover.1466687364.git.gregor.boirie@parrot.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Sampled pressure data are 24 bits long and should be stored in a 32 bits
word.

Signed-off-by: Gregor Boirie <gregor.boirie@parrot.com>
---
 drivers/iio/pressure/st_pressure_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/pressure/st_pressure_core.c b/drivers/iio/pressure/st_pressure_core.c
index 79616e0..31e5e41 100644
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

