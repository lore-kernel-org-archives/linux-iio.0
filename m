Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F8D3B1003
	for <linux-iio@vger.kernel.org>; Tue, 12 May 2026 12:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778590263; cv=none; b=bw1vLS8YA0n/OtLN5QRlXdNKzib7alJerEImmMudgvL4HdElC8X3THGX6IAT2xI5W80JpxSbRa2v/iTMJGHTpuJkLxVA97fvECGOPN/kHcgaDJKlG6HmXhibnkJVuzP72ZmZYjoyTiuUffwdLr9yZeoNLoqrk+66ZZogDSIpJbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778590263; c=relaxed/simple;
	bh=e+0U4Ow7rWGlilnutj2I8USKJonMlmpsu+TEZ98N0Lw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=q2pzkyvfUdeJJRxQgc6sP6wL1V8rVxkVPRuESDaqvmaGbkEB/MZeOSp6j5f5bxwXof1tH1fqNxuQIt+zvR4b2VPuIhiy72Iy7Pv9U0tXU+wDMdwh+k9B91IIyFQLquhEQgujVaW9Zyus+8ST/WOTLvXYF8PBVHdvDIuDsCdgowE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=X6pkgjSM; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="X6pkgjSM"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-48374014a77so50577095e9.3
        for <linux-iio@vger.kernel.org>; Tue, 12 May 2026 05:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1778590259; x=1779195059; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jEiJ1p0MysT9uZ6t0AF7Y/l/BfCwqdbT2A7/EO2I6Ac=;
        b=X6pkgjSM0NWXxf4ZGk3BTdhnDZHRhZA5c8FML4WEQb0FEt1KzLETg0XCXKW2iQawl2
         hfLPZ9k82Rw/R4B3Dq5wV0Ja1yU9tepDZDnDdQXINQxAiMsvt0mGYUIuJRJBJmcya0hE
         SSo0+nGijSFFC7RRw6VNVl6PP0STgq0iNCf+RShR9t7su0xGFyVcm7C1ulXdqS6UWRTl
         ulPFQ/PFikSAN09fYjBU2Qy4BPI98orWJv6tVgO3mzN+YkZvZrKoz+GU8IPUDGssyUyf
         ZWtZaCt47gxIdAV370R+wwwmezBIYmy7GwUPQDhh1CDBoROpHoJ2W7Mq6sP6sgRvOARv
         wn/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778590259; x=1779195059;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jEiJ1p0MysT9uZ6t0AF7Y/l/BfCwqdbT2A7/EO2I6Ac=;
        b=e/hhAWhq80jMxrQ7wFbtJBxjUX512A5ixciZLHu+x96Akl+1u94aknf4ZzTluHymXb
         m4JOcfYVu65lKCWCCKQ0EKyrzv5HpAbZpp4kfbU7/KFHmdD6mNSIo0uSnKHvdX4U0RR/
         AdoVw4y8N2ssoOHAevk9VG1E1u0KEk2gO7dTUu5Ahl5EvQO38j8wizOdq+VHBK3L6CLL
         dqDwqpDAGd6/ljc2vAxTstapDx0cgJ6WGbXqJiLqr283MiMBrGdwSQLJh4aigDkdo/fQ
         HYZ2egARxWdN/6Cj/Jg0kKGsObaWxtXw9UQRL8mtc5aWOtCYWuM1ZnO4oISzZok82/Av
         FeDg==
X-Forwarded-Encrypted: i=1; AFNElJ+0YWP3a23VRwVv22BoKIOqwGNWi1vHGbMMfbLvpRA1ht8yXExOqxdzrjbsNIPrlyFzwdRm6U8B5uU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUXHvGeP6trSZOCxrcP9sEpP8byeqsyLdBli5g4rd5KmWvxGep
	KPcdpBy+5hs+G5iaM/nDpqAOLPe4X4lvSbMuH8jXSS1rHEq63zTPVT9Y7bwjulJyo1o=
