Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B0513B2D0D
	for <linux-iio@vger.kernel.org>; Fri, 21 Aug 2026 10:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787307913; cv=none; b=tO2VFu+fP9+yHWM83YCRLxvMQFN66phKzBnACcn1q93PGgnufpRzvfnLJKVtVbv+4cMIoV8I+vyI9s5LMTZLWPLNv2peskABEzQqnBjBBBGe9jlvbT3grBrzzf4WUU/KtIIWbSu+m4zNhR6+QXEy33ry2lxP53KcoZGEIykiRQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787307913; c=relaxed/simple;
	bh=bCAUpvYrDhZGAqlZRsCLa6zMXwegXdwEKisQrAJhwwc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LmIz1hysMxudqjHnKcHmfXLfRBuFySTyP7HtlCHQCfJZcaq+gQ6UVWru2cg1dMuQ4h9vF3OJ0L9Zio0WI/KUBqykyPs72f+Jt9G6Pp+fahZbifa0BoAlABvyCvTmroWVS+pFDcSqaETSH1GSosHjico/irOzOgUNq9k/OZq0zn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=grDXpu8J; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="grDXpu8J"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4957eefd361so5366875e9.1
        for <linux-iio@vger.kernel.org>; Fri, 21 Aug 2026 03:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787307904; x=1787912704; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wE5XUorKDUJRScv0y8L+tE9Vdt20ZNkSxUGx1M2ZEFs=;
        b=grDXpu8JDgbqbgmONsZq+Z68DE6Gi+CCJj8hUehY5NQs7SvVflE5P2mOmd1FlF9mIJ
         UIj94zucARZuhT5tX6rmSTYJTw0+LlaNsa6d48nUbWn+kq0jK3q8LOrBOn18XELmi4iH
         oQZK7Rdezf3FlNSZCm44SSwuM93IBg2MjGWg1Gti7eyTWWwVW0lVFSrGGRC/YjCrNdzp
         ZeDIhTES0zJumPPD5awkxlpMfQIjIhfVhSWIld8ktAHEzNq31SNmnmq2viPuWf6/NQLV
         zEYlYttynzWv4FOFQkhap543NGZcioFkots1KFM5XiuHssttkAmBDkDf+ZyoXZIb33kH
         lEaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787307904; x=1787912704;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=wE5XUorKDUJRScv0y8L+tE9Vdt20ZNkSxUGx1M2ZEFs=;
        b=ULwPFnhCpEgb9TbPIbiXGk2cAbQ723lpV2gybtKbj1O5qw8jrZQCgcegUgB6w+eOMz
         Y+f3T8XGp0fQeldMiNL+3EVsMhlhM9lYdwJKl6OIUcWmLc6AmkrzGLv9tEVZo3yepCWV
         viJj43UP/ICCrzoGDUkLcytvVJXHIfNUqffuhys9Y9prrZSXYM/5dPh8UvQ5Jk0J8BSc
         xsMrZdSUGGJv5GkAUxK3EQDHOXwWMj2aAhT46SqPcocdMtpNLNk7KZ16yNmnkPQyn81q
         S7MHORqKYGE/G0V5u6FCwD1m3ME/7DNjDlAK+qJsScXQ8iN8fEbaJkrKIHjx6zTEBqfF
         do+Q==
X-Forwarded-Encrypted: i=1; AHgh+RpdafVWCZEZ+6gZ1/f4MxuV5sU5viPXQrnYseqc9b0atAxwp4F8Ssh7skIPgythcbL0MSn/bHaqirY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNYA/v7Gr0yfyV/MxixiE+tF53uuMBmKV2kbYUB8WPP77vPOl8
	FjpnkRCra8ahBGBjpvCQPWJ8KjnuApENppEc+f+Mgq1ykEAnA6+TVReM
X-Gm-Gg: AR+sD12avQQOnpYfTjFw8L1nFjbBFduYu9jsKumnHc9KRiZjn/UZmWdu51sYNtUf23P
	eAWesGBUPGYKyFSk8TKLZCD33JttgKfASqZk+6d8sNZBkJ2B5VCkXG7wKBnJaSzNC8dlbNMDtYi
	032B1vF4Hb0Ws9p1hCrG7apD6r3RNYpjr2WuQSZXEcDXpCbZti8kgBarxYZ9ONJ3GACfkItmrp2
	6jMxxsl5TNnSCuHpz9vJULEvkuvLKtmj4kCEFUsokQPr3MRRjdDHWojgWfgOh5G5ZTkwbOKA5PH
	X4e90Kp2XxN8B2cAWgJ8wY3n5rlb0zQC57WnXWaVP2oJj4ZmterpI0yQ50JIRAfdcVcICb4Kdjn
	LlNVvC10H1jsj+TObDKEwi95x0/xaW+54vUEeGjSnrsJ7PBwr8Y7crZDwmkQIP+tD6b1kg3MsAp
	UO2gio6vmDO93+HVR+Dp6phli6zd2k48wNLtrcnMo82IHfqkP+zkYrSEgCNLHPaLeleLrjmBS6J
	ZNQ2HnFkr6sRIM=
