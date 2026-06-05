Received: from outbound5.mail.transip.nl (outbound5.mail.transip.nl [136.144.136.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15E6C233723;
	Fri,  5 Jun 2026 08:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=136.144.136.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780649252; cv=none; b=hFZtUb81hPn3l30GU56dlc6jtSUsARdAdcdqzR0n3TboIU863ehTl+SYYSH1xt3wbpqfcnTVwEyEDMyebqiQkShLEDDvq9XmLEK9AV+qvGGbKTx080TmCvqSC8Yh+B/YIBmFq2JZ/57scSPSzZ72S2EzRUXsd8owLyogGOPHLjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780649252; c=relaxed/simple;
	bh=vvpDUNSTmlVd/hGAG+9hXkldKHkwQINqvNkm2FJE/ls=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EfQHvbFeQL1yAH1ozxSsRkn4qgEJLOpi/BC9iJTjLVCsZngGVb1bPVnRjj4AtUgX4Su3J0u5+9/eHZ+E7PODgeDwzB5ThYoASr24kk4yATcZgmmbpYzSgVuTxqU4wZP27zHC35WWWGycCJTezYO8EtpwbpNl60pt5XQj1yfBdVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=herrie.org; spf=pass smtp.mailfrom=herrie.org; dkim=pass (2048-bit key) header.d=herrie.org header.i=@herrie.org header.b=g5+utD+G; arc=none smtp.client-ip=136.144.136.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=herrie.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=herrie.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=herrie.org header.i=@herrie.org header.b="g5+utD+G"
Received: from submission10.mail.transip.nl (unknown [10.103.8.161])
	by outbound5.mail.transip.nl (Postfix) with ESMTP id 4gWw6g2BXJzHVlP;
	Fri,  5 Jun 2026 10:47:23 +0200 (CEST)
Received: from herrie-desktop.. (180-93-184-31.ftth.glasoperator.nl [31.184.93.180])
	by submission10.mail.transip.nl (Postfix) with ESMTPA id 4gWw6f5K8dz1g92mK;
	Fri,  5 Jun 2026 10:47:22 +0200 (CEST)
From: Herman van Hazendonk <github.com@herrie.org>
To: linusw@kernel.org,
	jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Herman van Hazendonk <github.com@herrie.org>
Subject: [PATCH] iio: gyro: mpu3050: restore cached sample rate on runtime resume
Date: Fri,  5 Jun 2026 10:47:22 +0200
Message-ID: <4622fa440f1686e06d0828a6abdbda3181fa385b.1780649212.git.github.com@herrie.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: ClueGetter at submission10.mail.transip.nl
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=transip-a; d=herrie.org; t=1780649242; h=from:subject:to:cc:date:
 mime-version; bh=GJoL9J8Cmxp8zQ9NtkYIs0OoW3AI1zMDhzVX0UjULXE=;
 b=g5+utD+GVTIw6dmfCEons6RvYdiwdjaGHc4LOzGc+VKWYX0cDTOZS465J+1iYZGSb1FO/F
 vi01KqpocQg8vB2IBEMvUjui6Bs/8lLc7c9UuTroyLLYW55X2qbxET1iGpF76R229lhuvV
 8H/MrXJ8IoWNsKpBtCj7eT+C1uHDtSLSE/fDPQRgF3e6UrIh1kyguzLJrERioY86kXFH/y
 HOxRjtG6b+kYac3TINtI5r/ytbcSNW5EiKACjWMo1GZeVW2lFbR8ztog9cnlCsmGCwPq5b
 vyXyNT9mSxggEart4+dIfGwEksAeaC1B0QR8lyNEKITs93X7T5wPcmHzp6GYUw==
X-Report-Abuse-To: abuse@transip.nl

mpu3050_runtime_resume() only calls mpu3050_power_up(), which clears
the SLEEP bit and waits 200 ms for the chip's register file to come
back. It does not reprogram the full-scale, low-pass filter or sample
rate divisor, all of which return to the chip's power-on defaults
across a power cycle.

The driver's cached state (mpu3050->fullscale, mpu3050->lpf,
mpu3050->divisor) is the source of truth for what userspace observes
through the IIO ABI: in_anglvel_sampling_frequency goes through
mpu3050_get_freq() which reads the cached lpf and divisor, and
in_anglvel_scale similarly reads cached fullscale. After the first
autosuspend cycle the chip's actual sample rate diverges from what
sysfs reports, until the next IIO_CHAN_INFO_RAW read incidentally
reprograms the chip via mpu3050_set_8khz_samplerate() and the cached
state restoration paths in mpu3050_fifo_read_one().

That incidental restoration is only triggered by direct sysfs raw
reads, not by buffered/triggered mode. A user who configures the
sample rate, starts buffered capture and then leaves the device idle
long enough to autosuspend will see chip-default-rate samples after
resume rather than the configured rate.

Reprogram the chip from the cached state in mpu3050_runtime_resume()
by calling mpu3050_start_sampling() after mpu3050_power_up() succeeds.
On failure power the chip back down to keep regulator and pm_runtime
reference counts in sync with the error path.

Fixes: 3904b28efb2c ("iio: gyro: Add driver for the MPU-3050 gyroscope")
Signed-off-by: Herman van Hazendonk <github.com@herrie.org>
---
 drivers/iio/gyro/mpu3050-core.c | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/gyro/mpu3050-core.c b/drivers/iio/gyro/mpu3050-core.c
index d84e04e4b431..ac041074cfdf 100644
--- a/drivers/iio/gyro/mpu3050-core.c
+++ b/drivers/iio/gyro/mpu3050-core.c
@@ -1291,7 +1291,32 @@ static int mpu3050_runtime_suspend(struct device *dev)
 
 static int mpu3050_runtime_resume(struct device *dev)
 {
-	return mpu3050_power_up(iio_priv(dev_get_drvdata(dev)));
+	struct mpu3050 *mpu3050 = iio_priv(dev_get_drvdata(dev));
+	int ret;
+
+	ret = mpu3050_power_up(mpu3050);
+	if (ret)
+		return ret;
+
+	/*
+	 * mpu3050_power_up() only clears the SLEEP bit; it leaves the
+	 * full-scale, low-pass filter and sample rate divisor at the
+	 * chip's power-on defaults. Restore them from the driver's
+	 * cached state so the hardware matches what userspace observes
+	 * via the IIO ABI (in_anglvel_sampling_frequency, in_anglvel_scale)
+	 * across a suspend/resume cycle. Without this the chip continues
+	 * to deliver samples at chip-default rate after the first
+	 * autosuspend cycle, until the next IIO_CHAN_INFO_RAW read
+	 * incidentally reprograms it.
+	 */
+	ret = mpu3050_start_sampling(mpu3050);
+	if (ret) {
+		dev_err(dev, "failed to restore sampling config on resume\n");
+		mpu3050_power_down(mpu3050);
+		return ret;
+	}
+
+	return 0;
 }
 
 DEFINE_RUNTIME_DEV_PM_OPS(mpu3050_dev_pm_ops, mpu3050_runtime_suspend,
-- 
2.43.0

