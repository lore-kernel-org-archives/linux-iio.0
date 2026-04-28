Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D4CF24E4C4;
	Tue, 28 Apr 2026 13:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777383966; cv=none; b=Bsdx9zeI1bSTgztl1P5PW31LKaxyZ/86xOkxzwU5vFJ955YVzh9Rog0peksucvMv0M71VNWQ5fVgodMMnwQVHqpZD4WWyuwmk535cpAlVSJTY+Am103UyMyC4bepP1N0DjpSDiKr7keU+LRy9ksSMtxy5qlto8h5cnV9l66d/7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777383966; c=relaxed/simple;
	bh=AIvM/UklVhkmVU6LFZOgBDoqRGWiMMvRYOEY6SP9qtE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=O8CBAUK0ASJ3xUy6gGsF4mCggo5DzOul46y5zX8sp74VIlQNzNM9fKcwHk83REISWGd5SsBgXmg3v32pA1nrcPPf9+MfRS+obCOwX6PzPClQyJhPAzX9AFAZmoPTffkhm4eWSXqRWKPtdgrkrBrj8PoJ+MyVr4guta9PFNLpZUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZPPNXzBW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZPPNXzBW"
Received: by smtp.kernel.org (Postfix) with ESMTPS id C5688C2BCAF;
	Tue, 28 Apr 2026 13:46:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777383965;
	bh=AIvM/UklVhkmVU6LFZOgBDoqRGWiMMvRYOEY6SP9qtE=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=ZPPNXzBWzMyGOBhKSgv4plPOzr7bmih84xy2eYQs8qdyrO7aOUCKkBh/qN9Ff1gXL
	 S3G3CuFx8ruQkaa+4sqpnOQMPQSPXS2X0v5rPau0OF8oOO2/VOHhgQZuV1g1862604
	 k6zNd1z3xSIfFvxgMYy/fBkZx4byo/67hmvW5OdFu24nT3fkSPAo/8hE6auq9KUVrA
	 PfemRmh5ZC7fjSU1vCTuvIF8gIUnLDkrSmDiIj8CO/l3OqsToj0wR7wn5XmqeP9yU0
	 M6gNC4bVg5v9+MYJI2Rkt3pKmEIp4FPwM0pQhgfzj0ArjFFN8PZkHk6Dvv+CYTrIzz
	 URAemJpZ7KDrg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4794FF886D;
	Tue, 28 Apr 2026 13:46:05 +0000 (UTC)
From: Radu Sabau via B4 Relay <devnull+radu.sabau.analog.com@kernel.org>
Date: Tue, 28 Apr 2026 16:45:46 +0300
Subject: [PATCH] iio: adc: ad_sigma_delta: fix CS held asserted after
 single conversion
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260428-ad_sigma_delta-fix-v1-1-8e3f925ee8d2@analog.com>
X-B4-Tracking: v=1; b=H4sIAAm68GkC/x2MWwqAIBAAryL7nWBSEl0lQlbdaqEXGhGEd0/6n
 IGZFxJFpgS9eCHSzYmPvUBdCfAL7jNJDoVBK21UozuJwSaeN7SB1gvlxI90zrShNd47p6CEZ6S
 i/+kw5vwBtbVOJGQAAAA=
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777383964; l=2920;
 i=radu.sabau@analog.com; s=20260220; h=from:subject:message-id;
 bh=kPmJkQCTQ3xk2SjVNsLsQpVpwwpGNlBuBFiGkHVxLzY=;
 b=ITQxPzwixorBEfnYOWcwuGheO7Nv+EDzs6EFlrAsbNMPEuqFHYwJ3bYH1TcKhhDBNGIdd04SJ
 La958GA+JI0CtReTuaWHbNq9vV016AZcncUoQImAQC8YldIia7fe78J
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
Unfortunately it left ad_sigma_delta_disable_one() in the out: block
above that label, so disable_one()'s SPI write is issued while
keep_cs_asserted is still true.  keep_cs_asserted feeds directly into
the cs_change field of the spi_transfer, so the final write to the
device carries cs_change=1.  The SPI framework only calls spi_set_cs()
to deassert CS as part of message teardown when cs_change is not set on
the last transfer; with cs_change=1, that teardown is skipped and CS
stays physically asserted.  No further transfer to the device is made,
so the driver never deasserts CS.  The framework provides no automatic
CS deassert on bus unlock or when switching to another device, so CS
remains stuck low until the next SPI operation to that same device.

On a shared SPI bus this is problematic: with CS stuck low the ADC
remains selected and subsequent SPI traffic intended for another device
is interpreted as commands by the ADC.  Devices like the AD7124 that
multiplex /RDY onto the MISO line will start spurious conversions and
pull MISO low, corrupting reads from the other device and causing a
deadlock.

Fix by moving ad_sigma_delta_disable_one() into the out_unlock: block,
after keep_cs_asserted is cleared.  The final SPI write now carries
cs_change=0, so the SPI framework deasserts CS as part of normal
message teardown.

As a side effect this also calls disable_one() on the early-exit path
when ad_sigma_delta_clear_pending_event() fails.  That path already had
ad_sigma_delta_set_channel() called, so calling disable_one() to undo
it is the right thing to do and is consistent with ad_sd_calibrate().

Fixes: 132d44dc6966 ("iio: adc: ad_sigma_delta: Check for previous ready signals")
Signed-off-by: Radu Sabau <radu.sabau@analog.com>
---
 drivers/iio/adc/ad_sigma_delta.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ad_sigma_delta.c b/drivers/iio/adc/ad_sigma_delta.c
index a955556f9ec8..43aa296922c6 100644
--- a/drivers/iio/adc/ad_sigma_delta.c
+++ b/drivers/iio/adc/ad_sigma_delta.c
@@ -442,10 +442,10 @@ int ad_sigma_delta_single_conversion(struct iio_dev *indio_dev,
 	ad_sd_disable_irq(sigma_delta);
 
 	ad_sigma_delta_set_mode(sigma_delta, AD_SD_MODE_IDLE);
-	ad_sigma_delta_disable_one(sigma_delta, chan->address);
 
 out_unlock:
 	sigma_delta->keep_cs_asserted = false;
+	ad_sigma_delta_disable_one(sigma_delta, chan->address);
 	sigma_delta->bus_locked = false;
 	spi_bus_unlock(sigma_delta->spi->controller);
 out_release:

---
base-commit: 3b3bea6d4b9c162f9e555905d96b8c1da67ecd5b
change-id: 20260428-ad_sigma_delta-fix-bb65d56ccbb0

Best regards,
-- 
Radu Sabau <radu.sabau@analog.com>


