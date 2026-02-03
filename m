Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CE7E31A7F2;
	Tue,  3 Feb 2026 11:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770117859; cv=none; b=fX9inN515y9LnwvGDmgH1obOHaQwTnDPIrNisbI/wWZqMQ2YZF5CePoJH/py2muanAHsZAN9mjDe9VNT6UUNntOBHRT6XX/2IwLqoatp2cPXdG2y5f01RRHqdGAD0ZHbDecezvrF02IT/ww3PqWhwU3zTDzCVtnTeHQfkmd0oTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770117859; c=relaxed/simple;
	bh=3l8TsunZZKRsjK+8ZR9igab30aE9Da2kp9LQ9mqBi+k=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=eHR2kdfhQWvKkXmsqMiCWVuI/n0iBzzGH5csQtARNzPe1ocCONnmgdsEdRplk5x25sK5JC096WEwv/ii9yUKomSAFb2eOOlh2cH+7w5HniUXwuWlir9LJQ5z7EnJIgsKud+YO0Jdd5/tbsm2sGgi3bV45ywwEtGjmfwaqKheZyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jcAxnLnb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jcAxnLnb"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0FD37C116D0;
	Tue,  3 Feb 2026 11:24:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770117859;
	bh=3l8TsunZZKRsjK+8ZR9igab30aE9Da2kp9LQ9mqBi+k=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=jcAxnLnbdnejdwpBuHzVgJCe6HJBgDVlXTAffYcdFzg6LQjYqU618jKu8kqp3hE1v
	 IQ8QedFEkjkp56yLUYn3+KbhkfXPFvxEDXa2VNx9PyT2dsJ2kfcI9wJI3MLtNUOW23
	 2cKRMFKLxbr+s2z5KLNlwI4jRVDUt3XoXruYborkpEcpFGHvJ9HYZqU0cnawArf3eu
	 6uPkaLHaGdKI/OM0RT9ZT+7xl1YZ4ZzuZ2h8+KAunpfA1Dze/zz4Pi2RTYzraq7ZI8
	 RwwuZhKhOSsGpV2Hh5EeiGajLgFVE5gJYbclk8bBv8AZJZVhgdqNfkJxAc50YGnpMj
	 CAim/7iXPndJA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 035BAE6E813;
	Tue,  3 Feb 2026 11:24:19 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Subject: [PATCH v3 0/9] iio: amplifiers: ad8366: driver update and dt
 support
Date: Tue, 03 Feb 2026 11:24:06 +0000
Message-Id: <20260203-iio-ad8366-update-v3-0-5d5636b5181a@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANbagWkC/23NQQ7CIBCF4asY1mIYoKR15T2MiymMLYmWBirRN
 L27tCtNuvxfMt/MLFH0lNj5MLNI2ScfhhLqeGC2x6Ej7l1pJoWsACRw7wNHVytj+Gt0OBGvDLZ
 oq7ptLbJyN0a6+/dmXm+le5+mED/biwzrumpGADQ7WgYueC20JqmoMRovOOAjdCcbnmzlsvwhp
 NkjZCFsg9opQGoF/BHLsnwB9OQZDPYAAAA=
X-Change-ID: 20251121-iio-ad8366-update-56abac58bbca
To: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Lars-Peter Clausen <lars@metafoo.de>, Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Rodrigo Alencar <rodrigo.alencar@analog.com>, 
 Alexandru Ardelean <alexandru.ardelean@analog.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1770117857; l=2479;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=3l8TsunZZKRsjK+8ZR9igab30aE9Da2kp9LQ9mqBi+k=;
 b=UmKaTXgexGgrabJFVWN5QO7bQefJTFxZBvmcY+bc37mV8noC6bykjKayHKqW9skV5856J9fmE
 Qlt0hPtWEd/ADv3OMlHvzOFHcMb3ql98hAuQHQo/1iCkjN8ytKlU7xS
X-Developer-Key: i=rodrigo.alencar@analog.com; a=ed25519;
 pk=ULeHbgU/OYh/PG/4anHDfLgldFItQHAhOktYRVLMFRo=
X-Endpoint-Received: by B4 Relay for rodrigo.alencar@analog.com/default
 with auth_id=561
X-Original-From: Rodrigo Alencar <rodrigo.alencar@analog.com>
Reply-To: rodrigo.alencar@analog.com

This patch series updates the AD8366 amplifier/attenuator driver with
modern device resource management, including support for additional
device variants.

Adds support for multiple digital step attenuators:
- ADRF5720: 0.5 dB LSB, 6-Bit, Digital Attenuator, 9 kHz to 40 GHz
- ADRF5730: 0.5 dB LSB, 6-Bit, Digital Attenuator, 100 MHz to 40 GHz
- ADRF5731: 2 dB LSB, 4-Bit, Digital Attenuator, 100 MHz to 40 GHz
- HMC271A: 1 dB LSB, 5-bit, Digital Attenuator, 0.7 - 3.7 GHz
- HMC1018A: 1.0 dB LSB GaAs MMIC 5-BIT DIGITAL ATTENUATOR, 0.1 - 30 GHz
- HMC1019A: 0.5 dB LSB GaAs MMIC 5-BIT DIGITAL ATTENUATOR, 0.1 - 30 GHz

Device Tree Support:
- Adds device tree binding documentation
- Adds device tree compatible strings for all supported devices
- Favor chip info tables over device type.

Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
---
Changes in v3:
- Add compatible checks for dt-binding gpio properties.
- Remove reset and enable gpio from device state struct.
- Split refactoring commits.
- Drop part of the refactoring in favor of a cleaner diff.
- Get included header files sorted.
- Link to v2: https://lore.kernel.org/r/20260126-iio-ad8366-update-v2-0-c9a4d31aeb01@analog.com

Changes in v2:
- Reorganize commits with cleanups before features.
- Link to v1: https://lore.kernel.org/r/20260119-iio-ad8366-update-v1-0-8044e23e964a@analog.com

---
Rodrigo Alencar (9):
      MAINTAINERS: Add missing maintainer entry for AD8366 driver
      dt-bindings: iio: amplifiers: Add AD8366 support
      iio: amplifiers: ad8366: use devm_mutex_init() and drop mutex_init()
      iio: amplifiers: ad8366: drop reset_gpio from private struct
      iio: amplifiers: ad8366: refactor device resource management
      iio: amplifiers: ad8366: sort header includes
      iio: amplifiers: ad8366: add device tree support
      iio: amplifiers: ad8366: consume enable gpio
      iio: amplifiers: ad8366: Update device support

 .../bindings/iio/amplifiers/adi,ad8366.yaml        |  97 ++++++
 MAINTAINERS                                        |   9 +
 drivers/iio/amplifiers/Kconfig                     |   6 +
 drivers/iio/amplifiers/ad8366.c                    | 362 +++++++++++----------
 4 files changed, 297 insertions(+), 177 deletions(-)
---
base-commit: 62b44ebc1f2c71db3ca2d4737c52e433f6f03038
change-id: 20251121-iio-ad8366-update-56abac58bbca

Best regards,
-- 
Rodrigo Alencar <rodrigo.alencar@analog.com>


