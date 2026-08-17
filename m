Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 603FA47126B
	for <linux-iio@vger.kernel.org>; Mon, 17 Aug 2026 21:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787001092; cv=none; b=GrOJETbqND66iqlA+o5YcskgrT0SAzonYDpYi02ca5ujJDXU0CbCnXe0RnwqdbF/HvoLV9X5ZbvK2SgBjfwwuQ3p8Q9ALJ6l/3M2Q7KP2d6kROUEmYyz4hZVYnKyePBB0ffqF8ICAzDDNiyVfsUjRsOP0KTktAEvkch9nhJ4x9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787001092; c=relaxed/simple;
	bh=rgunS7b4Wy0VDJ29oNVsmhZnHfrcDZ13jSnNMl3NNjQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Tvxk4WEJ6aWVRummUG1bEYjXDnl59Mt7RMgCXobKRi9Ts7CTqTOYyZ50hZja19cNC249BD4RpNIUnBMD+Uzpn5s+mrs9asaj+5Y9M3OMNmAM14/9eNeWL6tCuQ1l8gT3OE35m4gLiyxZSu+T60X1nzpzATOFnKuIcC3pk5hiigo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qW9qWQdY; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qW9qWQdY"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4954a32cf1eso20347215e9.3
        for <linux-iio@vger.kernel.org>; Mon, 17 Aug 2026 14:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787001088; x=1787605888; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pcGsnyXzE2OdR4xDjm/uu4+zzV6UMflIr2YVTptDqio=;
        b=qW9qWQdYL4sbsP/5gpVbRlKRzwPAZ0nC+VJa90DByqv0Hl7mBEqxRdztDhxTX9BOKx
         Dg2uUuhbJ9DHNz9VzFApmL6/LPe487eyIiVvHQKFxl6OIy0tN3PnamwlOxXjFv5WkV4g
         jUSJ7y+UsqeSvdY0DhBPp1L2rN1QnVhNMGcNkWZLovOsMf0KaJaQ5gnITyNqdX8+esWA
         1KYmFIlC6VHOAe4ewaL0paArVtIGYDDoxRC0vZG0xQAzBxJ5Dcw5JOaTndVWWLvl7fQO
         b3S7OGgKK37TOXufrQ4JtHrLBayOjQ/szKtbWrizT2+At2mSlk/FLgY2G+cKr410Rf2d
         PatQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787001088; x=1787605888;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pcGsnyXzE2OdR4xDjm/uu4+zzV6UMflIr2YVTptDqio=;
        b=FpY11p1ZDIl5CqhIhXtSQ+TVKzasVBwVd9zhEdf854T7m/0ZCWRniTPm1jEsn1T9vZ
         BKpfCEl14rkC1FDmEmJnj7sCLih3PbkLZb8f9tII/NJVFHiGYybMeZbhThPJ56tAJyO2
         cbYTex6NDw58OHqBH+gyd0eUKNxzVR86dzAkeeauKjp7s3Yp6pnB1kUdiYOffdb+QP6e
         oPrFvVq+3hrWrVA7JzEkXWTCKFZB4MparLdhmXTdyfIOjVI+OJQ9ziM/UQ8wDOH4jdDV
         aJMJ82Kd9DItr/ketbT1x8QoYa5fARjhdWDnSI81ERrHYpTXV8Z4FOSiQUHaKkd3yr1R
         77iw==
X-Forwarded-Encrypted: i=1; AHgh+Rq8DheJg4oe0G1AVM19GDCgxocRMrY5I/DNf50Hi/QiGggM18RP8e1rPM7qrMwTmKzY9PQrFwWhEKY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxShvCB+B0B+ySMEszdnOFIa8/MsjdH9qeQ2/S5feSHdy03g9U/
	Wfa3uAHnh4ZrwM69rWmvFbi1e07aUADpdYsnGeJ6CGrKkruaYnhdodl7
X-Gm-Gg: AR+sD13jeCVEszDI1azivLlbC/ps5VNcqBGu4fCdPtGJtJv0nnLl1zfwKQrHi10w4vo
	7BMe8eL4EuLKcHOAFCX6zMnW7yAuw53hAai7Gf0mU4MUWCNPH1VEyKnWrtRk1utlsdeNOm+S5Re
	mHJMJuhhoRXSwK9BOIZosWJs9xftwTLyxVCVcOQKOa4YUYL1w57vMoj4vBxriEqr2LqJUy1eitc
	8HKV0fNmAf5rdAl2rd2o1JP0feKIC5fMCBQFgpB4Oj1gN04/tXQFHHTD3soZ9fiZmul2ufacjaA
	PfQB4m02l5dhbJR3iPMLJA6wVryffT+DUODPSEACcr2fwXvHtUBxKqTVKqJkXEp2GTNEmDGLf4r
	gYje5kQX8FrgShInVMBwN+36wOqMhw4A8NyYghPVejqxWesGYCCDQHkL8PQtkjBAl9aUsW2OR4i
	lENLx26/0WFrFG9O+L3H9qLL8VxLPqlZo2+HwrKkJ1pWBG9Wyom2u5tVM10nRaNH9lbZ9w01UOO
	Jjx4xnLgkwp
