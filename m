Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2EC62FB97D
	for <linux-iio@vger.kernel.org>; Tue, 23 Jun 2026 20:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782245491; cv=none; b=iDav0u2sGB+4TAjYeqhaX24GWWuLgW+RAIpGUpFuOT4RoTpi6M1Ycbi8dWBFfmfHuIrTHMF5r1DJVvNsg9AnLB9ASj3/Wx0Qlfw5rIdPsjO5oqTRFOxx0EC7Ti93RIUdSe5YgP/ElP0oTgsFKGqgKSVIrJUYa9epjE6pontDRO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782245491; c=relaxed/simple;
	bh=w+znsPWR2m+FtXWrHaMqdzCF10WMGywSmA7kz9Jb7Jo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tiHyAYACNqI3WfSMNKwA+rQAbt7RipJekAAcCe/+enB9HBouOi3Ge5D6C3QtsDZy6U/eaiDfHDbPb/Z4z8h1gJd8obhPPR7NKAfWLPWOupxpRAgQfynD+XdWxNeWxMnm4l09iHUPlrGbZEs31p6m2OR26TZ7uf7t6w/VaZZSKeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lhnk/2K1; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lhnk/2K1"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5ad68b30252so278438e87.2
        for <linux-iio@vger.kernel.org>; Tue, 23 Jun 2026 13:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782245488; x=1782850288; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eemGmyIckec9AvxQSb5eEYFJSl0M4CtoU51u/KMfkvQ=;
        b=Lhnk/2K1N/4+Xp5qhGXa5lEaPN2cp0zR8vjZjAHMHqLU3cMWMajxaIT54s4I+hTdM7
         4WEF2s7hwvwew6XTiI3OJLVJg3wkkcsP1CIkgY77sbbu9C+Ttfx7df1OzjqN1yBIUmNj
         VeFE6ozvQsQHwANRCYnRAeyczXZGikryhWCUe6CVuIY7Lua0fHyJvb0FPdNgFCDekcVM
         hDt7XlmKHeAs8fB6IG3ZNDnCbLppUKBCT5dyGpcbdNf8fhg4g2eZ1/dj4JG6Odck1T+b
         JBdJmgne9KgkXtHet+h3qPHxmGD2P6yNCDhPL7QjiRHYjnVF1h8RS+MPihrrsmL6SFUq
         RVAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782245488; x=1782850288;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eemGmyIckec9AvxQSb5eEYFJSl0M4CtoU51u/KMfkvQ=;
        b=kAUEDkCJ2SlKybwk7xrZEWQSBWcrc0cqhd3pVbKf431IOi3fETg5AfIDCuiCHKYTy1
         cluEaXzW4391flYasNANBfQjuF+3VxIDypNobjwv6mMOZ6D15s+vL+wz7FGxjY+JknXO
         TFCp4CYpRsbTTgXkDUbqngo2buZ/dq75904Tx2A/prQWLOUw0sTlE1ZcYkpNYqOzykgl
         dmpZ74o5mwcE1Eemz7kuGKzNqmTbxN4Dq7oez5IGs0zJlEH6afWOc8puDaA4ejMoYGpT
         ++vJ0448B/4d44VcwVhrdSRrm295YzrAkYkv6N82qRSSHEeCdH0H2zHAFHjNDxLpt9lA
         fsHQ==
X-Gm-Message-State: AOJu0Ywe1clrn1Ioio4fcjvHV8Vfdrox2trgJfiqRcpb3p2uVTgkHEfC
	Ul4SJQLL+HjltRciLgHjUg1xugPMHXzd66u6XEWBf+FwQ95ZLJRz1K6x7SfFkWSEIYml4Q==
X-Gm-Gg: AfdE7ckyPIu8XvzDW583w7nk9niifSPmtB+ArolSVCmltFEvX1YA6fikcDiIOfCTC0+
	RxARmFmrD1AKRxS50WsV1ZvvlQ5VE/8dy9ocyCeb0YA1/2SJtWQSoFNh3ObNOlW5WM2aRMNyBrQ
	WHri9XwX8PPVwcb6lneneU1pny4AP6XHhl7giAu1PrFOhq1wcwcAk8th5MhpnzBMCoQj9FpYRPB
	FroXjzuIaJdRjkqMiCTY02s7mT8Wb66Mrn8wqn5IfILcZYa0UxeBLhnoAy1YLtz32O8rY4MvJzH
	Q13/WZEVVCPINF5/KkTiyMRx5+4NvKbBACzRaWgJgt4efjIDkOGsx0H8up1Cagnu0yVG1vyCKNL
	AGrpNS7ekKwdkLE1DmpCvCzKyprNKD4tqIJcanmj9KYmVoCZQOxyD9/nPlPWaBmOKzFvhyJ7Ubk
	16jPnj/WGcKQ4dSELX9VEANBo+oriACvUJ9j/dNb/3KPoka8iTZDg55vxt
