Received: from mail-244108.protonmail.ch (mail-244108.protonmail.ch [109.224.244.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6FB53E316F;
	Wed,  5 Aug 2026 07:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785914514; cv=none; b=jfFao0cTWi4VzEu2rWOdz5QWHKMvv5QbLdJeGkt3PZIaBFjUBIic2AkwR2oi2G3GrOd8Mi5Bau+eLURBpWB4xOs5QfKv+5TuMRM60duNYdKy5Avkt+ezOjrgaX0tHryE0K1AOY0uIBofkWKkuqAmJAhaLYkD8qfmd8k7LDd/Fok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785914514; c=relaxed/simple;
	bh=yRGJz5Ns5hgNujExrbtlKUm19YHk5OPVvmy6zVCRj5o=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=NX3L/YaRiNSazOKJJsQQ4BEUYSxyd+8s8MC2KrfOyKrAVkOT3iHrTYHuOr/bmqQTIx7IwAIqCskFVwVyzePjdB3dAIjOc1UZ1AsBtw71V/LrOo1CebUhIGuVXQEdW88BNjE6AGALSKiT5fOB8rekQ8qtehCI1jbSRwFoOSCcy8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=Rw4NzZ5U; arc=none smtp.client-ip=109.224.244.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="Rw4NzZ5U"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail3; t=1785914506; x=1786173706;
	bh=uRVjIsqJHLgJG5ZR83GK+k8CP9bWR62gC1u2mXYmTgA=;
	h=From:Subject:Date:Message-Id:To:Cc:From:To:Cc:Date:Subject:
	 Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=Rw4NzZ5U0KiVEWfglHXB47uf9rabapqN+YGP+toka2q34GYgZScrA1Dv3LHGXXVXe
	 tuQGlpUBOJ+rGlmrWvck3aHGVtLPM7sCVMCjMFWjylD1Wvga65q78gviyuMi0QfNhm
	 /noOViiNZioOVYajSe+f+BMhrZkh1TcKakBSCVKasnJRUwOoJkZJ8f0XnMrcFaX83t
	 Tg/stcR4NYYaX5fIu1tFJE3cky03cEeQldfP50SYKWKlM2Ckp+0ADp5vHMjJGl2HSy
	 EuSKkzVNQWJ2GXqOOPS+omdEXJ9oGB9zimJr7uCw+54DtjqnhxUeOR8F5eyXKUAH1I
	 Br/cmd004AIbg==
X-Pm-Submission-Id: 4hFMKg2nwrz1DFF2
From: Esben Haabendal <esben@geanix.com>
Subject: [PATCH v3 0/4] io: accel: mma8452: Allow open drain interrupt pin
 configuration
Date: Wed, 05 Aug 2026 09:21:34 +0200
Message-Id: <20260805-mma8452-open-drain-v3-0-6149f406a409@geanix.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4XNQQ6DIBCF4asY1qUBZES76j2aLhBQZyEYaIiN8
 e5Fd02adPm/ZL7ZSHIRXSK3aiPRZUwYfIn6UhEzaT86irY0EUwAk4zTedatBEHD4jy1UaOnLQe
 ljOS1AkPK4RLdgOuJPp6lJ0yvEN/nj8yP9eAapjj84jKnjPbcWqGlZKZh99Fpj+vVhJkcXhb/D
 VGMDnrXDTBI1cGXse/7B+xar6j5AAAA
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
 Joshua Crofts <joshua.crofts1@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785914502; l=2339;
 i=esben@geanix.com; s=20240523; h=from:subject:message-id;
 bh=yRGJz5Ns5hgNujExrbtlKUm19YHk5OPVvmy6zVCRj5o=;
 b=yhw4BKXPQiryFwRHIOLRU5Y4kIXXtXltWvCj7yDwEmHNjFHK9a3kH/HEGbcQhGefMHXzPW1at
 YlOvmABxFLmA0rYvip2ILftUCnG2A6tCDVUjwcv4C5aDOFLLv6NsaIz
X-Developer-Key: i=esben@geanix.com; a=ed25519;
 pk=PbXoezm+CERhtgVeF/QAgXtEzSkDIahcWfC7RIXNdEk=

Extend the mma8452 driver with support for configuration of the
interrupt line in open-drain mode, which is needed for hardware designs
where the interrupt line is shared with other chips.

Adding drive-open-drain property to mma8452 device-tree node for such
designs to enable switching pin configuration to open-drain mode.

Signed-off-by: Esben Haabendal <esben@geanix.com>
---
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
Esben Haabendal (4):
      dt-bindings: iio: accel: mma8452: Add drive-open-drain
      iio: accel: mma8452: Optimize struct mm8452_data member orders
      iio: accel: mma8452: Only apply trigger type when not set by firmware
      iio: accel: mma8452: Allow open drain interrupt pin configuration

 .../devicetree/bindings/iio/accel/fsl,mma8452.yaml |  6 +++
 drivers/iio/accel/mma8452.c                        | 44 +++++++++++++++++++---
 2 files changed, 45 insertions(+), 5 deletions(-)
---
base-commit: 075b74841bd0065a3bda3440873c747938e69b68
change-id: 20250401-mma8452-open-drain-81577c41375c

Best regards,
--  
Esben Haabendal <esben@geanix.com>

