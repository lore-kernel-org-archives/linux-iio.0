Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 574423FBED1;
	Wed, 29 Apr 2026 13:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777468058; cv=none; b=XyUObtFKHnYFl7yWDLJ7ALWP72HocvY3VxBo+kE/4+bQgqM2jv8gc04l5QSHqXHbAcvTJomozZwLxaZMQC03ppAoUNRwDcwx83FnEY59ClaixKGdk6+8Ws0v/Y+MJ3CSYOKRTGsZ3uXI3ar9X5tRfX1/4PVWQ66j6LX0yeTIaFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777468058; c=relaxed/simple;
	bh=ofi5Nr2V7S4nqvAUGiuyQ9AB3wCRZIur4VO+quE7/no=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SqIS6gMaY8SpA96QL62ljThLIMW3TCjHKg9cZGuXDhBJj+caMI2RJ5fq8ElBYJweMvgG5GBT7BdtSZAoFvizExKODkhwp+F+trxR7iSevJy8P2PqnDmtTgj5+qK4YlA7a3xPW/phVaUd+OHnwQEHLOtix6GaTkTGKV+CWaDhnF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=smnDo1Va; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="smnDo1Va"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 37972C2BCC6;
	Wed, 29 Apr 2026 13:07:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777468058;
	bh=ofi5Nr2V7S4nqvAUGiuyQ9AB3wCRZIur4VO+quE7/no=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=smnDo1Va4UHhQPACWpkKJE7xz1e6CUx0vn7AxEYwdS5YUQmxkhpG3abEZaIfhso2Z
	 KP2zfTJSoPabHgaTSg5vBKjRcQPdtnuXt16hUyMy7glm5nn0K8zZRXJb5h3xc8FyOX
	 AvNI78nPaSn9lZ9ZAGsSCIaQIYpQ3s95dLS4MWTZk0UzXprfcR+4OXYLZsZfsB5xQk
	 ng+IuSpNcuni7ZwElUmVwfjOXet/jOPHqN6yIjveEMPA2ZcJ97YZH8QjtmZLwAPVT4
	 rxFyzUTRhKfgtMc1wFT+HHjDaKmi9NjDOAKBH7PIOOCvZ4LSLqKsVwa0ycxqJvTGUg
	 XwsjrNwSL0jgA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 308E4CCF9E3;
	Wed, 29 Apr 2026 13:07:38 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Wed, 29 Apr 2026 14:07:40 +0100
Subject: [PATCH v4 10/13] iio: dac: ad5686: remove powerdown mask magic
 number
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260429-ad5686-fixes-v4-10-bb8f1cbd68e1@analog.com>
References: <20260429-ad5686-fixes-v4-0-bb8f1cbd68e1@analog.com>
In-Reply-To: <20260429-ad5686-fixes-v4-0-bb8f1cbd68e1@analog.com>
To: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Stefan Popa <stefan.popa@analog.com>, Jonathan Cameron <jic23@cam.ac.uk>, 
 Greg Kroah-Hartman <gregkh@suse.de>, 
 Michael Auchter <michael.auchter@ni.com>, 
 Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 Rodrigo Alencar <rodrigo.alencar@analog.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777468056; l=2952;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=x+f5X9G+QgQmbzFHF+5ueLvHY+KAC7dvWbfcoQHYU34=;
 b=X2uVsE4M/sgiAOEaPE2oy3tNs+ey1gwQCHd2/J4JwZu3egSDguRYLm7Ok+A6/Kr4YVErYcQD8
 ZYhNTC83U81A7ZC8dH0fTfHk7eyABP16PBLY8AGPZxcyNxSE5KzeqF8
X-Developer-Key: i=rodrigo.alencar@analog.com; a=ed25519;
 pk=ULeHbgU/OYh/PG/4anHDfLgldFItQHAhOktYRVLMFRo=
X-Endpoint-Received: by B4 Relay for rodrigo.alencar@analog.com/default
 with auth_id=561
X-Original-From: Rodrigo Alencar <rodrigo.alencar@analog.com>
Reply-To: rodrigo.alencar@analog.com

From: Rodrigo Alencar <rodrigo.alencar@analog.com>

