Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793117965;
	b=I7mtmKnBoSbndiNk+/fjtdYzmJTnHJecY5W1AakikawfLD6jb6yHvQJnGWDm+KilRnaR
	 xFHAWCQzu8wdOoee4MtTF30+Tt+nZoTFfyrABv96L7o7wVBcskrtbbSSc5j+vWxkgOoDW
	 RfPYBMuXTNVlpqmvSvFwKp7OqC78SCvgmsMlbNLuh/iSeuChPGY29NJAAKnSpNVfpUxsh
	 Yzq9B4ycpeREcZAsqXzWJQ0f7IObqqcF8K2bjByVTJptKnNu1Zy7wXkaqo/AGAkZQKLDv
	 bJ+UNe2kOdOFgOEIAnygbMMJ6RnjuSxQM85XDo1Cvxsh1ijIiWa7t3lOHLXRsOpCmOQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793117965;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=Yah5JjbfdtHZyEnbN7bigpDzRmkycWHPaQZuuBA9MFI=;
	b=fggLsvyDgGeASiZOkchDmZvkCJITFOJnsaoUomXq1WNQsY7i/ggQuX+rf3+ND7nTYnnG
	 9WnuuxDsHsdB9XPqt9AsxagJ356NSYmUeKIF2Zzluc/RF9RAolYw08EZAOyHAG+9jQa/u
	 Fot+4mwClI0xq48zC9gCsGqi/+hs4nVUTDRJvVevmPUAwMfBC6i343lYXDz8g/0kkdqzI
	 iLxfelGHW+DADHvh0r+fpkwvR5dBaBIXVPxvw1xFAyu1VorbJj7rqagRJgi+d8nWhRX3H
	 Ws7rEDsbatrX2Tr544wG11xvErMRWtP7yLydWiFTkFWJYDEfkFVWxhAyatHea/iPYcQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=E7NFbiFv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38B4360A2605;
	Tue, 27 Oct 2026 16:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=E7NFbiFv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42A1B1F01825;
	Tue, 27 Oct 2026 16:19:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793117964;
	bh=Yah5JjbfdtHZyEnbN7bigpDzRmkycWHPaQZuuBA9MFI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=E7NFbiFv0M+6/EX33HZWjyRRgwpDrnPi7ycte/CrJDrq8f7tRASZODPo494HLPX+t
	 bkVlPDrx+S7/34fxd5wWRlw/sYO9G7HOr0+bz2ZMQL25WSqbG3ww4KNEIgPIiP3Y1s
	 XSxrc1saWkjOVgdCWEGVCr6/pYml09BA/07b4esI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Tue, 27 Oct 2026 17:19:07 +0100
Subject: [PATCH 03/15] iio: accel: adxl367: don't stay in standby on
 -EINVAL
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261027-llm-char-misc-iio-v1-3-0d818334f6c7@linuxfoundation.org>
References: <20261027-llm-char-misc-iio-v1-0-0d818334f6c7@linuxfoundation.org>
In-Reply-To: <20261027-llm-char-misc-iio-v1-0-0d818334f6c7@linuxfoundation.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Josef Bacik <josef@toxicpanda.com>, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable <stable@kernel.org>, 
 Marcelo Schmitt <marcelo.schmitt@analog.com>, 
 Antoniu Miclaus <antoniu.miclaus@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, 
 Cosmin Tanislav <demonsingur@gmail.com>
X-Mailer: b4 0.17-dev-e5168
X-Developer-Signature: v=1; a=openpgp-sha256; l=2432;
 i=gregkh@linuxfoundation.org; h=from:subject:message-id;
 bh=TZ5IsBEaWTSt9ePiedqMKadmJsIwCy9FZldh8G8gNZU=;
 b=owGbwMvMwCRo6H6F97bub03G02pJDFkPzjN1nm1c+exwf4bdxY4TN0XSf+44kRqxMuzO2TSvQ
 pHOJevedMSyMAgyMciKKbJ82cZzdH/FIUUvQ9vTMHNYmUCGMHBxCsBEzq9lWHB0wfGww7tfm2xa
 wa2V9CvjtIsedy7DHN7WJQu/b5rx1p5rapygx4LJDtoyggA=
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp;
 fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29

From: Josef Bacik <josef@toxicpanda.com>

adxl367_set_act_threshold() puts the sensor into standby, writes the
threshold and switches the measurement on again.  A threshold above 8191 is
refused in between, and the sensor stays in standby: no samples and no
events until the next write that succeeds.

adxl367_set_range() has the same problem and a worse one.  It rescales both
thresholds for the new range, times four from 8 g to 2 g.  If one no longer
fits it returns -EINVAL with the sensor in standby, the new range in the
chip, the old one in st->range and rescaled thresholds in the driver's
state: from the next successful write on the samples are reported with the
wrong scale.

Switch the measurement on again if the threshold is refused.  In
adxl367_set_range() see whether the thresholds fit before anything is
changed.

Fixes: cbab791c5e2a ("iio: accel: add ADXL367 driver")
Cc: stable <stable@kernel.org>
Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>
Cc: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: "Nuno Sá" <nuno.sa@analog.com>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>
Cc: David Lechner <dlechner@baylibre.com>
Cc: Andy Shevchenko <andy@kernel.org>
Cc: Cosmin Tanislav <demonsingur@gmail.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/iio/accel/adxl367.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/accel/adxl367.c b/drivers/iio/accel/adxl367.c
index 026db73057c5..ba6e7423978f 100644
--- a/drivers/iio/accel/adxl367.c
+++ b/drivers/iio/accel/adxl367.c
@@ -349,8 +349,11 @@ static int adxl367_set_act_threshold(struct adxl367_state *st,
 		return ret;
 
 	ret = _adxl367_set_act_threshold(st, act, threshold);
-	if (ret)
+	if (ret) {
+		/* Leave standby also if the value was refused */
+		adxl367_set_measure_en(st, true);
 		return ret;
+	}
 
 	return adxl367_set_measure_en(st, true);
 }
@@ -483,6 +486,12 @@ static int adxl367_set_range(struct iio_dev *indio_dev,
 
 	guard(mutex)(&st->lock);
 
+	/* The thresholds are rescaled: see that they fit before any change */
+	if (max(st->act_threshold, st->inact_threshold) *
+	    adxl367_range_scale_factor_tbl[st->range] /
+	    adxl367_range_scale_factor_tbl[range] > ADXL367_THRESH_MAX)
+		return -EINVAL;
+
 	ret = adxl367_set_measure_en(st, false);
 	if (ret)
 		return ret;

-- 
2.56.0

