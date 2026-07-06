Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2988C436BC9
	for <linux-iio@vger.kernel.org>; Mon,  6 Jul 2026 22:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783377577; cv=none; b=QYYeCP2ch94/6eEViKW1f9qgWQj4Sm2bEKVIj3brJ7gvyXBm96VEnrV61xqWOy+eD8+dpvd6buMdUfzrlMr87LgZ1tuxiCJlRZQIXUSZdehKQLc5gIaVuj5m45/t8EcpsA9jHn0GQUqBXN1SJRVS/Uf4Cr4s2eN7EhoQfYhWV+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783377577; c=relaxed/simple;
	bh=RPRuDGmOMHUJ4tbd/0+a596WkyjB/l3lQ5aGvDb6b/E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dH1jyBfVl0GPpq+A7ZUIMC6Doirj1uxg8XMY4woseZl+/qvgYD1jDxeENeCRhbTAhFizDLzqKfd6DXuZo9ahXBTAXfUCpbG0QJiYumvcDaT1kwSNsuSCzHV4NtlagaZL8ArH7M6zjy8n4jg2KSyjVpADYRvVJYVbZaV4GZPagmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sCjc3Lin; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sCjc3Lin"
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-39b0c6488e6so39436991fa.3
        for <linux-iio@vger.kernel.org>; Mon, 06 Jul 2026 15:39:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783377574; x=1783982374; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=d5cayZp9W67MGxKrNsRCGwdEmrQ3OB5DSTp2GrdSHiQ=;
        b=sCjc3LinGyiuWcFrdMNsUSupyjopcLxUxfdWb6BcaRSNosk1X0Fm4ZVB4ViOrOOyhY
         iWFi2WH1VIiSWEYSPW7yaM4ZJuwd1nvK2MGxzGrR0lG7vL/MW29IO1AWcX0BeqAJqUhu
         hvcZrn+tnzTutZMTFvHKVrhMGA6e4/ndpdq0Gcllhzxh1fJLL5yH6HNLBxaiNXddDqeT
         WfpCmNH4awuh6+gZamlio1E87K0VLlKWAQlsQ5mTA+7RcoI54icJuznXDHzFNPkfZJJC
         V6u7FngBNsjMVAERUmd7EnRLhr1VCyDtVM2e2GJzDnBmjEwSLnw8/yTM53KhPcjP0TQG
         awQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783377574; x=1783982374;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d5cayZp9W67MGxKrNsRCGwdEmrQ3OB5DSTp2GrdSHiQ=;
        b=OsVRXDoKnhDI6imSv1BGMvyBNlhCibHrfeZnyZcdCCtVz8DBdIeTcIEX5VxrWwRUVR
         wNGhsDeoyL8/NKPsNLCOQ3Hp+tvAgGJOlBnYaoee2quORQnOvQP3Sd/+d5VjWekXJrg0
         BtxuOKzLljNu3KtXGYLwvwsqBXzuRh3Izlfbc2hMI52kXDngsbJpqqXqPchsAulxTaFF
         lLrM4xMzI5Ri0AfB9yKRYER59JjcOP6yVGLkt2oUhALLI24jOpFR407vXR4NasOoT1A1
         0p/DiwQ6W9d/q063SG5bDSAngtOz99QDaWn4pwRs8SmFO+SRwTuQWPk/4JI/+VdN4Ca7
         vxfQ==
X-Gm-Message-State: AOJu0YxlRXj8HV+SAA/cyMWiHMrfoGW0I51RVBvXmvTO0cR/kTbmPmR5
	59YmdljWdXtkmZd3Wnqp1u2XXlzt3bL/1G1ba+XErGwGRx3ixjJfaopjKmFpDNMgYmuctQ==
X-Gm-Gg: AfdE7clhxMl2YPEH0vAwOlhgrpInBOQI2aRvbADHlgRI5EmE+fd5/3zw1W7XtDXXxk1
	WXbPsfpqV8Frm9VIzu1yWnSNeE5+F6/s3p6F3RVQPowFN6iDEkQbMKV+OhQc0rtqpSmX8KDcfP0
	qjN+x8HkZTxLl75rP0n0XpRElzvgFKBvwKgnq4vekGZQrTD4vsH38cagI5cxcPR24qVuAHxUY4+
	sQGwt+/BlnNRCmFTSbTat6TLJ5U2GpMYkH1Fgq5MrXZ9l7k5j5/eiN1ZqbvnV8bwbB7bH6/ur+r
	J8P04fyuY+jEaW/l60Q/bkPoOfQMfdTGQEEcEQiJ1d8Glii76CG7OcqPc/S0zwAsXYY+AUmlLsg
	GyTv92lLS4/WPLWGcZMEyz2TpvaZGuZhqALyzXL9vT+BQcBTaYt0Dp8mR0eKw9CtRE6TmTbcbrJ
	6BtAmSjOgYFNtTHm21TkehGFWAyKt1gAtdN4lVqdBvv8a5NA==
X-Received: by 2002:a2e:bcc5:0:b0:39a:cfe8:dcbd with SMTP id 38308e7fff4ca-39c600386b8mr5719571fa.30.1783377574045;
        Mon, 06 Jul 2026 15:39:34 -0700 (PDT)
Received: from Shofiq.home (87-92-251-137.rev.dnainternet.fi. [87.92.251.137])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-39c6631e1ebsm965691fa.42.2026.07.06.15.39.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 15:39:32 -0700 (PDT)
From: Md Shofiqul Islam <shofiqtest@gmail.com>
To: jic23@kernel.org,
	lars@metafoo.de
Cc: linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v7 0/3] iio: health: add MAX86150 ECG and PPG biosensor driver
Date: Tue,  7 Jul 2026 01:39:27 +0300
Message-ID: <20260706223930.1807714-1-shofiqtest@gmail.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
- Remove all code-section comments (/* Trigger */, /* Probe */, etc.)
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
- Remove "SoC" from description; spell out "photoplethysmography (PPG)"
  and "electrocardiogram (ECG)" in full
- Remove the I2C fast-mode (400 kHz) line
- Simplify interrupt description to a single sentence

Changes in v5:
- Rebase on iio/testing
- Adjust FIFO slot descriptor defines
- Fix scan_type for ECG (signed 18-bit)

v4 and earlier: initial submission and review iterations

Md Shofiqul Islam (3):
  dt-bindings: iio: health: add adi,max86150
  iio: health: add MAX86150 ECG and PPG biosensor driver
  MAINTAINERS: add entry for MAX86150 IIO health driver

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

