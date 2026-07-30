Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3938431A5C;
	Thu, 30 Jul 2026 14:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785421575; cv=none; b=Ye8fCB54d1qwi105re+6j0Hc/2fIy8oZaUOSEvWDutNxXk6wqv+9n5seAzvG4cIE9Ygtdxop+SNQzMklZq5hrqhlsxWKhFsIeAjuUWc/+4zho9dDUbN26Y2sjw1wa5WPSPFdCscIcKsxLAJFCs75nmC50OxoLiLNA2XxrT0U2dU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785421575; c=relaxed/simple;
	bh=FggnBymRb4haQym8k0HHiE2dxeAdRgistr/Jl5SaWE4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=bx302/E4xi+AkALML0grKYOX9oZru7GBELdDjjyMtKUkt4P18YeGBS5ushBVp1dDmNnwoVzxVc0jcCj9XEgBbdvhNqZ7+UdlZY7XpqCJWsirbhwfk8YtOWmJpS6/hTXNsmlC4Gtqyd8BUEFJEj9SgHEmF1zovCDAhNzsN5mIWu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DEWkTwWZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DEWkTwWZ"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7E066C2BCF4;
	Thu, 30 Jul 2026 14:26:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1785421574;
	bh=FggnBymRb4haQym8k0HHiE2dxeAdRgistr/Jl5SaWE4=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=DEWkTwWZIAX8IgLRE2Jig4RkSj1ExHiEyO5uToAu2emB3Vz49n1/yqAAV2JH4iuFR
	 Z6FU7Rl8nTfAmADPUWT7PCT/1OJJcjH+Xrp9uHz4x7bwT7tk8RGtGzQyfK7EZDjyWY
	 tXIUo77BPbapHDOFwTqYBjJ5brGLdaclvkXfe0DMu3ii+8WQHX1v6YNSbJx7UEV0ps
	 De1XvwAHt5q2mn918I+m/I4HHq8YpkotpEwt2nrGsXP9qew/FHt+24dyxFLT90V5mg
	 +rgf0Lt0Pj1mq22eqzsEsCHEGtDd8lIJtJX/eS6Q59Y0o2y2bkmrK2PxN2bnTZE4ks
	 s13uuXNkiO8eg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 580B8C55160;
	Thu, 30 Jul 2026 14:26:14 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Subject: [PATCH 0/9] dmaengine: Support bus widths of 32 bytes and above
Date: Thu, 30 Jul 2026 15:23:07 +0100
Message-Id: <20260730-dmaengine-support-wider-dma-masks-v1-0-3732f1f9d9ca@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/42OwQ6CMBBEf4X07BpaBdST/2E4LO0KVWlJF1BD+
 HcpxrvHN5nMm0kwBUssTskkAo2WrXcLyE0idIOuJrBmYaFSlae5zMC0SK62joCHrvOhh6c1FGI
 OLfKdIUPUUu2PBalCLDtdoKt9rY5L+WUeqhvpPg7HRmO59+G9nhhl7P18+R++UUIKBtUOD0ZXR
 Zaf0eHD11vtW1HO8/wBs75BbuUAAAA=
X-Change-ID: 20260615-dmaengine-support-wider-dma-masks-5aac12497e27
To: dmaengine@vger.kernel.org, linux-iio@vger.kernel.org
Cc: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785421644; l=3184;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=FggnBymRb4haQym8k0HHiE2dxeAdRgistr/Jl5SaWE4=;
 b=pvZS7Tfn264VwmOfLF8KzA6XiEXFuJMG0WjPuN+CP8mWmgYTr1A3uhwN6evAz9IdHsfqU6gTG
 AGzEZF8S8YwDds24acRajD+rIGIsQu8/9960smtefVehMW4RxvfmV4x
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received: by B4 Relay for nuno.sa@analog.com/20231116 with
 auth_id=100
X-Original-From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Reply-To: nuno.sa@analog.com

The DMA engine slave capabilities advertise the supported source and
destination bus widths through src_addr_widths / dst_addr_widths. These
are plain u32 bitmasks where a set bit's position equals the
corresponding enum dma_slave_buswidth value, e.g.
DMA_SLAVE_BUSWIDTH_4_BYTES sets bit 4.

The consequence is that widths of 32 bytes and above cannot be
represented at all: DMA_SLAVE_BUSWIDTH_32/64/128_BYTES would need bits
32, 64 and 128, which do not fit in a u32. Hardware with wider data
paths is becoming common, so add a representation that can express these
widths while still using enum dma_slave_buswidth.

This series switches consumers and a small set of producers to bitmap
based bus width capabilities. The legacy dma_device u32 fields are kept
for now so the remaining DMA controller drivers can be converted
incrementally. dma_get_slave_caps() folds legacy producer masks into the
new bitmap representation returned to consumers.

Once the remaining producers are converted, the legacy dma_device
src/dst_addr_widths fields can be removed as a final cleanup.

This issue was discussed before here:

https://lore.kernel.org/dmaengine/abkoXXbaxaiqbBuX@vaman/

---
Changes in v1:
- Drop RFC tag.
- Rename the new capability representation and helpers from address
  width terminology to bus width terminology.
- Convert all current dma_get_slave_caps() consumers that used the
  legacy src/dst_addr_widths fields.
- Convert a small set of DMA controller producers and the stm32-dma3
  per-channel capability callback.
- Add helper documentation for the new public API.
- Link to RFC: https://lore.kernel.org/dmaengine/20260616-dmaengine-support-wider-dma-masks-v1-0-da23a8dcb756@analog.com/

---
Nuno Sá (9):
      dmaengine: Support bus widths of 32 bytes and above
      dmaengine: dma-axi-dmac: Use bus width capability helpers
      dmaengine: dw-axi-dmac: Use bus width capability helpers
      dmaengine: qcom: gpi: Use bus width capability helpers
      dmaengine: stm32-dma3: Use bus width capability helpers
      iio: buffer-dmaengine: Use dma_slave_caps bus width accessors
      ALSA: pcm_dmaengine: Use dma_slave_caps bus width helpers
      spi: dw: Use dma_slave_caps bus width helpers
      dmaengine: Drop legacy bus width fields from dma_slave_caps

 drivers/dma/dma-axi-dmac.c                         |  13 +-
 drivers/dma/dmaengine.c                            |  20 +-
 drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c     |  39 ++--
 drivers/dma/qcom/gpi.c                             |  11 +-
 drivers/dma/stm32/stm32-dma3.c                     |  32 +--
 drivers/iio/buffer/industrialio-buffer-dmaengine.c |  15 +-
 drivers/spi/spi-dw-dma.c                           |   6 +-
 drivers/spi/spi-dw.h                               |   3 +-
 include/linux/dmaengine.h                          | 234 ++++++++++++++++++++-
 sound/core/pcm_dmaengine.c                         |  14 +-
 10 files changed, 323 insertions(+), 64 deletions(-)
---
base-commit: 7524fe142b5a772f8421aeee2132cf7e21a00103
change-id: 20260615-dmaengine-support-wider-dma-masks-5aac12497e27
--

Thanks!
- Nuno Sá


