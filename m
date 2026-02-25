Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C254311587
	for <linux-iio@vger.kernel.org>; Wed, 25 Feb 2026 10:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772013869; cv=none; b=TjWsoEL+ij1ydvjAJOi00pfFMH8bXqWjdENqdgDD1pFMz+fqGJJlVaRKqPJb1N3Z/IgOeyiOVzimPDdlRd9d4vyOhlqBhNzkKTcWNPVl/q+MtIIPQOfl4fuSF/E2fesp6+lrTMB0J8u2qdGXRPyGjNvIBdDMEHGZJ80rq8i1Uzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772013869; c=relaxed/simple;
	bh=ZkL2o7BktGvzrmJePa+npAaaCtncxdxuOVMqI5NMBeY=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=FV8LzjhZzQalmCu7O18chZ8XUsddNZLTshRYI+gllp+pAdgyR8gDidFGuED0eISLNL5SSHFRWd8hSUBn08pok1wXszd91NJ4qr0zI6FIb1dg/ibFQVDNwItRkzUScmtiVFx0bnZgTywDSmebkUv0w0Fnwdq+b8CJZuovGIQiSdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=foWWOu66; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="foWWOu66"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-43990ea3fbcso220045f8f.0
        for <linux-iio@vger.kernel.org>; Wed, 25 Feb 2026 02:04:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1772013863; x=1772618663; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=qjLZMylM1cyDL55PBfY1+GNEZo0/hIKFgQASoXd3iFw=;
        b=foWWOu66DpEvnIhLQq/gX3YXU6Q4J4t78yICjr55mewv2NHwpukzm5DP4XuCKwcQw7
         0hjNgtqQa0KOrgM/9UZIMzPw6SazQ2PEPGp6jRTYDApZrP8uYYX1F1RukQwtGIR1CRXK
         9FochpoNVw7miHYFI/nACHRllLA75X2onj7uzsBgk57L5hGFtkodxWsfpwX1ZwqqRnT9
         TuG+qAGBeTNNBsqu6orzltLvKLKTZk96pjy0WMT+AIITZNS+r+y/LFsnliIZpZqyNJWJ
         o/h9IRwvzkXQmI5aw01V3SX5cQ9YVJ+ntYgJhs1w30i1Q/CT2KVXql8Ig+jKk43Zw4qp
         JusQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772013863; x=1772618663;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qjLZMylM1cyDL55PBfY1+GNEZo0/hIKFgQASoXd3iFw=;
        b=RurrH6fzoWR4SGlXNtCHog+ZXMj/7SSrbpGhPL4E7tFk5k0fNMLigGTHAo9DHiWxwK
         rfBn8z39uPYe5MdR8+wtTSApqVX+RksAN1689VMhTNkPbuaeixrbfQoTDxTJFS6Dt8n0
         xD05OllaB/vpTnPyWfa7sJ7D1Ry/+JO224qc24+iL6U5m/BMMXYun8bWeSmbMov2BId6
         YiuPG21wepNlD+evrekgl6VYaSnutRhgEU+E4jDJxLZjXvH5S3HGItfg/f07m1UZrbAx
         uccG5R8z25t40fCD08SVqmq95E7oWOfDvlaPB7fiA001HuX/qWSSzkDwp0aAq//38PLc
         ctGg==
X-Forwarded-Encrypted: i=1; AJvYcCXqaoB3LMM3xdV2JSi976tOfdetZMXdvXuB5gy6YO4D6dQUV2DWXgXD4klbsIgZre9chPk38RFAMOo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyT7ws6VQWnuLtc1lq0PM2A6popi4yv/jd8LIuajEnLc1SdxpyG
	gKu3zWCTcAiAPB7l3INFn8Zc9pIf48IX/+Keyqm1UJkolVihxQhZtqvLd0V55/ujL0I=
