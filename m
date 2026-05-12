Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05E903B1ED2
	for <linux-iio@vger.kernel.org>; Tue, 12 May 2026 12:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778590268; cv=none; b=uXutY943pnRj+59xy9HPbxy+W8s5PkTpVPzqyyrbVhg4i/fzXqwyXgTblL0LuxJOAnYBV5G3iwMShuOHD1HDJooi66I+t3VSVVNK8u1oqtl3qBvRgy6xNQm+CbPNzCKwtg06C4LAvsOWD+ZNBRAoF7d1Mod3BKX9fHdzAEQ6mFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778590268; c=relaxed/simple;
	bh=ETbdRNxgqpSWz5dMK/4EfKzIEnHqHiaWOTFMmAWMxL8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mUrjLq4nEJXqR1Vc7xjkW2FMl2M+0b5G6gf+qC5Hr3FRKsORkPvKHlBjuvzmgvvByujanIjJGlIYJzHGdONs48L5sj3bMy1lrXnfpiR9X6Fv+HCu8rvg3k1wRFGRSc2lwS4iZb9UtGVBLu1ar3hQLYwf3gtr3E/tpuQZmXdm6MY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=JWJXXzgM; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="JWJXXzgM"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-48909558b3aso56673355e9.0
        for <linux-iio@vger.kernel.org>; Tue, 12 May 2026 05:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1778590262; x=1779195062; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UkXVwBEap9pZGOqf0duNBxIFlQlkWWRyvMZE9pLMmuk=;
        b=JWJXXzgMbGaFovlx22wIOW5jN0AYWFari372xYC/9Tw9FVgFVSzMPmjFEmmA52gnVg
         XAmqTw15OaAgtaF6MjCjCdOKsKzpUsx28mF/wu3HcgF6qnhu8+sginBFdI1LyW+DPxv5
         82iKCK0VoWTSMZhHYKf+2aVIdbHHQErHLG7P3Ul1iANIlMQ47eCIGEl65sbyj9cbztt+
         V3QQGVoBl4BQRwouCLTsUfMjsHMM+4rPhmmSL2Iy8YAAQL2+n3JAow22zcPnJwRtnJSX
         8lnraD8z7Ohz8oCV3zUVdI6BapCxzrPUkhEQfZDJVabydj2v4FEazeLOgcU9TYlhskci
         E4Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778590262; x=1779195062;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UkXVwBEap9pZGOqf0duNBxIFlQlkWWRyvMZE9pLMmuk=;
        b=gnVma8OwpZZTTcBJpK89oEJV+qWy4o3bqaZorDAcSyUISjoGoNA/k932PEShofnzPy
         O+h8SApK/SYUi4/f/Id/S/IG7ZlxM6rCIvFIag6M3Ei2orRV3rOUFNMaGklI8K3cnYQj
         /8fOlWbkv6U6cIFsRREbbyajJgNE2riFy6XABeuGl2xI6TZPxB8sAqV42dV04vW0kxeP
         fexYzGpZ4MAhUCNwDYYiI1vKBP6kiXEGNhqWShKJaBw8HvcYP7IsozYrfjWU/UQ9lkgI
         Ebbvi1NRq9DW5vU7MYJKbVBRE+8Cu29EA7qy0f6CT+rdvP8drJcPQ58xHNO7GNm5dFDM
         tWWw==
X-Forwarded-Encrypted: i=1; AFNElJ9uNFCCzKbgGDJUziXD4AXfk80IEB3qD5Otcx2pvi1hD2ORaUPP+y2Sjp2TUKrxe49X6KPVwbSUATw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOGLJgnPV5dC92Ldr76y4MH1oXtdjIV/VOywsgDqxW4aAj4jxT
	3KcLUpT7Cbpjrg5qd+KO4MjYbqcYs2J4yaMx/IMpi073SWMGUNfbCoFmo1jqw55I+/o=
X-Gm-Gg: Acq92OEv8xijlxugR7s21T8sxCY7RbpBlsJqPIo6VgRQsxBA4/7Nt6SuS3+2dPcso3T
	ix2wg9AY24kvdOCWJG7AHFfNd8asGS/3ZajG//CYg/a5yuuuSqTD7hgj/cFuP6pW48FssHphJ6j
	kM3sXVt/UOtoOIMgvMkjXtPMw2Py+f38PJwBDyAzO9mY7dKJcUm3foM2h69zb86R0vD4Zar57Ha
	XUgkVYD/TcOe0QQlNAG41G5+229epDRghRdcQn+L4ZqOmpAF9RR5psbGdiMoDrLGstQNTk3TAdK
	0RivgAplc+rvstbIqsFRaldGSb1ErsyDB+joHCqkwXnr3853dTy0L3BzwLXFFHBIjAUKrWis7yi
	ka7a2m6UguTUXY0OiY+rO2WhbrgCKExt9y3b7Sf6lgB/kW/q/JnfTdJuFA7IxSybB7wwGkc7rKQ
	UuEaNnXrEjTI36k8qB10MF/kM/xGFsqc9GR+/D8CDWQdkDknfSh+IOQpa9q1YUIggLD6vWXZiaD
	M70ZjYd6GVSBEo=
X-Received: by 2002:a05:600c:8585:b0:487:2439:b7be with SMTP id 5b1f17b1804b1-48e51e0b5c1mr389944145e9.6.1778590262009;
        Tue, 12 May 2026 05:51:02 -0700 (PDT)
Received: from localhost (p200300f65f114e08229f8c404acd2182.dip0.t-ipconnect.de. [2003:f6:5f11:4e08:229f:8c40:4acd:2182])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-48e90536122sm47141105e9.4.2026.05.12.05.51.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 05:51:01 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	David Lechner <dlechner@baylibre.com>,
	=?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
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
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Dixit Parmar <dixitparmar19@gmail.com>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Chuang Zhu <git@chuang.cz>,
	Kyle Hsieh <kylehsieh1995@gmail.com>,
	Linus Walleij <linusw@kernel.org>,
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
	Marcus Folkesson <marcus.folkesson@gmail.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/2] iio: Initialize i2c_device_id arrays using member names
Date: Tue, 12 May 2026 14:50:35 +0200
Message-ID:  <35a46c1014a1452b0c191a588bee8a09ddea964e.1778582187.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1778582187.git.u.kleine-koenig@baylibre.com>
References: <cover.1778582187.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=84145; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=ETbdRNxgqpSWz5dMK/4EfKzIEnHqHiaWOTFMmAWMxL8=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBqAyIpjb/IeVQj/K6WE5b39GFxBOjafxhX7U+Fq HihxvwdvaaJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCagMiKQAKCRCPgPtYfRL+ TrSjB/9DYtt5bA6d1izmwDjVx5BfOarvuWHUKh1po7v9Ho2zHf/a++7l+uocKur1ogWdZR0z4o9 heaUfTXQiWUqiGQeATtiHsvPP9NtbBkSVAFGt8SUrLt2lazgrAP6kfczSkN3zaD9EOhfizm94aI k77QQco4JKaplJip8i3rjaZVvXClQ/F+dFjH7N3J6W+fj6EcdxQkRnZSYTAo40xchlN2b5bgjON i9aRWGXl3mrYi8w53pl7WhlwIMNBgEDmLdlJW4tIiNpYbBrWm0w5BtDXUbWbLh43Azj4cQlrQJD e/MjTXTeeJSL8TE09JGVopXlQfFNF6pNIruxX9/9OG2MOCSX
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

While being less compact, using named initializers allows to more easily
see which members of the structs are assigned which value without having
to lookup the declaration of the struct. And it's also more robust
against changes to the struct definition.

The mentioned robustness is relevant for a planned change to struct
i2c_device_id that replaces .driver_data by an anonymous union.

This patch doesn't modify the compiled arrays, only their representation
in source form benefits. The former was confirmed with x86 and arm64
builds.

Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>
---
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
 drivers/iio/light/as73211.c                   |  4 +-
 drivers/iio/light/bh1750.c                    | 10 +-
 drivers/iio/light/isl29018.c                  |  6 +-
 drivers/iio/light/ltr501.c                    |  8 +-
 drivers/iio/light/opt3001.c                   |  4 +-
 drivers/iio/light/opt4001.c                   |  4 +-
 drivers/iio/light/si1145.c                    | 14 +--
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
 75 files changed, 470 insertions(+), 448 deletions(-)

diff --git a/drivers/iio/accel/adxl345_i2c.c b/drivers/iio/accel/adxl345_i2c.c
index af84c0043c6c..511fb610436c 100644
--- a/drivers/iio/accel/adxl345_i2c.c
+++ b/drivers/iio/accel/adxl345_i2c.c
@@ -43,8 +43,8 @@ static const struct adxl345_chip_info adxl375_i2c_info = {
 };
 
 static const struct i2c_device_id adxl345_i2c_id[] = {
-	{ "adxl345", (kernel_ulong_t)&adxl345_i2c_info },
-	{ "adxl375", (kernel_ulong_t)&adxl375_i2c_info },
+	{ .name = "adxl345", .driver_data = (kernel_ulong_t)&adxl345_i2c_info },
+	{ .name = "adxl375", .driver_data = (kernel_ulong_t)&adxl375_i2c_info },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, adxl345_i2c_id);
diff --git a/drivers/iio/accel/adxl355_i2c.c b/drivers/iio/accel/adxl355_i2c.c
index 1a512c7b792b..54a99fda1ecb 100644
--- a/drivers/iio/accel/adxl355_i2c.c
+++ b/drivers/iio/accel/adxl355_i2c.c
@@ -41,8 +41,8 @@ static int adxl355_i2c_probe(struct i2c_client *client)
 }
 
 static const struct i2c_device_id adxl355_i2c_id[] = {
-	{ "adxl355", (kernel_ulong_t)&adxl35x_chip_info[ADXL355] },
-	{ "adxl359", (kernel_ulong_t)&adxl35x_chip_info[ADXL359] },
+	{ .name = "adxl355", .driver_data = (kernel_ulong_t)&adxl35x_chip_info[ADXL355] },
+	{ .name = "adxl359", .driver_data = (kernel_ulong_t)&adxl35x_chip_info[ADXL359] },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, adxl355_i2c_id);
diff --git a/drivers/iio/accel/adxl372_i2c.c b/drivers/iio/accel/adxl372_i2c.c
index ca2cabf24938..ddb125075778 100644
--- a/drivers/iio/accel/adxl372_i2c.c
+++ b/drivers/iio/accel/adxl372_i2c.c
@@ -44,8 +44,8 @@ static int adxl372_i2c_probe(struct i2c_client *client)
 }
 
 static const struct i2c_device_id adxl372_i2c_id[] = {
-	{ "adxl371", (kernel_ulong_t)&adxl371_chip_info },
-	{ "adxl372", (kernel_ulong_t)&adxl372_chip_info },
+	{ .name = "adxl371", .driver_data = (kernel_ulong_t)&adxl371_chip_info },
+	{ .name = "adxl372", .driver_data = (kernel_ulong_t)&adxl372_chip_info },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, adxl372_i2c_id);
diff --git a/drivers/iio/accel/adxl380_i2c.c b/drivers/iio/accel/adxl380_i2c.c
index bd8782d08c7d..367a29298047 100644
--- a/drivers/iio/accel/adxl380_i2c.c
+++ b/drivers/iio/accel/adxl380_i2c.c
@@ -33,10 +33,10 @@ static int adxl380_i2c_probe(struct i2c_client *client)
 }
 
 static const struct i2c_device_id adxl380_i2c_id[] = {
-	{ "adxl318", (kernel_ulong_t)&adxl318_chip_info },
-	{ "adxl319", (kernel_ulong_t)&adxl319_chip_info },
-	{ "adxl380", (kernel_ulong_t)&adxl380_chip_info },
-	{ "adxl382", (kernel_ulong_t)&adxl382_chip_info },
+	{ .name = "adxl318", .driver_data = (kernel_ulong_t)&adxl318_chip_info },
+	{ .name = "adxl319", .driver_data = (kernel_ulong_t)&adxl319_chip_info },
+	{ .name = "adxl380", .driver_data = (kernel_ulong_t)&adxl380_chip_info },
+	{ .name = "adxl382", .driver_data = (kernel_ulong_t)&adxl382_chip_info },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, adxl380_i2c_id);
diff --git a/drivers/iio/accel/bma180.c b/drivers/iio/accel/bma180.c
index 7bc6761f5135..e643bc73eefe 100644
--- a/drivers/iio/accel/bma180.c
+++ b/drivers/iio/accel/bma180.c
@@ -1083,11 +1083,11 @@ static int bma180_resume(struct device *dev)
 static DEFINE_SIMPLE_DEV_PM_OPS(bma180_pm_ops, bma180_suspend, bma180_resume);
 
 static const struct i2c_device_id bma180_ids[] = {
-	{ "bma023", (kernel_ulong_t)&bma180_part_info[BMA023] },
-	{ "bma150", (kernel_ulong_t)&bma180_part_info[BMA150] },
-	{ "bma180", (kernel_ulong_t)&bma180_part_info[BMA180] },
-	{ "bma250", (kernel_ulong_t)&bma180_part_info[BMA250] },
-	{ "smb380", (kernel_ulong_t)&bma180_part_info[BMA150] },
+	{ .name = "bma023", .driver_data = (kernel_ulong_t)&bma180_part_info[BMA023] },
+	{ .name = "bma150", .driver_data = (kernel_ulong_t)&bma180_part_info[BMA150] },
+	{ .name = "bma180", .driver_data = (kernel_ulong_t)&bma180_part_info[BMA180] },
+	{ .name = "bma250", .driver_data = (kernel_ulong_t)&bma180_part_info[BMA250] },
+	{ .name = "smb380", .driver_data = (kernel_ulong_t)&bma180_part_info[BMA150] },
 	{ }
 };
 
