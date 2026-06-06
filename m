Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B23CC2F8EBA
	for <linux-iio@vger.kernel.org>; Sat,  6 Jun 2026 04:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780721887; cv=none; b=IWpAK7d8+idn+y4CKw6tqNhclc96lPkC0GSWiggk2afRceAq9zTVWdAXEZRtwZLi0Tdhf9bjBUWVEI2/XXgUUME3cGa4ZqEQk6aXhEcfXDHZhVI6ecL7dpNrT7lSKkIGIsunpkoRgWcxPgC8flPCLnidAVxV4Gdn2rQeSHng7hY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780721887; c=relaxed/simple;
	bh=sChSctaNk/iJ7rMo4OneEoqRj9NRpGu5gBeih5JX6Jg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lb+rzEFTjVBAAnWhTTeosiFfHGoERTHvJSebIKoZbKcLfiUojL+XaDq8WDn0GJlnxnuNsvJePU11Ewx7SLRYsbxkfOFXnCES//V4nVeQIME/KQqngQpcRnAGSWgtqkl7YA/4JiwTcUi5QRsb8k4myEYVltiDDHTvarY8k99TI08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sSfs//8t; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sSfs//8t"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-beb8a08a6c8so370062566b.2
        for <linux-iio@vger.kernel.org>; Fri, 05 Jun 2026 21:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780721884; x=1781326684; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ijiDIJoRq4DW5gmq2cKgL9VuesBVH2zWjg+vtHwI5sw=;
        b=sSfs//8t7+hi4vevAcVnNjxy1AQom4JuITz2efSHK9eMjRSjnhpigeGBbwFOXFrODK
         Z/GiP+EFP3SMYvbl4RrWp2DnpUEOX0iMA5Q/A2irlBbF9bhlwDPTzhgHtcuqUHU8s+82
         mkv1VTrkmYfkGhYaxh9vnrs4JLVn/LsLDpnUd7r/6F4PIaRIyKXQfh2mkrPhtDJnAKAk
         nTbRKpBufwY78nqOkIVVvt2hNHNMKNJBXqN0r7tKtMRW5LIRcH+8ojfBz7eKgb/OP7X8
         ODt15qnp7y9J9fLIctqWHekiPiqRPH2rcCdxN7sd4EFopcLlVydJPXxJ42T5rVSnDS72
         IrIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780721884; x=1781326684;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ijiDIJoRq4DW5gmq2cKgL9VuesBVH2zWjg+vtHwI5sw=;
        b=VTLoJyGf0zbWXUwrq8QavqQENVgUtOnE6LelUpb+wNycZV3l0FS49bwSRkewxDnqvZ
         mGrLyL3qQe2Qon0PAMS2fZwsof24K/eAPe49AlMO38Q7voLXNOvTCdAhgyL1AiQYMP3Z
         kf7vTab/u9+K0AleqDdtWX76Zc4RtmyQxdnYKIAK6su66SPK+DS7sEnzw+STDVz/iC0B
         2doSSPOJyypjoDTBbfBWXeDppGY1zG4b63oGB/5g5heDvZyXdx7mF1dsBIyHTu28icAr
         Ls8kcUZSepjOowqUT5Xnyct1EfvqPnSnH+JaGiwXvn/Ck40O2EPa5y5DpBne4wwVG/do
         XBAQ==
X-Forwarded-Encrypted: i=1; AFNElJ8brqcBYLnROzlxebf63l+ySrqcWWjLd5+AP9vYUJzdWDme0qFg+39ENC/f/fYip5mfriBHzaoSWXw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyERpmQZif5JitiyfJY34gC/WdMyshZWTCSJ2+7TDaSc1oCkz/Y
	hkwEVWpVeSy3KXIvbngdT2cTZ68SaDr9VBJ1QTDo9d4MHqGy2BuZv4DD
