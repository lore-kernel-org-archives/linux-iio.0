Return-Path: <hns@goldelico.com>
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
	"Andrew F. Davis" <afd@ti.com>,
	Mark Brown <broonie@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>
Cc: linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-omap@vger.kernel.org,
	letux-kernel@openphoenux.org,
	linux-iio@vger.kernel.org,
	kernel@pyra-handheld.com,
	"H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [PATCH v7 3/9] drivers:input:tsc2007: check for presence and power down tsc2007 during probe
Date: Fri, 11 Nov 2016 20:02:00 +0100
Message-Id: <0c45f364b0231477b81e0c820d20a14211d6c759.1478890925.git.hns@goldelico.com>
In-Reply-To: <cover.1478890925.git.hns@goldelico.com>
References: <cover.1478890925.git.hns@goldelico.com>
In-Reply-To: <cover.1478890925.git.hns@goldelico.com>
References: <cover.1478890925.git.hns@goldelico.com>
List-ID: <linux-iio@vger.kernel.org>

1. check if chip is really present and don't succeed if it isn't.
2. if it succeeds, power down the chip until accessed

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 drivers/input/touchscreen/tsc2007.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/input/touchscreen/tsc2007.c b/drivers/input/touchscreen/tsc2007.c
index e9d5086..5e3c4bf 100644
--- a/drivers/input/touchscreen/tsc2007.c
+++ b/drivers/input/touchscreen/tsc2007.c
@@ -538,6 +538,14 @@ static int tsc2007_probe(struct i2c_client *client,
 
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
