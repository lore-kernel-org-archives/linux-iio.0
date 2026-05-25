Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56C8A3E16A2;
	Mon, 25 May 2026 08:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779697226; cv=none; b=dYHnGqrFvfngsFg2wsHIgCFDESfT8uaybD2zgIBsDAzz21LElq3ZYGZGcKMpwITYzJxISJ6+g0saRgRktMxxefPFQvgrRs7Q3qhWfRfdqDauc3BTtgzdJ9CMzOCLxw2HTO0QIX72DwG26F9eM8jDmH1x4oGRImQETQCPhJgqL6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779697226; c=relaxed/simple;
	bh=QhpC0LOJNu5pik6KT+yhn5u0M1YrqVbXNByZR68+Awc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=haXOAXjKrTMYb7KiE8yxlYJt3GteP4bwDZJBvvXYbGjr/BmgrPm6jNAVAoh9Cq7D7JLefoIPZjxqv3keKZLBSt2ai1fru9phn9IFhZKrqnOCDvTeOcE9/WsLtxCPB/IlCTZobF04ZCrQJHoAaR87DFv+dVq0aerlBIojqXxNcgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m/NcCA1R; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m/NcCA1R"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 11037C4AF0C;
	Mon, 25 May 2026 08:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779697226;
	bh=QhpC0LOJNu5pik6KT+yhn5u0M1YrqVbXNByZR68+Awc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=m/NcCA1ReeW6Dh5ihN0HVPvsm5cpWguNkiNm7F6Is8lBsXvunO04iQA85URkaTuJF
	 kdP5lubYUhEMCcXIQhmNUYhYXpWStIHUG8lUT2ShzKwQYLb6mYOKeDZsPgcYKjt2N7
	 1KSEjyF4boK/xjUpb/u9TUgz2vzc7UAUhE3eK/JNstrDgW84ABzFHiX627/u1nRwpL
	 3oJTx3IreCE6SlT2CvFMw8q41YBYCUBEex242W87FrNcRKtLjKhDAiRgE17ql7G/Lb
	 XyD5xUEdWqEWpmf7NEmMtG3r0uolT/LOzOpBFxT/9yTMs8+NlkAW5c+dmR5SpEd3S1
	 h8eF+5sxABsHQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07B85CD5BCF;
	Mon, 25 May 2026 08:20:26 +0000 (UTC)
From: Joshua Crofts via B4 Relay <devnull+joshua.crofts1.gmail.com@kernel.org>
Date: Mon, 25 May 2026 10:20:20 +0200
Subject: [PATCH v4 6/8] iio: light: opt3001: move driver to guard(mutex)()
 use
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260525-opt3001-cleanup-v4-6-65b36a174f78@gmail.com>
References: <20260525-opt3001-cleanup-v4-0-65b36a174f78@gmail.com>
In-Reply-To: <20260525-opt3001-cleanup-v4-0-65b36a174f78@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Joshua Crofts <joshua.crofts1@gmail.com>, 
 Andy Shevchenko <andriy.shevchenko@intel.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779697227; l=5066;
 i=joshua.crofts1@gmail.com; s=20260422; h=from:subject:message-id;
 bh=k7RV8CJgC7cxMwnoTqnNl88vKb0HKNBwwuTVAnHr18w=;
 b=hxXLoZpoOMJ7MA1TTZdYgrGOuMCL6C70hBBjTKDQg8gWOaaQhy+h/roKCDCAoRe8P0LAE+JuA
 /MY9Cylo0SAAf0mF4t1qkodo7N73iT+LXOcfZuZIy+8D2np5x4tU2nR
X-Developer-Key: i=joshua.crofts1@gmail.com; a=ed25519;
 pk=Xd+UVoRPiiI0K3LHQ2XIcXmO0jvVuFTv9eTx3lgBphI=
X-Endpoint-Received: by B4 Relay for joshua.crofts1@gmail.com/20260422 with
 auth_id=746
X-Original-From: Joshua Crofts <joshua.crofts1@gmail.com>
Reply-To: joshua.crofts1@gmail.com

From: Joshua Crofts <joshua.crofts1@gmail.com>

Move driver to use guard(mutex)() macro, to facilitate automatic
locking/unlocking of resources. This modernizes the driver and
improves code style.

While at it, remove unnecessary gotos and return variables.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
---
 drivers/iio/light/opt3001.c | 61 +++++++++++++++------------------------------
 1 file changed, 20 insertions(+), 41 deletions(-)

diff --git a/drivers/iio/light/opt3001.c b/drivers/iio/light/opt3001.c
index fa799edd6a9ce7373400bb654ea4a1b9f17212a3..14a0915330672209a8de60fc4f3debdd6d6bba76 100644
--- a/drivers/iio/light/opt3001.c
+++ b/drivers/iio/light/opt3001.c
@@ -10,6 +10,7 @@
 
 #include <linux/array_size.h>
 #include <linux/bits.h>
+#include <linux/cleanup.h>
 #include <linux/delay.h>
 #include <linux/dev_printk.h>
 #include <linux/errno.h>
