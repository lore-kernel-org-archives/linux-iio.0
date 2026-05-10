Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90E59322A2E
	for <linux-iio@vger.kernel.org>; Sun, 10 May 2026 19:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778442602; cv=none; b=fWLc+v0Um9eG3P34q3mO8yGE9yh5sVEBSO3s2bby7pxZfKp9OPlDGgR04c2SgPvpjwvv0Fv8lAZK2jcA7HOJGBg1tsoFZXxiUiBb10FE/frdOvxBMQtFpoKssFgQuhMWj8rIKzhErpuaIMjsCv6y+1XOCpOY8Y0u4fPn3oEdXN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778442602; c=relaxed/simple;
	bh=V/b4mSM6zH+p8TXIS1po/E/hYlP6zgqrks6hq9bn5Oo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OmnS28DgMoctVXDTuhS8ZGn1Ij3Qjz+yqqsNAcmLbyig+SzYMGHNLuNIUPl0uXnZ4eV6+ErA2bUN3/RjWbwLD49Co8lJT/LJ04crCvp4NlnNei0yJ8NdY+1snMibkVOqc2MzcrLoX/Jm3qj2SvBeqJ5qCEMY7gECjeo0+D51e8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pOR8ckvV; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pOR8ckvV"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2ba6485d219so22648395ad.3
        for <linux-iio@vger.kernel.org>; Sun, 10 May 2026 12:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778442601; x=1779047401; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dP3fG7GEDYkhdiRzY6vd4dPBz6B4/zruI0cK+ySaCJg=;
        b=pOR8ckvV80VgzFPlHJQ9rIhoGe+viGq5nj/rviRtpJK8nA5BJiScmtEwzkRaDrX6hN
         tGmn4szqhAAIeFWNF6h3uAmnHQ3qvYW6i5Gn3qf5m3WR4M3Rt5XBMeUA/Dz6WPIamd9V
         UxX+z53K3hndk90eVyBJoaEU8UhdHoRWGpVtmhdjY6WldJjd4WhX2hlrwCArMf6BoS5a
         GdEhfY0mR/S0jxTh82QKl7HrvVsSLwwisn9mgCp2j9xuaVuey+Phy7H1QlKTenOyaF12
         WIE7ooYj+EFkJxPBDu1OpspuBu3EzBUbthLQ460abCRYnjn89arK9lgdpRHuzEMhlPoC
         Boqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778442601; x=1779047401;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dP3fG7GEDYkhdiRzY6vd4dPBz6B4/zruI0cK+ySaCJg=;
        b=JiiUDjgX3eaN38k6AeFAMVwF/jkAIR8UlNpRrb03Y6QMKmLG8LNMz29YIG7+ucdd3S
         hpgLXov5Z2UIpDxN6A3M91Abth4RC+s0EmDN5j3s0bDVRhNt+5kGdNh6OjqI1o0dpkuL
         EUjv+ls/IFU+/M7HJysRiU2pQDohlOnkAdekHue8xCIhm+FdtzViQjMTY98le/qQn9ZW
         gCvE6EmS1eq7t3ZwbJYaCQR0brq8WI0+PpzRE9bI2tsdn8PyAe2bXuL69TbzjonnNbdR
         jnutKgf+OScPf5rdIb7wVWn0jESCnzkv8ap3+g/ZxpKxtiiXgnzPF1t+QbCglP/4Hs/W
         OBRg==
X-Forwarded-Encrypted: i=1; AFNElJ/oRcxqd7pUAGBEfFVOPv92JhccerRmul/DlYttBVrFsNEWK2L9OPqW1DzU8lUFOOpQHePZH533wzc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwS+ebFYnl9Dl9omIINQlnFEiTzOtedromWT1493qY2PGfxeSQB
	y5YTaEOmc7e05KtDhGNZQBwaqUUE5m9vUqadHTexaweRf9di2aQ+G+BM6FS33w==
X-Gm-Gg: Acq92OEk/BUkroTZYojTZSK7EjQNCCzwX923qX51z4jiRxM/KOfB+ebyUaXvuKC6rlW
	tIphr2ppMjzrq4qvTaN/bPf3XXC+m0hZ2ZHP4ELC0oY0sc80/Zz6XMXOT0isXJnQba680h/8DWS
	oFQxum3rCXgH6z6NTF5teac1PEVYNDc4QkuGIJsGWyb30eXzwRjaAymW1yeyUiezlVjFE4Zu4GV
	57L3DaWMjufFAKmSxtGA4+oFD1EtKATT5w51ruAjbUBVMSvsKfnk/c3Xsz7uINDNQNWy7Ju5AoD
	dkr7Fy7AU3O9/PtuM2HoJ+4FCyelqZUWidF4FojVIy3T83RgZi8f2RLuuohcLipzEOIhuIg8auH
	lmofIqm19JnTnqDuZyUFfevMREBK/ZSOTPvsd26vSyrOvibDAbMOuEWFOrep1Jn2x+2lrEJVSA6
	xgd3rnf9D0DImfdxZPcIY5cZuuEvx/EzhwZ6HyGhpVooEovkRmlhgGO5nX9tDEJuoNh4718kEa5
	9aJyFZcgEntjVLf1UrFJ9haiZUb2vFLTfwae+/EcSZgLDtpwdu7V+Xy24wf
