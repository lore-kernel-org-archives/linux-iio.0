Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B64933F383
	for <linux-iio@vger.kernel.org>; Thu, 18 Jun 2026 21:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781816663; cv=none; b=Ag+5IGtsgwX6g7kcrb9R6D7Tydg8wYpfGdbqt6rKYIImJ6MEvbH/Fx4hm2cQNoKizJCWTNl2WXyhVGinVnvXmCvsi4dcBCuaU0JmTEq0mR+yK+/n1rqgnOXBVvLV/GjqUTaY3/vsrdiSLEXZm5z0DDo+Y27KUxSQoyyZUf4TyGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781816663; c=relaxed/simple;
	bh=8ifrEc9753CCi5Bhow6JmLPVihw5ePsw/Trj3+jkHt0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=hG7+IQzHSsq/YQ+bnGwDKdgIuVffzS2hATJgHIHCaO0tslimqORBQhfktm8LfefA7o32USzXuQprmpXy+EmRkj+blPh+tke88sj0+v+cQHV9XqB6eVx5xwse9Vj8dUsEVm4YcmfM0x4oJwAG/+1w9sY1GqVzsg2PVCRDc/y+TLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=OZEiiUv/; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="OZEiiUv/"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5ad583dc38eso5798e87.3
        for <linux-iio@vger.kernel.org>; Thu, 18 Jun 2026 14:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1781816659; x=1782421459; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=E9z0pIRRQq0JjZLgtfI21RJrv64iSxf66JeOGPUHps0=;
        b=OZEiiUv/3ThYD9n1LhEBRB3xvTVXLPRi3qDnaDQQ1YQ5tIj6ySzF+GINE1Te646Rem
         ewchhODruaOrUhckAOc7KKjZ7wQhtxBfLuv0fCbf11vPmuujFE7db3knEaOiJLb/yh3f
         KpZWLmNvLSbv6ms5LR2xTWnWT5vkZDFq3vjW42578xMUN17y6E9/2gReQqXrQPznjru/
         sk+X0BoHb0XwFVvVgZ89MXUwSjPX6xit5baykRxuqNo8IWILmc7C/sjzpNsuYi0vjYG2
         IMA27J2ZlJn8oEXg5n9p9SXWILi+gdQQGRpiyS/MrJGfgaR7LPhLp4mUHvYIrh5fNYF2
         B9WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781816659; x=1782421459;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E9z0pIRRQq0JjZLgtfI21RJrv64iSxf66JeOGPUHps0=;
        b=iMcAPfBpWYCgG/Wk/KEHr3Lb12SfpTJDwlpXs81fqevweQMAMiGCZ+B3Mer7/Yd7Xu
         Le0iayLTThReblexE6PCH66CKD5Fk2x+7y4fJcl2/tU+dPFCfeFhZM9UbSghtye/WRob
         vE9CAwICzzTL+LhiMYEDVdNtSTe5YrQarvT2ap12Y8z7upDHEse0853QFqWH4UptoNqn
         GOObmrvVPCit3SeLz7huxGxhIpEYSRdilgisju/Mst6h2rFdwxk40Hn/K+XrDo7niiRk
         6W0lXke7QwHK16jUA/hi9yBVpX9R8g6hDEoD84El85LK2w6juQuO5O9Wtkm4ojpk+ZL7
         u2fQ==
X-Forwarded-Encrypted: i=1; AFNElJ9ufBR/lG8utd1v4MbJtKjY3JVMDbxKoFE07LVL3RQfl8PBlc7e1ErC5OHtSqa4ehaKEoY3SP3oAvE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWUEdcow3uvQEXOhK6NQNOnhl7uea4LTEu8nPDwWkyXI1yHYa2
	qTaHjw52Y7YsZ/v+G4EvUZRl7oa3VEHGPVHcJ1EEAnd8tx8guW46grgvm9jGoS6Y3cg=
