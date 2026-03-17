Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B35EB3E9F87
	for <linux-iio@vger.kernel.org>; Tue, 17 Mar 2026 15:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773759802; cv=none; b=aC9RFl1XQ81Rww+hxJK89vzO5B+7pVNn/1hTxGMsBg2UcfXhoZmqt6AvUN7z/lKZJ5Hh3DHeSXiAmTfEhGlWUjjPWLxmf5YpjmtdUvKabF/I0+xLu5pu9eaylAQ3zdnIG5JC+6rq4YxsyDW9rMCyNpcJW/bRrsPDlBSbnh3rOS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773759802; c=relaxed/simple;
	bh=3NX4aYbRah9rdrLVNzlpjVZLWBPG7mhJmbsazlQpXW4=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=G1hOeQrgealpuXpMG1igIAmXh9F8DS9CFaEnITlzwdWvH+/poybiX2xPiRLK3tzvMoPdASjGxTagtjXLLm2L88RpmNl+3ghiAdASx8V8kFVRigRRG3dxbmtGf65e3PkgWMBxcOKOuERW0nR6UCs2NjoQJraN3NHuQU10pqo6aeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=hEy6Tuo2; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="hEy6Tuo2"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-43b47b95a77so1473140f8f.0
        for <linux-iio@vger.kernel.org>; Tue, 17 Mar 2026 08:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1773759798; x=1774364598; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=oa71Y7fJ68A+FitgJbz46UBxezC+WKiVazQa2FiQIu4=;
        b=hEy6Tuo2Fahkd4c6wSSfQ7tWFhasyNex8dluslZvYh5gexYxpQ1Bku87kMY4khdUo/
         Sm/BCh4aAcn7N7SUVJTCwCTCLu2HvG3jad5ysY1Hd0l0LLz1slKo/5bzguTgRcJZpHdg
         UF1eLixfh3dtV10eSSrvFB5Hp2VAu+Wah9ZfZKllARd5P0lTRWoRD5F1kp+Wj1zE04FQ
         Wy5QWdlY/t79od6jFDbgg5i+hhOCQ0UzdtgDTFrAgezQIxcE6dPoG4ZCOpUT0onJcx8/
         53O+JRX4f2afy/ZPcnS+niEBLWdwhJjEmAEWClphbCL6M5O7JZaziOBLcjiIT+lXIrcj
         W5hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773759798; x=1774364598;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oa71Y7fJ68A+FitgJbz46UBxezC+WKiVazQa2FiQIu4=;
        b=Kn1ByLuLAiBZ8Vp5VLeAVZ7wJkldNbgJNX5dDXKWFVqxsnZ97zDhsvIOofME9IKDtk
         GYOdsWc/6wagMrWhsJpEpOmDrO/R/NCXIldeLENFYUl9tzCrl2DFCB/XowBH83KnzdMS
         Xhhz+kOR5kb9jxwCj15cd5GG0kWWSDW1KtJV13+pfiKHJulJgJkuzy8Y5jf8sZi31IFo
         djOv5GvUFZ38Tzl8YgRbymgQ+hPd8obwP2QGK8YvsVY0NQLfatFmvgCSGJ1qaHwdLXYH
         mRf1ULnISW12IaHkBQH4iBk7bGlawM2huxhqjINIg2a4IP0L3U0HPgNNNo3QUgRY1+qm
         +wbg==
X-Forwarded-Encrypted: i=1; AJvYcCUDBFbAZayGCWxYw3VYfwHSoscNuSVrGwUTG+7/Df/8GarKwOWmNvUXYAwbaBIZBqOWl7ny6pcDPYQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEyI1IM/zH77ZJI1z5rINj54sUM7UanQHgErwdb6W+LQ/nQSYx
	N6K1YP25sWtXuf8jbGOQRDyln4BuRsttR2StUvHKuTpE97ngGQw0DamlKzBVRHiz+bk=
