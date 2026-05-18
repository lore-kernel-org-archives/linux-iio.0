Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15095381AFA
	for <linux-iio@vger.kernel.org>; Mon, 18 May 2026 22:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779141759; cv=none; b=nJcvn0q5UnPwEeZioV2pSD6EkUOYykcrgyMEI6AKhunizwesws8qlqEZlJgQ3bWMHPsquaqfCeIjBvK9QeFA51den77n3NrFMIp/LROa72BWiDO3162ht5DNJlmC9g2ahdlUb1j9Sol5OHubIXvza6QsoMkbRvuIq/iiilKVPME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779141759; c=relaxed/simple;
	bh=acjswfeq8oZRH84QTr3JJj65K4KOGRFPYT+Pa4T4ICg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UkpLfGcObmir1B7Qs6m/GB2QqBM2fCDpCmY6cNltIGmis81G8wTI5lO+HMQmuc96m4v6TSGt/qw2wimcoWV4iRvwgePxkHYsafHuu7EiwLh/0ClRTKx2l8O3zi3p02BlNFeayrDCBhiIgQJVU6ug1FTMNKHq+F3sR3kDdcJz/1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FKVmGiPE; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FKVmGiPE"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-82f8b60e54dso2371259b3a.2
        for <linux-iio@vger.kernel.org>; Mon, 18 May 2026 15:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779141756; x=1779746556; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1yTPoUclSMNL0BJRpMJ7+gdny1W+4ZcS3G2Is/IZvIk=;
        b=FKVmGiPE0b35iZBxAxNuIVqXuCLFkKL5gBE23C4Y0oMFlOkIt8YIWNn3FAiCZq7ZT2
         X9AR8Rbej5P/6EyEtZxBxa2Vhwr/DQEL08tDj2uakBTDoIdF/EGJ0CZlEvYO85woD+m3
         T2ZsJ1Ytn9X5/URXPDxBEDaRTcktaaLxHFduzwpXcldPkxsmjW4RXL7Pe0BXIdm9DH7g
         RlFqMXwr2E7bkU3sElQl+a6wYrSbRdCiTSHGg7x14p0XNgEEg5W41Pie/li6XDUy2yuX
         pJMOa6AvxFHERNmzGPSVXFRT7RQaNz3K+5ahLlcOmsC7Zszj42deiTk1PwRC1tCfvArs
         v0eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779141756; x=1779746556;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1yTPoUclSMNL0BJRpMJ7+gdny1W+4ZcS3G2Is/IZvIk=;
        b=Zfz2MJHpSx2pkVT0mUpigH8TnYvLHmMYcm4PwMnrImK0vpaTku1ZjZNf8KSuyc1yqz
         lPYNqlkTUAbR6b4hGgRzGty3glDOWZklkPIFns9asITN0LPSwOX0RKmnB9LgjJXFkovy
         fQrazbCvzqsH0sSEEv7jCwyOG0AWo6X6EtCM9nRGNwtET+zY5vxZYhxstxgD60sbl7FX
         qcGO7jYBtAbB3h1UfR8Ca8B369EdFFrmJI+EJCPjlxeQjjmHkkhJ9leICMLOdTfbc+qR
         Ed243RINxgHxyuhOr/WuVY4xvYkL0zKMEC5Np7j7oDvmu+8xXdhirR+Eseo9V+2ZUJNz
         Rj6A==
X-Gm-Message-State: AOJu0Yw/pdCOsJK3cyMAR6Be6osoXcBk412Eg4ps8E8j1m9UqoVco14m
	rsKXy1yWk5F17gK2GEpKEo/4Iz4YzBftw8g1Hy2/KGs92ovWXjsppUMe
X-Gm-Gg: Acq92OE8bcK2vmRkL9JZij1Tyh7g9/P9wpNzCro4q9+L8fWwg7Snebf5tstaNNjuCb5
	5MpuoMHZ5YuKJDieLj9r4HiqWxCoa5qP8UDb+Q0KnQ0uaMxPWw06x3n+yC+Q430Jxn9eHs4N9py
	8e2sehqlNEN0sf3t27rRiR72v6gyqpiAtBzvWg5jC71q7YyRGf/LRqZB+o2VnGE9nR7YKKwAV8J
	5AJ6ec35F0vPFjopQZKhMVpm7W4kxu8Nl78YJx6D8e7Bh364HoSWFkQbes/7CRsxRBGj0SIFw0P
	sYNzpFXxfPL8qG7c1ZPUFY+Z3vC5BKGLH5VMlE0Bc+OSvGqojJN+aY4QoWNPbwt+z5tvbEUoPPE
	fS7TH7I9ppjf2oEFwfW99judQLsvx4eT88b1TBk1r8O3ygvXLkXPNKZoti/1mpL0AoNwrqOUMwl
	RzfDPoaHIKIEWqLUfiFe1S03uBpqLguMqTWqiMCTQ7uVpNp5ZHnKTHBAHDNdQWtjmyvsWjkuiQ5
	Oy9FAzR2DmTfvA+QgwvJOtH0zN+40rcF+Cl00FBv3DrxtBWfPmn5AU8Njrm
X-Received: by 2002:a05:6a00:909d:b0:82f:4566:bbdf with SMTP id d2e1a72fcca58-83f33c9a61cmr16922727b3a.14.1779141756403;
        Mon, 18 May 2026 15:02:36 -0700 (PDT)
Received: from lord-daniel-VivoBook-ASUSLaptop-K3502ZA-S3502ZA.www.tendawifi.com ([14.139.108.62])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83f1977b128sm15772960b3a.22.2026.05.18.15.02.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 15:02:35 -0700 (PDT)
From: Piyush Patle <piyushpatle228@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andreas Klinger <ak@it-klinger.de>,
	Andy Shevchenko <andy@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>
Subject: [PATCH v9 00/11] iio: adc: Add support for AVIA HX710B ADC
Date: Tue, 19 May 2026 03:32:16 +0530
Message-ID: <20260518220228.63322-1-piyushpatle228@gmail.com>
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

Changes from v8:
  - 04/11: Dropped a misleading sentence from the commit message that
    suggested HX711-only binding extensions live in earlier patches
    (they do not; the earlier patches extend the shared binding).
  - 06/11: No code change.  Added a note below the --- line clarifying
    that __counted_by_ptr() is available since 6.12 (this tree is
    6.17), so the annotation is well-defined.
  - 11/11: Redesigned HX710B channel layout per Jonathan's v8 review.
    Modes 1 and 3 both read the same physical differential input, so
    they are now a single IIO channel with IIO_CHAN_INFO_SAMP_FREQ
    instead of two separate channels.  Added hx710b_write_raw() and
    hx710b_read_avail() to let userspace control the sample rate.
    Introduced hx710b_trailing_pulses() helper so .address is no longer
    needed in the channel spec.  Fixed hx711_trigger() to check the
    return value of hx711_reset_read() and bail out on error.  Fixed
    channel_set update ordering in hx711_set_hx710b_channel() so the
    field is written immediately after hx711_read() commits the new
    hardware mode, before waiting for the chip to be ready.

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

 .../bindings/iio/adc/avia-hx711.yaml          |  77 +++-
 drivers/iio/adc/Kconfig                       |   8 +-
 drivers/iio/adc/hx711.c                       | 362 ++++++++++++++----
 3 files changed, 362 insertions(+), 85 deletions(-)

-- 
2.43.0