X-Received: by 2002:a05:600c:4704:b0:499:9069:c2c9 with SMTP id 5b1f17b1804b1-499b84613fcmr69079535e9.11.1787307904031;
        Fri, 21 Aug 2026 03:25:04 -0700 (PDT)
Received: from fedora ([105.74.130.192])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499b9ba5139sm11663155e9.2.2026.08.21.03.25.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 03:25:03 -0700 (PDT)
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
Subject: [PATCH v5 0/6] iio: dac: ad5504: bindings, cleanups, locking, and scale fixes
Date: Fri, 21 Aug 2026 06:24:42 -0400
Message-ID: <20260821102452.37407-1-0rayn.dev@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Jonathan Cameron applied patches 2 (sort headers alphabetically) and 4
(introduce local dev pointer) from v3 directly to iio/testing. This
series rebases on top of that state and does not re-send those
patches.

This v5 series addresses feedback from the v4 review by Jonathan
Cameron, Andy Shevchenko and Uwe Kleine-König:

* Drop <linux/mod_devicetable.h> — now covered by spi.h (Andy, Uwe)
* Add blank lines after all guard() call sites (Andy)
* Rename macro to AD5504_VREF_ACPI_DEFAULT_mV (Andy)
* Switch to is_acpi_device_node(dev_fwnode(dev)) (Andy)
* Use (MICRO / MILLI) for microvolt-to-millivolt conversions (Andy)
* Trim all commit messages (Andy, Jonathan)
* Reorder ACPI/DT separation before pdata removal to avoid an
  intermediate commit that hard-fails probe on regulator-less
  systems (issue raised by Andy)

Testing:
Re-verified on ARM64 Raspberry Pi 5 (BCM2712) using a custom Device
Tree overlay on spi10, without physical AD5504 hardware. All test
cases from v4 pass unchanged with the v5 code:

60V path (output-range-microvolt = <0 60000000>):
$ cat /sys/bus/iio/devices/iio:device0/out_voltage_scale
14.648437500  (60000 mV / 4096)

30V path (output-range-microvolt = <0 30000000>):
$ cat /sys/bus/iio/devices/iio:device0/out_voltage_scale
7.324218750   (30000 mV / 4096)

Invalid range (output-range-microvolt = <0 70000000>):
[   94.762850] ad5504 spi10.0: error -EINVAL: Invalid output-range-microvolt
[   94.762857] ad5504 spi10.0: probe with driver ad5504 failed with error -22

Backward compatibility (no output-range-microvolt, vcc-supply = 60V):
$ cat /sys/bus/iio/devices/iio:device0/out_voltage_scale
14.648437500  (60000 mV / 4096 via regulator fallback)

Powerdown sysfs read/write and powerdown mode switching (20kohm_to_gnd,
three_state) verified on all four channels without errors.

Previous versions:
v4: https://lore.kernel.org/linux-iio/20260817211118.21833-1-0rayn.dev@gmail.com/
v3: https://lore.kernel.org/linux-iio/20260509142047.30302-1-0rayn.dev@gmail.com/
v2: https://lore.kernel.org/linux-iio/20260310174835.24209-1-0rayn.dev@gmail.com/
v1: https://lore.kernel.org/linux-iio/20260212181955.42724-1-0rayn.dev@gmail.com/

Thank you to Jonathan Cameron, David Lechner, Andy Shevchenko, Nuno Sá,
Krzysztof Kozlowski, Conor Dooley and Uwe Kleine-König for the
continued reviews.

Taha Ed-Dafili (6):
  dt-bindings: iio: dac: ad5504: add output-range and missing gpios
  iio: dac: ad5504: Align headers with IWYU principle
  iio: dac: ad5504: separate ACPI and DT paths
  iio: dac: ad5504: remove legacy platform data support
  iio: dac: ad5504: introduce local lock to protect state and spi
    transfers
  iio: dac: ad5504: support scale via output-range-microvolt property

 .../bindings/iio/dac/adi,ad5504.yaml          | 39 ++++++++-
 drivers/iio/dac/ad5504.c                      | 82 +++++++++++++++----
 include/linux/iio/dac/ad5504.h                | 15 ----
 3 files changed, 103 insertions(+), 33 deletions(-)
 delete mode 100644 include/linux/iio/dac/ad5504.h

-- 
2.55.0

