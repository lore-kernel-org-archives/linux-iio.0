Received: from mail-43170.protonmail.ch (mail-43170.protonmail.ch [185.70.43.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 211AC4119EA;
	Wed, 19 Aug 2026 08:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787127364; cv=none; b=Q/SAsPRCBG+TUZ/mUf3pU5p3UehEZv8PciUMIj2layHVMG3STFSjxJO7Ran+5NcU+AgmLzyywMhCIZeN7jZkiiT6r4xG0h/6FawJbkJKIheTX3Pzc+uCSE1lY7Vo63/rMavqrcFKDc1/o0V1svpOWTk2JgUtsnrMH7AUXnQTDVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787127364; c=relaxed/simple;
	bh=riwQcsO+IwaxUI20B5dB5i/Pd1mKHIkaDTT7CXcGWQ0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=IDuQOWVauy0cYKXfGsq8vYKnCVkitrdD1oNMv86qVos8yDH62PbnFkIqxM6Se14QZ1XCyTJEO9AUgsM/HOqB8BfYLrcVmqlb6+HRAT+PCd2p1ThhgIxbqW5BQHXU47e4U24VqZTL2Wngr+cZHvC4lqwk+uDFLQND/BC9KNS1gZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=7Y3vP2Q6; arc=none smtp.client-ip=185.70.43.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="7Y3vP2Q6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail; t=1787127344; x=1787386544;
	bh=IRj8ucj1w3XLvtGVfDIqQWeYMjyIWuKPJ1zghR+kRco=;
	h=From:Subject:Date:Message-Id:To:Cc:From:To:Cc:Date:Subject:
	 Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=7Y3vP2Q6sbERGk3mdN75Kwg9MD2ZjVtythgWkqRcHV5JTuk1HL1gU1CV6vZZyiuvo
	 jCX5GIV7Lx9qb2tr8883s1dM4J/ekMXMae1LEmlu3+QJdf1oqbSCtsRqO8rb1S4x8P
	 CzidBjKpR+SGE9hhNzKyAYYDpwP5HFxdkp0Fbtuftrz12y9IZ380AYq8GNGX+N7hf8
	 ibO7TdkJLKWW3LZd4qtmNQA8svFMdDj7OX3e92I3j4BaL4OPD3zVDn6LRRiXSl5y19
	 kn6Kq2V2/8ETXkdipkg/lrd4uK7j6g/edObCoXaslptHyrHPxmsKSOjZs2TPjWbwNH
	 FzdYyFJGG2Lcw==
X-Pm-Submission-Id: 4hPzsT4pY4z2SchF
From: Esben Haabendal <esben@geanix.com>
Subject: [PATCH RESEND v5 0/6] io: accel: mma8452: Allow open drain
 interrupt pin configuration
Date: Wed, 19 Aug 2026 10:15:27 +0200
Message-Id: <20260819-mma8452-open-drain-v5-0-d8aa590d7c36@geanix.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4XQPW/CMBAG4L+CPNfVnXMXx506lLUDjIjB8Qd4i
 IOcKqJC/PcaFloRqdPp1el9pLuLmEJJYRJvq4soYU5TGnMN/LIS7mjzIcjkaxYKFAMBymGwHbG
 S4ylk6YtNWXbIWjvCRrMTtXhM09dYvu/mjHXsbvUWNPJSfUYJskfvlSUC18L7Idiczq9uHMS+e
 rP631DVMNwHEzmSNvxkNA+jg2WjqUaLZCJBawnMk0G/DFSLBt1uic4ie1A9/zWuFTmVENP5/vG
 d2Ky368+Purj+ABAPbYuJAQAA
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787127340; l=3253;
 i=esben@geanix.com; s=20240523; h=from:subject:message-id;
 bh=riwQcsO+IwaxUI20B5dB5i/Pd1mKHIkaDTT7CXcGWQ0=;
 b=8f9TpexBf77nn7GJKTf+aZcfZXaxF5IEWvpfW9QlRs4W8Uz44canzVcum/H5wBH7Mg7PSFwtg
 Ahv2qjXlSvEBhnabHfaqW2C/K4N4pRK1F5ab/CyixOuThFTfplsbpsg
X-Developer-Key: i=esben@geanix.com; a=ed25519;
 pk=PbXoezm+CERhtgVeF/QAgXtEzSkDIahcWfC7RIXNdEk=

This is a resend of v5 which was not fully sent first time for some unknown
reason.

Extend the mma8452 driver with support for configuration of the
interrupt line in open-drain mode, which is needed for hardware designs
where the interrupt line is shared with other chips.

Adding drive-open-drain property to mma8452 device-tree node for such
designs to enable switching pin configuration to open-drain mode.

Signed-off-by: Esben Haabendal <esben@geanix.com>
---
Changes in v5:
- Squashed dev_err_probe() call to one line.
- Fixed typo in patch 2 title.
- Added synchronization between runtime suspend and interrupt handler.
- Link to v4: https://patch.msgid.link/20260812-mma8452-open-drain-v4-0-bfca15d02b59@geanix.com

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
      iio: accel: mma8452: Optimize struct mma8452_data member orders
      iio: accel: mma8452: Only apply trigger type when not set by firmware
      iio: accel: mma8452: Support interrupt sharing
      iio: accel: mma8452: Allow open drain interrupt pin configuration
      iio: accel: mma8452: Reuse existing dev pointer in mma8452_probe()

 .../devicetree/bindings/iio/accel/fsl,mma8452.yaml |  6 ++
 drivers/iio/accel/mma8452.c                        | 98 ++++++++++++++++------
 2 files changed, 80 insertions(+), 24 deletions(-)
---
base-commit: db2ddb87143519e20a95aa36c60b36107b736a58
change-id: 20250401-mma8452-open-drain-81577c41375c

Best regards,
--  
Esben Haabendal <esben@geanix.com>

