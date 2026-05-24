Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D46F391501;
	Sun, 24 May 2026 10:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779617842; cv=none; b=UyqCNlfSS4epc2y8dSCWEB2IdiBcFxsByEgNmDKwgEsrg388QR53ZRUw8OQeymahbRCp1WUlH+QLyqzM0++RtMrX2gAik+wkxgPSbaXOgPTls6qvXCuiQ+M5s73beCTIIVb7rVAEpvHyrlHN2Pwt7z3dftCK2zZqJvf1vlqflfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779617842; c=relaxed/simple;
	bh=XPXw8zIttn7JFd+/vY+mYscpcmOqgy7TIjHp+/T0vQM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ebKKiX3iHI7yMeYtoDrB8zw7lZodDpkQCmYdYYtwKYmzE33vu3Cf5fkDEnQJO21swAJa1wIwlhoYpwBYUnB8dKkn0IeTOVUs3jDl2+eBcalfydaAr8AgA29a3/wOXSrWR0gnRw3IGzZXbW75/aHI1r5xtkrXK5MkDtfOWwJthe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ssx2faML; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ssx2faML"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4A821C4AF0B;
	Sun, 24 May 2026 10:17:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779617842;
	bh=XPXw8zIttn7JFd+/vY+mYscpcmOqgy7TIjHp+/T0vQM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=ssx2faMLuhgXV6ZCsbMfneUucJYxBJGPrcxPWjR56Ds9wuyPvnHScNtuudvcqJ57T
	 yX5MTSya8Qrq8R19T/HgmyFweDELcPEXFoyk7AUavttGh+HW0DK576aDZtropAUL39
	 y9ohjBEtn7pr/pAwnx4VEmmEX9SzeUsgvyuTeJ0b5VH3bfZPNL2JstmvQw/n+u4scs
	 QY98fv9+vA4hhJbJ2F6r+OdNaLW9O1vLiMA3PdZ1rfKqcNMT6AoPKvEmaxEYnG0ydp
	 NIHrqXWeZztk5QjodOCWKYqNv0s9XVBN/j/W75bbffeQ2nE0wISlxYLXX0gKLgwKeM
	 0yHZTP+peM8TA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39DCFCD5BC6;
	Sun, 24 May 2026 10:17:22 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Sun, 24 May 2026 11:17:05 +0100
Subject: [PATCH v7 5/8] iio: dac: ad5686: add helpers to handle powerdown
 masks
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260524-ad5686-fixes-v7-5-b6bf395d08bd@analog.com>
References: <20260524-ad5686-fixes-v7-0-b6bf395d08bd@analog.com>
In-Reply-To: <20260524-ad5686-fixes-v7-0-b6bf395d08bd@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779617840; l=4923;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=9bkmUDhYDUWphVNh68Bpyk2wL74ckF0rKRjnwmXp+9s=;
 b=94aMV5EtBvCkBqI0H2aFi1zqvPJNTMnj7x3qAsZ6mzHJYl8x0sZrxTcZjZWIQlSEcBuxSZxCH
 KdoEe//vWwFBVbidS3DfMYEd6u6V32Pp22gWV/dJidW4AlwmjZA9sCZ
X-Developer-Key: i=rodrigo.alencar@analog.com; a=ed25519;
 pk=ULeHbgU/OYh/PG/4anHDfLgldFItQHAhOktYRVLMFRo=
X-Endpoint-Received: by B4 Relay for rodrigo.alencar@analog.com/default
 with auth_id=561
X-Original-From: Rodrigo Alencar <rodrigo.alencar@analog.com>
Reply-To: rodrigo.alencar@analog.com

From: Rodrigo Alencar <rodrigo.alencar@analog.com>

Add ad5686_pd_field_set() and ad5686_pd_field_get() helpers to cleanup
powerdown mask control. Define AD5686_PD_* constants, e.g. AD5686_PD_MSK
to hold powerdown mask value for a single channel. AD5686_LDAC_PWRDN_*
macros are replaced by AD5686_PD_MODE_*, because they are unused and the
LDAC feature for async load of DAC channel values is not related to power
down control.

Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
---
 drivers/iio/dac/ad5686.c | 40 ++++++++++++++++++++++++++--------------
 drivers/iio/dac/ad5686.h | 13 ++++++++-----
 2 files changed, 34 insertions(+), 19 deletions(-)

diff --git a/drivers/iio/dac/ad5686.c b/drivers/iio/dac/ad5686.c
index 50d4d5e8acf8..f024a7c05ddb 100644
--- a/drivers/iio/dac/ad5686.c
+++ b/drivers/iio/dac/ad5686.c
@@ -33,28 +33,40 @@ static inline unsigned int ad5686_pd_mask_shift(const struct iio_chan_spec *chan
 	return __ffs(chan->address) * 2;
 }
 
