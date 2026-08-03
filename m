Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2872426430
	for <linux-iio@vger.kernel.org>; Mon,  3 Aug 2026 17:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785778350; cv=none; b=oJ+kXGcHET1CflWonP8njhfawk+gBhB1QBbB6MQVahXhbQtdR/PH//T5AUDqniK83r9WKB6maVb1JtAZM9xUQUxxHFe4gJkGHyru6C6a0HHxcoUknwoSJlsIkBtaAxRJzfxMqRnP+XpH07DorwNdpkvtFIhUeGr/Vba5GdI5DbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785778350; c=relaxed/simple;
	bh=kEbL+PF96qvU+PFw5p131+6PIGTXF+X5TaoUcCGvk4E=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=DoD1ZkAp3CfCTpjugMPvxDXNdYmsJatD10Lb4PAZVjLK6wdX/WraOixU6GaIiSDaS3Ij5f0DLopDDo9Xl0fn3X7/+Uut11thMIFW/RM7yGHER7yUmU0/Mod7zQI7lHMGkccA7AJU4d4zKCSPNrXYoz8eVpLFtbIkAZ6w1d5+P/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sB5Rdfw5; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sB5Rdfw5"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-490cf322ed0so13267875e9.1
        for <linux-iio@vger.kernel.org>; Mon, 03 Aug 2026 10:32:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785778347; x=1786383147; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=OD/ypQ31fdaW5XOFMD2EU4x+H9hiOoxJr9FGKaxkja8=;
        b=sB5Rdfw5KEhB0ROuKOS2XbgSdz3dI7yoPCC+mtzCj22lqZ1M/mex3KS4vWEKxrJceX
         YOsbZ2hU04+GOKt4gk2o/s7CD6RNVvvpDIG7pZE2wEm7CbBidUHZbY3GigMItSTUxKyH
         x5T7fXKw5ocpx6kuFns24IuBKzaJQCa2VDSvY5OD1pKkUSl+8EJfYO6almNG9Wo7K35T
         2zBx1XyIDHQ2+GjZGVHQmGVA1voybzGzjM8b3Yz6lVlRAl7Brf6giXJd1MVJKBoXeHci
         680kCM/LehfO47kRAKxA4JXYaon8yGsnDDGB8gCL472TvBptMyaI8E3eYzWZHf2u7vck
         yRWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785778347; x=1786383147;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=OD/ypQ31fdaW5XOFMD2EU4x+H9hiOoxJr9FGKaxkja8=;
        b=kbeTsaQTlk4QhD1uXOPqOYNwMgfKDrnYELx6P604vJMTAgV8NBLmycmftL0hvUBP/r
         JdTGoiJ+QbvoutJzSChI4yJSenu3UcrvxD0J7Vmz5S4BeuIrxsBf04RLP+sFdUdpQL6D
         Kmuu4Q6nSd6HC4z0s3Aag4FNE9EJ/yfuox58MLBF8+mADeW59NVhK422/qLwefquEK4B
         o7TQtM9m66GDWLoUOLr02i+9mzSGCbAZy/+DVxqOVZeaz3za2F/N3+QJfrzP/kJoIzq6
         67pZHVyU8fuvgXzGIUXbpaf+AZXX37H5XYVsD9yEj8AWvjTNKqeWuAnEk/8evnLeXmb/
         h/1Q==
X-Gm-Message-State: AOJu0YzUlA6zvFi3P/j5yTJv7lSAVee7+qBRsWHS7KIwa1falrktZzt9
	d8e2O9KELajsM5cnaVySfqJ54mgvmjBXLZNv40S4f3B8w58ewJi6e8GC
X-Gm-Gg: AR+sD12STb6xYsK66PAJ3k6Tr7gd9L38WYD+Zc62rtUSKrLFrObbuJdjzrCo0oAAehv
	XYZLwZj3POQRHjL0olqWLQSGm3sJCfJpBB7jB4AknU9rfG7DkbDSQGcNGUryLBfUrC1uhiNgHIj
	deEFmjNxDYBmq5XWZiZgkM2Cg8Q+XGTRRRdL/mirI8Jw/8c+iuv/k7tLeDWjadl1qo8SbXNZ8nk
	d57iolb1CVyyhLIShUbr3Oj5ktkT1rERt4JGgirkqjJ4RZ1/7vWVbsTKEdnEFBNFJDgxidextYJ
	e7Pr2myaqL0bWUM4D67iqXrXhOrioIKvve3POBix37VQFc8c9m/lbdtCXhPSlFfpS9smmJWyE2f
	/qWCO86dSUfCpoU2GSDOiIixZ0402TNch7miMGxRYlmczcsohJHebNA/EFKKzhulOk/0+7jBF87
	gKMxlwkuBWeJ8kIDdGGdSNYpjCYwNp8JBkLxUSWX18KKAcmkBvZV4d5movQ5OYn9rDB3hbIt1Xr
	pGHsV+QYs9SErpZDvWWc5ZlN1RcPatlw9nA1QPMikO+Rgwb5Fq4UE6y+OPQqo6GGazUWoF+VOA6
	xVvrXXMQBk6GJQ9qrTDYnGpkH/L1MWSr+4nY2dbFo+nuU7ZHA9QZarWQ0XvNId/+cUH0inXVXjw
	yG1/csE6sN5foLr1ACZmhYi/7gQ==
