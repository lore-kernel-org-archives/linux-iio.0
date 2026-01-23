Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 933DD279329;
	Fri, 23 Jan 2026 15:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769183638; cv=none; b=qGkUmpwu2TaStn7df0haGY+Xy+he5ILcfiV7Mupox3n52hiBoRLsYdYwfZgP3gxnC10EP3zCsS/LqqLmoHFtzfnWbYcheyBwXC2fXexYrpMKdcmAhIwVD8UbO4EjQjJSxSZByvxQhceRmm8Ty2PXCzsgZh/WxXXH/0t95NmRbiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769183638; c=relaxed/simple;
	bh=UHlRZ5DldTHyADoNZZ73Un9907UYWbQli9Ti3A0SiBs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ZEQTe/SLzJd7fmiMT4bDrlWOxeO1u8to2fjcT7DKsR8QUcSZPDEcunjAQGpwuLJtBVCFajIypxQvJC20D4d9cRtaqrW6R7N7rXb+2g/UvkRudAtSDvMC1sIf8BjsaIuA5sKZyEkcOMuR9EpKq89rQ5MH6s7NJZd+xgwJRXe1Xzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nJ25TAp0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nJ25TAp0"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2D446C4CEF1;
	Fri, 23 Jan 2026 15:53:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769183638;
	bh=UHlRZ5DldTHyADoNZZ73Un9907UYWbQli9Ti3A0SiBs=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=nJ25TAp0fp0G7GmgindKnPpC1pMUQYY7uhYqFgkwCWUconacyiZuj7gEaiNVD+Vnw
	 O3hpoDV/gL/Wj8Cw3UicLB1ZAsK2P798B2qNlUhpfBr3R5utgBisOJdsOAA5yJSLea
	 ITcbF6Otn4QQEeijp8eBYw+nhQeSrRmtxoXjtFyO/yynS0cPbHWKbd0QbUMOhchuh4
	 hPZOPsDTKxMvuFK6OgsxIO9Dzj+OBMikUD3gokPACQLBSfMOrOyZp86tFp2IsF4sD2
	 BOdYAbAk6nxQpmAG1e/e45pwDS5tVfuuSwSOElQhgSm3pGLfqKP3JeJu3oxvl30yC4
	 7LAFYOPQ3NQBA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27478D74EC7;
	Fri, 23 Jan 2026 15:53:58 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Subject: [PATCH v5 0/8] ADF41513/ADF41510 PLL frequency synthesizers
Date: Fri, 23 Jan 2026 15:53:05 +0000
Message-Id: <20260123-adf41513-iio-driver-v5-0-2dce812a2dda@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGKZc2kC/33OwWrDMAyA4VcpPs/DkpPY2anvUXZQYrkVbPFwi
 ukoefc5hbGWhh1/gT7pqmbOwrN6211V5iKzpKlG+7JT44mmI2sJtRUabAHAaAqxgRasFkk6ZCm
 cNdFInlz0xrOqm1+Zo1xu6uG99knmc8rftyMF1un/XgFtNIboBzYxjB3vaaKPdHwd06dawYJ/C
 EK/jWBFBsaevA2t6+0TYn+RzoDx24hdP7EBrAPi2PgnpLlDoNtGmoqEYXChcx4R3AOyLMsPOh5
 c0oYBAAA=
X-Change-ID: 20251110-adf41513-iio-driver-aaca8a7f808e
To: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-doc@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Rodrigo Alencar <rodrigo.alencar@analog.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1769183636; l=3878;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=UHlRZ5DldTHyADoNZZ73Un9907UYWbQli9Ti3A0SiBs=;
 b=4MBhws7Y5/hMcdecd0oCGQp6xEEQkxeLLV5cYql/wU0Qs2Ojz2GKEEUEr/MFraQuYGjvG3lzb
 XdzCJlk5qceBY7zEdFtqsxUepC1jUtzUocmfbMXgY+C5nGuipnz3c1V
X-Developer-Key: i=rodrigo.alencar@analog.com; a=ed25519;
 pk=ULeHbgU/OYh/PG/4anHDfLgldFItQHAhOktYRVLMFRo=
