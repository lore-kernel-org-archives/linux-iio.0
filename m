Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 729871FBC8E
	for <linux-iio@vger.kernel.org>; Wed, 29 Apr 2026 05:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777441553; cv=none; b=mHCQlqGJeUkpJ8Id4lVcWY3ig6DekMZ/JTFU7Jjs8kklAWPnLMnoBBAiyCUc71breYQYBBLsAbUiMEjj9XowG0kBVp+JzN8eTqNCFfANeeJy5EnSdSJnzV7qLaVM3h0xCIHaZCpNr8dYaw+L2E3KlXQ1TbNoNivQd7Hx1QqRO9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777441553; c=relaxed/simple;
	bh=nxNg7NtfdyKUXf6Mec43Zr8AJokULKubqI9quirONLM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kS750j6KGU+zxqXFtJt6MyxsH4ClL0B/C0kfaUaZ+LpNsJN7XcR2lw13usHxmBwJAVJ9QIn6cbYjoH7Dlc7fiqK+r9UKmJKla030e9j2JsJrp2bevaSKL5pItAfVSV0R4D08mZ7ss5xbhmWHxeiKPMvbp7NhcqjLFYOxmBnzn18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KM8CGnA7; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KM8CGnA7"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2b299b3c739so56583825ad.3
        for <linux-iio@vger.kernel.org>; Tue, 28 Apr 2026 22:45:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777441552; x=1778046352; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oMW9RJTabJGll7g2jproro/xSxaIObt3HX9Zlu45nvE=;
        b=KM8CGnA7VrZx+6rkV7OdE1+/sd5qqEXW0aiYELkNGQqzgxj2kyHr10pXokAxzZUvHe
         Osbb2nEcVWeUCbx4/zhF55u4c3KHI7EDFiZyK2f+XW2APU5BUl8Axq4ErA4FSkT7Npse
         3SdZYNseYm0HWAPwet4owSKhyfUjo1qnMCRlAEA+UApUWxTW1hS7Y54DxHNzy8LOEQG8
         q8THeMqXpIEKoU+xoMrKrtxDvN9K4uryCvBSr5MSNN6yWWWkzy4Q7fawddnN6flciw/J
         qmTNd8BljXy7umsQxuLxugYwl0HBN9aTNgZEX8WTX30c9YXSQ8zyWfNTkWXu8+fKDYyG
         UtLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777441552; x=1778046352;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oMW9RJTabJGll7g2jproro/xSxaIObt3HX9Zlu45nvE=;
        b=L6c4KxLgUv7HX9j/qhFhy0R+Qid1fQFW8MVvHCWbn8Eo42J0HXtA7jPj654wxrXW8Q
         l8mzLiI/hYJG3G4DANchVDkmEqXxyLkrmfNyxL4pWvOPSvwKiZzgjNO55jqw7r7vwxKL
         pyru3m8CTHnRYRfJt02J5W7jpvy889H1jvzpMPw8cnU7v8/QS3RgMEZkm+73nlj+MMme
         p+B/26JSoj+Wo8r1fJvIGDX7NNuzRuGJ0Ousmi2nyzNGh97Tmv3cA3M7ClsSWkTR8h2u
         iRkZ9qucaYd1kZma4GBHc3TfUNaLw0ejrL2vILlq/GUqhJJIPk+NduYRaycK5wNaMPYx
         Kl+A==
X-Forwarded-Encrypted: i=1; AFNElJ9/HEPmpihmiy81hTA49n5EiUiR67nta9k6cCX1T/+FzwnlQXb8cgsyhbvPTiy5NNk01cHnl5sLrjM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywbog7JBrVsvXrsaBEda9r5OuqxUkN4M8PJuSHdGw/gTfTz9geJ
	oc4vUBqNgB8dtmYF40b4fFFxoT74LFvOj3TzUB/l7m2OHfjXEPDFrTtu
X-Gm-Gg: AeBDiesfC3fbi1xZZdySiZraaHggrIG+UWDVUHHOhD2pWFXwCgdd/ve/ctK05y6n5xw
	zz6TvL3uG5Wjy+3xdk1t1+AGMLDmMZb+3/oiDQsuPhAPLk8xoefNTj7oKvzUGa2hFpHYaDCbBE1
	I/gWtsP2sGrC9RG/KokSaFok7n9dwJNtwlYg/HQFgQWOzZUL55NbhDKPuhu+P/88q/37PC5P9vX
	9U5pSzY9bemyvOHgwHzq1UHzEijxQzV99zbvJZ6AWdBtgqQVyKZ5lPBTd40jLw2VWdbWiTVxr+P
	6A9ITD6LLvMTiuPv4EFrBYHnjO45miesfuNcdIHQl6nErKF5P3feB2Nlfvv6lHvYDON5kcajQ3x
	HOTroGEsZA0/nY/6rxyjvHziaRwDpMaVOaDoiKz1bDX8KnZarTD5YPW6W60cxtTEIUBPbvYTSKA
	y53lYOZMsR//+aoz4Ugt8NiEgUe5mJfOc59faseUdAFhABIrWqMs+8SU8dcOA2U5/n7WLJSgKXb
	EiX4SYo1IVdiuT28PUDS2a+2MvxOW3jwHfqYf2iEfoykyOY3A==
X-Received: by 2002:a17:902:d2c8:b0:2b2:a6a2:c8ca with SMTP id d9443c01a7336-2b97c40028dmr64209035ad.13.1777441551527;
        Tue, 28 Apr 2026 22:45:51 -0700 (PDT)