X-Received: by 2002:a05:600c:c165:b0:499:4892:d022 with SMTP id 5b1f17b1804b1-4998795bca6mr492345935e9.8.1787001088327;
        Mon, 17 Aug 2026 14:11:28 -0700 (PDT)
Received: from fedora ([105.74.73.207])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49996176b95sm134587625e9.10.2026.08.17.14.11.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 14:11:27 -0700 (PDT)
From: Taha Ed-Dafili <0rayn.dev@gmail.com>
To: jic23@kernel.org,
	lars@metafoo.de
Cc: Michael.Hennerich@analog.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	skhan@linuxfoundation.org,
	linux@analog.com,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Taha Ed-Dafili <0rayn.dev@gmail.com>
Subject: [PATCH v4 0/6] iio: dac: ad5504: bindings, cleanups, locking, and scale fixes
Date: Mon, 17 Aug 2026 17:11:09 -0400
Message-ID: <20260817211118.21833-1-0rayn.dev@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This v4 series continues the cleanup and scale-fix work for the AD5504
high-voltage DAC driver, addressing all outstanding feedback from the v3 review.

Jonathan Cameron applied patches 2 (sort headers alphabetically) and 4
(introduce local dev pointer) from v3 directly to iio/testing. This series
rebases on top of that state and does not re-send those patches.

Changes in v4:

* Split the formerly monolithic v3 patch 5 into four focused commits:
  pdata removal, locking, ACPI/DT separation, and output-range support.
  Each commit leaves the driver in a clean, bisectable state.
* Fix ACPI probe path by forking on ACPI_COMPANION() instead of relying
  on the -ENODEV sentinel from the regulator framework, following the
  pattern established in adc/ti-ads7950.c (David Lechner).
* Introduce a mutex via devm_mutex_init() and guard(mutex) to fix three
  concurrency issues: shared DMA SPI buffers, non-atomic CTRL+NOOP write
  sequences, and unprotected pwr_down_mask/pwr_down_mode state.
* Use device_property_present() to cleanly distinguish "property absent"
  from "property present but malformed" when parsing
  output-range-microvolt, replacing the ambiguous -EINVAL sentinel.
* Add backward compatibility fallback via
  devm_regulator_get_enable_read_voltage() for old DTs that predate the
  output-range-microvolt property.
* Replace <linux/device.h> with <linux/dev_printk.h> in IWYU patch
  (Jonathan Cameron).

Testing:
Verified on ARM64 Raspberry Pi 5 (BCM2712) using a custom Device Tree
overlay on spi10, without physical AD5504 hardware.

60V path (output-range-microvolt = <0 60000000>):
$ cat /sys/bus/iio/devices/iio:device0/out_voltage_scale
14.648437500  (60000 mV / 4096)

30V path (output-range-microvolt = <0 30000000>):
$ cat /sys/bus/iio/devices/iio:device0/out_voltage_scale
7.324218750   (30000 mV / 4096)

Invalid range (output-range-microvolt = <0 70000000>):
[   40.646862] ad5504 spi10.0: error -EINVAL: Invalid output-range-microvolt
[   40.646869] ad5504 spi10.0: probe with driver ad5504 failed with error -22

Backward compatibility (no output-range-microvolt, vcc-supply = 60V):
$ cat /sys/bus/iio/devices/iio:device0/out_voltage_scale
14.648437500  (60000 mV / 4096 via regulator fallback)

Powerdown sysfs read/write and powerdown mode switching (20kohm_to_gnd,
three_state) verified on all four channels without errors.

Previous versions:
v3: https://lore.kernel.org/linux-iio/20260509142047.30302-1-0rayn.dev@gmail.com/
v2: https://lore.kernel.org/linux-iio/20260310174835.24209-1-0rayn.dev@gmail.com/
v1: https://lore.kernel.org/linux-iio/20260212181955.42724-1-0rayn.dev@gmail.com/

Thank you to Jonathan Cameron, David Lechner, Andy Shevchenko, Nuno Sá,
Krzysztof Kozlowski, and Conor Dooley for the continued reviews.

Taha Ed-Dafili (6):
  dt-bindings: iio: dac: ad5504: add output-range and missing gpios
  iio: dac: ad5504: Align headers with IWYU principle
  iio: dac: ad5504: remove legacy platform data support
  iio: dac: ad5504: introduce local lock to protect state and spi
    transfers
  iio: dac: ad5504: strictly separate ACPI and DT probe paths
  iio: dac: ad5504: support scale via output-range-microvolt property

 .../bindings/iio/dac/adi,ad5504.yaml          | 39 +++++++++-
 drivers/iio/dac/ad5504.c                      | 76 ++++++++++++++-----
 include/linux/iio/dac/ad5504.h                | 15 ----
 3 files changed, 97 insertions(+), 33 deletions(-)
 delete mode 100644 include/linux/iio/dac/ad5504.h

-- 
2.55.0

