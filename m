Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83DC622D785;
	Tue, 12 May 2026 03:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778556881; cv=none; b=iHJyZSGJpnbjhCGr3R6jVPw5O/pz1lPM7T9Y46ZsKTgEmyXOZLbSFQbkNM/axy/ga/6IaCdNeNBhEWZAZRqpQFZ4VzhEEj88WT0qQa7LhRC6SwOUDGeWjJwSgRjTFWjE34bsRoMR0FA2fBQNrsHpTt5x5wmFi5d0R+vhnOjuMJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778556881; c=relaxed/simple;
	bh=wEg5B5/WRkgsiOTa8QdRiGTjTWXQVf13qM3qcQBbfh4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pYKLalsr29V7lBXMZpw1XGHQcm9bFhSpt9VO7RuLU31YHE8zTavklAPG7QVfB2am4HWase1SS+xccjM7yepbcID9IaZrFnfKzVyxS3IY64YHHMa9sFvX3P4BG8rnKseoBaCmEGPHGIQTdgXKCI14qGqpvJnIgQ++QKI0iOiQtHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=laDma3c0; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="laDma3c0"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 64C3XHVE03571926, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1778556797; bh=JpnVsZFsIPTPuJBPO8NxiEJrLCSiAZmgNj9J0Bjw4kc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=laDma3c0Ay2CyWvf8BKDTXdlC9DBgQwfnqs4SHQIioUfoxPovpOhgeTORHquWP0oU
	 JYCDOyPo0PVtkDKqGM7UP+wxpyEk2oowB+tx7H/HtqaUACwdHD27Z5++UvEYs8ZfkG
	 bvzFymh06eq5V7Ix8tc2Sr6zmc/YycrjEItFq7X9sgRwSVI+h3cZyMM8FLUEuPpk9/
	 G91e0Nj4C5Vc9D4jvWME3QGyT40H/NcvGzLG9ZXZO2IBxq4840HNVsI5oEGhrMaXLf
	 86PRuBjEYuNG8viHysxKdkV1zebMC9yFX7boPuEkV8r6TBx/cDNCNEtJe6MtgutPpy
	 HLSXFOP8CJWGg==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.27/5.94) with ESMTPS id 64C3XHVE03571926
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 May 2026 11:33:17 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 12 May 2026 11:33:17 +0800
Received: from cn1dhc-k02 (172.21.252.101) by RTKEXHMBS05.realtek.com.tw
 (10.21.1.55) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 12 May 2026 11:33:17 +0800
From: Yu-Chun Lin <eleanor.lin@realtek.com>
To: <linusw@kernel.org>, <brgl@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <afaerber@suse.com>,
        <wbg@kernel.org>, <mathieu.dubois-briand@bootlin.com>,
        <mwalle@kernel.org>, <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <jic23@kernel.org>, <nuno.sa@analog.com>, <andy@kernel.org>,
        <dlechner@baylibre.com>, <tychang@realtek.com>
CC: <linux-gpio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-realtek-soc@lists.infradead.org>, <linux-iio@vger.kernel.org>,
        <cy.huang@realtek.com>, <stanley_chang@realtek.com>,
        <eleanor.lin@realtek.com>, <james.tai@realtek.com>
Subject: [PATCH v3 0/7] gpio: realtek: Add support for Realtek DHC RTD1625
Date: Tue, 12 May 2026 11:33:10 +0800
Message-ID: <20260512033317.1602537-1-eleanor.lin@realtek.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Hi all,

This series adds GPIO support for the Realtek DHC RTD1625 SoC.

Unlike the existing driver (gpio-rtd.c) which uses shared bank registers,
the RTD1625 features a per-pin register architecture where each GPIO line
is managed by its own dedicated 32-bit control register. This distinct
hardware design requires a new, separate driver.

To accommodate this, we extend the gpio-regmap core framework to handle
per-pin register operations, write-enable mechanisms, and add custom
set_config callback.

Best Regards,
Yu-Chun Lin
---
Changes in v3:

patch 1 (gpio: Replace "default y" with "default ARCH_REATLEK" in Kconfig):
- Chang "remove default y" to "replace it with default ARCH_REALTEK".

patch 2 (gpio: regmap: add gpio_regmap_get_gpiochip() accessor):
- New patch

patch 3 (gpio: regmap: Add gpio_regmap_operation and write-enable support):
- New patch
- Update all drivers utilizing the gpio-regmap framework to accommodate
the new reg_mask_xlate function signature.

patch 4 (gpio: regmap: Add set_config callback):
- New patch

patch 5 (dt-bindings: gpio: realtek: Add realtek,rtd1625-gpio):
- Remove description for reg.
- Add Reviewed-by tag from Krzysztof.

patch 6 (gpio: realtek: Add driver for Realtek DHC RTD1625 SoC):
- Refactor to utilize the gpio-regmap framework.
- Create a custom irqdomain.

patch 7(arm64: dts: realtek: Add GPIO support for RTD1625):
- Add Reviewed-by tag from Bartosz.

v2: https://lore.kernel.org/lkml/20260408025243.1155482-1-eleanor.lin@realtek.com/
v1: https://lore.kernel.org/lkml/20260331113835.3510341-1-eleanor.lin@realtek.com/

Tzuyi Chang (2):
  dt-bindings: gpio: realtek: Add realtek,rtd1625-gpio
  gpio: realtek: Add driver for Realtek DHC RTD1625 SoC

Yu-Chun Lin (5):
  gpio: Replace "default y" with "default ARCH_REALTEK" in Kconfig
  gpio: regmap: add gpio_regmap_get_gpiochip() accessor
  gpio: regmap: Add gpio_regmap_operation and write-enable support
  gpio: regmap: Add set_config callback
  arm64: dts: realtek: Add GPIO support for RTD1625

 .../bindings/gpio/realtek,rtd1625-gpio.yaml   |  71 ++
 arch/arm64/boot/dts/realtek/kent.dtsi         |  39 ++
 drivers/gpio/Kconfig                          |  15 +-
 drivers/gpio/Makefile                         |   1 +
 drivers/gpio/gpio-104-idi-48.c                |  18 +-
 drivers/gpio/gpio-i8255.c                     |  13 +-
 drivers/gpio/gpio-idio-16.c                   |  16 +-
 drivers/gpio/gpio-max7360.c                   |  10 +
 drivers/gpio/gpio-pcie-idio-24.c              |  15 +-
 drivers/gpio/gpio-regmap.c                    |  80 ++-
 drivers/gpio/gpio-rtd1625.c                   | 608 ++++++++++++++++++
 drivers/iio/adc/ad7173.c                      |  32 +-
 drivers/iio/addac/stx104.c                    |  17 +-
 drivers/pinctrl/bcm/pinctrl-bcm63xx.c         |  12 +-
 drivers/pinctrl/pinctrl-tps6594.c             |  10 +
 include/linux/gpio/regmap.h                   |  51 +-
 16 files changed, 963 insertions(+), 45 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/gpio/realtek,rtd1625-gpio.yaml
 create mode 100644 drivers/gpio/gpio-rtd1625.c

-- 
2.34.1

