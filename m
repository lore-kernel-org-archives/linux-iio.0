Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A9823DC84C
	for <linux-iio@vger.kernel.org>; Mon,  1 Jun 2026 15:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780327143; cv=none; b=DXQ/0Xz3cvyDnEELjDhydJjBfSOUN4EV4+BWINxR1BOnlj0hdQpG9xzMil6gI4hKR44GCEoqyNKZPC0XwKNmnoMWgP/6PtaP9SohTy7GGqccGTATEf/i8nT7R9MdGK1dHt4U5u4Hy5yPUdYqrysN0tYwNcEjAWTKqvrC01Crc64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780327143; c=relaxed/simple;
	bh=PXFHvGio0optY61LEkjNkEzijVZnDLT+o2ExZZLbhKM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dZHwNzhQMVtOK52/P/CS4OHzQPx2QXnfvKYHAOJ4xuPM3fySCtaUlbgSaBa6WJCoxyy9hA6emkvU8Gmw4KyBpoIBT65c9qCQZnltpwt2d5Y306auOFvETE4w07pVxIUSjjVSOqIVaeWLW8/YMyklt+D6i4bZSIkEcxxyTY2JhA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HOdIHSAB; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HOdIHSAB"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-45eedc94d37so2038767f8f.3
        for <linux-iio@vger.kernel.org>; Mon, 01 Jun 2026 08:18:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780327138; x=1780931938; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qzN96GbcZUpB13Q9YtY/dmYRB6hgHD9CiDUD5v/xjEA=;
        b=HOdIHSABzfgWx6LFlNNUcprEOfEGGWvwEf4bQdcaQigLgiL4AE1dDrvfzsMI1ed0IB
         G29wE7pR7JSzZCLREquNbb3y1+aH8mZcNT8LO89DUCsAPONz644LJALPjjNZAipEtPwM
         p5q30ifdTIOrR7SBnleaEsxQeivIgezhMbvK7LDJTZONnwx8oHMICipOlpZb6KvX+GDb
         mHhWJ7aY1l5MfaetMcUxviJZSrxIE59a6numTNH18UaaOee5MDeDaYYq3B8H71xyc3gh
         nOITYDLRSi1hYlYQqHsikJ+Q2pk/CIeReTXpCOmehQO33F4XLcZ0ZrnhQ0La0lZfTnqp
         kL3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780327138; x=1780931938;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qzN96GbcZUpB13Q9YtY/dmYRB6hgHD9CiDUD5v/xjEA=;
        b=sCQDn2ZliJ2aR0E40zrvFjGEa7TWreHLWqxYJPfN8G0XlbHp43xWh3V/RX5UiRZW5s
         kM5cfeF/KWSHb5jRjChJup6NRjk/VXO7dr1mqs+D1aS0WJlAp6dlWevlYBythRE1mrOQ
         oiSMNC6Q1/fE9/2XF/+M6bvDHPZPcMy2nWxjn1Nj3Yq38NF95MdrvVv2Dr3HI6I/qOS6
         tuXD4Vc1YcdkWV+0NYrpmIFQFeANioP5N/Gq0m0JB5mr1oT925PugDd5e1rmURk6FqTJ
         gFbF/Czv2YJp9f8AfZIB7qKINcA1HXPBL5yd4tRD8cHOKJ5XgAC1h+GT7lXp+V+Fw1mo
         uMIA==
X-Forwarded-Encrypted: i=1; AFNElJ91nmOctChEZQETNp8A4ZSb7ADwKG50qcqY1EXmrfQBxB5t8LCkTBAUejkQ1l5eqWLxamxS6q0ciO0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsQR/Dt/gqfze1wUCyzvGruESLyDWXlgBRF+C6M/Qc5C6j7wrP
	djKvQ57t8+zo8JJT0biLP3/iTPpTixEsY52d4U3hNjWLd0ei5Af+7vW7
X-Gm-Gg: Acq92OHZsK0Kk9OjfcVMEQXNZegUrByC4MdEEA8YdVOKwivuKnWLd1gO3A9akj6cr0f
	t1JxwQZrQItDeTapYVUzBiFuv0UwwtczwRNeLRr69ujT8KROYgyRfRAKqpMotXr4YNg+0/tU2AD
	eP6SILaihrgNb/s5n0AzxYvBG/7RadenTKdrVKE/ZWmJYLDE9UKyYpK1GcUOS5smsa3qPaqGeoc
	v+ZLScLRPgTkoJyjDLtI4z2RuSDDobPGSg1ZnKbdgSqFt8qlqitVncG6ifLHERyxVbhkTQ3uA7y
	zt4hltWJb8iOQYk0WWqhmlwvyQkrt/nFnbm97fM++Ewym8KUGwDPn2xPcT1ipZMdRPOuMPcpeDP
	SS5Jhx/AwO7D7gjT3BzJ/Vz1lRKOSYcVyde4JzYKeSUDyzcFaA6ObF5KRLsg6JxoRi0U3ijKvRR
	aQeD95PH9HUgNMVZc6mm9XrsY=