X-Received: by 2002:a05:6512:4605:b0:5ad:3035:b353 with SMTP id 2adb3069b0e04-5ae9d5b8117mr7515e87.53.1782245487593;
        Tue, 23 Jun 2026 13:11:27 -0700 (PDT)
Received: from Shofiq.home (87-92-251-137.rev.dnainternet.fi. [87.92.251.137])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5ad69551082sm1063392e87.26.2026.06.23.13.11.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 13:11:27 -0700 (PDT)
From: Md Shofiqul Islam <shofiqtest@gmail.com>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org,
	lars@metafoo.de,
	conor@kernel.org,
	conor+dt@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Md Shofiqul Islam <shofiqtest@gmail.com>
Subject: [PATCH v5 0/3] iio: health: add MAX86150 ECG and PPG biosensor driver
Date: Tue, 23 Jun 2026 23:11:20 +0300
Message-ID: <20260623201124.18271-1-shofiqtest@gmail.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20260623174600.17100-1-shofiqtest@gmail.com>
References: <20260623174600.17100-1-shofiqtest@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes in v5 (addressing Conor Dooley and Sashiko review of v4):

DT binding (Conor Dooley):
- Rename binding file and compatible to adi,max86150 per ADI policy for
  former Maxim products.
- Add missing power supply properties: avdd-supply (analog core),
  vref-supply (ECG reference); make all four supplies required.
- Fix vdd-supply description: remove voltage tolerances; say "1.8 V".
- Fix leds-supply description: say "typically 3.3 V" (datasheet max
  is 5.0 V, not 5.5 V as previously stated).
- Rename example node to heart-rate@5e per prior DT art.

Driver (Sashiko):
- [High] Re-assign indio_dev->trig after trigger registration so the
  hardware trigger is the default and iio_trigger_validate_own_device
  accepts writes to current_trigger without a manual sysfs step.
  iio_device_unregister() releases the reference via iio_trigger_put().
- [High] Switch from devm_request_irq() to devm_request_threaded_irq()
  with IRQF_ONESHOT. A hard handler returning IRQ_HANDLED on a
  level-triggered line unmasks the still-asserted INT pin and causes an
  immediate re-fire loop. IRQF_ONESHOT keeps the line masked until
  max86150_trigger_handler reads INT_STATUS1 and de-asserts the source.
- [Medium] Fix overflow timestamps: when OVF_COUNTER > 0, pf->timestamp
  reflects an earlier A_FULL event and is no longer a valid anchor.
  Capture ktime_get_ns() at drain time and reconstruct timestamps
  relative to the newest surviving sample instead.
- [Medium] Pad fifo_raw to ARCH_DMA_MINALIGN bytes so that buf starts
  in the next cacheline. Previously the 9-byte fifo_raw (DMA target)
  and buf (CPU push buffer) shared a cacheline, violating DMA API
  constraints flagged by CONFIG_DMA_API_DEBUG.
- [Medium] Replace blind usleep_range() in read_raw() with
  regmap_read_poll_timeout() on the PPG_RDY bit. A fixed 11 ms sleep
  risks reading an empty FIFO if the internal oscillator starts slower
  than nominal; polling with a 25 ms timeout is robust.

Link: https://lore.kernel.org/linux-iio/20260623174600.17100-1-shofiqtest@gmail.com/
  v4 cover letter

Md Shofiqul Islam (3):
  dt-bindings: iio: health: add adi,max86150
  iio: health: add MAX86150 ECG and PPG biosensor driver
  MAINTAINERS: add entry for MAX86150 IIO health driver

 .../bindings/iio/health/adi,max86150.yaml     |  78 ++
 MAINTAINERS                                   |   7 +
 drivers/iio/health/Kconfig                    |  23 +
 drivers/iio/health/Makefile                   |   1 +
 drivers/iio/health/max86150.c                 | 730 ++++++++++++++++++
 5 files changed, 839 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/health/adi,max86150.yaml
 create mode 100644 drivers/iio/health/max86150.c

-- 
2.51.1

