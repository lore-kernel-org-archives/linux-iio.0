Return-Path: <vilhelm.gray@gmail.com>
Date: Tue, 29 Nov 2016 10:51:48 -0500
From: William Breathitt Gray <vilhelm.gray@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] iio: 104-quad-8: Fix active level mismatch for the preset
 enable option
Message-ID: <20161129155148.GA4193@sophia>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-ID: <linux-iio@vger.kernel.org>

The set_to_preset_on_index sysfs attribute provides a boolean
configuration option to enable a preset operation on the respective
channel's counter when Index occurs. However, the corresponding
configuration bit on the Input/Output Control register must be set low
to enable the preset operation.

This patch inverts the internal driver boolean logic exposed via the
set_to_preset_on_index attribute in order to correctly configure the
device which expects an active low bit.

Fixes: 28e5d3bb0325 ("iio: 104-quad-8: Add IIO support for the ACCES 104-QUAD-8")
Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 drivers/iio/counter/104-quad-8.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/counter/104-quad-8.c b/drivers/iio/counter/104-quad-8.c
index 2d2ee35..9847221 100644
--- a/drivers/iio/counter/104-quad-8.c
+++ b/drivers/iio/counter/104-quad-8.c
@@ -233,7 +233,7 @@ static ssize_t quad8_read_set_to_preset_on_index(struct iio_dev *indio_dev,
 	const struct quad8_iio *const priv = iio_priv(indio_dev);
 
 	return snprintf(buf, PAGE_SIZE, "%u\n",
-		priv->preset_enable[chan->channel]);
+		!priv->preset_enable[chan->channel]);
 }
 
 static ssize_t quad8_write_set_to_preset_on_index(struct iio_dev *indio_dev,
@@ -250,6 +250,9 @@ static ssize_t quad8_write_set_to_preset_on_index(struct iio_dev *indio_dev,
 	if (ret)
 		return ret;
 
+	/* Preset enable is active low in Input/Output Control register */
+	preset_enable = !preset_enable;
+
 	priv->preset_enable[chan->channel] = preset_enable;
 
 	ior_cfg = priv->ab_enable[chan->channel] |
-- 
2.10.2