X-Gm-Gg: ATEYQzwG371uC793Um/ocfYXl3/aHlyTIWrC2sTqci4muFRYIt+PS4EeGSuqWy9DFmu
	4i+yHJAiaMsQrJayJbRUDF1XQhSa2g2Wuk3EJ+Y0gdHDcmYWKz3E7kyJ6kzUzlBN2VMKjuKq9WH
	KJFVNMyMCSvWSTY90Aek+cqpm6EJD++M1gKEsbt9PUXOSZ8IrLlA5SaTcgVqo9wkgbcuHcG+3oj
	2hhyzYl7Hv37dNiY7Gy4I5oH/BGMnUULH+iRU9JJUvVIQAFlB/3KSwFLpgU8t4uWL8c9hZSGUu6
	2+YTphaArrfnu5pbqbUHxD1daxn1FggCvezsZWOYT8gfs4EcjAQhptdnjNoSwIrUOpS7r6rjNOP
	v/2mNueBuqWiafBqE2RpQ1Z6AFSXQYczfBSADL1YkVdBmcZ0TGP8acPN8YbZBHMuwNI0pSg==
X-Received: by 2002:a05:600c:4710:b0:486:c4f0:1a37 with SMTP id 5b1f17b1804b1-486c4f01e4dmr29111945e9.24.1773759797888;
        Tue, 17 Mar 2026 08:03:17 -0700 (PDT)
Received: from localhost ([151.37.101.237])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48557784c18sm276652055e9.4.2026.03.17.08.03.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 08:03:17 -0700 (PDT)
From: Francesco Lavra <flavra@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v8 0/6] imu: st_lsm6dsx: Add support for rotation sensor
Date: Tue, 17 Mar 2026 16:03:16 +0100
Message-Id: <20260317150316.3878107-1-flavra@baylibre.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6493; i=flavra@baylibre.com; h=from:subject; bh=3NX4aYbRah9rdrLVNzlpjVZLWBPG7mhJmbsazlQpXW4=; b=owEB7QES/pANAwAKAe3xO3POlDZfAcsmYgBpuWz4TkcXDcZDq9ORTApOoCYySTN7eUuoIdj3L OhZkbg4cFaJAbMEAAEKAB0WIQSGV4VPlTvcox7DFObt8TtzzpQ2XwUCabls+AAKCRDt8TtzzpQ2 X0GpC/4swim0VI6tN18IQWmM3Oq8eqg3k0FTz+ICLn/4LzijDpHVU+V/rv7GxhCibsZX4xsb8mF VK5IOZJBAHRIBEfUYQluJWszNUoSGW82kT13yVLcJK3zoIKTtR7BgP9TXqgnFKkG+aJg96AOe/R fzFzVvNHl93Hwrx5lf5yiaTstIphGZUixLsv/URfbyZQ0Nt5LDkOTlObNOex4hUmO2SgMwbvpWa wHTP5qV0Ul76zapcbV74iO8Sz1CqfuTRCB6TROxSbtWTGYdz8NpxRsXGQ42SfjgpdTTdIOKUSJD UfiOvGMRG9ZMzAixNXe9N3w+Xvoh94vxy2HDeb2RcHwVKw6181HzHEGIMz1wHELnUYc5xvnyjLu hiIrCqJhp8K8esjf7T87AVYYT6IwijOpPyu9HeylYIbDVvZmFPemUs7u0/sAhIV9gGwMHWC6BzF +b3JCyA8PihQ7kHxAhGlAfrCrwaE2d9XH/CMSI+Cu57A1IRd8wjR74Kc3wrDIlj3oDngs=
X-Developer-Key: i=flavra@baylibre.com; a=openpgp; fpr=8657854F953BDCA31EC314E6EDF13B73CE94365F
Content-Transfer-Encoding: 8bit

This series adds support for the rotation sensor functionality present in
some chips from the ST LSM6DSX IMU family.
The IIO ABI has been amended to allow the use of floating-point data and
a "quaternion axis" channel modifier in IIO buffers.
Tested on LSM6DSV16X.

