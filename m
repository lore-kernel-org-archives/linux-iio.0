Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E60B73A0E8A;
	Mon,  8 Jun 2026 09:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780909385; cv=none; b=CZzB4zk5bz1aUR4GrSXErog40//iu809ZE5PqdXtKtGLt/IBsBdqMsGC46tD6dFUGrluedMPJ92KGJwd/5r5WEvtq0m/BhreubETWKtyEl8YIjn50Xn6SLQmD/Q2laiMqWSXbTnutbLDcRZdOSu153k06juVNHjmJbih6EIDwT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780909385; c=relaxed/simple;
	bh=I1zEkOL1G5g5puFmA2/onCAQPfw2kl/uPlhwlPno3Dw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=lwAMdJkbI3ffN+nnX2h/rwBQIvcXQ68tiGpYFzdtiJv48XJd7A3Tf7DCOFOUBl+JUbc4WfeUyLhdutEP3o7+ne0w3xv3rQbHfJ5YLb9BHET3OnYiJAAeFP2pCKIJAsdbhkQAu820b/WlQXsgAYrX9WOynzRO4ZrCwQSknjqV4h8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fwLoAdL3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fwLoAdL3"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 70ABBC2BCB0;
	Mon,  8 Jun 2026 09:03:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1780909384;
	bh=I1zEkOL1G5g5puFmA2/onCAQPfw2kl/uPlhwlPno3Dw=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=fwLoAdL3bD1Y/Gk6b4nHbGkB9XQdIcJdLa49Y9wKlQBcB1BpGe//rIzjUUceB6Lzu
	 mdro1WJ5124Ze15fZEHXne60g7sUKHtcquLSdjvJExTYaTNevp7x2f9gGb+uQT5xBD
	 nVo6qfn6tL7o3fdl62hNRRzLsPxbGSJTud2XUXcxxuXAgbfDIYr2NR530ms8bDOeti
	 CJVgzORPQwjmVd5tWJ0GcShRxHs3d9obfY7kUQxJMuG7ByaL9XOKhndBxrxUUMpkNs
	 H2U6gtD2HLGlZRtTBHqevKjhFA/muzVdK1/afl07pbV6A1hrZY95vl4qHISjrcFYaa
	 rniIqLmXGKLqg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5548DCD8C9F;
	Mon,  8 Jun 2026 09:03:04 +0000 (UTC)
From: Radu Sabau via B4 Relay <devnull+radu.sabau.analog.com@kernel.org>
Date: Mon, 08 Jun 2026 12:02:54 +0300
Subject: [PATCH] iio: adc: ad_sigma_delta: allow COMPILE_TEST in isolation
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260608-ad_sigma_delta_spi-v1-1-61e37666d9b6@analog.com>
X-B4-Tracking: v=1; b=H4sIAD2FJmoC/x2M0QpAQBAAf+XaZ1frRPgV6TpuscXRraTk310ep
 2nmAaHIJNCqByJdLLyHBHmmYFxcmEmzTwwGTYUV1tp5KzxvznpaT2flYJ1EMRnEvCkHSOERaeL
 7n3b9+37rS1+aZAAAAA==
X-Change-ID: 20260608-ad_sigma_delta_spi-6063f200195b
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Radu Sabau <radu.sabau@analog.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780909381; l=1341;
 i=radu.sabau@analog.com; s=20260220; h=from:subject:message-id;
 bh=GA54EjBngw5qAiuNb6r1BBeWyhMJfGxCv8whjAQhc6M=;
 b=UK0M5bL9QqeHBi4QSmvPvewHW+zOL4F9Uxuc/DLQAmRv27fffcJObgR/JhgQlzi0Vk/fZqLBM
 j1b2i/O8jlKDx0qbtSvGu9NMXKY2psENCTp8THEnnAYOQogwIjUOK5S
X-Developer-Key: i=radu.sabau@analog.com; a=ed25519;
 pk=lDPQHgn9jTdt0vo58Na9lLxLaE2mb330if71Cn+EvFU=
X-Endpoint-Received: by B4 Relay for radu.sabau@analog.com/20260220 with
 auth_id=642
X-Original-From: Radu Sabau <radu.sabau@analog.com>
Reply-To: radu.sabau@analog.com

From: Radu Sabau <radu.sabau@analog.com>

AD_SIGMA_DELTA is a hidden tristate that can only be enabled by
selecting drivers (AD7124, AD7192, etc.), all of which require SPI.
This prevents compile-testing the library code directly with allmodconfig
or by manually enabling it with COMPILE_TEST.

Add a prompt string guarded by "if COMPILE_TEST" so the symbol becomes
directly selectable when COMPILE_TEST is set.

Also add an explicit "depends on SPI" since the ad_sigma_delta library
directly calls SPI core symbols such as spi_bus_lock(), spi_bus_unlock(),
and spi_sync_locked().

Signed-off-by: Radu Sabau <radu.sabau@analog.com>
---
 drivers/iio/adc/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index a9dedbb8eb46..329d1f6e5106 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -33,7 +33,8 @@ config AB8500_GPADC
 	  and USB voltages integral to the U8500 platform.
 
 config AD_SIGMA_DELTA
-	tristate
+	tristate "Analog Devices Sigma-Delta Modulator support" if COMPILE_TEST
+	depends on SPI
 	select IIO_BUFFER
 	select IIO_BUFFER_DMAENGINE
 	select IIO_TRIGGERED_BUFFER

---
base-commit: 4549871118cf616eecdd2d939f78e3b9e1dddc48
change-id: 20260608-ad_sigma_delta_spi-6063f200195b

Best regards,
-- 
Radu Sabau <radu.sabau@analog.com>