X-Gm-Gg: ATEYQzyfL5p6ckw8JLtCuSkA3pBF5fB8QiNs3PVdtJbHmsie4JitUxISH0iLzHRBfbM
	uCctpJ/XRd96th4VlRmGMpOxJ7TH5er2jYKAAaUS28ek01QQvhzqLGQTqQFlu5RSLzpsj1iBimN
	qO2sCQf4dFbj86jUM1iBZkfljgQkz1VQc2doGwTM/p+4JcfM077TpVh/ufrw1yCkaQPwibCH6GD
	imTH6acwgCAXEvU7VX2wDZnsDghJ99FhvQHtbOYFZCNpeWf3Q4eUZ003QuahSJ6WMPY+Lq7oEbX
	Jw8a8Mm9gQoY0p0aMO15aPVJ6r3OzCPG0MCpE09QN2PodtQSKdg57mAD7n4rS5T0oHcsiqIj6fS
	QQT86q6p8VjboMuGI3zgGTNEjbyqVB2GkQFQagTqEp0QCFbYh2mhcv4iZcTvClq09N7A2DQ==
X-Received: by 2002:a05:6000:2204:b0:436:e875:7911 with SMTP id ffacd0b85a97d-4398d82aa41mr5244554f8f.4.1772013863238;
        Wed, 25 Feb 2026 02:04:23 -0800 (PST)
Received: from localhost ([151.35.220.155])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43970d4c977sm35268178f8f.32.2026.02.25.02.04.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 02:04:22 -0800 (PST)
From: Francesco Lavra <flavra@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 0/7] imu: st_lsm6dsx: Add support for rotation sensor
Date: Wed, 25 Feb 2026 11:04:21 +0100
Message-Id: <20260225100421.2366864-1-flavra@baylibre.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=18227; i=flavra@baylibre.com; h=from:subject; bh=ZkL2o7BktGvzrmJePa+npAaaCtncxdxuOVMqI5NMBeY=; b=owEB7QES/pANAwAKAe3xO3POlDZfAcsmYgBpnsj0rxkYJAtN3m2lzDsn6p4e4Mgl5tDMnOS+d t3cvIIGyySJAbMEAAEKAB0WIQSGV4VPlTvcox7DFObt8TtzzpQ2XwUCaZ7I9AAKCRDt8TtzzpQ2 X2HvC/9yG8k79H0P3dvyU2GFB/w/0eevGhUI5ybr8S0+tfm7bA6DDk5+i3q2Kv+My6lqSVal944 8jKyTiT+JpaYqLxy8tF48AIOv+Uu7g2ebXfA6EsLkQLhExWEl1RqRps3AUExA4Hn8e6CHiA/Jn7 sGdL37o/3C2XDo7UjSt0LkA7lAugvq5DlOW8UdH1SpIJxBRgPLIU5IS97g+mc9jPNdu0c7Xjb+a GRAD6M9im0bArD/0JTSycpzecuTEt5GzDG3qFIIwNVGicUp2gpUNLo5DAiGoeYOj9t+mepLnvgC aW9t/mjn16ddMt0bcd0mnR+qcE/AzeKEmnP+nDsB3aYW2wipZAO849op7UkE01eNMMW5ZFS2dwc FakqbL4hF3IyvfYDHh79quNNYEQAywtqv1J7c2VrgxDYX4bWd1v9t+K2+Y8F1hi8aqn3DKzfxIg gUAWYBUN7VW8TRUiGwqUgElCCwiCtguUu83w6QeNN0wYzUOeL2HiM/9kWygVng7h/4gNw=
X-Developer-Key: i=flavra@baylibre.com; a=openpgp; fpr=8657854F953BDCA31EC314E6EDF13B73CE94365F
Content-Transfer-Encoding: 8bit

This series adds support for the rotation sensor functionality present in
some chips from the ST LSM6DSX IMU family.
The IIO ABI has been amended to allow the use of floating-point data and
custom (driver-specific) channels in IIO buffers.
Tested on LSM6DSV16X.

Changes from v5 [5]:
- cleaned up FIFO data representation in st_lsm6dsx_read_tagged_fifo() to
  avoid casting (Andy, Jonathan)
- renamed 'sign' field to `format` in struct iio_scan_type
- added support for IEEE 754 floating-point format in buffer scan elements
- added custom data type in the ABI (IIO_CUSTOM in enum iio_chan_type)
  (Jonathan)
- added driver document in Documentation/iio/ (Jonathan)

Changes from v4 [4]:
- changed data parameter in st_lsm6dsx_push_tagged_data() to __le16 *
  (Andy)