X-Received: by 2002:a05:600c:4e90:b0:495:7426:c392 with SMTP id 5b1f17b1804b1-4980eb4d5f9mr202655005e9.1.1785778346922;
        Mon, 03 Aug 2026 10:32:26 -0700 (PDT)
Received: from [192.168.1.187] ([2a02:8308:4092:11f0::f9f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49808199a68sm176259975e9.4.2026.08.03.10.32.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 10:32:26 -0700 (PDT)
From: Joshua Crofts <joshua.crofts1@gmail.com>
Subject: [PATCH v3 0/2] iio: dac: mcp47a1: add support for new device
Date: Mon, 03 Aug 2026 19:32:24 +0200
Message-Id: <20260803-mcp47a1-add-support-v3-0-540e71b4fd2e@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/23NTQ6CMBCG4auQrq3p9IeqK+9hXEzaAk0EmhYbD
 eHuFuKCBcv3S+aZmSQXvUvkVs0kuuyTH4cS4lQR0+HQOuptacIZr5kGoL0JUiNQtJamdwhjnKj
 ABri8NCBQkXIZomv8Z1Mfz9KdT9MYv9uTDOv69/ixl4EyapFJhVzV2ol726N/nc3Yk9XLfG/oY
 4OvhlRXQG5cfXV7Y1mWH/ynydv6AAAA
X-Change-ID: 20260711-mcp47a1-add-support-3af1248f13a5
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Joshua Crofts <joshua.crofts1@gmail.com>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785778346; l=2319;
 i=joshua.crofts1@gmail.com; s=20260530; h=from:subject:message-id;
 bh=kEbL+PF96qvU+PFw5p131+6PIGTXF+X5TaoUcCGvk4E=;
 b=STWGByyIUrA8jSOHoabbM1n9MJeox0XVXQznoFX7AbLi0tYM5UMvBb3MkUO0J02dYrdlPwn5d
 GV9Uq1kz87xBIgWYFBEDVvaRvbtwjlGte1p5AjzwHI9V4bZqx9DmlnZ
X-Developer-Key: i=joshua.crofts1@gmail.com; a=ed25519;
 pk=RTDOoVwgeL4oFdASj9U+cxJuIjXuXk73zkjnGOJKbEo=

This patch series adds support for the MCP47A1 DAC.

The Microchip MCP47A1 is a volatile 6-bit Digital-to-Analog converter
which communicates via I2C. It is a low-power, low-cost DAC commonly
used in embedded systems.

Reasons for adding a new driver:
- Existing Microchip DACs use a more complicated set of commands
  whereas the MCP47A1 communicates via SMBus using only one command.
- The closest Microchip DAC already in the tree - the MCP4725 - uses
  an EEPROM while the MCP47A1 is volatile, meaning that altering
  the driver of the former would worsen the code flow.
- The MCP47A1 maps cleanly to a standard regmap.

The driver was tested on a Raspberry Pi 4 using a breakout board with
the MCP47A1.

The datasheet can be viewed here:
https://ww1.microchip.com/downloads/aemDocuments/documents/OTH/ProductDocuments/DataSheets/25154A.pdf

Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
---
Changes in v3:
- remove iio_chan_spec array and define a separate single channel as
  only one is used
- change scale denominator from 63 to 64 as former would produce scaling
  errors
- Link to v2: https://lore.kernel.org/r/20260727-mcp47a1-add-support-v2-0-d4591a2ce69e@gmail.com

Changes in v2:
- dt-bindings: add slave address enum to dt-binding
- dt-bindings: remove unnecessary example
- move driver from regmap to i2c_smbus_* functions to reduce overhead
- remove read test on probe as it's too unstable
- add 20us delay on startup
- style changes
- remove excess mailing list entry from MAINTAINERS
- Link to v1: https://lore.kernel.org/r/20260721-mcp47a1-add-support-v1-0-da045a2567e3@gmail.com

---
Joshua Crofts (2):
      dt-bindings: iio: dac: add support for mcp47a1
      iio: dac: mcp47a1: add support for new device

 .../bindings/iio/dac/microchip,mcp47a1.yaml        |  50 +++++++
 MAINTAINERS                                        |   6 +
 drivers/iio/dac/Kconfig                            |  10 ++
 drivers/iio/dac/Makefile                           |   1 +
 drivers/iio/dac/mcp47a1.c                          | 166 +++++++++++++++++++++
 5 files changed, 233 insertions(+)
---
base-commit: e0484d62e8e1cff75b210938be835ea6221bda59
change-id: 20260711-mcp47a1-add-support-3af1248f13a5

Best regards,
-- 
Kind regards,
Joshua Crofts

