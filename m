Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F858361675;
	Tue,  2 Jun 2026 16:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780418032; cv=none; b=HDsZa+axX1BAN8R9+XrX/3Vx/1AuiwIZjyZ9fTcTL6AYIIMF/YhaCg9pk04WRKVVib3YtIVdsxRSilrG/fl9RYA90hMgqMex6gBLdFCVE19SlU9KEaDR1C324iHgJqr7b46Tju1mR5F+eX/YDlnEGM/jmupqIt3xZWfZrXiPvPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780418032; c=relaxed/simple;
	bh=dcsHKAoQP64Fz4xl/KKbSuqrRQCZoXXSHYxQq69uwEQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=HmlLY7wRwRHtU7mmy3/BzG3O4UNA8h4vFVr3DZDPSYSxowLzv1gQaj4ZkhTWDPjw0RuiDbEXiN/rxUzVF3UEMzXyoEOd3dAMjGCNdpR/qc+y89N2sBzpz3RUZ4D5+kigKcGPjDIkbtyCjjWmMmMt6CjJE76l9P2MFc9bo/5KNa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dd2QdNTN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dd2QdNTN"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2DE94C2BCC4;
	Tue,  2 Jun 2026 16:33:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1780418032;
	bh=dcsHKAoQP64Fz4xl/KKbSuqrRQCZoXXSHYxQq69uwEQ=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=dd2QdNTNrQYeQ6xPaIPsRXMkwg//xltULE09jvagSyNHX6pbGx5mebUqSfJqRQcfd
	 u8srw1mvrgw4geIHZo/f7hLpF1vUxTGYcdG+xfTUo8ckmxzgyFl+rtstAYykTu+O4Q
	 N+QfBTsjHLGyJISRaLSvtFFdj7cSQSXejyOdujDxDPBYqug7CFy73L40y66/eFFqKM
	 r8/FSetSiu9ek0QJyqCyQfo0ZCvu5OMP1OkFrbjAYiR3wLMN/QWoL9iV1+RXq71Xhy
	 RqRj3qtn7TGkMyZqhWUMebLVXY8Nb6f+c7r41EsVLyoS74BJF2MBYlUN2tXPTp4F7G
	 9zSOP63i4Xyfg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05A59CD5BD1;
	Tue,  2 Jun 2026 16:33:51 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Subject: [PATCH 00/12] New features for the AD5686 IIO driver
Date: Tue, 02 Jun 2026 17:33:47 +0100
Message-Id: <20260602-ad5686-new-features-v1-0-691e01883d27@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOsFH2oC/x3MQQqDMBBG4avIrB1Igg7qVcRFNL/tbNKSqC2Id
 ze4/BbvnZSRFJmG6qSEQ7N+YoGtK1rePr7AGorJGSdGjGMfWumEI368wm97QmZYK4tp5hDmnkr
 5TVj1/1zH6bpuO9vkBWUAAAA=
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
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780418030; l=2210;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=dcsHKAoQP64Fz4xl/KKbSuqrRQCZoXXSHYxQq69uwEQ=;
 b=YQcJxhCXAdZjqbq0PTcmgbJdHmJnFTw39NM1lD/TLpGichFY1mMwDrXvtgKJ2VlDpv4FCv3Jf
 i7Dl/EGxMwjDyAXWpJpZHuXkvGyqfUarsn9FKHyCzvbc+foBztTPR+T
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
Rodrigo Alencar (12):
      dt-bindings: iio: dac: ad5696: add reset/ldac/gain gpio support
      dt-bindings: iio: dac: ad5696: rework on power supplies
      dt-bindings: iio: dac: ad5686: add reset/ldac/gain gpio support
      dt-bindings: iio: dac: ad5686: rework on power supplies
      iio: dac: ad5686: add support for missing power supplies
      iio: dac: ad5686: consume optional reset signal
      iio: dac: ad5686: add ldac gpio
      iio: dac: ad5686: introduce sync operation
      iio: dac: ad5686: implement new sync() op for the spi bus
      iio: dac: ad5686: add triggered buffer support
      iio: dac: ad5686: write_raw: use guard(mutex)()
      iio: dac: ad5686: add gain control support

 .../devicetree/bindings/iio/dac/adi,ad5686.yaml    |  62 +++++-
 .../devicetree/bindings/iio/dac/adi,ad5696.yaml    |  65 ++++++-
 drivers/iio/dac/Kconfig                            |   2 +
 drivers/iio/dac/ad5686-spi.c                       | 109 ++++++++---
 drivers/iio/dac/ad5686.c                           | 212 +++++++++++++++++++--
 drivers/iio/dac/ad5686.h                           |  29 ++-
 drivers/iio/dac/ad5696-i2c.c                       |   2 +-
 7 files changed, 422 insertions(+), 59 deletions(-)
---
base-commit: 3dee3cddb9b2f78447bf1077f3eb8ae0b8251247
change-id: 20260602-ad5686-new-features-e116c04bddb9

Best regards,
-- 
Rodrigo Alencar <rodrigo.alencar@analog.com>