Define macro AD5686_PD_MSK to hold powerdown mask value.

Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
---
 drivers/iio/dac/ad5686.c | 16 ++++++++--------
 drivers/iio/dac/ad5686.h |  1 +
 2 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/dac/ad5686.c b/drivers/iio/dac/ad5686.c
index 4bcabdbaf1d8..0590716191c1 100644
--- a/drivers/iio/dac/ad5686.c
+++ b/drivers/iio/dac/ad5686.c
@@ -39,7 +39,7 @@ static int ad5686_get_powerdown_mode(struct iio_dev *indio_dev,
 	unsigned int shift = ad5686_pd_mask_shift(chan);
 	struct ad5686_state *st = iio_priv(indio_dev);
 
-	return ((st->pwr_down_mode >> shift) & 0x3) - 1;
+	return ((st->pwr_down_mode >> shift) & AD5686_PD_MSK) - 1;
 }
 
 static int ad5686_set_powerdown_mode(struct iio_dev *indio_dev,
@@ -51,8 +51,8 @@ static int ad5686_set_powerdown_mode(struct iio_dev *indio_dev,
 
 	guard(mutex)(&st->lock);
 
-	st->pwr_down_mode &= ~(0x3 << shift);
-	st->pwr_down_mode |= (mode + 1) << shift;
+	st->pwr_down_mode &= ~(AD5686_PD_MSK << shift);
+	st->pwr_down_mode |= ((mode + 1) & AD5686_PD_MSK) << shift;
 
 	return 0;
 }
@@ -70,7 +70,7 @@ static ssize_t ad5686_read_dac_powerdown(struct iio_dev *indio_dev,
 	unsigned int shift = ad5686_pd_mask_shift(chan);
 	struct ad5686_state *st = iio_priv(indio_dev);
 
-	return sysfs_emit(buf, "%d\n", !!(st->pwr_down_mask & (0x3 << shift)));
+	return sysfs_emit(buf, "%d\n", !!(st->pwr_down_mask & (AD5686_PD_MSK << shift)));
 }
 
 static ssize_t ad5686_write_dac_powerdown(struct iio_dev *indio_dev,
@@ -92,9 +92,9 @@ static ssize_t ad5686_write_dac_powerdown(struct iio_dev *indio_dev,
 	guard(mutex)(&st->lock);
 
 	if (readin)
-		st->pwr_down_mask |= 0x3 << ad5686_pd_mask_shift(chan);
+		st->pwr_down_mask |= AD5686_PD_MSK << ad5686_pd_mask_shift(chan);
 	else
-		st->pwr_down_mask &= ~(0x3 << ad5686_pd_mask_shift(chan));
+		st->pwr_down_mask &= ~(AD5686_PD_MSK << ad5686_pd_mask_shift(chan));
 
 	switch (st->chip_info->regmap_type) {
 	case AD5310_REGMAP:
@@ -468,8 +468,8 @@ int ad5686_probe(struct device *dev,
 	/* Set all the power down mode for all channels to 1K pulldown */
 	for (i = 0; i < st->chip_info->num_channels; i++) {
 		shift = ad5686_pd_mask_shift(&st->chip_info->channels[i]);
-		st->pwr_down_mask &= ~(0x3 << shift); /* powered up state */
-		st->pwr_down_mode &= ~(0x3 << shift);
+		st->pwr_down_mask &= ~(AD5686_PD_MSK << shift); /* powered up state */
+		st->pwr_down_mode &= ~(AD5686_PD_MSK << shift);
 		st->pwr_down_mode |= 0x01 << shift;
 	}
 
diff --git a/drivers/iio/dac/ad5686.h b/drivers/iio/dac/ad5686.h
index caadc7403da1..b9eee3ad4dc8 100644
--- a/drivers/iio/dac/ad5686.h
+++ b/drivers/iio/dac/ad5686.h
@@ -47,6 +47,7 @@
 #define AD5683_REF_BIT_MSK			BIT(12)
 #define AD5686_REF_BIT_MSK			BIT(0)
 
+#define AD5686_PD_MSK				GENMASK(1, 0)
 
 enum ad5686_regmap_type {
 	AD5310_REGMAP,

-- 
2.43.0


