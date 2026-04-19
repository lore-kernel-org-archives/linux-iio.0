Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF175C8CE
	for <linux-iio@vger.kernel.org>; Sun, 19 Apr 2026 17:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776620829; cv=none; b=Wl5v/C9RbV0TdGgrXLPRs0IVb/QcDd1BHMwTnydfjmF6Bcjmn97UlTl/tnSdTnyOMASoA5D6r3uNncoMLbHhvsVSEqjNhCT1rOJS2wUN7kblozpYCzAOGtxs0SbIuOXftrn3cFYGUQ7QPA7F/eAdRh9tP7/kleLl0AizwVucPyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776620829; c=relaxed/simple;
	bh=Qx/8Dms65l1UikupQqSxl2nd237/PWiqinWLfKLbJnU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=aM5sg1ayiUhNT0bWG5fO/VixxOw8VUp2yYQCxMF8rhX49dRMPoAl2unBEt3br/V4ackIRT141FlcZ+pZRqtfeV3aNM0I+LLRthZVsfUK2Z9YCRxFbZXddVy+xymsmg8dfZB1KECDUOBluoWMfJLPwLbZNYqHz4C/6cMRWjpvaEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zl09Q2gu; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zl09Q2gu"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-c70ea5e9e9dso827980a12.1
        for <linux-iio@vger.kernel.org>; Sun, 19 Apr 2026 10:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776620827; x=1777225627; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ERrK9KzPz/6QTTpTeLhgh6SvGfjWToynF1MxQf6ROgc=;
        b=Zl09Q2gu0y4tzOYJ/oErg2ba1NSf6R/9uOSxrmS3Ap9PgY4G3bUHAdtVGyJHoiElnf
         fua3p9drnT64JjRviKkHeHC51B5FKS8OsYi8IZj/Qmr9OPDwgMOUgWKy3rHafXnIYQLH
         f/BCsVcIzSXxtY2GDsl+ET7RlcDWju8ydVOixQi5PugWYjFLBZbTAeWDxJuvZjZ2DRGa
         LM7gyvmXXkTF/RbObWZrcaBserjh7iLa4g8SyA8qErsgK4XyvDcymfPqpEzlR4ZaUufA
         mQHrDb72/bqL+NQGR+LjrjOmZECwUVapxii1HVAI5BmD7xrgXZ0wDKIV8HD0nUxY4gW/
         OndQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776620827; x=1777225627;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ERrK9KzPz/6QTTpTeLhgh6SvGfjWToynF1MxQf6ROgc=;
        b=XB1EozbyL6p9eJHs9K8fxJ+S85L64d0SaR5Pcit5QGm0IJzcqTaDi1WWNKMrNvzrw/
         hQAdmHVkePu58VKcz7o+kdjdOBaLMEXVeFMM0VZZqidt3Jc4kP0uvT/5rDhYMUuz77LM
         qmKE8MURMRUCC8Jk95cdsklNpW3dtjBEbZL6m/yJKf3o32+ZpgVvvg3p/9Uoo8pm+GWE
         zNDNtoHspAHbaf7EeNCJL8IGVYorPnKN43od3RXIefmoFISdsw4Vj882cdNEAdnZ5Ovd
         nFBIKQDdQJeqwMVyIi44MuBGfz7MpMN3RxchQdHvxJwnYBWkU3yEeQld/bALnqV5qlv5
         hHCQ==
X-Forwarded-Encrypted: i=1; AFNElJ9e900JYpdnDRw53IZTpO//D8jvmFdWQD8hM/d7cRw0ZhIMYTpQmvf+cCqvegDHGI802qrqAbqtViQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUDhjGvI0zVRHzde+w7Oh1LPh91s/ULPPZZq8gm5MP/CEC4xw4
	fmZzfuId7wcfWFZ7A7uUZSi3gSB1nLOCWFXyQermSraoe1jTi5h3MzDd
