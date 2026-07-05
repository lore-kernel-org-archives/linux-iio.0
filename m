Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69F4837A488;
	Sun,  5 Jul 2026 11:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783251562; cv=none; b=qMU8j4TeE+J2Uy1TySWvoJpvQrs9qcCSYdh83Qig/ZKawTShaZG0DIGHe5OWwqOl24Ef+h5RGp3whLM4bJPeWC6tTslhGcbf1QbuC3dpSjs3oBZnpd8JP8Z/P2wGrjhQYIi9iJEcC18ioHA94O2YCVD8S5uPdVauurTSkqDoVEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783251562; c=relaxed/simple;
	bh=cRmTCTA5csWbCv0b+iGmBX/uosZKYsS/BSqEGF8I34o=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=U6eY6k1y6Ks5X8TVbjUzjueO+uVbUjCqhPb0LTBu2G6ozoXHo31LbuF0P7DVMl2p0YWC0Ge7FrugWRPs/H8/dco5vO5C4U+DuoQhWDrZUYXdcSTsstp8geHvMO+z2AkcKRHOh4f2cCRjQd7O1g4QRZAD597Cvg81AaNDFfMz6MI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EN8OcLiM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EN8OcLiM"
Received: by smtp.kernel.org (Postfix) with ESMTPS id F052BC2BCB8;
	Sun,  5 Jul 2026 11:39:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1783251562;
	bh=cRmTCTA5csWbCv0b+iGmBX/uosZKYsS/BSqEGF8I34o=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=EN8OcLiMUFDNhyRzdBp2oXiaqhq1TYbkGM8CJWLY37BIl8ERFrvaA1moV7KJgOexb
	 uUB63SakC77SyUDluyetI8IkPQrAPRD9WZOecVPE2yfFgfCcIMAaj9JphjdP4EER4N
	 iJcgUCWCjWu4I+0UtkOwBWWp1pJnm4U3krSJ6ErWDs1S2K4waeVkP5lnavv0uiym71
	 GdUAilhLnEDIGd6nR1D+BRRZgFE0FtH9g8uBLuwafXjeS/1wHhomci4D4W64oZQW1v
	 4UdruwOCWiJGOxWUKCR2htFk9q3S+i/u+WDb26S+axhDK6o+RYms6oOijhBTJSnZCh
	 yYdniJadRKL+g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB7EBC43458;
	Sun,  5 Jul 2026 11:39:21 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Subject: [PATCH v6 0/6] New features for the AD5686 IIO driver
Date: Sun, 05 Jul 2026 12:38:55 +0100
Message-Id: <20260705-ad5686-new-features-v6-0-269594c7aae5@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAE9CSmoC/33NTW7DIBCG4atErEsFgxmgq94j6oKfIUFq7QpSp
 1Xku5dk5cpWl+8nzTM31qgWauzlcGOV5tLKNPbApwOLZz+eiJfUm4EAFCiA+6TRIh/pyjP5y1e
 lxklKjGIIKQXH+uVnpVy+H+rxrfe5tMtUfx5PZnlf//dmyQVHJ0lIa1UC8+pH/z6dnuP0we7gD
 GvE7SPQESPCACrraDBtELVCJO4jqiPZgsvBkAOEDTKsEFD7yNARsA7Ba5OCyBtErxG7j+iOaGO
 i9ylkE8UfZFmWX75rPbfLAQAA
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
 Maxwell Doose <m32285159@gmail.com>, 
 Joshua Crofts <joshua.crofts1@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783251560; l=2903;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=cRmTCTA5csWbCv0b+iGmBX/uosZKYsS/BSqEGF8I34o=;
 b=/p0HUcH8oDFF/pcQkr+mAD3c6F6UBjyPOFH5O3ZVQv188MZnhA0JlQhi3E/hI6sMt16IbjJ1O
 oE7ewGn8EBADeIt3iVPS21bcdkCaMEb5WOB65bIsp81+fanfShjH5EJ
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
Changes in v6:
- Refactor command/data macros in favor of FIELD_PREP()
- Link to v5: https://lore.kernel.org/r/20260628-ad5686-new-features-v5-0-577caadbf7c0@analog.com

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
Rodrigo Alencar (6):
      iio: dac: ad5686: refactor command/data macros
      iio: dac: ad5686: introduce sync operation
      iio: dac: ad5686: implement new sync() op for the spi bus
      iio: dac: ad5686: read_raw/write_raw: use guard(mutex)()
      iio: dac: ad5686: add triggered buffer support
      iio: dac: ad5686: add gain control support

 drivers/iio/dac/Kconfig      |   2 +
 drivers/iio/dac/ad5686-spi.c | 136 +++++++++++++++++++++-------
 drivers/iio/dac/ad5686.c     | 209 +++++++++++++++++++++++++++++++++++++++----
 drivers/iio/dac/ad5686.h     |  43 ++++++---
 drivers/iio/dac/ad5696-i2c.c |  13 +--
 5 files changed, 334 insertions(+), 69 deletions(-)
---
base-commit: 4c0ecdbdc0d87570f74e656e21d56bae1ab6a8f1
change-id: 20260602-ad5686-new-features-e116c04bddb9

Best regards,
-- 
Rodrigo Alencar <rodrigo.alencar@analog.com>


