Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E67F43546C0;
	Thu, 23 Jul 2026 03:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784778193; cv=none; b=tN2WH8sQnWjTv5ckoTh1evuHEV3qPjtPk3Yb8S3vJV8cIi/5/1dFNV/uxwiC6gIrRnVMx05GODqulvLTxew7gtqBCoLz3BeZEW7Jv1IICkFxWz+U7Pvx9dcacvM6Mj/nO6GxMAKA9WBEt8PEKbL0wDU9GvY3qhvQTNeUhjXApm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784778193; c=relaxed/simple;
	bh=ralsew4SE6BU05qKQRCZfQ0YQBoR9l/lf8YHo5n7YFA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CoO9sIxVYdAMAcANtKqTQ+cATMkHv6mKrvRomrbkzYeFYmFNP76+WbU5o9DMu4HRfuV3xmG8Bx9EHrNYN4IMvjOm9sJkQvGvfvi43xcsjEx4/z+IbkmdW5xUyfTR1u9TuxKXpv28h+J7zxBW6TuHQWnYuE8P2L0jJG13OGy19QU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=Skt1GfjF; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="Skt1GfjF"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 66N3gb0N3179457, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1784778158; bh=xNunaMgWB2S+YDoubksZRc57aBU05ZLT9WdN+nxaBhM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=Skt1GfjFSAVh90zEK0/ORh0vmyoinQqvSfwDnRyRu0a48zUEkeKDB98Jw8Za2Eq8C
	 3e14XSz6knXu6vL5BUEoq9plqdpKZluzKukOr/f27rgLepPYoKST33dMkeSN5sqgZr
	 6BXE1GFXREwF9R7xlka+zuRMleeazkGcQkRvumRV1wIjrbq3/s1iPpwJ5xzM8aWclg
	 ZcYVNOpXo61bmi9eXIOvQ95il2DMtMhokx3qCo9zUlM/ZDc7YwdxENZKwnrhyV9bcz
	 uuVF09EJbxm5igvq/lA9izcAJkfZCNnpCIGrRSM+vyqseRSFKY3tgYuJM3BBLpURN9
	 sDJ/kOqJygANg==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 66N3gb0N3179457
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 23 Jul 2026 11:42:37 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 23 Jul 2026 11:42:38 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS06.realtek.com.tw (10.21.1.56) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 23 Jul 2026 11:42:38 +0800
Received: from cn1dhc-k02 (172.21.252.101) by RTKEXHMBS06.realtek.com.tw
 (10.21.1.56) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 23 Jul 2026 11:42:37 +0800
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
Subject: [PATCH v7 0/9] gpio: realtek: Add support for Realtek DHC RTD1625
Date: Thu, 23 Jul 2026 11:42:17 +0800
Message-ID: <20260723034237.2501507-1-eleanor.lin@realtek.com>
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
Changes in v7:
Patch 1:
- Add Acked-by tag from Andy.

Patch 2:
- Add Reviewed-by tag from Michael.

Patch 3:
- Add Reviewed-by tag from Michael.

Patch 4:
- Add Reviewed-by tag from Michael.
- Fix indentation by replacing spaces with a tab.

Patch 5 & 6:
- Create patch 6 and move value_xlate changes into patch 6.
- Add background context to kernel-doc comment for
'enum gpio_regmap_operation'.

Patch 7:
- Drop the reviewed by tag from Andy due to the signature changes.
- Add 'struct gpio_regmap' as the first parameter to the set_config callback.
- Add wrapper to bridge gpio_chip to gpio_regmap.

Patch 8:
- Add Reviewed-by tags from Michael and Andy.

Patch 9:
- Replace break with return 0 in functions that only consist of a switch-case
statement.
- Add a comment for 'platform_get_irq_optional()'.
- Update rtd1625_gpio_set_config() to align with the newly revised set_config
signature.
- Replace 'irq_domain_create_linear()' and 'devm_add_action_or_reset' with
'devm_irq_domain_instantiate()'.

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
 drivers/gpio/gpio-regmap.c            | 116 +++++++-
 drivers/gpio/gpio-rtd1625.c           | 389 +++++++++++++++-----------
 drivers/iio/adc/ad7173.c              |   8 +-
 drivers/iio/addac/stx104.c            |   6 +-
 drivers/pinctrl/bcm/pinctrl-bcm63xx.c |   1 +
 drivers/pinctrl/pinctrl-tps6594.c     |   1 +
 include/linux/gpio/regmap.h           |  80 +++++-
 13 files changed, 422 insertions(+), 212 deletions(-)

-- 
2.43.0

