Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0547319852;
	Mon, 18 May 2026 09:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779098345; cv=none; b=L8hAqsP3Au953yHBwR1OQ36lV/Ps66+yG3P+stKrsIqREFHO3MuBlWDMJh2fpZiWA6b8wBQ/ieV1LrVDfyWhraF39G3sCXKiCUDThrhfqeEhvxgjFRybYBWVoIuSvCdvzoolv8u3uEtEFBQEdJwjAM/bmdReBBfrBuh60Uk6dQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779098345; c=relaxed/simple;
	bh=DSaajmpquMdWug+5XgJ0uEvr2MyUnhHVtRvFSwEkPa0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=SpiFFeXq+L2l7t9f9rj8lMAztK+3woJ93EyIF/qIXXzXvmT/tw4wrZtltz96GOh6EJ399ad9Wgrhi4e449eHCESETCxFr0EpZNtp9mGmdDtpOxGSCtiUSrvKNhBmBIBEptIzbgYdF5XRjLUYx9mGqbH6gpn1FqyXHRUsWOCoULo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MaY4K0Z5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MaY4K0Z5"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6F609C2BCC9;
	Mon, 18 May 2026 09:59:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779098344;
	bh=DSaajmpquMdWug+5XgJ0uEvr2MyUnhHVtRvFSwEkPa0=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=MaY4K0Z5gqRLttY8PQSXLzew1dtl6cxPgeijBkh3LvuWq2NC8yJhy/ROpcrwZnr3t
	 zsYuIRLVPvYJ+Eync3r4nV4OR6ngvFOG5AEpAyP41nne1z1pWAf3utn5M9RRAehO5D
	 GeSp0vmXTWU6oqLwEOD7nHZ56fSobJNXZKHYXqbOi0A2372InuBDsyqh7AAU9GMV1b
	 dHfTC+DrcYkeSj14Ehry8bA4ypB1qVrBcYJ/mi9kMaZLhWHhK/Eyf7zfpHW9HS22gF
	 L2wfYXO5yoX6qksdIpp3bKNjyPRBS1yax7eyjrj5y2TkH/d76ZbXxq2CPonVFmJ6MS
	 fvtvkW4o+i2Tw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58EBCCD4F49;
	Mon, 18 May 2026 09:59:04 +0000 (UTC)
From: Radu Sabau via B4 Relay <devnull+radu.sabau.analog.com@kernel.org>
Subject: [PATCH v3 0/2] iio: adc: ad_sigma_delta: fix CS assertion and
 registerless device handling
Date: Mon, 18 May 2026 12:59:02 +0300
Message-Id: <20260518-ad_sigma_delta-fix-v3-0-a2a92b0c36f3@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAObiCmoC/33N3wqCMBTH8VeRXbeYR7dWV71HhOzPUQfqYpNRi
 O/e9CaC6PL7g/M5C4kYHEZyKRYSMLno/JSjOhTE9GrqkDqbmwADwWqQVNkmum5UjcVhVrR1T6q
 14JYLY7RmJB8+AuZ5R2/33L2Lsw+v/Ucqt/Uvl0paUolVewaOKC1c1aQG3x2NH8nmJfgYnJ1+G
 pANNFKgZrWotP0y1nV9A1Jqawf5AAAA
X-Change-ID: 20260428-ad_sigma_delta-fix-bb65d56ccbb0
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Radu Sabau <radu.sabau@analog.com>, Jonathan Cameron <jic23@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779098343; l=3282;
 i=radu.sabau@analog.com; s=20260220; h=from:subject:message-id;
 bh=DSaajmpquMdWug+5XgJ0uEvr2MyUnhHVtRvFSwEkPa0=;
 b=z/NgperCxQu+I0TpVeFbdX8q2EgytXH2MAcy6KLtkw/w3ZHdgH8G6SF1O9APUxe4KQ31kkMC4
 uio3XPhZFp6AjRgxAUmKXmy2qeiHUqTeYxBCYelljluyMIeVoIpF0pK
