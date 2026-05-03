Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEF3A3AD526
	for <linux-iio@vger.kernel.org>; Sun,  3 May 2026 12:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777810203; cv=none; b=Gwf9JrFVV3beKXsZ1TRmfroV/NRri/vwCW4ZuoMWu/RmeTEihPWppWiQQd5pPHbx8S4w3Tgi+IlD6KY/jR9UmboCD2zVFMpg6G7jG5mloCmaw1QMwhr+R8u11AZiNk1Rizk5I0YSJrpfliPXXimjpOBWnumEq+rCMLYyZeMNzsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777810203; c=relaxed/simple;
	bh=SV3B/g37WUP64p+W/862f7gX61rxiGRnF3JOrS/DGIE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AO83d5fZkxU6LwxCxKOoK2WFU7q69+okbp5AOe2LuMUqCvtDbk0E0Pd9Vx8KLydUh7z3mnE7CLBucCQqNkibWg2cswxj+/SKiGe0hb0VwSAAX3bd9UIDz29MJN7nfr3O6ejGdeTkSOj1kyQR9qEa82880rP6QvlEcv7gYXiA+t0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fEC457Xa; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fEC457Xa"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-c8173b2af32so108191a12.0
        for <linux-iio@vger.kernel.org>; Sun, 03 May 2026 05:10:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777810202; x=1778415002; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4mATdg5TAnsv6yqujjYHQNli4F9uj6Nj2HPuDvR1YhI=;
        b=fEC457XaFCM1Xba3ntKWUYC9AqVpG4z+VStiZzWAAzDDILlCI1XhUC2qiPqy3mvb10
         bIgkeCohVZAqdwejeqn6ueVbXqqpTD9IQ7yPXASdm8EVfmqJG1Qix1q+ehVsVZotKRh0
         q6s+pmc4bUldg+ZUVpwgdy4I7mndjroRuZ/6ZwZXwQk8Cq88B6l+efugkNVERctFVM6s
         LgN339V5P14QnErw/3CSCVJOsn3y/PXzO2f3r2XOVEOIix+MpQfwhLZ370lVhFm8HbZu
         Ousqm3DOFA1UnVCv8OMcdib38RGA4RGSP0Tf5XwB9tL0W2bLelv4O4760x3xDuXdkV8p
         Hikw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777810202; x=1778415002;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4mATdg5TAnsv6yqujjYHQNli4F9uj6Nj2HPuDvR1YhI=;
        b=FL1B+M/oSNGJe2tWmh5wN+GudpnLo75it6YhhhIS/85BW4QcnY2r3UC9/5Es65Uy3m
         KwA6SjaFACyNWyUhJMNL56BXx7BiNHIVNb73fQ+JGp0skQPtGbhiugbHiTlend50/ACc
         YPl0ho82a3taBpZSf6m6d1nWDq/+wSytSqNqYZpxlVlLSilA9fAMoxz5XGuriIj7jt8+
         xm1x0FeNeWECGD1COr45h8U6ziVwWiZYmrMclxY7OkarZOS6qQpf0Y1XJsG9f5sF5M/5
         VwlINPlOawiCB9vGMG9zilvNIR48B0aP4gT3ph7fdX6Bwj3ujwRjk1VT231mg8FTdWVA
         raTQ==
X-Forwarded-Encrypted: i=1; AFNElJ+RDSstIheKltehZfr4LR+hsy50EKa5KOOglDUsvLBEKfawzVgA5AFih10FLB1etm5tLVc+imzUyN0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxX39Yson+ngzQ7eAUB/z8ZHZxzkiC9y6rYM7lfQ3Mmii19+tL
	7I8zqUAkLNQO+cgTXI7/SHbwG78oMuObfoYf9mOY0K9CUWi5J6Zipje/
X-Gm-Gg: AeBDies5YLg8bwDXnuITEiyfgtphVjEIrHNo/NXtzVv6ohZshPxleyEOO3kPs1Jg7u6
	XTjhE4QvJsCWYfN+bI4fl5m6JCgjanGzWTafJjzyE+JdjUc14UTSPou15y4RbwKiDdXebekGFDF
	CfiicHOOUuNg9Vfio7bsqH7YVEtK7SG+n3xT7BiaptlNLshPCRxhty2260cnPINId4hgzIZlHxL
	YrURr4yc2IjvzLRFIIWdjne1fJJJWq0f/XBgaZI0ozLZd4I52aiVuIUCmTgHzlhRDDit3Svhorn
	Qj4CdLfU+RAYkBoV9OOZr6TPUwFTHDuloTjQT8yjVxOo2A11BNeXzSBqRuieMcuUaZZ04XpKMPO
	u2rEkGJ85bfmDNkJQ1LaEXwiTemM7w/szOL0OOfaNf3emiG/yT5Zl4TcGgdyWt4kiTqaEJsRYYc
	4BwSxCah1TLHmz+11bnw8wuNdh8htHmP8tAkYIy6QKQwJuqH/cS0FSxHJzS9zsf6GrD0B4tZFXt
	TNG6CWUQvpAWPQsGLpr0iv36BwZ1KQENSh/cQEjDlWDAN9goJFnYl7t7EyV+SXbQnYXOE0=
X-Received: by 2002:a05:6a00:bc8f:b0:82c:9e00:f958 with SMTP id d2e1a72fcca58-8352ce6e3cfmr5583554b3a.0.1777810201788;
        Sun, 03 May 2026 05:10:01 -0700 (PDT)
Received: from lord-daniel-VivoBook-ASUSLaptop-K3502ZA-S3502ZA.www.tendawifi.com ([14.139.108.62])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8357c4f4530sm1474364b3a.9.2026.05.03.05.09.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 May 2026 05:10:00 -0700 (PDT)
From: Piyush Patle <piyushpatle228@gmail.com>
To: Andreas Klinger <ak@it-klinger.de>,
	Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 00/11] iio: adc: hx711: add HX710B support
Date: Sun,  3 May 2026 17:39:29 +0530
Message-ID: <20260503120949.80292-1-piyushpatle228@gmail.com>
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

Compared to v5, this series is unchanged functionally and only folds in
the remaining review nits:

- keep the per-variant probe local declarations in reversed xmas tree
  order
- add a preparatory split-assignment patch before the loop-iterator
  cleanup, then keep the loop indices signed to match trailing_pulses
- replace the 24-bit read loop bound with a named constant while
  touching the same code
- keep the driver wording aligned on "weigh sensor modules"
- rename fixed_gain to has_fixed_gain and drop the channel_set cast

The DT binding split from v5 is kept as-is:

- cleanup of the existing HX711 binding text
- HX711-only VSUP documentation
- HX711-only RATE GPIO documentation
- HX710B binding addition

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

Changes in v6:
- Fold the remaining review nits into the original 11-patch series
  rather than adding follow-up fixes.
- Keep hx711_probe() local declarations in reversed xmas tree order in
  the hx711_chip_info patch.
- Add a preparatory split-assignment patch before the loop-iterator
  cleanup and keep the iterator types signed to match trailing_pulses.
- Replace the 24-bit hx711_read() loop bound with HX711_DATA_BITS in
  the loop-iterator patch.
- Keep the driver header wording as "weigh sensor modules".
- Rename fixed_gain to has_fixed_gain and make channel_set signed so
  the HX710B channel comparison no longer needs a cast.

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
 drivers/iio/adc/hx711.c                       | 299 ++++++++++++++----
 3 files changed, 308 insertions(+), 76 deletions(-)

-- 
2.43.0