Received: from lord-daniel-VivoBook-ASUSLaptop-K3502ZA-S3502ZA.. ([2405:201:31:d01f:5fb:20b2:c2f6:85bd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b98879656dsm9346365ad.25.2026.04.28.22.45.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 22:45:50 -0700 (PDT)
From: Piyush Patle <piyushpatle228@gmail.com>
To: ak@it-klinger.de,
	jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 0/11] iio: adc: hx711: add HX710B support
Date: Wed, 29 Apr 2026 11:15:33 +0530
Message-ID: <20260429054544.123862-1-piyushpatle228@gmail.com>
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

Compared to v4, this series is split more finely to match the review
boundaries requested during review rather than because the feature
itself grew materially:

- the DT binding work is now split into cleanup of the existing HX711
  binding, HX711-only VSUP documentation, HX711-only RATE GPIO
  documentation, and the HX710B binding addition
- the driver refactoring is now split further so the trailing-pulse
  parameterization, loop-iterator cleanup, and hx711_reset() declaration
  cleanup all stand alone
- the Kconfig help text, file header, and MODULE_DESCRIPTION updates now
  sit adjacent to the final HX710B support patch instead of appearing in
  the middle of the refactor sequence

The resulting series is longer than v4, but each patch is narrower and
maps more directly to the requested review boundaries.

Tested on PocketBeagle2 with an HX710B breakout module. The device
probed successfully, all three channels returned stable raw readings,
and alternating reads confirmed channel switching between the
differential input and the DVDD-AVDD supply monitor path.

Build-tested with:
- make -s W=1 drivers/iio/adc/hx711.o
- make -s dt_binding_check \
  DT_SCHEMA_FILES=Documentation/devicetree/bindings/iio/adc/avia-hx711.yaml
- pahole -C hx711_chip_info drivers/iio/adc/hx711.o

pahole reports hx711_chip_info as 40 bytes with no internal holes. The
remaining 7 bytes are tail padding from 8-byte pointer alignment.

Changes in v5:
- Split the old combined DT binding patch into four patches as requested
  by Jonathan Cameron:
  existing HX711 text cleanup, VSUP, RATE GPIO, and HX710B support.
- Keep the HX710B binding patch limited to the new variant-specific
  properties and constraints.
- Require explicit vref-supply for HX710B nodes and use a single
  if/then/else schema block for the HX710B versus HX711 constraints.
- Split the trailing-pulse refactor from the hx711_read() loop-iterator
  cleanup.
- Add a standalone preparatory hx711_reset() variable-assignment cleanup
  patch as requested.
- Move linux/array_size.h and linux/dev_printk.h to the chip_info patch,
  and move linux/types.h to the final HX710B support patch where it is
  first needed.
- Fold the Kconfig help text, file header, and MODULE_DESCRIPTION
  updates into the final HX710B support patch so they stay adjacent to
  the new hardware support change.
- Keep patch 10 as a standalone preparatory cleanup because Andy
  Shevchenko explicitly asked for the hx711_reset() declaration and
  assignment split before the later HX710B change adds another local
  variable there.
- Add the preparatory rationale to the hx711_chip_info commit message
  and use "missing driver data" for the NULL match-data guard.
- Do not carry the earlier DT Reviewed-by tag because the binding
  changed materially again in v5.

Changes in v4:
- Fix the pre-existing global scale mutation bug (new patch 2 in v4,
  now patch 5).
- Split the v3 driver refactor into smaller independent patches as
  requested during review.
- Keep hx711_chip_info fields in their final order from introduction so
  the HX710B patch only appends new fields without reordering existing
  ones.
- Add vref-supply binding and driver support for the HX710B VREF pin.
- Add a third HX710B channel (27 pulses, differential 40 SPS) from
  Table 3 of the datasheet.
- Use .channel = 2 for the supply monitor to avoid clashing with
  .channel2 = 1 of the differential pair.
- Remove dvdd-supply from the HX710B forbidden list in the binding.
- Add the NULL guard on device_get_match_data().
- Fix checkpatch alignment in multi-line hx711_read() calls.

Changes in v3:
- Split the hx711_chip_info refactor from the HX710B feature patch.
- Fix signedness and update channel_set only after successful channel
  switching.
- Keep HX710B scale based on the documented fixed gain of 128.
- Add direct ARRAY_SIZE/types includes where needed and use pahole to
  verify hx711_chip_info layout.
- Rework Kconfig/header/module description wording for compatible ADCs.
- DT binding: restore the example node name to weight, drop the extra
  HX710B example used earlier, and avoid repeating the clock-frequency
  default text.

Changes in v2:
- DT binding: add dvdd-supply, vsup-supply, and rate-gpios; clarify
  clock-frequency as SCK bit-bang timing; remove the dead vendor URL.
- Driver: fix the HX710B pulse-count bug ({25,26}->{1,2} trailing
  pulses), move pulse counts to chan->address, add fixed-gain support,
  and pass iio_chan_spec * directly where needed.

Piyush Patle (11):
  dt-bindings: iio: adc: hx711: clean up existing binding text
  dt-bindings: iio: adc: hx711: add VSUP supply property
  dt-bindings: iio: adc: hx711: add RATE GPIO property
  dt-bindings: iio: adc: hx711: add HX710B support
  iio: adc: hx711: move scale computation to per-device storage
  iio: adc: hx711: introduce hx711_chip_info structure
  iio: adc: hx711: pass trailing pulse count into hx711_read
  iio: adc: hx711: localize loop iterators in hx711_read
  iio: adc: hx711: pass iio_chan_spec to hx711_reset_read
  iio: adc: hx711: split hx711_reset variable assignment
  iio: adc: hx711: add support for HX710B

 .../bindings/iio/adc/avia-hx711.yaml          |  77 ++++-
 drivers/iio/adc/Kconfig                       |   8 +-
 drivers/iio/adc/hx711.c                       | 296 ++++++++++++++----
 3 files changed, 305 insertions(+), 76 deletions(-)

-- 
2.43.0
