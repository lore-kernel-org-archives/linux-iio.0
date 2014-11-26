Return-Path: <lars@metafoo.de>
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Mike Looijmans <mike.looijmans@topic.nl>,
	linux-iio@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH] iio: ad799x: Fix ad7991/ad7995/ad7999 config setup
Date: Wed, 26 Nov 2014 11:35:35 +0100
Message-Id: <1416998135-19931-1-git-send-email-lars@metafoo.de>
List-ID: <linux-iio@vger.kernel.org>

The ad7991/ad7995/ad7999 does not have a configuration register like the
other devices that can be written and read. The configuration is written as
part of the conversion sequence.

Fixes: 0f7ddcc1bff1 ("iio:adc:ad799x: Write default config on probe and reset alert status on probe")
Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/iio/adc/ad799x.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/ad799x.c b/drivers/iio/adc/ad799x.c
index e37412d..b99de00 100644
--- a/drivers/iio/adc/ad799x.c
+++ b/drivers/iio/adc/ad799x.c
@@ -143,9 +143,15 @@ static int ad799x_write_config(struct ad799x_state *st, u16 val)
 	case ad7998:
 		return i2c_smbus_write_word_swapped(st->client, AD7998_CONF_REG,
 			val);
-	default:
+	case ad7992:
+	case ad7993:
+	case ad7994:
 		return i2c_smbus_write_byte_data(st->client, AD7998_CONF_REG,
 			val);
+	default:
+		/* Will be written when doing a conversion */
+		st->config = val;
+		return 0;
 	}
 }
 
@@ -155,8 +161,13 @@ static int ad799x_read_config(struct ad799x_state *st)
 	case ad7997:
 	case ad7998:
 		return i2c_smbus_read_word_swapped(st->client, AD7998_CONF_REG);
-	default:
+	case ad7992:
+	case ad7993:
+	case ad7994:
 		return i2c_smbus_read_byte_data(st->client, AD7998_CONF_REG);
+	default:
+		/* No readback support */
+		return st->config;
 	}
 }
 
-- 
1.8.0
