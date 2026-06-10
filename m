Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A45D048094E
	for <linux-iio@vger.kernel.org>; Wed, 10 Jun 2026 20:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781123714; cv=none; b=lVeFA5pStwRix3NK0aKGPaVzcZ29gDMgdqBHsnQOSMdtRwwuhF2/LZoZLRrFiztNYYzbMWJEZ2913XP4Lhc2XxszPyxUWWIWIGmRheAc10Gi2+EU7t6dnIilxxvH0LvZ+J6WNVbrnZRg7FaY4RUSZOmPm5g/duQnqbTN/LgpEpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781123714; c=relaxed/simple;
	bh=DfQ3P2bQ2EvWGbkuEOTmf9qixrRKxvxvLXH1fQ704HA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=CTxp1qw9y5fiOpffbwvpKQhr//IfsG06carVN/1ijzPD0VKUiKlcZsKRZn5oo/k85jkk9GdGIb2YxVVDCEtIdZoRSiPipibsHWNB0RFdxjNMRYuI8UyX5YG/TaIfXFMfO2sFHrLe3Jk+3NCddp4ns+2A2LXN2aSTfVOItqW4TaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=F2LICWHt; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="F2LICWHt"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-490b12270b3so43566995e9.1
        for <linux-iio@vger.kernel.org>; Wed, 10 Jun 2026 13:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1781123710; x=1781728510; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0uD+V1MP1IrfqCSKgnnEBQvMXliLpNg3JmnXmkFW/Zc=;
        b=F2LICWHtkCMnqy4Z6JoObNJa51LaGZmPDb+LFs3QW5/BmLaVKuldeY6E6b2U33RcjB
         biEG89iRIOMv8eUzchnbVBgtCWczrhGDE8HroQRmUmX7yFmwVVXZycH4/1wmJMB9S1pl
         yrTIFrd83RfgSug+udhG1Xgg6lCG340ZG0+WIM9L3UEzq3DjbbDCiQGN++iTPMrWgSG4
         4WImHSd4LxGRPx3vNlrVxtdVbv4dD3NgOZoCJNNZQdkPGADqlSOFIs7YwVdIwLkZ9dJZ
         s06WO60UAwrN9FAahPC9jlScuxStLemcbeBdDn+IwiR3mGGjCYZUKIqMDmS31uXL7hYu
         YBkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781123710; x=1781728510;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0uD+V1MP1IrfqCSKgnnEBQvMXliLpNg3JmnXmkFW/Zc=;
        b=F0HrA50lI7jqRd6o6c6LGO35ID2YqD4fyKZMhBgj3LjEKWQBmwRQPwZ37RCf3o9pUq
         YYv6BD0t9u1apUBVTNFyVS5vWhBjnQdY/CYoxJoJJ6uDFxMaRAMHTSSgnFhK9+ODNKnS
         L1yC0Xw8qoDNdA1TWsR+QM6nQsfWGRIMZgmdQ/TCO2CZeOMVMGzd3M3sVKSgJVeKIkyr
         +33vdF9UeO5IWpqcUToktHYfYBRaf4/DyJMgefaz3oru2v7l7njMUxou7NVmaom+fkwb
         7IoAlG9ZRKEEtZFGmtXRlTdq9yY97f9SIKK1S05bP65ylcvnzRs2hJuAQ2t+/Bgloj5V
         zH6g==
X-Forwarded-Encrypted: i=1; AFNElJ/5nmgZMU1mJ6Z1xPUefau0g/1xKMtb8wc+jpP+R3RiRDticHGPY/Nq1pCU5qG95Wgs9EtGIyFsuRQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcCp+AJmNuXGT9L8/At768nfl5rmx3w2kkSsup5FSLm3Fu6pA3
	ZLNbiMKvnUzk7H067NHxZMrtKylJUx7ieq6dstIL+kTKhb48LPuo+tAt/iMuWqGtszU=
