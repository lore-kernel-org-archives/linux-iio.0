Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-yb0-f196.google.com ([209.85.213.196]:34682 "EHLO
        mail-yb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755700AbcK1Vzm (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 28 Nov 2016 16:55:42 -0500
Date: Mon, 28 Nov 2016 16:55:34 -0500
From: William Breathitt Gray <vilhelm.gray@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] iio: 104-quad-8: Fix off-by-one errors when addressing IOR
Message-ID: <20161128215534.GA27078@sophia>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The Input/Output Control register (IOR) is offset by 1 from the
respective channel data register. This patch fixes off-by-one errors
when attempting to write to a channel IOR where the base address was not
properly offset.

Fixes: 28e5d3bb0325 ("iio: 104-quad-8: Add IIO support for the ACCES 104-QUAD-8")
Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 drivers/iio/counter/104-quad-8.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/counter/104-quad-8.c b/drivers/iio/counter/104-quad-8.c
index 2d2ee35..412d283 100644
--- a/drivers/iio/counter/104-quad-8.c
+++ b/drivers/iio/counter/104-quad-8.c
@@ -153,7 +153,7 @@ static int quad8_write_raw(struct iio_dev *indio_dev,
 		ior_cfg = val | priv->preset_enable[chan->channel] << 1;
 
 		/* Load I/O control configuration */
-		outb(0x40 | ior_cfg, base_offset);
+		outb(0x40 | ior_cfg, base_offset + 1);
 
 		return 0;
 	case IIO_CHAN_INFO_SCALE:
@@ -241,7 +241,7 @@ static ssize_t quad8_write_set_to_preset_on_index(struct iio_dev *indio_dev,
 	size_t len)
 {
 	struct quad8_iio *const priv = iio_priv(indio_dev);
-	const int base_offset = priv->base + 2 * chan->channel;
+	const int base_offset = priv->base + 2 * chan->channel + 1;
 	bool preset_enable;
 	int ret;
 	unsigned int ior_cfg;
-- 
2.10.2

