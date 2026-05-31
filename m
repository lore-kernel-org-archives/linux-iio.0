Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 894C12E8DFC
	for <linux-iio@vger.kernel.org>; Sun, 31 May 2026 15:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780241162; cv=none; b=ilslgIm9tG9tT6l4E2EM8uAhgldWuGzxfhQ+1zQnuFz7sS/NHsjNF2qKzvD+oIK8AOm7Gxh29wpdIx1g0In7GOE5fLKGxt2YxVgYAyuwL1F2U3H4xWan4ZmGL4ToF8OVGPmaN7UY91SkVeneHizEHOHeG10gk1qB7Wvl2rBFAbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780241162; c=relaxed/simple;
	bh=OLRn0WPuowOpGkcllj26gGYuNaltNJ82CwrGWLvsHkc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ByiMfzziRRu+zqtqC8LnVSc+PkuCnoIKJXA1F9enLDEx0v1zmmMYBNk+njWc4hVOH2u7AzBCrz7vigX/cJh/b79goL5/xfC2ulJFaTXrveYtWkJf6ea/ISv71eIZReGC30tKoJbkSKo5OGkYT/31BFdYpLjUiipViQBcjhVwSRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=POoRMYQL; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="POoRMYQL"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-45fd461e4a5so584640f8f.0
        for <linux-iio@vger.kernel.org>; Sun, 31 May 2026 08:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1780241158; x=1780845958; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DG2xp1hSIJeTvHYY9toNTecy4Wvd4sNJMjvyyolvm+4=;
        b=POoRMYQL9+Ys1cDaOWO8BLFAXLcF78vdL2r2smX/JBq5xUWSDalcmyO96FxHzvA4sa
         VOpt5+vYeQUdtSvhifllCDjBMaYCA3sKO/dzEuDFyGEubT+hgH9Q8p6npY6HcwlW58+F
         aw/oZJ3eBkZNDQ+ScwA3fdbPpA/FCWXG8tS+C9hPZ8lSNobyQUdq1wlcEjCnofW/+EMr
         isy/YvSKpV3DIj+cU/YSPSddXEnCtl2AWnGBBguY5N3Dx63sHLoD++231TIobpQSWM1m
         WuoI2Admz8jZMLIKNqfJu6B3iVijxyXFI2Hh7ZivNu1vVEO17zlb97W1qiEqCYB6Lz3D
         tRgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780241158; x=1780845958;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DG2xp1hSIJeTvHYY9toNTecy4Wvd4sNJMjvyyolvm+4=;
        b=TqZcpj6lYApyXu/eJwWi/wnHuwX0yP4UZpCnWXQuVOV09KjE1sCPWQ2xFw3s1bITmb
         S8tJhFyUAXrOGRdG+Je3Ozdnal07lOZ7eACpQlr5vR9NVbqqUcs32lAwxcy5zRSxS8p8
         mur7mWMYkkuyPdM0xHDIP+ONGCu4vdGTXWpYcjMHvrDCCN2BHKIoxO+F0N2/RXB5k6bt
         zAwpYhh1Ntuv/DdsxRo0bmVTeqUX67lujAVkhjRGknSWDB0DKWh4MszAXbdk4/HNAnyf
         QX5j6UOb66t+kmLlEJtJ7Ecaxww+U+2pMJOl+n+7xrcs3r4KqNKr3KATunTWMTaNm5T6
         9OHg==
X-Forwarded-Encrypted: i=1; AFNElJ+1C25o0x0dRCqkrajZXqwSVdQi2X2u/brLK3TSYiyaWc9DKYRCo7o02M166kPc1Lu1f4j87xoWcdY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNqs8iRWd/++ivZUclaRVzJ2JWKV0G79t7rElrBH/Jrx+mriTC
	KNqYn3VKySIgC8fJhUomx3mk2p/sYzTQcJHY4OkL9Uyo+f2JxVSxMabFCLUg0a4s9qY=