X-Developer-Key: i=radu.sabau@analog.com; a=ed25519;
 pk=lDPQHgn9jTdt0vo58Na9lLxLaE2mb330if71Cn+EvFU=
X-Endpoint-Received: by B4 Relay for radu.sabau@analog.com/20260220 with
 auth_id=642
X-Original-From: Radu Sabau <radu.sabau@analog.com>
Reply-To: radu.sabau@analog.com

This series fixes two independent bugs in the ad_sigma_delta framework.

Patch 1 fixes CS being left permanently asserted after single conversion
and in the error path of ad_sd_buffer_postenable(). In
ad_sigma_delta_single_conversion(), set_mode(AD_SD_MODE_IDLE) and
disable_one() were executing while keep_cs_asserted was still true,
causing any SPI transfer they issued to carry cs_change=1. The
postenable() error path also failed to call set_mode(AD_SD_MODE_IDLE),
leaving the device in continuous conversion mode with bus_locked
incorrectly set, opening a window for concurrent SPI access.

Patch 2 fixes ad_sigma_delta_clear_pending_event() for devices with
has_registers = false and no rdy_gpiod (currently MAX11205, AD7191, AD7780).
These devices fall through to the status register read path, but since
has_registers is false, ad_sd_read_reg() transmits no address byte and
blindly clocks raw MISO bytes — indistinguishable from reading conversion
data. This partially consumes any pending conversion result, corrupting
the data stream. With num_resetclks = 0 on these devices a further bug
triggers: if the clocked byte has bit 7 clear, a SIZE_MAX memset corrupts
the heap. The fix returns 0 immediately for such devices, relying on
IRQ_DISABLE_UNLAZY to latch any pending edge so it fires cleanly on the
next ad_sd_enable_irq() call.

Signed-off-by: Radu Sabau <radu.sabau@analog.com>
---
Changes in v3:
- add ad_sigma_delta_set_mode(AD_SD_MODE_IDLE) to the err_unlock
  path in ad_sd_buffer_postenable() to revert the device
  from continuous mode and deassert CS; previously only the flag resets
  were added. Update commit message to remove the inaccurate "in all
  cases" claim and note that CS-less devices such as MAX11205 are
  unaffected since no physical line is toggled.
- Patch 2: new patch fixing ad_sigma_delta_clear_pending_event() for
  devices with has_registers = false and no rdy_gpiod, where the
  existing status register read path blindly clocks raw MISO bytes,
  partially consuming pending conversion data and potentially
  corrupting the heap via a SIZE_MAX memset.
- Link to v2: https://lore.kernel.org/r/20260507-ad_sigma_delta-fix-v2-1-ec86eb0463bd@analog.com

Changes in v2:
- Move set_mode(AD_SD_MODE_IDLE) into out_unlock: as well, not only
  disable_one(); v1 left set_mode() above the label where
  keep_cs_asserted is still true, so devices without the optional
  disable_one callback still had CS stuck after that transfer.
- Fix pre-existing state leak in ad_sd_buffer_postenable() err_unlock:
  reset bus_locked and keep_cs_asserted before spi_bus_unlock() to
  prevent spi_sync_locked() being called on an unlocked controller.
- Link to v1: https://lore.kernel.org/r/20260428-ad_sigma_delta-fix-v1-1-8e3f925ee8d2@analog.com

---
Radu Sabau (2):
      iio: adc: ad_sigma_delta: fix CS held asserted and state leaks
      iio: adc: ad_sigma_delta: fix clear_pending_event for registerless devices

 drivers/iio/adc/ad_sigma_delta.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)
---
base-commit: 3b3bea6d4b9c162f9e555905d96b8c1da67ecd5b
change-id: 20260428-ad_sigma_delta-fix-bb65d56ccbb0

Best regards,
-- 
Radu Sabau <radu.sabau@analog.com>


