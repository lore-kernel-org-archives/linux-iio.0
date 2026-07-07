Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 739143DB640
	for <linux-iio@vger.kernel.org>; Tue,  7 Jul 2026 11:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783423644; cv=none; b=q7TJfj6OTyyX2t0nTPFNQG5le5bkPKe/q+3tPnxu6DPaQ0OvsfT3rmMZLU4lvVu2smX97U9Q1DnRcUDSMeCII6NG6WyMZmOXWXpxiGzvVhBHdtWOXWnj1MHh8WujpN6Y37/DBegRjACxcHSGjCVPynNXWMCaa4CqxmloSc+QEyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783423644; c=relaxed/simple;
	bh=nUd4gAMcOpB9jeeI7zarxSmyxqEXFICLV7XY6/voWEk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G5yVjoj8XcMDKRx981CeasQGnzEqNeXrUtF9zK250QsQRwzt7AxQd4aiYgrsS0weXklfiE8ubHOKqXwlewIshZqHm7096gtyKzq9MALPCfYk/NyqcC5ZWXZT/hQ5xLigwRoDSDHw7gNTj5GbBRnaHHmeH2IkhXM+FGh88uVdhUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mw1vA6Ew; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mw1vA6Ew"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5aebd52488cso4287557e87.2
        for <linux-iio@vger.kernel.org>; Tue, 07 Jul 2026 04:27:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783423638; x=1784028438; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dKrUxXCYekUi2G/xzFSEkuhD2hb9AvZ8aLdmpQZQD1o=;
        b=Mw1vA6EwiZTJ7E8TkyNtcp/+5lJ1Cn74qoceQNuo8IG80h8CK+FtVM1LUf00Cshmjm
         EIBKhjec2f/YDBRB6z6AFjj2pBTcoH+By+TClXFVBNWAzH/huvUkCw4Qg3Da8LXk9oy0
         EGVrI36uvkptO2SECPmJok18o/lB8zpriHiM+/dRFzAwNtr2THEdfD31eauPzErs0vRt
         VD8wDqt988wWWSynQfUxN8CTtToujVlCKmVexYOJhYPG2Z3wx92VZtJlrPG8paL9Hpsm
         CrAB4dRd8ckjJ6oCcGCqmGZm/VeDZKdPJzWCxO7ZxQX37Gq2QIiELxDlMYc+WAwuYlpy
         JqNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783423638; x=1784028438;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dKrUxXCYekUi2G/xzFSEkuhD2hb9AvZ8aLdmpQZQD1o=;
        b=WXQF3dyLae5984I/8x2yHZk9/I+WPq0u1YgRLVAwfpLLoALrLjb+vS7QgrFZ6z6syv
         3GS5FKHOaQbPrQEqPLINhIlkiyhtkD5LJ60OrIu8Xq26SXL/0Z3SPnUmOfd52Hp1Wro7
         oczK2vJnwFcRsnbGPPPZWUnD3kwblF8bRkRFIV2H20N/ox7Oo7EsezmIrGzaSGai9h0z
         Lvz4z8esS08rucUqTXIjqgmLyKPPuyCvpSfqpbG573yjj1OKEVLQoUuYj4tSOU6j3GVY
         rThxcoFHiT8tNPLiOpYGCZxrqW93ZoOKpjG8CkgNJfP4ktrKHsZwVaMXNLNetmvQ3/WJ
         mRHw==
X-Gm-Message-State: AOJu0YxquWYTeLpJmVKimkKKYUM5zds4+fG+g02WRI6PbrG0AhW5eFZu
	3In0iQhYpxFboMwmbBnkMVpJHzODB9Imd67VzdLHltzCMieAqt5tNPMSdMd+WMZ03UuqFA==
X-Gm-Gg: AfdE7cnLGiLXDiI4YtlQU7dj2udRIQ68hOAAP9Y6os7wctnOCsSljjKqkopnJ3GHcxH
	tN18BZ7QcIBGN6EcWcJik+lb6Bb++tCslUOffEUYd1R8Mgrij10fEV+IsLlQwHEd20CX/3Jji0Y
	TEkhEH2YQ/kDKSq7rV8hfOlF38BmOb8CWGRV81Y4uvwOfDeU6RGPJWTKS+9aoiDRBkD81CgZ3DF
	PkL8R4kjsnPsfllJTnKvtw0pykUlxnb3I7XWBXX88MQzGzpen5N8uItL4TjzV2EeBytUxw7VqA3
	QqEkRHKKH+MixorZlNwjHC8wnuTJYCbqgm8RuB89aa4pnBJtbEUF+llMVBX6qAB/wuK9wMYf7IS
	RAUxb3+161m9k8DGdL2waveXatPxEQ5+Ez81sVv4ihbyH7XQXcw3r+T9ky302PzZaAHiW4oFyVH
	NSB7g+8+UXWj+PuT6l3E2mWuK8JZLTb2Vmrae4Hugok7kpzg==