X-Gm-Gg: Acq92OHlR+yVbpAzV0UPokuY1gvc3XtMwZJ5xT78ZVTSwYdNTHVc/D/SDERy3ZOC+/n
	y1JFr4rDbg7q3uxIMDdzp8OGqWNK3Sfol5q0dMwdnN9BK/LP5pJkC1QTN446seTkhJrEJ1uMxPE
	lfHJ7CjyCXnBtE/FBNu7iGpM1qJ7rrsIKjYIBVDfv/Tw+kzbbLkAyoPBwOXpZbXlLRyWwU880Iy
	4eMFdoi1vUHd8SNkvy4plTOcHqg/Faapc3WE+6wvuzjINwwK6hABKg3HHr5q/T9fJeWir1YrQEV
	boMprtjGoD+060sApFWXsU2K7Pityx/SJhLPbjgPDFQ3NT4KMLeHq168P5zx2d6AmRpFCzS8LPI
	dQY2qP8WfUxaaQ2adZxks6TaPNdF5WsGNXgAfpJ03qJvHKkT/YMGEZ5jYDw3iSALrPGEkDEg1Wf
	PlW29+VfKg1oW7eZrvf5y3vVSzyC5mvhvrDw==
X-Received: by 2002:a17:906:8a79:b0:bee:bcf6:6a23 with SMTP id a640c23a62f3a-bf3749d7f03mr231807166b.43.1780721883699;
        Fri, 05 Jun 2026 21:58:03 -0700 (PDT)
Received: from xeon ([188.163.112.61])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bf054e086fesm570597166b.32.2026.06.05.21.57.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 21:58:01 -0700 (PDT)
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
Subject: [PATCH v4 00/14] mfd: lm3533: convert to OF bindings, improve support
Date: Sat,  6 Jun 2026 07:57:24 +0300
Message-ID: <20260606045738.21050-1-clamor95@gmail.com>
X-Mailer: git-send-email 2.53.0
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

Changes in v4:

- fixed regmap_update_bits val and mask swap in lm3533_als_set_int_mode
- fixed als->irq check in store_thresh_either_en
- removed clamping of r_select in als driver
- added use_of_reg and of_reg for backlight and leds registration
- added intermediate step in asigning props.brightness
- fixed HVLED/LVLED configuration overwriting
- added bounds check for num_leds in leds and backlight driver
- switched to regmap_clean/set/assign/test_bits helpers where appropriate
- dropped extern from header function declartions
- switched lm3533 pointer in cell structures to regmap
- sysfs_create_group > device_add_group
- changes in backlight sysfs were expanded to all properties
---

Svyatoslav Ryhel (14):
  dt-bindings: leds: Document TI LM3533 LED controller
  mfd: lm3533: Remove driver specific regmap wrappers
  mfd: lm3533: Remove extern from shared functions in the header
  mfd: lm3533: Pass only regmap and light sensor presence to child
    devices
  iio: light: lm3533-als: Remove redundant pdata helpers
  mfd: lm3533-core: Remove redundant pdata helpers
  mfd: lm3533: Switch sysfs_create_group() to device_add_group()
  mfd: lm3533: Convert to use OF bindings
  mfd: lm3533: Add support for VIN power supply
  mfd: lm3533: Set DMA mask
  video: backlight: lm3533_bl: Improve logic of sysfs functions
  video: backlight: lm3533_bl: Set initial mapping mode from DT
  video: backlight: lm3533_bl: Implement backlight_scale property
  video: leds: backlight: lm3533: Support getting LED sources from DT

 .../leds/backlight/ti,lm3533-backlight.yaml   |  69 ++++
 .../bindings/leds/ti,lm3533-leds.yaml         |  67 ++++
 .../devicetree/bindings/leds/ti,lm3533.yaml   | 169 ++++++++
 drivers/iio/light/lm3533-als.c                | 179 ++++-----
 drivers/leds/leds-lm3533.c                    | 181 ++++++---
 drivers/mfd/lm3533-core.c                     | 365 +++++++-----------
 drivers/mfd/lm3533-ctrlbank.c                 |  27 +-
 drivers/video/backlight/lm3533_bl.c           | 223 ++++++-----
 include/linux/mfd/lm3533.h                    |  75 +---
 9 files changed, 806 insertions(+), 549 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/leds/backlight/ti,lm3533-backlight.yaml
 create mode 100644 Documentation/devicetree/bindings/leds/ti,lm3533-leds.yaml
 create mode 100644 Documentation/devicetree/bindings/leds/ti,lm3533.yaml

-- 
2.53.0

