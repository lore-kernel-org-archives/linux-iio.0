Received: from mail-244108.protonmail.ch (mail-244108.protonmail.ch [109.224.244.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0227145DF4B
	for <linux-iio@vger.kernel.org>; Wed, 12 Aug 2026 14:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786545063; cv=none; b=hI50evc0fdYShlHUox+J9ZWpqeuLBweFFo/XX4ZLiH7SPiLLE0n1eXlfMvgaQuyi4HASucwlKg+ZvMAV+9GIFxabb/DnWZNvKilqpuWmXT2TOR0TpB87jCuKFTXXbI3oYbwGe7drXL5EDiFxza9Kx1N/eQcPftlaUAAakMFnV+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786545063; c=relaxed/simple;
	bh=PBsOtnCHFAt539AAfYviAHlXValdaGxH9xSoBb5bRo0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=LMLEGZ/fFCOymTOek8tS0Ya1CxETki0zwB6yJZ+7fTo8in2th0KYkVASxH9exj2f3kAbwPPrkf6vYAiNSr+OczzPD2EnEzyrIcQAbvV8f2S9rvT8BTdsVRdrMpBBI2NduiqMZVAlfmAVpDmYJvkO6ecbUoVg8zdD3YM3YsMCC2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=mK7TaB9W; arc=none smtp.client-ip=109.224.244.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="mK7TaB9W"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail; t=1786545044; x=1786804244;
	bh=0aTOYcyvFqrNukw77kCre4TkM7x3Fs8Pt7uE6hf6umY=;
	h=From:Subject:Date:Message-Id:To:Cc:From:To:Cc:Date:Subject:
	 Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=mK7TaB9WBWKSGqoiJvdchavjMXidh3VGnqcuTM/+0mKcTVyTkfX1dTxTJ4RqQKI9D
	 8J6ShXMLIs/9vX0QIi3c9eensJzhAiZNbakVEYxg1vSJ4LQYk0+D0Q+2jtsL93zwtE
	 QcrIdFQgzvwP9ejjYK3ASfs63uydv4csVfE/4FvkOs5TG7RTdh0Ffw0OMMw6MIBIv6
	 YQa4gSeZOdyGQxMJ70StDSghpliAsQ7HvsgRrgZjcM7sOjFx+jDgEyQddF/Munu1XI
	 ksXPPlBog6Pe0S85IgtO398DBHkD255EAC4o3f979Pqp2I/K68lQ242IZl5hO3QYze
	 VUrhMcCb92bXw==
X-Pm-Submission-Id: 4hKrWP2fkvz2ScdC
From: Esben Haabendal <esben@geanix.com>
Subject: [PATCH v4 0/6] io: accel: mma8452: Allow open drain interrupt pin
 configuration
Date: Wed, 12 Aug 2026 16:30:31 +0200
Message-Id: <20260812-mma8452-open-drain-v4-0-bfca15d02b59@geanix.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4XNQQ6DIBCF4as0rEsz4CDSVe/RdIEIykIw2Bgb4
 92LbpqmJl3+L5lvFjLa5O1IrqeFJDv50ceQA88nYjodWkt9k5tw4AIQGO17XaHgNA420CZpH2j
 FhJQGWSGFIflwSNb5eUfvj9ydH58xvfYfE9vWjStBMnHETYwCrVnTcI0IpoRba3Xw88XEnmzex
 P8bPBtK1FY54VAq8WMUH6OCY6PIRslQOYRSI6gvY13XNwgMCTo9AQAA
X-Change-ID: 20250401-mma8452-open-drain-81577c41375c
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Martin Kepplinger <martink@posteo.de>, 
 Sean Nyekjaer <sean@geanix.com>, David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 Martin Kepplinger <martin.kepplinger@theobroma-systems.com>
Cc: Esben Haabendal <esben@geanix.com>, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Joshua Crofts <joshua.crofts1@gmail.com>, 
 Andy Shevchenko <andriy.shevchenko@intel.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786545039; l=2899;
 i=esben@geanix.com; s=20240523; h=from:subject:message-id;
 bh=PBsOtnCHFAt539AAfYviAHlXValdaGxH9xSoBb5bRo0=;
 b=/YsBda7ClY0jjhjGfsf3/crnJuw0HZCkhhWpqzkv78DStk3AeZQUDetmnXv/gMDLPlACtce+t
 4VA5Xk0FykfCVT86usHU6MSf8Q0Yz29mCEG5P2PjQyY5og2xfClzM3a
X-Developer-Key: i=esben@geanix.com; a=ed25519;
 pk=PbXoezm+CERhtgVeF/QAgXtEzSkDIahcWfC7RIXNdEk=

Extend the mma8452 driver with support for configuration of the
interrupt line in open-drain mode, which is needed for hardware designs
where the interrupt line is shared with other chips.

Adding drive-open-drain property to mma8452 device-tree node for such
designs to enable switching pin configuration to open-drain mode.

Signed-off-by: Esben Haabendal <esben@geanix.com>
---
Changes in v4:
- Fixed interrupt handler to check runtime PM status before trying to
  access the chip.
- Split open-drain support and interrupt sharing into separate patches.
- Added new patch to reuse existing struct device * through mma8452_probe()
  function.
- Print warning message when irq type is not set by firmware.
- Link to v3: https://patch.msgid.link/20260805-mma8452-open-drain-v3-0-6149f406a409@geanix.com

Changes in v3:
- Reordered patches, swapping #2 and #3.
- Always add IRQF_SHARED flag.
- New patch to change it so IQRF_TRIGGER_LOW flag is only added when no
  trigger type is set by firmware.
- Link to v2: https://patch.msgid.link/20260715-mma8452-open-drain-v2-0-95be9f5f4795@geanix.com

Changes in v2:
- Commit message of patch 2 updated.
- Operator precedence bug fixed in flags argument to
  request_threaded_irq().
- Always check return value of mma8452_set_interrupt_pin_mode(), and just
  check for non-zero value.
- Added new patch with optimization of struct mma8452_data ordering.
- Link to v1: https://patch.msgid.link/20260715-mma8452-open-drain-v1-0-b1dd2a440c60@geanix.com

To: Jonathan Cameron <jic23@kernel.org>
To: Lars-Peter Clausen <lars@metafoo.de>
To: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>
To: Conor Dooley <conor+dt@kernel.org>
To: Martin Kepplinger <martink@posteo.de>
To: Sean Nyekjaer <sean@geanix.com>
To: David Lechner <dlechner@baylibre.com>
To: Nuno Sá <nuno.sa@analog.com>
To: Andy Shevchenko <andy@kernel.org>
To: Martin Kepplinger <martin.kepplinger@theobroma-systems.com>
Cc: linux-iio@vger.kernel.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

---
Esben Haabendal (6):
      dt-bindings: iio: accel: mma8452: Add drive-open-drain
      iio: accel: mma8452: Optimize struct mm8452_data member orders
      iio: accel: mma8452: Only apply trigger type when not set by firmware
      iio: accel: mma8452: Support interrupt sharing
      iio: accel: mma8452: Allow open drain interrupt pin configuration
      iio: accel: mma8452: Reuse existing dev pointer in mma8452_probe()

 .../devicetree/bindings/iio/accel/fsl,mma8452.yaml |  6 ++
 drivers/iio/accel/mma8452.c                        | 90 ++++++++++++++++------
 2 files changed, 73 insertions(+), 23 deletions(-)
---
base-commit: db2ddb87143519e20a95aa36c60b36107b736a58
change-id: 20250401-mma8452-open-drain-81577c41375c

Best regards,
--  
Esben Haabendal <esben@geanix.com>

