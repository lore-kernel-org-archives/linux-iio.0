Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A637A3EDAC7
	for <linux-iio@vger.kernel.org>; Tue,  7 Jul 2026 10:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783420961; cv=none; b=V2mPvHNHZx5a29XcBYzI6FDu1d+O6UpgweEFGlDoWgmJEFjdt2ojs/LauT++f91w14kP4gz2PJSVO3UEnDaP8UdC9rh4oT3axH3e4xgRLidfNg73lH3fXac35mOCW6GMI/niMfQNKStc75C8iYyWWswDY9NJv9ZAK+T69BP3E88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783420961; c=relaxed/simple;
	bh=3Iul7A7AzwQnOR9Dpe9SeTKE7tzpz+SWSNxnI5w5KIM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ASxMQPBZaMkkKvldN9Fj8cen+FVsLtIrXqYCTCEJuWZB7AibeM1EokXmE/9xdg9IDUOhNwia9ILDQslF4UmBEksXnIj70T+9PLmsOWbw9UL4AcC6H/vC8RtUz0HTjcBE0EEKvsL7vmqKKd4uCslXYYiNY1epQ1pk1KwNp4BfIJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hzX8+H5H; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hzX8+H5H"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5aeba1a36dfso2637117e87.2
        for <linux-iio@vger.kernel.org>; Tue, 07 Jul 2026 03:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783420958; x=1784025758; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=heb5dabrqT4zaKra2HrW++HGz55cL7RYIU7fGZa8obU=;
        b=hzX8+H5HBzl8ItZZp4BVaVf79imxaO0Ip3ki9jmENTQG8R5mYzimckg+B8bs45xwyv
         rBr3K3mbB4hxgyBmrWsnlunoOGLP2PLETs9CKWbjQXeOI00VORH+7LTO/TjtwQob3/MO
         Rea1QhjvljwazYj1tpGzcpHmdBWx+vE6ihYYs89CdaUqwvc7m3uj9sScMD9ngxAOE4br
         KirrHmiKzwR4MvxrZ322vp5/Lr9fLrXASKuOEvxZ0FgYFrkVrz+Z/pE85fzk+o1/nr71
         T6tlJpyaOLu0lOAAyUxI9OqEhZGDpJcvCWj6M2ZpAjpLy4bMd0DSrfPpR9O0vgIpK7KY
         ePkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783420958; x=1784025758;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=heb5dabrqT4zaKra2HrW++HGz55cL7RYIU7fGZa8obU=;
        b=feF19bpaFsoVGLXgeL5uuGt/kgJpRgcJ7g7gws4TW3DxYrMLwvhy+X7w8J3EyT9Bue
         PhB9U7UUD8vNYMRBP0bKzbua81oCF/ufiadpKRw/DPx5jculwaNTcoDI2x6SIODvzut7
         qH39TKMfc20jzqh/kLJGCiBFGt+tdzYcTE5nmdb2cQDYQvOhtAdNacCH/pcw5OQZWRha
         ktl3OIINKqtUyYs8IMo0aaFCssmfUxOLQV0NNQ2kBRXDF2NfHdsVEOe62rxiNdFA511w
         7/+QPJORIgrwaBF4lDFpMOdJPrxbeKEsciB4V2ofmlH5ESI72hFVa/Hg+4sQLZoE1bj+
         6PuA==
X-Gm-Message-State: AOJu0YyT2KdYvMCaOsTgZ3eQ0D6Zj80Uvs8LBT03F65PnqRbHdSfFMJY
	pX4y+gCdgRzMBU/fvcEQsXqbuItwC8kvLiTai4/uUGZ50Oue+bA1XhTPREiWeMvwLpgdqw==
X-Gm-Gg: AfdE7cl7+xkeynLdjIEjDnXsNE+ERohnWCFtbJ7smY5zHPyHUQon7DBjFoIlfxI9cel
	4EKxWGklyVM7wi8Ies4/7iZTX3PLojIy3NPaTRga9H81iO349Y3oce7uoPsREG4COdmo9ADzyEN
	Qay8mH21CoANk5oVMwdZbB8dgfHSc53IhBc291MbjbYDJ1tARUsQaFghXwH+B8qy/pGSdmK9na2
	89LHlNGSEMZe1fnvDQUEdagCRbMmf1MLChUULJ5YDM3Zs48JhyhknGezaaslL/TSblBdJDP0t00
	jIoUsg896zvfinHXOPwmzlPSbDBBL5+w8KEgV9G6NTqO5a1BpdPl3ywDqttsupgjqTx1lpyb/zd
	3OCsMDFIzr4Jeyf9OiaxQdS7XIipdz6+aH6nYtobTb8HBP9mJHgL/3VpguUVQv7sVnQYYoZEH53
	poqHS09cdHVE2eD74J08en0fWt/OZknC1k9c/+1gghHIYuT7hHcLTeUVlm
