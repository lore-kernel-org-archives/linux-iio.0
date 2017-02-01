Return-Path: <SRS0=GBpQ=ZO=axentia.se=peda@kernel.org>
From: Peter Rosin <peda@axentia.se>
To: <linux-kernel@vger.kernel.org>
CC: Peter Rosin <peda@axentia.se>, Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>, Peter
 Meerwald-Stadler <pmeerw@pmeerw.net>, Alison Schofield
	<amsfield22@gmail.com>, Gregor Boirie <gregor.boirie@parrot.com>, Sanchayan
 Maity <maitysanchayan@gmail.com>, Ken Lin <ken.lin@advantech.com>,
	<linux-iio@vger.kernel.org>
Subject: [PATCH 2/2] iio: pressure: mpl115: do not rely on structure field ordering
Date: Wed, 1 Feb 2017 09:09:27 +0100
Message-ID: <1485936567-3367-3-git-send-email-peda@axentia.se>
In-Reply-To: <1485936567-3367-1-git-send-email-peda@axentia.se>
References: <1485936567-3367-1-git-send-email-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

Fixes a regression triggered by a change in the layout of
struct iio_chan_spec, but the real bug is in the driver which assumed
a specific structure layout in the first place.

Fixes: 3017d90e8931 ("iio: Add Freescale MPL115A2 pressure / temperature sensor driver")
Fixes: 51239600074b ("iio:core: add a callback to allow drivers to provide _available attributes")
Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/iio/pressure/mpl115.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/pressure/mpl115.c b/drivers/iio/pressure/mpl115.c
index 73f2f0c46e62..8f2bce213248 100644
--- a/drivers/iio/pressure/mpl115.c
+++ b/drivers/iio/pressure/mpl115.c
@@ -137,6 +137,7 @@ static const struct iio_chan_spec mpl115_channels[] = {
 	{
 		.type = IIO_TEMP,
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
+		.info_mask_shared_by_type =
 			BIT(IIO_CHAN_INFO_OFFSET) | BIT(IIO_CHAN_INFO_SCALE),
 	},
 };
-- 
2.1.4