X-Received: by 2002:a05:6512:8351:b0:5ae:cee7:52bf with SMTP id 2adb3069b0e04-5b007b70ff3mr874174e87.9.1783423637363;
        Tue, 07 Jul 2026 04:27:17 -0700 (PDT)
Received: from Shofiq.home (87-92-251-137.rev.dnainternet.fi. [87.92.251.137])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-39b4ad1890asm23602331fa.3.2026.07.07.04.27.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 04:27:16 -0700 (PDT)
From: Md Shofiqul Islam <shofiqtest@gmail.com>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org,
	devicetree@vger.kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	andriy.shevchenko@intel.com,
	u.kleine-koenig@baylibre.com,
	joshua.crofts1@gmail.com
Subject: [PATCH v9 0/2] iio: health: add MAX86150 ECG and PPG biosensor driver
Date: Tue,  7 Jul 2026 14:27:12 +0300
Message-ID: <20260707112714.2261727-1-shofiqtest@gmail.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add DT bindings and an IIO driver for the Analog Devices MAX86150
integrated biosensor, which combines two PPG optical channels (Red/IR
LED) and one ECG biopotential channel in a single I2C device.

Md Shofiqul Islam (2):
  dt-bindings: iio: health: add adi,max86150
  iio: health: add MAX86150 ECG and PPG biosensor driver

 .../bindings/iio/health/adi,max86150.yaml     |  65 ++
 MAINTAINERS                                   |   7 +
 drivers/iio/health/Kconfig                    |  17 +
 drivers/iio/health/Makefile                   |   1 +
 drivers/iio/health/max86150.c                 | 564 ++++++++++++++++++
 5 files changed, 654 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/health/adi,max86150.yaml
 create mode 100644 drivers/iio/health/max86150.c

Changes in v9:
- Split MAINTAINERS correctly: M:/L:/S:/F: yaml entry in DT binding
  patch, F: .c entry added in driver patch (Joshua Crofts, Jonathan
  Cameron)
- Reorder includes: move linux/iio/* group after linux/module.h,
  linux/regmap.h, linux/regulator/consumer.h (Andy Shevchenko)
- Add linux/timekeeping.h for ktime_get_ns() (IWYU)
- Add synchronize_irq() in predisable() after masking the hardware
  interrupt, preventing a race where a threaded handler in flight
  dereferences active_scan_mask after the IIO core clears it
- Clear INT_STATUS1 before regmap_read_poll_timeout() to avoid
  latching on a stale PPG_RDY flag from a previous session
- Detect FIFO exactly-full condition (wr_ptr == rd_ptr with
  OVF_COUNTER == 0) using the A_FULL status bit so that a full
  32-sample FIFO is not silently treated as empty
- Use unsigned int for FIFO pointer and counter variables; use s32
  for ECG and u32 for PPG values throughout
- Use local struct device *dev in probe() to reduce code repetition
- Remove explicit enum values from scan index (= 0, 1, 2); let
  C auto-increment assign them consistently
- Use named .name initializer in i2c_device_id[] (Uwe Kleine-Koenig,
  already in v8)

Changes in v8:
- Fold MAINTAINERS entry into the driver patch rather than a separate
  patch (Joshua Crofts, Jonathan Cameron)
- Use named .name initializer in i2c_device_id[] (Uwe Kleine-Koenig)

Changes in v7:
- Replace devm_iio_triggered_buffer_setup() with
  devm_iio_kfifo_buffer_setup() to match FIFO-drain pattern
- Use regmap_noinc_read() for burst FIFO reads
- Use IIO_DECLARE_BUFFER_WITH_TS and iio_push_to_buffers_with_ts()
- Back-calculate per-sample timestamps from IRQ arrival time
- Use IIO_DMA_MINALIGN for DMA-safe FIFO read buffer
- Use fsleep() instead of msleep() for short delays
- Use NSEC_PER_MSEC constant for sample period
- Use devm_regulator_get_enable() for power supplies
- Use regmap_set_bits()/regmap_clear_bits() for single-direction writes
- Return IRQ_NONE when A_FULL is not set
- Discard samples on FIFO overflow (timestamps unreliable)
- Add devm_add_action_or_reset() cleanup for power-down on error
- Add FIFO overflow detection and reset
- Use regmap_read_poll_timeout() instead of fixed sleep in read_raw

-- 
2.51.1