X-Gm-Gg: AfdE7cmhciZlu6dUX9AHdHtT2F1yBRvpKvow/E9OyLZpHeIzK0VtSK3y4qSheeEqV2o
	06RC47tObqGgVuH1zB3yBNhwKzZE/F+LA26UlWh3yPcCCqQiY6OAX9tgcNmSFK2oNsk+8g9HdM8
	pU7sGAp11bpdJS0JkjHNMrBJIVAnJEqUDBBIhvt51MJ8dbguzE4+2okRKBtoOBCk5f99nOi/xQW
	5jNXABQM5wf/CQ70P0K3/jm0stTk05X+yqaig6NYry6ZTQ0DMBP+7N7tyuMzvmb8W7QndsKbP21
	+xcJ9vSzFlycoyBfgDeajLD8g/VdKlkmWR6Y0q+sNcxd76+kNhqBI3KGiNa8pF01fNSojbrbDME
	018ChF9yz36IV65eM7Skz3uSb4yr317X+rpmqCcQQttmghP8NyLDJTlE/hNmK2uxz5sEJohwWIB
	p7BecbMbXrS3hYix/+hYLo
X-Received: by 2002:a05:6512:8013:20b0:5aa:b6a:738e with SMTP id 2adb3069b0e04-5ad57715b49mr98736e87.44.1781816659260;
        Thu, 18 Jun 2026 14:04:19 -0700 (PDT)
Received: from [192.168.0.2] ([2a07:7e81:7daa:0:202:c9ff:fe53:eda4])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5ad57493145sm108586e87.69.2026.06.18.14.04.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 14:04:18 -0700 (PDT)
From: Angelo Dureghello <adureghello@baylibre.com>
X-Google-Original-From: Angelo Dureghello <adureghello@baylibre.org>
Subject: [PATCH v6 0/2] add mcf54415 DAC driver
Date: Thu, 18 Jun 2026 23:04:14 +0200
Message-Id: <20260618-wip-stmark2-dac-v6-0-48761dbb96d7@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4XRy07DMBAF0F+pvMZo/JokXfEfiMX4RQ20qZwQq
 Kr8O05YFKgrlleae64ln9kQcgoD227OLIcpDak/lIB3G+Z2dHgOPPmSmQSJoBXwj3Tkw7in/Cq
 5J8cbQIi6877TkZXWMYeYPlfx8ek7D+/2JbhxYZaLXRrGPp/WyUkud7f1SXLgQVFssXUaSDxYO
 r0lm8O96/eLtlaNUPVqdJ6CAReNoN/V5W2Tuqwb0NeEKgQYqUlEJ5y6tS5lvSrQBiCvDGFTWRf
 /rItCtI12Ckl3AnyF0D8IJa4JXYgmoCGrpTC+RpgLgaLyA6YQtkHbKoXojftDzPP8Ben+oGRFA
 gAA
X-Change-ID: 20260430-wip-stmark2-dac-7060f49dd94f
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 Geert Uytterhoeven <geert@linux-m68k.org>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
 linux-m68k@lists.linux-m68k.org, linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, 
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
Changes in v6:
- Removed patches 1 to 8, already pushed in m68knommu for-next by
  Greg Ungerer <gerg@linux-m68k.org>
- keeping changelog in each single patch, where any
- Link to v5: https://patch.msgid.link/20260610-wip-stmark2-dac-v5-0-b76b83366d5c@baylibre.com

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

To: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
To: Nuno Sá <nuno.sa@analog.com>
To: Andy Shevchenko <andy@kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
To: Maxime Coquelin <mcoquelin.stm32@gmail.com>
To: Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: linux-kernel@vger.kernel.org
Cc: linux-iio@vger.kernel.org
Cc: linux-m68k@lists.linux-m68k.org
Cc: linux-stm32@st-md-mailman.stormreply.com
Cc: linux-arm-kernel@lists.infradead.org

---
Angelo Dureghello (2):
      iio: dac: add mcf54415 DAC
      m68k: defconfig: update stmark2 defconfig

 arch/m68k/configs/stmark2_defconfig |   2 +
 drivers/iio/dac/Kconfig             |  11 +++
 drivers/iio/dac/Makefile            |   1 +
 drivers/iio/dac/mcf54415_dac.c      | 183 ++++++++++++++++++++++++++++++++++++
 4 files changed, 197 insertions(+)
---
base-commit: d43c76b1fd85cf6f9a53145ed397d10e76f99213
change-id: 20260430-wip-stmark2-dac-7060f49dd94f

Best regards,
--  
Angelo Dureghello <adureghello@baylibre.com>

