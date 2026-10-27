Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793105414;
	b=kvI/AhdTYHhXJubunD5K7rfIdsNAPXEI/SPQy5UoPExE43i+u4LkuEngMBdRHW0QYhsy
	 eZnQGErQ/x4wAwSQKwbKAALrqholdsJM4WN7g1/ERz+3WT5NtGqTaXxmqxkL2csJ6DEc5
	 Fr5HO+HSdZH1/HtsxFf/7zQGluJCk3ruqArBQC+NHrGrxWhowytj7kNFcGaCdbz52TLjU
	 3pw3rYRnSMlit9whblzEjZepa45uKyrK6d/OVzZkvN2BLKGF5PmZocnTpoUDm/cuay+0P
	 9N8fW9wYonDsoNK65c8mzN4A0D3TaIv/P7gxdcO7FG/45ePmff/3HrNZcrhd5nhiZHw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793105414;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=WGfqlzOlm/2Znl/FFRINE+v3482ibGM0kLPKp8gPRsI=;
	b=CBA3AjE5zX1aSWgC7hh1zdpZIMjcrnR/kbEKdZOLMoKadj5crDbtxRR4XWY+B4m6AZF0
	 RewKnQKH9hNEpv7OXQZ3x7B2l7+yn7Rb9qU/pzZzYVWrnkkOqgVz6T+DjGSYEr3IlE6Xl
	 3di9yfUUKvTtpa5go5QdQ79b3+sKkRB4XfeOrrVmmvNb4db8wSLh8IfmUQl1c3ROnEaM/
	 7mSDkSjzdztkzDM3+kK906aUFV/vWao5uhl5/decV7SbPZuBT1kBpozeT3lYA6LOHRuSM
	 pBdM0A1EZefxy7JXp4nD2OWLKEaSGKgWSw9WeC2GDRspdWRSsxSu1JYGq7+x9BZZloA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="DsxI+c/j";
	arc=none smtp.remote-ip=209.85.167.52
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A582860A3834
	for <linux-iio@vger.kernel.org>; Tue, 27 Oct 2026 12:50:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A582860A3834
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=DsxI+c/j
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5be3ea5a7adso1832132e87.2
        for <linux-iio@vger.kernel.org>; Tue, 27 Oct 2026 05:50:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793105412; x=1793710212; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WGfqlzOlm/2Znl/FFRINE+v3482ibGM0kLPKp8gPRsI=;
        b=DsxI+c/j5luKhz2DTcBC/EQ6eAMBNBTuZW+hO4kfZKURCgWmr3Au7SV5GFXeGmVRAE
         nbHzTxFnYiNHhhO2kW0QYy4nPqr3/oGopTV8JGUbmk/PjK7PqFj7OSdmWeM+LcjO3gmm
         SLtPDDEWAKurXoL1/ziObfD/MN3uHUPRlGM1TJvOQ9Mr0/W7+ehi+CMZViZDreqQ4Fxa
         AngwzBstZf7sUg0krDqKTsYZHDFbaZKwO8zZr+q80GcYKj8QBWm50O7yqDEHAgVxdckq
         WuPciy4/tslSjz0XftLlFYNl/hW2cl4ShpZGGmxd23QGhB24cvdvPjVTzDZiayoHTfLN
         2ZRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793105412; x=1793710212;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=WGfqlzOlm/2Znl/FFRINE+v3482ibGM0kLPKp8gPRsI=;
        b=DWTH+PWD610zxq0xfJryRvbjaMvwg0WULxlEltb6NJ8k7IzoomNzmDGStWEkt+8Cz2
         N017UoCpMwNPrMiRC94++Kc3b/J7wfGU4aG6STDn38kuRZuPMNJx+Kj/FKBXSE1ib25b
         K/bGwMustbZW3ysrofTSzhKrpTG0cPMhc7guX6+l6eyyJkKzFO7hv9Fcqe1lvCUTDzmc
         g5rg9Z8dN/Eu4Uhb7UchjYFzgct9GzdatWhCE5caaJthH8BTBiE1tNeeXzNAdtCwla8n
         U+zQJWFfG63nKWkwIsthSUrHIkLvnnPUs18bLZoyhvKQ8+MSPe2zKCKAez8N6qSgNkOj
         jdAQ==
X-Forwarded-Encrypted: i=1; AKwUvBxNuUbMoiO14AGuMMBLbT0UQOOPjrhnDOU1abPtuIzyxsRorYOs0i8NPO8fkKqcluFbZoXjAYXru74=@vger.kernel.org
X-Gm-Message-State: AFq9FYJhJI85rkEqt0tpkmd/cYMj+ECoeQ6IP1qne6eJWZiOuEn4K6xg
	GCdhwDu9pvsOxY8pzoSNP1xCpw6v/TFfJ3MhEnfX512If5dzXNzszst3
