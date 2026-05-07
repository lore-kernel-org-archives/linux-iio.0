Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B49D13783D8;
	Thu,  7 May 2026 14:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778162439; cv=none; b=u3umoTvwRNOdpMD6U8ZuoKTdwPWaJpk2LNbREi9bGkm8m2tf4c23zgAF4Ea6Y2OKFkRMb0LH5kTIHsOllBbh3OYXqUpIF7NNfOp8GT5XG+ESz2etWH/HIvbwisdktgsBfqwg5sLxwoMar9L5A8yQZ/8C6cbJoPH7rCMpoxzekcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778162439; c=relaxed/simple;
	bh=UijPSaICq/ijkQIvcHjGA7W8g6G9O4mGFUQp/4gOA3w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=a3sLQec2EyAU1Q6nFzBksWdTzF5naEvCxjK3MaLxeGp4DE75FHGeeWdPQIZKBmy/CBgzGdCwA5anPl1Cgh2LmPTAHnSX+sQCgTVPS/3C9tjt/jYsYkK1nlQXi/kSigWzvwEo2czuYWlq2P/Q0nWUkvG+9zZKc3cbynO8eutN81c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HCPToQPC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HCPToQPC"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 62D7FC2BCB8;
	Thu,  7 May 2026 14:00:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778162439;
	bh=UijPSaICq/ijkQIvcHjGA7W8g6G9O4mGFUQp/4gOA3w=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=HCPToQPCIl7I5+yanrj7AL9g3bk+atKzb9bylfTlSHzyQJH7m5h3fzl6lqlumH3nq
	 4dMpM+4HePN3djtmuVO2yRpzqX22I/JDyQZIkHgI+OJ1/BH6suJJTrseZcKMknCOi/
	 Y50DAeKnUNxJubx+5LrEWURUMP/VVLmIPUGh2c+WBXJzFiVm6dZyEBUNXK/GiFAPVm
	 anV1NwKmAhe16tOdUel73xfUq2ofzF6x3q1rn8o1iKvkJ9O8S7pXUA0xwAjyZISImF
	 2zxHMWf3t270IpfUitebYMCE3p1HmB5MWFYFLzc7FYOKNkpnAL7RuM/xc07nV0F64G
	 skBsrFoPDwDGw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5032BCD343B;
	Thu,  7 May 2026 14:00:39 +0000 (UTC)
From: Radu Sabau via B4 Relay <devnull+radu.sabau.analog.com@kernel.org>
Date: Thu, 07 May 2026 17:00:38 +0300
Subject: [PATCH v2] iio: adc: ad_sigma_delta: fix CS held asserted after
 single conversion
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260507-ad_sigma_delta-fix-v2-1-ec86eb0463bd@analog.com>
X-B4-Tracking: v=1; b=H4sIAAWb/GkC/32NWwrCMBBFt1Lm20gSTah+uQ8pJY9pO9A2kpSgl
 Ozd2AX4eQ7cc3dIGAkT3JsdImZKFNYK8tSAm8w6IiNfGSSXml9ly4zvE42L6T3Om2EDvZm1Wnm
 lnbOWQx2+IlZ9RJ9d5YnSFuLn+MjiZ//msmCCtXgZblIhtl4+zGrmMJ5dWKArpXwBm8D7VLUAA
 AA=
X-Change-ID: 20260428-ad_sigma_delta-fix-bb65d56ccbb0
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jonathan Cameron <jic23@kernel.org>, Radu Sabau <radu.sabau@analog.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778162438; l=4300;
 i=radu.sabau@analog.com; s=20260220; h=from:subject:message-id;
 bh=/e0hEMIOR6U0Xas7CrcCNGcH0SKd8Y1VKGzMma43BAo=;
 b=9KVQbx4Z3pasaAkx4dtp91thk2b/HisX/vOnX2R8SJ3bITnApojoDn35p3fE+bPtbCDfbPQ7O
 c1L24h0LqpoDsFgZV6AhL/xWqhdEsvxfdt6EAmPN50iFxc6VyVe3jfG
X-Developer-Key: i=radu.sabau@analog.com; a=ed25519;
 pk=lDPQHgn9jTdt0vo58Na9lLxLaE2mb330if71Cn+EvFU=
