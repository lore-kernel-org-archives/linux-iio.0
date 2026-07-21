Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D0D9429020;
	Tue, 21 Jul 2026 06:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784617116; cv=none; b=j1OKRmDv/aeJkjUB7/a54ZBY03kXwm3/rUME6ppV81XHMmDuXV63U/cOFRKwj65gMFqSb4FVibAXtop+0rs9OvEMGSK6UofGWzBIkY/hDVE1L6N+mq8Mdh+519LWjRe8yHoqUovpMAh0giYapuLkI74z8IpXafxrwL6IxeQIwEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784617116; c=relaxed/simple;
	bh=iGULKZ3vc0/BZb6Tgsq2caKjKRRwiXqObCdhwUQjTxM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TkTyK9JM98jDYkuDhxEh8pEszEuCVOCK0n9h0elszHDIl/E2u6Nr/M3NM16T2TT7BPLlc5ijbbxMefHaCYXpyEvtxcVwUHrYd6gA7cHX5kJJyfRg/v1cnBWIe6jFzzeD7uYpGfsOcRbD3ZAJ3gW5cFafHImhhQ0bKX7glL95ajI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=SrmZhfkE; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="SrmZhfkE"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 66L6w4kW53014039, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1784617084; bh=tE64jyiK83bGPmbhJBEGc+s/Xm9RfigyxWCVyakSsvY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=SrmZhfkEcTHKEP4UuQMwSD0aXfDK3cmodkCMkLmHd261xHhrdq/5M5gdd/e9wYZ3Z
	 8VXt1HxU64NRpTERysWcqgUlCiP3oW9Xr0OvXvG3qDwZRYaViQVsWX2/gXGnz2j/r5
	 OrIgGOXqafjGn/aDSfCNQjPm3mj2q2+TfeaXcw0H+tU/MJtp4hgQO2n2q/bNpqWV26
	 RdwjrvSKl4/AOsmkEdtZxRu4m6q3nGtW0eJxDO48k6+hmwPJRvyC50N6pC09CFUhYa
	 0kBTtOgWjAYkcZAXl9xC/5Iwfcgu5OfcegXkp33BkZzLmTZ4BLc7SjqC5vJkcBBYYS
	 t2ZxnOJEhSFqg==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 66L6w4kW53014039
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 21 Jul 2026 14:58:04 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 21 Jul 2026 14:58:03 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS05.realtek.com.tw (10.21.1.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 21 Jul 2026 14:58:02 +0800
Received: from cn1dhc-k02 (172.21.252.101) by RTKEXHMBS05.realtek.com.tw
 (10.21.1.55) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 21 Jul 2026 14:58:02 +0800
From: Yu-Chun Lin <eleanor.lin@realtek.com>
To: <linusw@kernel.org>, <andriy.shevchenko@intel.com>, <mwalle@kernel.org>,
	<brgl@kernel.org>, <tychang@realtek.com>, <wbg@kernel.org>,
	<mathieu.dubois-briand@bootlin.com>, <nuno.sa@analog.com>,
	<Michael.Hennerich@analog.com>, <jic23@kernel.org>, <andy@kernel.org>,
	<u.kleine-koenig@baylibre.com>, <dakr@kernel.org>, <bhelgaas@google.com>,
	<o-takashi@sakamocchi.jp>
CC: <eleanor.lin@realtek.com>, <dlechner@baylibre.com>,
	<linux-kernel@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
	<linux@analog.com>, <linux-iio@vger.kernel.org>, <cy.huang@realtek.com>,
	<james.tai@realtek.com>
Subject: [PATCH v6 0/8]  gpio: realtek: Add support for Realtek DHC RTD1625
Date: Tue, 21 Jul 2026 14:57:54 +0800
Message-ID: <20260721065802.689530-1-eleanor.lin@realtek.com>
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
Changes in v6:
- The dt-binding patch has already been applied by Bartosz and remains
unchanged. The DTS patch has been applied separately.

Patch 2 & 3:
- Move gpio_regmap_irq_reqres() and gpio_regmap_irq_relres() implementation
  from patch 2 to patch 3 for better split.

Patch 3:
- Add '_maybe_unused' to prevent build fail when CONFIG_REGMAP_IRQ is not
enabled.

Patch 5:
- Remove removed the hardcoded write-enable workarounds.
- Retain the necessary prototype updates in every driver using custom
reg_mask_xlate
- Add value_xlate to dynamically adjust the register mask and value right
before the actual register write operation.

Patch 8:
- Add 'select REGMAP_MMIO' into Kconfig.
- Replace GPIOCHIP_IRQ_RESOURCE_HELPERS with explicit irq_request_resources
and irq_release_resources callbacks using gpio_regmap_reqres_irq() and
gpio_regmap_relres_irq() introduced by Andy's patches.
- Replace the '*mask = 0' hack with 'return -ENOTSUPP'.
- Move variable operations out of scoped_guard().
- Add 'struct lock_class_key' to irq_domain map for proper lockdep annotation.
- Remove redundant 'ret' variable.
- Make regmap disable_locking depend on CONFIG_DEBUG_GPIO to avoid
dropping debugfs support unconditionally.
- Replace irq_domain_add_linear() with irq_domain_create_linear() using
dev_fwnode(dev), and manage lifetime with devm_add_action_or_reset().

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

Yu-Chun Lin (4):
  Revert "gpio: realtek: Add driver for Realtek DHC RTD1625 SoC"
  gpio: regmap: Add gpio_regmap_operation and value_xlate support
  gpio: regmap: Add set_config callback
  gpio: regmap: Add IRQ enable/disable helpers

 drivers/gpio/Kconfig                  |   2 +
 drivers/gpio/gpio-104-idi-48.c        |   7 +-
 drivers/gpio/gpio-i8255.c             |   4 +-
 drivers/gpio/gpio-idio-16.c           |   6 +-
 drivers/gpio/gpio-max7360.c           |   8 +-
 drivers/gpio/gpio-pcie-idio-24.c      |   6 +-
 drivers/gpio/gpio-regmap.c            | 101 ++++++-
 drivers/gpio/gpio-rtd1625.c           | 382 +++++++++++++++-----------
 drivers/iio/adc/ad7173.c              |   8 +-
 drivers/iio/addac/stx104.c            |   6 +-
 drivers/pinctrl/bcm/pinctrl-bcm63xx.c |   1 +
 drivers/pinctrl/pinctrl-tps6594.c     |   1 +
 include/linux/gpio/regmap.h           |  75 ++++-
 13 files changed, 401 insertions(+), 206 deletions(-)

-- 
2.43.0