X-Gm-Gg: Acq92OGz92PPEs9OKFfpGBVkEQtvQyTwJnd+MpvcsEWPQpqS9/QH9s+ITJy4vPQIxSI
	gE8oMAOmN598Sa4AyURwDepEkn+tn1vAzKOffRQjxu5r/9rIXzw+JL/sGW+pvyWQlEMqtBQi/zJ
	2wSfuPrsLxjHD1xr9aC+fjR/PnllwjC3yIXeFtgF24BMkPsQQF41PdSnD4SmoI1Y2vUZ/3QxbOo
	6ZKVbghkDSFK3dAXW7qsdFAj5CuO3Ufn4xNXgz8l1rct0i7dePz2V5GpQm20rwuCWEB3gQX5PGW
	ztfhnC8kG/2fhOqWbCFV9cPYUEoEJDzYFZMKZ/Rvi3kwGZuoF/yEmtGsPonZdPurIQq+f4g1uJu
	tSiA0X6IbuV1fA6ulp6bi2S7lzVxtFWBzjLbM5T3zzWYXUu7kC2b4FCPVsiy7KkCbcP3FL58F7o
	cc+lsw8jILYM9NXiFIbQDYERvyp5EhFjwB1bzv49IONNg4/pD6Bb/jQuh9lN4iZlI7FCGvNuAAX
	QC6rIYTfHdhxL0=
X-Received: by 2002:a05:600c:4695:b0:48e:5d91:cffb with SMTP id 5b1f17b1804b1-48e706c0662mr216301545e9.10.1778590259434;
        Tue, 12 May 2026 05:50:59 -0700 (PDT)
Received: from localhost (p200300f65f114e08229f8c404acd2182.dip0.t-ipconnect.de. [2003:f6:5f11:4e08:229f:8c40:4acd:2182])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-48e913469besm11310355e9.14.2026.05.12.05.50.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 05:50:58 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Matteo Martelli <matteomartelli3@gmail.com>,
	David Lechner <dlechner@baylibre.com>,
	=?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Mikael Gonella-Bolduc <m.gonella.bolduc@gmail.com>,
	Linus Walleij <linusw@kernel.org>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	linux-iio@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Puranjay Mohan <puranjay@kernel.org>,
	Marcelo Schmitt <marcelo.schmitt@analog.com>,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Ramona Gradinariu <ramona.gradinariu@analog.com>,
	Ariana Lazar <ariana.lazar@microchip.com>,
	Alex Lanzano <lanzano.alex@gmail.com>,
	Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
	Remi Buisson <remi.buisson@tdk.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Christian Eggers <ceggers@arri.de>,
	Tomasz Duszynski <tduszyns@gmail.com>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Andreas Klinger <ak@it-klinger.de>,
	Waqar Hameed <waqar.hameed@axis.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Gustavo Vaz <gustavo.vaz@usp.br>,
	Dixit Parmar <dixitparmar19@gmail.com>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Chuang Zhu <git@chuang.cz>,
	Kyle Hsieh <kylehsieh1995@gmail.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Sander Vanheule <sander@svanheule.net>,
	Romain Gantois <romain.gantois@bootlin.com>,
	David Jander <david@protonic.nl>,
	Kurt Borja <kuurtb@gmail.com>,
	Tomas Borquez <tomasborquez13@gmail.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	chuguangqing <chuguangqing@inspur.com>,
	Shi Hao <i.shihao.999@gmail.com>,
	Erikas Bitovtas <xerikasxx@gmail.com>,
	Marcus Folkesson <marcus.folkesson@gmail.com>
Subject: [PATCH v1 0/2] iio: Rework i2c_device_id initialisation
Date: Tue, 12 May 2026 14:50:33 +0200
Message-ID: <cover.1778582187.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=7872; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=e+0U4Ow7rWGlilnutj2I8USKJonMlmpsu+TEZ98N0Lw=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBqAyIaHIJhL34l/xZ10sUuWqdyK6ckYL2FsWnSQ cOmanf7aKmJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCagMiGgAKCRCPgPtYfRL+ TjJFB/4tuRMynJJAARN0BaR+DHNuP0k5SF64zGTxv+U40Xh80b3MiA/be/U58deQayNQcF9ad97 1F3DuR2TJXqG/+XsuVagLJOZQeUaC2gX9pKPRWu34ty1nXbJa6HVzVfoR/UwMLSvNBhG4uJIWXO 1teXjY3WK+jtMQzzKMUk5xv7TINgntk26GgA4QtJ8RGcH749BhZbNXFP80kVsTo7Xe8oe/llY2f U5SOhBUVkagE+eqSFoGd0L/CzPHWFnA/+f9oz1SvILuKyztSBI8rc8aqEfX/8KdYY8ZDmZWu7sJ 32+JqibNQfZkIp64n+mV8n0Ds9CRMO924LDJ+R0Pw9rg+dJw
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

Hello,