X-Gm-Gg: AYBFou2Oh2mfL6ljLeCklF8Z3q3KBUCChArr+VBaK4E3cmIM/3uy2KcBhcgKpv878OH
	zRFF/Wxcc0o2ujqb9cWY1NOMOfCdkcqAR5bBT4GrWUg4CZD0tyKp3uXRzlOqTRFKa+haCu9rsw2
	gxeoG14I7SxSoIzmom2REizhajxsN/Lmz0QxEHeEuCxfgCtHxON7WW197DL8A6OdIMvo34vWegK
	r8CvJc0+IuttyT4DFH6vy/xUFs9vAOvgIDNPkBXObAsGp0Ruh5bNm7dXPPaUMsvu3FQEfVx2/0h
	bg16zF3Ud5xg+mINOkhE//sM7Oh0rS8SDFYhX8RSXLauf1pLCWt4PfFGhD1Z9CLI0YImDhLX1d0
	7sHB8K77ham95OhcLxhYv7AL7Oh56q62jRfXUi5chxKH62w1iDk9sCIHrahemrOF3xmpTgJXfK4
	79kV55SyiK2a3y4C49A9Dh2yH0OpT7RFNclB/yUMVB+Y6aaLQwjO/c6w+yJfNLAToSHt0kwDLHn
	eZ8n1NaUF8oxD+PnmGqBpPsn8orfJurEm9dTyL2xmKOwoElojGBjQJb/tWiBhawVTvmV0HHidjf
	H9uX3GiTr5CfJmPY7Zp9e/YS02sleTRW9cn8dKwQ/q4auRyCs/HQIV3sxYlh0fJo
X-Received: by 2002:a05:6512:400f:b0:5bf:bed1:6ae2 with SMTP id 2adb3069b0e04-5bfbed16c19mr1876354e87.65.1793105411577;
        Tue, 27 Oct 2026 05:50:11 -0700 (PDT)
