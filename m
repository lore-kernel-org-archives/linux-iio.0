Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E05CF32470E;
	Mon, 18 May 2026 09:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779098345; cv=none; b=AtbcB14gf23AAAGvtZKMrmfTM2BuvAc6L7KM/EajfxSChHzHR635NBuCOEgULkojoSmNixxFA+amwaau6ADKE+Kd7teKe6TraQOQgLYWq9KFAU+KLOVAFklHwPQa2iLIJa97u7UyY2AvNFL5TVe0K7piXBGz7Tb6rDhdTt1m2kQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779098345; c=relaxed/simple;
	bh=mKnRuldEhWQktUtIa6WmCvZZ2JFy+d/Hp5jzI0nvrYM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Mg3U+6GNyjT5vnEsGfQVDnF1gYiHD6T+AxtLn4Vg8vouAXpCdVbFaLF3/Gi1VBf9Un/Wv+lRwcTAKX2qTGlpgi/8D1ZY0JaiY5of8EvzMVClgA1OhHek4ipIfNyaMpDrtgxlrdegrr1HvNDZ4ero67HYdc49fZNsfneAZfvo+vM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TU6iM1Ly; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TU6iM1Ly"
Received: by smtp.kernel.org (Postfix) with ESMTPS id A69FBC2BCF6;
	Mon, 18 May 2026 09:59:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779098344;
	bh=mKnRuldEhWQktUtIa6WmCvZZ2JFy+d/Hp5jzI0nvrYM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=TU6iM1LyEVGi3QpL1osaTzKSK1jAhkaB83DfiArmqtS0MnLkmTiGGkOi8e12mFdkD
	 3NRpRJFPMtQFCprhftv2HlVRiVzxUe4M44m/O3j1qikRsCIeUcBy8DO5AU0hRHImnv
	 A7g0TCdI5+EZdkhVXNCBkmc28LaeHDiRGXqzOYQw9Cmr8LwsfQLw9lTJzfrH71wMCl
	 s4QZ00Y5eUvbzrecKZI6sbwMmJ/QAd0nSKfU2tFfpLaow01EsbuxYrOWPF/oPX26mU
	 57475vri9juPKJol3cxdggHKN4yRRRKRK2StU9iCKYdUyYYwULH6TqWSDwO8yRAM8P
	 Be8IO1Jhzv2eQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B19FCD4F52;
	Mon, 18 May 2026 09:59:04 +0000 (UTC)
From: Radu Sabau via B4 Relay <devnull+radu.sabau.analog.com@kernel.org>
Date: Mon, 18 May 2026 12:59:04 +0300
Subject: [PATCH v3 2/2] iio: adc: ad_sigma_delta: fix clear_pending_event
 for registerless devices
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260518-ad_sigma_delta-fix-v3-2-a2a92b0c36f3@analog.com>
References: <20260518-ad_sigma_delta-fix-v3-0-a2a92b0c36f3@analog.com>
In-Reply-To: <20260518-ad_sigma_delta-fix-v3-0-a2a92b0c36f3@analog.com>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Radu Sabau <radu.sabau@analog.com>, Jonathan Cameron <jic23@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779098343; l=3198;
 i=radu.sabau@analog.com; s=20260220; h=from:subject:message-id;
 bh=ik2MMWjPIciaEPWACoIeOi+XWz2Jq+3CxsOakr8Y31w=;
 b=mjtWt97UmSf1N+y14ywsO1BC0YuGZlRbohpvwDZ96pDVYmkrMh7+Iel+jWLecvhbAPlDtolil
 LQLh6qlasfTCE2n0CY8Rl649E+lt60a8vbR0Rg3+MWhsPsomPcWZBso
X-Developer-Key: i=radu.sabau@analog.com; a=ed25519;
 pk=lDPQHgn9jTdt0vo58Na9lLxLaE2mb330if71Cn+EvFU=
