Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B0704657F2
	for <linux-iio@vger.kernel.org>; Mon, 11 May 2026 17:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778521435; cv=none; b=JHVTteKAgucbxKeinTvbqYQyPRvXO8wMbtDq6WoF4ygXCwrFdPmnrDxOOc4KVUoPSZ6WlQmIKAE+Kqs1yG1Sv4/CoYf1b4Aqtk4hkeF5D8OfPsX0GcF00b1/UAXlVbvJRI44UsYx5jqidK+C7YJLdeIpKEmvfWQ53PIhc9NApmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778521435; c=relaxed/simple;
	bh=NZUNw0asM8Uh79fDTRNXCJ95Tgrkji7DhAnpBxZELIE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oDXc69yT059XRbSVSOiC/3U3r+ZCNdxLqRgusY3AWVwJmGiIeEAwATDrEJG6Z/n6hoS/y2zJupWiaGKxCNV0qR5lOwcVzmIzI/RumizqToGoxytPHviDu0D1qBfJhzK7V+t7t/uF5Qr2/MjbozW+03JubHAA8I2lk6vGWQrgh24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ritCKHfU; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ritCKHfU"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2baca4df358so28272055ad.2
        for <linux-iio@vger.kernel.org>; Mon, 11 May 2026 10:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778521434; x=1779126234; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=B2jGSpuCkFnZZPSgBqwuaE2iTkPzgpCQONBBuaB+fDw=;
        b=ritCKHfU4elqPO1sNYB3ysv7Yeq4rKDVX3JJdVgi1iieqemLkLpk6fB5wHDL66ujAN
         rGV8ACqn1Rl/bHsEBqk6Dbs8RoUmbaj5km9DL/SpJqHTTz4GF3tmSbDn6jo39D9efHkW
         vJpujdioRaKhktECo1VVE/Bs6ZrPOVhHG1HWSDY/WgZfPmxZPJvQg4tkqPGuRoN4okth
         0ySpDnPoDV6vj7jyabKote550QjYUyKpBx+AZ59LVZ7QvdAKOboM0dKY4IAxXfEivIaw
         /bDNEPCoLVMZvZdvqRe4SrGz+okOOVxwgYl8D9ouAbzK3R8sU+vsT0+u21kpCVTRwsc5
         Kzsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778521434; x=1779126234;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B2jGSpuCkFnZZPSgBqwuaE2iTkPzgpCQONBBuaB+fDw=;
        b=Qln2w/M14o6I9OkoypcWmBUBrgaz/lziX38aXMJGwjmjjRTt02OsO/x7tBGyfyPmcU
         +TN1uW/kXlQCaZtG8fa2FgOhlFGv+SylZcm5q2P1BgxHwvqisSBbnh1ASNWZzHFbr5UJ
         M0GnL9oNfsMEVZ1foYcx9tkOz0NNxtCkDx/+5dYFla1MUZT90yHRPV+l0PGdm8hAbP3Y
         C25/8rU1sUtIBVuurlZpJmG6sE6ThTn8OPltNR4L3/rog/pxVEWR3W2v+giT1cny47aG
         27/uaQ9Xt0SFbxhg9EVtq4gX+NXKqCFyeezxoMBit+0LkBTxSNEMcpNYcv1dFkRk5fJ4
         xcFQ==
X-Forwarded-Encrypted: i=1; AFNElJ+n/DgwIVxVDmIMgNpyKcPEluvSXpASxPcyO+TCjZCah2OUytdTCJY7HECCiWX0Zyw0CkS3bVea3Ts=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgYTsq5267zN6Fu8yk41BtzmEij5+mZqR2sRaBB5Dr1/5VFPxg
	xnffefqZGT1Oey7Rn73BXVuJFWoy6OgJKHYXyFzfYMtGjgNYux4fcgqJ
X-Gm-Gg: Acq92OEDafxiF9j1oDeRkRxZFSp8NstDcmHo4CUa6jGrYjZoktrUTRqfqT0RTQ1Qtol
	STeMfUnE47TbARaTey8rTsGpFA9kh2oNlW/2xwcwDZMPAe5cDrGf8W2GEvdmb2V0x4TyrBO0YIX
	ngevwIFE1Jy1LcVurV4V9ZdCMQECFiJrNjrUSNKS444V950yPa8fxjP2xLGHS4/oEkOcMCquOjq
	J4s4uFHyi0898GsUCqN+1Gn2DvUnRTzL92rwRBZKLNzwEiEDpyy1IyJLpjQACkkwnWvGgfhNPm8
	MtevkDVfXTe5fzD51Y6NIRkLWXDC9OTx1G9dJ6v2sPd+cvqGgI0OJP4CDITM93Jb/qJYTpwp25O
	Kc5KvdUGlm+IJ1dKvxxVuVrO+HQPJMpSGuTKUJjymmWGMpdDHycyqFDlfDBp2aWx8ZL4hVGpOYt
	yXSyqT6EJGkvD8k4k2ezUtQ3blyu8AKjr/dTMnaxxTBQeJEAhGJlDT52xQOSH0LU5+DlHCvZ/2j
	BHCqSqVRnmZ4kNFjwcRhsmgYBAZ42K2JRonOSkKA7fSlOb1ig6L9+W47jJZ7oM6hvP8rpA=
X-Received: by 2002:a17:903:2796:b0:2b2:58c7:2ce1 with SMTP id d9443c01a7336-2ba7a345555mr192439805ad.36.1778521433704;
        Mon, 11 May 2026 10:43:53 -0700 (PDT)
Received: from lord-daniel-VivoBook-ASUSLaptop-K3502ZA-S3502ZA.www.tendawifi.com ([14.139.108.62])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1e365a1sm106838425ad.44.2026.05.11.10.43.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 10:43:53 -0700 (PDT)
From: Piyush Patle <piyushpatle228@gmail.com>
To: jic23@kernel.org
Cc: ak@it-klinger.de,
	andriy.shevchenko@linux.intel.com,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v8 00/11] iio: adc: hx711: add HX710B support
Date: Mon, 11 May 2026 23:13:25 +0530
Message-ID: <20260511174342.123820-1-piyushpatle228@gmail.com>
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

Compared to v7, this series folds in the remaining review feedback:

- patches 01-04: add Acked-by from Conor Dooley
- patch 06: reorder hx711_chip_info fields so channels and num_channels
  are adjacent; annotate channels with __counted_by_ptr(num_channels)
  (Jonathan Cameron)
- patch 08: add blank line between int val declaration and its first use
  in hx711_reset() (Andy Shevchenko, Jonathan Cameron)
- patch 11: add blank line between linux/ and linux/iio/* include groups;
  replace the open-coded triggered-buffer struct with
  IIO_DECLARE_BUFFER_WITH_TS(u32, buffer, 3) (Jonathan Cameron)

Tested on PocketBeagle2 with an HX710B breakout module. The device
probed successfully, all three channels returned stable raw readings,
and alternating reads confirmed channel switching between the
differential input and the DVDD-AVDD supply monitor path.

Build-tested with:
- make -s W=1 drivers/iio/adc/hx711.o
- make -s dt_binding_check \
  DT_SCHEMA_FILES=Documentation/devicetree/bindings/iio/adc/avia-hx711.yaml
- pahole -C hx711_chip_info drivers/iio/adc/hx711.o

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
 drivers/iio/adc/hx711.c                       | 311 ++++++++++++++----
 3 files changed, 312 insertions(+), 84 deletions(-)

-- 
2.43.0

