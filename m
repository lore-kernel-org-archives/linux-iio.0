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
	Nicola Corna <nicola@corna.info>
Subject: [PATCH 2/4] i2c: added I2C_AQ_NO_CLK_STRETCH to i2c-algo-bit.c
Date: Tue, 27 Oct 2015 21:11:56 +0100
Message-Id: <1445976718-7449-2-git-send-email-nicola@corna.info>
In-Reply-To: <1445976718-7449-1-git-send-email-nicola@corna.info>
References: <1445976718-7449-1-git-send-email-nicola@corna.info>
List-ID: <linux-iio@vger.kernel.org>

Added I2C_AQ_NO_CLK_STRETCH to drivers/i2c/algos/i2c-algo-bit.c when
getscl is not available.

Signed-off-by: Nicola Corna <nicola@corna.info>
---
 drivers/i2c/algos/i2c-algo-bit.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/i2c/algos/i2c-algo-bit.c b/drivers/i2c/algos/i2c-algo-bit.c
index 899bede..9d233bb 100644
--- a/drivers/i2c/algos/i2c-algo-bit.c
+++ b/drivers/i2c/algos/i2c-algo-bit.c
@@ -617,6 +617,10 @@ const struct i2c_algorithm i2c_bit_algo = {
 };
 EXPORT_SYMBOL(i2c_bit_algo);
 
+const struct i2c_adapter_quirks i2c_bit_quirk_no_clk_stretch = {
+	.flags = I2C_AQ_NO_CLK_STRETCH,
+};
+
 /*
  * registering functions to load algorithms at runtime
  */
@@ -635,6 +639,8 @@ static int __i2c_bit_add_bus(struct i2c_adapter *adap,
 	/* register new adapter to i2c module... */
 	adap->algo = &i2c_bit_algo;
 	adap->retries = 3;
+	if (bit_adap->getscl == NULL)
+		adap->quirks = &i2c_bit_quirk_no_clk_stretch;
 
 	ret = add_adapter(adap);
 	if (ret < 0)
-- 
2.6.1
