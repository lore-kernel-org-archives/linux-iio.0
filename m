Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-ea0-f178.google.com ([209.85.215.178]:45411 "EHLO
	mail-ea0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752585Ab3IJMuN (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 10 Sep 2013 08:50:13 -0400
Received: by mail-ea0-f178.google.com with SMTP id a15so3868764eae.37
        for <linux-iio@vger.kernel.org>; Tue, 10 Sep 2013 05:50:12 -0700 (PDT)
From: Lee Jones <lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	jic23@cam.ac.uk
Cc: arnd@arndb.de, linus.walleij@linaro.org, denis.ciocca@st.com,
	linux-iio@vger.kernel.org, Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 25/38] iio: pressure-core: st: Allow for number of channels to vary
Date: Tue, 10 Sep 2013 13:49:26 +0100
Message-Id: <1378817379-8238-26-git-send-email-lee.jones@linaro.org>
In-Reply-To: <1378817379-8238-1-git-send-email-lee.jones@linaro.org>
References: <1378817379-8238-1-git-send-email-lee.jones@linaro.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

At the moment the number of channels specified is dictated by the first
sensor supported by the driver. As we add support for more sensors this
is likely to vary. Instead of using the ARRAY_SIZE() of the LPS331AP's
channel specifier we'll use a new adaptable 'struct st_sensors' element
instead.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/iio/pressure/st_pressure_core.c | 3 ++-
 include/linux/iio/common/st_sensors.h   | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/pressure/st_pressure_core.c b/drivers/iio/pressure/st_pressure_core.c
index 60c2ee4..3abada2 100644
--- a/drivers/iio/pressure/st_pressure_core.c
+++ b/drivers/iio/pressure/st_pressure_core.c
@@ -107,6 +107,7 @@ static const struct st_sensors st_press_sensors[] = {
 			[0] = LPS331AP_PRESS_DEV_NAME,
 		},
 		.ch = (struct iio_chan_spec *)st_press_lps331ap_channels,
+		.num_ch = ARRAY_SIZE(st_press_lps331ap_channels),
 		.odr = {
 			.addr = ST_PRESS_LPS331AP_ODR_ADDR,
 			.mask = ST_PRESS_LPS331AP_ODR_MASK,
@@ -245,7 +246,7 @@ int st_press_common_probe(struct iio_dev *indio_dev,
 	pdata->num_data_channels = ST_PRESS_NUMBER_DATA_CHANNELS;
 	pdata->multiread_bit = pdata->sensor->multi_read_bit;
 	indio_dev->channels = pdata->sensor->ch;
-	indio_dev->num_channels = ARRAY_SIZE(st_press_lps331ap_channels);
+	indio_dev->num_channels = pdata->sensor->num_ch;
 
 	if (pdata->sensor->fs.addr != 0)
 		pdata->current_fullscale = (struct st_sensor_fullscale_avl *)
diff --git a/include/linux/iio/common/st_sensors.h b/include/linux/iio/common/st_sensors.h
index e51f654..e732fda 100644
--- a/include/linux/iio/common/st_sensors.h
+++ b/include/linux/iio/common/st_sensors.h
@@ -184,6 +184,7 @@ struct st_sensors {
 	u8 wai;
 	char sensors_supported[ST_SENSORS_MAX_4WAI][ST_SENSORS_MAX_NAME];
 	struct iio_chan_spec *ch;
+	int num_ch;
 	struct st_sensor_odr odr;
 	struct st_sensor_power pw;
 	struct st_sensor_axis enable_axis;
-- 
1.8.1.2

