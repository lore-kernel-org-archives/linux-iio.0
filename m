Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.171.202.116
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794582964;
	b=16hj0vue3nHWhg+AdzfJhqJN1vwxzmVgt9X/PjZqkYy/XVkMnrm1/31r0jHGbB5YrwTL
	 8AubwjE/HHfE5DgtWOavZKgVOQLgUyljTw6SbFaqOzZvG4O0xfUA/bxnQQi+AuamDG1jS
	 F2xn+YBMbJWuzZxhgM9Im0cjNUG+jVIkTOPAxNC4fL6BLtw3IlJW/SF6vYJ2zOuCyTLVC
	 pJ0DZqPbMNN4Q9CCM7/eNuLC+bnIOpiT2F02Xbpmqx22lJk/l0OC21eVyXMwzHWBYxVkK
	 EcejNoNSd/N9QSuyVFh+JMnB1MQIzum9QA8jEi5vSYlZrS2vBFtYj4ydOKSh4msPKRw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794582964;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
	bh=lEK8nUBi0jVe9yX+WITeGcdHbn0xNGCiuHof4jLotTQ=;
	b=WYQKdAtMZU2sX5zsjJ2xxaoDll86m3kvWiKD8g3bHrHJf6H8dIVEY674CC2OL7O6OkAg
	 GcR5IVqfM2NIBXuPmeaaf+ZvuAr86PztTjWofjs0oOoriUvw4neCAFl6y8+6fYW/4tW4q
	 dNISHyDKjkHrKNABuHGZywREq/mV9FR6BM6+o+UsFrpchjEm64BxfqunGvZdnaKPxGPUL
	 7hlVV2cw42HMp5OZEutSqbpwVMcJcV17Hc8oRk4e9Phgfj7RemMAVNyATsi4T6Dr7zWZQ
	 RsgOuyqOOnQkGcTqc66RO2f1WEbkCeCHn18F4v2GaEcZVCwNCKkrTL82GI91VbaGjAw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=wBcQKjQh;
	arc=none smtp.remote-ip=185.171.202.116
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FA2360A261E;
	Fri, 13 Nov 2026 15:16:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4FA2360A261E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=wBcQKjQh
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 69DE4C4F755;
	Fri, 13 Nov 2026 15:15:59 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 6A50E60015;
	Fri, 13 Nov 2026 15:15:56 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A94E611BC16F7;
	Fri, 13 Nov 2026 16:15:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1794582954; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=lEK8nUBi0jVe9yX+WITeGcdHbn0xNGCiuHof4jLotTQ=;
	b=wBcQKjQha5kRC2ZJsMhTWDfUu2moG31bAk+T/0Ckg2P/WmUsk7GbmC8AzhDVmJSejs6VJr
	AwVUTSC2mt0tRT18jis20nSjXVMpqQcYd2mN6b3TnUwZwUAq0fRnqr55HJTZT7jsHWOhDu
	Z+Ffh8OH/k/C0J0kGV+JhEO9kkHVkuPdnd7DHZXll8WzbmgZEP9etIuQwm69T4OWjz6L3P
	E5AYKDAod3BGCbCNa1POjznGimiOvyO3nj6qX+MLbyT+QEqxMIM7oKSV3VSW5v4fTxvl3g
	mATGi6gZQ7ON33+qdSyUFaUGjvEpDJTE73yfDbc6Rj+rwjkwsEP9sAaLeasUhw==
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Rodolfo Giometti <giometti@enneenne.com>,
	Marcelo Schmitt <marcelo.schmitt@analog.com>,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Angelo Dureghello <adureghello@baylibre.com>,
	Tobias Sperling <tobias.sperling@softing.com>,
	Eason Yang <j2anfernee@gmail.com>,
	Marilene Andrade Garcia <marilene.agarcia@gmail.com>,
	Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>,
	duje@dujemihanovic.xyz,
	Joshua Crofts <crofts@kernel.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Victor Chernyakin <chernyakin.victor.j@outlook.com>,
	herve.codina@bootlin.com,
	thomas.petazzoni@bootlin.com,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/2] iio: adc: add driver for Texas Instruments TLA2528 adc
Date: Fri, 13 Nov 2026 16:15:40 +0100
Message-ID: <20261113151543.2241604-1-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Hi everyone,

This is V4 for the TI TLA2528 driver, for the ADC part. This new
revision contains a small amount of changes, after the reviews from
Joshua, Andy, Jonathan, and sashiko.

Thanks everyone for the quick feedback,

Maxime

V4:
  - Return -EIO on a short read in tla2528_read(), from Joshua
  - Drop mod_devicetable.h, include asm/byteorder.h
  - Rename vref_mv to vref_mV
  - Drop the L: entry in MAINTAINERS

V3: https://lore.kernel.org/r/20261104125726.1754980-1-maxime.chevallier@bootlin.com
  - Require channels to be described
  - Use guard()
  - Add Datasheet link
  - Drop the unused registers
  - Use named initializers in the id table
  - Collect Conor's Ack

V2: https://lore.kernel.org/r/20261030164705.297354-1-maxime.chevallier@bootlin.com
  - Describe AVDD and DVDD in the bindings instead of vref.
  - Add gpio-controller
  - Allow describing individual ADC channels
  - Switch to regmap with caching
  - Reset the chip at probe time
  - Small cleanups following all the reviews
  - Moved MAINTAINERS to patch 1

V1: https://lore.kernel.org/linux-iio/20251223155534.220504-1-maxime.chevallier@bootlin.com/

Maxime Chevallier (2):
  dt-bindings: iio: adc: add Texas Instruments TLA2528
  iio: adc: add driver for Texas Instruments TLA2528 adc

 .../bindings/iio/adc/ti,tla2528.yaml          |  91 ++++++++
 MAINTAINERS                                   |   6 +
 drivers/iio/adc/Kconfig                       |  12 +
 drivers/iio/adc/Makefile                      |   1 +
 drivers/iio/adc/ti-tla2528.c                  | 218 ++++++++++++++++++
 5 files changed, 328 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/ti,tla2528.yaml
 create mode 100644 drivers/iio/adc/ti-tla2528.c

-- 
2.56.0

