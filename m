Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A20C33F8D6
	for <linux-iio@vger.kernel.org>; Wed,  1 Jul 2026 14:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782915452; cv=none; b=klXcHvT8qM87j6IBJzfzppBOnu5IPs8orRKwXlcGh1SyZkP0PHubGaFwkzviqUacXl8DLi4aWCy26LZOGdBgj5FaKmfc0YHtnSEkS++yYfzb+kt8ThE3MZI865zU4BY7ar169qWAC8MKtnpyweevNGDT24o7qlv7ApSVIC3wBqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782915452; c=relaxed/simple;
	bh=uxpkze4mO0R/ciNnUW9aPg3o8zyZI3JR3YM28nP5gR4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=gP7OPnrkek6J+F7goHBw/8SvixY7TcHtPmqEYaQqSkJxNkU0kOCkfeWo+yYG0PoX8sqduwjpMORhekBrRtgSmX7OXbMMSBJ5+cEVemr5itzJwjqx71UDOA+WoQkmlVMeGCFHd3yJ0k2EJr5wokauvybGaJS1+MJfjEz+RrnOmmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=ouCPuBWk; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="ouCPuBWk"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-493ae59eca6so5377125e9.1
        for <linux-iio@vger.kernel.org>; Wed, 01 Jul 2026 07:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1782915447; x=1783520247; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZW8+spma2S67V6miLcBHdIf2ZY8X/GF3gl5p74l3kDU=;
        b=ouCPuBWkX8ZjCYthBoWS9vHidKRwbSa4lLbvm4ERmt0Vis4wVJjpm/VVGc6nv/3pyl
         eBejsxnbrS+nBxO+G38gA/o0MVSrEBnLIOsxKvjXEJ8bgC8BmWDo4QMayVGo/OvLXMRf
         Ati+Ao0BkLNV3BC2vkJz6dRlpAwx3CgpBD81akuuKauJUvkZgHPoa0RIDwvn65ZWqBjd
         3qBiIhT16iaDsKsch4RjfpiBBIpK3+7gEbxEcz3hD71YbV++EityTgbF9UOQL4I7xg+l
         jkVElLErkzKEddCth+7mUYBw04+aJ3bLGm9/Oo25X1SOkOt5YkZyrHWJmiRrDI8WyD52
         veDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782915447; x=1783520247;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZW8+spma2S67V6miLcBHdIf2ZY8X/GF3gl5p74l3kDU=;
        b=XNedtnaneZPONkuZ6Pqk+omBiEoPx2vLG7kieQlQXz51vvbnEuoJ6uQ/07TY2/hGXd
         vfWSDmJOGfFNqbVT6Lp3K85WZ4+eMjTFQpogMPQTfhtpOYiZaAbepR3XSplRda9zvbCm
         Ye2RuBUYALAp6wbttjLO1eMQKKU0OPPIem2J8/+9DpntQsdw9xhYe/fbUc7E5qkhg8W9
         qQsCfhyHPWUgNdfzTc6Y0lHx4rZ08SfECTniUAncpC12OgtWe0GwVnx0+vPZdciZKoa+
         w/HWae1nhaw2e5j7g7+EdqW9MbYdQ5GWsPVPS/HzOuzYjrRH4YxcSw0FICNDsqdO3Ev3
         OhSw==
X-Forwarded-Encrypted: i=1; AFNElJ/hi4kl5B/1ub7UMwmkEvfKdIwwzWQUS0yTdthIeYQD8xlqWYUrYCl4E3XNcot7jNxZcWjU35UppxY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2vwJ8VMaeBsv27QwqfABNgtPIwKevucOJCJpAnqFiK61xnEiz
	2MpWOMpHgGlFYgB/fbtrNiVLkoM3hZlSxZCdlF0fGcP9xMhL3krKdMDdCgcdkDn24fs=
X-Gm-Gg: AfdE7cmbM15UaLnlFm+pa+9HNYykYLYge2Gmfj31ycfn1QzBoDHggbH4i4yoXXLyxpL
	psoJUBBFA+eAEMOODeGQmP7iL3NTmJIjRHzIxhVuSbh7eMmhzsXfymhEBvtK1FwK8WESDR3KS+f
	pXUFKEE3a9YIWYv1bBoGgF7PCDrai/ifcs4TtuvCgaUOqhTukpfMrjr6K437yAvRFlotZKmsFRN
	nA57FNA38iY3nkHFtr8aq2scS35OZ5wa74bb6q2/m6mCqh/mY7IdeaSCJ6vdLdtZZI7+rEjSjBC
	3ly5uTKzpRjrDk7q01SKOHYZX7CujvNuS+zEJ9nRIwwZ+jwhCfF7pW+BpwxOZfPPbc6VyTG1DZr
	X+YHcNjBc7WFZFWcYl9Eref6EhdufAnqqiebfaqk8FvL+c7EqzjO7H/uW45OVEsJAkgsbZFBd1g
	XnoulaSJnH1FLhMQrgLnj7yBkmhf7p9mmNE0t/HoCB1IGmNedktGE3
X-Received: by 2002:a05:600c:524a:b0:493:af0d:484c with SMTP id 5b1f17b1804b1-493c3df2fb5mr12527785e9.34.1782915447358;
        Wed, 01 Jul 2026 07:17:27 -0700 (PDT)
Received: from [192.168.0.2] (host93-7-32-195.dimensionesrl.eu. [195.32.7.93])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493be81df2asm152552155e9.12.2026.07.01.07.17.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 07:17:26 -0700 (PDT)
From: Angelo Dureghello <adureghello@baylibre.com>
X-Google-Original-From: Angelo Dureghello <adureghello@baylibre.org>
Subject: [PATCH v7 0/2] add mcf54415 DAC driver
Date: Wed, 01 Jul 2026 16:17:22 +0200
Message-Id: <20260701-wip-stmark2-dac-v7-0-ff8fdcc8010a@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4XRy07DMBAF0F+pssbI48c4YcV/IBbjFzXQpnJCo
 Kry7zhh0UJdsRxp7rmW59QMIacwNA+bU5PDlIbU78tg7jaN29L+JbDky9wILpArydlnOrBh3FF
 +E8yTY4Yjj6rzvlOxKalDDjF9reLT8888fNjX4MaFWTa2aRj7fFwrJ7Hs3dYnwTgLkmKLrVOc4
 NHS8T3ZHO5dv1u0NapB1qPReQqau6iBfkeXt03y3K65uiZkIbgWiiA6cPJWuxD1KKANnLzUhKb
 SDv+0QyFao5xEUh1wXyHUBSHhmlCFMAE1WSVA+xqhzwRC5QK6ENagbaVE9NpVCLwk2msCC6Fag
 +Ct7dD//Yt5nr8Bqq48OogCAAA=
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
 Angelo Dureghello <adureghello@baylibre.com>, 
 Andy Shevchenko <andriy.shevchenko@intel.com>
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
Changes in v7:
- keeping changelog in each single patch, where any
- Link to v6: https://patch.msgid.link/20260618-wip-stmark2-dac-v6-0-48761dbb96d7@baylibre.com

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
 drivers/iio/dac/mcf54415_dac.c      | 180 ++++++++++++++++++++++++++++++++++++
 4 files changed, 194 insertions(+)
---
base-commit: bc5a85a5441632f4bd7acd38620fdcbe4852a44f
change-id: 20260430-wip-stmark2-dac-7060f49dd94f

Best regards,
--  
Angelo Dureghello <adureghello@baylibre.com>