X-Received: by 2002:a17:903:1b10:b0:2b9:f55e:1c1b with SMTP id d9443c01a7336-2ba78f50707mr209647015ad.5.1778442600658;
        Sun, 10 May 2026 12:50:00 -0700 (PDT)
Received: from lord-daniel-VivoBook-ASUSLaptop-K3502ZA-S3502ZA.www.tendawifi.com ([14.139.108.62])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1e358b2sm77065095ad.54.2026.05.10.12.49.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 May 2026 12:49:59 -0700 (PDT)
From: Piyush Patle <piyushpatle228@gmail.com>
To: ak@it-klinger.de,
	jic23@kernel.org
Cc: andriy.shevchenko@intel.com,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v7 00/11] iio: adc: hx711: add HX710B support
Date: Mon, 11 May 2026 01:19:22 +0530
Message-ID: <20260510194947.31997-1-piyushpatle228@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for the AVIA HX710B ADC, a HX711-compatible converter with
the same GPIO interface but a different channel-selection model and a
fixed gain of 128.

Compared to v6, this series folds in the remaining review feedback:

- patch 02: drop the incorrect "No functional change" and the forward
  reference to HX710B from the VSUP commit message (Krzysztof Kozlowski)
- patch 03: drop the incorrect "No functional change" from the RATE GPIO
  commit message (Krzysztof Kozlowski)
- patch 05: remove trailing inner commas from the struct initializers
  (Andy Shevchenko); do not carry the stray trailing-newline removal
- patch 06: add Reviewed-by from Andy Shevchenko
- patch 08: remove the extra blank lines added between the split
  declarations and their first use in hx711_read() and hx711_reset()
  (Andy Shevchenko, Jonathan Cameron)
- patch 09: move HX711_DATA_BITS above the "gain to pulse and scale
  conversion" comment so the constant is not semantically grouped with
  the gain-to-pulse machinery (Andy Shevchenko)
- patch 10: add a blank line before the bare return 0 at the end of
  hx711_set_hx711_channel() (Jonathan Cameron)
- patch 11: remove the explicit u32 pad member from the triggered-buffer
  struct; aligned_s64 provides the necessary alignment on its own
  (Jonathan Cameron); add a comment explaining why the layout change does
  not break the existing HX711 ABI (Andy Shevchenko)

The DT binding and driver structure are unchanged from v6.

Tested on PocketBeagle2 with an HX710B breakout module. The device
probed successfully, all three channels returned stable raw readings,
and alternating reads confirmed channel switching between the
differential input and the DVDD-AVDD supply monitor path.

Build-tested with:
- make -s W=1 drivers/iio/adc/hx711.o
- make -s dt_binding_check \
  DT_SCHEMA_FILES=Documentation/devicetree/bindings/iio/adc/avia-hx711.yaml
- pahole -C hx711_chip_info drivers/iio/adc/hx711.o

Note: patch 08 produces a checkpatch warning ("Missing a blank line after
declarations") for the hx711_reset() change. This is intentional as both
Andy Shevchenko and Jonathan Cameron explicitly requested the blank line
be removed so the split declaration and its initializing assignment are
treated as a unit.

Piyush Patle (11):
  dt-bindings: iio: adc: hx711: clean up existing binding text
  dt-bindings: iio: adc: hx711: add VSUP supply property
  dt-bindings: iio: adc: hx711: add RATE GPIO property
  dt-bindings: iio: adc: hx711: add HX710B support
  iio: adc: hx711: move scale computation to per-device storage
  iio: adc: hx711: introduce hx711_chip_info structure
  iio: adc: hx711: pass trailing pulse count into hx711_read
  iio: adc: hx711: split variable assignments in hx711_read and
    hx711_reset
  iio: adc: hx711: localize loop iterators in hx711_read
  iio: adc: hx711: pass iio_chan_spec to hx711_reset_read
  iio: adc: hx711: add support for HX710B

 .../bindings/iio/adc/avia-hx711.yaml          |  77 ++++-
 drivers/iio/adc/Kconfig                       |   8 +-
 drivers/iio/adc/hx711.c                       | 304 ++++++++++++++----
 3 files changed, 314 insertions(+), 75 deletions(-)

-- 
2.43.0

