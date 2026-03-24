Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19450221F26
	for <linux-iio@vger.kernel.org>; Tue, 24 Mar 2026 08:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774342023; cv=none; b=D0CTDkJFNmIwoKB+JPa+XDXpYoFWMtDu+uJUnJlOlfhmA4e8/8C7MDWDPz93fH8Y7bwz5OlrEwgQUXYLP1gDTSkyMocF84G3qnX5U0fHL+p29JEZMip4mv5UD/1Dsfw9Iw1o1/B8AxzhpuZ8bSSm2FvmSN/kRTaP4ANX1mRCaxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774342023; c=relaxed/simple;
	bh=zPsFgpR1ONJzNQWwmccNEEAZlm+N/31MN3Z2vQYpcLM=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=Pn2e+w2t6c0gzsiSk0CYneX2MUt7EkRkgjRUIjfeTT4KEtNDak+XfuV41zITAn7GAvb64ieaABNybyh9SYEoMe4aOvfH/Ae+TYLPP+vLSXjtAIPm+N2VGaJYM29iBYl6WmSXv4Sbi7ZwG6QtmEJR1MBdTfRiChutmWgBj6ZoSWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=hNx8+dqT; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="hNx8+dqT"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-48374014a77so49612945e9.3
        for <linux-iio@vger.kernel.org>; Tue, 24 Mar 2026 01:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1774342017; x=1774946817; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=C5e2xV2YkYhowuVMrYQeZbN/S2plaCFtv6XcR0GkRJU=;
        b=hNx8+dqTCJtdcHnD9eUc5lpKnCFoCU2KhHMo1sgFYGJ73OwLcrTO0JoxDzEMUnvydG
         GKdBBK1dXeVN8xfBzYJuK+ahEcNcaJ1rRYu9ZNgE9jj0MTX78Pv+uHUUKZk5PnrCA4Y2
         J4YHzZA/uPP83k6snlaXsXXkA1yHa9NeM8eKUm0XYIV77liQXqL8y/NGoETGFnGQRhLM
         VCahM3cXWSq47BVgLUy01rahVRvUB2YfsrcVX3/MN/TAOPeqqy6Ksrlv+eRrowe/Qiwd
         FcnSaIkf9jPEnAngzuV4sdS2HJe6KsFfVQIfkmIVFpzLyY+InLSyifzqQI+eFoNeiIFF
         WHNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774342017; x=1774946817;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C5e2xV2YkYhowuVMrYQeZbN/S2plaCFtv6XcR0GkRJU=;
        b=WFyMHconsIviQGir1eV/Sm4wZhNycIsJNs1ss3bGbrwKhLsJ5i36uI8YQ3cGzFbMFj
         pKNBu4yM3yjWNKrOkpM+SIo8eswoojc9eeXpBM1yifxgvXrUF7x7tTaSTZ/Km1JUz46v
         u78HYHyamnMKC2sjvyCyF7ioUijRlYy2ZT5dvC2MhphVJAyLHKREFlKKHUw5f2b7a7oq
         X8Wu+m1nHKYb77OF9NN8e7/BrPTVR/y1hKhMU0/WUONI+GT1utiMOMcTdGIG7HxBFMWU
         Xg7+NKZhFFJ75NI+MOp61YvfvVG3PMAM79wYNyheshGRAZd13UqpjIIJjY2a+M2jJb5s
         qH/w==
X-Forwarded-Encrypted: i=1; AJvYcCVpa3zJGz70LJxko9QVjMdaf/feUD8LSDYgqKg0SqWa3LITTpRL0+rNbIQV8ktR2QMhaRYvBnYcKAM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1ZU4yFUHUgsQNtvQoUQ5ST/E7Ke++iv0OXTjOBe571UJRZ6Hh
	wTdv1TNLPU3lbSadsLAUSE82VSQWu8tb0xZ2KljqvXW8pPdq9Cqh1kGv7nVu7KWTcQY=
X-Gm-Gg: ATEYQzx1XMXz7YYPc2UDBPgRrpD6bDdh6J6n0d/N496wyQ7OULgLyYQ2YGWTS0F3dW3
	huGbS9JmW/OhhwVnqsP39AeS7/e5FZwtkPeloIQwAvGpuClsc3vjkas67TUXbu0tHN+YKCh6IOj
	B4pe0lEjY4IrPslhUs7eWzHeFfeYnaO8FzebWg6NUocZvNfL5Q8o58VheKQ+ImN3ci9GiGyBKNN
	EhPrklyRSdToJ3s9V1NY0R/ArfuPvl4tFhI3x8EykuyKsWwekJMsRzrafDUQZTSu1DWuI7wokXe
	3nFpHT4Cmoa2cgG2aumWEtm96sCJn5nTD2B08t5OVPuQhBNDAXGFSr1HV4muQmOd7RG6nU7SZxw
	S+ReOyM1SZ36R/tM73FKh8YDeBhkxtvC8z7VM6XQkldvR/FsbbmIfsGzj3pCAht1dwlg=
X-Received: by 2002:a05:600c:3490:b0:487:300:d9ca with SMTP id 5b1f17b1804b1-4870300db54mr175186585e9.31.1774342017170;
        Tue, 24 Mar 2026 01:46:57 -0700 (PDT)
