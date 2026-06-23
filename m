Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CC49306764
	for <linux-iio@vger.kernel.org>; Tue, 23 Jun 2026 15:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782230163; cv=none; b=QhDArZayMrkZkkxrwRmTEFEOQdCeUMwTctzlowZzZqhneOYSsK0s8WfFdSQ22QGveMpncieQ6vk/vdqnY+4QGt49VwYfJ89mtEAaj6GkHTmAlzaY+FezTeRSwKOOVeEPtpcowUt8H/CbhRNgPMeCowEmOb4xwMvQfnZFPQLaWwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782230163; c=relaxed/simple;
	bh=T0SiTGRObhjsTPu+h1FAf6ljLkbOXP1HNR4jj07g41o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HaKDB4uacEHQGdbI2cDVFwlpKMgam+lIpi489921v2S14Ayx5juZsp8FcT4n03CyvgoQOibAXI2mbl5X02pTgmyzFrcHmOnMmCm9RyMQaAuMYhKHr43oVH22DXh/oTpFsJL3lql0WBovId2SyoEo/JMewR93vEa6LZYPOql3uyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pl6QRMMb; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pl6QRMMb"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5ad4c229861so4668232e87.2
        for <linux-iio@vger.kernel.org>; Tue, 23 Jun 2026 08:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782230160; x=1782834960; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=55KrpsLVrgFVm6uOkBGmtvpWY3NBouDgLEEMArVVBP4=;
        b=Pl6QRMMbajWc5rT9fyDk6HNtIoimUjVleHOLKMB5gs3yVIszFcWgQNSf1kgKoG6eXr
         bErZkIMIiStMvd/whBOrCeO1VMqj3+sW06gh5KVSTMzU8LfTkgVNp3HNe8Zl033njdFC
         QAJ5gGGZzG6/7ueqJCPStegxuPq7aOefGYOZAbZi8uyzFu8nyTPbAwxkmZ1tNNYQQC/+
         XzxDYaYWaOuDvBlNph6cSedtbnxmmqNe+po7bRLJstzUtWeYHUgiOj1r5NHA4mR+JHIB
         aP9FBiHcczVghcsbV1/2VFzL7iqm26p98QPCx4quLvgzPELVTZihbcQ2M92vWY80PiS8
         qWmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782230160; x=1782834960;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=55KrpsLVrgFVm6uOkBGmtvpWY3NBouDgLEEMArVVBP4=;
        b=GZRudOrXGyaFYHBewTKQIh3PG5QmBWc5FRgsnrguX4Pu9oB/WrzZwGdyoCXZoyjUop
         l3jWkhIUu1tTTxiVVhLzsjB7cumfwy9eBtn8IUSqe5YCcdCfQCWhLFxf8mKESe3ZqqK7
         MbJoyMlaoEjVQrGgNWWRCTZko18Tdy0v3QKJ1N6UKl5Y6JH6c1KLeTlC7niF2vlnVUr+
         oiHHQ/4o9VHYs8JukWCILmOcY3fn2toXrXOCMk69Kou7ICuwmAeLT9kgOx2e2n0xYIGI
         0vYcCh2LdmsjuKrv/HVofx47JDFQlnCxmuDdcPX+dyBUf7LCUCCR02oA9IhuPW9RftWW
         PhAg==
X-Gm-Message-State: AOJu0YxRb/wS8qF1pSXsY58Zfg4l+TRy3Dz/uJzLIaiPumXOb5oULR0i
	RmI8yC4BvjhvIik5hJm0SDc9EaBruV7y2HT/UbMXnVsuWtsu+r+fVGUvZNIiMbI/EKdxAw==
X-Gm-Gg: AfdE7cmMMNwf2AAfx44qCxnMYrSVNvf7FrpGCjI8hpFyAyD10zvx5iIx70UM1S3ph4O
	LIkivyuMuPQXuSCXwwdXZHW17iza1TV8py3M5SCc8RlHcAl8xRoxI9K8yGdzHRN+hez55gg9q+A
	xUwX8AORsdyu/H+wl9YP5UYc0zRa74bODrcdHmskTir8dcX3ibVLUY6xRsHiRtGIpjzbczhntiE
	FoQveGYGZJuqluJDQf67MSLpVdPtkIyvGtgIPRQlT44nUfXEfL3c+VNjTGY9j+vxX98/HBPOYvJ
	xdEZyKFpYELJDQhb4CVsI+Clp8G7PjLOvQ0DdCF7LvFUNLXNVRNOghQtaioXRMsr+J5nTCQ6FfV
	xwHtwlGXd46seBqUVx6IZWxWtcCzD05E7vtWYJJ8T1dlL8oI2cnn08OZgJdoFzfhIo8eXZDtGcX
	Y2P3wD8pXjEwuWYuDah1HmGdi7jPh6RpAPi8MNLxzg0I7o5w==
