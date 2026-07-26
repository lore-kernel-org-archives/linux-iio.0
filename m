Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61CD41D5CC9;
	Sun, 26 Jul 2026 12:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785070379; cv=none; b=NnVYISVVvhP32XaLMZvn/wpJ6RaqJ0tTgj6XBngK0T5iOFFj9/n/WmCGe5LJquaVhT9chcP+OBNddBGoBLwIVq2PomEY3fuB2TNR252p6Wa72fAfuW2biuTgxtXrxX/aoJ9TtCXil+CTBsygNnfWGcH5e/LlIQF5Xo8YshL8liQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785070379; c=relaxed/simple;
	bh=bp7eee8h+6irxIj/lG4Wkrl2e2v7Or8uVjOFwficGmg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Lng+JWKk8PcLfjnkxUYOZGfV/AGe2Pm3JXppPkiTlWREoIFnw1B6BCiQ8GLLCof+rh87/W6Rq0Kb1+mll3pl38xFGdC6VP6pLdD3WaJ/b+pgzdyKTPsKcAukMLlWbfex4DI4CI0RMU1lyTt4tH0C6CJPWjozSkNKYdy9spO6934=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=SIVcWbGY; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="SIVcWbGY"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 66QCq95412402717, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1785070329; bh=+o7AgV94ccTjF0QqKeSYFyr2+o9NWdtl2uHVkJ+2ChA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=SIVcWbGYNrec8JmxOHa38STUkRN1fXpltJr1sZVKhbzSLWxqEgOzdzQOIwAs5ODst
	 D0/hasLQhFbV7IWwFy1Sd7/nPR6JAt6WoRqQ2gcGHb64Z0Gw5vKQahzoQSY8li/4ug
	 zjxTrQ+QCdfVp3bjckH0GeefaV4zLf/u2UczknKtFaVPidNH5bhFh1l6a+7bYkPEGb
	 VKBotUcXOtGqGVNXGNeSHRi3j/ZbbxW0u/iJUjBsJnl0g6lwi2YyakqtHDS7feFlzO
	 CTKmHs6J9qRQcdEiVELjhsx8B3YscTVANh/zUtCxdso+yPdAer5Ai7RSJArZGTxzqz
	 10sNFzUqjaWbA==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 66QCq95412402717
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sun, 26 Jul 2026 20:52:09 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Sun, 26 Jul 2026 20:52:09 +0800
Received: from RTKEXHMBS03.realtek.com.tw (10.21.1.53) by
 RTKEXHMBS06.realtek.com.tw (10.21.1.56) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Sun, 26 Jul 2026 20:52:09 +0800
Received: from cn1dhc-k02 (172.21.252.101) by RTKEXHMBS03.realtek.com.tw
 (10.21.1.53) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Sun, 26 Jul 2026 20:52:09 +0800
From: Yu-Chun Lin <eleanor.lin@realtek.com>
To: <linusw@kernel.org>, <andriy.shevchenko@intel.com>, <mwalle@kernel.org>,
	<brgl@kernel.org>, <tychang@realtek.com>, <wbg@kernel.org>,
	<mathieu.dubois-briand@bootlin.com>, <nuno.sa@analog.com>,
	<Michael.Hennerich@analog.com>, <jic23@kernel.org>, <andy@kernel.org>,
	<o-takashi@sakamocchi.jp>
CC: <u.kleine-koenig@baylibre.com>, <dakr@kernel.org>, <bhelgaas@google.com>,
	<eleanor.lin@realtek.com>, <dlechner@baylibre.com>,
	<linux-kernel@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
	<linux@analog.com>, <linux-iio@vger.kernel.org>, <cy.huang@realtek.com>,
	<james.tai@realtek.com>, <stanley_chang@realtek.com>
Subject: [PATCH v8 0/9] gpio: realtek: Add support for Realtek DHC RTD1625
Date: Sun, 26 Jul 2026 20:51:51 +0800
Message-ID: <20260726125209.140307-1-eleanor.lin@realtek.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

For better review flow, this series includes Andy Shevchenko's
gpio-regmap fix patches [1] as a prerequisite. The first patch
reverts the previously applied patch from Bartosz Golaszewski.