Changes from v7 [7]:
- added Lorenzo's Acked-by tag to patch 1
- in st_lsm6dsx_buffer.c, added st_lsm6dsx_check_data() helper function
  (Lorenzo)
- added definition of IIO_SCAN_FORMAT_* symbolic constants to restrict
  flexibility of what can go in .format (Jonathan)
- re-added @sign description in kernel.doc comment for
  struct iio_scan_type, mentioning that @format should be used in new code
  (Jonathan)
- in tools/iio/iio_generic_buffer, replaced legacy __fp16 type with
  standard-compliant _Float16 (David)
- in tools/iio/iio_generic_buffer, added check for compiler support
  (David), so that compilation does not fail with compilers that don't
  support _Float16: tested with gcc for x86-64 (supported), for aarch64
  (supported), for riscv-64 (not supported), clang for x86-64 (not
  supported)
- in tols/iio/iio_utils.h, replaced unsigned with char type for `format`
  field in struct iio_channel_info (David)
- renamed "partial quaternion" modifier to "quaternion axis"
- moved new modifier value at the end of enum iio_modifier (David)
- squashed the two words together in the modifier name (Jonathan)
- in ABI doc for new modifier, fixed typo and angle units (David)
- in ABI doc for new modifier, fixed kernel-doc warning (kernel test robot)
- in st_lsm6dsx_fusion.c, added missing header includes (Andy)

Changes from v6 [6]:
- dropped patches 1 and 2 (already picked up by Jonathan)
- added floating-point support to iio-tools (Andy)
- replaced `sign` field in struct iio_scan_type with union instead of
  `format` field (David, Jonathan)
- changed [s|u|f] to [f|s|u] in ABI and driver documentation files (Andy)
- removed IIO_CUSTOM channel type in favor of IIO_MOD_PARTIAL_QUATERNION
  modifier (David, Andy)
- replaced "sf" with "fusion" in type, variable and function names (David)
- added copyright statement in st_lsm6dsx_fusion.c (David)
- added `ret` variable in st_lsm6dsx_fusion_probe() for better readability
  (Andy)
- modified data structure holding the list of available frequencies in
  order to replace device attribute with .read_avail callback (David)

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
[6] https://lore.kernel.org/linux-iio/20260225100421.2366864-1-flavra@baylibre.com/T/
[7] https://lore.kernel.org/linux-iio/20260304080519.2844101-1-flavra@baylibre.com/T/

Francesco Lavra (6):
  iio: imu: st_lsm6dsx: Fix check for invalid samples from FIFO
  iio: Replace 'sign' field with union in struct iio_scan_type
  iio: tools: Add support for floating-point types in buffer scan
    elements
  iio: ABI: Add support for floating-point numbers in buffer scan
    elements
  iio: ABI: Add quaternion axis modifier
  iio: imu: st_lsm6dsx: Add support for rotation sensor

 Documentation/ABI/testing/sysfs-bus-iio       |  48 ++--
 Documentation/driver-api/iio/buffers.rst      |   7 +-
 Documentation/iio/iio_devbuf.rst              |   3 +-
 drivers/iio/imu/st_lsm6dsx/Makefile           |   2 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h       |  28 ++-
 .../iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c    |  40 ++-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c  |  58 +++++
 .../iio/imu/st_lsm6dsx/st_lsm6dsx_fusion.c    | 235 ++++++++++++++++++
 drivers/iio/industrialio-core.c               |   1 +
 include/linux/iio/iio.h                       |  19 +-
 include/uapi/linux/iio/types.h                |   1 +
 tools/iio/iio_event_monitor.c                 |   1 +
 tools/iio/iio_generic_buffer.c                |  59 ++++-
 tools/iio/iio_utils.c                         |   8 +-
 tools/iio/iio_utils.h                         |   4 +-
 15 files changed, 464 insertions(+), 50 deletions(-)
 create mode 100644 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_fusion.c

-- 
2.39.5