X-Received: by 2002:a05:6512:6308:b0:5b0:312:21ce with SMTP id 2adb3069b0e04-5b007ba9521mr849175e87.45.1783420957244;
        Tue, 07 Jul 2026 03:42:37 -0700 (PDT)
Received: from Shofiq.home (87-92-251-137.rev.dnainternet.fi. [87.92.251.137])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aed13c8c1asm3533227e87.81.2026.07.07.03.42.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 03:42:35 -0700 (PDT)
From: Md Shofiqul Islam <shofiqtest@gmail.com>
To: linux-iio@vger.kernel.org,
	jic23@kernel.org
Cc: nuno.sa@analog.com,
	Michael.Hennerich@analog.com,
	dlechner@baylibre.com,
	andy@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	linux@analog.com,
	linux-kernel@vger.kernel.org,
	Md Shofiqul Islam <shofiqtest@gmail.com>
Subject: [PATCH v8 0/2] iio: health: add MAX86150 ECG and PPG biosensor driver
Date: Tue,  7 Jul 2026 13:42:32 +0300
Message-ID: <20260707104234.1957104-1-shofiqtest@gmail.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes in v8:
- Fold MAINTAINERS entry into the driver patch; no separate patch

Changes in v7 (Jonathan Cameron's review of v5 driver):
- Switch from triggered buffer to kfifo buffer (like MAX30100/MAX30102)
  and remove the IIO trigger framework from this driver entirely
- Remove spurious 'select IIO_TRIGGER' added to AFE4403, AFE4404,
  MAX30100, MAX30102 in the Kconfig patch
- Rename all register field macros to include the parent register name
  and a _MASK suffix (e.g. MAX86150_PPG_CONFIG1_ADC_RGE_MASK)
- Use IIO_DMA_MINALIGN instead of ARCH_DMA_MINALIGN
- Use IIO_DECLARE_BUFFER_WITH_TS() macro for the push buffer
- Fix regmap_noinc_read() length: use MAX86150_SAMPLE_BYTES (9) not
  sizeof(fifo_raw) (64) -- the padded size is for DMA alignment only;
  using it would over-read the FIFO by 7 extra samples per call
- Use get_unaligned_be24() with a single mask for 24-bit FIFO reads
- Use regmap_set_bits() / regmap_clear_bits() instead of regmap_update_bits
- Use iio_push_to_buffers_with_ts() (new name)
- Use fsleep() instead of usleep_range() after software reset
- Use 10 * NSEC_PER_MSEC instead of bare 10000000
- Replace if (!ret) chains with goto-based error handling
- Remove all code-section comments
- Remove forced variable declaration alignment
- Print a warning (not -ENODEV) for unexpected part ID
- Remove IRQ trigger type fallback; honour DT specification only
- Remove memset of push buffer before packing
- Drop overflow timestamp reconstruction; flush FIFO and discard samples
- Remove struct device *dev field (unused after removing trigger)
- Rename LED_PA_DEFAULT to LED_PA_50MA to make the value self-describing
- Remove vref regulator (not a supply pin per the datasheet); keep vdd
  and vled; change to non-optional devm_regulator_get_enable()

Changes in v6 (Jonathan Cameron's review of v5 DT binding):
- Remove SoC from description; spell out photoplethysmography (PPG)
  and electrocardiogram (ECG) in full
- Remove the I2C fast-mode (400 kHz) line
- Simplify interrupt description to a single sentence

Changes in v5:
- Rebase on iio/testing
- Adjust FIFO slot descriptor defines
- Fix scan_type for ECG (signed 18-bit)

v4 and earlier: initial submission and review iterations

Md Shofiqul Islam (2):
  dt-bindings: iio: health: add adi,max86150
  iio: health: add MAX86150 ECG and PPG biosensor driver

 .../bindings/iio/health/adi,max86150.yaml     |  65 +++
 MAINTAINERS                                   |   7 +
 drivers/iio/health/Kconfig                    |  18 +
 drivers/iio/health/Makefile                   |   1 +
 drivers/iio/health/max86150.c                 | 533 ++++++++++++++++++
 5 files changed, 624 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/health/adi,max86150.yaml
 create mode 100644 drivers/iio/health/max86150.c

-- 
2.51.1