Received: from yantra.. (nekmmqtcmoboczbkdcs-1.v6.elisa-laajakaista.fi. [2001:99a:d7d:c300:55c8:a52b:6ba2:979c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5bfb7e7cb24sm2052803e87.25.2026.10.27.05.50.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 05:50:11 -0700 (PDT)
From: Rupesh Majhi <zoone.rupert@gmail.com>
To: Alex Lanzano <lanzano.alex@gmail.com>,
	Andy Shevchenko <andy@kernel.org>,
	Benson Leung <bleung@chromium.org>,
	David Lechner <dlechner@baylibre.com>,
	Guenter Roeck <groeck@chromium.org>,
	Jagath Jog J <jagathjog1996@gmail.com>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Jinseob Kim <kimjinseob88@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Remi Buisson <remi.buisson@tdk.com>
Cc: chrome-platform@lists.linux.dev,
	linux-amlogic@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-arm-msm@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Rupesh Majhi <zoone.rupert@gmail.com>,
	Marco Elver <elver@google.com>,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH v4 9/9] iio: enable context analysis for all drivers
Date: Tue, 27 Oct 2026 14:49:54 +0200
Message-ID: <20261027124954.110697-10-zoone.rupert@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261027124954.110697-1-zoone.rupert@gmail.com>
References: <20261027124954.110697-1-zoone.rupert@gmail.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

All of drivers/iio now builds without context analysis warnings, so
enable it in every Makefile that builds objects, replacing the entry
for dps310 alone.

Suggested-by: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Rupesh Majhi <zoone.rupert@gmail.com>
---
Cc: Marco Elver <elver@google.com>
Cc: Bart Van Assche <bvanassche@acm.org>

 drivers/iio/Makefile                        | 2 ++
 drivers/iio/accel/Makefile                  | 2 ++
 drivers/iio/adc/Makefile                    | 2 ++
 drivers/iio/addac/Makefile                  | 2 ++
 drivers/iio/afe/Makefile                    | 2 ++
 drivers/iio/amplifiers/Makefile             | 2 ++
 drivers/iio/buffer/Makefile                 | 2 ++
 drivers/iio/cdc/Makefile                    | 2 ++
 drivers/iio/chemical/Makefile               | 2 ++
 drivers/iio/common/cros_ec_sensors/Makefile | 2 ++
 drivers/iio/common/hid-sensors/Makefile     | 2 ++
 drivers/iio/common/inv_sensors/Makefile     | 2 ++
 drivers/iio/common/ms_sensors/Makefile      | 2 ++
 drivers/iio/common/scmi_sensors/Makefile    | 3 +++
 drivers/iio/common/ssp_sensors/Makefile     | 2 ++
 drivers/iio/common/st_sensors/Makefile      | 2 ++
 drivers/iio/dac/Makefile                    | 2 ++
 drivers/iio/dummy/Makefile                  | 2 ++
 drivers/iio/filter/Makefile                 | 2 ++
 drivers/iio/flow/Makefile                   | 2 ++
 drivers/iio/frequency/Makefile              | 2 ++
 drivers/iio/gyro/Makefile                   | 2 ++
 drivers/iio/health/Makefile                 | 2 ++
 drivers/iio/humidity/Makefile               | 2 ++
 drivers/iio/imu/Makefile                    | 2 ++
 drivers/iio/imu/bmi160/Makefile             | 3 +++
 drivers/iio/imu/bmi270/Makefile             | 3 +++
 drivers/iio/imu/bmi323/Makefile             | 3 +++
 drivers/iio/imu/bno055/Makefile             | 2 ++
 drivers/iio/imu/inv_icm42600/Makefile       | 2 ++
 drivers/iio/imu/inv_icm42607/Makefile       | 2 ++
 drivers/iio/imu/inv_icm45600/Makefile       | 2 ++
 drivers/iio/imu/inv_mpu6050/Makefile        | 2 ++
 drivers/iio/imu/smi330/Makefile             | 3 +++
 drivers/iio/imu/st_lsm6dsx/Makefile         | 3 +++
 drivers/iio/imu/st_lsm9ds0/Makefile         | 3 +++
 drivers/iio/light/Makefile                  | 2 ++
 drivers/iio/magnetometer/Makefile           | 2 ++
 drivers/iio/multiplexer/Makefile            | 2 ++
 drivers/iio/orientation/Makefile            | 2 ++
 drivers/iio/position/Makefile               | 2 ++
 drivers/iio/potentiometer/Makefile          | 2 ++
 drivers/iio/potentiostat/Makefile           | 2 ++
 drivers/iio/pressure/Makefile               | 2 +-
 drivers/iio/proximity/Makefile              | 2 ++
 drivers/iio/resolver/Makefile               | 2 ++
 drivers/iio/sensorhubs/osf/Makefile         | 2 ++
 drivers/iio/temperature/Makefile            | 2 ++
 drivers/iio/test/Makefile                   | 2 ++
 drivers/iio/trigger/Makefile                | 2 ++
 50 files changed, 106 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/Makefile b/drivers/iio/Makefile
index 4e1d930108de..7aead0b09cc6 100644
--- a/drivers/iio/Makefile
+++ b/drivers/iio/Makefile
@@ -3,6 +3,8 @@
 # Makefile for the industrial I/O core.
 #
 
+CONTEXT_ANALYSIS := y
+
 obj-$(CONFIG_IIO) += industrialio.o
 industrialio-y := industrialio-core.o industrialio-event.o inkern.o
 industrialio-$(CONFIG_IIO_BUFFER) += industrialio-buffer.o
diff --git a/drivers/iio/accel/Makefile b/drivers/iio/accel/Makefile
index fa440a859283..ec75ab67bd45 100644
--- a/drivers/iio/accel/Makefile
+++ b/drivers/iio/accel/Makefile
@@ -3,6 +3,8 @@
 # Makefile for industrial I/O accelerometer drivers
 #
 
+CONTEXT_ANALYSIS := y
+
 # When adding new entries keep the list in alphabetical order
 obj-$(CONFIG_ADIS16201) += adis16201.o
 obj-$(CONFIG_ADIS16209) += adis16209.o
diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
index d7bb4815df61..15ac57dc2054 100644
--- a/drivers/iio/adc/Makefile
+++ b/drivers/iio/adc/Makefile
@@ -3,6 +3,8 @@
 # Makefile for IIO ADC drivers
 #
 
+CONTEXT_ANALYSIS := y
+
 obj-$(CONFIG_IIO_ADC_HELPER) += industrialio-adc.o
 
 # When adding new entries keep the list in alphabetical order
diff --git a/drivers/iio/addac/Makefile b/drivers/iio/addac/Makefile
index 577777276e43..ca0c5d341627 100644
--- a/drivers/iio/addac/Makefile
+++ b/drivers/iio/addac/Makefile
@@ -3,6 +3,8 @@
 # Makefile for industrial I/O ADDAC drivers
 #
 
+CONTEXT_ANALYSIS := y
+
 # When adding new entries keep the list in alphabetical order
 obj-$(CONFIG_AD74115) += ad74115.o
 obj-$(CONFIG_AD74413R) += ad74413r.o
diff --git a/drivers/iio/afe/Makefile b/drivers/iio/afe/Makefile
index 4c56c8edb2ba..453f1fc7f647 100644
--- a/drivers/iio/afe/Makefile
+++ b/drivers/iio/afe/Makefile
@@ -3,5 +3,7 @@
 # Makefile for industrial I/O Analog Front Ends (AFE)
 #
 
+CONTEXT_ANALYSIS := y
+
 # When adding new entries keep the list in alphabetical order
 obj-$(CONFIG_IIO_RESCALE) += iio-rescale.o
diff --git a/drivers/iio/amplifiers/Makefile b/drivers/iio/amplifiers/Makefile
index 0a76443be1aa..d7c5036ba2df 100644
--- a/drivers/iio/amplifiers/Makefile
+++ b/drivers/iio/amplifiers/Makefile
@@ -3,6 +3,8 @@
 # Makefile iio/amplifiers
 #
 
+CONTEXT_ANALYSIS := y
+
 # When adding new entries keep the list in alphabetical order
 obj-$(CONFIG_AD8366) += ad8366.o
 obj-$(CONFIG_ADA4250) += ada4250.o
diff --git a/drivers/iio/buffer/Makefile b/drivers/iio/buffer/Makefile
index 1403eb2f9409..bb068efa4c9d 100644
--- a/drivers/iio/buffer/Makefile
+++ b/drivers/iio/buffer/Makefile
@@ -3,6 +3,8 @@
 # Makefile for the industrial I/O buffer implementations
 #
 
+CONTEXT_ANALYSIS := y
+
 # When adding new entries keep the list in alphabetical order
 obj-$(CONFIG_IIO_BUFFER_CB) += industrialio-buffer-cb.o
 obj-$(CONFIG_IIO_BUFFER_DMA) += industrialio-buffer-dma.o
diff --git a/drivers/iio/cdc/Makefile b/drivers/iio/cdc/Makefile
index 41db756d8020..241263f7b512 100644
--- a/drivers/iio/cdc/Makefile
+++ b/drivers/iio/cdc/Makefile
@@ -3,5 +3,7 @@
 # Makefile for industrial I/O capacitance to digital converter (CDC) drivers
 #
 
+CONTEXT_ANALYSIS := y
+
 obj-$(CONFIG_AD7150) += ad7150.o
 obj-$(CONFIG_AD7746) += ad7746.o
diff --git a/drivers/iio/chemical/Makefile b/drivers/iio/chemical/Makefile
index 2287a00a6b75..0cffbad02234 100644
--- a/drivers/iio/chemical/Makefile
+++ b/drivers/iio/chemical/Makefile
@@ -3,6 +3,8 @@
 # Makefile for IIO chemical sensors
 #
 
+CONTEXT_ANALYSIS := y
+
 # When adding new entries keep the list in alphabetical order
 obj-$(CONFIG_AOSONG_AGS02MA)	+= ags02ma.o
 obj-$(CONFIG_ATLAS_PH_SENSOR)	+= atlas-sensor.o
diff --git a/drivers/iio/common/cros_ec_sensors/Makefile b/drivers/iio/common/cros_ec_sensors/Makefile
index a7dfb5794cae..5c41c7e52d0c 100644
--- a/drivers/iio/common/cros_ec_sensors/Makefile
+++ b/drivers/iio/common/cros_ec_sensors/Makefile
@@ -3,6 +3,8 @@
 # Makefile for sensors seen through the ChromeOS EC sensor hub.
 #
 
+CONTEXT_ANALYSIS := y
+
 cros-ec-sensors-core-objs += cros_ec_sensors_core.o cros_ec_sensors_trace.o
 obj-$(CONFIG_IIO_CROS_EC_SENSORS_CORE) += cros-ec-sensors-core.o
 obj-$(CONFIG_IIO_CROS_EC_SENSORS) += cros_ec_sensors.o
diff --git a/drivers/iio/common/hid-sensors/Makefile b/drivers/iio/common/hid-sensors/Makefile
index 64b01a81fcb2..b90bcf40066a 100644
--- a/drivers/iio/common/hid-sensors/Makefile
+++ b/drivers/iio/common/hid-sensors/Makefile
@@ -3,6 +3,8 @@
 # Makefile for the Hid sensor common modules.
 #
 
+CONTEXT_ANALYSIS := y
+
 obj-$(CONFIG_HID_SENSOR_IIO_COMMON) += hid-sensor-iio-common.o
 obj-$(CONFIG_HID_SENSOR_IIO_TRIGGER) += hid-sensor-trigger.o
 hid-sensor-iio-common-y := hid-sensor-attributes.o
diff --git a/drivers/iio/common/inv_sensors/Makefile b/drivers/iio/common/inv_sensors/Makefile
index dcf39f249112..a464dad84d68 100644
--- a/drivers/iio/common/inv_sensors/Makefile
+++ b/drivers/iio/common/inv_sensors/Makefile
@@ -3,4 +3,6 @@
 # Makefile for TDK-InvenSense sensors module.
 #
 
+CONTEXT_ANALYSIS := y
+
 obj-$(CONFIG_IIO_INV_SENSORS_TIMESTAMP) += inv_sensors_timestamp.o
diff --git a/drivers/iio/common/ms_sensors/Makefile b/drivers/iio/common/ms_sensors/Makefile
index 028573b9b7e3..8f9b9a4556e8 100644
--- a/drivers/iio/common/ms_sensors/Makefile
+++ b/drivers/iio/common/ms_sensors/Makefile
@@ -3,4 +3,6 @@
 # Makefile for the Measurement Specialties sensor common modules.
 #
 
+CONTEXT_ANALYSIS := y
+
 obj-$(CONFIG_IIO_MS_SENSORS_I2C) += ms_sensors_i2c.o
diff --git a/drivers/iio/common/scmi_sensors/Makefile b/drivers/iio/common/scmi_sensors/Makefile
index 645e0fce1a73..4c1421003d2d 100644
--- a/drivers/iio/common/scmi_sensors/Makefile
+++ b/drivers/iio/common/scmi_sensors/Makefile
@@ -2,4 +2,7 @@
 #
 # Makefile for the IIO over SCMI
 #
+
+CONTEXT_ANALYSIS := y
+
 obj-$(CONFIG_IIO_SCMI) += scmi_iio.o
diff --git a/drivers/iio/common/ssp_sensors/Makefile b/drivers/iio/common/ssp_sensors/Makefile
index ba831429b20a..caee484a0a23 100644
--- a/drivers/iio/common/ssp_sensors/Makefile
+++ b/drivers/iio/common/ssp_sensors/Makefile
@@ -3,6 +3,8 @@
 # Makefile for SSP sensor drivers and commons.
 #
 
+CONTEXT_ANALYSIS := y
+
 sensorhub-objs				:= ssp_dev.o ssp_spi.o
 obj-$(CONFIG_IIO_SSP_SENSORHUB)		+= sensorhub.o
 
diff --git a/drivers/iio/common/st_sensors/Makefile b/drivers/iio/common/st_sensors/Makefile
index f7fb3b79b64c..089f6aca57b7 100644
--- a/drivers/iio/common/st_sensors/Makefile
+++ b/drivers/iio/common/st_sensors/Makefile
@@ -3,6 +3,8 @@
 # Makefile for the STMicroelectronics sensor common modules.
 #
 
+CONTEXT_ANALYSIS := y
+
 obj-$(CONFIG_IIO_ST_SENSORS_I2C) += st_sensors_i2c.o
 obj-$(CONFIG_IIO_ST_SENSORS_SPI) += st_sensors_spi.o
 obj-$(CONFIG_IIO_ST_SENSORS_CORE) += st_sensors.o
diff --git a/drivers/iio/dac/Makefile b/drivers/iio/dac/Makefile
index 2cd0fe23db9e..72da690354e5 100644
--- a/drivers/iio/dac/Makefile
+++ b/drivers/iio/dac/Makefile
@@ -3,6 +3,8 @@
 # Makefile for industrial I/O DAC drivers
 #
 
+CONTEXT_ANALYSIS := y
+
 # When adding new entries keep the list in alphabetical order
 obj-$(CONFIG_AD3530R) += ad3530r.o
 obj-$(CONFIG_AD3552R_HS) += ad3552r-hs.o
diff --git a/drivers/iio/dummy/Makefile b/drivers/iio/dummy/Makefile
index f14fe20f365c..aa3949ec2619 100644
--- a/drivers/iio/dummy/Makefile
+++ b/drivers/iio/dummy/Makefile
@@ -3,6 +3,8 @@
 # Makefile for the IIO Dummy Driver
 #
 
+CONTEXT_ANALYSIS := y
+
 obj-$(CONFIG_IIO_SIMPLE_DUMMY) += iio_dummy.o
 iio_dummy-y := iio_simple_dummy.o
 iio_dummy-$(CONFIG_IIO_SIMPLE_DUMMY_EVENTS) += iio_simple_dummy_events.o
diff --git a/drivers/iio/filter/Makefile b/drivers/iio/filter/Makefile
index 55e228c0dd20..ec416d647755 100644
--- a/drivers/iio/filter/Makefile
+++ b/drivers/iio/filter/Makefile
@@ -3,5 +3,7 @@
 # Makefile for industrial I/O Filter drivers
 #
 
+CONTEXT_ANALYSIS := y
+
 # When adding new entries keep the list in alphabetical order
 obj-$(CONFIG_ADMV8818) += admv8818.o
diff --git a/drivers/iio/flow/Makefile b/drivers/iio/flow/Makefile
index 3cf4ab95c69c..ce5e1df630a9 100644
--- a/drivers/iio/flow/Makefile
+++ b/drivers/iio/flow/Makefile
@@ -3,5 +3,7 @@
 # Makefile for industrial I/O flow sensor drivers
 #
 
+CONTEXT_ANALYSIS := y
+
 # When adding new entries keep the list in alphabetical order
 obj-$(CONFIG_SENSIRION_SLF3S) += slf3s.o
diff --git a/drivers/iio/frequency/Makefile b/drivers/iio/frequency/Makefile
index e3b1d36ed620..5f9900a4ebf3 100644
--- a/drivers/iio/frequency/Makefile
+++ b/drivers/iio/frequency/Makefile
@@ -3,6 +3,8 @@
 # Makefile iio/frequency
 #
 
+CONTEXT_ANALYSIS := y
+
 # When adding new entries keep the list in alphabetical order
 obj-$(CONFIG_AD9523) += ad9523.o
 obj-$(CONFIG_AD9910) += ad9910.o
diff --git a/drivers/iio/gyro/Makefile b/drivers/iio/gyro/Makefile
index 0319b397dc3f..1c2a020ffe6e 100644
--- a/drivers/iio/gyro/Makefile
+++ b/drivers/iio/gyro/Makefile
@@ -3,6 +3,8 @@
 # Makefile for industrial I/O gyroscope sensor drivers
 #
 
+CONTEXT_ANALYSIS := y
+
 # When adding new entries keep the list in alphabetical order
 obj-$(CONFIG_ADIS16080) += adis16080.o
 obj-$(CONFIG_ADIS16130) += adis16130.o
diff --git a/drivers/iio/health/Makefile b/drivers/iio/health/Makefile
index 910817112258..9100aa431585 100644
--- a/drivers/iio/health/Makefile
+++ b/drivers/iio/health/Makefile
@@ -3,6 +3,8 @@
 # Makefile for IIO Health sensors
 #
 
+CONTEXT_ANALYSIS := y
+
 # When adding new entries keep the list in alphabetical order
 
 obj-$(CONFIG_AFE4403)		+= afe4403.o
diff --git a/drivers/iio/humidity/Makefile b/drivers/iio/humidity/Makefile
index 34b3dc749466..1d736b306a8d 100644
--- a/drivers/iio/humidity/Makefile
+++ b/drivers/iio/humidity/Makefile
@@ -3,6 +3,8 @@
 # Makefile for IIO humidity sensor drivers
 #
 
+CONTEXT_ANALYSIS := y
+
 obj-$(CONFIG_AM2315) += am2315.o
 obj-$(CONFIG_DHT11) += dht11.o
 obj-$(CONFIG_ENS210) += ens210.o
diff --git a/drivers/iio/imu/Makefile b/drivers/iio/imu/Makefile
index 3268dc2371ae..10383f75d288 100644
--- a/drivers/iio/imu/Makefile
+++ b/drivers/iio/imu/Makefile
@@ -3,6 +3,8 @@
 # Makefile for Inertial Measurement Units
 #
 
+CONTEXT_ANALYSIS := y
+
 # When adding new entries keep the list in alphabetical order
 obj-$(CONFIG_ADIS16400) += adis16400.o
 obj-$(CONFIG_ADIS16460) += adis16460.o
diff --git a/drivers/iio/imu/bmi160/Makefile b/drivers/iio/imu/bmi160/Makefile
index fdcfeddf48d4..72ebe0409d92 100644
--- a/drivers/iio/imu/bmi160/Makefile
+++ b/drivers/iio/imu/bmi160/Makefile
@@ -2,6 +2,9 @@
 #
 # Makefile for Bosch BMI160 IMU
 #
+
+CONTEXT_ANALYSIS := y
+
 obj-$(CONFIG_BMI160) += bmi160_core.o
 obj-$(CONFIG_BMI160_I2C) += bmi160_i2c.o
 obj-$(CONFIG_BMI160_SPI) += bmi160_spi.o
diff --git a/drivers/iio/imu/bmi270/Makefile b/drivers/iio/imu/bmi270/Makefile
index d96c96fc3d83..1dc327c96f8f 100644
--- a/drivers/iio/imu/bmi270/Makefile
+++ b/drivers/iio/imu/bmi270/Makefile
@@ -2,6 +2,9 @@
 #
 # Makefile for Bosch BMI270 IMU
 #
+
+CONTEXT_ANALYSIS := y
+
 obj-$(CONFIG_BMI270) += bmi270_core.o
 obj-$(CONFIG_BMI270_I2C) += bmi270_i2c.o
 obj-$(CONFIG_BMI270_SPI) += bmi270_spi.o
diff --git a/drivers/iio/imu/bmi323/Makefile b/drivers/iio/imu/bmi323/Makefile
index a6a6dc0207c9..ef8fc4f8460c 100644
--- a/drivers/iio/imu/bmi323/Makefile
+++ b/drivers/iio/imu/bmi323/Makefile
@@ -2,6 +2,9 @@
 #
 # Makefile for Bosch BMI323 IMU
 #
+
+CONTEXT_ANALYSIS := y
+
 obj-$(CONFIG_BMI323) += bmi323_core.o
 obj-$(CONFIG_BMI323_I2C) += bmi323_i2c.o
 obj-$(CONFIG_BMI323_SPI) += bmi323_spi.o
diff --git a/drivers/iio/imu/bno055/Makefile b/drivers/iio/imu/bno055/Makefile
index 98c624730dae..8ecf24be7954 100644
--- a/drivers/iio/imu/bno055/Makefile
+++ b/drivers/iio/imu/bno055/Makefile
@@ -1,5 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 
+CONTEXT_ANALYSIS := y
+
 obj-$(CONFIG_BOSCH_BNO055) += bno055.o
 obj-$(CONFIG_BOSCH_BNO055_SERIAL) += bno055_ser.o
 bno055_ser-y := bno055_ser_core.o
diff --git a/drivers/iio/imu/inv_icm42600/Makefile b/drivers/iio/imu/inv_icm42600/Makefile
index 0f49f6df3647..9b6ddbce713d 100644
--- a/drivers/iio/imu/inv_icm42600/Makefile
+++ b/drivers/iio/imu/inv_icm42600/Makefile
@@ -1,5 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-or-later
 
+CONTEXT_ANALYSIS := y
+
 obj-$(CONFIG_INV_ICM42600) += inv-icm42600.o
 inv-icm42600-y += inv_icm42600_core.o
 inv-icm42600-y += inv_icm42600_gyro.o
diff --git a/drivers/iio/imu/inv_icm42607/Makefile b/drivers/iio/imu/inv_icm42607/Makefile
index 7b907e019601..4f19ebe08f88 100644
--- a/drivers/iio/imu/inv_icm42607/Makefile
+++ b/drivers/iio/imu/inv_icm42607/Makefile
@@ -1,5 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-or-later
 
+CONTEXT_ANALYSIS := y
+
 obj-$(CONFIG_INV_ICM42607) += inv-icm42607.o
 inv-icm42607-y += inv_icm42607_core.o
 inv-icm42607-y += inv_icm42607_gyro.o
diff --git a/drivers/iio/imu/inv_icm45600/Makefile b/drivers/iio/imu/inv_icm45600/Makefile
index c98b8365b467..b5aaa00ba3b3 100644
--- a/drivers/iio/imu/inv_icm45600/Makefile
+++ b/drivers/iio/imu/inv_icm45600/Makefile
@@ -1,5 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-or-later
 
+CONTEXT_ANALYSIS := y
+
 obj-$(CONFIG_INV_ICM45600) += inv-icm45600.o
 inv-icm45600-y += inv_icm45600_core.o
 inv-icm45600-y += inv_icm45600_buffer.o
diff --git a/drivers/iio/imu/inv_mpu6050/Makefile b/drivers/iio/imu/inv_mpu6050/Makefile
index c103441a906b..7c89414e1452 100644
--- a/drivers/iio/imu/inv_mpu6050/Makefile
+++ b/drivers/iio/imu/inv_mpu6050/Makefile
@@ -3,6 +3,8 @@
 # Makefile for Invensense MPU6050 device.
 #
 
+CONTEXT_ANALYSIS := y
+
 obj-$(CONFIG_INV_MPU6050_IIO) += inv-mpu6050.o
 inv-mpu6050-y := inv_mpu_core.o inv_mpu_ring.o inv_mpu_trigger.o \
 		 inv_mpu_aux.o inv_mpu_magn.o
diff --git a/drivers/iio/imu/smi330/Makefile b/drivers/iio/imu/smi330/Makefile
index c663dcb5a9f2..90e0977133e9 100644
--- a/drivers/iio/imu/smi330/Makefile
+++ b/drivers/iio/imu/smi330/Makefile
@@ -2,6 +2,9 @@
 #
 # Makefile for Bosch SMI330 IMU
 #
+
+CONTEXT_ANALYSIS := y
+
 obj-$(CONFIG_SMI330) += smi330_core.o
 obj-$(CONFIG_SMI330_I2C) += smi330_i2c.o
 obj-$(CONFIG_SMI330_SPI) += smi330_spi.o
diff --git a/drivers/iio/imu/st_lsm6dsx/Makefile b/drivers/iio/imu/st_lsm6dsx/Makefile
index 19a488254de3..11b8ab9adac2 100644
--- a/drivers/iio/imu/st_lsm6dsx/Makefile
+++ b/drivers/iio/imu/st_lsm6dsx/Makefile
@@ -1,4 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
+
+CONTEXT_ANALYSIS := y
+
 st_lsm6dsx-y := st_lsm6dsx_core.o st_lsm6dsx_buffer.o \
 		st_lsm6dsx_shub.o st_lsm6dsx_fusion.o
 
diff --git a/drivers/iio/imu/st_lsm9ds0/Makefile b/drivers/iio/imu/st_lsm9ds0/Makefile
index 488af523f648..6326718f7e25 100644
--- a/drivers/iio/imu/st_lsm9ds0/Makefile
+++ b/drivers/iio/imu/st_lsm9ds0/Makefile
@@ -1,4 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
+
+CONTEXT_ANALYSIS := y
+
 obj-$(CONFIG_IIO_ST_LSM9DS0) += st_lsm9ds0.o
 st_lsm9ds0-y := st_lsm9ds0_core.o
 obj-$(CONFIG_IIO_ST_LSM9DS0_I2C) += st_lsm9ds0_i2c.o
diff --git a/drivers/iio/light/Makefile b/drivers/iio/light/Makefile
index 6672ed01a819..5db5ab99f63f 100644
--- a/drivers/iio/light/Makefile
+++ b/drivers/iio/light/Makefile
@@ -3,6 +3,8 @@
 # Makefile for IIO Light sensors
 #
 
+CONTEXT_ANALYSIS := y
+
 # When adding new entries keep the list in alphabetical order
 obj-$(CONFIG_ACPI_ALS)		+= acpi-als.o
 obj-$(CONFIG_ADJD_S311)		+= adjd_s311.o
diff --git a/drivers/iio/magnetometer/Makefile b/drivers/iio/magnetometer/Makefile
index 8f2205975c1b..b85de8718ce4 100644
--- a/drivers/iio/magnetometer/Makefile
+++ b/drivers/iio/magnetometer/Makefile
@@ -3,6 +3,8 @@
 # Makefile for industrial I/O Magnetometer sensor drivers
 #
 
+CONTEXT_ANALYSIS := y
+
 # When adding new entries keep the list in alphabetical order
 obj-$(CONFIG_AF8133J)	+= af8133j.o
 obj-$(CONFIG_AK8974)	+= ak8974.o
diff --git a/drivers/iio/multiplexer/Makefile b/drivers/iio/multiplexer/Makefile
index f069ab781d95..7a2261b2f8b1 100644
--- a/drivers/iio/multiplexer/Makefile
+++ b/drivers/iio/multiplexer/Makefile
@@ -3,5 +3,7 @@
 # Makefile for industrial I/O multiplexer drivers
 #
 
+CONTEXT_ANALYSIS := y
+
 # When adding new entries keep the list in alphabetical order
 obj-$(CONFIG_IIO_MUX) += iio-mux.o
diff --git a/drivers/iio/orientation/Makefile b/drivers/iio/orientation/Makefile
index 7800ed293a9a..3bfa01d483da 100644
--- a/drivers/iio/orientation/Makefile
+++ b/drivers/iio/orientation/Makefile
@@ -3,6 +3,8 @@
 # Makefile for industrial I/O Inclinometer sensor drivers
 #
 
+CONTEXT_ANALYSIS := y
+
 # When adding new entries keep the list in alphabetical order
 obj-$(CONFIG_HID_SENSOR_INCLINOMETER_3D) += hid-sensor-incl-3d.o
 obj-$(CONFIG_HID_SENSOR_DEVICE_ROTATION) += hid-sensor-rotation.o
diff --git a/drivers/iio/position/Makefile b/drivers/iio/position/Makefile
index d70902f2979d..0b61f33bbee8 100644
--- a/drivers/iio/position/Makefile
+++ b/drivers/iio/position/Makefile
@@ -2,6 +2,8 @@
 # Makefile for IIO linear and angular position sensors
 #
 
+CONTEXT_ANALYSIS := y
+
 # When adding new entries keep the list in alphabetical order
 
 obj-$(CONFIG_HID_SENSOR_CUSTOM_INTEL_HINGE) += hid-sensor-custom-intel-hinge.o
diff --git a/drivers/iio/potentiometer/Makefile b/drivers/iio/potentiometer/Makefile
index d11fb739176c..5cf55d9501c0 100644
--- a/drivers/iio/potentiometer/Makefile
+++ b/drivers/iio/potentiometer/Makefile
@@ -3,6 +3,8 @@
 # Makefile for industrial I/O potentiometer drivers
 #
 
+CONTEXT_ANALYSIS := y
+
 # When adding new entries keep the list in alphabetical order
 obj-$(CONFIG_AD5110) += ad5110.o
 obj-$(CONFIG_AD5272) += ad5272.o
diff --git a/drivers/iio/potentiostat/Makefile b/drivers/iio/potentiostat/Makefile
index be78b46acbab..a3e5d78cf809 100644
--- a/drivers/iio/potentiostat/Makefile
+++ b/drivers/iio/potentiostat/Makefile
@@ -3,5 +3,7 @@
 # Makefile for industrial I/O potentiostat drivers
 #
 
+CONTEXT_ANALYSIS := y
+
 # When adding new entries keep the list in alphabetical order
 obj-$(CONFIG_LMP91000) += lmp91000.o
diff --git a/drivers/iio/pressure/Makefile b/drivers/iio/pressure/Makefile
index a3b57bdd5b3e..861f5622a44f 100644
--- a/drivers/iio/pressure/Makefile
+++ b/drivers/iio/pressure/Makefile
@@ -3,7 +3,7 @@
 # Makefile for industrial I/O pressure drivers
 #
 
-CONTEXT_ANALYSIS_dps310.o := y
+CONTEXT_ANALYSIS := y
 
 # When adding new entries keep the list in alphabetical order
 obj-$(CONFIG_ABP060MG) += abp060mg.o
diff --git a/drivers/iio/proximity/Makefile b/drivers/iio/proximity/Makefile
index 8a65e42fbea0..88b19778252b 100644
--- a/drivers/iio/proximity/Makefile
+++ b/drivers/iio/proximity/Makefile
@@ -3,6 +3,8 @@
 # Makefile for IIO proximity sensors
 #
 
+CONTEXT_ANALYSIS := y
+
 # When adding new entries keep the list in alphabetical order
 obj-$(CONFIG_AS3935)		+= as3935.o
 obj-$(CONFIG_CROS_EC_MKBP_PROXIMITY) += cros_ec_mkbp_proximity.o
diff --git a/drivers/iio/resolver/Makefile b/drivers/iio/resolver/Makefile
index 7f6c876c35ae..28aeef65fb6d 100644
--- a/drivers/iio/resolver/Makefile
+++ b/drivers/iio/resolver/Makefile
@@ -3,6 +3,8 @@
 # Makefile for Resolver/Synchro drivers
 #
 
+CONTEXT_ANALYSIS := y
+
 obj-$(CONFIG_AD2S90) += ad2s90.o
 obj-$(CONFIG_AD2S1200) += ad2s1200.o
 obj-$(CONFIG_AD2S1210) += ad2s1210.o
diff --git a/drivers/iio/sensorhubs/osf/Makefile b/drivers/iio/sensorhubs/osf/Makefile
index b4e03b80cfa4..da98e9b27577 100644
--- a/drivers/iio/sensorhubs/osf/Makefile
+++ b/drivers/iio/sensorhubs/osf/Makefile
@@ -1,5 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 
+CONTEXT_ANALYSIS := y
+
 obj-$(CONFIG_OPEN_SENSOR_FUSION) += open-sensor-fusion.o
 
 open-sensor-fusion-y := osf_core.o osf_iio.o osf_protocol.o osf_serdev.o \
diff --git a/drivers/iio/temperature/Makefile b/drivers/iio/temperature/Makefile
index 0850bf691820..69a084f0a18a 100644
--- a/drivers/iio/temperature/Makefile
+++ b/drivers/iio/temperature/Makefile
@@ -3,6 +3,8 @@
 # Makefile for industrial I/O temperature drivers
 #
 
+CONTEXT_ANALYSIS := y
+
 obj-$(CONFIG_IQS620AT_TEMP) += iqs620at-temp.o
 obj-$(CONFIG_LTC2983) += ltc2983.o
 obj-$(CONFIG_HID_SENSOR_TEMP) += hid-sensor-temperature.o
diff --git a/drivers/iio/test/Makefile b/drivers/iio/test/Makefile
index ba08afa7f3f2..a7222f878a94 100644
--- a/drivers/iio/test/Makefile
+++ b/drivers/iio/test/Makefile
@@ -3,6 +3,8 @@
 # Makefile for the industrial I/O unit tests.
 #
 
+CONTEXT_ANALYSIS := y
+
 # Keep in alphabetical order
 obj-$(CONFIG_IIO_CHANNEL_PREFIX_KUNIT_TEST) += iio-test-channel-prefix.o
 obj-$(CONFIG_IIO_RESCALE_KUNIT_TEST) += iio-test-rescale.o
diff --git a/drivers/iio/trigger/Makefile b/drivers/iio/trigger/Makefile
index fc1fd5661c94..6eb16f37df15 100644
--- a/drivers/iio/trigger/Makefile
+++ b/drivers/iio/trigger/Makefile
@@ -3,6 +3,8 @@
 # Makefile for triggers not associated with iio-devices
 #
 
+CONTEXT_ANALYSIS := y
+
 # When adding new entries keep the list in alphabetical order
 
 obj-$(CONFIG_IIO_HRTIMER_TRIGGER) += iio-trig-hrtimer.o
-- 
2.43.0

