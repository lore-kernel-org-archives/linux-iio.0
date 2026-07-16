Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7A6441E6CA;
	Thu, 16 Jul 2026 12:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784204076; cv=none; b=Tgour50GmI4ybBfgn81/7vLTw1Yf/hq1Xzc82waDxICOAMPKYWvEIwnX85LQlJ9b0DStxIjAcEBW4oyL53oi4np+nRT34K+okmmRwSMRZbM9fZwGo76VtxrY1VE31IQ9FfcfJjdaNjFVZQGHDz8XO+xZSPusdrvnP1QQthzylKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784204076; c=relaxed/simple;
	bh=rLQpZwJYHm3pBx9twYZLrN9NmQn/pwgiSWbAdNWL9AU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=mQVSr0YgnBQMQ/JjvekSpqGOQDuOmU4NICHCPi/lWa6e8xNUDCRE2vte1BziYEWK+zzIlPsu3bmCd8IOGGf2IpTlC3NhMyQ2Aek6O6GI4LHSOiTB2/MU79x76H0zMw+d61MMrVm3log69/K6LRurX4Sc4aJ/FS8cJemvEeYLqtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e8wvuVoi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e8wvuVoi"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 13410C19425;
	Thu, 16 Jul 2026 12:14:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1784204075;
	bh=rLQpZwJYHm3pBx9twYZLrN9NmQn/pwgiSWbAdNWL9AU=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=e8wvuVoiPoo7HFvYlY8J8HptdBq2+JID4foGX9nHS7EZ6WxrHJqoSgEMrMFh2lLI3
	 g/nyPzzWUROsX9nfy5e8dgwtV0jj3p4iSJj/9Mto558A9+NM4laBoU8gquHKVaLl01
	 EyH0mVBTntmEMnjb2GY5EFsxxw8CFbUXJi3vWOHFSg9fwpB9wH+W/E3e/do7EsmRuT
	 sUFzoJLkXACk6uCPv2zALICbnP0dvLX7tyavNcQeGGYf/RPFYylWKeAO8TbEMxO3hr
	 DIbOVHZ14fBzw6IzcLCOMDNlbJ8n4F5/mLHY1DUEm/XWrSw/agUcVD/cL3eAMYUo6g
	 7adZby2Gyc54A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E34DDC44501;
	Thu, 16 Jul 2026 12:14:34 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Subject: [PATCH v8 0/8] New features for the AD5686 IIO driver
Date: Thu, 16 Jul 2026 13:14:16 +0100
Message-Id: <20260716-ad5686-new-features-v8-0-ebb0051af5e5@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABjLWGoC/33Qz07DMAwG8FeZcibIcRMn4cR7IA7542yVoJ3aU
 UBT351sF4oacfws+fdZvoqZp55n8XS4iomXfu7HoQb3cBDpFIYjyz7XLBCQgABlyIYcyYE/ZeF
 w+Zh4lqwUJdAx5+hF3TxPXPqvu/ryWvOpny/j9H0vWdRt+r+3KAmSvGJQznUZ7XMYwtt4fEzju
 7iBC24R30awIhaixq6YZCnvkG6DKGojXUWKQ1+iZY+EO0RvEOzaiK4IOk8YjM0Ryg4xW8S1EVM
 RY20KIcdiE+wQ+kUsmDZCt0vIG6+TDYHNDrEbREEbsRVRMSWX0AHrv49d1/UHoRGFi1UCAAA=
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
 Rodrigo Alencar <rodrigo.alencar@analog.com>, sashiko-bot@kernel.org, 
 Maxwell Doose <m32285159@gmail.com>, 
 Joshua Crofts <joshua.crofts1@gmail.com>, 
 Andy Shevchenko <andriy.shevchenko@intel.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784204073; l=3455;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=rLQpZwJYHm3pBx9twYZLrN9NmQn/pwgiSWbAdNWL9AU=;
 b=0i7Pvk2j5I1U00oTc1qz1LOcDzHPdVD5voFZth2xu5CkN32RSflshm8niY1YjHpeTqg5jvVvT
 1oASlI5d7EDCgaMO+A1zZdIEBwvBWT/JMyNEhocNW/ra8NLs374cWWg
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
Changes in v8:
- Add nul-check for chip_info match data.
- Update comments/commit text and other minor changes.
- Link to v7: https://lore.kernel.org/r/20260710-ad5686-new-features-v7-0-1bcc8c280e4d@analog.com

Changes in v7:
- Fix return value check of i2c_transfer().
- Amend refactoring of command/data macros.
- Link to v6: https://lore.kernel.org/r/20260705-ad5686-new-features-v6-0-269594c7aae5@analog.com

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
Rodrigo Alencar (8):
      iio: dac: ad5696: properly check i2c_transfer() return value
      iio: dac: ad5686: missing NULL check on match data
      iio: dac: ad5686: refactor command/data macros
      iio: dac: ad5686: introduce sync operation
      iio: dac: ad5686: implement new sync() op for the spi bus
      iio: dac: ad5686: read_raw/write_raw: use guard(mutex)()
      iio: dac: ad5686: add triggered buffer support
      iio: dac: ad5686: add gain control support

 drivers/iio/dac/Kconfig      |   2 +
 drivers/iio/dac/ad5686-spi.c | 142 +++++++++++++++++++++-------
 drivers/iio/dac/ad5686.c     | 217 +++++++++++++++++++++++++++++++++++++++----
 drivers/iio/dac/ad5686.h     |  52 ++++++++---
 drivers/iio/dac/ad5696-i2c.c |  18 ++--
 5 files changed, 355 insertions(+), 76 deletions(-)
---
base-commit: 4c0ecdbdc0d87570f74e656e21d56bae1ab6a8f1
change-id: 20260602-ad5686-new-features-e116c04bddb9

Best regards,
-- 
Rodrigo Alencar <rodrigo.alencar@analog.com>