X-Gm-Gg: Acq92OHaO5bIgNgFdrWwCUk/ie4XUJuTkXoSb7xMGaIEiUuw+YIF40vqHwMNECsjDgj
	YsLgCtfMuBVg6pVto2NnZ9YtbLeBy6Z919ya2scCMJeQ0e6/Yzc4vsMBfPPmir0CAS/gGmfeqsS
	XvM/E6yQUn8YxfgUVUGHdM3JiAgqyB7K9AX/rwcD+p4VnRqXMlLDaO6ZnBaYKc+vlmSewqnCAtb
	PmaDe5iuuvjszAmeQ8O5r7ssY2AUs4kZVyjtOkx/BfE7fQ2WTVCTKggrPCfsi0SWh16xBTL4Z8H
	NOvA2RsfOWEy1Ri03ipwNUMJHplCcx3YM2upO1tR3SR0Mg7zot4/XWpXj5X+aaNx2BTZOXKNupq
	XWVwQrgs+9Md4/Y1Co3rlRtLl80Xo1u5DLYhHVOAp9lbKo85JqeFNXf0llEy3Oh14YmGd6F9sZq
	CbfhN7Z/mhFPSbaUSASHPAcijPbmwLSoLQ8hBuRVjdLQ==
X-Received: by 2002:a05:600c:1f89:b0:490:e1a6:4d13 with SMTP id 5b1f17b1804b1-490e2d27954mr6307175e9.15.1781123709975;
        Wed, 10 Jun 2026 13:35:09 -0700 (PDT)