X-Endpoint-Received: by B4 Relay for rodrigo.alencar@analog.com/default
 with auth_id=561
X-Original-From: Rodrigo Alencar <rodrigo.alencar@analog.com>
Reply-To: rodrigo.alencar@analog.com

This patch series adds support for the Analog Devices ADF41513 and ADF41510
ultralow noise PLL frequency synthesizers. These devices are designed for
implementing local oscillators (LOs) in high-frequency applications.
The ADF41513 covers frequencies from 1 GHz to 26.5 GHz, while the ADF41510
operates from 1 GHz to 10 GHz.

Key features supported by this driver:
- Integer-N and fractional-N operation modes
- High maximum PFD frequency (250 MHz integer-N, 125 MHz fractional-N)
- 25-bit fixed modulus or 49-bit variable modulus fractional modes
- Digital lock detect functionality
- Phase resync capability for consistent output phase
- Load Enable vs Reference signal syncronization

The series includes:
1. PLL driver implementation
2. Device tree bindings documentation
3. IIO ABI documentation

Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
---
Changes in v5:
- Drop local parsing of 64-bit plus fractional parts
- Add iio_str_to_fixpoint64() to iio core with parsing tests
- Add DT property dependency for adi,charge-pump-resistor-ohms
- Add local definition for ADF41513_HZ_PER_GHZ and drop units.h patch
- Link to v4: https://lore.kernel.org/r/20260116-adf41513-iio-driver-v4-0-dbb7d6782217@analog.com

Changes in v4:
- Proper usage of units.h macros
- Simplifications to DT property parsing
- Adjustments to return value handling
- Drop of simple DT property node example
- Link to v3: https://lore.kernel.org/r/20260108-adf41513-iio-driver-v3-0-23d1371aef48@analog.com

Changes in v3:
- Use FIELD_MODIFY macro in driver implementation
- Drop refin_frequency iio attribute
- Drop muxout-select property from dt-bindings (and rename logic-level property)
- Use -mhz suffix in power-up frequency property
- Address documentation issues
- Link to v2: https://lore.kernel.org/r/20251219-adf41513-iio-driver-v2-0-be29a83d5793@analog.com

Changes in v2:
- separate driver implementation from extra features and improve commit messages
- use macros from units.h
- explanation of custom parse function: adf41513_parse_uhz
- reorganize driver data structures
- drop clock framework support for now
- reorganize documentation
- Link to v1: https://lore.kernel.org/r/20251110-adf41513-iio-driver-v1-0-2df8be0fdc6e@analog.com

---
Rodrigo Alencar (8):
      dt-bindings: iio: frequency: add adf41513
      iio: core: add fixed point parsing with 64-bit parts
      iio: test: add kunit test for fixed-point parsing
      iio: frequency: adf41513: driver implementation
      iio: frequency: adf41513: handle LE synchronization feature
      iio: frequency: adf41513: features on frequency change
      docs: iio: add documentation for adf41513 driver
      Documentation: ABI: testing: add common ABI file for iio/frequency

 Documentation/ABI/testing/sysfs-bus-iio-frequency  |   11 +
 .../bindings/iio/frequency/adi,adf41513.yaml       |  215 ++++
 Documentation/iio/adf41513.rst                     |  199 ++++
 Documentation/iio/index.rst                        |    1 +
 MAINTAINERS                                        |   11 +
 drivers/iio/frequency/Kconfig                      |   10 +
 drivers/iio/frequency/Makefile                     |    1 +
 drivers/iio/frequency/adf41513.c                   | 1244 ++++++++++++++++++++
 drivers/iio/industrialio-core.c                    |  151 ++-
 drivers/iio/test/Kconfig                           |   12 +
 drivers/iio/test/Makefile                          |    1 +
 drivers/iio/test/iio-test-fixpoint-parse.c         |  437 +++++++
 include/linux/iio/iio.h                            |    2 +
 13 files changed, 2245 insertions(+), 50 deletions(-)
---
base-commit: c30e80d68a7afb334fde7147ee0106f25dd58d3a
change-id: 20251110-adf41513-iio-driver-aaca8a7f808e

Best regards,
-- 
Rodrigo Alencar <rodrigo.alencar@analog.com>