+static inline void ad5686_pd_field_set(const struct iio_chan_spec *chan,
+				       unsigned int *pd, unsigned int val)
+{
+	unsigned int shift = ad5686_pd_mask_shift(chan);
+
+	*pd = (*pd & ~(AD5686_PD_MSK << shift)) | ((val & AD5686_PD_MSK) << shift);
+}
+
+static inline unsigned int ad5686_pd_field_get(const struct iio_chan_spec *chan,
+					       unsigned int pd)
+{
+	unsigned int shift = ad5686_pd_mask_shift(chan);
+
+	return (pd >> shift) & AD5686_PD_MSK;
+}
+
 static int ad5686_get_powerdown_mode(struct iio_dev *indio_dev,
 				     const struct iio_chan_spec *chan)
 {
-	unsigned int shift = ad5686_pd_mask_shift(chan);
 	struct ad5686_state *st = iio_priv(indio_dev);
 
 	guard(mutex)(&st->lock);
 
-	return ((st->pwr_down_mode >> shift) & 0x3U) - 1;
+	return ad5686_pd_field_get(chan, st->pwr_down_mode) - 1;
 }
 
 static int ad5686_set_powerdown_mode(struct iio_dev *indio_dev,
 				     const struct iio_chan_spec *chan,
 				     unsigned int mode)
 {
-	unsigned int shift = ad5686_pd_mask_shift(chan);
 	struct ad5686_state *st = iio_priv(indio_dev);
 
 	guard(mutex)(&st->lock);
-
-	st->pwr_down_mode &= ~(0x3U << shift);
-	st->pwr_down_mode |= (mode + 1) << shift;
+	ad5686_pd_field_set(chan, &st->pwr_down_mode, mode + 1);
 
 	return 0;
 }
@@ -69,12 +81,12 @@ static const struct iio_enum ad5686_powerdown_mode_enum = {
 static ssize_t ad5686_read_dac_powerdown(struct iio_dev *indio_dev,
 		uintptr_t private, const struct iio_chan_spec *chan, char *buf)
 {
-	unsigned int shift = ad5686_pd_mask_shift(chan);
 	struct ad5686_state *st = iio_priv(indio_dev);
 
 	guard(mutex)(&st->lock);
 
-	return sysfs_emit(buf, "%d\n", !!(st->pwr_down_mask & (0x3U << shift)));
+	return sysfs_emit(buf, "%d\n",
+			  !!ad5686_pd_field_get(chan, st->pwr_down_mask));
 }
 
 static ssize_t ad5686_write_dac_powerdown(struct iio_dev *indio_dev,
@@ -96,9 +108,9 @@ static ssize_t ad5686_write_dac_powerdown(struct iio_dev *indio_dev,
 	guard(mutex)(&st->lock);
 
 	if (readin)
-		st->pwr_down_mask |= 0x3U << ad5686_pd_mask_shift(chan);
+		ad5686_pd_field_set(chan, &st->pwr_down_mask, AD5686_PD_MSK_PWR_DOWN);
 	else
-		st->pwr_down_mask &= ~(0x3U << ad5686_pd_mask_shift(chan));
+		ad5686_pd_field_set(chan, &st->pwr_down_mask, AD5686_PD_MSK_PWR_UP);
 
 	switch (st->chip_info->regmap_type) {
 	case AD5310_REGMAP:
@@ -471,10 +483,10 @@ int ad5686_probe(struct device *dev,
 
 	/* Set all the power down mode for all channels to 1K pulldown */
 	for (i = 0; i < st->chip_info->num_channels; i++) {
-		shift = ad5686_pd_mask_shift(&st->chip_info->channels[i]);
-		st->pwr_down_mask &= ~(0x3U << shift); /* powered up state */
-		st->pwr_down_mode &= ~(0x3U << shift);
-		st->pwr_down_mode |= 0x01U << shift;
+		ad5686_pd_field_set(&st->chip_info->channels[i],
+				    &st->pwr_down_mask, AD5686_PD_MSK_PWR_UP);
+		ad5686_pd_field_set(&st->chip_info->channels[i],
+				    &st->pwr_down_mode, AD5686_PD_MODE_1K_TO_GND);
 	}
 
 	indio_dev->name = name;
diff --git a/drivers/iio/dac/ad5686.h b/drivers/iio/dac/ad5686.h
index caadc7403da1..176d41966985 100644
--- a/drivers/iio/dac/ad5686.h
+++ b/drivers/iio/dac/ad5686.h
@@ -35,11 +35,6 @@
 #define AD5686_CMD_DAISY_CHAIN_ENABLE		0x8
 #define AD5686_CMD_READBACK_ENABLE		0x9
 
-#define AD5686_LDAC_PWRDN_NONE			0x0
-#define AD5686_LDAC_PWRDN_1K			0x1
-#define AD5686_LDAC_PWRDN_100K			0x2
-#define AD5686_LDAC_PWRDN_3STATE		0x3
-
 #define AD5686_CMD_CONTROL_REG			0x4
 #define AD5686_CMD_READBACK_ENABLE_V2		0x5
 
@@ -47,6 +42,14 @@
 #define AD5683_REF_BIT_MSK			BIT(12)
 #define AD5686_REF_BIT_MSK			BIT(0)
 
+#define AD5686_PD_MSK				GENMASK(1, 0)
+
+#define AD5686_PD_MODE_1K_TO_GND		0x1
+#define AD5686_PD_MODE_100K_TO_GND		0x2
+#define AD5686_PD_MODE_THREE_STATE		0x3
+
+#define AD5686_PD_MSK_PWR_UP			0x0
+#define AD5686_PD_MSK_PWR_DOWN			0x3
 
 enum ad5686_regmap_type {
 	AD5310_REGMAP,

-- 
2.43.0


