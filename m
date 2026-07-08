Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF1993438B7;
	Wed,  8 Jul 2026 09:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783504393; cv=none; b=Jt7C2wSS0WjFsj7WRn8dDjR6Whd4C17QwAfDIsQjFMaMDA+MYaWH8IutsgyHkpjfH9D9VjXm7TJqDpZ6QEgygo7RRcrxspRKDUuBuRCdBpvO9DwbGp/uAmIzCeyXw0jmRQPnx7IT5FDq/it3JpA7BDPWo9HPPYHskzJkr+mNi/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783504393; c=relaxed/simple;
	bh=on2lcVlpE6P+0LOFKNgEdykwJLshdckEPnrvLOgvfrE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=F3OIicEbR8jyvmUTg1KQenOWLPl1AB+eELOeEl8Gr9AdGSbLv1ExUOGXwiIFlDFBE+Z4sIZcl0gyDsafu+xVDFsyhlA23IajC9B5k43lGgh6gj67ZVDT1MBWLy1ieQnYo6/Eq8jmzfA4Qp4x53yHJlpnUsG3hmEFLPNaM05owRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=lukas.metz@gmx.net header.b=fHhKj1Lj; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=lukas.metz@gmx.net header.b="fHhKj1Lj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1783504387; x=1784109187; i=lukas.metz@gmx.net;
	bh=Lge+6YopaIY4N+z10CVSwBUFvLb5GJVm4hJbAPY/Z0g=;
	h=X-UI-Sender-Class:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:To:Cc:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=fHhKj1Lj6dfZ8YQ0zJUga0J2arg15XWur6OZtZkdhHyo/tneBAMciaygM8IYy2bh
	 P/0QL3vwooSJOLrp251g+vnpFdBL1XKEeZSu5evDl5ZHzjpAdHyieiYH4631Mq87R
	 9AHe5H8BDixwXRZpoRdVPReH6W8uq40lZsGHv327V4YV3YuTRq577vnhhKEyxzWUi
	 0gz4t/ldgVclC/hK3Xo/1AdaThTIEBkdmdMdEmxFPagP7WgiTfImXA92tKvqg6rR8
	 5EjN19D19k/5Odregl+7x1/2mZIQhuPZg9z/3JuwL4rVgWAglSGUP/lO5gXAwSB7B
	 NcyFmlThvNpNyA1kkw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mz9Yv-1x3JXF42j5-0132R4; Wed, 08
 Jul 2026 11:53:07 +0200
From: Lukas Metz <lukas.metz@gmx.net>
Subject: [PATCH v2 0/2] Add driver for DAC8163:
Date: Wed, 08 Jul 2026 11:52:42 +0200
Message-Id: <20260708-dac8163-work-v2-0-3acd1bf20182@gmx.net>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-B4-Tracking: v=1; b=H4sIAOodTmoC/13MQQ7CIBCF4as0sxbDgFDiynuYLrCl7cQIBhqsa
 bi7WHcu/5e8b4PkIrkE52aD6DIlCr6GODTQz9ZPjtFQGwQXmp9QssH2BrVkrxDvTKA0tm3VTaG
 CenlGN9K6c9eu9kxpCfG96xm/6w/S4g/KyDirDDeozGgtv0yP9ejdAl0p5QMEf/I3pgAAAA==
X-Change-ID: 20260413-dac8163-work-2138a775b515
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, Lukas Metz <lukas.metz@gmx.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783504386; l=3766;
 i=lukas.metz@gmx.net; s=20260616; h=from:subject:message-id;
 bh=JVmgTGNGFylMd63WOYrYIYPTM+eSDJTXZtD41iRXrKc=;
 b=U6OtJYok1cG2FpMLmpJkC0ptUWH2lwkDPGwlmZW8885B3xomcWuPS1iu0afBBTqdSqAKB8Hzo
 o1j529j3SukC8OkhM+Z6XVoKl+qcmRAFimn6UWa4vcF5BOtaacc4Wph
X-Developer-Key: i=lukas.metz@gmx.net; a=ed25519;
 pk=ljkIqYPVyHd9CYN4/koqGKt7Mym5FTTB+ZzvvlfD4yM=
X-Provags-ID: V03:K1:wND2e+fbTxGb5Gk8UnhR4NGhkjUo8qxOUtlG8gZFSrQoT3PDjG7
 TvU1XyBXS/DyT0Ifyet3NCnf99jyGNS/B6B2NOrFxx2oQZeWch3berUPkfAR0I8XRPmkClx
 zclsAqJnV0r3d0NrYeLKL9c5CxTu88wCiNS6fc6QvSRQWFvH+tITF7vQv1zQmbe5vc1L2jx
 bROahK4E0RQQa3YQdmVeQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:xbO3qGGHgAM=;HL5ijB+z5VDRfS/CtJahngJQMAt
 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
 G0Apf+Kl31nlZHDG+raMoqB9b7U=

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

 .../devicetree/bindings/iio/dac/ti,dac8163.yaml    |  85 +++++
 MAINTAINERS                                        |   7 +
 drivers/iio/dac/Kconfig                            |  15 +
 drivers/iio/dac/Makefile                           |   1 +
 drivers/iio/dac/ti-dac8163.c                       | 373 ++++++++++++++++=
+++++
 5 files changed, 481 insertions(+)
=2D--
base-commit: 76b6720279964612111352ca5d09f5bd61e41ce4
change-id: 20260413-dac8163-work-2138a775b515

Best regards,
=2D- =20
Lukas <lukas.metz@gmx.net>

