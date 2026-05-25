Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ED803793AB
	for <linux-iio@vger.kernel.org>; Mon, 25 May 2026 10:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779706298; cv=none; b=FdB6abYf7iL5V9GAwI9TvHsiCPx3UeVUB4zp3FTjQEyHKiv3jgEUDWvvqWEHzmTb5YVqk3pkpSPmqugtY2snl5aCo/g2ex//v5/lP6BmTouArjQvnYL+2jkfxMQSUZ+IM6GckYzmgfAQlco61PS0RFfz1EquqxzZjo5SYdv+QUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779706298; c=relaxed/simple;
	bh=f5DHgfTDON8Z7Hqcg/RAB6ffOcn9hbOp5DGUcqANlZQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sQcC6W4f395pwkxr0VMdjVfzbfFsn27jwgRQx9fSNdpB9il0NNd81a0y+NaMGvxWtAwAsfQIF47jKzTCvBDima1n3q7QsBxzDn1mCI0Omj43YJpBF5jp6w7l8Z97ejfZljkOmV0cWxK2XEpeZ5c4kMhBFgzrirLQqwyvgtM+rWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iVCtwXkx; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iVCtwXkx"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-368f25ff4c4so5193347a91.2
        for <linux-iio@vger.kernel.org>; Mon, 25 May 2026 03:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779706297; x=1780311097; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dHO2VvSt37xok9aGTo5VhiAMv2Gtm77tddVwXTG5HfY=;
        b=iVCtwXkxKp2KF2yrkPBESX7gbm5KMJ8wDk7sDQsVqJipj8USWqaXXF+buN0XmPZDbk
         3WpXg8MeL5Wea5Nj8wiGVZE4Zao2+ydcjhm09YL5RR6mni025OTOWhvuWFxvkXjca3Lp
         r8VxxpFo7Rsyq9MM7k2AG4+Y8bVb/gpXFKOxVlCPW4JSqpvWjezHOkK3zGU5XxM/+j/F
         v1kQw5hVWmLizkit7Gk6ojJt2sxDsbM2V/aqcDrkPn0vlXqU8EhBlW8QHzEIILWLqmRW
         +ilbXv60Wy2WMVNTGc4tIAdjjZaiMlcjJ6SP5BJqrpHRJvaDA6RuIHIgsx1oZZj7E9gA
         GH0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779706297; x=1780311097;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dHO2VvSt37xok9aGTo5VhiAMv2Gtm77tddVwXTG5HfY=;
        b=X3j14TA33HoLtzIBKUnI2FkZmDzwjZTTazTkL/zmE8IjX91ZT8GO0k1qr8x0ehK4Qi
         XnKte+MyQSNXodj1vzIzy79iYFZYkdxLEcQ/5m/jzhkDjUVC/ioU4N0gwC+17Lm/d0zo
         plNk7sTBOfv1ddhrvs1yTFHatTbrnVCfbw6QTOASc2eXhkhcf9ZBasoGdqjpVCizBEQO
         kguTCjLYiiwKADERFzZzE/ItK/McgLHo/zbRfrVS0R3YoLw/IrY4HarrjVjrXRqDMyEm
         EC7CxXuVXhIr7b6Yo8uGRSrzE6LRHAqtYvMhSHdx+LpkoTg1XTtBw4L19sVt9nrX2W23
         UWTQ==
X-Gm-Message-State: AOJu0YwLfnzf5TwX2C3f/qKbMy8xmzBPpMTS5W6NmqRjfobGa6HM3v9p
	jdqVISPq1a0r6kIdPclAREX6AzSu/hbpVFl8SQW8+FAoI6rAKUR/JbaJBucoyuut
