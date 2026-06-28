Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B5B13A5E7D;
	Sun, 28 Jun 2026 14:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782655794; cv=none; b=Tgi9mg/1GwB2eOCx/eGM06dOGjX01xLciO3LMFY/Dhnvc4TZ5XJNu2nPLJemTgukFIYkqeEUxvzSwlMdH1Aj5Ci56dk2XNzQMqYhDq3EyvuWgeDjItbQrrQpbCUP22mtFmFNlhiq1dbI1ZWk6Uv8kzJ13RchHWI9jKCPsC811Yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782655794; c=relaxed/simple;
	bh=bi5FJvmSJHeupHZtWBU2pPq0Vd3xiRfvLjFBOTVH9p0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=s+2wYtkVHubYSFo2eDK/1C4dznIIkWA4DAgmKyDPtfNF2kiC3Kk01umGheBZcRtqghkH9MGrqDPNEmZTkUr/E/n36QBYsec0uwkT++3KFZVPyVGleYDsximfc1dvqdkLyMLqmU//yn+hmToLqqE6LzFUpCoAh3O/r8mPrCWcZ00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rg1bYO51; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rg1bYO51"
Received: by smtp.kernel.org (Postfix) with ESMTPS id BAFCBC2BCB4;
	Sun, 28 Jun 2026 14:09:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1782655793;
	bh=bi5FJvmSJHeupHZtWBU2pPq0Vd3xiRfvLjFBOTVH9p0=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=Rg1bYO517FYY58rnLLQ/iMQlzQzP5dV7LXBSbsQBmMYyGOzlBhQKpd08dwqvMfco9
	 vdXbff0Y9O4Gp+ffIkq9hsm2lIoHz3t7wU8lldvyjeKT4m4607iX5Ma7iE6mMs8Kmt
	 PvUreZjFYpSqIGtmkn81lOCsi3NWFH/aX858M0R49C8bSO2Jp8E1MQBbJKvFHcUUb7
	 IF+AQQpkiTkvLbct03xiaDCWh5mHz1ADWq01ypZizVHxem5+XxMpmOv4+83Faga99o
	 Sk3nHPf0uq48FgzFnK/4xi+uogU8eJCct/jfF46Xm+7T01QGCh8FreSIzvdRosUvAX
	 F1GIDJc2ItmgQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B27D5C43458;
	Sun, 28 Jun 2026 14:09:53 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Subject: [PATCH v5 00/12] New features for the AD5686 IIO driver
Date: Sun, 28 Jun 2026 15:08:07 +0100
Message-Id: <20260628-ad5686-new-features-v5-0-577caadbf7c0@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMcqQWoC/33NwY7CIBDG8VcxnMXA0A6wJ9/DeIAyKMnabkCrx
 vTdRU81Nnv8f8n85sEK5USF/aweLNOYShr6Gu16xbqj6w/EU6jNQAAKFMBdaNEg7+nKI7nzJVP
 hJCV2ovEheMvq5V+mmG5vdbevfUzlPOT7+8koX+v/3ii54GglCWmMCqC3rne/w2HTDSf2AkeYI
 3YZgYpo4RtQse00hi9EzRCJy4iqSDRgo9dkAeELaWYIqGWkqQgYi+BaHbyIH8g0TU+C/hf4hgE
 AAA==
X-Change-ID: 20260602-ad5686-new-features-e116c04bddb9
To: Michael Auchter <michael.auchter@ni.com>, linux@analog.com, 
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
 Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
 Rodrigo Alencar <rodrigo.alencar@analog.com>, 
 Conor Dooley <conor.dooley@microchip.com>, 
 Maxwell Doose <m32285159@gmail.com>, 
 Joshua Crofts <joshua.crofts1@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782655792; l=3288;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=bi5FJvmSJHeupHZtWBU2pPq0Vd3xiRfvLjFBOTVH9p0=;
 b=UakpPUFnMsUh2aBV1mDcwJ9JZCnxWXkT6bLvOV8+4OlHLz6nWN/abVJtrMPr0nuI9KUIZ15kt
 akuFJILBRTmDsaBFEW7Fjd+EA9ZkkMXc6U/YTD+oin7FHq4HLZWLN2F
