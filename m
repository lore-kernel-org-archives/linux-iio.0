Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.84.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793378840;
	b=I1I9fA2wp/Cr4k8MHD+CEw81jrTqH+SpdM0dDYtoA/InKxbFaPQsetlyCBe56JGbWffG
	 +zv2ruYfahxxTSKA1i/MjP+hQPMxCDZgDp7uJxPMv0NB5a7EjWGYKfKtxOSo+zi1amwx6
	 s9cVVqncNpTHuMIkCVzzevXmGzlVSXsNZv9xedFQeceJX3sF8KWl9Kuya81PPCleb9cJ1
	 WsqOAcd9Q3fjJAJZ/7K/eQhhxnYbRVY9Hsxfk8gjSjrcVja954uEc+Mk4MWSqRp33S8Ng
	 ciMwUM7qs+R23M/LWzlwwbhJRDFm4dBlm3qUyJ2eYiDCGKSgFM93vHUe9BiNXtFM2Pw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793378840;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
	bh=1JNCQP+uPHSWlFQ9/h+R6elRqx5vlsNj2kueH8DsSN4=;
	b=XCBalr33hNR+QATLkYUOglGyu/k/dq4Emn9yP9RjUxYdqMKFqIvAkm8t0MV54UTd9jjR
	 ueBMwuvdJIMNobqYJohaXaN7XYQOIlokclaelEefwC9XOXo8TIrwzUjwV9h2Yjq4Z+XMs
	 l//r6U5F8ZBUll1KnroCXnDdRhHH11WuKChyRpA+BneqICRGZnLcoyxY+PWHkjQ5/M+vD
	 KqExf1MoN1HF4/3JEjUXM3SqZ3BfQhk5T6C3ESh351zzh8688+jckWrueViliLtplhc4I
	 5ohmMVysXqQXVwS/nKqdH3kk3m8D1V8Rz9NKBBCDlX6sbEpRLhzODlIdxbhcBIrMPKQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=EKDUZOLb;
	arc=none smtp.remote-ip=185.246.84.56
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66719606A31A;
	Fri, 30 Oct 2026 16:47:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 66719606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=EKDUZOLb
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id AEE281A13CC;
	Fri, 30 Oct 2026 16:47:15 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 80907603C2;
	Fri, 30 Oct 2026 16:47:15 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 69A7E103290EE;
	Fri, 30 Oct 2026 17:47:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1793378833; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=1JNCQP+uPHSWlFQ9/h+R6elRqx5vlsNj2kueH8DsSN4=;
	b=EKDUZOLbUJClzt52D4WlwvQnQ2r+Exo4KVJO5/fzACzfQCNKZQMfowQ8jdFA5EwEwNCxv8
	W9r2D6Zx4fl1N1KrJMdVoqb1zZwEZyX88qY9BjuCZeq+etsIVFUAJTmACvctuDWWU5j62r
	ncsnVb51UTUv+aRGAuT7kPhgyU2bMfRyuwPOXmh9+7JhSDW3shUoI7mlVAM7y0M5duh5nm
	aiWPmZwgjYoZ7T2MJMh5S7rAdCpbf3j5OK4UdlrszYVPkDktify4HV2C9UCeJpzaoT7VCL
	+JvXtwvQSJaEhLMBYwEQ4v6motTUEz9nYG+KulU1wzTKsrcGsJLrbFRIfbI0YA==
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
	herve.codina@bootlin.com,
	thomas.petazzoni@bootlin.com,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] Add driver for the TI TLA2528 i2c ADC
Date: Fri, 30 Oct 2026 17:47:02 +0100
Message-ID: <20261030164705.297354-1-maxime.chevallier@bootlin.com>
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

This is V2 for the TLA2528 ADC support, V1 was sent almost a year ago
and was already resurecting yet another older series from Rodolfo
Giometti [1]. Sorry for the slow iteration.

This V2 addresses the various comments that were made on V1, thanks
again to everyone involved in the first review round (Jonathan, Andy,
Matti and David)

This was tested on a custom board based on imx93, with a 3v3 ref supply.

Maxime  

[1] : https://lore.kernel.org/linux-iio/20210802130441.972978-1-giometti@enneenne.com/

V2:
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

 .../bindings/iio/adc/ti,tla2528.yaml          |  91 +++++++
 MAINTAINERS                                   |   7 +
 drivers/iio/adc/Kconfig                       |  12 +
 drivers/iio/adc/Makefile                      |   1 +
 drivers/iio/adc/ti-tla2528.c                  | 245 ++++++++++++++++++
 5 files changed, 356 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/ti,tla2528.yaml
 create mode 100644 drivers/iio/adc/ti-tla2528.c

-- 
2.56.0

