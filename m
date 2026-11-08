Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794174244;
	b=Ep++jCJ0sh7cR/nksyJ5RcjsfvXrhNt5ucbYa5xsCHk8gIpfR1pWBhK8R38msA9CZNIn
	 kcbjsEmjer7y8I4I4NGBwO8X1wAWSkM2smnBI21KcIiH5gOiSuqc9cyNHa2eP8sLUUKIL
	 Ep76mck7xxAD3JZ3Z98Kx76JRcSZYkHedKwgT4ILdbznidMjEgds5+dY6FMBGZvNzatG9
	 hzc40sdIV9WYkhW1Nxj/Po30LPLTVv+EaWEulUAR6GkInTVSTNOdkpEMMCVH8F1zp+Q5C
	 i9QliRANwqHu1xV8woSg07lZ6VrzFgnFSmNo5WoosjKSUn3ncxdTLfogdWTolULfqLg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794174244;
	h=Received:DKIM-Signature:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer;
	bh=HyY9LZsqXMqU6TJvTlAIMrH9fUfSEMURKgAuTO+sdGc=;
	b=pLQOEMgyP1me+qhOYXwUsS5ZJZG7c5AJbVYPnjFl5wWYWXQopMF0ncu0YNnar/ExLghA
	 A8MqcWjMimfvZ7Le9J4kwi4wZj5PnhymgXkcvpEbWA8wWBAtH3iQsXJ3xRIOj0014zdV5
	 3P8TEyTDFrVJ0ioaykCuTsjUPXA3R6nmoAz+bt+vSEW0KhtFayXzx/+t18Z8H3rcHLcHL
	 AtycfuwvbSA54hIIk6nqJ0tXHVPK7juUOXvle9lKvHON6L82NgXsV0jCJTMI1WinFIFTb
	 CD2Lg/JT30q5KKzda+n9ht4vNrSBlJYe0vMlsfN8GOGV3EDYNAdyCtepfsJPQZo3WwQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lc247RHm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33178606A331;
	Sun,  8 Nov 2026 21:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lc247RHm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 951B71F0089F;
	Sun,  8 Nov 2026 21:44:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794174243;
	bh=HyY9LZsqXMqU6TJvTlAIMrH9fUfSEMURKgAuTO+sdGc=;
	h=From:Subject:Date:To:Cc;
	b=lc247RHmlARewjRcFxCCexRTuj4+GL4V2SwuqVn7QPmPokNDo5/XO98uz5Es8wAFu
	 Mkvt6vHR6iBPNsIySbwCPuJqdFjN9Y6B7bV0BjL3hL1kD9oCxjeW6MrMeNUaZArSgq
	 SRBBMaXisjsC/B+ZI6DbWBzfBsJ+0sGkVzpR+m5od4TrTzAF9h4COpeQ/o8+heNw4O
	 Jkt/M57/eIqxXgMW3QItxpMY5AqsG8UECn7AfnsGdXXax4SpfxG0cZgX/vsh4fTcfa
	 jiRgTBMS1Vk6XgdWD0xNdfCjy17i6WCevbw93O9I1Svdgcotd7Jg33HD5Ipt3HiSVa
	 s/ZaNF6VcumbQ==
From: Linus Walleij <linusw@kernel.org>
Subject: [PATCH v2 0/5] iio: light: gp2ap020a00f: Add VCC supply and
 GP2AP030A00F support
Date: Sun, 08 Nov 2026 22:43:58 +0100
Message-Id: <20261108-gp2ap030-v2-0-24eaa1b9fe59@kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAA/0XMSwrCMBAA0KsMs05kkjb2s/Ie0kWbjumgtCGRo
 pTeXSyI27d4G2ZOwhlb2DDxKlmWGVuwCtBP/RxYy4gtoCV7NoYqHaLtIxWkm8ZR6e3oqahRAcb
 EN3kd1bVTgJPk55Lex7yar/6S+p+sRpN2rjAlDxU5N1zunGZ+nJYUsNv3/QOKmLF/oQAAAA==
X-Change-ID: 20261107-gp2ap030-99504c2dc038
To: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Kyungmin Park <kyungmin.park@samsung.com>
Cc: devicetree@vger.kernel.org, Linus Walleij <linusw@kernel.org>
X-Mailer: b4 0.16.0

Describe and enable the optional VCC supply for the GP2AP020A00F and
GP2AP030A00F. Preserve compatibility with existing device trees that only
describe the LED supply.

Extend the existing binding and driver to support the GP2AP030A00F. It
shares the register layout, but has different proximity resolution
encodings and no automatic lux calculation. Select model-specific
initialization, keep reserved bits clear and expose fixed-range raw
clear and infrared counts. Keep generic supply handling in separate
patches from the model-specific binding and driver additions.

Assisted by LLM.

Signed-off-by: Linus Walleij <linusw@kernel.org>
---
Changes in v2:
- Replace vdd/vio with one optional vcc supply, matching the VCC pin.
- Use devm_regulator_get_enable() for VCC, allowing dummy regulators.
- Move the VLED description into the generic supply binding patch.
- Split variant infrastructure from GP2AP030A00F support.
- Use "GP2AP020A00F and similar" in family descriptions.
- Use reverse Christmas tree ordering for local declarations.
- Explicitly select MANUAL_CALC when automatic ALS calculation is absent.
- Reject missing chip match data before accessing the device.
- Use fsleep() for the GP2AP030A00F startup delay.
- Select static channel arrays and counts through chip_info.
- Link to v1: https://patch.msgid.link/20261108-gp2ap030-v1-0-55314eb7055b@kernel.org

---
Linus Walleij (5):
      dt-bindings: iio: light: sharp,gp2ap020a00f: Add VCC supply
      dt-bindings: iio: light: sharp,gp2ap020a00f: Add GP2AP030A00F
      iio: light: gp2ap020a00f: Enable the VCC supply
      iio: light: gp2ap020a00f: Prepare for chip variants
      iio: light: gp2ap020a00f: Add GP2AP030A00F support

 .../bindings/iio/light/sharp,gp2ap020a00f.yaml     |  17 ++-
 drivers/iio/light/Kconfig                          |   6 +-
 drivers/iio/light/gp2ap020a00f.c                   | 136 +++++++++++++++++++--
 3 files changed, 143 insertions(+), 16 deletions(-)
---
base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
change-id: 20261107-gp2ap030-99504c2dc038

Best regards,
--  
Linus Walleij <linusw@kernel.org>

