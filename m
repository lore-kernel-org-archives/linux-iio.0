Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C8FE3ED5A8;
	Wed, 27 May 2026 09:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779874721; cv=none; b=SZ+7zxDc7LQfufNHKmkoE5NKlxz19WmTHWIyowFYjMXqcn1jRYflR/PURnGJvMBG/aiNvm5NMhEfzsOEH7u5uE9VK0Te0cNZbOhtrs621I78vgvOpCfqCP1gBbJ8eNjLmrss6PAzRaZ3QKDS9trjJ8YDzFJstIZCYSpobkCCNSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779874721; c=relaxed/simple;
	bh=l0gn/ceJGXl3sz4iPhyZRlM/OumNDIWS6BfiwpkaCzY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nt2aeuh0P3nSgHmUHHu802dec8+mtbHuAqevKr33lUH/j9De2sN5hFoXAC/m89pzLYHjqUGG8kXOppI7Iw5jkTokBdYp7PRbP/6vlG7tOWyLN5dnCZPADVuN0dMkmx2yI7DY7c6z40GIt4d22UsOR8KaPUA/o8O+/nnOdHRFVqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JXwsRLYd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JXwsRLYd"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2BE13C2BCB3;
	Wed, 27 May 2026 09:38:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779874720;
	bh=l0gn/ceJGXl3sz4iPhyZRlM/OumNDIWS6BfiwpkaCzY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=JXwsRLYdmRom5m6CnJyvKl+0HPlemM8iFlNHTrBUxtPgObsqT70ONlofgWdtV9aJY
	 MjByQ0l5ZumkaTrUGj4Jv6szHJnVP3EQAtpxK03bpOHu4QGIvNgoqMJDfpWKvut2Hs
	 8NqLIygggAca1ogGqHGBvbUyl+gb/nZMuu0IX2805q2oLHv3bqn90qFP566q1YNDDZ
	 lCI5XYtNuhGocvr6SyGv7U42Bhx+eTyl/NKk81bCQmqUxotPmtBdAQpWfRqJznm4Ib
	 AEnLpWBQeT7UFeEPQ+UrZpg0S/lqRUruC+uhbzbg6a3FOc8/xm0P2FPMed22qB+0JW
	 pVZHVPJ/j0XYw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1644ECD4F54;
	Wed, 27 May 2026 09:38:40 +0000 (UTC)
From: Radu Sabau via B4 Relay <devnull+radu.sabau.analog.com@kernel.org>
Date: Wed, 27 May 2026 12:38:38 +0300
Subject: [PATCH v5 1/2] iio: adc: ad_sigma_delta: fix CS held asserted and
 state leaks
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260527-ad_sigma_delta-fix-v5-1-446fd2bc7330@analog.com>
References: <20260527-ad_sigma_delta-fix-v5-0-446fd2bc7330@analog.com>
In-Reply-To: <20260527-ad_sigma_delta-fix-v5-0-446fd2bc7330@analog.com>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Radu Sabau <radu.sabau@analog.com>, Jonathan Cameron <jic23@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779874718; l=2544;
 i=radu.sabau@analog.com; s=20260220; h=from:subject:message-id;
 bh=QFWfNaET8rJJ77RhwFpRfRVxthjDFfu19nJZEMUWpQ4=;
 b=9mvEoYkkSx7dx7qeYU0zgbemxfaNTLszCpOqUl+1gjIAynb64WmEy7Q37XKjQkBsTl2NU/1yV
 db//UcghU3CDfp+ebrVGGIVsbrLrpJrhIK0rIVoIS/OybUVKy2uXOcc
X-Developer-Key: i=radu.sabau@analog.com; a=ed25519;
 pk=lDPQHgn9jTdt0vo58Na9lLxLaE2mb330if71Cn+EvFU=
X-Endpoint-Received: by B4 Relay for radu.sabau@analog.com/20260220 with
 auth_id=642
X-Original-From: Radu Sabau <radu.sabau@analog.com>
Reply-To: radu.sabau@analog.com

From: Radu Sabau <radu.sabau@analog.com>

In ad_sigma_delta_single_conversion(), set_mode(AD_SD_MODE_IDLE) and
disable_one() were called from the out: block while keep_cs_asserted
was still true. This caused any SPI transfer issued by those callbacks
to carry cs_change=1, leaving CS permanently asserted after the
conversion. Fix by moving both calls into the out_unlock: block, after
keep_cs_asserted is cleared, matching the pattern already used in
ad_sd_calibrate().

In the error path of ad_sd_buffer_postenable(), if an operation fails
after set_mode(AD_SD_MODE_CONTINUOUS) has already succeeded (e.g.
spi_offload_trigger_enable()), the device is left in continuous
conversion mode with CS physically asserted. Additionally,
bus_locked remaining true after spi_bus_unlock() causes subsequent
SPI operations to call spi_sync_locked() without the bus lock actually
held, allowing concurrent SPI access.

Fix the error path by clearing keep_cs_asserted first, then calling
set_mode(AD_SD_MODE_IDLE) to revert the device mode and deassert CS,
then clearing bus_locked before releasing the bus.

For devices that implement neither set_mode nor disable_one (such as
MAX11205, which has no physical CS pin), no SPI transfer is issued
during cleanup and the cs_change flag has no effect on any physical
line.

Signed-off-by: Radu Sabau <radu.sabau@analog.com>
---
 drivers/iio/adc/ad_sigma_delta.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/ad_sigma_delta.c b/drivers/iio/adc/ad_sigma_delta.c
index a955556f9ec8..651ade67ad2e 100644
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
@@ -578,6 +577,9 @@ static int ad_sd_buffer_postenable(struct iio_dev *indio_dev)
 	return 0;
 
 err_unlock:
+	sigma_delta->keep_cs_asserted = false;
+	ad_sigma_delta_set_mode(sigma_delta, AD_SD_MODE_IDLE);
+	sigma_delta->bus_locked = false;
 	spi_bus_unlock(sigma_delta->spi->controller);
 	spi_unoptimize_message(&sigma_delta->sample_msg);
 

-- 
2.43.0


