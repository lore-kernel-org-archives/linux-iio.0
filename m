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
Subject: [PATCH 3/4] i2c: added I2C_AQ_NO_CLK_STRETCH to i2c-bcm2835.c
Date: Tue, 27 Oct 2015 21:11:57 +0100
Message-Id: <1445976718-7449-3-git-send-email-nicola@corna.info>
In-Reply-To: <1445976718-7449-1-git-send-email-nicola@corna.info>
References: <1445976718-7449-1-git-send-email-nicola@corna.info>
List-ID: <linux-iio@vger.kernel.org>

As reported here
http://www.advamation.com/knowhow/raspberrypi/rpi-i2c-bug.html
the BCM2835 has a bug in its i2c implementation which prevents a correct
clock stretching.

Signed-off-by: Nicola Corna <nicola@corna.info>
---
 drivers/i2c/busses/i2c-bcm2835.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/i2c/busses/i2c-bcm2835.c b/drivers/i2c/busses/i2c-bcm2835.c
index 3032b89..38d7102 100644
--- a/drivers/i2c/busses/i2c-bcm2835.c
+++ b/drivers/i2c/busses/i2c-bcm2835.c
@@ -222,6 +222,10 @@ static const struct i2c_algorithm bcm2835_i2c_algo = {
 	.functionality	= bcm2835_i2c_func,
 };
 
+static const struct i2c_adapter_quirks bcm2835_i2c_quirks = {
+	.flags = I2C_AQ_NO_CLK_STRETCH,
+};
+
 static int bcm2835_i2c_probe(struct platform_device *pdev)
 {
 	struct bcm2835_i2c_dev *i2c_dev;
@@ -293,6 +297,7 @@ static int bcm2835_i2c_probe(struct platform_device *pdev)
 	adap->algo = &bcm2835_i2c_algo;
 	adap->dev.parent = &pdev->dev;
 	adap->dev.of_node = pdev->dev.of_node;
+	adap->quirks = &bcm2835_i2c_quirks;
 
 	bcm2835_i2c_writel(i2c_dev, BCM2835_I2C_C, 0);
 
-- 
2.6.1
