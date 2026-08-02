Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 332F2399003;
	Sun,  2 Aug 2026 16:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785686911; cv=none; b=bc7fngYSPpxJgWyVEDQ9sf/6cHiFPPZFOlV0FtyJwgnkCgrqPM2ma6ysBHQZ6DOwRYPxHBaccp0hlfXKZ02B+oVG3sS4OsqUibm8co2H8m5q1Cnf03rn8M/QnR5Njf7Neg/yts6fwS8C5xr5TBR5qNe8IMBBl986Bs+3J2chMBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785686911; c=relaxed/simple;
	bh=bDOT6jicvB0WuMOyTcHgIMjdJWjg8DtZS+J/UJq7SpA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Zf485shx3hXTM/7vS7awEFuu2my4b7sOOULej2D1vZrhFDsoN57RKAmoq42qZZoE5UuWbIf7QejHCeBUHWMnUPmhV9i3N6kRfvLI5UrpS4bPDstQBlbI6gEoaeVC/sYzDifUFNchoX73n4vAnGFhhPUA1ZV3dmcTOnAF7YlmD5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=lukas.metz@gmx.net header.b=bWgEqb30; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=lukas.metz@gmx.net header.b="bWgEqb30"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1785686906; x=1786291706; i=lukas.metz@gmx.net;
	bh=PpeF2qdUO+KSgCVBrVNXl1/ADN0sWZby+ebOZF7Cw3Q=;
	h=X-UI-Sender-Class:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:To:Cc:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=bWgEqb30TJlgU3FdIptqj0pmR5gri7qWfc4P+JffwBXBMyoqOQj4R0FIfvdAfHlZ
	 W42IGhUkwxb2iqBU0ECljFZR+CVf28rsJ4480+wqi2Cp/tgyhAokcU1ttvKz4zDTt
	 gjA85m6rUoC6NTTz3g52jQfiK5zphoRhUfhPng/nXB9JI4OE+Z8wNLBvM808llUjE
	 M/iJ8QwDcTlTQCbvI3C6H+KmgiDF/jzSWNcMf/kiM7O3Ga4LQBGdl96sjJ3TRZsxH
	 Qfal7IdMJAskyMTHP9C8fuSmnO7UJ/iv5cmx1vprC80jDfhPnTw8aOkGFprYLCBST
	 TcdvszmSmmmYEpNrAw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MacSY-1xN8Oe1uuY-00ZP2n; Sun, 02
 Aug 2026 18:08:26 +0200
From: Lukas Metz <lukas.metz@gmx.net>
Subject: [PATCH v3 0/2] Add driver for DAC8163:
Date: Sun, 02 Aug 2026 18:07:21 +0200
Message-Id: <20260802-dac8163-work-v3-0-3ecc7bc66d0d@gmx.net>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-B4-Tracking: v=1; b=H4sIADlrb2oC/13MQQ6CMBCF4auQWVszM7XQuPIexkWBAo0RTEsqh
 nB3Cy5IWL6X/N8MwXpnA1yzGbyNLrihT0OeMqg607dWuDptYOQcLyRFbSpNuRSfwT8Fk9SmKFS
 pSEFK3t42btq4+yPtzoVx8N9Nj7S+fyjnAxRJoEgMalK6MQZv7Ws693aElYm8pwXqQ8oplaaqq
 WwYSfOeLsvyAyjIH4LhAAAA
X-Change-ID: 20260413-dac8163-work-2138a775b515
To: Jonathan Cameron <jic23@kernel.org>, 
 Siratul Islam <siratul.islam@linux.dev>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, Lukas Metz <lukas.metz@gmx.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785686905; l=5117;
 i=lukas.metz@gmx.net; s=20260616; h=from:subject:message-id;
 bh=YtTmdMORrY8XUW+RznEsydiPjYj5Y1SkiL5X0qN16/E=;
 b=NNkDoEEmtqZR/BHQrckxyhVj+nN3NoV619ClGEfhvI6DF5WvWl9NTLjtVJggf1hDyS4eLUg/7
 p7Y+0c7MMnzCqYPjJMDmct2rO3dQfjhaPCKEjPndGN5/dqNqvBLh2n4
X-Developer-Key: i=lukas.metz@gmx.net; a=ed25519;
 pk=ljkIqYPVyHd9CYN4/koqGKt7Mym5FTTB+ZzvvlfD4yM=
X-Provags-ID: V03:K1:pQNJcxiA4vZzlkJGubOhHgc/J9dBUNE3QeAsJQRFJHnuvHxxp1p
 s8mPp+HNYNVaY8BJ0IUnwQEO7UemJhgvIRd9V/+9xoOBehYntZd74qGuKvs4c6UsigFUrnP
 oUQjPSX0452Ebyh1IAuebjOltkleefH1HAv7BaGlt3NQeluK+peOEroQ/Ri5eNaZtMXyZg5
 Jr78C+Nvn8F/wyveTxIlw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:un5soiYbmno=;MYPw7Jwe2sE1HbIuOVK6SHnW7V/
 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
 2Mm

