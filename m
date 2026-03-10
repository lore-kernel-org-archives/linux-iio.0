Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED1823AA51A
	for <linux-iio@vger.kernel.org>; Tue, 10 Mar 2026 17:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773164926; cv=none; b=OqMlhZXTsIJBuBOldd3SMqFYwVUScrQRy/Zvv0LgglLkotlSVQzhTAKdwln2P7voWQyA/41U/aoiQiIlX/LoczhlT5l3KnXNioiaoX2lRXz7uNK/S2UWVfib79+eD/fX/JcK4ehT6Cbt/zIf/VvLLvUT/QavLSQH0GuM/mrAhcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773164926; c=relaxed/simple;
	bh=CAt5rbLDMhxVLmOqiqlVM1mP0fA6B6zhT5OMjhjh6p4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=URDvGCJiCWSSxnD7uA5lalqV7zsEUBJm7bJyIvL6tsCV2PjEyvucBTLTHYdsuUnBw16IogSufQfvfMM566/RwHOV6lcYT+TD4T2OJqwyk3l6AAmnzGuAPUI8prpMF9Zw9qFW65gsDVIFv17+OfDDaFembpjcZqKft9HRawj/znE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eQ88UCSW; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eQ88UCSW"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-485445e80bdso8510425e9.0
        for <linux-iio@vger.kernel.org>; Tue, 10 Mar 2026 10:48:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773164923; x=1773769723; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2dldqyonvLVTQ/Lexaotmy5KRFPJ0gpKjoNB+Wq1yLo=;
        b=eQ88UCSW5DYGD7Ov835QPzK1xYqpr8tVgdb5t3TiSL3lJ1W1HjNPFWHNqVgEXbZdnx
         IIG/MMZkalA3fAfMURSphGYxS9bJWt4WSO5DKWEVYikHb2DhZtpYQRm3RJCa/3Xnc0xd
         5bmSWHLNPsoeiYA/3nlzXhR/TDqY5kpmz5CeWkG0RZzilsKL8dNOCxKfxfcPh/7rhXMU
         G4q+JsIWD8tZCrrfRkaX+91A4y0BirPAbLurkZpMEB+hVQgHOupar+Q6s57Bzbki2s5J
         hQwnAL7SCiuegeioHEWpi7hD3QDPZ67hpatdjsoaB0u8Sz2AuDKvmcNk9ZRMFrAk+8ct
         LPRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773164923; x=1773769723;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2dldqyonvLVTQ/Lexaotmy5KRFPJ0gpKjoNB+Wq1yLo=;
        b=wteoahoSqzGo4AVlUajWp5/zfq8l5Pb/Tu27qjNHPo2pgw+PbD9bwGDQWT0J51VSH5
         B3qhE3dzU0F1zzog+RliCjO6ImVEChfLS/0DkTq1c3KVcTDi+xp1QmBRy+qbF23kKt54
         VXoU2qiReluMFeEN5/ZvFCOBzAS/TWsPELG4P5bl5GxVWK451Rf2DqIQs6YKKh10ehvy
         bg4HkBZ579fWure09Ym9RHy4IJy28ZY7rs4myaaiI3Tdu+dS+0j3MggBhvfiiy89LnTf
         wiAAp1guR0bvQUQnPorEXLuPGpeyxxspIgOPdpJBNNRDiGzbsoCkktzjbo9nRShpp+mi
         tiUg==
X-Forwarded-Encrypted: i=1; AJvYcCUZmHuhnsXu+zQdzGsf5Rdri9hS8K9sbW66Dcdni0YxvEWB9ALZULQMNyiZbujtXDnvjnzeQrmWuXA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXYlWvcBm7Cu8beZxcOBR0Hq/h5SpSuoFDuAVutweNbEg5kcMw
	pLA4SAI90iR70DJaDfrTiOUWnxgW1MaSPlOBiq32EBwbLrUQyDFNWA/D