diff --git a/drivers/iio/accel/bmc150-accel-i2c.c b/drivers/iio/accel/bmc150-accel-i2c.c
index b4604f441553..aab3b110faa5 100644
--- a/drivers/iio/accel/bmc150-accel-i2c.c
+++ b/drivers/iio/accel/bmc150-accel-i2c.c
@@ -245,16 +245,16 @@ static const struct acpi_device_id bmc150_accel_acpi_match[] = {
 MODULE_DEVICE_TABLE(acpi, bmc150_accel_acpi_match);
 
 static const struct i2c_device_id bmc150_accel_id[] = {
-	{"bma222"},
-	{"bma222e"},
-	{"bma250e"},
-	{"bma253"},
-	{"bma254"},
-	{"bma255"},
-	{"bma280"},
-	{"bmc150_accel"},
-	{"bmc156_accel", BOSCH_BMC156},
-	{"bmi055_accel"},
+	{ .name = "bma222", .driver_data = 0 },
+	{ .name = "bma222e", .driver_data = 0 },
+	{ .name = "bma250e", .driver_data = 0 },
+	{ .name = "bma253", .driver_data = 0 },
+	{ .name = "bma254", .driver_data = 0 },
+	{ .name = "bma255", .driver_data = 0 },
+	{ .name = "bma280", .driver_data = 0 },
+	{ .name = "bmc150_accel", .driver_data = 0 },
+	{ .name = "bmc156_accel", .driver_data = BOSCH_BMC156 },
+	{ .name = "bmi055_accel", .driver_data = 0 },
 	{ }
 };
 
diff --git a/drivers/iio/accel/bmi088-accel-i2c.c b/drivers/iio/accel/bmi088-accel-i2c.c
index 310f863029bb..d9468b1c5aee 100644
--- a/drivers/iio/accel/bmi088-accel-i2c.c
+++ b/drivers/iio/accel/bmi088-accel-i2c.c
@@ -45,9 +45,9 @@ static const struct of_device_id bmi088_of_match[] = {
 MODULE_DEVICE_TABLE(of, bmi088_of_match);
 
 static const struct i2c_device_id bmi088_accel_id[] = {
-	{ "bmi085-accel",  BOSCH_BMI085 },
-	{ "bmi088-accel",  BOSCH_BMI088 },
-	{ "bmi090l-accel", BOSCH_BMI090L },
+	{ .name = "bmi085-accel",  .driver_data = BOSCH_BMI085 },
+	{ .name = "bmi088-accel",  .driver_data = BOSCH_BMI088 },
+	{ .name = "bmi090l-accel", .driver_data = BOSCH_BMI090L },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, bmi088_accel_id);
diff --git a/drivers/iio/accel/da280.c b/drivers/iio/accel/da280.c
index c2dd123b9021..15acbe1c2cbd 100644
--- a/drivers/iio/accel/da280.c
+++ b/drivers/iio/accel/da280.c
@@ -162,9 +162,9 @@ static const struct acpi_device_id da280_acpi_match[] = {
 MODULE_DEVICE_TABLE(acpi, da280_acpi_match);
 
 static const struct i2c_device_id da280_i2c_id[] = {
-	{ "da217", (kernel_ulong_t)&da217_match_data },
-	{ "da226", (kernel_ulong_t)&da226_match_data },
-	{ "da280", (kernel_ulong_t)&da280_match_data },
+	{ .name = "da217", .driver_data = (kernel_ulong_t)&da217_match_data },
+	{ .name = "da226", .driver_data = (kernel_ulong_t)&da226_match_data },
+	{ .name = "da280", .driver_data = (kernel_ulong_t)&da280_match_data },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, da280_i2c_id);
diff --git a/drivers/iio/accel/fxls8962af-i2c.c b/drivers/iio/accel/fxls8962af-i2c.c
index 106198a12474..fa46f5aa34f7 100644
--- a/drivers/iio/accel/fxls8962af-i2c.c
+++ b/drivers/iio/accel/fxls8962af-i2c.c
@@ -28,10 +28,10 @@ static int fxls8962af_probe(struct i2c_client *client)
 }
 
 static const struct i2c_device_id fxls8962af_id[] = {
-	{ "fxls8962af", fxls8962af },
-	{ "fxls8964af", fxls8964af },
-	{ "fxls8967af", fxls8967af },
-	{ "fxls8974cf", fxls8974cf },
+	{ .name = "fxls8962af", .driver_data = fxls8962af },
+	{ .name = "fxls8964af", .driver_data = fxls8964af },
+	{ .name = "fxls8967af", .driver_data = fxls8967af },
+	{ .name = "fxls8974cf", .driver_data = fxls8974cf },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, fxls8962af_id);
diff --git a/drivers/iio/accel/kxcjk-1013.c b/drivers/iio/accel/kxcjk-1013.c
index 2823ddde4bf2..8a082ff034dd 100644
--- a/drivers/iio/accel/kxcjk-1013.c
+++ b/drivers/iio/accel/kxcjk-1013.c
@@ -1630,11 +1630,11 @@ static const struct dev_pm_ops kxcjk1013_pm_ops = {
 };
 
 static const struct i2c_device_id kxcjk1013_id[] = {
-	{ "kxcjk1013",  (kernel_ulong_t)&kxcjk1013_info },
-	{ "kxcj91008",  (kernel_ulong_t)&kxcj91008_info },
-	{ "kxtj21009",  (kernel_ulong_t)&kxtj21009_info },
-	{ "kxtf9", (kernel_ulong_t)&kxtf9_info },
-	{ "kx023-1025", (kernel_ulong_t)&kx0231025_info },
+	{ .name = "kxcjk1013", .driver_data = (kernel_ulong_t)&kxcjk1013_info },
+	{ .name = "kxcj91008", .driver_data = (kernel_ulong_t)&kxcj91008_info },
+	{ .name = "kxtj21009", .driver_data = (kernel_ulong_t)&kxtj21009_info },
+	{ .name = "kxtf9", .driver_data = (kernel_ulong_t)&kxtf9_info },
+	{ .name = "kx023-1025", .driver_data = (kernel_ulong_t)&kx0231025_info },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, kxcjk1013_id);
diff --git a/drivers/iio/accel/mc3230.c b/drivers/iio/accel/mc3230.c
index 3e494f9ddc56..b45897210a62 100644
--- a/drivers/iio/accel/mc3230.c
+++ b/drivers/iio/accel/mc3230.c
@@ -230,8 +230,8 @@ static int mc3230_resume(struct device *dev)
 static DEFINE_SIMPLE_DEV_PM_OPS(mc3230_pm_ops, mc3230_suspend, mc3230_resume);
 
 static const struct i2c_device_id mc3230_i2c_id[] = {
-	{ "mc3230", (kernel_ulong_t)&mc3230_chip_info },
-	{ "mc3510c", (kernel_ulong_t)&mc3510c_chip_info },
+	{ .name = "mc3230", .driver_data = (kernel_ulong_t)&mc3230_chip_info },
+	{ .name = "mc3510c", .driver_data = (kernel_ulong_t)&mc3510c_chip_info },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, mc3230_i2c_id);
diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
index 15172ba2972c..57f194faf910 100644
--- a/drivers/iio/accel/mma8452.c
+++ b/drivers/iio/accel/mma8452.c
@@ -1821,12 +1821,12 @@ static const struct dev_pm_ops mma8452_pm_ops = {
 };
 
 static const struct i2c_device_id mma8452_id[] = {
-	{ "fxls8471", (kernel_ulong_t)&mma_chip_info_table[fxls8471] },
-	{ "mma8451", (kernel_ulong_t)&mma_chip_info_table[mma8451] },
-	{ "mma8452", (kernel_ulong_t)&mma_chip_info_table[mma8452] },
-	{ "mma8453", (kernel_ulong_t)&mma_chip_info_table[mma8453] },
-	{ "mma8652", (kernel_ulong_t)&mma_chip_info_table[mma8652] },
-	{ "mma8653", (kernel_ulong_t)&mma_chip_info_table[mma8653] },
+	{ .name = "fxls8471", .driver_data = (kernel_ulong_t)&mma_chip_info_table[fxls8471] },
+	{ .name = "mma8451", .driver_data = (kernel_ulong_t)&mma_chip_info_table[mma8451] },
+	{ .name = "mma8452", .driver_data = (kernel_ulong_t)&mma_chip_info_table[mma8452] },
+	{ .name = "mma8453", .driver_data = (kernel_ulong_t)&mma_chip_info_table[mma8453] },
+	{ .name = "mma8652", .driver_data = (kernel_ulong_t)&mma_chip_info_table[mma8652] },
+	{ .name = "mma8653", .driver_data = (kernel_ulong_t)&mma_chip_info_table[mma8653] },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, mma8452_id);
diff --git a/drivers/iio/adc/ad7091r5.c b/drivers/iio/adc/ad7091r5.c
index bd4877268689..d4c4b19edc61 100644
--- a/drivers/iio/adc/ad7091r5.c
+++ b/drivers/iio/adc/ad7091r5.c
@@ -117,7 +117,7 @@ static const struct of_device_id ad7091r5_dt_ids[] = {
 MODULE_DEVICE_TABLE(of, ad7091r5_dt_ids);
 
 static const struct i2c_device_id ad7091r5_i2c_ids[] = {
-	{ "ad7091r5", (kernel_ulong_t)&ad7091r5_init_info },
+	{ .name = "ad7091r5", .driver_data = (kernel_ulong_t)&ad7091r5_init_info },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, ad7091r5_i2c_ids);
diff --git a/drivers/iio/adc/ad799x.c b/drivers/iio/adc/ad799x.c
index 108bb22162ef..db6bc7dff8c2 100644
--- a/drivers/iio/adc/ad799x.c
+++ b/drivers/iio/adc/ad799x.c
@@ -946,14 +946,14 @@ static int ad799x_resume(struct device *dev)
 static DEFINE_SIMPLE_DEV_PM_OPS(ad799x_pm_ops, ad799x_suspend, ad799x_resume);
 
 static const struct i2c_device_id ad799x_id[] = {
-	{ "ad7991", ad7991 },
-	{ "ad7995", ad7995 },
-	{ "ad7999", ad7999 },
-	{ "ad7992", ad7992 },
-	{ "ad7993", ad7993 },
-	{ "ad7994", ad7994 },
-	{ "ad7997", ad7997 },
-	{ "ad7998", ad7998 },
+	{ .name = "ad7991", .driver_data = ad7991 },
+	{ .name = "ad7995", .driver_data = ad7995 },
+	{ .name = "ad7999", .driver_data = ad7999 },
+	{ .name = "ad7992", .driver_data = ad7992 },
+	{ .name = "ad7993", .driver_data = ad7993 },
+	{ .name = "ad7994", .driver_data = ad7994 },
+	{ .name = "ad7997", .driver_data = ad7997 },
+	{ .name = "ad7998", .driver_data = ad7998 },
 	{ }
 };
 
diff --git a/drivers/iio/adc/ina2xx-adc.c b/drivers/iio/adc/ina2xx-adc.c
index 7c04e3ec1cbc..c412f5ed46a1 100644
--- a/drivers/iio/adc/ina2xx-adc.c
+++ b/drivers/iio/adc/ina2xx-adc.c
@@ -1078,12 +1078,12 @@ static void ina2xx_remove(struct i2c_client *client)
 }
 
 static const struct i2c_device_id ina2xx_id[] = {
-	{ "ina219", ina219 },
-	{ "ina220", ina219 },
-	{ "ina226", ina226 },
-	{ "ina230", ina226 },
-	{ "ina231", ina226 },
-	{ "ina236", ina236 },
+	{ .name = "ina219", .driver_data = ina219 },
+	{ .name = "ina220", .driver_data = ina219 },
+	{ .name = "ina226", .driver_data = ina226 },
+	{ .name = "ina230", .driver_data = ina226 },
+	{ .name = "ina231", .driver_data = ina226 },
+	{ .name = "ina236", .driver_data = ina236 },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, ina2xx_id);
diff --git a/drivers/iio/adc/ltc2309.c b/drivers/iio/adc/ltc2309.c
index 316256edf150..7db1b09b72be 100644
--- a/drivers/iio/adc/ltc2309.c
+++ b/drivers/iio/adc/ltc2309.c
@@ -233,8 +233,8 @@ static const struct of_device_id ltc2309_of_match[] = {
 MODULE_DEVICE_TABLE(of, ltc2309_of_match);
 
 static const struct i2c_device_id ltc2309_id[] = {
-	{ "ltc2305", (kernel_ulong_t)&ltc2305_chip_info },
-	{ "ltc2309", (kernel_ulong_t)&ltc2309_chip_info },
+	{ .name = "ltc2305", .driver_data = (kernel_ulong_t)&ltc2305_chip_info },
+	{ .name = "ltc2309", .driver_data = (kernel_ulong_t)&ltc2309_chip_info },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, ltc2309_id);
diff --git a/drivers/iio/adc/ltc2471.c b/drivers/iio/adc/ltc2471.c
index a579107fd5c9..369af700969f 100644
--- a/drivers/iio/adc/ltc2471.c
+++ b/drivers/iio/adc/ltc2471.c
@@ -136,8 +136,8 @@ static int ltc2471_i2c_probe(struct i2c_client *client)
 }
 
 static const struct i2c_device_id ltc2471_i2c_id[] = {
-	{ "ltc2471", ltc2471 },
-	{ "ltc2473", ltc2473 },
+	{ .name = "ltc2471", .driver_data = ltc2471 },
+	{ .name = "ltc2473", .driver_data = ltc2473 },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, ltc2471_i2c_id);
diff --git a/drivers/iio/adc/ltc2497.c b/drivers/iio/adc/ltc2497.c
index eb9d521e86e5..8e899d6ffcfa 100644
--- a/drivers/iio/adc/ltc2497.c
+++ b/drivers/iio/adc/ltc2497.c
@@ -142,8 +142,8 @@ static const struct ltc2497_chip_info ltc2497_info[] = {
 };
 
 static const struct i2c_device_id ltc2497_id[] = {
-	{ "ltc2497", (kernel_ulong_t)&ltc2497_info[TYPE_LTC2497] },
-	{ "ltc2499", (kernel_ulong_t)&ltc2497_info[TYPE_LTC2499] },
+	{ .name = "ltc2497", .driver_data = (kernel_ulong_t)&ltc2497_info[TYPE_LTC2497] },
+	{ .name = "ltc2499", .driver_data = (kernel_ulong_t)&ltc2497_info[TYPE_LTC2499] },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, ltc2497_id);
diff --git a/drivers/iio/adc/max34408.c b/drivers/iio/adc/max34408.c
index 4f45fd22a90c..da847eaed84e 100644
--- a/drivers/iio/adc/max34408.c
+++ b/drivers/iio/adc/max34408.c
@@ -256,8 +256,8 @@ static const struct of_device_id max34408_of_match[] = {
 MODULE_DEVICE_TABLE(of, max34408_of_match);
 
 static const struct i2c_device_id max34408_id[] = {
-	{ "max34408", (kernel_ulong_t)&max34408_model_data },
-	{ "max34409", (kernel_ulong_t)&max34409_model_data },
+	{ .name = "max34408", .driver_data = (kernel_ulong_t)&max34408_model_data },
+	{ .name = "max34409", .driver_data = (kernel_ulong_t)&max34409_model_data },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, max34408_id);
diff --git a/drivers/iio/adc/mcp3422.c b/drivers/iio/adc/mcp3422.c
index 50834fdcf738..3180994ade27 100644
--- a/drivers/iio/adc/mcp3422.c
+++ b/drivers/iio/adc/mcp3422.c
@@ -394,14 +394,14 @@ static int mcp3422_probe(struct i2c_client *client)
 }
 
 static const struct i2c_device_id mcp3422_id[] = {
-	{ "mcp3421", 1 },
-	{ "mcp3422", 2 },
-	{ "mcp3423", 3 },
-	{ "mcp3424", 4 },
-	{ "mcp3425", 5 },
-	{ "mcp3426", 6 },
-	{ "mcp3427", 7 },
-	{ "mcp3428", 8 },
+	{ .name = "mcp3421", .driver_data = 1 },
+	{ .name = "mcp3422", .driver_data = 2 },
+	{ .name = "mcp3423", .driver_data = 3 },
+	{ .name = "mcp3424", .driver_data = 4 },
+	{ .name = "mcp3425", .driver_data = 5 },
+	{ .name = "mcp3426", .driver_data = 6 },
+	{ .name = "mcp3427", .driver_data = 7 },
+	{ .name = "mcp3428", .driver_data = 8 },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, mcp3422_id);
diff --git a/drivers/iio/adc/ti-adc081c.c b/drivers/iio/adc/ti-adc081c.c
index 8ef51c57912d..33f82bdfeb94 100644
--- a/drivers/iio/adc/ti-adc081c.c
+++ b/drivers/iio/adc/ti-adc081c.c
@@ -199,9 +199,9 @@ static int adc081c_probe(struct i2c_client *client)
 }
 
 static const struct i2c_device_id adc081c_id[] = {
-	{ "adc081c", (kernel_ulong_t)&adc081c_model },
-	{ "adc101c", (kernel_ulong_t)&adc101c_model },
-	{ "adc121c", (kernel_ulong_t)&adc121c_model },
+	{ .name = "adc081c", .driver_data = (kernel_ulong_t)&adc081c_model },
+	{ .name = "adc101c", .driver_data = (kernel_ulong_t)&adc101c_model },
+	{ .name = "adc121c", .driver_data = (kernel_ulong_t)&adc121c_model },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, adc081c_id);
diff --git a/drivers/iio/adc/ti-ads1015.c b/drivers/iio/adc/ti-ads1015.c
index c7ffe47449e2..8a272af69f7d 100644
--- a/drivers/iio/adc/ti-ads1015.c
+++ b/drivers/iio/adc/ti-ads1015.c
@@ -1128,9 +1128,9 @@ static const struct ads1015_chip_data tla2024_data = {
 };
 
 static const struct i2c_device_id ads1015_id[] = {
-	{ "ads1015", (kernel_ulong_t)&ads1015_data },
-	{ "ads1115", (kernel_ulong_t)&ads1115_data },
-	{ "tla2024", (kernel_ulong_t)&tla2024_data },
+	{ .name = "ads1015", .driver_data = (kernel_ulong_t)&ads1015_data },
+	{ .name = "ads1115", .driver_data = (kernel_ulong_t)&ads1115_data },
+	{ .name = "tla2024", .driver_data = (kernel_ulong_t)&tla2024_data },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, ads1015_id);
diff --git a/drivers/iio/adc/ti-ads7138.c b/drivers/iio/adc/ti-ads7138.c
index ee5c1b8e3a8e..af87f5f19a0f 100644
--- a/drivers/iio/adc/ti-ads7138.c
+++ b/drivers/iio/adc/ti-ads7138.c
@@ -727,8 +727,8 @@ static const struct of_device_id ads7138_of_match[] = {
 MODULE_DEVICE_TABLE(of, ads7138_of_match);
 
 static const struct i2c_device_id ads7138_device_ids[] = {
-	{ "ads7128", (kernel_ulong_t)&ads7128_data },
-	{ "ads7138", (kernel_ulong_t)&ads7138_data },
+	{ .name = "ads7128", .driver_data = (kernel_ulong_t)&ads7128_data },
+	{ .name = "ads7138", .driver_data = (kernel_ulong_t)&ads7138_data },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, ads7138_device_ids);
diff --git a/drivers/iio/cdc/ad7150.c b/drivers/iio/cdc/ad7150.c
index 8106a6a83561..cb9fff3bd67f 100644
--- a/drivers/iio/cdc/ad7150.c
+++ b/drivers/iio/cdc/ad7150.c
@@ -628,9 +628,9 @@ static int ad7150_probe(struct i2c_client *client)
 }
 
 static const struct i2c_device_id ad7150_id[] = {
-	{ "ad7150", AD7150 },
-	{ "ad7151", AD7151 },
-	{ "ad7156", AD7150 },
+	{ .name = "ad7150", .driver_data = AD7150 },
+	{ .name = "ad7151", .driver_data = AD7151 },
+	{ .name = "ad7156", .driver_data = AD7150 },
 	{ }
 };
 
diff --git a/drivers/iio/cdc/ad7746.c b/drivers/iio/cdc/ad7746.c
index cb97e3c978d8..cf68b882bc49 100644
--- a/drivers/iio/cdc/ad7746.c
+++ b/drivers/iio/cdc/ad7746.c
@@ -789,9 +789,9 @@ static int ad7746_probe(struct i2c_client *client)
 }
 
 static const struct i2c_device_id ad7746_id[] = {
-	{ "ad7745", 7745 },
-	{ "ad7746", 7746 },
-	{ "ad7747", 7747 },
+	{ .name = "ad7745", .driver_data = 7745 },
+	{ .name = "ad7746", .driver_data = 7746 },
+	{ .name = "ad7747", .driver_data = 7747 },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, ad7746_id);
diff --git a/drivers/iio/chemical/atlas-ezo-sensor.c b/drivers/iio/chemical/atlas-ezo-sensor.c
index 59f3a4fa9e9f..05da3b8a92ab 100644
--- a/drivers/iio/chemical/atlas-ezo-sensor.c
+++ b/drivers/iio/chemical/atlas-ezo-sensor.c
@@ -186,9 +186,9 @@ static const struct iio_info atlas_info = {
 };
 
 static const struct i2c_device_id atlas_ezo_id[] = {
-	{ "atlas-co2-ezo", (kernel_ulong_t)&atlas_ezo_devices[ATLAS_CO2_EZO] },
-	{ "atlas-o2-ezo", (kernel_ulong_t)&atlas_ezo_devices[ATLAS_O2_EZO] },
-	{ "atlas-hum-ezo", (kernel_ulong_t)&atlas_ezo_devices[ATLAS_HUM_EZO] },
+	{ .name = "atlas-co2-ezo", .driver_data = (kernel_ulong_t)&atlas_ezo_devices[ATLAS_CO2_EZO] },
+	{ .name = "atlas-o2-ezo", .driver_data = (kernel_ulong_t)&atlas_ezo_devices[ATLAS_O2_EZO] },
+	{ .name = "atlas-hum-ezo", .driver_data = (kernel_ulong_t)&atlas_ezo_devices[ATLAS_HUM_EZO] },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, atlas_ezo_id);
diff --git a/drivers/iio/chemical/atlas-sensor.c b/drivers/iio/chemical/atlas-sensor.c
index 8bbba85af699..0e2edcff63f9 100644
--- a/drivers/iio/chemical/atlas-sensor.c
+++ b/drivers/iio/chemical/atlas-sensor.c
@@ -586,11 +586,11 @@ static const struct iio_info atlas_info = {
 };
 
 static const struct i2c_device_id atlas_id[] = {
-	{ "atlas-ph-sm", (kernel_ulong_t)&atlas_devices[ATLAS_PH_SM] },
-	{ "atlas-ec-sm", (kernel_ulong_t)&atlas_devices[ATLAS_EC_SM] },
-	{ "atlas-orp-sm", (kernel_ulong_t)&atlas_devices[ATLAS_ORP_SM] },
-	{ "atlas-do-sm", (kernel_ulong_t)&atlas_devices[ATLAS_DO_SM] },
-	{ "atlas-rtd-sm", (kernel_ulong_t)&atlas_devices[ATLAS_RTD_SM] },
+	{ .name = "atlas-ph-sm", .driver_data = (kernel_ulong_t)&atlas_devices[ATLAS_PH_SM] },
+	{ .name = "atlas-ec-sm", .driver_data = (kernel_ulong_t)&atlas_devices[ATLAS_EC_SM] },
+	{ .name = "atlas-orp-sm", .driver_data = (kernel_ulong_t)&atlas_devices[ATLAS_ORP_SM] },
+	{ .name = "atlas-do-sm", .driver_data = (kernel_ulong_t)&atlas_devices[ATLAS_DO_SM] },
+	{ .name = "atlas-rtd-sm", .driver_data = (kernel_ulong_t)&atlas_devices[ATLAS_RTD_SM] },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, atlas_id);
diff --git a/drivers/iio/chemical/sgp30.c b/drivers/iio/chemical/sgp30.c
index 21730d62b5c8..d12d3fe83179 100644
--- a/drivers/iio/chemical/sgp30.c
+++ b/drivers/iio/chemical/sgp30.c
@@ -562,8 +562,8 @@ static void sgp_remove(struct i2c_client *client)
 }
 
 static const struct i2c_device_id sgp_id[] = {
-	{ "sgp30", (kernel_ulong_t)&sgp_devices[SGP30] },
-	{ "sgpc3", (kernel_ulong_t)&sgp_devices[SGPC3] },
+	{ .name = "sgp30", .driver_data = (kernel_ulong_t)&sgp_devices[SGP30] },
+	{ .name = "sgpc3", .driver_data = (kernel_ulong_t)&sgp_devices[SGPC3] },
 	{ }
 };
 
