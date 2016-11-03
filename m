Return-Path: <masneyb@onstation.org>
From: Brian Masney <masneyb@onstation.org>
To: jic23@kernel.org,
	linux-iio@vger.kernel.org
Cc: devel@driverdev.osuosl.org,
	gregkh@linuxfoundation.org,
	lars@metafoo.de,
	pmeerw@pmeerw.net,
	knaack.h@gmx.de,
	linux-kernel@vger.kernel.org,
	Jon.Brenner@ams.com
Subject: [PATCH 4/9] staging: iio: tsl2583: remove redundant power off sequence in taos_chip_on()
Date: Thu,  3 Nov 2016 08:56:15 -0400
Message-Id: <1478177780-28699-5-git-send-email-masneyb@onstation.org>
In-Reply-To: <1478177780-28699-1-git-send-email-masneyb@onstation.org>
References: <1478177780-28699-1-git-send-email-masneyb@onstation.org>
List-ID: <linux-iio@vger.kernel.org>

taos_chip_on() explicitly turns the sensor power on and then writes the
8 registers that are stored in taos_config. The first register in
taos_config is the CONTROL register and the configuration is set to
turn the power off. The existing state sequence in taos_chip_on() is:

- Turn device power on
- Turn device power off (via taos_config)
- Configure other 7 registers (via taos_config)
- Turn device power on, enable ADC

This patch changes the code so that the device is not powered off via
taos_config.

Verified that the driver still functions correctly using a TSL2581
hooked up to a Raspberry Pi 2.

Signed-off-by: Brian Masney <masneyb@onstation.org>
---
 drivers/staging/iio/light/tsl2583.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/iio/light/tsl2583.c b/drivers/staging/iio/light/tsl2583.c
index 709f446..7fb09c6 100644
--- a/drivers/staging/iio/light/tsl2583.c
+++ b/drivers/staging/iio/light/tsl2583.c
@@ -410,17 +410,8 @@ static int taos_chip_on(struct iio_dev *indio_dev)
 	chip->als_saturation = als_count * 922; /* 90% of full scale */
 	chip->als_time_scale = (als_time + 25) / 50;
 
-	/*
-	 * TSL258x Specific power-on / adc enable sequence
-	 * Power on the device 1st.
-	 */
-	utmp = TSL258X_CNTL_PWR_ON;
-	ret = i2c_smbus_write_byte_data(chip->client,
-					TSL258X_CMD_REG | TSL258X_CNTRL, utmp);
-	if (ret < 0) {
-		dev_err(&chip->client->dev, "taos_chip_on failed on CNTRL reg.\n");
-		return ret;
-	}
+	/* Power on the device; ADC off. */
+	chip->taos_config[TSL258X_CNTRL] = TSL258X_CNTL_PWR_ON;
 
 	/*
 	 * Use the following shadow copy for our delay before enabling ADC.
-- 
2.5.5
