Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56F403CB56D
	for <linux-iio@vger.kernel.org>; Fri, 28 Aug 2026 06:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787899135; cv=none; b=nxBCppBFzIU+HixINnwKG1thFNfVxBwI1OgkpzRuVN6JXLCFb+CSertaj1Q1a0PlsyfWgddDGWOacu3EB0T0V1cH4S5KlvJ9NyBqr45iatk1NBxyQlCZhmjwUWTe1pdQ3T+qA0dIJgOaU3dAkB3ioc82iTSITFX3kDMi12F/7Ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787899135; c=relaxed/simple;
	bh=jBnuNfFaNy+lYevkOT79mOgADpfoXMW0c9FuXIA5WWY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=g/3sr6EJjrrjl3tiUBvES70VstYfJ3WOiiXCKWxLQHC5slRoaJElwINniT3yk0HSvHzmN6SgZ2lEVWxd6PMMOMZ8S1DttLG/2i7Bu0BRFzO0mKd9HDoeCboujnQ+HYMv4aQnv1OZBSlwWpb3RqKzxNh+Sik9WwWp6wDpFZpxUtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G5miVteJ; arc=none smtp.client-ip=209.85.217.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G5miVteJ"
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-783047c8464so418656137.0
        for <linux-iio@vger.kernel.org>; Thu, 27 Aug 2026 23:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787899131; x=1788503931; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hcOlTatZtiMtegG+sIDHWIx8wVSL0Q7Xb7hEFQvq7zQ=;
        b=G5miVteJq064cTyZyjT0ACmOINFtxxWOrOPD8enRbI/Oly1Id0MZSKc9YHys0OR1Dg
         QQe95gpoTfCtfdOdSRsFY/xzO3Msk9S5ATNbs08ZN24lTVz9xPcjHFoZLhWfRSZsSVC7
         xX+QR1TlrQIPXAbS/9nXaVpkqX2y0OuOrSCovOLGTri6SLpT3zPpqs52+SPuQn80YMF0
         OX4OAEcaH8xKAolyll+jIoK/iNcglL5MFhWezkrneoJlYQe4JLQV3+XyNnHGjHeJ1gYt
         dEzQ32i9In3GTU91f6tHRTA7HdAHQHHJTwrMYUMcheWACshlF+2QLQOLBxbu5yUyg3zu
         FX5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787899131; x=1788503931;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hcOlTatZtiMtegG+sIDHWIx8wVSL0Q7Xb7hEFQvq7zQ=;
        b=M2laHbThbr0RfphI/jjlUQPXOyIRs8x/nWx5ytAdHefid/AuRyQO+Bwgmkk6mXu/5i
         pYRWb8bXStEsmtxkgVCTpO/qt7RXxYG758nnluU//fiSrXEdd4yP1Fy+MAuhP0YJ8BP3
         VYTGLYDCho0u5Sp0VHIghyyDCq6WN08eZQu3KO3jG8rsg3itFgkryckv13++1uxATjBm
         96qw+E+Rl0RStL4QcO9O4zBdNE5/wcsp6T5G2HFTshlnPPZYRNnRd4O3EKf7nCHC3Twy
         OJStc4+IWVti6oCrbEc3Tm4V7JSgRKh3H3ygP1ZA5CTD19LElxhvRoYjWzvT2Pvkdye+
         Y3Uw==
X-Forwarded-Encrypted: i=1; AHgh+RrBcV8k61P/ciSCSnUVZhoy3NuEwNtHfAczJj8uBwjkRczF6mBWv54hJo8LBvDvpqiHA1by0Y1KZ1g=@vger.kernel.org
X-Gm-Message-State: AFuF++k5AYdYhG10LdQRPjVgsYB1XuUSuiaSljNfAq7ddMvqYkWkoaEz
	+8Mka04I7QkgckXI6j0xB1bjish4v1oRzXiuVJHaR6zY7XiPF8kzqIbP
X-Gm-Gg: AR+sD11273qK6nvTdbDQeA3hqX3xxh1+dNdja57OdxC+u5DLaWQmRTXW8zgRdb1etDc
	HHjyu5ciQa3HhjIeLFAo61MeBo1/SQ7F1+k2ojxOtcceh3OUYSwBW7LgbQ7S82Y0fTpMNc7yRT3
	JgVs5AlIKHudI2OTOimLW3lD2svuudQ0aD0olPzKLsO16rNwwDPyLVY5kOtuQgYJxwvAI0UCFyK
	HZLj6r0Q6RSTnVK0OD8ogwBUOxdeQPSFqWmARBQhMdD1kRFskcUPzy1sTZEYN1Gp5I9Zhyksh71
	3qPC9g98HCuFsfHIh8Bsp7WvzKwJs8MlzDacV31oEU90Eh3Rj6ytCPw4y3DTPQXFbKoUS45/7V8
	v6rgQQK562po44d2MtJ7GvpoWCg2NcEyLuq6I4jh/IGLskOFqxteapfsX6ucPQeFooYplYQ3nKe
	usKiJNJgR6fz86HYW4d0PWC7t8/xdYtMaWzFfBusS5xymHewwd1ga9lywBO8IP428w
X-Received: by 2002:a05:6102:3e83:b0:779:c38e:de53 with SMTP id ada2fe7eead31-7859956a1cdmr1778891137.10.1787899131018;
        Thu, 27 Aug 2026 23:38:51 -0700 (PDT)
