Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 096042C3261;
	Tue,  9 Jun 2026 13:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781011941; cv=none; b=FjESLVo+r4L7nPX9HcCKs0UIEgfen3XSRXE3D9KMhvMowjLn2i1xieE34GACzcLafNjgGE1EGBc30jABVoxCmLmcJkTkh6/3yPZE/ymbnEZTqTFbsvQW5FRX8iyOCEat8Lw/xAd1Yv7gv/A7+OHDLx6xwcnwzl7OFv+wCFbq0WU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781011941; c=relaxed/simple;
	bh=FfND962Io4+pHKDVIyGxMi09AxKTKGfMA3CBqCUUb4c=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=o7w1ELDJknV1jowSKsb8cQn70uO8UwD0eDGxcJp+S8NeuInCDjm7T/ovQyCKaWCvZacTEj7BIrGB+222YY6I0O3eWtk2z27HS5gzjPx4fkacIyIh5eTDxupyrXaqMOZysMQvI6y1hg2Zn+nTWUBqTa2oEiiq4tmw3TuXmn3Ssr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S9vcKysn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S9vcKysn"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9ADC5C2BCB4;
	Tue,  9 Jun 2026 13:32:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1781011940;
	bh=FfND962Io4+pHKDVIyGxMi09AxKTKGfMA3CBqCUUb4c=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=S9vcKysnFo0u6uwqTxbGJkQtCzClBYHpiUkKANV6mEtY0Qj9pV4uxv/TzHCwd9lqn
	 4+pti0jKXHtVvyalLb3Lm+jxbO8mfKSESQRTF4aKraBeBJqy1mTBmWJQoV3WqpLGE4
	 IDgD4x4PdzGVkDE2gKvYTue2NkAlQ08gvzNR/9ihubExcTHp5c19bCynCKifi6hYFI
	 OvX6hyq3UWtwOKWxSim+iaXym2fIfsJoUAIeYRo2yb95mtMPVWTK7Q7uWaE66palec
	 ySg+Fu+aeck9EML39HN518kcahCMEvZYGbuvOj163CYvBhUUACU8/CcKLSoT7jQmRK
	 SLDdu1KLuFG1Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6338FCD8CAA;
	Tue,  9 Jun 2026 13:32:20 +0000 (UTC)
From: Roman Vivchar via B4 Relay <devnull+rva333.protonmail.com@kernel.org>
Subject: [PATCH v2 0/4] AUXADC driver for the MediaTek mt6323 PMIC
Date: Tue, 09 Jun 2026 16:31:57 +0300
Message-Id: <20260609-mt6323-adc-v2-0-aa93a22309f9@protonmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/02Nyw6CMBBFf4XM2poyDYW48j8ICxgGGSOUtJVoC
 P8uj43Lk5x77gKBvXCAW7KA51mCuHEDvCRAfT0+WEm7MaBGqzPM1BCtQaPqlpRpuCM2lpoOYRt
 Mnjv5HLGyOjm8mydT3Au70UuIzn+PtzndvTNsNf6H51RpZQum3OSZLpjvk3fRjUMtryu5Aap1X
 X9z9kGBuwAAAA==
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781011938; l=3208;
 i=rva333@protonmail.com; s=20260510; h=from:subject:message-id;
 bh=FfND962Io4+pHKDVIyGxMi09AxKTKGfMA3CBqCUUb4c=;
 b=jBjC9nUipu0EfQIEXnZBKRC9uX4Uz5bSk7FypJ32naF/9gTeAAKor08+V9gO0X14uZz1EdHg5
 eBOD4lkHfG8A2SKq8S7iiMtb9/gwpjR+0u9FO957v6igfqL5ohoP2b6
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
 drivers/iio/adc/mt6323-auxadc.c                    | 305 +++++++++++++++++++++
 drivers/mfd/mt6397-core.c                          |   3 +
 .../dt-bindings/iio/adc/mediatek,mt6323-auxadc.h   |  24 ++
 8 files changed, 358 insertions(+), 1 deletion(-)
---
base-commit: 028ef9c96e96197026887c0f092424679298aae8
change-id: 20260525-mt6323-adc-3befce36cbf2

Best regards,
--  
Roman Vivchar <rva333@protonmail.com>


