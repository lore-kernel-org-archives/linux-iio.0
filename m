Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 690DF3D47A0
	for <linux-iio@vger.kernel.org>; Wed, 13 May 2026 09:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778663683; cv=none; b=c91vP9atiIbH0+HA2QTEVNrWgb1ok5c4OshNht1o5b2P6Chh2vO3O+uhMNaE3mlhDur7gcyXHWC3xPlA3Vs24AOS8EdPIERS6/cCQbXUofd465G+1SJCZtxCuzshU+clgDrsGfg2RcAm4W4lq1WWOEHBEwfHEsmuIRqA8FLcLbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778663683; c=relaxed/simple;
	bh=+Yx1Zg5rFuonF5evcV4LLzCgrpfxwRi5dFqTUCk4UQY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=NOwZ6760tm2o4Lmvt58HmKQ+EZQnox+HBCLpnHlG1cnp9QzxhQy+UQW3fkDbg0yxaj7G+ytJIoaz6MFppilFtNPxEwx+OzY+d0t9xzMUMOjE6cFP1NbXRWAP3jjibZi2t0zV++uz8f+GJYXH1a+ldCCw9ojSYTgkkoffSvICyKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=Z6b8bTK7; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="Z6b8bTK7"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-48984d29fe3so69234075e9.0
        for <linux-iio@vger.kernel.org>; Wed, 13 May 2026 02:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1778663680; x=1779268480; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3M6rRLTQ9CGPGf8NA7+4xvB1DmVHioIYgHph20eH9Ks=;
        b=Z6b8bTK7nBSUrsrAS0SquX81SyhGcYnWW/DyfDSREcYfhc4WAxxXfLKZgZBxz3wdGh
         Tl52X6vL288nwIk+ml2UBXeBiSydt6Bp7PN50K5yp2K11OA5v+JPMA8I1cEqMXdFz3H+
         S10sxh6dNolP4Vu47cwH25THnBqPKRIjvUrfzoMHbty4fAv1Sm8mbjlTo1c83XDtbNrW
         g6V6gUQQobB2ZMlMXqotHMwh9fMWAUcJ/VvjqF6luhqdCMu6y/qGs9qx7NBDuMIk+mV/
         JM8Ip3V0yahr3gz4B1W/X5igy0BJ+q++AKv9DklCRNMN68gnQkVDKpDM8i+ZZ/RWliUg
         PckA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778663680; x=1779268480;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3M6rRLTQ9CGPGf8NA7+4xvB1DmVHioIYgHph20eH9Ks=;
        b=ADvmx+8ta5nDbKQsMEWg31d73Wc+7Nqh1YuMHY3n3EwXK5Tx1ek6xfA+ilxS7+ftZA
         1u+zpSz7G/P/3bLoKoYSKexJgrPIsc06mw+RizEUEuUKsToY+VI/QyJhBOUhiPvGWi2x
         o6F0iflx8DylZHTtYQgpuEcD+aLBoDHqkYx2TEcRYxJ+BR9d7nFUeS+8wCKqDKLuGciv
         xXxbePj6JKVCQ8peGyl1jBnxTcLgEs5chBo6Bs19oPnULu40cyzt2VqiLp/FHRG28TSJ
         2Ch+hUtmoT6GQ+fCO4MkPeqBDr8cCumJYF5es/syB0k9rW8aOUGXFxLOsStIgM/EgPlQ
         1Xvg==
X-Forwarded-Encrypted: i=1; AFNElJ/jOsqXJzLGfqcuPN/m/L/L+O9d9IfGvnC1xvX5YYqtMiZSXujPcrdo3roCQ4GZLtQoPeyYNAxKH2U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzLpAG4gP7vMZSflV/vUapWibGmeXHZIdK43QPlMuLu5v7M3kH
	VIwZhWrXjsaKoupsm00NXPpT8Vf+Jf7ysno11qViypN6Zox1iUAXEvG4hAwQBqwlZg8=