X-Developer-Key: i=rodrigo.alencar@analog.com; a=ed25519;
 pk=ULeHbgU/OYh/PG/4anHDfLgldFItQHAhOktYRVLMFRo=
X-Endpoint-Received: by B4 Relay for rodrigo.alencar@analog.com/default
 with auth_id=561
X-Original-From: Rodrigo Alencar <rodrigo.alencar@analog.com>
Reply-To: rodrigo.alencar@analog.com

This is the second series of three on updating the AD5686 driver.

Initially, a big patch series was sent:
https://lore.kernel.org/r/20260422-ad5313r-iio-support-v1-0-ed7dca001d1b@analog.com

Then, the first patch series added fixes and cleanups:
https://lore.kernel.org/linux-iio/20260524-ad5686-fixes-v7-0-b6bf395d08bd@analog.com/

This one is introducing new features:
- Consume optional reset and correct power supplies;
- LDAC GPIO handling (active-low, held low when unused);
- SPI bus sync() implementation for batching multiple transfers;
- Triggered buffer support, leveraging LDAC and sync() to flush
  all channel writes atomically;
- Gain control support through the scale property.

Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
---
Changes in v5:
- Create auxiliary handler for the triggered buffer.
- Do not allow modification of double_scale in case gain_gpio is not set.
- Link to v4: https://lore.kernel.org/r/20260623-ad5686-new-features-v4-0-28962a57db0f@analog.com

Changes in v4:
- Replace anyof+const for enum in dt-bindings. 
- Address some sashiko's comments.
- Use guard(mutex)() in trigger handler and other misc changes.
- Link to v3: https://lore.kernel.org/r/20260616-ad5686-new-features-v3-0-f829fb7e9262@analog.com

Changes in v3:
- Add range-double property.
- Acquire reset control after power-up delay.
- Include cleanup.h and use guard(mutex)() in read_raw().
- Link to v2: https://lore.kernel.org/r/20260609-ad5686-new-features-v2-0-70b423f5c76d@analog.com

Changes in v2:
- Get reset control deasserted.
- Update entire spi_transfer struct rather than individual fields.
- Replace udelay() for fsleep() in probe().
- Minor changes addressing further feedback.
- Link to v1: https://lore.kernel.org/r/20260602-ad5686-new-features-v1-0-691e01883d27@analog.com

---
Rodrigo Alencar (12):
      dt-bindings: iio: dac: ad5696: add reset/ldac/gain support
      dt-bindings: iio: dac: ad5696: rework on power supplies
      dt-bindings: iio: dac: ad5686: add reset/ldac/gain support
      dt-bindings: iio: dac: ad5686: rework on power supplies
      iio: dac: ad5686: add support for missing power supplies
      iio: dac: ad5686: consume optional reset signal
      iio: dac: ad5686: add ldac gpio
      iio: dac: ad5686: introduce sync operation
      iio: dac: ad5686: implement new sync() op for the spi bus
      iio: dac: ad5686: read_raw/write_raw: use guard(mutex)()
      iio: dac: ad5686: add triggered buffer support
      iio: dac: ad5686: add gain control support

 .../devicetree/bindings/iio/dac/adi,ad5686.yaml    |  72 +++++-
 .../devicetree/bindings/iio/dac/adi,ad5696.yaml    |  73 +++++-
 drivers/iio/dac/Kconfig                            |   2 +
 drivers/iio/dac/ad5686-spi.c                       | 125 ++++++++---
 drivers/iio/dac/ad5686.c                           | 249 +++++++++++++++++++--
 drivers/iio/dac/ad5686.h                           |  34 ++-
 drivers/iio/dac/ad5696-i2c.c                       |   2 +-
 7 files changed, 496 insertions(+), 61 deletions(-)
---
base-commit: 7667a80340e99fd45357d0c90ae05813b01bbfef
change-id: 20260602-ad5686-new-features-e116c04bddb9

Best regards,
-- 
Rodrigo Alencar <rodrigo.alencar@analog.com>


