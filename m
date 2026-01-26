Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA8F81EA7F4;
	Mon, 26 Jan 2026 14:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769436113; cv=none; b=RKINTNpBZxkEqhn5DUgeq4UPrlraXaI1NxD6SwedQgheBDruzvfbcP4HWBp/nDvaE04koJG/iPTcDeUQR+AmJ7iraTev2NfumplcFrnxNfE0U4NHB/ayRzh7shjo+s+YcRa4dQUbfPL0ce27Trvxi3ndFdVpJ+8A3q1JDV7XA+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769436113; c=relaxed/simple;
	bh=R21gIQbgwUX+oWBo0h1+I14p3FR0cDNzjpZL3DLCrGQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=pO3X8glGu2ZX6cnLpNu9RlnSvwdulBeGftDeZFE3r09Apee6Rcqv+qSQWC5oaqYjSGGNb7+eui66oKQUeBjWVesnvJW5eolTOItFflsioDta1p5lptXSPsRLRC4EoRx6lJu9gGWN2VbKGmBY+FL/T/cpxExMrufy+vjYEfaCgvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mTBH8I1C; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mTBH8I1C"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 599D0C19425;
	Mon, 26 Jan 2026 14:01:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769436113;
	bh=R21gIQbgwUX+oWBo0h1+I14p3FR0cDNzjpZL3DLCrGQ=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=mTBH8I1CVlw/ADJRL6/B9IjbEJvVE/O62J3RDwMLXiUVva79k5SZtxJHnJsVjY4jP
	 PJSh/Rck0XMuNfHTdyHPCxIc6oczIOqlCx7YjfB72lNdlWrvCTQC0LPqkJSIGo1KDm
	 VlA9btq4bb63QlpcFW9Q0ox4tC91f5W/SD0fActw+w1HL2iqzSzYADOaXHQirV7L3I
	 r6Kp1hPsufmobWwB5KsUlShGHT1FT1Eq65lEfotAM7qae4XcxceJxBa5yHoZYKgDbN
	 hmgwKMsETBVigoWeKACf+3P5C2C8HsIFUB3PcRqCLe1euqnk9ZBYxjiScWyN2Qn1eM
	 rq8BpsIxT/bKA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46BE5D13C1A;
	Mon, 26 Jan 2026 14:01:53 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Subject: [PATCH v2 0/6] iio: amplifiers: ad8366: driver update and dt
 support
Date: Mon, 26 Jan 2026 13:51:01 +0000
Message-Id: <20260126-iio-ad8366-update-v2-0-c9a4d31aeb01@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEVxd2kC/22NQQ6CMBBFr0Jm7Zi2QAOuuIdhMZQRJlFKWiQaw
 t0trF2+l/z3N4gchCPcsg0CrxLFTwnMJQM30jQwSp8YjDKl1kajiEfqq9xafM89LYylpY5cWXW
 dI0i7OfBDPmfz3iYeJS4+fM+LVR/2qFmldf2ntmpUWKmiYJNzbQtqaKKnH67Ov6Dd9/0HPbIuj
 rMAAAA=
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1769436111; l=1923;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=R21gIQbgwUX+oWBo0h1+I14p3FR0cDNzjpZL3DLCrGQ=;
 b=N7/MmRTnYxgXuSEeWtMZTUAik4oBIvjVumccBAW1++K9pnWmzLj/m0vYTHlQXFHUXB6KQ+yp2
 dgz5t9xwEgzAdvzmhYW6Nqe13REFH7lcZ1twpm3jnKZBdMzRMKG4miW
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
Changes in v2:
- Reorganize commits with cleanups before features.
- Link to v1: https://lore.kernel.org/r/20260119-iio-ad8366-update-v1-0-8044e23e964a@analog.com

---
Rodrigo Alencar (6):
      MAINTAINERS: Add missing maintainer entry for AD8366 driver
      dt-bindings: iio: amplifiers: Add AD8366 support
      iio: amplifiers: ad8366: refactor device resource management
      iio: amplifiers: ad8366: add device tree support
      iio: amplifiers: ad8366: consume enable gpio
      iio: amplifiers: ad8366: Update device support

 .../bindings/iio/amplifiers/adi,ad8366.yaml        |  68 ++++
 MAINTAINERS                                        |   9 +
 drivers/iio/amplifiers/Kconfig                     |   6 +
 drivers/iio/amplifiers/ad8366.c                    | 385 +++++++++++----------
 4 files changed, 278 insertions(+), 190 deletions(-)
---
base-commit: f52690c50893ef1504990199c8a2dfbb869f38c6
change-id: 20251121-iio-ad8366-update-56abac58bbca

Best regards,
-- 
Rodrigo Alencar <rodrigo.alencar@analog.com>