This series then adds GPIO support for the Realtek DHC RTD1625 SoC.

Unlike the existing driver (gpio-rtd.c) which uses shared bank
registers, the RTD1625 features a per-pin register architecture where
each GPIO line is managed by its own dedicated 32-bit control register.
This distinct hardware design requires a new, separate driver.

Link: https://lore.kernel.org/lkml/20260702130903.1790633-1-andriy.shevchenko@linux.intel.com/ [1]
---
Changes in v8:
Patch 1:
- Add Acked-by tag from Linus.

Patch 2:
- Add Reviewed-by tag from Linus.

Patch 3
- Add Reviewed-by tags from Mathieu and Linus.

Patch 4
- Add Reviewed-by tag from Linus.

Patch 5
- Remove GPIO_REGMAP_IN and GPIO_REGMAP_OUT from 'enum gpio_regmap_operation'
and one extra regmap_read in gpio_regmap_get().
- Add Acked-by tags from William Breathitt Gray and Jonathan Cameron.

Patch 6
- Add Reviewed-by tags from Michael and Linus.
- Improve kernel-doc comments for 'enum gpio_regmap_operation' and value_xlate.

Patch 7
- Move the assignment of gpio->set_config into the if (config->set_config)
block.
- Add Reviewed-by tags from Michael and Linus.

Patch 8:
- Add Reviewed-by tag from Linus.

Patch 9
- Add error handlers in td1625_gpio_irq_handle().
- Move the direction-checking logic from the core to our custom
reg_mask_xlate() callback.
- Add Reviewed-by tag from Linus.

v7: https://lore.kernel.org/lkml/20260723034237.2501507-1-eleanor.lin@realtek.com/
v6: https://lore.kernel.org/lkml/20260721065802.689530-1-eleanor.lin@realtek.com/
v5: https://lore.kernel.org/lkml/20260702090115.2564318-1-eleanor.lin@realtek.com/
v4: https://lore.kernel.org/lkml/20260622092335.1166876-1-eleanor.lin@realtek.com/
v3: https://lore.kernel.org/lkml/20260512033317.1602537-1-eleanor.lin@realtek.com/
v2: https://lore.kernel.org/lkml/20260408025243.1155482-1-eleanor.lin@realtek.com/
v1: https://lore.kernel.org/lkml/20260331113835.3510341-1-eleanor.lin@realtek.com/

Andy Shevchenko (3):
  gpio: regmap: Provide default IRQ resource request and release
    callbacks
  gpio: regmap: Apply default resource callbacks for regmap IRQ chip
  gpio: regmap: Order kernel-doc descriptions with the actual appearance

Tzuyi Chang (1):
  gpio: realtek: Add driver for Realtek DHC RTD1625 SoC

Yu-Chun Lin (5):
  Revert "gpio: realtek: Add driver for Realtek DHC RTD1625 SoC"
  gpio: regmap: Add gpio_regmap_operation to extend reg_mask_xlate
    callback
  gpio: regmap: Add value_xlate callback
  gpio: regmap: Add set_config callback
  gpio: regmap: Add IRQ enable/disable helpers

 drivers/gpio/Kconfig                  |   2 +
 drivers/gpio/gpio-104-idi-48.c        |   7 +-
 drivers/gpio/gpio-i8255.c             |   4 +-
 drivers/gpio/gpio-idio-16.c           |   6 +-
 drivers/gpio/gpio-max7360.c           |   8 +-
 drivers/gpio/gpio-pcie-idio-24.c      |   6 +-
 drivers/gpio/gpio-regmap.c            | 104 ++++++-
 drivers/gpio/gpio-rtd1625.c           | 408 +++++++++++++++-----------
 drivers/iio/adc/ad7173.c              |   8 +-
 drivers/iio/addac/stx104.c            |   6 +-
 drivers/pinctrl/bcm/pinctrl-bcm63xx.c |   1 +
 drivers/pinctrl/pinctrl-tps6594.c     |   1 +
 include/linux/gpio/regmap.h           |  73 ++++-
 13 files changed, 421 insertions(+), 213 deletions(-)

-- 
2.43.0