Received: from [192.168.0.2] ([2a07:7e81:7daa:0:202:c9ff:fe53:eda4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490dc4715e4sm62390975e9.0.2026.06.10.13.35.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 13:35:09 -0700 (PDT)
From: Angelo Dureghello <adureghello@baylibre.com>
X-Google-Original-From: Angelo Dureghello <adureghello@baylibre.org>
Subject: [PATCH v5 00/10] add mcf54415 DAC driver
Date: Wed, 10 Jun 2026 22:35:05 +0200
Message-Id: <20260610-wip-stmark2-dac-v5-0-b76b83366d5c@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4XOy07DMBAF0F+pvMZoxq+krPgPxGJij6mBNpUdA
 lWVf8cJCx5NxfJKc8+dsyicExdxtzmLzGMqqT/UYG82wu/o8MQyhZqFAuXAaJDv6SjLsKf8omQ
 gLxtwEM02hK2JoraOmWP6WMSHx69c3rpn9sPMzBe7VIY+n5bJUc131/VRSZCsKbau9QYI7zs6v
 aYu863v97O2VC3q9Wr0gdiCjxbpd3X+bdTf6xbMJaErAVYZwujR62vrSq1X0XUMFLQl16ys4z/
 rWIm2MV47MluEsEKYH4TGS8JUomFnqTMKbfhLTNP0CU94Sd0CAgAA
X-Change-ID: 20260430-wip-stmark2-dac-7060f49dd94f
To: Greg Ungerer <gerg@linux-m68k.org>, 
 Geert Uytterhoeven <geert@linux-m68k.org>, Steven King <sfking@fdwdc.com>, 
 Arnd Bergmann <arnd@arndb.de>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: Greg Ungerer <gerg@uclinux.org>, linux-m68k@lists.linux-m68k.org, 
 linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org, 
 Angelo Dureghello <adureghello@baylibre.com>
X-Mailer: b4 0.15.2

This patchset adds a minimalistic DAC driver for the NXP mcf54415/6/7/8
builtin DACs.

Currently the driver enables the raw write only. Feature as dma, sync, or
format are not supoprted for this version.

Additional options suppoerted by the DAC module will be added to the driver
later on, as needed.

The same patchset prepares the m68k/coldfire architecture to support
the driver.

Below some basic tests done on stmark2 mcf54415-based board, voltage check
on DAC0 and DAC1:

~ # cd /sys/bus/iio/devices/iio:device0/
/sys/bus/iio/devices/iio:device0 # ls
name               out_voltage_scale  uevent
out_voltage_raw    subsystem
/sys/bus/iio/devices/iio:device0 # cat name
mcf54415
/sys/bus/iio/devices/iio:device0 # echo 4095 > out_voltage_raw 
/sys/bus/iio/devices/iio:device0 # echo 2048 > out_voltage_raw 
/sys/bus/iio/devices/iio:device0 # echo 4096 > out_voltage_raw 
sh: write error: Invalid argument
/sys/bus/iio/devices/iio:device0 # cat out_voltage_raw 
2048
/sys/bus/iio/devices/iio:device0 # 

Same behavior for /sys/bus/iio/devices/iio:device1.

Generated a sine wave by shell script, sine shape is good.

is actually in progress:

Note: this patchset depends on mew mcf_read/mcf_write implementation that
Link: https://lore.kernel.org/linux-m68k/209d0653-6386-4b64-9e15-e358f84453ab@app.fastmail.com/T/#t
Link: https://lore.kernel.org/linux-m68k/20260506142644.3234270-2-gerg@kernel.org/
---
Changes in v5:
- keeping changelog in each single patch, where any
- Link to v4: https://patch.msgid.link/20260531-wip-stmark2-dac-v4-0-7e65ab4215dd@baylibre.com

Changes in v4:
- keeping changelog in each single patch, where any
- Link to v3: https://patch.msgid.link/20260522-wip-stmark2-dac-v3-0-16be0ad35a67@baylibre.com

Changes in v3:
- keeping changelog in each single patch, where any
- Link to v2: https://patch.msgid.link/20260513-wip-stmark2-dac-v2-0-fcdae50cf51a@baylibre.com

Changes in v2:
- keeping changelog in each single patch, where any
- Link to v1: https://patch.msgid.link/20260504-wip-stmark2-dac-v1-0-874c36a4910d@baylibre.com

To: Greg Ungerer <gerg@linux-m68k.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
To: Steven King <sfking@fdwdc.com>
To: Arnd Bergmann <arnd@arndb.de>
To: Maxime Coquelin <mcoquelin.stm32@gmail.com>
To: Alexandre Torgue <alexandre.torgue@foss.st.com>
To: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
To: Nuno Sá <nuno.sa@analog.com>
To: Andy Shevchenko <andy@kernel.org>
Cc: Greg Ungerer <gerg@uclinux.org>
Cc: linux-m68k@lists.linux-m68k.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-stm32@st-md-mailman.stormreply.com
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-iio@vger.kernel.org

---
Angelo Dureghello (10):
      m68k: mcf5441x: fix clocks numbering
      m68k: mcf5441x: add clock for DAC channel 1
      m68k: add DAC modules base addresses
      m68k: mcf5441x: add CCM registers
      m68k: mcf5441x: add CCR MISCCR2 bitfields
      m68k: stmark2: use ioport.h macros for resources
      m68k: stmark2: add mcf5441x DAC platform devices
      m68k: stmark2: enable DACs outputs
      iio: dac: add mcf54415 DAC
      m68k: defconfig: update stmark2 defconfig

 arch/m68k/coldfire/m5441x.c         |  21 ++--
 arch/m68k/coldfire/stmark2.c        |  47 +++++---
 arch/m68k/configs/stmark2_defconfig |   2 +
 arch/m68k/include/asm/m5441xsim.h   |  42 +++++++
 drivers/iio/dac/Kconfig             |  11 ++
 drivers/iio/dac/Makefile            |   1 +
 drivers/iio/dac/mcf54415_dac.c      | 216 ++++++++++++++++++++++++++++++++++++
 7 files changed, 316 insertions(+), 24 deletions(-)
---
base-commit: dcf93520157c17ddfb1f43b66fcdda27714ff1dd
change-id: 20260430-wip-stmark2-dac-7060f49dd94f

Best regards,
--  
Angelo Dureghello <adureghello@baylibre.com>

