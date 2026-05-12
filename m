Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CFC738E8B7;
	Tue, 12 May 2026 10:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778583473; cv=none; b=cj5u2w+bVgu+bKV/W3QW+n/s78DKa/Ou5FDwWJw5K5HqH9hYWc9cRyUhV/KljwMp7hUF5IaxRRHLp5CKXhG992+J2OrNT34J0QPOPE41/mchZKSz5VbhvsKR88W1fkof2vXcYlIe7alcEVdsEgddM3RShDV3SSG59brJgR4BaXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778583473; c=relaxed/simple;
	bh=UQztexIb2C8tQVJaROY9WTwS6p5tW8+4ZSyp2BwPQEU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EEo3Pe74lNkZgaO5xLYjzeO38uz8vV0rHo7L0X+qpyOB12HPEtZ7Iu4dDBWXTQEThK7ktZLv4TlnAc0BVkDKye5fVdIquEjeEYzU2A1aVUjdJu6TzIPcqNiKyQxSiANwTtQPzbwIaQz6iZwOUilMY1PU9MkkLnmqqjwuK0LRFcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TUOCONxo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TUOCONxo"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6EC84C2BCF5;
	Tue, 12 May 2026 10:57:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778583473;
	bh=UQztexIb2C8tQVJaROY9WTwS6p5tW8+4ZSyp2BwPQEU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=TUOCONxoptvy0RaYHnEMQmxVz+HPbYxiFbpk/e66lGQ9/dx0AU2jCoQXTaLpyjozi
	 RH/UsNzaUaXZvfb8BUkypBXFyFDvc0of3Wfv1MiWW8y4zozjye8H5Zvmw0Rb14poW7
	 Vg7IUermPi6rlS15zXsbBlav+msoDDEm6FRqvqMjm0zvgVbbxd9vqWntKryGkxW4pm
	 7W06XTrEnTlN9VGnDndukNVcA9E8jrqlIoerLte25pGUSWCaitSeIJoKoHZJp2k8Gz
	 H8JGXsXNu55J1GqgRZ+9NtGy9dCEcLk2TpKz176D4eJW4MoQsOtDJxrrNMUJB7rRVs
	 FS8xEJmhhxVYA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 666F9CD4F21;
	Tue, 12 May 2026 10:57:53 +0000 (UTC)
From: Joshua Crofts via B4 Relay <devnull+joshua.crofts1.gmail.com@kernel.org>
Date: Tue, 12 May 2026 12:57:28 +0200
Subject: [PATCH v2 08/10] iio: light: opt3001: move driver to
 guard(mutex)() use
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260512-opt3001-cleanup-v2-8-8018cf3a8a0a@gmail.com>
References: <20260512-opt3001-cleanup-v2-0-8018cf3a8a0a@gmail.com>
In-Reply-To: <20260512-opt3001-cleanup-v2-0-8018cf3a8a0a@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Alexander Koch <mail@alexanderkoch.net>, 
 Michael Hornung <mhornung.linux@gmail.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Joshua Crofts <joshua.crofts1@gmail.com>, 
 Andy Shevchenko <andriy.shevchenko@intel.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778583471; l=4962;
 i=joshua.crofts1@gmail.com; s=20260422; h=from:subject:message-id;
 bh=E9XaiRNPCXjAZv0bmOpRuAak9EP1Bj7kFnRGE0Loxl0=;
 b=aR3Fe4N4ftppBOmhbO2Iv/LOnYifaiUb31sC2v9KjMeG8K+h7U8kolAt6AWqUOIrFeKfgEA28
 XHFIC+LPwNtC0zVlvF+BQ4yYoNA+Wx0JXWcJafUDVD4n9KOUoD7vZCj
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
 drivers/iio/light/opt3001.c | 61 +++++++++++++--------------------------------
 1 file changed, 18 insertions(+), 43 deletions(-)

diff --git a/drivers/iio/light/opt3001.c b/drivers/iio/light/opt3001.c
index 6f7c524d3a7a41c5177c9b02ebe1b7858294a0b4..39ea60c0af2c1ec7473d49b73778cac1f9bb6086 100644
--- a/drivers/iio/light/opt3001.c
+++ b/drivers/iio/light/opt3001.c
@@ -10,6 +10,7 @@
 
 #include <linux/array_size.h>
 #include <linux/bits.h>
+#include <linux/cleanup.h>
 #include <linux/delay.h>
 #include <linux/dev_printk.h>
 #include <linux/errno.h>
@@ -478,7 +479,6 @@ static int opt3001_read_raw(struct iio_dev *iio,
 			    int *val, int *val2, long mask)
 {
 	struct opt3001 *opt = iio_priv(iio);
-	int ret;
 
 	if (opt->mode == OPT3001_CONFIGURATION_M_CONTINUOUS)
 		return -EBUSY;
@@ -486,23 +486,17 @@ static int opt3001_read_raw(struct iio_dev *iio,
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
@@ -510,7 +504,6 @@ static int opt3001_write_raw(struct iio_dev *iio,
 			     int val, int val2, long mask)
 {
 	struct opt3001 *opt = iio_priv(iio);
-	int ret;
 
 	if (opt->mode == OPT3001_CONFIGURATION_M_CONTINUOUS)
 		return -EBUSY;
@@ -524,11 +517,9 @@ static int opt3001_write_raw(struct iio_dev *iio,
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
@@ -539,28 +530,23 @@ static int opt3001_read_event_value(struct iio_dev *iio,
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
@@ -587,12 +573,12 @@ static int opt3001_write_event_value(struct iio_dev *iio,
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
@@ -615,18 +601,12 @@ static int opt3001_write_event_value(struct iio_dev *iio,
 		opt->low_thresh_exp = exponent;
 		break;
 	default:
-		ret = -EINVAL;
-		goto err;
+		return -EINVAL;
 	}
 
 	ret = i2c_smbus_write_word_swapped(client, reg, value);
-	if (ret < 0) {
+	if (ret < 0)
 		dev_err(dev, "failed to write register %02x\n", reg);
-		goto err;
-	}
-
-err:
-	mutex_unlock(&opt->lock);
 
 	return ret;
 }
@@ -660,7 +640,7 @@ static int opt3001_write_event_config(struct iio_dev *iio,
 	if (!state && opt->mode == OPT3001_CONFIGURATION_M_SHUTDOWN)
 		return 0;
 
-	mutex_lock(&opt->lock);
+	guard(mutex)(&opt->lock);
 
 	mode = state ? OPT3001_CONFIGURATION_M_CONTINUOUS
 		: OPT3001_CONFIGURATION_M_SHUTDOWN;
@@ -669,21 +649,16 @@ static int opt3001_write_event_config(struct iio_dev *iio,
 	if (ret < 0) {
 		dev_err(dev, "failed to read register %02x\n",
 			OPT3001_CONFIGURATION);
-		goto err;
+		return ret;
 	}
 
 	reg = ret;
 	opt3001_set_mode(opt, &reg, mode);
 
 	ret = i2c_smbus_write_word_swapped(client, OPT3001_CONFIGURATION, reg);
-	if (ret < 0) {
+	if (ret < 0)
 		dev_err(dev, "failed to write register %02x\n",
 			OPT3001_CONFIGURATION);
-		goto err;
-	}
-
-err:
-	mutex_unlock(&opt->lock);
 
 	return ret;
 }

-- 
2.47.3


