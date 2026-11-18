Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795009573;
	b=GV/skucAsCV7yqLX45W3ijfntzQNKh37B/FXSJpCOryTjuIUQ+nKjhZSFWKmW4SE5HEu
	 OvO4qLsWM4s22mGcsXEOrUsTfCbUdNYv7mun/d1W3HO3m8nsmxJZ3dMBhru/WXkLeqqsq
	 9Ax/0PT2Jy7zA1LG3DOC2hajCBydyc+xqUGdJJzliJfbqLKBr1ZNH+iyRUHk3xQWXvgEv
	 lfKcqpAGt6s3sVR9HFoLsxOo29XzXAiGtrYHeCPDh19LsSBRoSSpyWHN2wNrN0nUZzlaK
	 Mk+4tyaXevrkUfXF/efLCEx4r9jJaDrT81ePXPfihEbOkt5dse1kicZfHYg0MKTY64w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795009573;
	h=Received:DKIM-Signature:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer;
	bh=ME2c98cFZmrsIFhi9t1O9MP3b4XqKwYbmgLCsFp/Kbc=;
	b=YgUrx6TvgVlM1GdLhSHFPfxnu+g/0pLLNsV+Iibho6eLY38RrN3fcxmlER3jZ9AUS983
	 PkZ9epnLtUrF/mmhhq3Bq5BTVY80v9XbNmuRd69T3b9/4lqb2cURxkU1BUNf4YzCs7D6E
	 Kd53NoBm/H4qobgazcJCdM8mBY9GJ2xY+DM0KsuRlWNUm/ayL0CcE4h/KBeQ6eCIV57Ca
	 cc1OZHvh7w1Wz07RcoW5nkCnMNHP1HAUtqBKPIPzba/C8Z8KaeT0Vkzu/+aUvlEnyYo9Z
	 c8DVMZx3Jq13Rkf6Lhf5E8n9bCIFvlHF4NABzT8tJJhutgneEEu0LMSHKDj8J0fpzjw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c2PvRVVl;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5922860A2604;
	Wed, 18 Nov 2026 13:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c2PvRVVl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B717A1F000C4;
	Wed, 18 Nov 2026 13:46:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795009573;
	bh=ME2c98cFZmrsIFhi9t1O9MP3b4XqKwYbmgLCsFp/Kbc=;
	h=From:Subject:Date:To:Cc;
	b=c2PvRVVlZbHVxiKNPdEW5e9H9e3zgPmmfiFySKodj48z0AxpxU14WpapWtsMfrnF9
	 lOt6EIXhl4Lf5HXGDZFgYP+c6c5yQ9j60oAxPUSuUzRa+buXRZhZ5VPbK7V0uKqbtE
	 Ga+JhVpxNsImDjPFThqOz5UmAj0fpjN0mz4KHOvzx6HTs9xvHDyXJ5Dn2Oq1KZ1PeR
	 xnCCKpMHmeO0V//yz0ULOgGD00RTx0K28zURwZdrBje1X96Qy1dc6B04EIQI6CBKR1
	 0SVd491/zTkjaubW1L1iTNJQvdzHjWEb4+R6Gn3shx6yJmmmUiuLGtg2XPcA5nalOF
	 NXWt3mjITchkQ==
From: Linus Walleij <linusw@kernel.org>
Subject: [PATCH v3 0/5] iio: light: gp2ap020a00f: Add VCC supply and
 GP2AP030A00F support
Date: Wed, 18 Nov 2026 14:46:07 +0100
Message-Id: <20261118-gp2ap030-v3-0-c8df93460110@kernel.org>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAA/3XMQQqDMBBA0auEWTtlkphqXHmP0kXUUUOLSlJCi
 3j3olBKF91++G+FyMFzhEqsEDj56OcJKqEzAe3opoHRd1AJUKTOUlKBw6LcQprQWkN5q7qWdAm
 ZgCVw758HdblmAkYfH3N4HXKSe/0g5RdJEgmN0TLnpiBjmvrGYeL7aQ4D7EpS/06FhCpn52Rje
 zb259y27Q3utgxv2wAAAA==
X-Change-ID: 20261107-gp2ap030-99504c2dc038
To: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Kyungmin Park <kyungmin.park@samsung.com>
Cc: devicetree@vger.kernel.org, Linus Walleij <linusw@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>, 
 Joshua Crofts <crofts@kernel.org>
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
Changes in v3:
- Return -ENODATA when chip match data is missing.
- Use four-line initializers for I2C device IDs.
- Document the 1 ms power-on delay and use USEC_PER_MSEC.
- Align family descriptions and list supported parts in Kconfig help.
- Pack GP2AP030A00F samples as 16-bit values and omit zero shifts.
- Link to v2: https://patch.msgid.link/20261108-gp2ap030-v2-0-24eaa1b9fe59@kernel.org

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
 drivers/iio/light/gp2ap020a00f.c                   | 147 +++++++++++++++++++--
 3 files changed, 151 insertions(+), 19 deletions(-)
---
base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
change-id: 20261107-gp2ap030-99504c2dc038

Best regards,
--  
Linus Walleij <linusw@kernel.org>