diff --git a/drivers/iio/chemical/vz89x.c b/drivers/iio/chemical/vz89x.c
index 5b358bcd311b..4deacf10b6ef 100644
--- a/drivers/iio/chemical/vz89x.c
+++ b/drivers/iio/chemical/vz89x.c
@@ -385,8 +385,8 @@ static int vz89x_probe(struct i2c_client *client)
 }
 
 static const struct i2c_device_id vz89x_id[] = {
-	{ "vz89x", (kernel_ulong_t)&vz89x_chips[VZ89X] },
-	{ "vz89te", (kernel_ulong_t)&vz89x_chips[VZ89TE] },
+	{ .name = "vz89x", .driver_data = (kernel_ulong_t)&vz89x_chips[VZ89X] },
+	{ .name = "vz89te", .driver_data = (kernel_ulong_t)&vz89x_chips[VZ89TE] },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, vz89x_id);
diff --git a/drivers/iio/dac/ad5064.c b/drivers/iio/dac/ad5064.c
index 84be5174babd..b5ec33f5c317 100644
--- a/drivers/iio/dac/ad5064.c
+++ b/drivers/iio/dac/ad5064.c
@@ -1001,53 +1001,53 @@ static int ad5064_i2c_probe(struct i2c_client *i2c)
 }
 
 static const struct i2c_device_id ad5064_i2c_ids[] = {
-	{"ad5625", ID_AD5625 },
-	{"ad5625r-1v25", ID_AD5625R_1V25 },
-	{"ad5625r-2v5", ID_AD5625R_2V5 },
-	{"ad5627", ID_AD5627 },
-	{"ad5627r-1v25", ID_AD5627R_1V25 },
-	{"ad5627r-2v5", ID_AD5627R_2V5 },
-	{"ad5629-1", ID_AD5629_1},
-	{"ad5629-2", ID_AD5629_2},
-	{"ad5629-3", ID_AD5629_2}, /* similar enough to ad5629-2 */
-	{"ad5645r-1v25", ID_AD5645R_1V25 },
-	{"ad5645r-2v5", ID_AD5645R_2V5 },
-	{"ad5665", ID_AD5665 },
-	{"ad5665r-1v25", ID_AD5665R_1V25 },
-	{"ad5665r-2v5", ID_AD5665R_2V5 },
-	{"ad5667", ID_AD5667 },
-	{"ad5667r-1v25", ID_AD5667R_1V25 },
-	{"ad5667r-2v5", ID_AD5667R_2V5 },
-	{"ad5669-1", ID_AD5669_1},
-	{"ad5669-2", ID_AD5669_2},
-	{"ad5669-3", ID_AD5669_2}, /* similar enough to ad5669-2 */
-	{"ltc2606", ID_LTC2606},
-	{"ltc2607", ID_LTC2607},
-	{"ltc2609", ID_LTC2609},
-	{"ltc2616", ID_LTC2616},
-	{"ltc2617", ID_LTC2617},
-	{"ltc2619", ID_LTC2619},
-	{"ltc2626", ID_LTC2626},
-	{"ltc2627", ID_LTC2627},
-	{"ltc2629", ID_LTC2629},
-	{"ltc2631-l12", ID_LTC2631_L12},
-	{"ltc2631-h12", ID_LTC2631_H12},
-	{"ltc2631-l10", ID_LTC2631_L10},
-	{"ltc2631-h10", ID_LTC2631_H10},
-	{"ltc2631-l8", ID_LTC2631_L8},
-	{"ltc2631-h8", ID_LTC2631_H8},
-	{"ltc2633-l12", ID_LTC2633_L12},
-	{"ltc2633-h12", ID_LTC2633_H12},
-	{"ltc2633-l10", ID_LTC2633_L10},
-	{"ltc2633-h10", ID_LTC2633_H10},
-	{"ltc2633-l8", ID_LTC2633_L8},
-	{"ltc2633-h8", ID_LTC2633_H8},
-	{"ltc2635-l12", ID_LTC2635_L12},
-	{"ltc2635-h12", ID_LTC2635_H12},
-	{"ltc2635-l10", ID_LTC2635_L10},
-	{"ltc2635-h10", ID_LTC2635_H10},
-	{"ltc2635-l8", ID_LTC2635_L8},
-	{"ltc2635-h8", ID_LTC2635_H8},
+	{ .name = "ad5625", .driver_data = ID_AD5625 },
+	{ .name = "ad5625r-1v25", .driver_data = ID_AD5625R_1V25 },
+	{ .name = "ad5625r-2v5", .driver_data = ID_AD5625R_2V5 },
+	{ .name = "ad5627", .driver_data = ID_AD5627 },
+	{ .name = "ad5627r-1v25", .driver_data = ID_AD5627R_1V25 },
+	{ .name = "ad5627r-2v5", .driver_data = ID_AD5627R_2V5 },
+	{ .name = "ad5629-1", .driver_data = ID_AD5629_1 },
+	{ .name = "ad5629-2", .driver_data = ID_AD5629_2 },
+	{ .name = "ad5629-3", .driver_data = ID_AD5629_2 }, /* similar enough to ad5629-2 */
+	{ .name = "ad5645r-1v25", .driver_data = ID_AD5645R_1V25 },
+	{ .name = "ad5645r-2v5", .driver_data = ID_AD5645R_2V5 },
+	{ .name = "ad5665", .driver_data = ID_AD5665 },
+	{ .name = "ad5665r-1v25", .driver_data = ID_AD5665R_1V25 },
+	{ .name = "ad5665r-2v5", .driver_data = ID_AD5665R_2V5 },
+	{ .name = "ad5667", .driver_data = ID_AD5667 },
+	{ .name = "ad5667r-1v25", .driver_data = ID_AD5667R_1V25 },
+	{ .name = "ad5667r-2v5", .driver_data = ID_AD5667R_2V5 },
+	{ .name = "ad5669-1", .driver_data = ID_AD5669_1 },
+	{ .name = "ad5669-2", .driver_data = ID_AD5669_2 },
+	{ .name = "ad5669-3", .driver_data = ID_AD5669_2 }, /* similar enough to ad5669-2 */
+	{ .name = "ltc2606", .driver_data = ID_LTC2606 },
+	{ .name = "ltc2607", .driver_data = ID_LTC2607 },
+	{ .name = "ltc2609", .driver_data = ID_LTC2609 },
+	{ .name = "ltc2616", .driver_data = ID_LTC2616 },
+	{ .name = "ltc2617", .driver_data = ID_LTC2617 },
+	{ .name = "ltc2619", .driver_data = ID_LTC2619 },
+	{ .name = "ltc2626", .driver_data = ID_LTC2626 },
+	{ .name = "ltc2627", .driver_data = ID_LTC2627 },
+	{ .name = "ltc2629", .driver_data = ID_LTC2629 },
+	{ .name = "ltc2631-l12", .driver_data = ID_LTC2631_L12 },
+	{ .name = "ltc2631-h12", .driver_data = ID_LTC2631_H12 },
+	{ .name = "ltc2631-l10", .driver_data = ID_LTC2631_L10 },
+	{ .name = "ltc2631-h10", .driver_data = ID_LTC2631_H10 },
+	{ .name = "ltc2631-l8", .driver_data = ID_LTC2631_L8 },
+	{ .name = "ltc2631-h8", .driver_data = ID_LTC2631_H8 },
+	{ .name = "ltc2633-l12", .driver_data = ID_LTC2633_L12 },
+	{ .name = "ltc2633-h12", .driver_data = ID_LTC2633_H12 },
+	{ .name = "ltc2633-l10", .driver_data = ID_LTC2633_L10 },
+	{ .name = "ltc2633-h10", .driver_data = ID_LTC2633_H10 },
+	{ .name = "ltc2633-l8", .driver_data = ID_LTC2633_L8 },
+	{ .name = "ltc2633-h8", .driver_data = ID_LTC2633_H8 },
+	{ .name = "ltc2635-l12", .driver_data = ID_LTC2635_L12 },
+	{ .name = "ltc2635-h12", .driver_data = ID_LTC2635_H12 },
+	{ .name = "ltc2635-l10", .driver_data = ID_LTC2635_L10 },
+	{ .name = "ltc2635-h10", .driver_data = ID_LTC2635_H10 },
+	{ .name = "ltc2635-l8", .driver_data = ID_LTC2635_L8 },
+	{ .name = "ltc2635-h8", .driver_data = ID_LTC2635_H8 },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, ad5064_i2c_ids);
diff --git a/drivers/iio/dac/ad5380.c b/drivers/iio/dac/ad5380.c
index 8b813cee7625..2e587bdd3214 100644
--- a/drivers/iio/dac/ad5380.c
+++ b/drivers/iio/dac/ad5380.c
@@ -513,22 +513,22 @@ static int ad5380_i2c_probe(struct i2c_client *i2c)
 }
 
 static const struct i2c_device_id ad5380_i2c_ids[] = {
-	{ "ad5380-3", ID_AD5380_3 },
-	{ "ad5380-5", ID_AD5380_5 },
-	{ "ad5381-3", ID_AD5381_3 },
-	{ "ad5381-5", ID_AD5381_5 },
-	{ "ad5382-3", ID_AD5382_3 },
-	{ "ad5382-5", ID_AD5382_5 },
-	{ "ad5383-3", ID_AD5383_3 },
-	{ "ad5383-5", ID_AD5383_5 },
-	{ "ad5384-3", ID_AD5380_3 },
-	{ "ad5384-5", ID_AD5380_5 },
-	{ "ad5390-3", ID_AD5390_3 },
-	{ "ad5390-5", ID_AD5390_5 },
-	{ "ad5391-3", ID_AD5391_3 },
-	{ "ad5391-5", ID_AD5391_5 },
-	{ "ad5392-3", ID_AD5392_3 },
-	{ "ad5392-5", ID_AD5392_5 },
+	{ .name = "ad5380-3", .driver_data = ID_AD5380_3 },
+	{ .name = "ad5380-5", .driver_data = ID_AD5380_5 },
+	{ .name = "ad5381-3", .driver_data = ID_AD5381_3 },
+	{ .name = "ad5381-5", .driver_data = ID_AD5381_5 },
+	{ .name = "ad5382-3", .driver_data = ID_AD5382_3 },
+	{ .name = "ad5382-5", .driver_data = ID_AD5382_5 },
+	{ .name = "ad5383-3", .driver_data = ID_AD5383_3 },
+	{ .name = "ad5383-5", .driver_data = ID_AD5383_5 },
+	{ .name = "ad5384-3", .driver_data = ID_AD5380_3 },
+	{ .name = "ad5384-5", .driver_data = ID_AD5380_5 },
+	{ .name = "ad5390-3", .driver_data = ID_AD5390_3 },
+	{ .name = "ad5390-5", .driver_data = ID_AD5390_5 },
+	{ .name = "ad5391-3", .driver_data = ID_AD5391_3 },
+	{ .name = "ad5391-5", .driver_data = ID_AD5391_5 },
+	{ .name = "ad5392-3", .driver_data = ID_AD5392_3 },
+	{ .name = "ad5392-5", .driver_data = ID_AD5392_5 },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, ad5380_i2c_ids);
diff --git a/drivers/iio/dac/ad5446-i2c.c b/drivers/iio/dac/ad5446-i2c.c
index 40fe7e17fce4..2d4c8908d91e 100644
--- a/drivers/iio/dac/ad5446-i2c.c
+++ b/drivers/iio/dac/ad5446-i2c.c
@@ -65,12 +65,12 @@ static const struct ad5446_chip_info ad5622_chip_info = {
 };
 
 static const struct i2c_device_id ad5446_i2c_ids[] = {
-	{"ad5301", (kernel_ulong_t)&ad5602_chip_info},
-	{"ad5311", (kernel_ulong_t)&ad5612_chip_info},
-	{"ad5321", (kernel_ulong_t)&ad5622_chip_info},
-	{"ad5602", (kernel_ulong_t)&ad5602_chip_info},
-	{"ad5612", (kernel_ulong_t)&ad5612_chip_info},
-	{"ad5622", (kernel_ulong_t)&ad5622_chip_info},
+	{ .name = "ad5301", .driver_data = (kernel_ulong_t)&ad5602_chip_info },
+	{ .name = "ad5311", .driver_data = (kernel_ulong_t)&ad5612_chip_info },
+	{ .name = "ad5321", .driver_data = (kernel_ulong_t)&ad5622_chip_info },
+	{ .name = "ad5602", .driver_data = (kernel_ulong_t)&ad5602_chip_info },
+	{ .name = "ad5612", .driver_data = (kernel_ulong_t)&ad5612_chip_info },
+	{ .name = "ad5622", .driver_data = (kernel_ulong_t)&ad5622_chip_info },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, ad5446_i2c_ids);
diff --git a/drivers/iio/dac/ad5696-i2c.c b/drivers/iio/dac/ad5696-i2c.c
index d3327bca0e07..56625e1da817 100644
--- a/drivers/iio/dac/ad5696-i2c.c
+++ b/drivers/iio/dac/ad5696-i2c.c
@@ -66,22 +66,22 @@ static int ad5686_i2c_probe(struct i2c_client *i2c)
 }
 
 static const struct i2c_device_id ad5686_i2c_id[] = {
-	{"ad5311r", ID_AD5311R},
-	{"ad5337r", ID_AD5337R},
-	{"ad5338r", ID_AD5338R},
-	{"ad5671r", ID_AD5671R},
-	{"ad5673r", ID_AD5673R},
-	{"ad5675r", ID_AD5675R},
-	{"ad5677r", ID_AD5677R},
-	{"ad5691r", ID_AD5691R},
-	{"ad5692r", ID_AD5692R},
-	{"ad5693", ID_AD5693},
-	{"ad5693r", ID_AD5693R},
-	{"ad5694", ID_AD5694},
-	{"ad5694r", ID_AD5694R},
-	{"ad5695r", ID_AD5695R},
-	{"ad5696", ID_AD5696},
-	{"ad5696r", ID_AD5696R},
+	{ .name = "ad5311r", .driver_data = ID_AD5311R },
+	{ .name = "ad5337r", .driver_data = ID_AD5337R },
+	{ .name = "ad5338r", .driver_data = ID_AD5338R },
+	{ .name = "ad5671r", .driver_data = ID_AD5671R },
+	{ .name = "ad5673r", .driver_data = ID_AD5673R },
+	{ .name = "ad5675r", .driver_data = ID_AD5675R },
+	{ .name = "ad5677r", .driver_data = ID_AD5677R },
+	{ .name = "ad5691r", .driver_data = ID_AD5691R },
+	{ .name = "ad5692r", .driver_data = ID_AD5692R },
+	{ .name = "ad5693", .driver_data = ID_AD5693 },
+	{ .name = "ad5693r", .driver_data = ID_AD5693R },
+	{ .name = "ad5694", .driver_data = ID_AD5694 },
+	{ .name = "ad5694r", .driver_data = ID_AD5694R },
+	{ .name = "ad5695r", .driver_data = ID_AD5695R },
+	{ .name = "ad5696", .driver_data = ID_AD5696 },
+	{ .name = "ad5696r", .driver_data = ID_AD5696R },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, ad5686_i2c_id);
diff --git a/drivers/iio/dac/ds4424.c b/drivers/iio/dac/ds4424.c
index 085f73de3f02..b6430b832cf0 100644
--- a/drivers/iio/dac/ds4424.c
+++ b/drivers/iio/dac/ds4424.c
@@ -401,10 +401,10 @@ static void ds4424_remove(struct i2c_client *client)
 }
 
 static const struct i2c_device_id ds4424_id[] = {
-	{ "ds4402", (kernel_ulong_t)&ds4402_info },
-	{ "ds4404", (kernel_ulong_t)&ds4404_info },
-	{ "ds4422", (kernel_ulong_t)&ds4422_info },
-	{ "ds4424", (kernel_ulong_t)&ds4424_info },
+	{ .name = "ds4402", .driver_data = (kernel_ulong_t)&ds4402_info },
+	{ .name = "ds4404", .driver_data = (kernel_ulong_t)&ds4404_info },
+	{ .name = "ds4422", .driver_data = (kernel_ulong_t)&ds4422_info },
+	{ .name = "ds4424", .driver_data = (kernel_ulong_t)&ds4424_info },
 	{ }
 };
 