X-Endpoint-Received: by B4 Relay for radu.sabau@analog.com/20260220 with
 auth_id=642
X-Original-From: Radu Sabau <radu.sabau@analog.com>
Reply-To: radu.sabau@analog.com

From: Radu Sabau <radu.sabau@analog.com>

ad_sigma_delta_clear_pending_event() falls through to the status register
read path for devices with has_registers = false and no rdy_gpiod. For
such devices, ad_sd_read_reg() skips the address byte entirely and clocks
raw MISO bytes with no address phase — making it byte-for-byte identical
to reading conversion data. If a pending conversion result is present,
this partially consumes it and corrupts the data stream for the subsequent
ad_sd_read_reg() call in ad_sigma_delta_single_conversion().

Furthermore, with num_resetclks = 0 on these devices, data_read_len
evaluates to 0. If the clocked byte has bit 7 clear, pending_event is set
and the code attempts memset(data + 2, 0xff, 0 - 1), overflowing to
SIZE_MAX and corrupting the heap.

Fix by returning 0 immediately when neither rdy_gpiod nor has_registers
is set. This is safe because the IRQ is requested with IRQF_NO_AUTOEN and
IRQ_DISABLE_UNLAZY, which keeps the hardware IRQ line unmasked even while
software-disabled. Any falling edge from a completed conversion is latched
by the IRQ controller. When ad_sd_enable_irq() is subsequently called the
latched edge fires immediately, and the existing ad_sd_read_reg() call in
ad_sigma_delta_single_conversion() reads the complete stale result from
the beginning with no prior partial clock corruption.

Signed-off-by: Radu Sabau <radu.sabau@analog.com>
---
 drivers/iio/adc/ad_sigma_delta.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/ad_sigma_delta.c b/drivers/iio/adc/ad_sigma_delta.c
index a33a7e8c264f..88dcaa910b2d 100644
--- a/drivers/iio/adc/ad_sigma_delta.c
+++ b/drivers/iio/adc/ad_sigma_delta.c
@@ -262,11 +262,16 @@ static int ad_sigma_delta_clear_pending_event(struct ad_sigma_delta *sigma_delta
 
 	/*
 	 * Read R̅D̅Y̅ pin (if possible) or status register to check if there is an
-	 * old event.
+	 * old event. For devices with neither an RDY GPIO nor registers,
+	 * ad_sd_read_reg() transmits no address byte and clocks raw MISO bytes,
+	 * which is indistinguishable from reading conversion data and would
+	 * partially consume a pending result. Skip the check for such devices;
+	 * IRQ_DISABLE_UNLAZY ensures any pending falling edge is latched and
+	 * fires naturally on the next ad_sd_enable_irq() call.
 	 */
 	if (sigma_delta->rdy_gpiod) {
 		pending_event = gpiod_get_value(sigma_delta->rdy_gpiod);
-	} else {
+	} else if (sigma_delta->info->has_registers) {
 		unsigned int status_reg;
 
 		ret = ad_sd_read_reg(sigma_delta, AD_SD_REG_STATUS, 1, &status_reg);
@@ -274,6 +279,8 @@ static int ad_sigma_delta_clear_pending_event(struct ad_sigma_delta *sigma_delta
 			return ret;
 
 		pending_event = !(status_reg & AD_SD_REG_STATUS_RDY);
+	} else {
+		return 0;
 	}
 
 	if (!pending_event)
@@ -578,6 +585,7 @@ static int ad_sd_buffer_postenable(struct iio_dev *indio_dev)
 
 err_unlock:
 	sigma_delta->keep_cs_asserted = false;
+	ad_sigma_delta_set_mode(sigma_delta, AD_SD_MODE_IDLE);
 	sigma_delta->bus_locked = false;
 	spi_bus_unlock(sigma_delta->spi->controller);
 	spi_unoptimize_message(&sigma_delta->sample_msg);

-- 
2.43.0


