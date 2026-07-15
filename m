Received: from mail-244106.protonmail.ch (mail-244106.protonmail.ch [109.224.244.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA1A942BC4B
	for <linux-iio@vger.kernel.org>; Wed, 15 Jul 2026 12:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784118818; cv=none; b=pRlsaxpC05HhHuLqIDwtgaHgy+NVHC1oHI+mL1KdhlJxbh8m2jYc4T/nF/UMNsBDMRCOo+zpPdDHxe0mh2VXtbvuHa8tXHaKbZmSlxbKnnwqrQtFK4/T7AZswhhW0l5ZBRVlrEM6kAgMK15kfOm1o3zpI6hY/TFVgX66gstd3Gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784118818; c=relaxed/simple;
	bh=qG3Ue0S1FKxy2vdyUX3YqpYFsnFnY2kugwsKFAUKAIA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=YXgOJi63L5w8BwgVbO0h+TO7xByCxVHcpXCftyNIJMf2s+EsnL1WpXGnHsF/bYQxuXvjUp8OjO0bGWarKdAwx+1zA1K3kk4wuKY/yorz0KNsnK5AHFrHhusVuToS0QKERbg27Gb5qNLO/bO4/4Xt8TEsVhbOvsxznvKKViCLImU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=QF1bh6ZR; arc=none smtp.client-ip=109.224.244.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="QF1bh6ZR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail3; t=1784118814; x=1784378014;
	bh=5J7JYYHHFNVk41nCvp3IxlyKwZwhxolSSSPevsAkazY=;
	h=From:Subject:Date:Message-Id:To:Cc:From:To:Cc:Date:Subject:
	 Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=QF1bh6ZRL6FIb778YiqGn4sflZoc+fwFkATkUUMtQr1arwb5P+SItHR5lk9k7Pod+
	 O3ppsfsnQyq63cakaXlz/WQqIJJlBJtKeiV+81kwAkDMIvojuwPsIxvBuQSnczBlap
	 BmfYo6dN4s8WoYecCl8UfDtql2V83Kr0yg2fkne1FBgxQmaZjhrVQppICxqFqSYXdc
	 aPBs5aqsi1be1lY6rBSES+TdYbeLBwmjmeNgYA5hjm/Y3QK455MogQgzjtncG9Khjx
	 ESz+g7gsiEA06JUGZ286brHbALyGPi0lJ9LrvMf2uR0hBFlyxbyWiJTJYuJtIWegpj
	 5XPPJP64WnX7g==
X-Pm-Submission-Id: 4h0bF75nYHz1DFDy
From: Esben Haabendal <esben@geanix.com>
Subject: [PATCH v2 0/3] io: accel: mma8452: Allow open drain interrupt pin
 configuration
Date: Wed, 15 Jul 2026 14:33:26 +0200
Message-Id: <20260715-mma8452-open-drain-v2-0-95be9f5f4795@geanix.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/22NQQ6DIBBFr2JYdxqGgpiueo/GBYWpzkIw0Bgb4
 92Lrrt8L/nvb6JQZiri3mwi08KFU6ygLo3wo4sDAYfKQkllpJYI0+Q6bRSkmSKE7DhCh8Zar/F
 mjRd1OGd683pGn33lkcsn5e/5seBhj1wrLZp/uQVBwgtDUE5r6Vv5GMhFXq8+TaLf9/0Hv99YG
 bUAAAA=
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
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784118811; l=1965;
 i=esben@geanix.com; s=20240523; h=from:subject:message-id;
 bh=qG3Ue0S1FKxy2vdyUX3YqpYFsnFnY2kugwsKFAUKAIA=;
 b=4UCvtVcNEYzhyQPX0R+eSf08mi3S0yQX7bVSNJsvYIbkU75oh3hIesHANUsfREk84qrvyouaP
 XmecA7j5WF5Cp6GVJgVfYm2qEJ8rCItlJOK/ehjPktaphlXluEGtY8G
X-Developer-Key: i=esben@geanix.com; a=ed25519;
 pk=PbXoezm+CERhtgVeF/QAgXtEzSkDIahcWfC7RIXNdEk=

Extend the mma8452 driver with support for configuration of the
interrupt line in open-drain mode, which is needed for hardware designs
where the interrupt line is shared with other chips.

Adding drive-open-drain property to mma8452 device-tree node for such
designs to enable switching pin configuration to open-drain mode.

Signed-off-by: Esben Haabendal <esben@geanix.com>
---
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
Esben Haabendal (3):
      dt-bindings: iio: accel: mma8452: Add drive-open-drain
      iio: accel: mma8452: Allow open drain interrupt pin configuration
      iio: accel: mma8452: Optimize struct mm8452_data member orders

 .../devicetree/bindings/iio/accel/fsl,mma8452.yaml |  6 ++++
 drivers/iio/accel/mma8452.c                        | 38 +++++++++++++++++++---
 2 files changed, 40 insertions(+), 4 deletions(-)
---
base-commit: a13c140cc289c0b7b3770bce5b3ad42ab35074aa
change-id: 20250401-mma8452-open-drain-81577c41375c

Best regards,
--  
Esben Haabendal <esben@geanix.com>

