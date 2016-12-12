Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp.megiteam.pl ([31.186.83.105]:42078 "EHLO smtp.megiteam.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752758AbcLLQ7E (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 12 Dec 2016 11:59:04 -0500
From: Marcin Niestroj <m.niestroj@grinn-global.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Gregor Boirie <gregor.boirie@parrot.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-iio@vger.kernel.org,
        Marcin Niestroj <m.niestroj@grinn-global.com>
Subject: [PATCH 2/2] iio: st_pressure: Export sampling frequency for lps25h and lps331ap
Date: Mon, 12 Dec 2016 17:58:43 +0100
Message-Id: <20161212165843.32322-2-m.niestroj@grinn-global.com>
In-Reply-To: <20161212165843.32322-1-m.niestroj@grinn-global.com>
References: <20161212165843.32322-1-m.niestroj@grinn-global.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Both devices are using the same iio_chan_spec to define which settings
are exported with sysfs. Both are properly configured to set/get
sampling frequency for pressure and temperature. They also properly
export available sampling frequencies. The only missing thing is
sampling_frequency sysfs file, which allows to set/get this property
from userspace.

Add sampling frequency to iio channel info mask, so sampling_frequency
file is properly exported using sysfs.

Signed-off-by: Marcin Niestroj <m.niestroj@grinn-global.com>
---
 drivers/iio/pressure/st_pressure_core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iio/pressure/st_pressure_core.c b/drivers/iio/pressure/st_pressure_core.c
index 44e46c1..fd4dcf1 100644
--- a/drivers/iio/pressure/st_pressure_core.c
+++ b/drivers/iio/pressure/st_pressure_core.c
@@ -234,6 +234,7 @@ static const struct iio_chan_spec st_press_1_channels[] = {
 		},
 		.info_mask_separate =
 			BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
+		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),
 	},
 	{
 		.type = IIO_TEMP,
@@ -249,6 +250,7 @@ static const struct iio_chan_spec st_press_1_channels[] = {
 			BIT(IIO_CHAN_INFO_RAW) |
 			BIT(IIO_CHAN_INFO_SCALE) |
 			BIT(IIO_CHAN_INFO_OFFSET),
+		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),
 	},
 	IIO_CHAN_SOFT_TIMESTAMP(2)
 };
-- 
2.10.2