X-Received: by 2002:a05:6512:6c9:b0:5aa:71de:74ca with SMTP id 2adb3069b0e04-5ae3511d20dmr877415e87.28.1782230159378;
        Tue, 23 Jun 2026 08:55:59 -0700 (PDT)
Received: from Shofiq.home (87-92-251-137.rev.dnainternet.fi. [87.92.251.137])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5ad6957a6a2sm908946e87.46.2026.06.23.08.55.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 08:55:59 -0700 (PDT)
From: Md Shofiqul Islam <shofiqtest@gmail.com>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	joshua.crofts1@gmail.com,
	Md Shofiqul Islam <shofiqtest@gmail.com>
Subject: [PATCH v2 0/3] iio: health: add MAX86150 ECG and PPG biosensor driver
Date: Tue, 23 Jun 2026 18:55:53 +0300
Message-ID: <20260623155556.13701-1-shofiqtest@gmail.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20260623140113.12574-1-shofiqtest@gmail.com>
References: <20260623140113.12574-1-shofiqtest@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The MAX86150 (Maxim/Analog Devices) combines two PPG optical channels
(Red/IR LED) and one ECG biopotential channel in a single I2C device.
Data is produced at up to 3200 Hz and buffered in a 32-entry hardware
FIFO with a configurable almost-full interrupt.

This series adds:
  1. DT binding YAML schema for maxim,max86150
  2. IIO driver with triggered buffer support
  3. MAINTAINERS entry

Changes in v2 (addressing Sashiko AI review, Joshua Crofts, Krzysztof Kozlowski):
  - Fix buffer overflow: expand scan buffer to s32 buf[6] to hold
    3 x s32 channels + 4-byte pad + s64 timestamp (24 bytes total)
  - Add iio_device_claim_direct() in read_raw to prevent concurrent
    sysfs reads from corrupting FIFO pointers during buffer capture
  - Fix FIFO-full detection: read OVF_COUNTER to distinguish a fully
    saturated FIFO (wr_ptr == rd_ptr after wrap) from an empty one
  - Fix active_scan_mask handling: pack only active channels at
    consecutive positions using test_bit(idx, active_scan_mask)
  - Remove IRQF_ONESHOT from IRQ request (not needed for edge-triggered;
    iio_trigger_generic_data_rdy_poll is a hard-IRQ handler)
  - Add set_trigger_state callback to enable/disable A_FULL interrupt
    only when the IIO buffer is active, preventing the interrupt line
    from asserting before the handler is registered
  - Fix endianness: change scan_type.endianness from IIO_LE to IIO_CPU
    to match native integers written directly into the buffer
  - Add max86150_powerdown() devm action to disable interrupts and
    assert SYS_SHDN on driver unload
  - Add devm_regulator_get_enable() for vdd-supply and leds-supply
    before any I2C access
  - Add devm action for iio_trigger_put() to balance the reference
    count increment from iio_trigger_get()
  - Split DT binding into a separate first patch (requested by Joshua Crofts)
  - Add MAINTAINERS entry (requested by Joshua Crofts)

Known limitations (to be addressed in v3):
  - IIO_CHAN_INFO_SCALE not yet implemented
  - Runtime PM (SYS_CTRL SHDN bit) not yet implemented
  - Not yet tested on physical hardware

Md Shofiqul Islam (3):
  dt-bindings: iio: health: add maxim,max86150
  iio: health: add MAX86150 ECG and PPG biosensor driver
  MAINTAINERS: add entry for MAX86150 IIO health driver

 .../bindings/iio/health/maxim,max86150.yaml   |  67 ++
 MAINTAINERS                                   |   7 +
 drivers/iio/health/Kconfig                    |  18 +
 drivers/iio/health/Makefile                   |   1 +
 drivers/iio/health/max86150.c                 | 612 ++++++++++++++++++
 5 files changed, 705 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/health/maxim,max86150.yaml
 create mode 100644 drivers/iio/health/max86150.c

-- 
2.51.1
