Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7467C2EF653;
	Tue,  2 Jun 2026 12:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780404416; cv=none; b=aN+08Qd8iCn9hHsdZWAOCAUsGuv2KpkdMlLn2ESwohKdSI97m4KyxI2NbxLqQ/z1pxcrJ3V2nrJxHon7L9dm4W4LNtpb7QWLWJtTh+jcOYGtgEefTnFxsjZwnESXaunAY0ppF+rh37JbNyAL/mfgNu5dZ24aWcxzaR5FX9DMAeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780404416; c=relaxed/simple;
	bh=7JSIVJME0qcwrQkDU0f3aTxdQOaohzA3I2n+ATF6Cqc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ZVg474TtwWDL+NgpfQkYO9S/HcTm28gAs9qNJ588ZYaGhUBx7vrUKOQhqfvziA3jn/rJAM70ZW0CZUhHEx9bnh+ihxmzN8cPrmHXWaWZdyfPPQM6FFBoPsUh+7OKqVtezXhH9wPXI3IsKyWkzx8im3Ea80jp7/NdpayXf+2Kteo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nytbkpnv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nytbkpnv"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 19749C2BCB4;
	Tue,  2 Jun 2026 12:46:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1780404416;
	bh=7JSIVJME0qcwrQkDU0f3aTxdQOaohzA3I2n+ATF6Cqc=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=NytbkpnvZm9cEu5e4OX06nVnFWbbd6myUUwGAsHmbU6zXX1VTeOaOv35meORmxrWo
	 tCA0Flr/HAmxpKxbg0BpN3vNjqROfAFJJtv3QtsLqKxhJBK7TJfBR5jiFGjObApwS2
	 FknjOxTuEJjzhDT7HAuiFjrOXdK/BEaZr2V0IJeC2fCciCu4qHz7T5bNFaF8SFA+VK
	 KZBrb4O1/rlvZgTIjk4Y6Npmb9XNx5n8D0eAkEQI6ZPPAXbe7CuueJ/wdYrSvzD47L
	 BzKIDmThUSMO+GQBCbrw9tXvK/vBpk85L01ubDP3Rrt9Oq0ipfFpMYL64yXNbLXcjW
	 4pvLy+5iWB9cg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02855CD6E57;
	Tue,  2 Jun 2026 12:46:56 +0000 (UTC)
From: Roman Vivchar via B4 Relay <devnull+rva333.protonmail.com@kernel.org>
Subject: [PATCH 0/4] AUXADC driver for the MediaTek mt6323 PMIC
Date: Tue, 02 Jun 2026 15:46:53 +0300
Message-Id: <20260602-mt6323-adc-v1-0-68ec737508ee@protonmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMTQ5AMBBA4avIrDVhGl24iljodMpI/KRFJOLui
 uW3eO+CyEE4Qp1dEPiQKMucUOYZ0NDNPStxyYAFmqLCSk2b0ahV50hpy55YG7IeIQVrYC/nN2v
 a33G3I9P2HuC+H2I4g2luAAAA
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
 Roman Vivchar <rva333@protonmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780404414; l=2643;
 i=rva333@protonmail.com; s=20260510; h=from:subject:message-id;
 bh=7JSIVJME0qcwrQkDU0f3aTxdQOaohzA3I2n+ATF6Cqc=;
 b=0JbMx2y6tCQJ3dd9ZlUioB5ryHJQg5jI2blGOCtlbQ6SkPy7gHQ8050y5eQKPoicbwzx0Hnsg
 abvtLeSslqPAqYkIExaK3VblfKmPSMfXmth7sUz2Ec+Ybrc3QcZ880Z
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

The other parts (EFUSE and thermal) will probably be sent next week.

[1]: https://lore.kernel.org/linux-mediatek/20260504-mt6323-v1-0-799b58b355ff@protonmail.com/T/#med30fad67a090be35f549231336b2dec295233f6

Tested-by: Ben Grisdale <bengris32@protonmail.ch> # Amazon Echo Dot (2nd Generation)
Signed-off-by: Roman Vivchar <rva333@protonmail.com>
---
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
 MAINTAINERS                                        |   8 +
 arch/arm/boot/dts/mediatek/mt6323.dtsi             |   5 +
 drivers/iio/adc/Kconfig                            |  11 +
 drivers/iio/adc/Makefile                           |   1 +
 drivers/iio/adc/mt6323-auxadc.c                    | 299 +++++++++++++++++++++
 drivers/mfd/mt6397-core.c                          |   3 +
 .../dt-bindings/iio/adc/mediatek,mt6323-auxadc.h   |  24 ++
 8 files changed, 353 insertions(+), 1 deletion(-)
---
base-commit: 028ef9c96e96197026887c0f092424679298aae8
change-id: 20260525-mt6323-adc-3befce36cbf2

Best regards,
--  
Roman Vivchar <rva333@protonmail.com>