X-Gm-Gg: Acq92OHg+dufCetnmKf6vZmicL6cQPgcNM+UgqIcV3qj6zhi3HBlQMi5Hq/9ZPTG6b9
	09oxtPKlCNs8Z4v1FdSwpR/mSQ97BBJYXARuTwdlfPQq/PtNBQ5eZ7RpMiiCVpQsro8660OFuLP
	0wjCU7fAKeSlMta2Y9T00fLYjHZcy+Ebev6dnsE9+gGS983kArKgjZt8ZNWKZMBGTWUw1xNrACY
	fp412WGEZx6Kccp3ArVyZAGsi0SE6Wl6DlBKVlM+Q2wrKjHluOaS9oANrP1Nvxy5JRmA7bP0W//
	O5Qjap0nIf8EQf7AuODsx3eAAUICGuOeti9MN+ShwdJmIAFd5X/Y9cykdaVogfKnP1/saPqLSjF
	a55kqw7V1SEcLUT7+0cETuaoJ+arc3jq4JyT8YzbyEq79opsf8tv20LCwW4gO2DcA6CZSSemDH0
	Q7BgzY+6TJ3ias0kHSzmpbuG896zkVW5cvJU/lToIwsQ==
X-Received: by 2002:a05:600c:c4ab:b0:485:30d4:6b9e with SMTP id 5b1f17b1804b1-48fc9a3c1ffmr38082135e9.21.1778663679846;
        Wed, 13 May 2026 02:14:39 -0700 (PDT)
Received: from [192.168.0.2] ([2a07:7e81:7daa:0:62cf:84ff:feee:627])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4548e6a66bfsm34590821f8f.4.2026.05.13.02.14.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 02:14:39 -0700 (PDT)
From: Angelo Dureghello <adureghello@baylibre.com>
X-Google-Original-From: Angelo Dureghello <adureghello@baylibre.org>
Subject: [PATCH v2 00/11] add mcf54415 DAC driver
Date: Wed, 13 May 2026 11:14:24 +0200
Message-Id: <20260513-wip-stmark2-dac-v2-0-fcdae50cf51a@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4XNyQrCMBgE4FeRnI38Wbp58j3EQ5rFRu1CUqul9
 N1N6kFwwePAzDcT8tpZ7dF2NSGnB+tt24RA1yskK9EcNbYqZESBpsAZ4JvtsO9r4c4UKyFxBik
 YXihVcIPCqnPa2Psi7g/P7K/lScs+MrFRWd+3blwuBxp7v/WBYsCaCZOnueQgyK4U48WWTm9kW
 6N4MLAXkQD/JFggIKFcECOJZN8I8ocggcgzLlkqeEFAvRHzPD8AnWT3ykkBAAA=
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

Note: this patchset depends on mew mcf_read/mcf_write implementation:
Link: https://lore.kernel.org/linux-m68k/209d0653-6386-4b64-9e15-e358f84453ab@app.fastmail.com/T/#t

---
Changes in v2:
- keeping changelog in each single patch, where any
- Link to v1: https://patch.msgid.link/20260504-wip-stmark2-dac-v1-0-874c36a4910d@baylibre.com

---
Angelo Dureghello (11):
      m68k: mcf5441x: fix clocks numbering
      m68k: mcf5441x: add clock for DAC channel 1
      m68k: mcf5441x: setup DAC clock name as per driver name
      m68k: defconfig: update stmark2 defconfig
      m68k: add DAC modules base addresses
      m68k: mcf5441x: add CCM registers
      m68k: mcf5441x: add CCR MISCCR2 bitfields
      m68k: stmark2: add mcf5441x DAC platform devices
      m68k: stmark2: use ioport.h macros for resources
      m68k: stmark2: enable DACs outputs
      iio: dac: add mcf54415 DAC

 arch/m68k/coldfire/m5441x.c         |  21 ++--
 arch/m68k/coldfire/stmark2.c        |  51 ++++++---
 arch/m68k/configs/stmark2_defconfig |   2 +
 arch/m68k/include/asm/m5441xsim.h   |  42 ++++++++
 drivers/iio/dac/Kconfig             |  10 ++
 drivers/iio/dac/Makefile            |   1 +
 drivers/iio/dac/mcf54415_dac.c      | 203 ++++++++++++++++++++++++++++++++++++
 7 files changed, 306 insertions(+), 24 deletions(-)
---
base-commit: 25c66a1b49f3c5463ee8266a3fd5256cbc794610
change-id: 20260430-wip-stmark2-dac-7060f49dd94f

Best regards,
--  
Angelo Dureghello <adureghello@baylibre.com>