this series is a preparation for 

	diff --git a/include/linux/mod_devicetable.h b/include/linux/mod_devicetable.h
	index 23ff24080dfd..aebd3a5e90af 100644
	--- a/include/linux/mod_devicetable.h
	+++ b/include/linux/mod_devicetable.h
	@@ -477,7 +477,11 @@ struct rpmsg_device_id {
	 
	 struct i2c_device_id {
		char name[I2C_NAME_SIZE];
	-	kernel_ulong_t driver_data;	/* Data private to the driver */
	+	union {
	+		/* Data private to the driver */
	+		kernel_ulong_t driver_data;
	+		const void *driver_data_ptr;
	+	};
	 };

and this requires that .driver_data is assigned via a named initializer
for static data. This requirement isn't a bad one because named
initializers are also much better readable than list initializers.

Once the union is in place, this allows changes like:
 
	diff --git a/drivers/iio/accel/kxcjk-1013.c b/drivers/iio/accel/kxcjk-1013.c
	index 8a082ff034dd..b2aac7348d22 100644
	--- a/drivers/iio/accel/kxcjk-1013.c
	+++ b/drivers/iio/accel/kxcjk-1013.c
	@@ -1429,7 +1429,7 @@ static int kxcjk1013_probe(struct i2c_client *client)
	 
		if (id) {
			name = id->name;
	-		data->info = (const struct kx_chipset_info *)(id->driver_data);
	+		data->info = id->driver_data_ptr;
		} else {
			name = iio_get_acpi_device_name_and_data(&client->dev, &ddata);
			data->info = ddata;
	@@ -1630,11 +1630,11 @@ static const struct dev_pm_ops kxcjk1013_pm_ops = {
	 };
	 
	 static const struct i2c_device_id kxcjk1013_id[] = {
	-	{ .name = "kxcjk1013", .driver_data = (kernel_ulong_t)&kxcjk1013_info },
	-	{ .name = "kxcj91008", .driver_data = (kernel_ulong_t)&kxcj91008_info },
	-	{ .name = "kxtj21009", .driver_data = (kernel_ulong_t)&kxtj21009_info },
	-	{ .name = "kxtf9", .driver_data = (kernel_ulong_t)&kxtf9_info },
	-	{ .name = "kx023-1025", .driver_data = (kernel_ulong_t)&kx0231025_info },
	+	{ .name = "kxcjk1013", .driver_data_ptr = &kxcjk1013_info },
	+	{ .name = "kxcj91008", .driver_data_ptr = &kxcj91008_info },
	+	{ .name = "kxtj21009", .driver_data_ptr = &kxtj21009_info },
	+	{ .name = "kxtf9", .driver_data_ptr = &kxtf9_info },
	+	{ .name = "kx023-1025", .driver_data_ptr = &kx0231025_info },
		{ }
	 };
	 MODULE_DEVICE_TABLE(i2c, kxcjk1013_id);

that is an improvement for readability (again!) and it keeps some
properties of the pointers (here: being const) without having to pay
attention for that. (I didn't spot a driver that doesn't have that const
on casting back in drivers/iio, but other subsystems will benefit here,
too.)

My additional motivation for this effort is CHERI[1]. This is a hardware
extension that uses 128 bit pointers but unsigned long is still 64 bit.
So with CHERI you cannot store pointers in unsigned long variables.

The first patch drops a few unused assignments to .driver_data (which is
still better than assigning the values by name) and the second converts
all iio drivers with driver_data to use named initializers.

Best regards
Uwe

[1] https://cheri-alliance.org/discover-cheri/
    https://lwn.net/Articles/1037974/

Uwe Kleine-König (The Capable Hub) (2):
  iio: Drop unused driver_data in four i2c drivers
  iio: Initialize i2c_device_id arrays using member names

 drivers/iio/accel/adxl345_i2c.c               |  4 +-
 drivers/iio/accel/adxl355_i2c.c               |  4 +-
 drivers/iio/accel/adxl372_i2c.c               |  4 +-
 drivers/iio/accel/adxl380_i2c.c               |  8 +-
 drivers/iio/accel/bma180.c                    | 10 +-
 drivers/iio/accel/bmc150-accel-i2c.c          | 20 ++--
 drivers/iio/accel/bmi088-accel-i2c.c          |  6 +-
 drivers/iio/accel/da280.c                     |  6 +-
 drivers/iio/accel/fxls8962af-i2c.c            |  8 +-
 drivers/iio/accel/kxcjk-1013.c                | 10 +-
 drivers/iio/accel/mc3230.c                    |  4 +-
 drivers/iio/accel/mma8452.c                   | 12 +--
 drivers/iio/adc/ad7091r5.c                    |  2 +-
 drivers/iio/adc/ad799x.c                      | 16 ++--
 drivers/iio/adc/ina2xx-adc.c                  | 12 +--
 drivers/iio/adc/ltc2309.c                     |  4 +-
 drivers/iio/adc/ltc2471.c                     |  4 +-
 drivers/iio/adc/ltc2497.c                     |  4 +-
 drivers/iio/adc/max34408.c                    |  4 +-
 drivers/iio/adc/mcp3422.c                     | 16 ++--
 drivers/iio/adc/pac1921.c                     |  2 +-
 drivers/iio/adc/ti-adc081c.c                  |  6 +-
 drivers/iio/adc/ti-ads1015.c                  |  6 +-
 drivers/iio/adc/ti-ads7138.c                  |  4 +-
 drivers/iio/cdc/ad7150.c                      |  6 +-
 drivers/iio/cdc/ad7746.c                      |  6 +-
 drivers/iio/chemical/atlas-ezo-sensor.c       |  6 +-
 drivers/iio/chemical/atlas-sensor.c           | 10 +-
 drivers/iio/chemical/sgp30.c                  |  4 +-
 drivers/iio/chemical/vz89x.c                  |  4 +-
 drivers/iio/dac/ad5064.c                      | 94 +++++++++----------
 drivers/iio/dac/ad5380.c                      | 32 +++----
 drivers/iio/dac/ad5446-i2c.c                  | 12 +--
 drivers/iio/dac/ad5696-i2c.c                  | 32 +++----
 drivers/iio/dac/ds4424.c                      |  8 +-
 drivers/iio/dac/max517.c                      | 10 +-
 drivers/iio/dac/max5821.c                     |  2 +-
 drivers/iio/dac/mcp4725.c                     |  4 +-
 drivers/iio/dac/mcp47feb02.c                  | 48 +++++-----
 drivers/iio/dac/ti-dac5571.c                  | 22 ++---
 drivers/iio/health/max30102.c                 |  6 +-
 drivers/iio/humidity/ens210.c                 | 12 +--
 drivers/iio/humidity/htu21.c                  |  4 +-
 drivers/iio/imu/bmi270/bmi270_i2c.c           |  4 +-
 .../iio/imu/inv_icm42600/inv_icm42600_i2c.c   | 14 +--
 .../iio/imu/inv_icm45600/inv_icm45600_i2c.c   | 16 ++--
 drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c     | 36 +++----
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c   | 48 +++++-----
 drivers/iio/light/apds9160.c                  |  2 +-
 drivers/iio/light/as73211.c                   |  4 +-
 drivers/iio/light/bh1750.c                    | 10 +-
 drivers/iio/light/isl29018.c                  |  6 +-
 drivers/iio/light/ltr501.c                    |  8 +-
 drivers/iio/light/opt3001.c                   |  4 +-
 drivers/iio/light/opt4001.c                   |  4 +-
 drivers/iio/light/si1145.c                    | 14 +--
 drivers/iio/light/tsl2563.c                   |  8 +-
 drivers/iio/light/tsl2583.c                   |  6 +-
 drivers/iio/light/tsl2772.c                   | 22 ++---
 drivers/iio/light/vcnl4000.c                  | 14 +--
 drivers/iio/light/veml6030.c                  |  6 +-
 drivers/iio/magnetometer/ak8975.c             | 14 +--
 drivers/iio/magnetometer/hmc5843_i2c.c        |  8 +-
 drivers/iio/magnetometer/yamaha-yas530.c      |  8 +-
 drivers/iio/potentiometer/ad5272.c            | 10 +-
 drivers/iio/potentiometer/ds1803.c            |  8 +-
 drivers/iio/potentiometer/tpl0102.c           |  8 +-
 drivers/iio/pressure/abp060mg.c               | 90 +++++++++++-------
 drivers/iio/pressure/bmp280-i2c.c             | 12 +--
 drivers/iio/pressure/dlhl60d.c                |  4 +-
 drivers/iio/pressure/ms5611_i2c.c             |  4 +-
 drivers/iio/pressure/ms5637.c                 |  8 +-
 drivers/iio/pressure/st_pressure_i2c.c        | 16 ++--
 drivers/iio/proximity/aw96103.c               |  4 +-
 drivers/iio/proximity/srf08.c                 |  6 +-
 drivers/iio/proximity/sx9310.c                |  4 +-
 drivers/iio/proximity/sx9324.c                |  2 +-
 drivers/iio/proximity/sx9360.c                |  2 +-
 drivers/iio/temperature/tmp117.c              |  4 +-
 79 files changed, 479 insertions(+), 457 deletions(-)


base-commit: 254f49634ee16a731174d2ae34bc50bd5f45e731
-- 
2.47.3