Received: from [192.168.100.153] ([2800:bf0:61:1127:ab87:5602:531c:8dfb])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-97e849d8494sm454195241.1.2026.08.27.23.38.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 23:38:50 -0700 (PDT)
From: Kurt Borja <kuurtb@gmail.com>
Date: Fri, 28 Aug 2026 01:38:21 -0500
Subject: [PATCH v4 06/10] iio: adc: ti-ads1262: support input chopping
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260828-ads126x-v4-6-1dc27e9c0260@gmail.com>
References: <20260828-ads126x-v4-0-1dc27e9c0260@gmail.com>
In-Reply-To: <20260828-ads126x-v4-0-1dc27e9c0260@gmail.com>
To: Kurt Borja <kuurtb@gmail.com>, Jonathan Cameron <jic23@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, David Lechner <dlechner@baylibre.com>
Cc: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3240; i=kuurtb@gmail.com;
 h=from:subject:message-id; bh=jBnuNfFaNy+lYevkOT79mOgADpfoXMW0c9FuXIA5WWY=;
 b=owGbwMvMwCUmluBs8WX+lTTG02pJDFkTdd6031zRuqLFyVz66v4vesfMzvmHhlYFRc2PkQ7Ly
 pryj/l4RykLgxgXg6yYIkt7wqJvj6Ly3vodCL0PM4eVCWQIAxenAExk5SuGf7YGAqskZljs+Kzg
 ZNu/78XZ7yuez/ivru6knPoiZ8Nv7xRGhi4NvWU2zmWppzu/WkibqggtfcjgG7Ca90oxe9FJQ6N
 8LgA=
X-Developer-Key: i=kuurtb@gmail.com; a=openpgp;
 fpr=54D3BE170AEF777983C3C63B57E3B6585920A69A

Enable per-channel input chopping via the "input-chopping" property.
As the device withholds the first conversion in chop mode, single reads
are taken in CONTINUOUS run mode with a brief start/stop pulse, as
recommended by the datasheet (Section 9.4.1.2).

Reviewed-by: David Lechner <dlechner@baylibre.com>
Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
 drivers/iio/adc/ti-ads1262.c | 25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/ti-ads1262.c b/drivers/iio/adc/ti-ads1262.c
index c87c0a66119a..4d38da092001 100644
--- a/drivers/iio/adc/ti-ads1262.c
+++ b/drivers/iio/adc/ti-ads1262.c
@@ -203,6 +203,7 @@ struct ads1262_channel {
 	u8 ref_n;
 	bool ref_reversal;
 	bool is_resistance;
+	bool input_chop;
 	size_t num_scales;
 	int scales[ADS1262_GAIN_COUNT][2];
 };
@@ -464,7 +465,7 @@ static int ads1262_dev_stop(struct ads1262 *st)
 	return ret;
 }
 
-static int ads1262_dev_start_one(struct ads1262 *st)
+static int ads1262_dev_start_one(struct ads1262 *st, u8 runmode)
 {
 	int ret;
 
@@ -472,7 +473,7 @@ static int ads1262_dev_start_one(struct ads1262 *st)
 	if (ret)
 		return ret;
 
-	if (st->start_gpiod) {
+	if (runmode == ADS1262_RUNMODE_CONTINUOUS || st->start_gpiod) {
 		/*
 		 * The START pulse timing requirement is 4 clock cycles, at the
 		 * minimum clock rate this is 4 microseconds.
@@ -520,7 +521,9 @@ static int ads1262_channel_enable(struct ads1262 *st,
 	guard(mutex)(&st->chan_lock);
 
 	ret = regmap_update_bits(st->regmap, ADS1262_MODE0_REG,
+				 ADS1262_MODE0_INPUT_CHOP_MASK |
 				 ADS1262_MODE0_REFREV_MASK,
+				 FIELD_PREP(ADS1262_MODE0_INPUT_CHOP_MASK, chan->input_chop) |
 				 FIELD_PREP(ADS1262_MODE0_REFREV_MASK, chan->ref_reversal));
 	if (ret)
 		return ret;
@@ -561,13 +564,26 @@ static int ads1262_channel_read(struct iio_dev *indio_dev,
 				const struct iio_chan_spec *spec, __be32 *val)
 {
 	struct ads1262 *st = iio_priv(indio_dev);
+	struct ads1262_channel *chan = &st->channels[spec->scan_index];
+	u8 runmode;
 	int ret;
 
 	IIO_DEV_ACQUIRE_DIRECT_MODE(indio_dev, claim);
 	if (IIO_DEV_ACQUIRE_FAILED(claim))
 		return -EBUSY;
 
-	ret = ads1262_set_runmode(st, ADS1262_RUNMODE_PULSE);
+	/*
+	 * When a channel has chop mode or IDAC rotation mode, the first
+	 * conversion is always withheld so the datasheet suggests using the
+	 * CONTINUOUS mode and briefly starting and stopping conversions to
+	 * achieve the same effect (Section 9.4.1.2).
+	 */
+	if (chan->input_chop)
+		runmode = ADS1262_RUNMODE_CONTINUOUS;
+	else
+		runmode = ADS1262_RUNMODE_PULSE;
+
+	ret = ads1262_set_runmode(st, runmode);
 	if (ret)
 		return ret;
 
@@ -577,7 +593,7 @@ static int ads1262_channel_read(struct iio_dev *indio_dev,
 
 	reinit_completion(&st->drdy);
 
-	ret = ads1262_dev_start_one(st);
+	ret = ads1262_dev_start_one(st, runmode);
 	if (ret)
 		return ret;
 
@@ -1340,6 +1356,7 @@ static int ads1262_parse_channel_node(struct ads1262 *st,
 		}
 	}
 
+	chan->input_chop = fwnode_property_read_bool(node, "input-chopping");
 	chan->ref_reversal = fwnode_property_read_bool(node, "ti,reference-reversal");
 
 	return 0;

-- 
2.55.0

