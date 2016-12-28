Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mo4-p04-ob.smtp.rzone.de ([81.169.146.177]:21336 "EHLO
        mo4-p04-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751040AbcL1Oxf (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 28 Dec 2016 09:53:35 -0500
From: "H. Nikolaus Schaller" <hns@goldelico.com>
To: Sebastian Reichel <sre@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>,
        Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Michael Welling <mwelling@ieee.org>,
        =?UTF-8?q?Mika=20Penttil=C3=A4?= <mika.penttila@nextfour.com>,
        Javier Martinez Canillas <javier@osg.samsung.com>,
        Igor Grinberg <grinberg@compulab.co.il>,
        "Andrew F. Davis" <afd@ti.com>, Mark Brown <broonie@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "H. Nikolaus Schaller" <hns@goldelico.com>,
        Alexander Stein <alexander.stein@systec-electronic.com>,
        Eric Engestrom <eric@engestrom.ch>,
        Hans de Goede <hdegoede@redhat.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Petr Cvek <petr.cvek@tul.cz>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Nick Dyer <nick@shmanahar.org>,
        Siebren Vroegindeweij <siebren.vroegindeweij@hotmail.com>,
        Michel Verlaan <michel.verl@gmail.com>
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
        letux-kernel@openphoenux.org, linux-iio@vger.kernel.org,
        kernel@pyra-handheld.com
Subject: [PATCH v9 2/8] drivers:input:tsc2007: check for presence and power down tsc2007 during probe
Date: Wed, 28 Dec 2016 15:53:17 +0100
Message-Id: <f39f47ebef2224bd73e114ee529768756bb8972a.1482936802.git.hns@goldelico.com>
In-Reply-To: <cover.1482936802.git.hns@goldelico.com>
References: <cover.1482936802.git.hns@goldelico.com>
In-Reply-To: <cover.1482936802.git.hns@goldelico.com>
References: <cover.1482936802.git.hns@goldelico.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

1. check if chip is really present and don't succeed if it isn't.
2. if it succeeds, power down the chip until accessed

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 drivers/input/touchscreen/tsc2007.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/input/touchscreen/tsc2007.c b/drivers/input/touchscreen/tsc2007.c
index c1d9593..76b462b 100644
--- a/drivers/input/touchscreen/tsc2007.c
+++ b/drivers/input/touchscreen/tsc2007.c
@@ -529,6 +529,14 @@ static int tsc2007_probe(struct i2c_client *client,
 
 	tsc2007_stop(ts);
 
+	/* power down the chip (TSC2007_SETUP does not ACK on I2C) */
+	err = tsc2007_xfer(ts, PWRDOWN);
+	if (err < 0) {
+		dev_err(&client->dev,
+			"Failed to setup chip: %d\n", err);
+		return err;	/* usually, chip does not respond */
+	}
+
 	err = input_register_device(input_dev);
 	if (err) {
 		dev_err(&client->dev,
-- 
2.7.3

