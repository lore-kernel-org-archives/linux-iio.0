Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C00C3F44F0;
	Tue,  9 Jun 2026 10:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780999991; cv=none; b=OEWodmLEBD2oa7acOGQEbtQlcLKw8lonG5wPNgsHh3Jnw2kHa7tjATJRN3dgSSHomXpps3J29J+Hs/5X3YUBe0VC9vc1Cdr7BPuUBN/17N1HuubBDKpR4QLHaiONpuxz4EDQVeZWWmoIkyEr7cPcA2Cg86YWISVivROPqFu2WKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780999991; c=relaxed/simple;
	bh=j3jOR2pj9QA/qjuI0KedbquDj1TnipFEVD0itDA1WiU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=g5uZ6fvjiGku1GB4ewzS/O2tPDFRcdQN6noYsEq/y+lzI1H5t6F+j3qij/AEsxxwds46RrF+3GOHfhkth7QHrFRerj6Mo9NovinD+Xoqgim27zAp8/jGvPijw1EEJ0exkUpg6gDa161lmhKi4OY+1aVwS7fxKzyGnXWSP8ma9Do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O4JrcTrS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O4JrcTrS"
Received: by smtp.kernel.org (Postfix) with ESMTPS id D3EFDC2BCB4;
	Tue,  9 Jun 2026 10:13:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1780999990;
	bh=j3jOR2pj9QA/qjuI0KedbquDj1TnipFEVD0itDA1WiU=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=O4JrcTrSWLSTx7t7pewygwJbE7PfFWaZyn6Q9YFLy5yJDHzwRct7BnOXXl1wY7RNW
	 H04Vcf3plBYBgm/unDKnY7ubJyJ/CdLPNsNWc39zKJk3oifYHCkz7jAqbCdL2wF7gZ
	 Be2bgnUOPmE18ep193cqkC8OAX5gSa8x2/Bz4BbGDj0NkWdqXSHCDVXnstJUZ+wYVr
	 xF25jNXcIIbZtaV9kJcYmRx1eBPaKAYfidLNU5MrMEOdq5BOJH/AoRjouNK21915xY
	 Q+8OdqQOxw8Wp85Kn6ZYDKriTRA+hH+s30Bi8krxfpgjrnTU9ZM+AJskl5ehQyuh3/
	 SK9GuTeENjRYA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A073DCD8CA8;
	Tue,  9 Jun 2026 10:13:10 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Subject: [PATCH v2 00/12] New features for the AD5686 IIO driver
Date: Tue, 09 Jun 2026 11:12:55 +0100
Message-Id: <20260609-ad5686-new-features-v2-0-70b423f5c76d@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACfnJ2oC/32NQQ7CIBBFr9LM2jGAitSV9zBdUJi2JAoNVNQ03
 F3sAVy+l/z3V0gUHSW4NCtEyi654CuIXQNm0n4kdLYyCCYkk0ygtiepJHp64UB6eUZKSJxLw46
 9tX0LdTlHGtx7q966ypNLS4if7STzn/3fyxwZypYT40odrDhftdf3MO5NeEBXSvkCl6mQN7cAA
 AA=
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780999989; l=2525;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=j3jOR2pj9QA/qjuI0KedbquDj1TnipFEVD0itDA1WiU=;
 b=W4y8cOMoFMjONOMjwCufoRcdIQyQBDs4VWWrQiFevaiOVdED82xOQpHA812z8noIcbnRMLfPz
 GC9t2If6E0EA8reNPFvimjneKa6kXXj2NtTqhGX8zlui/Cb2R+cNJvq
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
Changes in v2:
- Get reset control deasserted.
- Update entire spi_transfer struct rather than individual fields.
- Replace udelay() for fsleep() in probe().
- Minor changes addressing further feedback.
- Link to v1: https://lore.kernel.org/r/20260602-ad5686-new-features-v1-0-691e01883d27@analog.com

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
 .../devicetree/bindings/iio/dac/adi,ad5696.yaml    |  65 +++++-
 drivers/iio/dac/Kconfig                            |   2 +
 drivers/iio/dac/ad5686-spi.c                       | 122 +++++++++---
 drivers/iio/dac/ad5686.c                           | 219 +++++++++++++++++++--
 drivers/iio/dac/ad5686.h                           |  33 +++-
 drivers/iio/dac/ad5696-i2c.c                       |   2 +-
 7 files changed, 444 insertions(+), 61 deletions(-)
---
base-commit: ae696dfa47c30016cd429b9db5e70b259b8f509e
change-id: 20260602-ad5686-new-features-e116c04bddb9

Best regards,
-- 
Rodrigo Alencar <rodrigo.alencar@analog.com>