X-Received: by 2002:a5d:59ca:0:b0:45e:f46d:fa95 with SMTP id ffacd0b85a97d-45ef6a8c8f7mr19705747f8f.0.1780327137736;
        Mon, 01 Jun 2026 08:18:57 -0700 (PDT)
Received: from xeon ([188.163.112.61])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45ef354cd7csm25753103f8f.18.2026.06.01.08.18.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 08:18:57 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Lee Jones <lee@kernel.org>,
	Daniel Thompson <danielt@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	Pavel Machek <pavel@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Helge Deller <deller@gmx.de>,
	Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Johan Hovold <johan@kernel.org>,
	dri-devel@lists.freedesktop.org,
	linux-leds@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-fbdev@vger.kernel.org
Subject: [PATCH v3 00/11] mfd: lm3533: convert to OF bindings, improve support
Date: Mon,  1 Jun 2026 18:18:20 +0300
Message-ID: <20260601151831.76350-1-clamor95@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert LM3533 to OF bindings, add missing VIN supply, add support for
setting mapping mode and LED sources based on device tree. 

---
Changes in v2:

schema
- maximum led sources for leds set to 4
- anyOf > oneOf in ALS
- improved ALS descriptions
- adjusted example
drivers
- dropped devm convertion of irq and mfd helpers
- all als configuration moved into lm3533_als_setup
- added regulator/consumer.h
- lm3533_bl_setup set before sysfs_create_group in backlight
- added check if LVLED is valid
- LM3533_REG_OUTPUT_CONF1 > LM3533_REG_OUTPUT_CONF2 for LVLED4 and LVLED5

Changes in v3:

- ohm -> ohms
- added default PWM mask to schema
- added commit removing driver regmap wrappers
- added commits which flatten pdata helpers
- adjusted check if als->irq > 0 since als->irq can be negative if error/missing
- added count for children defined in device tree and mfd_cell is allocated
  via devm_kcalloc to be able to contain all of them
- fixed backlight boundary check
- fixed count increased unconditionally
- dev_err returns node name instead of reg value
- LM3533_MAX_CURRENT_* defines moved to common header since they are used to clamp
  current values read from the tree
- mapping mode commit splitted into 2 (sysfs logic improvement > mode from DT)
- backlight mode configuration set before sysfs group is created
- fixed LVLED check on LEDs setup
- added check if HVLED is valid
- fixed wrong err_sysfs_remove goto in lm3533_bl
- added commit implementing backlight_scale property
---

Svyatoslav Ryhel (11):
  dt-bindings: leds: Document TI LM3533 LED controller
  mfd: lm3533: Remove driver specific regmap wrappers
  iio: light: lm3533-als: Remove redundant pdata helpers
  mfd: lm3533-core: Remove redundant pdata helpers
  mfd: lm3533: Convert to use OF bindings
  mfd: lm3533: Add support for VIN power supply
  mfd: lm3533: Set DMA mask
  video: backlight: lm3533_bl: Improve linear sysfs logic
  video: backlight: lm3533_bl: Set initial mapping mode from DT
  video: backlight: lm3533_bl: Implement backlight_scale property
  video: leds: backlight: lm3533: Support getting LED sources from DT

 .../leds/backlight/ti,lm3533-backlight.yaml   |  69 ++++
 .../bindings/leds/ti,lm3533-leds.yaml         |  67 ++++
 .../devicetree/bindings/leds/ti,lm3533.yaml   | 169 ++++++++
 drivers/iio/light/lm3533-als.c                | 159 ++++----
 drivers/leds/leds-lm3533.c                    | 142 +++++--
 drivers/mfd/lm3533-core.c                     | 361 +++++++-----------
 drivers/mfd/lm3533-ctrlbank.c                 |  27 +-
 drivers/video/backlight/lm3533_bl.c           | 153 ++++++--
 include/linux/mfd/lm3533.h                    |  62 +--
 9 files changed, 758 insertions(+), 451 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/leds/backlight/ti,lm3533-backlight.yaml
 create mode 100644 Documentation/devicetree/bindings/leds/ti,lm3533-leds.yaml
 create mode 100644 Documentation/devicetree/bindings/leds/ti,lm3533.yaml

-- 
2.51.0

