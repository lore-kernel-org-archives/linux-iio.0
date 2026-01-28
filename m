Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 525052E0405
	for <linux-iio@vger.kernel.org>; Wed, 28 Jan 2026 15:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769614713; cv=none; b=JdOJG+BmdDAvlTKcC5UE0QA2+UiqLnuMfgPkEfGfwNNtXUpZ3K8KApyrVimLmPyMxhDUrQ9WQvuPUttY3k0GkRaMT01rAo2mircS7OQQ7yyXYRm1cI0GoXsu/7I2+S7SoKAXyO7eTivE3wgX36aIyUN3nWmLcr0RQoLADPkGIWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769614713; c=relaxed/simple;
	bh=zCr6LEZ8hqiYApECOvFthtaaWbs/9iyDcYHceOPIlO8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RjcMa8BVVw5iZCbPF/jBx+dVwm6XAhDxRsLpZ+o8MicBHPeAA6TI/DPsFrcwS3awesVWQ5MacR+IfJ9sP25sZ/yzNQVaxmNZNDHwszBpEgaQ2im/kJ2cfILF04SyUYznEm/S+iIP55b8GRQdP9vPqDzN8enOXjXym+lCN88GBYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1vl7cg-0003oo-Nh; Wed, 28 Jan 2026 16:38:26 +0100
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac] helo=dude04)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1vl7cg-002wSJ-2K;
	Wed, 28 Jan 2026 16:38:26 +0100
Received: from ore by dude04 with local (Exim 4.98.2)
	(envelope-from <ore@pengutronix.de>)
	id 1vl7cf-0000000FR9Z-43mZ;
	Wed, 28 Jan 2026 16:38:25 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Jonathan Cameron <jic23@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	David Jander <david@protonic.nl>
Subject: [PATCH v3 0/8] iio: dac: ds4424: add DS4402/DS4404 support and scale
Date: Wed, 28 Jan 2026 16:38:16 +0100
Message-ID: <20260128153824.3679187-1-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-iio@vger.kernel.org

This series extends the ds4424 IIO DAC driver and its devicetree binding
to support the DS4402 and DS4404 current DAC variants.

DS440x devices share the same register map as DS442x but use a different
resolution (5-bit vs 7-bit) and a different full-scale current formula.
The full-scale current depends on external Rfs resistors connected to
the FS pins, so a new optional DT property is added to provide the
per-channel Rfs values and allow the driver to report a correct IIO
SCALE (mA/step).

While adding DS440x support, a few related issues were addressed:
- Port to regmap
- Reject -128 in RAW writes on DS442x, which cannot be represented with
  sign-magnitude encoding and could silently program an unintended
  output.
- Preserve preconfigured values on probe.
- Ratelimit read error logging and use device context.

David Jander (1):
  iio: dac: ds4424: add DS4402/DS4404 device IDs

Oleksij Rempel (7):
  iio: dac: ds4424: fix -128 rejection and refactor raw access
  iio: dac: ds4424: ratelimit read errors and use device context
  iio: dac: ds4424: sort headers alphabetically
  dt-bindings: iio: dac: maxim,ds4424: add ds4402/ds4404
  dt-bindings: iio: dac: maxim,ds4424: add maxim,rfs-ohms property
  iio: dac: ds4424: convert to regmap
  iio: dac: ds4424: add Rfs-based scale and per-variant limits

 .../bindings/iio/dac/maxim,ds4424.yaml        |  42 ++-
 drivers/iio/dac/Kconfig                       |   1 +
 drivers/iio/dac/ds4424.c                      | 351 ++++++++++++------
 3 files changed, 283 insertions(+), 111 deletions(-)

--
2.47.3