Changes from v3 [3]:
- added patch 3 (Andy)
- removed unneeded checks for negative return values in st_lsm6dsx_fusion.c
  (Andy)
- replaced st_lsm6dsx_sf_set_page function with
  st_lsm6dsx_sf_page_enable/disable (Andy)
- used reversed xmas tree ordering for local variables (Andy)
- added parentheses to MILLI / MICRO in st_lsm6dsx_sf_write_raw (Andy)
- added check for string truncation in st_lsm6dsx_sf_probe (Andy)

Changes from v2 [2]:
- amended description of patch 2 to point out that there are no supported
  gyro events (Jonathan)
- removed superfluous parentheses in st_lsm6dsx_fifo_setup (Lorenzo)
- added Lorenzo's acked-by tag to patch 3
- added missing checks of st_lsm6dsx_sf_set_page() return value (Jonathan)
- added comment in st_lsm6dsx_sf_write_raw (Jonathan)

Changes from v1 [1]:
- swapped patches 1 and 2 (Jonathan)
- miscellaneous stylistic changes (Andy)
- fixed usage of MICRO and MILLI constants in st_lsm6dsx_sf_read_raw and
  st_lsm6dsx_sf_write_raw (Andy)
- replaced scnprintf() with sysfs_emit_at() in
  st_lsm6dsx_sf_sampling_freq_avail (Andy)
- replaced scnprintf() with snprintf() in st_lsm6dsx_sf_probe (Andy)
- clarified in a comment in st_lsm6dsx_set_fifo_odr() that only internal
  sensors have a FIFO ODR configuration register (Jonathan)
- modified patch 3 description to explain justification for the extra IIO
  device (Jonathan)
- moved page lock from st_lsm6dsx_sf_set_page() to the callers (Jonathan)
- s/magnetometer/gyroscope/ in patch 2 description

[1] https://lore.kernel.org/linux-iio/20260109181528.154127-1-flavra@baylibre.com/T/
[2] https://lore.kernel.org/linux-iio/20260115122431.1014630-1-flavra@baylibre.com/T/
[3] https://lore.kernel.org/linux-iio/20260119100449.1559624-1-flavra@baylibre.com/T/
[4] https://lore.kernel.org/linux-iio/20260121112758.1831077-1-flavra@baylibre.com/T/
[5] https://lore.kernel.org/linux-iio/20260122162335.2020006-1-flavra@baylibre.com/T/

