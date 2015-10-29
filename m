Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from 19.mo4.mail-out.ovh.net ([87.98.179.66]:39726 "EHLO
	19.mo4.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751024AbbJ2Mlw (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 29 Oct 2015 08:41:52 -0400
Received: from mail170.ha.ovh.net (gw6.ovh.net [213.251.189.206])
	by mo4.mail-out.ovh.net (Postfix) with SMTP id 5EA83FFBD6A
	for <linux-iio@vger.kernel.org>; Thu, 29 Oct 2015 13:02:59 +0100 (CET)
From: Nicola Corna <nicola@corna.info>
To: Wolfram Sang <wsa@the-dreams.de>,
	Stephen Warren <swarren@wwwdotorg.org>,
	Lee Jones <lee@kernel.org>, Eric Anholt <eric@anholt.net>,
	Jonathan Cameron <jic23@kernel.org>
Cc: linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org,
	Nicola Corna <nicola@corna.info>
Subject: [PATCH v2 2/5] i2c: add I2C_AQ_NO_CLK_STRETCH to i2c-algo-bit.c
Date: Thu, 29 Oct 2015 12:34:24 +0100
Message-Id: <1446118467-26453-2-git-send-email-nicola@corna.info>
In-Reply-To: <1446118467-26453-1-git-send-email-nicola@corna.info>
References: <1445976718-7449-1-git-send-email-nicola@corna.info>
 <1446118467-26453-1-git-send-email-nicola@corna.info>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Add I2C_AQ_NO_CLK_STRETCH to drivers/i2c/algos/i2c-algo-bit.c when getscl
is not available.

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