X-Endpoint-Received: by B4 Relay for radu.sabau@analog.com/20260220 with
 auth_id=642
X-Original-From: Radu Sabau <radu.sabau@analog.com>
Reply-To: radu.sabau@analog.com

From: Radu Sabau <radu.sabau@analog.com>

Commit 132d44dc6966 ("iio: adc: ad_sigma_delta: Check for previous
ready signals") introduced a new out_unlock: label for an early-exit
path and moved sigma_delta->keep_cs_asserted = false there.
Unfortunately it left both ad_sigma_delta_set_mode(AD_SD_MODE_IDLE)
and ad_sigma_delta_disable_one() in the out: block above that label,
so both SPI writes are issued while keep_cs_asserted is still true.
keep_cs_asserted feeds directly into the cs_change field of the
spi_transfer, so the final write to the device carries cs_change=1.
The SPI framework only calls spi_set_cs() to deassert CS as part of
message teardown when cs_change is not set on the last transfer; with
cs_change=1, that teardown is skipped and CS stays physically asserted.
No further transfer to the device is made, so the driver never
deasserts CS.  The framework provides no automatic CS deassert on bus
unlock or when switching to another device, so CS remains stuck low
until the next SPI operation to that same device.

On a shared SPI bus this is problematic: with CS stuck low the ADC
remains selected and subsequent SPI traffic intended for another device
is interpreted as commands by the ADC.  Devices like the AD7124 that
multiplex /RDY onto the MISO line will start spurious conversions and
pull MISO low, corrupting reads from the other device and causing a
deadlock.

Fix both calls by moving them into the out_unlock: block, after
keep_cs_asserted is cleared, mirroring the existing correct pattern in
ad_sd_calibrate().  With keep_cs_asserted false, both set_mode(IDLE)
and disable_one() execute with cs_change=0, so the SPI framework
deasserts CS as part of normal message teardown.  For devices that do
not implement the optional disable_one callback, set_mode(IDLE) issues
the last SPI transfer and CS is properly released in all cases.

Also fix a pre-existing state leak in ad_sd_buffer_postenable(): the
err_unlock: error path called spi_bus_unlock() without first resetting
bus_locked and keep_cs_asserted to false.  Subsequent SPI calls would
observe bus_locked == true and invoke spi_sync_locked() on a controller
that is no longer locked, potentially allowing concurrent bus access.

Fixes: 132d44dc6966 ("iio: adc: ad_sigma_delta: Check for previous ready signals")
Acked-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
Signed-off-by: Radu Sabau <radu.sabau@analog.com>
---
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
 drivers/iio/adc/ad_sigma_delta.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/ad_sigma_delta.c b/drivers/iio/adc/ad_sigma_delta.c
index a955556f9ec8..a33a7e8c264f 100644
--- a/drivers/iio/adc/ad_sigma_delta.c
+++ b/drivers/iio/adc/ad_sigma_delta.c
@@ -441,11 +441,10 @@ int ad_sigma_delta_single_conversion(struct iio_dev *indio_dev,
 out:
 	ad_sd_disable_irq(sigma_delta);
 
-	ad_sigma_delta_set_mode(sigma_delta, AD_SD_MODE_IDLE);
-	ad_sigma_delta_disable_one(sigma_delta, chan->address);
-
 out_unlock:
 	sigma_delta->keep_cs_asserted = false;
+	ad_sigma_delta_set_mode(sigma_delta, AD_SD_MODE_IDLE);
+	ad_sigma_delta_disable_one(sigma_delta, chan->address);
 	sigma_delta->bus_locked = false;
 	spi_bus_unlock(sigma_delta->spi->controller);
 out_release:
@@ -578,6 +577,8 @@ static int ad_sd_buffer_postenable(struct iio_dev *indio_dev)
 	return 0;
 
 err_unlock:
+	sigma_delta->keep_cs_asserted = false;
+	sigma_delta->bus_locked = false;
 	spi_bus_unlock(sigma_delta->spi->controller);
 	spi_unoptimize_message(&sigma_delta->sample_msg);
 

---
base-commit: 3b3bea6d4b9c162f9e555905d96b8c1da67ecd5b
change-id: 20260428-ad_sigma_delta-fix-bb65d56ccbb0

Best regards,
-- 
Radu Sabau <radu.sabau@analog.com>