Francesco Lavra (7):
  iio: imu: st_lsm6dsx: Set FIFO ODR for accelerometer and gyroscope
    only
  iio: imu: st_lsm6dsx: Set buffer sampling frequency for accelerometer
    only
  iio: imu: st_lsm6dsx: Fix check for invalid samples from FIFO
  iio: Rename 'sign' field to `format` in struct iio_scan_type
  iio: ABI: Add support for floating-point numbers in buffer scan
    elements
  iio: ABI: Add custom data type
  iio: imu: st_lsm6dsx: Add support for rotation sensor

 Documentation/ABI/testing/sysfs-bus-iio       |  52 ++--
 Documentation/driver-api/iio/buffers.rst      |   9 +-
 Documentation/iio/iio_devbuf.rst              |   3 +-
 drivers/iio/accel/adxl313_core.c              |   2 +-
 drivers/iio/accel/adxl345_core.c              |   2 +-
 drivers/iio/accel/adxl355_core.c              |   4 +-
 drivers/iio/accel/adxl367.c                   |   4 +-
 drivers/iio/accel/adxl372.c                   |   2 +-
 drivers/iio/accel/adxl380.c                   |   4 +-
 drivers/iio/accel/bma180.c                    |  10 +-
 drivers/iio/accel/bma220_core.c               |   2 +-
 drivers/iio/accel/bma400_core.c               |   4 +-
 drivers/iio/accel/bmc150-accel-core.c         |   2 +-
 drivers/iio/accel/cros_ec_accel_legacy.c      |   2 +-
 drivers/iio/accel/fxls8962af-core.c           |   4 +-
 drivers/iio/accel/hid-sensor-accel-3d.c       |   2 +-
 drivers/iio/accel/kionix-kx022a.c             |   2 +-
 drivers/iio/accel/kxcjk-1013.c                |   2 +-
 drivers/iio/accel/kxsd9.c                     |   4 +-
 drivers/iio/accel/mma7455_core.c              |   2 +-
 drivers/iio/accel/mma8452.c                   |   4 +-
 drivers/iio/accel/msa311.c                    |   2 +-
 drivers/iio/accel/mxc4005.c                   |   2 +-
 drivers/iio/accel/sca3000.c                   |   4 +-
 drivers/iio/accel/sca3300.c                   |   6 +-
 drivers/iio/accel/stk8312.c                   |   2 +-
 drivers/iio/accel/stk8ba50.c                  |   2 +-
 drivers/iio/adc/ad4000.c                      |   8 +-
 drivers/iio/adc/ad4030.c                      |  10 +-
 drivers/iio/adc/ad4062.c                      |   8 +-
 drivers/iio/adc/ad4080.c                      |   2 +-
 drivers/iio/adc/ad4130.c                      |   2 +-
 drivers/iio/adc/ad4170-4.c                    |  12 +-
 drivers/iio/adc/ad4695.c                      |  24 +-
 drivers/iio/adc/ad4851.c                      |  12 +-
 drivers/iio/adc/ad7124.c                      |   4 +-
 drivers/iio/adc/ad7173.c                      |   6 +-
 drivers/iio/adc/ad7191.c                      |   6 +-
 drivers/iio/adc/ad7192.c                      |   2 +-
 drivers/iio/adc/ad7266.c                      |   6 +-
 drivers/iio/adc/ad7280a.c                     |   4 +-
 drivers/iio/adc/ad7298.c                      |   4 +-
 drivers/iio/adc/ad7380.c                      |  44 ++--
 drivers/iio/adc/ad7405.c                      |   2 +-
 drivers/iio/adc/ad7476.c                      |   2 +-
 drivers/iio/adc/ad7606.c                      |  14 +-
 drivers/iio/adc/ad7625.c                      |   2 +-
 drivers/iio/adc/ad7766.c                      |   2 +-
 drivers/iio/adc/ad7768-1.c                    |   8 +-
 drivers/iio/adc/ad7779.c                      |   2 +-
 drivers/iio/adc/ad7780.c                      |   2 +-
 drivers/iio/adc/ad7791.c                      |   2 +-
 drivers/iio/adc/ad7793.c                      |   2 +-
 drivers/iio/adc/ad7887.c                      |   2 +-
 drivers/iio/adc/ad7923.c                      |   2 +-
 drivers/iio/adc/ad7944.c                      |   8 +-
 drivers/iio/adc/ad799x.c                      |   2 +-
 drivers/iio/adc/ad9467.c                      |   4 +-
 drivers/iio/adc/ade9000.c                     |   4 +-
 drivers/iio/adc/at91-sama5d2_adc.c            |  10 +-
 drivers/iio/adc/at91_adc.c                    |   4 +-
 drivers/iio/adc/cc10001_adc.c                 |   4 +-
 drivers/iio/adc/cpcap-adc.c                   |   2 +-
 drivers/iio/adc/dln2-adc.c                    |   4 +-
 drivers/iio/adc/hx711.c                       |   4 +-
 drivers/iio/adc/ina2xx-adc.c                  |   8 +-
 drivers/iio/adc/ingenic-adc.c                 |  12 +-
 drivers/iio/adc/max1027.c                     |   4 +-
 drivers/iio/adc/max1118.c                     |   2 +-
 drivers/iio/adc/max11205.c                    |   2 +-
 drivers/iio/adc/max11410.c                    |   2 +-
 drivers/iio/adc/max1363.c                     |   4 +-
 drivers/iio/adc/mcp3911.c                     |   2 +-
 drivers/iio/adc/mt6359-auxadc.c               |   2 +-
 drivers/iio/adc/mt6360-adc.c                  |   2 +-
 drivers/iio/adc/mxs-lradc-adc.c               |   6 +-
 drivers/iio/adc/nxp-sar-adc.c                 |   2 +-
 drivers/iio/adc/pac1921.c                     |   8 +-
 drivers/iio/adc/pac1934.c                     |  32 +--
 drivers/iio/adc/rockchip_saradc.c             |   2 +-
 drivers/iio/adc/rtq6056.c                     |  16 +-
 drivers/iio/adc/sd_adc_modulator.c            |   2 +-
 drivers/iio/adc/stm32-adc.c                   |   4 +-
 drivers/iio/adc/stm32-dfsdm-adc.c             |   2 +-
 drivers/iio/adc/ti-adc081c.c                  |   2 +-
 drivers/iio/adc/ti-adc0832.c                  |   4 +-
 drivers/iio/adc/ti-adc084s021.c               |   2 +-
 drivers/iio/adc/ti-adc108s102.c               |   2 +-
 drivers/iio/adc/ti-adc12138.c                 |   4 +-
 drivers/iio/adc/ti-adc161s626.c               |   4 +-
 drivers/iio/adc/ti-ads1015.c                  |   4 +-
 drivers/iio/adc/ti-ads1018.c                  |   6 +-
 drivers/iio/adc/ti-ads1100.c                  |   2 +-
 drivers/iio/adc/ti-ads1119.c                  |   2 +-
 drivers/iio/adc/ti-ads124s08.c                |   2 +-
 drivers/iio/adc/ti-ads1298.c                  |   2 +-
 drivers/iio/adc/ti-ads131e08.c                |   2 +-
 drivers/iio/adc/ti-ads7950.c                  |   2 +-
 drivers/iio/adc/ti-ads8688.c                  |   2 +-
 drivers/iio/adc/ti-lmp92064.c                 |   4 +-
 drivers/iio/adc/ti-tlc4541.c                  |   2 +-
 drivers/iio/adc/ti-tsc2046.c                  |   2 +-
 drivers/iio/adc/ti_am335x_adc.c               |   2 +-
 drivers/iio/adc/vf610_adc.c                   |   4 +-
 drivers/iio/adc/xilinx-ams.c                  |   2 +-
 drivers/iio/adc/xilinx-xadc-core.c            |  10 +-
 drivers/iio/addac/ad74115.c                   |   2 +-
 drivers/iio/addac/ad74413r.c                  |   2 +-
 drivers/iio/chemical/atlas-ezo-sensor.c       |   4 +-
 drivers/iio/chemical/atlas-sensor.c           |  12 +-
 drivers/iio/chemical/bme680_core.c            |   8 +-
 drivers/iio/chemical/ccs811.c                 |   4 +-
 drivers/iio/chemical/ens160_core.c            |   4 +-
 drivers/iio/chemical/pms7003.c                |   2 +-
 drivers/iio/chemical/scd30_core.c             |   2 +-
 drivers/iio/chemical/scd4x.c                  |   6 +-
 drivers/iio/chemical/sps30.c                  |   2 +-
 .../common/cros_ec_sensors/cros_ec_activity.c |   2 +-
 .../cros_ec_sensors/cros_ec_lid_angle.c       |   2 +-
 .../common/cros_ec_sensors/cros_ec_sensors.c  |   4 +-
 drivers/iio/common/scmi_sensors/scmi_iio.c    |   4 +-
 .../iio/common/ssp_sensors/ssp_iio_sensor.h   |   4 +-
 drivers/iio/dac/ad3552r-hs.c                  |   2 +-
 drivers/iio/dac/ad3552r.c                     |   2 +-
 drivers/iio/dac/ad5064.c                      |   2 +-
 drivers/iio/dac/ad5360.c                      |   2 +-
 drivers/iio/dac/ad5380.c                      |   2 +-
 drivers/iio/dac/ad5421.c                      |   2 +-
 drivers/iio/dac/ad5446.h                      |   2 +-
 drivers/iio/dac/ad5449.c                      |   2 +-
 drivers/iio/dac/ad5504.c                      |   2 +-
 drivers/iio/dac/ad5592r-base.c                |   2 +-
 drivers/iio/dac/ad5624r_spi.c                 |   2 +-
 drivers/iio/dac/ad5686.c                      |   2 +-
 drivers/iio/dac/ad5755.c                      |   2 +-
 drivers/iio/dac/ad5761.c                      |   2 +-
 drivers/iio/dac/ad5764.c                      |   2 +-
 drivers/iio/dac/ad5766.c                      |   2 +-
 drivers/iio/dac/ad5791.c                      |   4 +-
 drivers/iio/dac/ad7303.c                      |   2 +-
 drivers/iio/dac/ad8460.c                      |   2 +-
 drivers/iio/dac/ad9739a.c                     |   2 +-
 drivers/iio/dac/ltc1660.c                     |   2 +-
 drivers/iio/dac/max5522.c                     |   2 +-
 drivers/iio/dac/mcp4922.c                     |   2 +-
 drivers/iio/dac/stm32-dac.c                   |   2 +-
 drivers/iio/dummy/iio_simple_dummy.c          |   8 +-
 drivers/iio/gyro/adis16136.c                  |   4 +-
 drivers/iio/gyro/adxrs290.c                   |   4 +-
 drivers/iio/gyro/bmg160_core.c                |   2 +-
 drivers/iio/gyro/fxas21002c_core.c            |   2 +-
 drivers/iio/gyro/hid-sensor-gyro-3d.c         |   2 +-
 drivers/iio/gyro/itg3200_core.c               |   2 +-
 drivers/iio/gyro/mpu3050-core.c               |   4 +-
 drivers/iio/health/afe440x.h                  |   2 +-
 drivers/iio/health/max30100.c                 |   4 +-
 drivers/iio/health/max30102.c                 |   2 +-
 drivers/iio/humidity/am2315.c                 |   4 +-
 drivers/iio/humidity/hdc100x.c                |   4 +-
 drivers/iio/humidity/hid-sensor-humidity.c    |   2 +-
 drivers/iio/humidity/hts221_core.c            |   4 +-
 drivers/iio/imu/adis.c                        |   2 +-
 drivers/iio/imu/adis16400.c                   |  16 +-
 drivers/iio/imu/adis16460.c                   |   4 +-
 drivers/iio/imu/adis16475.c                   |   6 +-
 drivers/iio/imu/adis16480.c                   |   6 +-
 drivers/iio/imu/adis16550.c                   |   6 +-
 drivers/iio/imu/bmi160/bmi160_core.c          |   2 +-
 drivers/iio/imu/bmi270/bmi270_core.c          |   4 +-
 drivers/iio/imu/bmi323/bmi323_core.c          |   4 +-
 drivers/iio/imu/bno055/bno055.c               |   2 +-
 .../iio/imu/inv_icm42600/inv_icm42600_accel.c |   2 +-
 .../iio/imu/inv_icm42600/inv_icm42600_gyro.c  |   2 +-
 .../iio/imu/inv_icm42600/inv_icm42600_temp.h  |   2 +-
 drivers/iio/imu/inv_icm45600/inv_icm45600.h   |   2 +-
 .../iio/imu/inv_icm45600/inv_icm45600_accel.c |   2 +-
 .../iio/imu/inv_icm45600/inv_icm45600_gyro.c  |   2 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c    |   6 +-
 drivers/iio/imu/kmx61.c                       |   4 +-
 drivers/iio/imu/smi240.c                      |   4 +-
 drivers/iio/imu/smi330/smi330_core.c          |   6 +-
 drivers/iio/imu/st_lsm6dsx/Makefile           |   2 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h       |  30 ++-
 .../iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c    |  45 +++-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c  |  58 +++++
 .../iio/imu/st_lsm6dsx/st_lsm6dsx_fusion.c    | 235 ++++++++++++++++++
 drivers/iio/industrialio-buffer.c             |   4 +-
 drivers/iio/industrialio-core.c               |   1 +
 drivers/iio/light/acpi-als.c                  |   2 +-
 drivers/iio/light/adjd_s311.c                 |   2 +-
 drivers/iio/light/apds9960.c                  |   2 +-
 drivers/iio/light/as73211.c                   |   6 +-
 drivers/iio/light/bh1745.c                    |   2 +-
 drivers/iio/light/cros_ec_light_prox.c        |   4 +-
 drivers/iio/light/gp2ap020a00f.c              |   6 +-
 drivers/iio/light/hid-sensor-als.c            |   2 +-
 drivers/iio/light/hid-sensor-prox.c           |   2 +-
 drivers/iio/light/isl29125.c                  |   2 +-
 drivers/iio/light/ltr501.c                    |   4 +-
 drivers/iio/light/max44000.c                  |   4 +-
 drivers/iio/light/opt4060.c                   |   4 +-
 drivers/iio/light/rohm-bu27034.c              |   4 +-
 drivers/iio/light/rpr0521.c                   |   6 +-
 drivers/iio/light/si1145.c                    |   2 +-
 drivers/iio/light/st_uvis25_core.c            |   2 +-
 drivers/iio/light/tcs3414.c                   |   2 +-
 drivers/iio/light/tcs3472.c                   |   2 +-
 drivers/iio/light/vcnl4000.c                  |   2 +-
 drivers/iio/light/vcnl4035.c                  |   4 +-
 drivers/iio/light/veml6030.c                  |   8 +-
 drivers/iio/light/veml6046x00.c               |   8 +-
 drivers/iio/light/vl6180.c                    |   6 +-
 drivers/iio/magnetometer/af8133j.c            |   2 +-
 drivers/iio/magnetometer/ak8974.c             |   2 +-
 drivers/iio/magnetometer/ak8975.c             |   2 +-
 drivers/iio/magnetometer/als31300.c           |   4 +-
 drivers/iio/magnetometer/bmc150_magn.c        |   2 +-
 drivers/iio/magnetometer/hid-sensor-magn-3d.c |   2 +-
 drivers/iio/magnetometer/hmc5843_core.c       |   4 +-
 drivers/iio/magnetometer/mag3110.c            |   4 +-
 drivers/iio/magnetometer/rm3100-core.c        |   2 +-
 drivers/iio/magnetometer/tlv493d.c            |   4 +-
 drivers/iio/magnetometer/tmag5273.c           |   8 +-
 drivers/iio/magnetometer/yamaha-yas530.c      |   4 +-
 drivers/iio/orientation/hid-sensor-incl-3d.c  |   2 +-
 drivers/iio/orientation/hid-sensor-rotation.c |   2 +-
 .../position/hid-sensor-custom-intel-hinge.c  |   6 +-
 drivers/iio/potentiostat/lmp91000.c           |   2 +-
 drivers/iio/pressure/abp2030pa.c              |   4 +-
 drivers/iio/pressure/bmp280-core.c            |  18 +-
 drivers/iio/pressure/cros_ec_baro.c           |   4 +-
 drivers/iio/pressure/dlhl60d.c                |   4 +-
 drivers/iio/pressure/hid-sensor-press.c       |   2 +-
 drivers/iio/pressure/hsc030pa.c               |   4 +-
 drivers/iio/pressure/mpl3115.c                |   4 +-
 drivers/iio/pressure/mprls0025pa.c            |   2 +-
 drivers/iio/pressure/ms5611_core.c            |   4 +-
 drivers/iio/pressure/rohm-bm1390.c            |   4 +-
 drivers/iio/pressure/st_pressure_core.c       |  12 +-
 drivers/iio/pressure/zpa2326.c                |   4 +-
 drivers/iio/proximity/as3935.c                |   2 +-
 drivers/iio/proximity/hx9023s.c               |   2 +-
 drivers/iio/proximity/irsd200.c               |   2 +-
 drivers/iio/proximity/isl29501.c              |   2 +-
 drivers/iio/proximity/mb1232.c                |   2 +-
 .../iio/proximity/pulsedlight-lidar-lite-v2.c |   2 +-
 drivers/iio/proximity/srf08.c                 |   2 +-
 drivers/iio/proximity/sx9310.c                |   2 +-
 drivers/iio/proximity/sx9324.c                |   2 +-
 drivers/iio/proximity/sx9360.c                |   4 +-
 drivers/iio/proximity/sx9500.c                |   2 +-
 drivers/iio/proximity/vl53l0x-i2c.c           |   2 +-
 drivers/iio/resolver/ad2s1210.c               |   4 +-
 .../iio/temperature/hid-sensor-temperature.c  |   2 +-
 drivers/iio/temperature/maxim_thermocouple.c  |   6 +-
 drivers/iio/temperature/tmp006.c              |   4 +-
 include/linux/iio/common/st_sensors.h         |   2 +-
 include/linux/iio/iio.h                       |   6 +-
 include/linux/iio/imu/adis.h                  |   6 +-
 include/uapi/linux/iio/types.h                |   1 +
 260 files changed, 905 insertions(+), 545 deletions(-)
 create mode 100644 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_fusion.c

-- 
2.39.5

