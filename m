Return-Path: <nicola@corna.info>
From: Nicola Corna <nicola@corna.info>
To: Wolfram Sang <wsa@the-dreams.de>,
	Stephen Warren <swarren@wwwdotorg.org>,
	Lee Jones <lee@kernel.org>,
	Eric Anholt <eric@anholt.net>,
	Jonathan Cameron <jic23@kernel.org>
Cc: linux-i2c@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	linux-iio@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org,
	Nicola Corna <nicola@corna.info>
Subject: [PATCH v2 1/5] i2c: add i2c quirk flag for unsupported clock stretching
Date: Thu, 29 Oct 2015 12:34:23 +0100
Message-Id: <1446118467-26453-1-git-send-email-nicola@corna.info>
In-Reply-To: <1445976718-7449-1-git-send-email-nicola@corna.info>
References: <1445976718-7449-1-git-send-email-nicola@corna.info>
List-ID: <linux-iio@vger.kernel.org>

Add I2C_AQ_NO_CLK_STRETCH quirk flag, to be used when clock stretching is
not supported.

Signed-off-by: Nicola Corna <nicola@corna.info>
---
 include/linux/i2c.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/i2c.h b/include/linux/i2c.h
index 768063b..9697002 100644
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -493,6 +493,8 @@ struct i2c_adapter_quirks {
 /* convenience macro for typical write-then read case */
 #define I2C_AQ_COMB_WRITE_THEN_READ	(I2C_AQ_COMB | I2C_AQ_COMB_WRITE_FIRST | \
 					 I2C_AQ_COMB_READ_SECOND | I2C_AQ_COMB_SAME_ADDR)
+/* clock stretching is not supported */
+#define I2C_AQ_NO_CLK_STRETCH		BIT(4)
 
 /*
  * i2c_adapter is the structure used to identify a physical i2c bus along
-- 
2.6.1