X-Gm-Gg: ATEYQzxMJwsg4ZqhU40+9WocQIaz8arUWbrDFKAjtNYiVNapDs+kqq6A2WBypc/bFAA
	fCzaD4ppjkXqntfytAZvaoTamsTQcz121t6qNDNMHI9aV11oCvXLaQDYtLIsAtXbokAemJ/xaKG
	OEE0bFeipljlOCupTCP9ShAf8BTEnSSTyMBrI1XWxP7cB4f/d5Hqw4F1FuouGFvJ2D0+HNxGN6W
	K0QUgdsAJesXOCDrET4avGtNtRaZJ470V1DoUPZ8o1tok+5pC4Xx5VCJ1ZL2wCb5RogH/MZhgvL
	m5sz19B8VOHGQSn9KoomRbTPUwCUDQdZa68mpn6tsZJ3itcO60vQgvvchyoXvZB7SM00riFMIw2
	FD211laDZh9Np1W3iSXrGMTGMZpPeT38yWZt1Tw6rEbuRxgigf3eiB5K8KjESX2ymENJralO3A/
	6P+Lykp2zmhGzC48ouF99WXRYuDH5xWYRQXPVcEYRg6IS2LmJ7Muc2OeB8fi7vhGeeg2Ma
X-Received: by 2002:a05:600c:35d2:b0:485:3ca4:4eee with SMTP id 5b1f17b1804b1-4853ca45255mr123439525e9.34.1773164923066;
        Tue, 10 Mar 2026 10:48:43 -0700 (PDT)
Received: from db07.1337.ma ([197.230.240.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439dae45786sm42986166f8f.32.2026.03.10.10.48.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 10:48:42 -0700 (PDT)
From: Taha Ed-Dafili <0rayn.dev@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	skhan@linuxfoundation.org,
	me@brighamcampbell.com,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Taha Ed-Dafili <0rayn.dev@gmail.com>
Subject: [PATCH v2 0/5] iio: dac: ad5504: fix voltage scaling and add missing bindings
Date: Tue, 10 Mar 2026 17:48:30 +0000
Message-ID: <20260310174835.24209-1-0rayn.dev@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series fixes the voltage scale calculation for the AD5504 DAC and
updates the devicetree bindings to support the necessary hardware
configuration.

Previously, the driver calculated the scale based on the VCC supply
voltage. However, the AD5504 has an integrated precision reference,
and the output range is determined strictly by the state of the
R_SEL pin (0-30V or 0-60V).

This series updates the bindings to use standard IIO DAC properties,
aligns the driver headers with the IWYU principle, and fixes the core
scaling bug while adding support for the hardware's optional GPIOs.

Changes in v2:
- Replaced vendor-specific adi,output-range-volts with the standard
  output-range-microvolt property array (Krzysztof).
- Replaced adi,output-range-gpios with standard range-sel-gpios
  (Krzysztof).
- Refactored allOf block in bindings to use not/required logic
  (Krzysztof).
- Split header updates into two patches: alphabetical sorting and IWYU
  compliance (Andy).
- Used MILLI and MICRO macros to replace hardcoded values (Andy).
- Used a local dev pointer to respect the 80-character limit and realigned
  function arguments accordingly (Andy).
- Added driver implementation for the optional CLR and LDAC
  GPIOs (new in v2)

Thank you to Jonathan Cameron, Krzysztof Kozlowski, Andy Shevchenko, and
David Lechner for the reviews, schema guidance, and C optimizations on v1.

Note: I do not have access to the physical AD5504 hardware, so this series
has been strictly compile-tested and validated against dt_binding_check
based on the datasheet specifications.

Taha Ed-Dafili (5):
  dt-bindings: iio: dac: ad5504: add output-range and missing gpios
  iio: dac: ad5504: sort headers alphabetically
  iio: dac: ad5504: Align headers with IWYU principle
  iio: dac: ad5504: fix scale via output-range-microvolt
  iio: dac: ad5504: add optional GPIO control for CLR and LDAC

 .../bindings/iio/dac/adi,ad5504.yaml          | 40 ++++++++++-
 drivers/iio/dac/ad5504.c                      | 70 ++++++++++++-------
 2 files changed, 84 insertions(+), 26 deletions(-)

-- 
2.47.3

