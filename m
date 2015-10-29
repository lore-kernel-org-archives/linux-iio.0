Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from 6.mo4.mail-out.ovh.net ([188.165.36.253]:39755 "EHLO
	6.mo4.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751148AbbJ2Mlz (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 29 Oct 2015 08:41:55 -0400
Received: from mail170.ha.ovh.net (gw6.ovh.net [213.251.189.206])
	by mo4.mail-out.ovh.net (Postfix) with SMTP id DA98A1000022
	for <linux-iio@vger.kernel.org>; Thu, 29 Oct 2015 13:04:19 +0100 (CET)
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
Subject: [PATCH v2 3/5] i2c: add I2C_AQ_NO_CLK_STRETCH to i2c-bcm2835.c
Date: Thu, 29 Oct 2015 12:34:25 +0100
Message-Id: <1446118467-26453-3-git-send-email-nicola@corna.info>
In-Reply-To: <1446118467-26453-1-git-send-email-nicola@corna.info>
References: <1445976718-7449-1-git-send-email-nicola@corna.info>
 <1446118467-26453-1-git-send-email-nicola@corna.info>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

As reported here
http://www.advamation.com/knowhow/raspberrypi/rpi-i2c-bug.html
and confirmed here
https://www.raspberrypi.org/forums/viewtopic.php?p=146272
the BCM2835 has a hardware bug in its i2c module which prevents a correct
clock stretching. This patch adds the I2C_AQ_NO_CLK_STRETCH quirk flag
to i2c-bcm2835.

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

