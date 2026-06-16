Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE33C36403D;
	Tue, 16 Jun 2026 14:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781619341; cv=none; b=IdziFsee0cMK4po+4PMyfWiCD3/tLvv2oZvU6LEk3n5RDE4RAZDJML2E35YNXbZwATk5Rt1ejLNn5nJPN7PtomzGRXAMW4mE6tPp2GkaxOYliPQsonbla14jGmmHrz61sh8x58puiDMqZXti+KUDCIxq1NUFjzSmxs/WU/OyCG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781619341; c=relaxed/simple;
	bh=XlvIloNwlhCYTGHH8aZG1rdAJjOlq93TwFN1w080BL0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Hay82irC5dyXo2yIZEEKEfUW2KVgJaWSFKmgCqfXqBaxqXtVMEcyTBBP/Zj9KVOhoQ8H08z+cOABBD7eL7FulwkAzhp9Q7TSDtwW0TlIv4HbuDvw1EgE7MMZfMrioMbe7x36awhBJS82azL5ppILY3G9mNLqslyq9I34ZZ74ZtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d3ALwlVF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d3ALwlVF"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 512CCC2BCB8;
	Tue, 16 Jun 2026 14:15:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1781619341;
	bh=XlvIloNwlhCYTGHH8aZG1rdAJjOlq93TwFN1w080BL0=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=d3ALwlVFgmBywMHfOl5dLQuzlxvQ1Dl0G6AW76Ch6YwwzuiQ6tF0ULMU0O2ZFpz4J
	 n7UIamdVyUErWvbQTFGkitK9FnUeLgBbhpet1iy1MZq5fgo3xM93YyujMrLRMt0AhO
	 bI1FeusiXH9hCp6ADy/oFd6gP7ErjB3Lndo190gpfGeo447yR/kFDxXbAVygpL1pVM
	 SSU/HoP7hQ0xweaWEtoBB6BHzPDpdfG5z8MhDu94WCiihZoOXMYF3XBi8INSTEREEh
	 ffOGy1AxcfD1IJavmW99fFzKWyZYyaT0BOYKusAVl0LlBVIejMjJgXnpj9fy2y6mGV
	 7LWBIYj3qSs5w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39B72CD98CF;
	Tue, 16 Jun 2026 14:15:41 +0000 (UTC)
From: Roman Vivchar via B4 Relay <devnull+rva333.protonmail.com@kernel.org>
Subject: [PATCH v3 0/4] AUXADC driver for the MediaTek mt6323 PMIC
Date: Tue, 16 Jun 2026 17:15:38 +0300
Message-Id: <20260616-mt6323-adc-v3-0-1c27c588185d@protonmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/2WN0Q6CIBhGX8VxHY1+JmpXvUfrAvEnaSkOiNWc7
 x7oja3Ls33nfDPx6Ax6ci5m4jAab+yYgB8Kono53pGaLjEBBoKVUNIhCA6cyk5R3qJWyIVqNZA
 kTA61ea+x621j/2ofqEIu5EVvfLDus77FU95tYcFgH44nyqioUVW8KlmNeJmcDXYcpHkelR1Ir
 kfY+82PD8mXsuESgLNGN3/+sixfL3ZHK/sAAAA=
X-Change-ID: 20260525-mt6323-adc-3befce36cbf2
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Lee Jones <lee@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, Ben Grisdale <bengris32@protonmail.ch>, 
 Roman Vivchar <rva333@protonmail.com>, 
 Andy Shevchenko <andriy.shevchenko@intel.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781619339; l=3607;
 i=rva333@protonmail.com; s=20260510; h=from:subject:message-id;
 bh=XlvIloNwlhCYTGHH8aZG1rdAJjOlq93TwFN1w080BL0=;
 b=NbUp3PfytNvQnQz7+JDvwPQAi/S5bTTYQfLrvRPuMmXmkYazYuBdekOocL0sWzz3jCGWz72Ix
 EGx0RQ40Dw0AXDupH/lVZbWQ00PDSjnvhgqIgdRzNJP6x4bJYy7YcFm
X-Developer-Key: i=rva333@protonmail.com; a=ed25519;
 pk=zww/nWjBGoQ4POXCG0BV6fx2iuXK6jx77rsKPA5YK5Y=
X-Endpoint-Received: by B4 Relay for rva333@protonmail.com/20260510 with
 auth_id=777
