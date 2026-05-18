Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E04C8317176;
	Mon, 18 May 2026 09:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779098345; cv=none; b=tHcCHYxIXGr1g/bWvh9N2SUlox2A1YOrQOiRBcTgNh+OYPjcW/9/GYvWzRQ66JB5vOKvqex7Pn9RBwbmfVhPxEFtnpqSQZyP0TJJ8/hT/KZvfWEbKLBg+I8+dmAbFxaZ99Wz3Au1ECD4Z1PipN6Z7LadCFEw4hRe4DIONO94pjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779098345; c=relaxed/simple;
	bh=kItDCd7EvbNKulZLaZYqEk6tnoj2gCQ5biwGPGhGd7M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lQtgIdeqKjauoIkZHVMICNN6hPKPDPuSVwtaYuRaorNPRoPAf6pK7NsOAk5FCWajzTKSbzPgtpE8gHme2Dpdpftr5qEc09t1io976g0ce42nO3nOemSRsB+NxEQ2An3DYP5gk7ai0vzSJn4SXaQBd8sGYblKEzfkz0UInOFHD4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=szxLO2bn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="szxLO2bn"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8C83EC2BCC6;
	Mon, 18 May 2026 09:59:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779098344;
	bh=kItDCd7EvbNKulZLaZYqEk6tnoj2gCQ5biwGPGhGd7M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=szxLO2bnZeZ9Cha/v0CGtnuGthx4F0SJYLAnY/L8fDbQ96260pkwRZCIvzzobr4Qs
	 n+Lsxr7oPs4Sedf8HUnYfdUXsCLFgDYRNzotrpVHVgGPQtNJxp/to0SzZGz/38hveL
	 BHh9vCr6PWOWT/S8TJ8PUMzxC+rXuz0VWVQgqKoGNWffTiehXmK0SwXIwjy1eFgMoL
	 0JGgp3fPA/y6yYFvI40/s0hAeiiaLFknOcWrA90oOI+/HddzgGz/Iqe9sjP3iLvOqr
	 5fTnK7dYShsRlofPPTNenK1x2jVUtcu50ub/pBzl2N6xzJV3jNx/H96Zwj4cgCBjJr
	 tAXXkkwAub2Qg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CB32CD4F3C;
	Mon, 18 May 2026 09:59:04 +0000 (UTC)
From: Radu Sabau via B4 Relay <devnull+radu.sabau.analog.com@kernel.org>
Date: Mon, 18 May 2026 12:59:03 +0300
Subject: [PATCH v3 1/2] iio: adc: ad_sigma_delta: fix CS held asserted and
 state leaks
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260518-ad_sigma_delta-fix-v3-1-a2a92b0c36f3@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779098343; l=2485;
 i=radu.sabau@analog.com; s=20260220; h=from:subject:message-id;
 bh=jgsy//wSVhNGuw9UiQlTJ+vWzQIexEwOSspnPbjTdn0=;
 b=5FYm5eyXVfVif4vOdQyy+nX8Qi21HBhZgUb3RhOZsAecRSCjbPM4PLWb86JPRU1c44DjXfXWd
 4AH6e/rD6JsD/+XTMVTojqmpz4tp/lXWnUxgbg1AUaoFTJc+0YmRpRZ
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
 

-- 
2.43.0


