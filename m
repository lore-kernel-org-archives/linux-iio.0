Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88565340DB9
	for <linux-iio@vger.kernel.org>; Tue, 10 Feb 2026 13:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770731480; cv=none; b=FHM54PvEUn8NPiTSL0VbwrspBLCw3NRuZuuHLgkbuJk18AGOPbK4+UyWUnmXR7reyB6jhxKVwViYkDxwQJJcwp+avgAXjWBlNpekkKfRqeT7QJHoItPsOlmLQ/BEn+nrghWugoYOPXIpj9ZiHgKoziHpp/OZYzXBOpYroM1tzNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770731480; c=relaxed/simple;
	bh=d3XTjJj/yPkqHIsG+VCWmRMELS7yty9PSgNqiwQiRow=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Uuo8VgROY7Uuojty2LpLGrdFdM2qEX156JbkQJhLoqX5mtKQaDHlYXMdy28AydlitCpKAINYTesMn58BUHHCyQFY7c6WhlwrZEjMNlY2B/8AaiglZFLmE0iSdnlDWpIlKNZFctdupGmx3j7iWAEuNr4DE860H0N4pOgui9ZXn50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1vpo93-0005dD-HX; Tue, 10 Feb 2026 14:51:13 +0100
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac] helo=dude04)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1vpo91-0005cw-35;
	Tue, 10 Feb 2026 14:51:11 +0100
Received: from ore by dude04 with local (Exim 4.98.2)
	(envelope-from <ore@pengutronix.de>)
	id 1vpo92-00000008VN1-2hom;
	Tue, 10 Feb 2026 14:51:12 +0100
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
Subject: [PATCH v6 00/12] iio: dac: ds4424: add DS4402/DS4404 support and scale
Date: Tue, 10 Feb 2026 14:50:58 +0100
Message-ID: <20260210135110.2027073-1-o.rempel@pengutronix.de>
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

changes v6:
- rebase on top of iio/fixes-togreg
- drop "iio: dac: ds4424: reject -128 RAW value", already included

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

Oleksij Rempel (11):
  iio: dac: ds4424: refactor raw access to use bitwise operations
  iio: dac: ds4424: ratelimit read errors and use device context
  iio: dac: ds4424: sort headers alphabetically
  iio: dac: ds4424: rename iio_info struct to avoid ambiguity
  iio: dac: ds4424: use device match data for chip info
  iio: dac: ds4424: use fsleep() instead of usleep_range()
  dt-bindings: iio: dac: maxim,ds4424: add ds4402/ds4404
  iio: dac: ds4424: support per-variant output range limits
  iio: dac: ds4424: convert to regmap
  dt-bindings: iio: dac: maxim,ds4424: add maxim,rfs-ohms property
  iio: dac: ds4424: add Rfs-based scale and per-variant limits

 .../bindings/iio/dac/maxim,ds4424.yaml        |  42 +-
 drivers/iio/dac/Kconfig                       |   1 +
 drivers/iio/dac/ds4424.c                      | 375 ++++++++++++------
 3 files changed, 287 insertions(+), 131 deletions(-)

--
2.47.3