X-Original-From: Roman Vivchar <rva333@protonmail.com>
Reply-To: rva333@protonmail.com

This series adds support for the 15-bit AUXADC hardware block found on
the MediaTek mt6323 PMIC.

The previous version of the series for all AUXADC, EFUSE and thermal
drivers was split after Krzysztof's comment [1].

Tested on the MediaTek mt6572 and mt8163 SoCs (Ben), both paired with a
mt6323.

The other parts (EFUSE and thermal) will probably be sent this week.

[1]: https://lore.kernel.org/linux-mediatek/20260504-mt6323-v1-0-799b58b355ff@protonmail.com/T/#med30fad67a090be35f549231336b2dec295233f6

Tested-by: Ben Grisdale <bengris32@protonmail.ch> # Amazon Echo Dot (2nd Generation)
Signed-off-by: Roman Vivchar <rva333@protonmail.com>
---
Changes in v3:
- AUXADC driver:
    - Add comment for channels table about voltage and channel IDs (Jonathan)
    - Add comment for mutex in the 'mt6323_auxadc' struct (Jonathan)
    - Break 'regmap_read_poll_timeout' on logical boundaries (Andy)
    - Switch to 'guard' from 'scoped_guard' (Andy)
- Link to v2: https://patch.msgid.link/20260609-mt6323-adc-v2-0-aa93a22309f9@protonmail.com

Changes in v2:
- AUXADC driver:
    - Drop channel type from the MTK_PMIC_IIO_CHAN macro (Nuno)
    - Drop kerneldoc for the mt6323_auxadc struct (Nuno)
    - Add channel release to save power (Sashiko, Jonathan)
    - Drop 'reg' variable in the mt6323_auxadc_read (Jonathan)
    - Sort variables in the mt6323_auxadc_probe (Jonathan)
- Maintainers:
    - Drop linux-mediatek list (Andy)
    - Split between dt-bindings and driver to avoid missing file (Nuno)
- Link to v1: https://patch.msgid.link/20260602-mt6323-adc-v1-0-68ec737508ee@protonmail.com

Changes after split:
- dt-bindings: Change 'MT63xx' to 'MT6350 series and similar' (Jonathan)
- AUXADC driver:
    - Add missing headers (Andy)
    - Fix AUXADC_TRIM_CH* values (Andy)
    - Rename masks to include their register name (Jonathan)
    - Fix formatting (Andy, Jonathan)
    - Replace channel address with actual register value (Jonathan), align the table
    - Replace IIO_TEMP with IIO_VOLTAGE, since the actual output is still mV, not mC
    - Rename constants to match their registers (Jonathan)
    - Remove 'if/else if/else' in the mt6323_auxadc_read_raw (Andy)
    - Add comments for fsleep, ADC range and resolution (Andy, Jonathan)
    - Remove useless error messages (Andy)
- Maintainers:
    - Explicitly include mt6323 in the name (Jonathan)
    - Squash with AUXADC driver commit (Krzysztof)
    - Set status back to 'Maintained'
- Link to a previous series: https://patch.msgid.link/20260512-mt6323-v2-0-3efcba579e88@protonmail.com

---
Roman Vivchar (4):
      dt-bindings: iio: adc: mediatek,mt6359-auxadc: add mt6323 PMIC AUXADC
      iio: adc: mt6323-auxadc: add mt6323 PMIC AUXADC driver
      mfd: mt6397-core: add mt6323 AUXADC support
      ARM: dts: mediatek: mt6323: add AUXADC support

 .../bindings/iio/adc/mediatek,mt6359-auxadc.yaml   |   3 +-
 MAINTAINERS                                        |   7 +
 arch/arm/boot/dts/mediatek/mt6323.dtsi             |   5 +
 drivers/iio/adc/Kconfig                            |  11 +
 drivers/iio/adc/Makefile                           |   1 +
 drivers/iio/adc/mt6323-auxadc.c                    | 314 +++++++++++++++++++++
 drivers/mfd/mt6397-core.c                          |   3 +
 .../dt-bindings/iio/adc/mediatek,mt6323-auxadc.h   |  24 ++
 8 files changed, 367 insertions(+), 1 deletion(-)
---
base-commit: 028ef9c96e96197026887c0f092424679298aae8
change-id: 20260525-mt6323-adc-3befce36cbf2

Best regards,
--  
Roman Vivchar <rva333@protonmail.com>