This series adds an IIO driver for the Texas Instruments DAC7562, DAC7563,
DAC8162, DAC8163, DAC8562, and DAC8563 dual-channel voltage-output DACs.

These devices are pin-compatible 12-, 14-, and 16-bit variants sharing the
same 24-bit SPI command interface. Each device provides two independently
addressable output channels and includes a 2.5 V, 4 ppm/=C2=B0C internal
reference that can be enabled via device tree, or an external reference
supplied through a regulator. The register and command structure differs
from already existing drivers which makes adding a new driver a
reasonable choice in my opinion.

The driver supports:
 - All six device variants via a shared chip info table
 - DAC updates in synchronous mode
 - Configurable internal or external voltage reference
 - Optional LDAC GPIO which has to be asserted permanently when using
   synchronous updates.
 - IIO_CHAN_INFO_RAW and IIO_CHAN_INFO_SCALE attributes per channel

Datasheet (DAC8163):
  https://www.ti.com/lit/gpn/dac8163

The driver was tested with a DAC8163 on a custom STM32MP157F board with
external reference enabled.

Signed-off-by: Lukas Metz <lukas.metz@gmx.net>
=2D--
Changes in v3:
- add trailing comma to non-terminator entries as pointed out by Andy
  Shevchenko
- add select REGMAP_SPI to Kconfig entry as per Siratul Islam
- rename clr-gpios to clear-gpios and correct description as per Conor
  Dooley and David Lechner
- align mask macros as per Siratul Islam
- add macros for dac resolution as per Siratul Islam
- remove errno.h include as per Andy Shevchenko
- extend top level bindings description to explain why none of the devices
  are fallback compatible as suggested by Conor Dooley and David Lechner
- split function parameters logically when adding linebreaks as per Andy
  Shevchenko
- make use of dev_err_probe as suggested by Siratul Islam
- enable avdd regulator before the vrefin regulator to ensure a save
  powerup as suggested by sashiko
- enclose case statements in brackets as per Siratul Islam
- add select REGMAP_SPI to Kconfig entry as per Siratul Islam
- remove CMD_SET macro to avoid putting FIELD_PREP in a macro as per
  David Lechner
- remove mod_devicetable include as per Uwe Klein-Koenig
- define separate reg_default and regmap_config structures for each
  compatible and add regmap_config to the device info, see discussion
  with Siratul Islam and Jonathan Cameron
- Link to v2: https://patch.msgid.link/20260708-dac8163-work-v2-0-3acd1bf2=
0182@gmx.net

Changes in v2:
- add reg_defaults to initialize the output registers based on
  the device (dacxxx2 resets to 0, dacxxx3 resets to mid-scale)
- add variable gain to dac8163_state struct to report correct scale when
  internal reference is used (the device sets the gain register to 2
  when the internal reference is selected)
- do a full reset of the device when probing to ensure we have a known
  device state as pointed out by Jonathan Cameron
- use devm* calls where possible and omit remove callback
- make use of regmap and remove now unneeded things like manual locking
  and caching of output register values (thanks to Andy Shevchenko,
  David Lechner and others for the hint)
- remove internal_reference property
- add missing headers as suggested by Siratul Islam
- remove debug print from dac8163_write_raw (per Andy Shevchenko and
  David Lechner)
- switch ldac-gpio polarity for consistency with datasheet (as per David
  Lechner)
- rename dt properties ti,loaddacs-gpios to ldac-gpios and vref-supply to
  vrefin-supply
- add required spi property spi-cpha to binding (the device only works
  in spi mode 1 and 3)
- add missing spi properties spi-max-frequency and spi-rx-bus-width to
  binding
- add avdd-supply to binding and enable it in the driver (thanks to
  David Lechner)
- add clr-gpios to binding although not yet supported by the driver
- add nullptr check after calling spi_get_device_match_data (thanks to
  Andy Shevchenko for pointing this out)
- add comment for permanent ldac assertion
- switch to GPL-2.0-or-later
- return -ERANGE when raw write is out of range
- use named structures instead of chip_info array
- rename driver identifiers from dacxx6x to dac8163 and partly remove
  vendor prefix as suggested by David Lechner and Siratul Islam
- remove redundant call to gpiod_set_value
- Link to v1: https://patch.msgid.link/20260623-dac8163-work-v1-0-5b508158=
faa0@gmx.net

=2D--
Lukas Metz (2):
      dt-bindings: iio: dac: Add DAC8163
      iio: dac: dac8163: Add driver for DAC8163

 .../devicetree/bindings/iio/dac/ti,dac8163.yaml    |  87 ++++
 MAINTAINERS                                        |   7 +
 drivers/iio/dac/Kconfig                            |  16 +
 drivers/iio/dac/Makefile                           |   1 +
 drivers/iio/dac/ti-dac8163.c                       | 449 ++++++++++++++++=
+++++
 5 files changed, 560 insertions(+)
=2D--
base-commit: 76b6720279964612111352ca5d09f5bd61e41ce4
change-id: 20260413-dac8163-work-2138a775b515

Best regards,
=2D- =20
Lukas <lukas.metz@gmx.net>

