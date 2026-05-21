Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3856385D9E;
	Thu, 21 May 2026 10:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779359451; cv=none; b=TMYXWGWkM9BbBXhvOc6DkGuRxdv2N0DbWatzhZlsw7PcHP+/UVdsNrIv1UQMjR22MmCm10C7ZH8Nck6TfV70IkDPBiO49/G2hrpV1aennimnRFx8AjVyAY/R/XBw9F7PMfvxDwmXn0BwQuDHwkvz61lgoEC0htyG0vDTUiRqADA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779359451; c=relaxed/simple;
	bh=WHETLfz1GD2FrydRzvs6kR2wwNije8siVJQHmOWSbok=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=uPGXPEqM+5y7UKXaTkh96Md/G0wjC56651Cu7mJtWfxJRCWeCuRdWRGSfkDmP3ILjybeokesDc36z7c1Xfhe5rkFt2PCV6T5B8drHi+b3vhrT2M0K0Fr4+kXNt3MrRr42ZHEYejvFKoKWVvAMVNnitdATW8Msqk8huOx2JAi87k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PDTO5nJm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PDTO5nJm"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 84C8EC2BCB7;
	Thu, 21 May 2026 10:30:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779359450;
	bh=WHETLfz1GD2FrydRzvs6kR2wwNije8siVJQHmOWSbok=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=PDTO5nJm5xxBHHJquwo4QZ7ElX+0ftDi+3YCNBX+QBrAs4tofwtf7KmvzVyfJMcd9
	 uSytGri6DzcVkS+bzqth6VmF1QG3LnBtnbd8xZiQ3OG+eFhigdxk3DDzfQjgWZnNOZ
	 jXk67XJxNIjyK8DdYyarj849gDuVbH5v+zgy3iJxJdWou7PGzncdSmAzSVP+IdjitR
	 LCbNss8wXSvVA6qhUsMJM5Tfhmn4zhGQ/LG7Z0DnkdsC9QP9caNi2qesz/luPGZZRq
	 tV5tRp0uE6zjpO5I0zuqk7uPZ9zhiPoQ9tYTScNB8LLrz5pZO3IVN6fGzCDoZzHFv2
	 EAyiG5BBn88zg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79F52CD5BA4;
	Thu, 21 May 2026 10:30:50 +0000 (UTC)
From: Radu Sabau via B4 Relay <devnull+radu.sabau.analog.com@kernel.org>
Subject: [PATCH v4 0/2] iio: adc: ad_sigma_delta: fix CS assertion and
 registerless device handling
Date: Thu, 21 May 2026 13:30:47 +0300
Message-Id: <20260521-ad_sigma_delta-fix-v4-0-bfb3df3e36da@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIANfeDmoC/33OywqDMBAF0F+RrJuSTDSNXfU/SpE8Rg34KEakR
 fz3RjdtqXR5L8y5M5OAg8dAzslMBpx88H0XQ3pIiK11VyH1LmYCDCRLQVHtiuCrVhcOm1HT0j+
 oMTJzmbTWGEbi4X3AWG/o9RZz7cPYD89tY+Jr+5ebOOVUoShzyBCVg4vudNNXR9u3ZPUmeBsZO
 +0aEA20SqJhqRTG/Rjiw+D7fwjKqAadg2FWyFJ8GcuyvAAGbUSePQEAAA==
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779359448; l=3723;
 i=radu.sabau@analog.com; s=20260220; h=from:subject:message-id;
 bh=WHETLfz1GD2FrydRzvs6kR2wwNije8siVJQHmOWSbok=;
 b=yCCLyvx34MwZMqa+i+HYqJhAURyWVNeGgTvn7b3GtORAL202pvkrXrwNFiTud3Aup646RVXNZ
 oQEl84LY1ksCyFihXyKVQBJdx6m1RXKAWFRA5q1W4Y7lcCyarb+04Te
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
has_registers = false and no rdy_gpiod (currently MAX11205 and AD7191).
These devices fall through to the status register read path, but since
has_registers is false, ad_sd_read_reg() transmits no address byte and
blindly clocks raw MISO bytes — indistinguishable from reading conversion
data, partially consuming any pending result and corrupting the stream.
With num_resetclks = 0 on these devices a further hazard exists: if
pending_event is set, the drain path attempts memset of SIZE_MAX bytes,
corrupting the heap. The same heap corruption can be triggered on any
device with rdy_gpiod set but num_resetclks = 0, so an explicit
data_read_len == 0 guard is added independently of the register check.

Signed-off-by: Radu Sabau <radu.sabau@analog.com>
---
Changes in v4:
- set_mode(AD_SD_MODE_IDLE) was accidentally placed in patch 2
  in v3; moved to the correct commit via rebase.
- add data_read_len == 0 guard to cover the heap corruption path
  reachable via rdy_gpiod on devices with num_resetclks = 0;
  set_mode(AD_SD_MODE_IDLE) moved to patch 1.

- Link to v3: https://lore.kernel.org/r/20260518-ad_sigma_delta-fix-v3-0-a2a92b0c36f3@analog.com

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

 drivers/iio/adc/ad_sigma_delta.c | 29 ++++++++++++++++++++++++-----
 1 file changed, 24 insertions(+), 5 deletions(-)
---
base-commit: 3b3bea6d4b9c162f9e555905d96b8c1da67ecd5b
change-id: 20260428-ad_sigma_delta-fix-bb65d56ccbb0

Best regards,
-- 
Radu Sabau <radu.sabau@analog.com>