@@ -477,7 +478,6 @@ static int opt3001_read_raw(struct iio_dev *iio,
 			    int *val, int *val2, long mask)
 {
 	struct opt3001 *opt = iio_priv(iio);
-	int ret;
 
 	if (opt->mode == OPT3001_CONFIGURATION_M_CONTINUOUS)
 		return -EBUSY;
@@ -485,23 +485,17 @@ static int opt3001_read_raw(struct iio_dev *iio,
 	if (chan->type != opt->chip_info->chan_type)
 		return -EINVAL;
 
-	mutex_lock(&opt->lock);
+	guard(mutex)(&opt->lock);
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
 	case IIO_CHAN_INFO_PROCESSED:
-		ret = opt3001_get_processed(opt, val, val2);
-		break;
+		return opt3001_get_processed(opt, val, val2);
 	case IIO_CHAN_INFO_INT_TIME:
-		ret = opt3001_get_int_time(opt, val, val2);
-		break;
+		return opt3001_get_int_time(opt, val, val2);
 	default:
-		ret = -EINVAL;
+		return -EINVAL;
 	}
-
-	mutex_unlock(&opt->lock);
-
-	return ret;
 }
 
 static int opt3001_write_raw(struct iio_dev *iio,
@@ -509,7 +503,6 @@ static int opt3001_write_raw(struct iio_dev *iio,
 			     int val, int val2, long mask)
 {
 	struct opt3001 *opt = iio_priv(iio);
-	int ret;
 
 	if (opt->mode == OPT3001_CONFIGURATION_M_CONTINUOUS)
 		return -EBUSY;
@@ -523,11 +516,9 @@ static int opt3001_write_raw(struct iio_dev *iio,
 	if (val != 0)
 		return -EINVAL;
 
-	mutex_lock(&opt->lock);
-	ret = opt3001_set_int_time(opt, val2);
-	mutex_unlock(&opt->lock);
+	guard(mutex)(&opt->lock);
 
-	return ret;
+	return opt3001_set_int_time(opt, val2);
 }
 
 static int opt3001_read_event_value(struct iio_dev *iio,
@@ -538,28 +529,23 @@ static int opt3001_read_event_value(struct iio_dev *iio,
 				    int *val, int *val2)
 {
 	struct opt3001 *opt = iio_priv(iio);
-	int ret = IIO_VAL_INT_PLUS_MICRO;
 
-	mutex_lock(&opt->lock);
+	guard(mutex)(&opt->lock);
 
 	switch (dir) {
 	case IIO_EV_DIR_RISING:
 		opt3001_to_iio_ret(opt, opt->high_thresh_exp,
 				   opt->high_thresh_mantissa,
 				   val, val2);
-		break;
+		return IIO_VAL_INT_PLUS_MICRO;
 	case IIO_EV_DIR_FALLING:
 		opt3001_to_iio_ret(opt, opt->low_thresh_exp,
 				   opt->low_thresh_mantissa,
 				   val, val2);
-		break;
+		return IIO_VAL_INT_PLUS_MICRO;
 	default:
-		ret = -EINVAL;
+		return -EINVAL;
 	}
-
-	mutex_unlock(&opt->lock);
-
-	return ret;
 }
 
 static int opt3001_write_event_value(struct iio_dev *iio,
@@ -586,12 +572,12 @@ static int opt3001_write_event_value(struct iio_dev *iio,
 	if (val < 0)
 		return -EINVAL;
 
-	mutex_lock(&opt->lock);
+	guard(mutex)(&opt->lock);
 
 	ret = opt3001_find_scale(opt, val, val2, &exponent);
 	if (ret < 0) {
 		dev_err(dev, "can't find scale for %d.%06u\n", val, val2);
-		goto err;
+		return ret;
 	}
 
 	whole = opt->chip_info->factor_whole;
@@ -614,20 +600,16 @@ static int opt3001_write_event_value(struct iio_dev *iio,
 		opt->low_thresh_exp = exponent;
 		break;
 	default:
-		ret = -EINVAL;
-		goto err;
+		return -EINVAL;
 	}
 
 	ret = i2c_smbus_write_word_swapped(client, reg, value);
 	if (ret < 0) {
 		dev_err(dev, "failed to write register %02x\n", reg);
-		goto err;
+		return ret;
 	}
 
-err:
-	mutex_unlock(&opt->lock);
-
-	return ret;
+	return 0;
 }
 
 static int opt3001_read_event_config(struct iio_dev *iio,
@@ -659,7 +641,7 @@ static int opt3001_write_event_config(struct iio_dev *iio,
 	if (!state && opt->mode == OPT3001_CONFIGURATION_M_SHUTDOWN)
 		return 0;
 
-	mutex_lock(&opt->lock);
+	guard(mutex)(&opt->lock);
 
 	mode = state ? OPT3001_CONFIGURATION_M_CONTINUOUS
 		: OPT3001_CONFIGURATION_M_SHUTDOWN;
@@ -668,7 +650,7 @@ static int opt3001_write_event_config(struct iio_dev *iio,
 	if (ret < 0) {
 		dev_err(dev, "failed to read register %02x\n",
 			OPT3001_CONFIGURATION);
-		goto err;
+		return ret;
 	}
 
 	reg = ret;
@@ -678,13 +660,10 @@ static int opt3001_write_event_config(struct iio_dev *iio,
 	if (ret < 0) {
 		dev_err(dev, "failed to write register %02x\n",
 			OPT3001_CONFIGURATION);
-		goto err;
+		return ret;
 	}
 
-err:
-	mutex_unlock(&opt->lock);
-
-	return ret;
+	return 0;
 }
 
 static const struct iio_info opt3001_info = {

-- 
2.47.3