X-Gm-Gg: Acq92OH9pxiaxp8gC1s7CPq6VXQMMwicNpQPBYOQnK/BR0658G3y4ypqFUliKzRw5ik
	lFR1C5YtG2xfQ8cmYZIjALGamVDv062na0iMcogoTb8Cc6++I8wd6wvtPIeIgQOiBeUX6CkuHwm
	x37UL8XykRlnwEIvCyg1uiQJ/vELTQ3lloHd8MYFNQWAMLYESZB0gQLQIfj/7f0tq2EYWrHK8T+
	GEKboeNx139nyZ462u75pHyLpx5F/kQuFL5nWL/ApDw6EeAIwbVRh5m+00cIJW7H2X81WmOdq7+
	s8ePn9CQJVK1O81+fydWITlm9ZkZHaNUYUw6UqBz1R92v8JqTQcQZBNsw10xrrXFnqr3Elw5n3O
	PuY6UAmzzbhSQhwo+tQbKhYQBNn5a5p2Jldan5CZFFRYkRcSvZd8CoG+iV3pHNOOCmFwwLUYItf
	JX1Lfad4JEpeld8SDmsYmAX/HXN/o1m+Wu4FstdNtjCA==
X-Received: by 2002:a05:6000:2581:b0:45e:f8d0:d22c with SMTP id ffacd0b85a97d-45ef8d0d485mr12474042f8f.25.1780241157769;
        Sun, 31 May 2026 08:25:57 -0700 (PDT)
Received: from [192.168.0.2] ([2a07:7e81:7daa:0:202:c9ff:fe53:eda4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45ef354cf0dsm18526622f8f.17.2026.05.31.08.25.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 May 2026 08:25:57 -0700 (PDT)
From: Angelo Dureghello <adureghello@baylibre.com>
X-Google-Original-From: Angelo Dureghello <adureghello@baylibre.org>
Subject: [PATCH v4 00/11] add mcf54415 DAC driver
Date: Sun, 31 May 2026 17:25:53 +0200
Message-Id: <20260531-wip-stmark2-dac-v4-0-7e65ab4215dd@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4WOzU7DMBAGX6XyGaP1bxJOvAfisFmvqYE2lR0CV
 ZV3xwkHBKTi+Ek7M3sRhXPiIu52F5F5SiUNxzrszU7QHo9PLFOoW2jQHqwB+Z5OsowHzC9aBiT
 ZgIdouxA6G0WlTplj+liND49fu7z1z0zjolku9qmMQz6vyUkvd9ftk5Yg2WBsfUsWUN33eH5Nf
 eZbGg6LbUWdMttopIDsgKJT+BNdfpvMd92B/aswVQFOW1SRFJlrda23UeV7BgzGoW826uqfuqq
 KtrFkPNpOQfilmOf5E18HIxq/AQAA
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
ibuiltin DACs.

Currently the driver enables the raw write only. Feature as dma, sync, or
format are not supoprted for this version.

Additional options suppoerted by the DAC module will be added to the driver
later on, as needed.

The same patchset prepares the m68k/coldfire architecture to support
the driver.

Below soem basic tests done on stmark2 mcf54415-based board, voltage check
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
Angelo Dureghello (11):
      m68k: mcf5441x: fix clocks numbering
      m68k: mcf5441x: add clock for DAC channel 1
      m68k: mcf5441x: initialize DAC clocks by iio DAC driver name
      m68k: defconfig: update stmark2 defconfig
      m68k: add DAC modules base addresses
      m68k: mcf5441x: add CCM registers
      m68k: mcf5441x: add CCR MISCCR2 bitfields
      m68k: stmark2: use ioport.h macros for resources
      m68k: stmark2: add mcf5441x DAC platform devices
      m68k: stmark2: enable DACs outputs
      iio: dac: add mcf54415 DAC

 arch/m68k/coldfire/m5441x.c         |  21 ++--
 arch/m68k/coldfire/stmark2.c        |  47 +++++---
 arch/m68k/configs/stmark2_defconfig |   2 +
 arch/m68k/include/asm/m5441xsim.h   |  42 +++++++
 drivers/iio/dac/Kconfig             |  11 ++
 drivers/iio/dac/Makefile            |   1 +
 drivers/iio/dac/mcf54415_dac.c      | 211 ++++++++++++++++++++++++++++++++++++
 7 files changed, 311 insertions(+), 24 deletions(-)
---
base-commit: 9edf4183f0d32146b708220d56ee2d35905ba516
change-id: 20260430-wip-stmark2-dac-7060f49dd94f

Best regards,
--  
Angelo Dureghello <adureghello@baylibre.com>

