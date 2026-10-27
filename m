Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793117969;
	b=WdrojlK7iDeIjWtH1ZiTFJoQcV+NKq5Yfey+HAVy1TWVfDvBDzWjBqTYDH6ni/sxaYEB
	 3mapC/g8i65QgUcvGF3aF+M0q8L2AIDtjberfTGy4Qz61zAb/1mcLtjGLJUxzz0oZ8fgj
	 STiGBcOYypYUvAMwQQhun9ThMjTKtDJradUVOeiZV9UDKpF6+862GszpQOb4QH+Az48Bk
	 PqhUtJ8zI/Es3GWMZSEwr/bZ51DFMG+xns/+S2CdVrxXpP6HOJQDe05CghcmatAdOurOj
	 U1roaYt/MWIT5sYDPJ3a8fYSOEFt9/Vb3usIKKsasVZW28Q1KP/CHSzA2u6M2mvcgTg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793117969;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=x3KUzhQz6+4DPJOkUGvWeoYPemZAUp92OI03uEKWCV0=;
	b=b3iteQjMKL56JY4Qnn1UrCkE/TmMP3r8cJm4BbDGQXNSWPRKsSwMylOhwFe02E2yO1yW
	 7EBx4DVQl8fPzi84+b9413Tbvkgi7i9ha5qKqW9J4b3b2n5CJtqMuGheBiEZU15gE6c50
	 HV+PxsNtkq/XUt8JK/jq3db0NDS6sX/EAayH9whFe851hwmpJuRvsWnIKrg+SfcVAjS6T
	 iMUK/xYDIxEY3WPSOxExma81F+daqw1SXqv8Crhz7ynATFkZ2KZEGWJ0B7iaMyer0ZrMV
	 yxMyDd78lelWk9nxIqNQrCSu8dxw2ypNyWZUz9HI3rmkpMddgnV1g64Dqs/D+Au3Zpg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=nikSyQlv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC8D3606A33A;
	Tue, 27 Oct 2026 16:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=nikSyQlv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEA461F01828;
	Tue, 27 Oct 2026 16:19:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793117968;
	bh=x3KUzhQz6+4DPJOkUGvWeoYPemZAUp92OI03uEKWCV0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=nikSyQlvAigLWakWkgeQn033oYYOV1oZPi6Mua/RIdv01NfO7i4AvaceCAvSGjsr1
	 66NuyC/9AsxQvQpGQ/7zQ17pI3PYP5fckBeDL6MVicsl0msJB0MDfL3aMbPHKJUSxm
	 gl1uoMP/brkhctwp6yqyqcrdlIx4o+dIXe59qp2g=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Tue, 27 Oct 2026 17:19:08 +0100
Subject: [PATCH 04/15] iio: accel: adxl380: don't stay in standby on
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
Message-Id: <20261027-llm-char-misc-iio-v1-4-0d818334f6c7@linuxfoundation.org>
References: <20261027-llm-char-misc-iio-v1-0-0d818334f6c7@linuxfoundation.org>
In-Reply-To: <20261027-llm-char-misc-iio-v1-0-0d818334f6c7@linuxfoundation.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Josef Bacik <josef@toxicpanda.com>, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable <stable@kernel.org>, 
 Ramona Gradinariu <ramona.gradinariu@analog.com>, 
 Antoniu Miclaus <antoniu.miclaus@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>
X-Mailer: b4 0.17-dev-e5168
X-Developer-Signature: v=1; a=openpgp-sha256; l=2399;
 i=gregkh@linuxfoundation.org; h=from:subject:message-id;
 bh=rQ2GbiOQ7qewAYozocsqbgW0DvfWIjr7lyEgbBUgfuk=;
 b=owGbwMvMwCRo6H6F97bub03G02pJDFkPzjM9W3rh8NwW9y1C05oOXfvYdX7NzKvrQuY6T99xv
 Gj9xj0sSztiWRgEmRhkxRRZvmzjObq/4pCil6HtaZg5rEwgQxi4OAVgIqKSDAvWTM29LPh1zYqp
 5vs9k2Yxvqqbn76JYX7GqRWNPlsf3Q0ozYiz5cjYWRoZXgIA
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp;
 fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29

From: Josef Bacik <josef@toxicpanda.com>

adxl380_set_act_inact_threshold() puts the sensor into standby, writes the
threshold and switches the measurement on again.  A threshold above 8191 is
refused in between, and the sensor stays in standby: no samples and no
events until the next write that succeeds.

adxl380_set_range() has the same problem and a worse one.  It rescales both
thresholds for the new range.  If one no longer fits it returns -EINVAL
with the sensor in standby, the new range in the chip, the old one in
st->range and rescaled thresholds in the driver's state: from the next
successful write on the samples are reported with the wrong scale.

Switch the measurement on again if the threshold is refused.  In
adxl380_set_range() see whether the thresholds fit before anything is
changed.

Fixes: df36de13677a ("iio: accel: add ADXL380 driver")
Cc: stable <stable@kernel.org>
Cc: Ramona Gradinariu <ramona.gradinariu@analog.com>
Cc: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: "Nuno Sá" <nuno.sa@analog.com>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>
Cc: David Lechner <dlechner@baylibre.com>
Cc: Andy Shevchenko <andy@kernel.org>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/iio/accel/adxl380.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/accel/adxl380.c b/drivers/iio/accel/adxl380.c
index 8518ee23e114..03b140303520 100644
--- a/drivers/iio/accel/adxl380.c
+++ b/drivers/iio/accel/adxl380.c
@@ -334,8 +334,11 @@ static int adxl380_set_act_inact_threshold(struct iio_dev *indio_dev,
 		return ret;
 
 	ret = adxl380_write_act_inact_threshold(st, act, th);
-	if (ret)
+	if (ret) {
+		/* Leave standby also if the value was refused */
+		adxl380_set_measure_en(st, true);
 		return ret;
+	}
 
 	return adxl380_set_measure_en(st, true);
 }
@@ -698,6 +701,12 @@ static int adxl380_set_range(struct adxl380_state *st, u8 range)
 
 	guard(mutex)(&st->lock);
 
+	/* The thresholds are rescaled: see that they fit before any change */
+	if (mult_frac(max(st->act_threshold, st->inact_threshold),
+		      adxl380_range_scale_factor_tbl[st->range],
+		      adxl380_range_scale_factor_tbl[range]) > ADXL380_THRESH_MAX)
+		return -EINVAL;
+
 	ret = adxl380_set_measure_en(st, false);
 	if (ret)
 		return ret;

-- 
2.56.0