X-Gm-Gg: Acq92OFx6PsaxS11725SzI9FSHJR3WcYxvBlSwAHBDO6wC1KQExg8KsnytOLZ1kHifn
	lD0WLgkDJ5pS8AfWM8Y/6oE+V6l8y078ImlX4qZ80SDseK0pz8+FkpV6qQ8PpNLyNXoxyNn19T0
	UJCt/NhqpSGWGRUzR4HbXJnfWplZSfTGuivv2pgTUdcrSkWV6M/reFL2wajXFFRMplk5tTHZYbv
	0mEFD9J8hyXNU1hib/IAZqBSHOa1ornBLYPp2CxHzwGBi7mykmNeauL/iOfwc5HjrhJvJiJIIAa
	CjmcA1tb+wTHjF2HK+tT5pmy3wswa1FwIr9ZZahhojQngF0iqIGK3GKhBYD5Hqyd/apdN6D/d4V
	VHqdEMlpSCiwVL7w0oKfte2jn7+JyN2QjR+3RvL55rR8KjPO9Nubq8XJ1Gz3U34jf57vcuXiJ7S
	OfWTOvyzd/3uOuy5EtNEx6GSi9Il5GHh9kQHRRNoP62TVSlHW2Zt3C0WASHCUgvKgXsxgGrzblh
	1q7NCqtf0iMonEYXxvfYovVFYxkzhqIGioHjix+PQ==
X-Received: by 2002:a17:90a:d2c3:b0:36a:6ac2:8bc8 with SMTP id 98e67ed59e1d1-36a6ac28c1emr7212752a91.14.1779706296688;
        Mon, 25 May 2026 03:51:36 -0700 (PDT)
Received: from lord-daniel-VivoBook-ASUSLaptop-K3502ZA-S3502ZA.. ([2405:201:2011:e829:fadd:33b:8fc3:b2c8])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36a7265a001sm9302388a91.7.2026.05.25.03.51.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2026 03:51:35 -0700 (PDT)
From: Piyush Patle <piyushpatle228@gmail.com>
To: linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: jic23@kernel.org,
	ak@it-klinger.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	andy@kernel.org,
	nuno.sa@analog.com,
	dlechner@baylibre.com
Subject: [PATCH v10 00/11] iio: adc: Add support for AVIA HX710B ADC
Date: Mon, 25 May 2026 16:21:16 +0530
Message-ID: <20260525105127.180156-1-piyushpatle228@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The HX710B is a 24-bit ADC from AVIA Semiconductor, related to the
HX711 already supported in this driver.  Unlike the HX711 (which has
selectable gain and two input channels), the HX710B has a fixed gain
of 128 and two operating modes selected by the trailing PD_SCK pulse
count after each conversion:

  25 pulses (1 trailing): differential input at 10 SPS
  26 pulses (2 trailing): DVDD-AVDD supply monitor at 40 SPS
  27 pulses (3 trailing): differential input at 40 SPS

This series first extends the existing HX711 binding and driver with
preparatory refactoring, then adds HX710B support on top.

The differential input is exposed as a single IIO channel with
IIO_CHAN_INFO_SAMP_FREQ, allowing userspace to select 10 or 40 SPS
without needing two separate channels for the same physical input.
The supply monitor is a second channel at fixed 40 SPS.

Patches 01/11, 02/11, 03/11, and 05/11 have already been applied to
the iio.git testing branch.  They are re-included here so the series
applies cleanly as a unit.

Changes from v9:
  - 02/11: Added dvdd-supply alongside vsup-supply. Per the v8
    discussion, DVDD is a board-supplied digital rail on the HX711
    (figure 1 of the datasheet shows it as a separate input supply,
    not merely a bypass capacitor point). It was missing from the
    original binding. Moved its declaration from 04/11 to this earlier
    shared-supply patch.
  - 04/11: Removed dvdd-supply declaration (now in 02/11). Updated
    commit message to reflect the patch now adds only vref-supply and
    the allOf constraint.
  - 06/11: No code change. Removed inaccurate below-the-line note
    about __counted_by_ptr() commit reference.
  - 08/11: Remove blank line between val = hx711_wait_for_ready() and
    if (val) check in hx711_reset().
  - 11/11: Revert IIO_DECLARE_BUFFER_WITH_TS() to explicit named
    struct (both variants have exactly 2 channels). Add
    iio_device_claim_direct_mode() in hx710b_write_raw() to prevent
    concurrent hardware changes during triggered buffer capture; drop
    channel_set = 0 reset (hx711_set_hx710b_channel() re-programs the
    chip automatically on the next read). MODULE_DESCRIPTION: change
    'compatible' to 'similar'.

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

 .../bindings/iio/adc/avia-hx711.yaml          |  79 +++-
 drivers/iio/adc/Kconfig                       |   8 +-
 drivers/iio/adc/hx711.c                       | 351 +++++++++++++++---
 3 files changed, 363 insertions(+), 75 deletions(-)

-- 
2.43.0