diff --git a/drivers/iio/dac/max517.c b/drivers/iio/dac/max517.c
index d334c67821ad..d2ddc72e0e50 100644
--- a/drivers/iio/dac/max517.c
+++ b/drivers/iio/dac/max517.c
@@ -187,11 +187,11 @@ static int max517_probe(struct i2c_client *client)
 }
 
 static const struct i2c_device_id max517_id[] = {
-	{ "max517", ID_MAX517 },
-	{ "max518", ID_MAX518 },
-	{ "max519", ID_MAX519 },
-	{ "max520", ID_MAX520 },
-	{ "max521", ID_MAX521 },
+	{ .name = "max517", .driver_data = ID_MAX517 },
+	{ .name = "max518", .driver_data = ID_MAX518 },
+	{ .name = "max519", .driver_data = ID_MAX519 },
+	{ .name = "max520", .driver_data = ID_MAX520 },
+	{ .name = "max521", .driver_data = ID_MAX521 },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, max517_id);
diff --git a/drivers/iio/dac/max5821.c b/drivers/iio/dac/max5821.c
index e7e29359f8fe..b3ae00431910 100644
--- a/drivers/iio/dac/max5821.c
+++ b/drivers/iio/dac/max5821.c
@@ -332,7 +332,7 @@ static int max5821_probe(struct i2c_client *client)
 }
 
 static const struct i2c_device_id max5821_id[] = {
-	{ "max5821", ID_MAX5821 },
+	{ .name = "max5821", .driver_data = ID_MAX5821 },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, max5821_id);
diff --git a/drivers/iio/dac/mcp4725.c b/drivers/iio/dac/mcp4725.c
index 23b9e3a09ec8..2d6bcfd5deaa 100644
--- a/drivers/iio/dac/mcp4725.c
+++ b/drivers/iio/dac/mcp4725.c
@@ -523,8 +523,8 @@ static const struct mcp4725_chip_info mcp4726 = {
 };
 
 static const struct i2c_device_id mcp4725_id[] = {
-	{ "mcp4725", (kernel_ulong_t)&mcp4725 },
-	{ "mcp4726", (kernel_ulong_t)&mcp4726 },
+	{ .name = "mcp4725", .driver_data = (kernel_ulong_t)&mcp4725 },
+	{ .name = "mcp4726", .driver_data = (kernel_ulong_t)&mcp4726 },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, mcp4725_id);
diff --git a/drivers/iio/dac/mcp47feb02.c b/drivers/iio/dac/mcp47feb02.c
index faccb804a5ed..217f78e44af1 100644
--- a/drivers/iio/dac/mcp47feb02.c
+++ b/drivers/iio/dac/mcp47feb02.c
@@ -1170,30 +1170,30 @@ static int mcp47feb02_probe(struct i2c_client *client)
 }
 
 static const struct i2c_device_id mcp47feb02_id[] = {
-	{ "mcp47feb01", (kernel_ulong_t)&mcp47feb01_chip_features },
-	{ "mcp47feb02", (kernel_ulong_t)&mcp47feb02_chip_features },
-	{ "mcp47feb04", (kernel_ulong_t)&mcp47feb04_chip_features },
-	{ "mcp47feb08", (kernel_ulong_t)&mcp47feb08_chip_features },
-	{ "mcp47feb11", (kernel_ulong_t)&mcp47feb11_chip_features },
-	{ "mcp47feb12", (kernel_ulong_t)&mcp47feb12_chip_features },
-	{ "mcp47feb14", (kernel_ulong_t)&mcp47feb14_chip_features },
-	{ "mcp47feb18", (kernel_ulong_t)&mcp47feb18_chip_features },
-	{ "mcp47feb21", (kernel_ulong_t)&mcp47feb21_chip_features },
-	{ "mcp47feb22", (kernel_ulong_t)&mcp47feb22_chip_features },
-	{ "mcp47feb24", (kernel_ulong_t)&mcp47feb24_chip_features },
-	{ "mcp47feb28", (kernel_ulong_t)&mcp47feb28_chip_features },
-	{ "mcp47fvb01", (kernel_ulong_t)&mcp47fvb01_chip_features },
-	{ "mcp47fvb02", (kernel_ulong_t)&mcp47fvb02_chip_features },
-	{ "mcp47fvb04", (kernel_ulong_t)&mcp47fvb04_chip_features },
-	{ "mcp47fvb08", (kernel_ulong_t)&mcp47fvb08_chip_features },
-	{ "mcp47fvb11", (kernel_ulong_t)&mcp47fvb11_chip_features },
-	{ "mcp47fvb12", (kernel_ulong_t)&mcp47fvb12_chip_features },
-	{ "mcp47fvb14", (kernel_ulong_t)&mcp47fvb14_chip_features },
-	{ "mcp47fvb18", (kernel_ulong_t)&mcp47fvb18_chip_features },
-	{ "mcp47fvb21", (kernel_ulong_t)&mcp47fvb21_chip_features },
-	{ "mcp47fvb22", (kernel_ulong_t)&mcp47fvb22_chip_features },
-	{ "mcp47fvb24", (kernel_ulong_t)&mcp47fvb24_chip_features },
-	{ "mcp47fvb28", (kernel_ulong_t)&mcp47fvb28_chip_features },
+	{ .name = "mcp47feb01", .driver_data = (kernel_ulong_t)&mcp47feb01_chip_features },
+	{ .name = "mcp47feb02", .driver_data = (kernel_ulong_t)&mcp47feb02_chip_features },
+	{ .name = "mcp47feb04", .driver_data = (kernel_ulong_t)&mcp47feb04_chip_features },
+	{ .name = "mcp47feb08", .driver_data = (kernel_ulong_t)&mcp47feb08_chip_features },
+	{ .name = "mcp47feb11", .driver_data = (kernel_ulong_t)&mcp47feb11_chip_features },
+	{ .name = "mcp47feb12", .driver_data = (kernel_ulong_t)&mcp47feb12_chip_features },
+	{ .name = "mcp47feb14", .driver_data = (kernel_ulong_t)&mcp47feb14_chip_features },
+	{ .name = "mcp47feb18", .driver_data = (kernel_ulong_t)&mcp47feb18_chip_features },
+	{ .name = "mcp47feb21", .driver_data = (kernel_ulong_t)&mcp47feb21_chip_features },
+	{ .name = "mcp47feb22", .driver_data = (kernel_ulong_t)&mcp47feb22_chip_features },
+	{ .name = "mcp47feb24", .driver_data = (kernel_ulong_t)&mcp47feb24_chip_features },
+	{ .name = "mcp47feb28", .driver_data = (kernel_ulong_t)&mcp47feb28_chip_features },
+	{ .name = "mcp47fvb01", .driver_data = (kernel_ulong_t)&mcp47fvb01_chip_features },
+	{ .name = "mcp47fvb02", .driver_data = (kernel_ulong_t)&mcp47fvb02_chip_features },
+	{ .name = "mcp47fvb04", .driver_data = (kernel_ulong_t)&mcp47fvb04_chip_features },
+	{ .name = "mcp47fvb08", .driver_data = (kernel_ulong_t)&mcp47fvb08_chip_features },
+	{ .name = "mcp47fvb11", .driver_data = (kernel_ulong_t)&mcp47fvb11_chip_features },
+	{ .name = "mcp47fvb12", .driver_data = (kernel_ulong_t)&mcp47fvb12_chip_features },
+	{ .name = "mcp47fvb14", .driver_data = (kernel_ulong_t)&mcp47fvb14_chip_features },
+	{ .name = "mcp47fvb18", .driver_data = (kernel_ulong_t)&mcp47fvb18_chip_features },
+	{ .name = "mcp47fvb21", .driver_data = (kernel_ulong_t)&mcp47fvb21_chip_features },
+	{ .name = "mcp47fvb22", .driver_data = (kernel_ulong_t)&mcp47fvb22_chip_features },
+	{ .name = "mcp47fvb24", .driver_data = (kernel_ulong_t)&mcp47fvb24_chip_features },
+	{ .name = "mcp47fvb28", .driver_data = (kernel_ulong_t)&mcp47fvb28_chip_features },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, mcp47feb02_id);
diff --git a/drivers/iio/dac/ti-dac5571.c b/drivers/iio/dac/ti-dac5571.c
index 455d61fc3f13..b9efd704e996 100644
--- a/drivers/iio/dac/ti-dac5571.c
+++ b/drivers/iio/dac/ti-dac5571.c
@@ -402,17 +402,17 @@ static const struct of_device_id dac5571_of_id[] = {
 MODULE_DEVICE_TABLE(of, dac5571_of_id);
 
 static const struct i2c_device_id dac5571_id[] = {
-	{"dac081c081", (kernel_ulong_t)&dac5571_spec[single_8bit] },
-	{"dac121c081", (kernel_ulong_t)&dac5571_spec[single_12bit] },
-	{"dac5571", (kernel_ulong_t)&dac5571_spec[single_8bit] },
-	{"dac6571", (kernel_ulong_t)&dac5571_spec[single_10bit] },
-	{"dac7571", (kernel_ulong_t)&dac5571_spec[single_12bit] },
-	{"dac5574", (kernel_ulong_t)&dac5571_spec[quad_8bit] },
-	{"dac6574", (kernel_ulong_t)&dac5571_spec[quad_10bit] },
-	{"dac7574", (kernel_ulong_t)&dac5571_spec[quad_12bit] },
-	{"dac5573", (kernel_ulong_t)&dac5571_spec[quad_8bit] },
-	{"dac6573", (kernel_ulong_t)&dac5571_spec[quad_10bit] },
-	{"dac7573", (kernel_ulong_t)&dac5571_spec[quad_12bit] },
+	{ .name = "dac081c081", .driver_data = (kernel_ulong_t)&dac5571_spec[single_8bit] },
+	{ .name = "dac121c081", .driver_data = (kernel_ulong_t)&dac5571_spec[single_12bit] },
+	{ .name = "dac5571", .driver_data = (kernel_ulong_t)&dac5571_spec[single_8bit] },
+	{ .name = "dac6571", .driver_data = (kernel_ulong_t)&dac5571_spec[single_10bit] },
+	{ .name = "dac7571", .driver_data = (kernel_ulong_t)&dac5571_spec[single_12bit] },
+	{ .name = "dac5574", .driver_data = (kernel_ulong_t)&dac5571_spec[quad_8bit] },
+	{ .name = "dac6574", .driver_data = (kernel_ulong_t)&dac5571_spec[quad_10bit] },
+	{ .name = "dac7574", .driver_data = (kernel_ulong_t)&dac5571_spec[quad_12bit] },
+	{ .name = "dac5573", .driver_data = (kernel_ulong_t)&dac5571_spec[quad_8bit] },
+	{ .name = "dac6573", .driver_data = (kernel_ulong_t)&dac5571_spec[quad_10bit] },
+	{ .name = "dac7573", .driver_data = (kernel_ulong_t)&dac5571_spec[quad_12bit] },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, dac5571_id);
diff --git a/drivers/iio/health/max30102.c b/drivers/iio/health/max30102.c
index 47da44efd68b..c830eaf286f7 100644
--- a/drivers/iio/health/max30102.c
+++ b/drivers/iio/health/max30102.c
@@ -596,9 +596,9 @@ static void max30102_remove(struct i2c_client *client)
 }
 
 static const struct i2c_device_id max30102_id[] = {
-	{ "max30101", max30105 },
-	{ "max30102", max30102 },
-	{ "max30105", max30105 },
+	{ .name = "max30101", .driver_data = max30105 },
+	{ .name = "max30102", .driver_data = max30102 },
+	{ .name = "max30105", .driver_data = max30105 },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, max30102_id);
diff --git a/drivers/iio/humidity/ens210.c b/drivers/iio/humidity/ens210.c
index 77418d97f30d..22ad208e6aa6 100644
--- a/drivers/iio/humidity/ens210.c
+++ b/drivers/iio/humidity/ens210.c
@@ -314,12 +314,12 @@ static const struct of_device_id ens210_of_match[] = {
 MODULE_DEVICE_TABLE(of, ens210_of_match);
 
 static const struct i2c_device_id ens210_id_table[] = {
-	{ "ens210", (kernel_ulong_t)&ens210_chip_info_data },
-	{ "ens210a", (kernel_ulong_t)&ens210a_chip_info_data },
-	{ "ens211", (kernel_ulong_t)&ens211_chip_info_data },
-	{ "ens212", (kernel_ulong_t)&ens212_chip_info_data },
-	{ "ens213a", (kernel_ulong_t)&ens213a_chip_info_data },
-	{ "ens215", (kernel_ulong_t)&ens215_chip_info_data },
+	{ .name = "ens210", .driver_data = (kernel_ulong_t)&ens210_chip_info_data },
+	{ .name = "ens210a", .driver_data = (kernel_ulong_t)&ens210a_chip_info_data },
+	{ .name = "ens211", .driver_data = (kernel_ulong_t)&ens211_chip_info_data },
+	{ .name = "ens212", .driver_data = (kernel_ulong_t)&ens212_chip_info_data },
+	{ .name = "ens213a", .driver_data = (kernel_ulong_t)&ens213a_chip_info_data },
+	{ .name = "ens215", .driver_data = (kernel_ulong_t)&ens215_chip_info_data },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, ens210_id_table);
diff --git a/drivers/iio/humidity/htu21.c b/drivers/iio/humidity/htu21.c
index 7f1775bd26fd..9ba7507f105e 100644
--- a/drivers/iio/humidity/htu21.c
+++ b/drivers/iio/humidity/htu21.c
@@ -230,8 +230,8 @@ static int htu21_probe(struct i2c_client *client)
 }
 
 static const struct i2c_device_id htu21_id[] = {
-	{"htu21", HTU21},
-	{"ms8607-humidity", MS8607},
+	{ .name = "htu21", .driver_data = HTU21 },
+	{ .name = "ms8607-humidity", .driver_data = MS8607 },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, htu21_id);
diff --git a/drivers/iio/imu/bmi270/bmi270_i2c.c b/drivers/iio/imu/bmi270/bmi270_i2c.c
index b92da4e0776f..1e6839f9669e 100644
--- a/drivers/iio/imu/bmi270/bmi270_i2c.c
+++ b/drivers/iio/imu/bmi270/bmi270_i2c.c
@@ -33,8 +33,8 @@ static int bmi270_i2c_probe(struct i2c_client *client)
 }
 
 static const struct i2c_device_id bmi270_i2c_id[] = {
-	{ "bmi260", (kernel_ulong_t)&bmi260_chip_info },
-	{ "bmi270", (kernel_ulong_t)&bmi270_chip_info },
+	{ .name = "bmi260", .driver_data = (kernel_ulong_t)&bmi260_chip_info },
+	{ .name = "bmi270", .driver_data = (kernel_ulong_t)&bmi270_chip_info },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, bmi270_i2c_id);
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c
index 7e4d3ea68721..99d37ac53bbe 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c
@@ -75,13 +75,13 @@ static int inv_icm42600_probe(struct i2c_client *client)
  * supported by this driver
  */
 static const struct i2c_device_id inv_icm42600_id[] = {
-	{ "icm42600", INV_CHIP_ICM42600 },
-	{ "icm42602", INV_CHIP_ICM42602 },
-	{ "icm42605", INV_CHIP_ICM42605 },
-	{ "icm42686", INV_CHIP_ICM42686 },
-	{ "icm42622", INV_CHIP_ICM42622 },
-	{ "icm42688", INV_CHIP_ICM42688 },
-	{ "icm42631", INV_CHIP_ICM42631 },
+	{ .name = "icm42600", .driver_data = INV_CHIP_ICM42600 },
+	{ .name = "icm42602", .driver_data = INV_CHIP_ICM42602 },
+	{ .name = "icm42605", .driver_data = INV_CHIP_ICM42605 },
+	{ .name = "icm42686", .driver_data = INV_CHIP_ICM42686 },
+	{ .name = "icm42622", .driver_data = INV_CHIP_ICM42622 },
+	{ .name = "icm42688", .driver_data = INV_CHIP_ICM42688 },
+	{ .name = "icm42631", .driver_data = INV_CHIP_ICM42631 },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, inv_icm42600_id);
diff --git a/drivers/iio/imu/inv_icm45600/inv_icm45600_i2c.c b/drivers/iio/imu/inv_icm45600/inv_icm45600_i2c.c
index 5ebc18121a11..26fba538a3cf 100644
--- a/drivers/iio/imu/inv_icm45600/inv_icm45600_i2c.c
+++ b/drivers/iio/imu/inv_icm45600/inv_icm45600_i2c.c
@@ -39,14 +39,14 @@ static int inv_icm45600_probe(struct i2c_client *client)
  * supported by this driver.
  */
 static const struct i2c_device_id inv_icm45600_id[] = {
-	{ "icm45605", (kernel_ulong_t)&inv_icm45605_chip_info },
-	{ "icm45606", (kernel_ulong_t)&inv_icm45606_chip_info },
-	{ "icm45608", (kernel_ulong_t)&inv_icm45608_chip_info },
-	{ "icm45634", (kernel_ulong_t)&inv_icm45634_chip_info },
-	{ "icm45686", (kernel_ulong_t)&inv_icm45686_chip_info },
-	{ "icm45687", (kernel_ulong_t)&inv_icm45687_chip_info },
-	{ "icm45688p", (kernel_ulong_t)&inv_icm45688p_chip_info },
-	{ "icm45689", (kernel_ulong_t)&inv_icm45689_chip_info },
+	{ .name = "icm45605", .driver_data = (kernel_ulong_t)&inv_icm45605_chip_info },
+	{ .name = "icm45606", .driver_data = (kernel_ulong_t)&inv_icm45606_chip_info },
+	{ .name = "icm45608", .driver_data = (kernel_ulong_t)&inv_icm45608_chip_info },
+	{ .name = "icm45634", .driver_data = (kernel_ulong_t)&inv_icm45634_chip_info },
+	{ .name = "icm45686", .driver_data = (kernel_ulong_t)&inv_icm45686_chip_info },
+	{ .name = "icm45687", .driver_data = (kernel_ulong_t)&inv_icm45687_chip_info },
+	{ .name = "icm45688p", .driver_data = (kernel_ulong_t)&inv_icm45688p_chip_info },
+	{ .name = "icm45689", .driver_data = (kernel_ulong_t)&inv_icm45689_chip_info },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, inv_icm45600_id);
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
index 8dc61812a8fc..4868e1576cee 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
@@ -174,24 +174,24 @@ static void inv_mpu_remove(struct i2c_client *client)
  * supported by this driver
  */
 static const struct i2c_device_id inv_mpu_id[] = {
-	{"mpu6050", INV_MPU6050},
-	{"mpu6500", INV_MPU6500},
-	{"mpu6515", INV_MPU6515},
-	{"mpu6880", INV_MPU6880},
-	{"mpu9150", INV_MPU9150},
-	{"mpu9250", INV_MPU9250},
-	{"mpu9255", INV_MPU9255},
-	{"icm20608", INV_ICM20608},
-	{"icm20608d", INV_ICM20608D},
-	{"icm20609", INV_ICM20609},
-	{"icm20689", INV_ICM20689},
-	{"icm20600", INV_ICM20600},
-	{"icm20602", INV_ICM20602},
-	{"icm20690", INV_ICM20690},
-	{"iam20380", INV_IAM20380},
-	{"iam20680", INV_IAM20680},
-	{"iam20680hp", INV_IAM20680HP},
-	{"iam20680ht", INV_IAM20680HT},
+	{ .name = "mpu6050", .driver_data = INV_MPU6050 },
+	{ .name = "mpu6500", .driver_data = INV_MPU6500 },
+	{ .name = "mpu6515", .driver_data = INV_MPU6515 },
+	{ .name = "mpu6880", .driver_data = INV_MPU6880 },
+	{ .name = "mpu9150", .driver_data = INV_MPU9150 },
+	{ .name = "mpu9250", .driver_data = INV_MPU9250 },
+	{ .name = "mpu9255", .driver_data = INV_MPU9255 },
+	{ .name = "icm20608", .driver_data = INV_ICM20608 },
+	{ .name = "icm20608d", .driver_data = INV_ICM20608D },
+	{ .name = "icm20609", .driver_data = INV_ICM20609 },
+	{ .name = "icm20689", .driver_data = INV_ICM20689 },
+	{ .name = "icm20600", .driver_data = INV_ICM20600 },
+	{ .name = "icm20602", .driver_data = INV_ICM20602 },
+	{ .name = "icm20690", .driver_data = INV_ICM20690 },
+	{ .name = "iam20380", .driver_data = INV_IAM20380 },
+	{ .name = "iam20680", .driver_data = INV_IAM20680 },
+	{ .name = "iam20680hp", .driver_data = INV_IAM20680HP },
+	{ .name = "iam20680ht", .driver_data = INV_IAM20680HT },
 	{ }
 };
 
diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c
index b2a7c2eaf50d..edec898cb11f 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c
@@ -150,30 +150,30 @@ static const struct acpi_device_id st_lsm6dsx_i2c_acpi_match[] = {
 MODULE_DEVICE_TABLE(acpi, st_lsm6dsx_i2c_acpi_match);
 
 static const struct i2c_device_id st_lsm6dsx_i2c_id_table[] = {
-	{ ST_LSM6DS3_DEV_NAME, ST_LSM6DS3_ID },
-	{ ST_LSM6DS3H_DEV_NAME, ST_LSM6DS3H_ID },
-	{ ST_LSM6DSL_DEV_NAME, ST_LSM6DSL_ID },
-	{ ST_LSM6DSM_DEV_NAME, ST_LSM6DSM_ID },
-	{ ST_ISM330DLC_DEV_NAME, ST_ISM330DLC_ID },
-	{ ST_LSM6DSO_DEV_NAME, ST_LSM6DSO_ID },
-	{ ST_ASM330LHH_DEV_NAME, ST_ASM330LHH_ID },
-	{ ST_LSM6DSOX_DEV_NAME, ST_LSM6DSOX_ID },
-	{ ST_LSM6DSR_DEV_NAME, ST_LSM6DSR_ID },
-	{ ST_LSM6DS3TRC_DEV_NAME, ST_LSM6DS3TRC_ID },
-	{ ST_ISM330DHCX_DEV_NAME, ST_ISM330DHCX_ID },
-	{ ST_LSM9DS1_DEV_NAME, ST_LSM9DS1_ID },
-	{ ST_LSM6DS0_DEV_NAME, ST_LSM6DS0_ID },
-	{ ST_LSM6DSRX_DEV_NAME, ST_LSM6DSRX_ID },
-	{ ST_LSM6DST_DEV_NAME, ST_LSM6DST_ID },
-	{ ST_LSM6DSOP_DEV_NAME, ST_LSM6DSOP_ID },
-	{ ST_ASM330LHHX_DEV_NAME, ST_ASM330LHHX_ID },
-	{ ST_LSM6DSTX_DEV_NAME, ST_LSM6DSTX_ID },
-	{ ST_LSM6DSV_DEV_NAME, ST_LSM6DSV_ID },
-	{ ST_LSM6DSV16X_DEV_NAME, ST_LSM6DSV16X_ID },
-	{ ST_LSM6DSO16IS_DEV_NAME, ST_LSM6DSO16IS_ID },
-	{ ST_ISM330IS_DEV_NAME, ST_ISM330IS_ID },
-	{ ST_ASM330LHB_DEV_NAME, ST_ASM330LHB_ID },
-	{ ST_ASM330LHHXG1_DEV_NAME, ST_ASM330LHHXG1_ID },
+	{ .name = ST_LSM6DS3_DEV_NAME, .driver_data = ST_LSM6DS3_ID },
+	{ .name = ST_LSM6DS3H_DEV_NAME, .driver_data = ST_LSM6DS3H_ID },
+	{ .name = ST_LSM6DSL_DEV_NAME, .driver_data = ST_LSM6DSL_ID },
+	{ .name = ST_LSM6DSM_DEV_NAME, .driver_data = ST_LSM6DSM_ID },
+	{ .name = ST_ISM330DLC_DEV_NAME, .driver_data = ST_ISM330DLC_ID },
+	{ .name = ST_LSM6DSO_DEV_NAME, .driver_data = ST_LSM6DSO_ID },
+	{ .name = ST_ASM330LHH_DEV_NAME, .driver_data = ST_ASM330LHH_ID },
+	{ .name = ST_LSM6DSOX_DEV_NAME, .driver_data = ST_LSM6DSOX_ID },
+	{ .name = ST_LSM6DSR_DEV_NAME, .driver_data = ST_LSM6DSR_ID },
+	{ .name = ST_LSM6DS3TRC_DEV_NAME, .driver_data = ST_LSM6DS3TRC_ID },
+	{ .name = ST_ISM330DHCX_DEV_NAME, .driver_data = ST_ISM330DHCX_ID },
+	{ .name = ST_LSM9DS1_DEV_NAME, .driver_data = ST_LSM9DS1_ID },
+	{ .name = ST_LSM6DS0_DEV_NAME, .driver_data = ST_LSM6DS0_ID },
+	{ .name = ST_LSM6DSRX_DEV_NAME, .driver_data = ST_LSM6DSRX_ID },
+	{ .name = ST_LSM6DST_DEV_NAME, .driver_data = ST_LSM6DST_ID },
+	{ .name = ST_LSM6DSOP_DEV_NAME, .driver_data = ST_LSM6DSOP_ID },
+	{ .name = ST_ASM330LHHX_DEV_NAME, .driver_data = ST_ASM330LHHX_ID },
+	{ .name = ST_LSM6DSTX_DEV_NAME, .driver_data = ST_LSM6DSTX_ID },
+	{ .name = ST_LSM6DSV_DEV_NAME, .driver_data = ST_LSM6DSV_ID },
+	{ .name = ST_LSM6DSV16X_DEV_NAME, .driver_data = ST_LSM6DSV16X_ID },
+	{ .name = ST_LSM6DSO16IS_DEV_NAME, .driver_data = ST_LSM6DSO16IS_ID },
+	{ .name = ST_ISM330IS_DEV_NAME, .driver_data = ST_ISM330IS_ID },
+	{ .name = ST_ASM330LHB_DEV_NAME, .driver_data = ST_ASM330LHB_ID },
+	{ .name = ST_ASM330LHHXG1_DEV_NAME, .driver_data = ST_ASM330LHHXG1_ID },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, st_lsm6dsx_i2c_id_table);
diff --git a/drivers/iio/light/as73211.c b/drivers/iio/light/as73211.c
index 9fe830dac679..67f33bbe1c13 100644
--- a/drivers/iio/light/as73211.c
+++ b/drivers/iio/light/as73211.c
@@ -875,8 +875,8 @@ static const struct of_device_id as73211_of_match[] = {
 MODULE_DEVICE_TABLE(of, as73211_of_match);
 
 static const struct i2c_device_id as73211_id[] = {
-	{ "as73211", (kernel_ulong_t)&as73211_spec },
-	{ "as7331", (kernel_ulong_t)&as7331_spec },
+	{ .name = "as73211", .driver_data = (kernel_ulong_t)&as73211_spec },
+	{ .name = "as7331", .driver_data = (kernel_ulong_t)&as7331_spec },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, as73211_id);
diff --git a/drivers/iio/light/bh1750.c b/drivers/iio/light/bh1750.c
index 764f88826fcb..a51ac98c83c8 100644
--- a/drivers/iio/light/bh1750.c
+++ b/drivers/iio/light/bh1750.c
@@ -319,11 +319,11 @@ static int bh1750_suspend(struct device *dev)
 static DEFINE_SIMPLE_DEV_PM_OPS(bh1750_pm_ops, bh1750_suspend, NULL);
 
 static const struct i2c_device_id bh1750_id[] = {
-	{ "bh1710", BH1710 },
-	{ "bh1715", BH1750 },
-	{ "bh1721", BH1721 },
-	{ "bh1750", BH1750 },
-	{ "bh1751", BH1750 },
+	{ .name = "bh1710", .driver_data = BH1710 },
+	{ .name = "bh1715", .driver_data = BH1750 },
+	{ .name = "bh1721", .driver_data = BH1721 },
+	{ .name = "bh1750", .driver_data = BH1750 },
+	{ .name = "bh1751", .driver_data = BH1750 },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, bh1750_id);
diff --git a/drivers/iio/light/isl29018.c b/drivers/iio/light/isl29018.c
index b6ab726d1dae..8a39afaa2a37 100644
--- a/drivers/iio/light/isl29018.c
+++ b/drivers/iio/light/isl29018.c
@@ -829,9 +829,9 @@ static const struct acpi_device_id isl29018_acpi_match[] = {
 MODULE_DEVICE_TABLE(acpi, isl29018_acpi_match);
 
 static const struct i2c_device_id isl29018_id[] = {
-	{"isl29018", isl29018},
-	{"isl29023", isl29023},
-	{"isl29035", isl29035},
+	{ .name = "isl29018", .driver_data = isl29018 },
+	{ .name = "isl29023", .driver_data = isl29023 },
+	{ .name = "isl29035", .driver_data = isl29035 },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, isl29018_id);
diff --git a/drivers/iio/light/ltr501.c b/drivers/iio/light/ltr501.c
index 4d99ae336f61..15dd82ecf745 100644
--- a/drivers/iio/light/ltr501.c
+++ b/drivers/iio/light/ltr501.c
@@ -1601,10 +1601,10 @@ static const struct acpi_device_id ltr_acpi_match[] = {
 MODULE_DEVICE_TABLE(acpi, ltr_acpi_match);
 
 static const struct i2c_device_id ltr501_id[] = {
-	{ "ltr501", ltr501 },
-	{ "ltr559", ltr559 },
-	{ "ltr301", ltr301 },
-	{ "ltr303", ltr303 },
+	{ .name = "ltr501", .driver_data = ltr501 },
+	{ .name = "ltr559", .driver_data = ltr559 },
+	{ .name = "ltr301", .driver_data = ltr301 },
+	{ .name = "ltr303", .driver_data = ltr303 },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, ltr501_id);
diff --git a/drivers/iio/light/opt3001.c b/drivers/iio/light/opt3001.c
index 53bc455b7bad..9f380073c3c9 100644
--- a/drivers/iio/light/opt3001.c
+++ b/drivers/iio/light/opt3001.c
@@ -948,8 +948,8 @@ static const struct opt3001_chip_info opt3002_chip_information = {
 };
 
 static const struct i2c_device_id opt3001_id[] = {
-	{ "opt3001", (kernel_ulong_t)&opt3001_chip_information },
-	{ "opt3002", (kernel_ulong_t)&opt3002_chip_information },
+	{ .name = "opt3001", .driver_data = (kernel_ulong_t)&opt3001_chip_information },
+	{ .name = "opt3002", .driver_data = (kernel_ulong_t)&opt3002_chip_information },
 	{ } /* Terminating Entry */
 };
 MODULE_DEVICE_TABLE(i2c, opt3001_id);
diff --git a/drivers/iio/light/opt4001.c b/drivers/iio/light/opt4001.c
index 95167273bb90..dd152d921b48 100644
--- a/drivers/iio/light/opt4001.c
+++ b/drivers/iio/light/opt4001.c
@@ -438,8 +438,8 @@ static int opt4001_probe(struct i2c_client *client)
  * opt4001 packaging
  */
 static const struct i2c_device_id opt4001_id[] = {
-	{ "opt4001-sot-5x3", (kernel_ulong_t)&opt4001_sot_5x3_info },
-	{ "opt4001-picostar", (kernel_ulong_t)&opt4001_picostar_info },
+	{ .name = "opt4001-sot-5x3", .driver_data = (kernel_ulong_t)&opt4001_sot_5x3_info },
+	{ .name = "opt4001-picostar", .driver_data = (kernel_ulong_t)&opt4001_picostar_info },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, opt4001_id);
diff --git a/drivers/iio/light/si1145.c b/drivers/iio/light/si1145.c
index ef0abc4499b7..4601ae5d2009 100644
--- a/drivers/iio/light/si1145.c
+++ b/drivers/iio/light/si1145.c
@@ -1334,13 +1334,13 @@ static int si1145_probe(struct i2c_client *client)
 }
 
 static const struct i2c_device_id si1145_ids[] = {
-	{ "si1132", SI1132 },
-	{ "si1141", SI1141 },
-	{ "si1142", SI1142 },
-	{ "si1143", SI1143 },
-	{ "si1145", SI1145 },
-	{ "si1146", SI1146 },
-	{ "si1147", SI1147 },
+	{ .name = "si1132", .driver_data = SI1132 },
+	{ .name = "si1141", .driver_data = SI1141 },
+	{ .name = "si1142", .driver_data = SI1142 },
+	{ .name = "si1143", .driver_data = SI1143 },
+	{ .name = "si1145", .driver_data = SI1145 },
+	{ .name = "si1146", .driver_data = SI1146 },
+	{ .name = "si1147", .driver_data = SI1147 },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, si1145_ids);
diff --git a/drivers/iio/light/tsl2772.c b/drivers/iio/light/tsl2772.c
index c8f15ba95267..1b1c704f1d6c 100644
--- a/drivers/iio/light/tsl2772.c
+++ b/drivers/iio/light/tsl2772.c
@@ -1888,17 +1888,17 @@ static int tsl2772_resume(struct device *dev)
 }
 
 static const struct i2c_device_id tsl2772_idtable[] = {
-	{ "tsl2571", tsl2571 },
-	{ "tsl2671", tsl2671 },
-	{ "tmd2671", tmd2671 },
-	{ "tsl2771", tsl2771 },
-	{ "tmd2771", tmd2771 },
-	{ "tsl2572", tsl2572 },
-	{ "tsl2672", tsl2672 },
-	{ "tmd2672", tmd2672 },
-	{ "tsl2772", tsl2772 },
-	{ "tmd2772", tmd2772 },
-	{ "apds9930", apds9930 },
+	{ .name = "tsl2571", .driver_data = tsl2571 },
+	{ .name = "tsl2671", .driver_data = tsl2671 },
+	{ .name = "tmd2671", .driver_data = tmd2671 },
+	{ .name = "tsl2771", .driver_data = tsl2771 },
+	{ .name = "tmd2771", .driver_data = tmd2771 },
+	{ .name = "tsl2572", .driver_data = tsl2572 },
+	{ .name = "tsl2672", .driver_data = tsl2672 },
+	{ .name = "tmd2672", .driver_data = tmd2672 },
+	{ .name = "tsl2772", .driver_data = tsl2772 },
+	{ .name = "tmd2772", .driver_data = tmd2772 },
+	{ .name = "apds9930", .driver_data = apds9930 },
 	{ }
 };
 
diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
index 9650dbc41f2b..fc2161d5f3c7 100644
--- a/drivers/iio/light/vcnl4000.c
+++ b/drivers/iio/light/vcnl4000.c
@@ -237,13 +237,13 @@ struct vcnl4000_chip_spec {
 };
 
 static const struct i2c_device_id vcnl4000_id[] = {
-	{ "cm36672p", CM36672P },
-	{ "cm36686", VCNL4040 },
-	{ "vcnl4000", VCNL4000 },
-	{ "vcnl4010", VCNL4010 },
-	{ "vcnl4020", VCNL4010 },
-	{ "vcnl4040", VCNL4040 },
-	{ "vcnl4200", VCNL4200 },
+	{ .name = "cm36672p", .driver_data = CM36672P },
+	{ .name = "cm36686", .driver_data = VCNL4040 },
+	{ .name = "vcnl4000", .driver_data = VCNL4000 },
+	{ .name = "vcnl4010", .driver_data = VCNL4010 },
+	{ .name = "vcnl4020", .driver_data = VCNL4010 },
+	{ .name = "vcnl4040", .driver_data = VCNL4040 },
+	{ .name = "vcnl4200", .driver_data = VCNL4200 },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, vcnl4000_id);
diff --git a/drivers/iio/light/veml6030.c b/drivers/iio/light/veml6030.c
index 6bcacae3863c..1aca4b80972e 100644
--- a/drivers/iio/light/veml6030.c
+++ b/drivers/iio/light/veml6030.c
@@ -1218,9 +1218,9 @@ static const struct of_device_id veml6030_of_match[] = {
 MODULE_DEVICE_TABLE(of, veml6030_of_match);
 
 static const struct i2c_device_id veml6030_id[] = {
-	{ "veml6030", (kernel_ulong_t)&veml6030_chip},
-	{ "veml6035", (kernel_ulong_t)&veml6035_chip},
-	{ "veml7700", (kernel_ulong_t)&veml7700_chip},
+	{ .name = "veml6030", .driver_data = (kernel_ulong_t)&veml6030_chip },
+	{ .name = "veml6035", .driver_data = (kernel_ulong_t)&veml6035_chip },
+	{ .name = "veml7700", .driver_data = (kernel_ulong_t)&veml7700_chip },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, veml6030_id);
diff --git a/drivers/iio/magnetometer/ak8975.c b/drivers/iio/magnetometer/ak8975.c
index b648b0afa573..07fe622dc6af 100644
--- a/drivers/iio/magnetometer/ak8975.c
+++ b/drivers/iio/magnetometer/ak8975.c
@@ -1099,13 +1099,13 @@ static const struct acpi_device_id ak_acpi_match[] = {
 MODULE_DEVICE_TABLE(acpi, ak_acpi_match);
 
 static const struct i2c_device_id ak8975_id[] = {
-	{"AK8963", (kernel_ulong_t)&ak_def_array[AK8963] },
-	{"ak8963", (kernel_ulong_t)&ak_def_array[AK8963] },
-	{"ak8975", (kernel_ulong_t)&ak_def_array[AK8975] },
-	{"ak09911", (kernel_ulong_t)&ak_def_array[AK09911] },
-	{"ak09912", (kernel_ulong_t)&ak_def_array[AK09912] },
-	{"ak09916", (kernel_ulong_t)&ak_def_array[AK09916] },
-	{"ak09918", (kernel_ulong_t)&ak_def_array[AK09918] },
+	{ .name = "AK8963", .driver_data = (kernel_ulong_t)&ak_def_array[AK8963] },
+	{ .name = "ak8963", .driver_data = (kernel_ulong_t)&ak_def_array[AK8963] },
+	{ .name = "ak8975", .driver_data = (kernel_ulong_t)&ak_def_array[AK8975] },
+	{ .name = "ak09911", .driver_data = (kernel_ulong_t)&ak_def_array[AK09911] },
+	{ .name = "ak09912", .driver_data = (kernel_ulong_t)&ak_def_array[AK09912] },
+	{ .name = "ak09916", .driver_data = (kernel_ulong_t)&ak_def_array[AK09916] },
+	{ .name = "ak09918", .driver_data = (kernel_ulong_t)&ak_def_array[AK09918] },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, ak8975_id);
diff --git a/drivers/iio/magnetometer/hmc5843_i2c.c b/drivers/iio/magnetometer/hmc5843_i2c.c
index b41709959e2b..4c454b0057b1 100644
--- a/drivers/iio/magnetometer/hmc5843_i2c.c
+++ b/drivers/iio/magnetometer/hmc5843_i2c.c
@@ -71,10 +71,10 @@ static void hmc5843_i2c_remove(struct i2c_client *client)
 }
 
 static const struct i2c_device_id hmc5843_id[] = {
-	{ "hmc5843", HMC5843_ID },
-	{ "hmc5883", HMC5883_ID },
-	{ "hmc5883l", HMC5883L_ID },
-	{ "hmc5983", HMC5983_ID },
+	{ .name = "hmc5843", .driver_data = HMC5843_ID },
+	{ .name = "hmc5883", .driver_data = HMC5883_ID },
+	{ .name = "hmc5883l", .driver_data = HMC5883L_ID },
+	{ .name = "hmc5983", .driver_data = HMC5983_ID },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, hmc5843_id);
diff --git a/drivers/iio/magnetometer/yamaha-yas530.c b/drivers/iio/magnetometer/yamaha-yas530.c
index 140c422773f6..f0b2a2709172 100644
--- a/drivers/iio/magnetometer/yamaha-yas530.c
+++ b/drivers/iio/magnetometer/yamaha-yas530.c
@@ -1579,10 +1579,10 @@ static DEFINE_RUNTIME_DEV_PM_OPS(yas5xx_dev_pm_ops, yas5xx_runtime_suspend,
 				 yas5xx_runtime_resume, NULL);
 
 static const struct i2c_device_id yas5xx_id[] = {
-	{"yas530", (kernel_ulong_t)&yas5xx_chip_info_tbl[yas530] },
-	{"yas532", (kernel_ulong_t)&yas5xx_chip_info_tbl[yas532] },
-	{"yas533", (kernel_ulong_t)&yas5xx_chip_info_tbl[yas533] },
-	{"yas537", (kernel_ulong_t)&yas5xx_chip_info_tbl[yas537] },
+	{ .name = "yas530", .driver_data = (kernel_ulong_t)&yas5xx_chip_info_tbl[yas530] },
+	{ .name = "yas532", .driver_data = (kernel_ulong_t)&yas5xx_chip_info_tbl[yas532] },
+	{ .name = "yas533", .driver_data = (kernel_ulong_t)&yas5xx_chip_info_tbl[yas533] },
+	{ .name = "yas537", .driver_data = (kernel_ulong_t)&yas5xx_chip_info_tbl[yas537] },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, yas5xx_id);
diff --git a/drivers/iio/potentiometer/ad5272.c b/drivers/iio/potentiometer/ad5272.c
index 672b1ca3a920..ac342127d59e 100644
--- a/drivers/iio/potentiometer/ad5272.c
+++ b/drivers/iio/potentiometer/ad5272.c
@@ -204,11 +204,11 @@ static const struct of_device_id ad5272_dt_ids[] = {
 MODULE_DEVICE_TABLE(of, ad5272_dt_ids);
 
 static const struct i2c_device_id ad5272_id[] = {
-	{ "ad5272-020", AD5272_020 },
-	{ "ad5272-050", AD5272_050 },
-	{ "ad5272-100", AD5272_100 },
-	{ "ad5274-020", AD5274_020 },
-	{ "ad5274-100", AD5274_100 },
+	{ .name = "ad5272-020", .driver_data = AD5272_020 },
+	{ .name = "ad5272-050", .driver_data = AD5272_050 },
+	{ .name = "ad5272-100", .driver_data = AD5272_100 },
+	{ .name = "ad5274-020", .driver_data = AD5274_020 },
+	{ .name = "ad5274-100", .driver_data = AD5274_100 },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, ad5272_id);
diff --git a/drivers/iio/potentiometer/ds1803.c b/drivers/iio/potentiometer/ds1803.c
index 8a64d93f7e7b..42394343b5a9 100644
--- a/drivers/iio/potentiometer/ds1803.c
+++ b/drivers/iio/potentiometer/ds1803.c
@@ -235,10 +235,10 @@ static const struct of_device_id ds1803_dt_ids[] = {
 MODULE_DEVICE_TABLE(of, ds1803_dt_ids);
 
 static const struct i2c_device_id ds1803_id[] = {
-	{ "ds1803-010", (kernel_ulong_t)&ds1803_cfg[DS1803_010] },
-	{ "ds1803-050", (kernel_ulong_t)&ds1803_cfg[DS1803_050] },
-	{ "ds1803-100", (kernel_ulong_t)&ds1803_cfg[DS1803_100] },
-	{ "ds3502", (kernel_ulong_t)&ds1803_cfg[DS3502] },
+	{ .name = "ds1803-010", .driver_data = (kernel_ulong_t)&ds1803_cfg[DS1803_010] },
+	{ .name = "ds1803-050", .driver_data = (kernel_ulong_t)&ds1803_cfg[DS1803_050] },
+	{ .name = "ds1803-100", .driver_data = (kernel_ulong_t)&ds1803_cfg[DS1803_100] },
+	{ .name = "ds3502", .driver_data = (kernel_ulong_t)&ds1803_cfg[DS3502] },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, ds1803_id);
diff --git a/drivers/iio/potentiometer/tpl0102.c b/drivers/iio/potentiometer/tpl0102.c
index a42b57733363..77149908e1bf 100644
--- a/drivers/iio/potentiometer/tpl0102.c
+++ b/drivers/iio/potentiometer/tpl0102.c
@@ -149,10 +149,10 @@ static int tpl0102_probe(struct i2c_client *client)
 }
 
 static const struct i2c_device_id tpl0102_id[] = {
-	{ "cat5140-503", CAT5140_503 },
-	{ "cat5140-104", CAT5140_104 },
-	{ "tpl0102-104", TPL0102_104 },
-	{ "tpl0401-103", TPL0401_103 },
+	{ .name = "cat5140-503", .driver_data = CAT5140_503 },
+	{ .name = "cat5140-104", .driver_data = CAT5140_104 },
+	{ .name = "tpl0102-104", .driver_data = TPL0102_104 },
+	{ .name = "tpl0401-103", .driver_data = TPL0401_103 },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, tpl0102_id);
diff --git a/drivers/iio/pressure/abp060mg.c b/drivers/iio/pressure/abp060mg.c
index 699b0fd64985..fd48bed35088 100644
--- a/drivers/iio/pressure/abp060mg.c
+++ b/drivers/iio/pressure/abp060mg.c
@@ -209,44 +209,66 @@ static int abp060mg_probe(struct i2c_client *client)
 static const struct i2c_device_id abp060mg_id_table[] = {
 	/* mbar & kPa variants (abp060m [60 mbar] == abp006k [6 kPa]) */
 	/*    gage: */
-	{ "abp060mg", ABP006KG }, { "abp006kg", ABP006KG },
-	{ "abp100mg", ABP010KG }, { "abp010kg", ABP010KG },
-	{ "abp160mg", ABP016KG }, { "abp016kg", ABP016KG },
-	{ "abp250mg", ABP025KG }, { "abp025kg", ABP025KG },
-	{ "abp400mg", ABP040KG }, { "abp040kg", ABP040KG },
-	{ "abp600mg", ABP060KG }, { "abp060kg", ABP060KG },
-	{ "abp001bg", ABP100KG }, { "abp100kg", ABP100KG },
-	{ "abp1_6bg", ABP160KG }, { "abp160kg", ABP160KG },
-	{ "abp2_5bg", ABP250KG }, { "abp250kg", ABP250KG },
-	{ "abp004bg", ABP400KG }, { "abp400kg", ABP400KG },
-	{ "abp006bg", ABP600KG }, { "abp600kg", ABP600KG },
-	{ "abp010bg", ABP001GG }, { "abp001gg", ABP001GG },
+	{ .name = "abp060mg", .driver_data = ABP006KG },
+	{ .name = "abp006kg", .driver_data = ABP006KG },
+	{ .name = "abp100mg", .driver_data = ABP010KG },
+	{ .name = "abp010kg", .driver_data = ABP010KG },
+	{ .name = "abp160mg", .driver_data = ABP016KG },
+	{ .name = "abp016kg", .driver_data = ABP016KG },
+	{ .name = "abp250mg", .driver_data = ABP025KG },
+	{ .name = "abp025kg", .driver_data = ABP025KG },
+	{ .name = "abp400mg", .driver_data = ABP040KG },
+	{ .name = "abp040kg", .driver_data = ABP040KG },
+	{ .name = "abp600mg", .driver_data = ABP060KG },
+	{ .name = "abp060kg", .driver_data = ABP060KG },
+	{ .name = "abp001bg", .driver_data = ABP100KG },
+	{ .name = "abp100kg", .driver_data = ABP100KG },
+	{ .name = "abp1_6bg", .driver_data = ABP160KG },
+	{ .name = "abp160kg", .driver_data = ABP160KG },
+	{ .name = "abp2_5bg", .driver_data = ABP250KG },
+	{ .name = "abp250kg", .driver_data = ABP250KG },
+	{ .name = "abp004bg", .driver_data = ABP400KG },
+	{ .name = "abp400kg", .driver_data = ABP400KG },
+	{ .name = "abp006bg", .driver_data = ABP600KG },
+	{ .name = "abp600kg", .driver_data = ABP600KG },
+	{ .name = "abp010bg", .driver_data = ABP001GG },
+	{ .name = "abp001gg", .driver_data = ABP001GG },
 	/*    differential: */
-	{ "abp060md", ABP006KD }, { "abp006kd", ABP006KD },
-	{ "abp100md", ABP010KD }, { "abp010kd", ABP010KD },
-	{ "abp160md", ABP016KD }, { "abp016kd", ABP016KD },
-	{ "abp250md", ABP025KD }, { "abp025kd", ABP025KD },
-	{ "abp400md", ABP040KD }, { "abp040kd", ABP040KD },
-	{ "abp600md", ABP060KD }, { "abp060kd", ABP060KD },
-	{ "abp001bd", ABP100KD }, { "abp100kd", ABP100KD },
-	{ "abp1_6bd", ABP160KD }, { "abp160kd", ABP160KD },
-	{ "abp2_5bd", ABP250KD }, { "abp250kd", ABP250KD },
-	{ "abp004bd", ABP400KD }, { "abp400kd", ABP400KD },
+	{ .name = "abp060md", .driver_data = ABP006KD },
+	{ .name = "abp006kd", .driver_data = ABP006KD },
+	{ .name = "abp100md", .driver_data = ABP010KD },
+	{ .name = "abp010kd", .driver_data = ABP010KD },
+	{ .name = "abp160md", .driver_data = ABP016KD },
+	{ .name = "abp016kd", .driver_data = ABP016KD },
+	{ .name = "abp250md", .driver_data = ABP025KD },
+	{ .name = "abp025kd", .driver_data = ABP025KD },
+	{ .name = "abp400md", .driver_data = ABP040KD },
+	{ .name = "abp040kd", .driver_data = ABP040KD },
+	{ .name = "abp600md", .driver_data = ABP060KD },
+	{ .name = "abp060kd", .driver_data = ABP060KD },
+	{ .name = "abp001bd", .driver_data = ABP100KD },
+	{ .name = "abp100kd", .driver_data = ABP100KD },
+	{ .name = "abp1_6bd", .driver_data = ABP160KD },
+	{ .name = "abp160kd", .driver_data = ABP160KD },
+	{ .name = "abp2_5bd", .driver_data = ABP250KD },
+	{ .name = "abp250kd", .driver_data = ABP250KD },
+	{ .name = "abp004bd", .driver_data = ABP400KD },
+	{ .name = "abp400kd", .driver_data = ABP400KD },
 	/* psi variants */
 	/*    gage: */
-	{ "abp001pg", ABP001PG },
-	{ "abp005pg", ABP005PG },
-	{ "abp015pg", ABP015PG },
-	{ "abp030pg", ABP030PG },
-	{ "abp060pg", ABP060PG },
-	{ "abp100pg", ABP100PG },
-	{ "abp150pg", ABP150PG },
+	{ .name = "abp001pg", .driver_data = ABP001PG },
+	{ .name = "abp005pg", .driver_data = ABP005PG },
+	{ .name = "abp015pg", .driver_data = ABP015PG },
+	{ .name = "abp030pg", .driver_data = ABP030PG },
+	{ .name = "abp060pg", .driver_data = ABP060PG },
+	{ .name = "abp100pg", .driver_data = ABP100PG },
+	{ .name = "abp150pg", .driver_data = ABP150PG },
 	/*    differential: */
-	{ "abp001pd", ABP001PD },
-	{ "abp005pd", ABP005PD },
-	{ "abp015pd", ABP015PD },
-	{ "abp030pd", ABP030PD },
-	{ "abp060pd", ABP060PD },
+	{ .name = "abp001pd", .driver_data = ABP001PD },
+	{ .name = "abp005pd", .driver_data = ABP005PD },
+	{ .name = "abp015pd", .driver_data = ABP015PD },
+	{ .name = "abp030pd", .driver_data = ABP030PD },
+	{ .name = "abp060pd", .driver_data = ABP060PD },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, abp060mg_id_table);
diff --git a/drivers/iio/pressure/bmp280-i2c.c b/drivers/iio/pressure/bmp280-i2c.c
index 8e459b6c97ff..3f6e0723a9d7 100644
--- a/drivers/iio/pressure/bmp280-i2c.c
+++ b/drivers/iio/pressure/bmp280-i2c.c
@@ -38,12 +38,12 @@ static const struct of_device_id bmp280_of_i2c_match[] = {
 MODULE_DEVICE_TABLE(of, bmp280_of_i2c_match);
 
 static const struct i2c_device_id bmp280_i2c_id[] = {
-	{"bmp085", (kernel_ulong_t)&bmp085_chip_info },
-	{"bmp180", (kernel_ulong_t)&bmp180_chip_info },
-	{"bmp280", (kernel_ulong_t)&bmp280_chip_info },
-	{"bme280", (kernel_ulong_t)&bme280_chip_info },
-	{"bmp380", (kernel_ulong_t)&bmp380_chip_info },
-	{"bmp580", (kernel_ulong_t)&bmp580_chip_info },
+	{ .name = "bmp085", .driver_data = (kernel_ulong_t)&bmp085_chip_info },
+	{ .name = "bmp180", .driver_data = (kernel_ulong_t)&bmp180_chip_info },
+	{ .name = "bmp280", .driver_data = (kernel_ulong_t)&bmp280_chip_info },
+	{ .name = "bme280", .driver_data = (kernel_ulong_t)&bme280_chip_info },
+	{ .name = "bmp380", .driver_data = (kernel_ulong_t)&bmp380_chip_info },
+	{ .name = "bmp580", .driver_data = (kernel_ulong_t)&bmp580_chip_info },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, bmp280_i2c_id);
diff --git a/drivers/iio/pressure/dlhl60d.c b/drivers/iio/pressure/dlhl60d.c
index 46feb27fe632..01a873165923 100644
--- a/drivers/iio/pressure/dlhl60d.c
+++ b/drivers/iio/pressure/dlhl60d.c
@@ -340,8 +340,8 @@ static const struct of_device_id dlh_of_match[] = {
 MODULE_DEVICE_TABLE(of, dlh_of_match);
 
 static const struct i2c_device_id dlh_id[] = {
-	{ "dlhl60d", (kernel_ulong_t)&dlhl60d_info },
-	{ "dlhl60g", (kernel_ulong_t)&dlhl60g_info },
+	{ .name = "dlhl60d", .driver_data = (kernel_ulong_t)&dlhl60d_info },
+	{ .name = "dlhl60g", .driver_data = (kernel_ulong_t)&dlhl60g_info },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, dlh_id);
diff --git a/drivers/iio/pressure/ms5611_i2c.c b/drivers/iio/pressure/ms5611_i2c.c
index 1c041b9085fb..b5be6a6daf02 100644
--- a/drivers/iio/pressure/ms5611_i2c.c
+++ b/drivers/iio/pressure/ms5611_i2c.c
@@ -113,8 +113,8 @@ static const struct of_device_id ms5611_i2c_matches[] = {
 MODULE_DEVICE_TABLE(of, ms5611_i2c_matches);
 
 static const struct i2c_device_id ms5611_id[] = {
-	{ "ms5611", MS5611 },
-	{ "ms5607", MS5607 },
+	{ .name = "ms5611", .driver_data = MS5611 },
+	{ .name = "ms5607", .driver_data = MS5607 },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, ms5611_id);
diff --git a/drivers/iio/pressure/ms5637.c b/drivers/iio/pressure/ms5637.c
index 59705a666979..03945a4fc718 100644
--- a/drivers/iio/pressure/ms5637.c
+++ b/drivers/iio/pressure/ms5637.c
@@ -215,10 +215,10 @@ static const struct ms_tp_data ms8607_data = {
 };
 
 static const struct i2c_device_id ms5637_id[] = {
-	{"ms5637", (kernel_ulong_t)&ms5637_data },
-	{"ms5805", (kernel_ulong_t)&ms5805_data },
-	{"ms5837", (kernel_ulong_t)&ms5837_data },
-	{"ms8607-temppressure", (kernel_ulong_t)&ms8607_data },
+	{ .name = "ms5637", .driver_data = (kernel_ulong_t)&ms5637_data },
+	{ .name = "ms5805", .driver_data = (kernel_ulong_t)&ms5805_data },
+	{ .name = "ms5837", .driver_data = (kernel_ulong_t)&ms5837_data },
+	{ .name = "ms8607-temppressure", .driver_data = (kernel_ulong_t)&ms8607_data },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, ms5637_id);
diff --git a/drivers/iio/pressure/st_pressure_i2c.c b/drivers/iio/pressure/st_pressure_i2c.c
index 0f50bac1fb4d..816bfcfd62ae 100644
--- a/drivers/iio/pressure/st_pressure_i2c.c
+++ b/drivers/iio/pressure/st_pressure_i2c.c
@@ -61,14 +61,14 @@ static const struct acpi_device_id st_press_acpi_match[] = {
 MODULE_DEVICE_TABLE(acpi, st_press_acpi_match);
 
 static const struct i2c_device_id st_press_id_table[] = {
-	{ LPS001WP_PRESS_DEV_NAME, LPS001WP },
-	{ LPS25H_PRESS_DEV_NAME,  LPS25H },
-	{ LPS331AP_PRESS_DEV_NAME, LPS331AP },
-	{ LPS22HB_PRESS_DEV_NAME, LPS22HB },
-	{ LPS33HW_PRESS_DEV_NAME, LPS33HW },
-	{ LPS35HW_PRESS_DEV_NAME, LPS35HW },
-	{ LPS22HH_PRESS_DEV_NAME, LPS22HH },
-	{ LPS22DF_PRESS_DEV_NAME, LPS22DF },
+	{ .name = LPS001WP_PRESS_DEV_NAME, .driver_data = LPS001WP },
+	{ .name = LPS25H_PRESS_DEV_NAME, .driver_data = LPS25H },
+	{ .name = LPS331AP_PRESS_DEV_NAME, .driver_data = LPS331AP },
+	{ .name = LPS22HB_PRESS_DEV_NAME, .driver_data = LPS22HB },
+	{ .name = LPS33HW_PRESS_DEV_NAME, .driver_data = LPS33HW },
+	{ .name = LPS35HW_PRESS_DEV_NAME, .driver_data = LPS35HW },
+	{ .name = LPS22HH_PRESS_DEV_NAME, .driver_data = LPS22HH },
+	{ .name = LPS22DF_PRESS_DEV_NAME, .driver_data = LPS22DF },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, st_press_id_table);
diff --git a/drivers/iio/proximity/aw96103.c b/drivers/iio/proximity/aw96103.c
index 3472a2c36e44..8fbb755dcae0 100644
--- a/drivers/iio/proximity/aw96103.c
+++ b/drivers/iio/proximity/aw96103.c
@@ -825,8 +825,8 @@ static const struct of_device_id aw96103_dt_match[] = {
 MODULE_DEVICE_TABLE(of, aw96103_dt_match);
 
 static const struct i2c_device_id aw96103_i2c_id[] = {
-	{ "aw96103", (kernel_ulong_t)&aw_chip_info_tbl[AW96103_VAL] },
-	{ "aw96105", (kernel_ulong_t)&aw_chip_info_tbl[AW96105_VAL] },
+	{ .name = "aw96103", .driver_data = (kernel_ulong_t)&aw_chip_info_tbl[AW96103_VAL] },
+	{ .name = "aw96105", .driver_data = (kernel_ulong_t)&aw_chip_info_tbl[AW96105_VAL] },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, aw96103_i2c_id);
diff --git a/drivers/iio/proximity/srf08.c b/drivers/iio/proximity/srf08.c
index d7e4cc48cfbf..01328d155350 100644
--- a/drivers/iio/proximity/srf08.c
+++ b/drivers/iio/proximity/srf08.c
@@ -533,9 +533,9 @@ static const struct of_device_id of_srf08_match[] = {
 MODULE_DEVICE_TABLE(of, of_srf08_match);
 
 static const struct i2c_device_id srf08_id[] = {
-	{ "srf02", SRF02 },
-	{ "srf08", SRF08 },
-	{ "srf10", SRF10 },
+	{ .name = "srf02", .driver_data = SRF02 },
+	{ .name = "srf08", .driver_data = SRF08 },
+	{ .name = "srf10", .driver_data = SRF10 },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, srf08_id);
diff --git a/drivers/iio/proximity/sx9310.c b/drivers/iio/proximity/sx9310.c
index fb02eac78ed4..602f7b95c83e 100644
--- a/drivers/iio/proximity/sx9310.c
+++ b/drivers/iio/proximity/sx9310.c
@@ -1007,8 +1007,8 @@ static const struct of_device_id sx9310_of_match[] = {
 MODULE_DEVICE_TABLE(of, sx9310_of_match);
 
 static const struct i2c_device_id sx9310_id[] = {
-	{ "sx9310", (kernel_ulong_t)&sx9310_info },
-	{ "sx9311", (kernel_ulong_t)&sx9311_info },
+	{ .name = "sx9310", .driver_data = (kernel_ulong_t)&sx9310_info },
+	{ .name = "sx9311", .driver_data = (kernel_ulong_t)&sx9311_info },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, sx9310_id);
diff --git a/drivers/iio/proximity/sx9324.c b/drivers/iio/proximity/sx9324.c
index f61eff39751d..4831d33cb337 100644
--- a/drivers/iio/proximity/sx9324.c
+++ b/drivers/iio/proximity/sx9324.c
@@ -1135,7 +1135,7 @@ static const struct of_device_id sx9324_of_match[] = {
 MODULE_DEVICE_TABLE(of, sx9324_of_match);
 
 static const struct i2c_device_id sx9324_id[] = {
-	{ "sx9324", SX9324_WHOAMI_VALUE },
+	{ .name = "sx9324", .driver_data = SX9324_WHOAMI_VALUE },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, sx9324_id);
diff --git a/drivers/iio/proximity/sx9360.c b/drivers/iio/proximity/sx9360.c
index 4448988d4e7e..f8fd399dc2be 100644
--- a/drivers/iio/proximity/sx9360.c
+++ b/drivers/iio/proximity/sx9360.c
@@ -845,7 +845,7 @@ static const struct of_device_id sx9360_of_match[] = {
 MODULE_DEVICE_TABLE(of, sx9360_of_match);
 
 static const struct i2c_device_id sx9360_id[] = {
-	{"sx9360", SX9360_WHOAMI_VALUE },
+	{ .name = "sx9360", .driver_data = SX9360_WHOAMI_VALUE },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, sx9360_id);
diff --git a/drivers/iio/temperature/tmp117.c b/drivers/iio/temperature/tmp117.c
index 8972083d903a..6bc18616ad15 100644
--- a/drivers/iio/temperature/tmp117.c
+++ b/drivers/iio/temperature/tmp117.c
@@ -209,8 +209,8 @@ static const struct of_device_id tmp117_of_match[] = {
 MODULE_DEVICE_TABLE(of, tmp117_of_match);
 
 static const struct i2c_device_id tmp117_id[] = {
-	{ "tmp116", (kernel_ulong_t)&tmp116_channels_info },
-	{ "tmp117", (kernel_ulong_t)&tmp117_channels_info },
+	{ .name = "tmp116", .driver_data = (kernel_ulong_t)&tmp116_channels_info },
+	{ .name = "tmp117", .driver_data = (kernel_ulong_t)&tmp117_channels_info },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, tmp117_id);
-- 
2.47.3