X-Gm-Gg: AeBDievVyw7aKDUssCTJPTADjWsxFYXAoS5atcDilAOQC8e6O0hBoXmtl8Z6deTPiqD
	P1O2tD5EBrUgUNlx55nD1pqgnx0qd0PEEWr2JV/nVKZirmod+PUsFLQk15EnqFB2agdlftRu2RX
	zt3ngpQ4+Hp/gmvMT4K4SnLuLJ69ByEfOdtPI8JCrhT6gNNyGumOYHsdT2ly/90cvBgDB5j8A1D
	JxAbfS/dc+z/NZ+gPLLKnd3dM/M4Ulpm2wAgXn3IxsGFaM34kyoc4LM0YoFGB0XPa3QN5+Er0Ok
	bg+tpyDbcdwg3g3l67llpvElrtbS/6Ai0RWyINHZRNSFa9UF96F+7tI+r9LeP6Dq2UyM2adWU27
	t5M/wzi/qXYbNrGZpPYlPuITF/CyleJGmf4aCu0Mt/9irZouOMUP0NmAEkkSuJQS52vzM99LTFP
	62D7yIFXzJMvHCdexVcQuA6S/luxZvSnISo30OrmPzbCx+8cvLV6JWT+mWY/vLhsHtEk0+7xX4c
	Yu57n65g4Y6mOvY1kEU0Ko09a4hFsR2Ucx3nZk7IbH6FdXYflI=
X-Received: by 2002:a17:90b:3c0f:b0:359:87a8:e65c with SMTP id 98e67ed59e1d1-3614046c9f7mr10655185a91.17.1776620827253;
        Sun, 19 Apr 2026 10:47:07 -0700 (PDT)
Received: from lord-daniel-VivoBook-ASUSLaptop-K3502ZA-S3502ZA.. ([2405:201:31:d01f:1c1e:6c93:8067:7dee])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36140fe07c7sm7794875a91.5.2026.04.19.10.47.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Apr 2026 10:47:06 -0700 (PDT)
From: Piyush Patle <piyushpatle228@gmail.com>
To: jic23@kernel.org,
	ak@it-klinger.de
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] iio: adc: hx711: add HX710B support
Date: Sun, 19 Apr 2026 23:16:38 +0530
Message-ID: <20260419174654.683692-1-piyushpatle228@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add support for the HX710B ADC, a variant of the HX711 with the same
GPIO interface but a different channel and gain model.

The first patch updates the devicetree binding to add the
`avia,hx710b` compatible, document the variant-specific behavior, and
add chip-specific properties for supplies, the RATE pin, and an allOf
constraint for HX710B nodes.
The second patch refactors the driver with per-chip configuration,
pulse counts stored in chan->address, a dedicated fixed_gain flag, and
the differential channel descriptor for the HX710B input.

Tested on PocketBeagle2 with an HX710B breakout module. The device
probed successfully and raw readings were stable.

Changes in v2:
- See individual patch changelogs for full details.
- dt-bindings: add dvdd-supply, vsup-supply, rate-gpios; allOf if/then
  for HX710B; fix clock-frequency description; remove dead vendor URL;
  clarify vref not needed (AVDD serves as reference on both chips)
- driver: fix pulse count bug ({25,26}→{1,2}); move counts to
  chan->address; add fixed_gain flag; add .differential/.channel2;
  remove NULL check; drop reset_channel; pass iio_chan_spec * directly

Piyush Patle (2):
  dt-bindings: iio: adc: avia-hx711: add avia,hx710b compatible
  iio: adc: hx711: add support for HX710B

 .../bindings/iio/adc/avia-hx711.yaml          |  61 +++++-
 drivers/iio/adc/Kconfig                       |   9 +-
 drivers/iio/adc/hx711.c                       | 206 ++++++++++++++----
 3 files changed, 225 insertions(+), 51 deletions(-)

-- 
2.43.0