Received: from localhost ([151.43.230.2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-487116ac0a8sm64681075e9.6.2026.03.24.01.46.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 01:46:56 -0700 (PDT)
From: Francesco Lavra <flavra@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v9 0/6] imu: st_lsm6dsx: Add support for rotation sensor
Date: Tue, 24 Mar 2026 09:46:55 +0100
Message-Id: <20260324084655.653781-1-flavra@baylibre.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7448; i=flavra@baylibre.com; h=from:subject; bh=zPsFgpR1ONJzNQWwmccNEEAZlm+N/31MN3Z2vQYpcLM=; b=owEB7QES/pANAwAKAe3xO3POlDZfAcsmYgBpwk9dV/vQWuOsL0Bt7L3gBNaopZ0sBxhsY2j6p n/OiIeFGteJAbMEAAEKAB0WIQSGV4VPlTvcox7DFObt8TtzzpQ2XwUCacJPXQAKCRDt8TtzzpQ2 Xxf3C/9BFlztMm4duYEAiP+gtnQMtAZ1FnA+Pmicx5FFKVx4T17binvMZlHbGREb8di5jYYPvqn uLDzazQ2BwuCtlfQYtluQFI6LWEO/6RdU2XP4givAbpms3MtvGWJpK73qgh5RLLBW0iAGxgTy5m y2Uc+OoMV2bCFJ1aBw+GG0U3YMNAnsZRvKuPONO8SaReKB8Ff9DLFwJ0SVWy+6M9GOutiA2femo o0nZB3ZZEq9fXTpYDHje7Mnl5i85wCMY3Tmy8dOJuXnnt//9wa4+EF9KMO31Ds9Z50fkGprPXq9 nUpajgwi+mL86o7G/xRDfwTRppwip3m4mOXAY/nVHX6DI+zOCEg1n0Sb+yBxkRWFG1Wr8LFdOzs C8RmxstwYxt0brnYhzCFXQFJxwGCd22v6zbWsjZarym1yJe9rl6A1Js5pKM/xHOXxpvUhrnsFWq 13BdzNKyYsf+SpzSLagQ+kfRWVQ59h7mqlT3fn9dW3xkcidEynW3nSMaIJ965NPkJxFyg=
X-Developer-Key: i=flavra@baylibre.com; a=openpgp; fpr=8657854F953BDCA31EC314E6EDF13B73CE94365F
Content-Transfer-Encoding: 8bit

This series adds support for the rotation sensor functionality present in
some chips from the ST LSM6DSX IMU family.
The IIO ABI has been amended to allow the use of floating-point data and
a "quaternion axis" channel modifier in IIO buffers.

The use of the new modifier depends on [0] to get the correct sizing of the
buffer in userspace.

Tested on LSM6DSV16X.

Changes from v8 [8]:
- changed comments for IIO_SCAN_FORMAT_* macros to use proper kernel doc
  format with one comment per macro (David)
- in tools/iio, added error print if 1-byte floats are encountered and if
  2-byte floats are encountered when unsupported (David)
- in tools/iio, renamed signchar variable to formatchar (David)
- added David's Reviewed-by tag to patch 5
- in st_lsm6dsx_fusion.c, avoided mixing cleanup and gotos by adding a
  helper function (Jonathan)
- in st_lsm6dsx_fusion.c, removed leading double spaces in comment
  (Jonathan)
- in ST_LSM6DSX_CHANNEL_ROT macro, replaced literal 'f' with
  IIO_SCAN_FORMAT_FLOAT

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

[0]: https://lore.kernel.org/linux-iio/20260307-iio-fix-timestamp-alignment-v2-4-d1d48fbadbbf@baylibre.com/
[1] https://lore.kernel.org/linux-iio/20260109181528.154127-1-flavra@baylibre.com/T/
[2] https://lore.kernel.org/linux-iio/20260115122431.1014630-1-flavra@baylibre.com/T/
[3] https://lore.kernel.org/linux-iio/20260119100449.1559624-1-flavra@baylibre.com/T/
[4] https://lore.kernel.org/linux-iio/20260121112758.1831077-1-flavra@baylibre.com/T/
[5] https://lore.kernel.org/linux-iio/20260122162335.2020006-1-flavra@baylibre.com/T/
[6] https://lore.kernel.org/linux-iio/20260225100421.2366864-1-flavra@baylibre.com/T/
[7] https://lore.kernel.org/linux-iio/20260304080519.2844101-1-flavra@baylibre.com/T/
[8] https://lore.kernel.org/linux-iio/20260317150316.3878107-1-flavra@baylibre.com/T/

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
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h       |  28 +-
 .../iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c    |  40 ++-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c  |  58 +++++
 .../iio/imu/st_lsm6dsx/st_lsm6dsx_fusion.c    | 243 ++++++++++++++++++
 drivers/iio/industrialio-core.c               |   1 +
 include/linux/iio/iio.h                       |  30 ++-
 include/uapi/linux/iio/types.h                |   1 +
 tools/iio/iio_event_monitor.c                 |   1 +
 tools/iio/iio_generic_buffer.c                |  70 ++++-
 tools/iio/iio_utils.c                         |  12 +-
 tools/iio/iio_utils.h                         |   4 +-
 15 files changed, 495 insertions(+), 53 deletions(-)
 create mode 100644 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_fusion.c

-- 
2.39.5

